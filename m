Return-Path: <netdev+bounces-141696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2CF9BC0D4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CDA280F68
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085FF1FDF93;
	Mon,  4 Nov 2024 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQsSAVr+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C91FCC6B;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759116; cv=none; b=l3DJgCgbE/nxrafHKFTnmOYrRfpTXegXK7ypRlewMdl9x34UE2MvyFiiaq/Vt8BTPTtIBRpujBv3wmnP1NspOKhTzRuItwVRDOjnySEHfp/mBt7C21hkbhQ5B87j0M2xNjZBPWE1Prl54qZTAXdZj7o8sV4dlP9kkAvfp9HnL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759116; c=relaxed/simple;
	bh=IQDWNN9AzscOd/onsKj9XQgejdQOpQ2hRjYTq++U6Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MjWKbv+fbhuutBfLuSO1iU4pmSDx9OBHG8VRoluY+odXPA9NnB6J/PSJKx3/yg38KnOYklVXjmTsAIBlbSEroDaxdVyPGhNWCk1hYgMy9AnXFrWw1ulJQZu54PzKe7VPxL6sDqNfqxnpVSn44fx77yxe3hctTrkc7pVmbshQ0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQsSAVr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7E0C4CED1;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730759116;
	bh=IQDWNN9AzscOd/onsKj9XQgejdQOpQ2hRjYTq++U6Ys=;
	h=From:To:Cc:Subject:Date:From;
	b=CQsSAVr+eRCjiKaz3rfTz/05RVTgOf4KlVnvd/7UQ4jSuCqB5p/I5HW7BaRqk/Lo0
	 Y/K7zsW07n3Rlgu88P/hqWufPVhhy9D47N/WbvBSI/Ytuh2jxeOzg9mtRcY5ErxgCw
	 i6hXNLQ1Rle/Lj8b9mOTQ6ilmbZo1IcpA9rzoAGoi02te5Fm6NNooC4mVyl85WUU+Z
	 w1+SyglKXb5tRgjyjINkWCKpvxl4rx1KMihjgyOkp/W4E2s089QRhn64zD2NMLHBfT
	 ZIQqYgSmXCHGAo0hiGgmOGm7DGVKmuUwkmisxkn4ZkRVv0H5wPqCeQFcblfBS1HuJQ
	 DgAFKjpXBzSxw==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RFC 0/5] sockaddr usage removal
Date: Mon,  4 Nov 2024 14:25:02 -0800
Message-Id: <20241104221450.work.053-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5838; i=kees@kernel.org; h=from:subject:message-id; bh=IQDWNN9AzscOd/onsKj9XQgejdQOpQ2hRjYTq++U6Ys=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmange5zdILLoUGrcm8n3iV7e6vgFsrrHtSnt5fWjch3 13g0d5dHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOx/cXw3/nflfA9t42una3l rXqjxzTn1B7jdEEjy80rXn65oSTpeoOR4W/MU7lv1440ta+zyL6fPW3V/M8yCSqFoROjHude+Th jMgcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

(I removed the explicit CC list because it was huge...)

Hi,

This is strictly an RFC -- it's not a complete removal of sockaddr at
all, but it explores what's involved. Some things are easy (e.g. the
first 3 patches), and some is very involved (last patch).

For the most part, the proto_ops::getname() switching from sockaddr
to sockaddr_storage is mostly mechanical (and mostly just removes
sockaddr casts). There are, however, cases where we still end up lying
to the compiler about object sizes (in the case where the backing
object is smaller than sockaddr_storage, but large enough to hold the
protocol-specific address). These remain just as safe as they used to
be. :)

I think for getname() (and similar interfaces) we *do* want to use
sockaddr_storage, but there is kind of an argument to instead use
a struct with a flexible array, e.g.:

struct sockaddr_unspec {
        sa_family_t	sa_family;
	char		sa_data[];
};

If this was done, then all these APIs would switch their casts from
"(struct sockaddr *)" to "(struct sockaddr_unspec *)", even though in
most cases the object is actully a struct sockaddr_storage.

What do folks think?

-Kees


Kees Cook (5):
  Revert "net: dev: Convert sa_data to flexible array in struct
    sockaddr"
  net: core: dev.c confirmed to use classic sockaddr
  rtnetlink: do_setlink: Use sockaddr_storage
  net: core: Convert inet_addr_is_any() to sockaddr_storage
  net: Convert proto_ops::getname to sockaddr_storage

 drivers/infiniband/hw/erdma/erdma_cm.h        |  4 +-
 drivers/infiniband/hw/usnic/usnic_transport.c | 16 +++---
 drivers/infiniband/sw/siw/siw_cm.h            |  4 +-
 drivers/isdn/mISDN/socket.c                   |  2 +-
 drivers/net/ppp/pppoe.c                       |  2 +-
 drivers/net/ppp/pptp.c                        |  2 +-
 drivers/nvme/host/tcp.c                       |  2 +-
 drivers/nvme/target/rdma.c                    |  2 +-
 drivers/nvme/target/tcp.c                     |  8 ++-
 drivers/scsi/iscsi_tcp.c                      | 18 +++----
 drivers/soc/qcom/qmi_interface.c              |  2 +-
 drivers/target/iscsi/iscsi_target.c           |  2 +-
 drivers/target/iscsi/iscsi_target_login.c     | 51 +++++++++----------
 fs/dlm/lowcomms.c                             |  2 +-
 fs/nfs/nfs4client.c                           |  4 +-
 fs/ocfs2/cluster/tcp.c                        | 25 +++++----
 fs/smb/server/connection.h                    |  2 +-
 fs/smb/server/mgmt/tree_connect.c             |  2 +-
 fs/smb/server/transport_ipc.c                 |  4 +-
 fs/smb/server/transport_ipc.h                 |  4 +-
 fs/smb/server/transport_tcp.c                 |  6 +--
 include/linux/inet.h                          |  2 +-
 include/linux/net.h                           |  6 +--
 include/linux/socket.h                        |  5 +-
 include/linux/sunrpc/clnt.h                   |  2 +-
 include/net/inet_common.h                     |  2 +-
 include/net/ipv6.h                            |  2 +-
 include/net/sock.h                            |  2 +-
 net/appletalk/ddp.c                           |  2 +-
 net/atm/pvc.c                                 |  2 +-
 net/atm/svc.c                                 |  2 +-
 net/ax25/af_ax25.c                            |  2 +-
 net/bluetooth/hci_sock.c                      |  2 +-
 net/bluetooth/iso.c                           |  6 +--
 net/bluetooth/l2cap_sock.c                    |  6 +--
 net/bluetooth/rfcomm/sock.c                   |  3 +-
 net/bluetooth/sco.c                           |  6 +--
 net/can/isotp.c                               |  3 +-
 net/can/j1939/socket.c                        |  2 +-
 net/can/raw.c                                 |  2 +-
 net/core/dev.c                                |  7 ++-
 net/core/dev_ioctl.c                          |  2 +-
 net/core/rtnetlink.c                          | 12 ++---
 net/core/sock.c                               |  4 +-
 net/core/utils.c                              |  8 +--
 net/ipv4/af_inet.c                            |  2 +-
 net/ipv4/arp.c                                |  2 +-
 net/ipv6/af_inet6.c                           |  2 +-
 net/iucv/af_iucv.c                            |  6 +--
 net/l2tp/l2tp_ip.c                            |  2 +-
 net/l2tp/l2tp_ip6.c                           |  2 +-
 net/l2tp/l2tp_ppp.c                           |  2 +-
 net/llc/af_llc.c                              |  2 +-
 net/netlink/af_netlink.c                      |  4 +-
 net/netrom/af_netrom.c                        |  2 +-
 net/nfc/llcp_sock.c                           |  4 +-
 net/packet/af_packet.c                        | 21 ++++----
 net/phonet/socket.c                           | 10 ++--
 net/qrtr/af_qrtr.c                            |  2 +-
 net/qrtr/ns.c                                 |  2 +-
 net/rds/af_rds.c                              |  2 +-
 net/rose/af_rose.c                            |  2 +-
 net/sctp/ipv6.c                               |  2 +-
 net/smc/af_smc.c                              |  2 +-
 net/smc/smc.h                                 |  2 +-
 net/smc/smc_clc.c                             |  2 +-
 net/socket.c                                  | 10 ++--
 net/sunrpc/clnt.c                             |  9 ++--
 net/sunrpc/svcsock.c                          |  8 +--
 net/sunrpc/xprtsock.c                         |  4 +-
 net/tipc/socket.c                             |  2 +-
 net/unix/af_unix.c                            |  9 ++--
 net/vmw_vsock/af_vsock.c                      |  2 +-
 net/x25/af_x25.c                              |  2 +-
 security/tomoyo/network.c                     |  3 +-
 75 files changed, 189 insertions(+), 193 deletions(-)

-- 
2.34.1


