Return-Path: <netdev+bounces-46022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04EC7E0EF2
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 12:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EE828172D
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573313FEF;
	Sat,  4 Nov 2023 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGCSOTor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FD11C9F
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 11:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D4FC433C7;
	Sat,  4 Nov 2023 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699096452;
	bh=l3wFpZyX/13lGer+hOoC13euBfLCdUPhXg8d5zCHXh4=;
	h=From:To:Cc:Subject:Date:From;
	b=OGCSOTorzlBqamG3EKDHzhV/KLIlzoN1oL2yOp6aL1Alwf1w5nizE0/Z8KsfBgk5G
	 NCoXwiKkhPVndZcNrh22RmHynCg8ThtUFsDDGIeFKkJCgKCwjyLHidUv/+6hN+m7+i
	 2irp5deFpMGjEXftWxnvnHy1yftW1EiI0ZT32QBnXl/UOXJ1qAl2sI7wXzC7w6mGUf
	 F1+2QioiFY3D+38WlKqkMaFtOYMloDF8IG2+DGk/DF3UuAVo1+x0zerLVpPDCORszA
	 m45IeztwioEuxa5GMYk97Zx1Dp3/HkuyGHbxwqbnkXqwp/cU1nO+krbA3QOviYifxL
	 teXOGSIU6ggRg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	neilb@suse.de,
	chuck.lever@oracle.com,
	netdev@vger.kernel.org,
	jlayton@kernel.org,
	kuba@kernel.org
Subject: [PATCH v4 0/3] convert write_threads, write_version and write_ports to netlink commands
Date: Sat,  4 Nov 2023 12:13:44 +0100
Message-ID: <cover.1699095665.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce write_threads, write_version and write_ports netlink
commands similar to the ones available through the procfs.

Changes since v3:
- drop write_maxconn and write_maxblksize for the moment
- add write_version and write_ports commands
Changes since v2:
- use u32 to store nthreads in nfsd_nl_threads_set_doit
- rename server-attr in control-plane in nfsd.yaml specs
Changes since v1:
- remove write_v4_end_grace command
- add write_maxblksize and write_maxconn netlink commands

This patch can be tested with user-space tool reported below:
https://github.com/LorenzoBianconi/nfsd-netlink.git
This series is based on the commit below available in net-next tree

commit e0fadcffdd172d3a762cb3d0e2e185b8198532d9
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Oct 6 06:50:32 2023 -0700

    tools: ynl-gen: handle do ops with no input attrs

    The code supports dumps with no input attributes currently
    thru a combination of special-casing and luck.
    Clean up the handling of ops with no inputs. Create empty
    Structs, and skip printing of empty types.
    This makes dos with no inputs work.

Lorenzo Bianconi (3):
  NFSD: convert write_threads to netlink commands
  NFSD: convert write_version to netlink commands
  NFSD: convert write_ports to netlink commands

 Documentation/netlink/specs/nfsd.yaml |  83 ++++++++
 fs/nfsd/netlink.c                     |  54 ++++++
 fs/nfsd/netlink.h                     |   8 +
 fs/nfsd/nfsctl.c                      | 267 +++++++++++++++++++++++++-
 include/uapi/linux/nfsd_netlink.h     |  30 +++
 tools/net/ynl/generated/nfsd-user.c   | 254 ++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   | 156 +++++++++++++++
 7 files changed, 845 insertions(+), 7 deletions(-)

-- 
2.41.0


