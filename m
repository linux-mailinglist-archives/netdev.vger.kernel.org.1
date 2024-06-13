Return-Path: <netdev+bounces-103403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D2C907E31
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14721C22E4D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DBE13B787;
	Thu, 13 Jun 2024 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNVthX+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E8371747
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314247; cv=none; b=GobVuY9ok7P9YmcN168OQjnb82jVVHKETdNESUEdRSa+EQv3WH4YlkeQ03WIOQhv/tat49Hhjc9eavEmpOuP8aOJT9dpEYv7DzQDlo2AkdCTI3de9gTEzn+ZcN+rCp0iaPP7iCNBe8Lu4JjLRcpVFK5vX5shBnqs+63f9nAGZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314247; c=relaxed/simple;
	bh=vL8siueTJKLiH03DKajoFJJfPeIK52TYxWAcvZUMwLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzDn7G4oktRU4rDLdJR8y2AWRgMs5+d/eTtlYsrjACD+s7cwUKNcBJdcg6MjCHCKghzwlt1fSzC51ocQP4iikkjrXpG9Umf9YxE76RdI9m3v3S41uU6MpVGoY/HsRA8mF/jbOoq3mogNzQMvSHiA42LdqWPkvAf/3L/HRUjrwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNVthX+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2E9C2BBFC;
	Thu, 13 Jun 2024 21:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718314247;
	bh=vL8siueTJKLiH03DKajoFJJfPeIK52TYxWAcvZUMwLg=;
	h=From:To:Cc:Subject:Date:From;
	b=rNVthX+NCZhgLwqNzEIq6jIVujCZSD9+zbq2J+o2bL3WZk3Xlira1BWnBQBKu/Pd4
	 4ZhTbNhS0ysQJ4zBXM9NrIWV/I0zUzGSWNCg/mdivXY55vpTbdFIp3bg0liMOfVatF
	 Fc0XLMUUTSLPmn4u7ctDEb96YZyKq33OSpIOjPvwzX4OojWUnHx1/sSKEsy8n7diiX
	 OB6VuqFTAUeMnjv3OllwhJJp9DbEQ+yOH1aEMhbGMRebp+4+lK/5ovEjlyKg8wsjvK
	 wMRL3qnSOqrgXtkclK2MbJvNrcUavRrAlqgJgVIYWKYyMOuSUzTsb6byGm8jC17rNC
	 ZzlTcqcnXJ66A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	alardam@gmail.com,
	lorenzo@kernel.org,
	memxor@gmail.com
Subject: [PATCH net] netdev-genl: fix error codes when outputting XDP features
Date: Thu, 13 Jun 2024 14:30:44 -0700
Message-ID: <20240613213044.3675745-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-EINVAL will interrupt the dump. The correct error to return
if we have more data to dump is -EMSGSIZE.

Discovered by doing:

  for i in `seq 80`; do ip link add type veth; done
  ./cli.py --dbg-small-recv 5300 --spec netdev.yaml --dump dev-get >> /dev/null
  [...]
     nl_len = 64 (48) nl_flags = 0x0 nl_type = 19
     nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
  	error: -22

Fixes: d3d854fd6a1d ("netdev-genl: create a simple family for netdev stuff")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: amritha.nambiar@intel.com
CC: sridhar.samudrala@intel.com
CC: alardam@gmail.com
CC: lorenzo@kernel.org
CC: memxor@gmail.com
---
 net/core/netdev-genl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1f6ae6379e0f..05f9515d2c05 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -59,22 +59,22 @@ XDP_METADATA_KFUNC_xxx
 	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XDP_RX_METADATA_FEATURES,
 			      xdp_rx_meta, NETDEV_A_DEV_PAD) ||
 	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XSK_FEATURES,
-			      xsk_features, NETDEV_A_DEV_PAD)) {
-		genlmsg_cancel(rsp, hdr);
-		return -EINVAL;
-	}
+			      xsk_features, NETDEV_A_DEV_PAD))
+		goto err_cancel_msg;
 
 	if (netdev->xdp_features & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
 		if (nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
-				netdev->xdp_zc_max_segs)) {
-			genlmsg_cancel(rsp, hdr);
-			return -EINVAL;
-		}
+				netdev->xdp_zc_max_segs))
+			goto err_cancel_msg;
 	}
 
 	genlmsg_end(rsp, hdr);
 
 	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+	return -EMSGSIZE;
 }
 
 static void
-- 
2.45.2


