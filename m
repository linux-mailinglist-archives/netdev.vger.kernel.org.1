Return-Path: <netdev+bounces-32815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED7D79A804
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116E728108D
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A1C8DB;
	Mon, 11 Sep 2023 12:50:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24F3D65
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 12:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39166C433C8;
	Mon, 11 Sep 2023 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694436609;
	bh=tHzf9IpTRRObT2Wt3tnU7xQFrfxfs3mf7RJ8SD6UTgk=;
	h=From:To:Cc:Subject:Date:From;
	b=giXe9f9PkYJf6xsj7SqiplLBd9eSD1v1yjrk9YCiV93a/XC0+Vvo+gfcvRTiaoU48
	 AzoCqKhcLJ+1CK7wKweXDpCjKyP4DAOmMyZmasWKdmRKwOOgcDf8ohsGGMuyjT0n45
	 odqgjihH6iO02MrjqyhfbRm5ybcCZ5L4PqkFCMGvrprboc6Wf1z7kY8VoWKexo5/E+
	 aqJxjF4fCGfOG2f9b4NlAyK+VA4H1N3j4+TygbmA0/O3sqLSggw3rOGqwzpnQFROnT
	 AD8R9qw+Aum1gvwe1ym6vzvVH3hqhY64Rny51xFwJleurhhYIqjNe9Qq/UIrTbLDew
	 4YFIFQKy+s5xA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	netdev@vger.kernel.org
Subject: [PATCH v8 0/3] add rpc_status netlink support for NFSD
Date: Mon, 11 Sep 2023 14:49:43 +0200
Message-ID: <cover.1694436263.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce rpc_status netlink support for NFSD in order to dump pending
RPC requests debugging information from userspace.
The new code can be tested with the user-space tool reported below:
https://github.com/LorenzoBianconi/nfsd-rpc-netlink-monitor/tree/main

Changes since v7:
- introduce nfsd_server.yaml for netlink messages

Changes since v6:
- report info to user-space through netlink and get rid of the related
  entry in the procfs

Changes since v5:
- add missing delimiters for nfs4 compound ops
- add a header line for rpc_status handler
- do not dump rq_prog
- do not dump rq_flags in hex

Changes since v4:
- rely on acquire/release APIs and get rid of atomic operation
- fix kdoc for nfsd_rpc_status_open
- get rid of ',' as field delimiter in nfsd_rpc_status hanlder
- move nfsd_rpc_status before nfsd_v4 enum entries
- fix compilantion error if nfsdv4 is not enabled

Changes since v3:
- introduce rq_status_counter in order to detect if the RPC request is
  pending and RPC info are stable
- rely on __svc_print_addr to dump IP info

Changes since v2:
- minor changes in nfsd_rpc_status_show output

Changes since v1:
- rework nfsd_rpc_status_show output

Changes since RFCv1:
- riduce time holding nfsd_mutex bumping svc_serv refcoung in
  nfsd_rpc_status_open()
- dump rqstp->rq_stime
- add missing kdoc for nfsd_rpc_status_open()

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D3D3D366

Lorenzo Bianconi (3):
  Documentation: netlink: add a YAML spec for nfsd_server
  NFSD: introduce netlink rpc_status stubs
  NFSD: add rpc_status netlink support

 Documentation/netlink/specs/nfsd_server.yaml |  97 +++++++++
 fs/nfsd/Makefile                             |   3 +-
 fs/nfsd/nfs_netlink_gen.c                    |  32 +++
 fs/nfsd/nfs_netlink_gen.h                    |  22 ++
 fs/nfsd/nfsctl.c                             | 204 +++++++++++++++++++
 fs/nfsd/nfsd.h                               |  16 ++
 fs/nfsd/nfssvc.c                             |  15 ++
 fs/nfsd/state.h                              |   2 -
 include/linux/sunrpc/svc.h                   |   1 +
 include/uapi/linux/nfsd_server.h             |  49 +++++
 10 files changed, 438 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/netlink/specs/nfsd_server.yaml
 create mode 100644 fs/nfsd/nfs_netlink_gen.c
 create mode 100644 fs/nfsd/nfs_netlink_gen.h
 create mode 100644 include/uapi/linux/nfsd_server.h

-- 
2.41.0


