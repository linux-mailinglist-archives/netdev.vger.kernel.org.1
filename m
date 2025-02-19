Return-Path: <netdev+bounces-167675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695A9A3BB95
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BCC7A7CFE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA881DE4D4;
	Wed, 19 Feb 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIOZbm3L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6341DE4D0
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960446; cv=none; b=Y52+nntlBctW2b7W3KOjzucznNzxZoP+K/k4UOmftDRelCb+9vJqMERFm0NRKgCluHNiTDBNkiNl9/1jyZan5bVI/XfJT9I0iLisSvnZAgf2a+R7Fck2tvmmCz5z5QGVxNEzV/yQv9ZKFXNu9I0/Nf/29FCvQA1q1kAVQun7YoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960446; c=relaxed/simple;
	bh=lzx+6jISSJC3XoxDhPAqIx1HwB+hSy/TtKm3X5jo7nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NeKFoNWyhNfz7/KhiZHakITUhwPByTOl9dyUJUGwx5cD0T0chBVYtLYH+6z9XN8H4tzBD7NPxWQpMioNMZRBLTGCVqfAVhytiwcScH5hn7ApzOZJuHMDU20aPAqPeGfB0Ti0xkUUtbRZDMCjSa0Zyzaqx/r8I72oC9NZGApg3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIOZbm3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C2AC4CED1;
	Wed, 19 Feb 2025 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739960446;
	bh=lzx+6jISSJC3XoxDhPAqIx1HwB+hSy/TtKm3X5jo7nQ=;
	h=From:To:Cc:Subject:Date:From;
	b=WIOZbm3L9BzEL2GFJVYrh7oLxGGYqaLAiy4L2ALg3ljqBDuhy9lrO8v3mVc1n7Kes
	 fzbDjZqNjzAUb/8v8X0DCofguKoc5DzZxCoLkArgo9njzL9SnwrNTmDxZpWnWfgA+3
	 GodjP0Vf1aZcd0aZSzjX+Ryix3k6UqFJ0yc/J1hDNrhaLgQY0Nh7j0yw3hvuMEydeN
	 1Exmrv/50pVdhoIPhLc/5582SuKc2ljptOR9uMD1FXegLohEB4yv4DxsXJs8dZe6gh
	 lrOIaqky1g2xLMzxBQIAUpNsDxGA15L0zKJblbK1NqIFCeVYqnj97BmZ83l6k4ylFq
	 hFezPHb8ZeB/g==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Alexandre Cassen <acassen@corp.free.fr>,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH ipsec-rc] xfrm: fix tunnel mode TX datapath in packet offload mode
Date: Wed, 19 Feb 2025 12:20:37 +0200
Message-ID: <dd53723e4ba4dcb4efa9f731b54ebfb9ca24e049.1739959873.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandre Cassen <acassen@corp.free.fr>

Packets that match the output xfrm policy are delivered to the netstack.
In IPsec packet mode for tunnel mode, the HW is responsible for building
the hard header and outer IP header. In such a situation, the inner
header may refer to a network that is not directly reachable by the host,
resulting in a failed neighbor resolution. The packet is then dropped.
xfrm policy defines the netdevice to use for xmit so we can send packets
directly to it.

Makes direct xmit exclusive to tunnel mode, since some rules may apply
in transport mode.

Fixes: f8a70afafc17 ("xfrm: add TX datapath support for IPsec packet offload mode")
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Steffen,

Fixes line is not accurate as at that point, I didn't implement tunnel
mode yet. However it is still useful SHA-1 as it points to the commit
which changed these lines.

Changelog:
v0:
 * Added more comments
 * Make sure that we are calling to new function in tunnel mode only
RFC: https://lore.kernel.org/all/af1b9df0b22d7a9f208e093356412f8976cc1bc2.1738780166.git.leon@kernel.org
---
 net/xfrm/xfrm_output.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 34c8e266641c..8b4e044162b8 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -612,6 +612,40 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
 }
 EXPORT_SYMBOL_GPL(xfrm_output_resume);
 
+static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
+				  struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+	struct net *net = xs_net(x);
+	int err;
+
+	dst = skb_dst_pop(skb);
+	if (!dst) {
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+		kfree_skb(skb);
+		return -EHOSTUNREACH;
+	}
+	skb_dst_set(skb, dst);
+	nf_reset_ct(skb);
+
+	err = skb_dst(skb)->ops->local_out(net, sk, skb);
+	if (unlikely(err != 1)) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	/* In transport mode, network destination is
+	 * directly reachable, while in tunnel mode,
+	 * inner packet network may not be. In packet
+	 * offload type, HW is responsible for hard
+	 * header packet mangling so directly xmit skb
+	 * to netdevice.
+	 */
+	skb->dev = x->xso.dev;
+	__skb_push(skb, skb->dev->hard_header_len);
+	return dev_queue_xmit(skb);
+}
+
 static int xfrm_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	return xfrm_output_resume(sk, skb, 1);
@@ -735,6 +769,13 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			return -EHOSTUNREACH;
 		}
 
+		/* Exclusive direct xmit for tunnel mode, as
+		 * some filtering or matching rules may apply
+		 * in transport mode.
+		 */
+		if (x->props.mode == XFRM_MODE_TUNNEL)
+			return xfrm_dev_direct_output(sk, x, skb);
+
 		return xfrm_output_resume(sk, skb, 0);
 	}
 
-- 
2.48.1


