Return-Path: <netdev+bounces-125240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F3596C670
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA631F22FBA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9391E2011;
	Wed,  4 Sep 2024 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYg2gO63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB412BEBB;
	Wed,  4 Sep 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474599; cv=none; b=NxButpzbdi8wDtEfI8OFKAgWqKC/PJxAk4mPEcVNDhRfoG4ePu/xcTQ8SYr1Z2vn+WsZcaj6i4cZePM5PaUQmipYWsjZIvYHflg+0/w+Evdal8bYg4Rb8sPVkSJyVXkwJvzV4XEvRNwgm7Z/sSo3pWVNEVgSuEcnsJyp/Rnflns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474599; c=relaxed/simple;
	bh=kL2piebXo3Utwe8dYmGRPzr5ytc0xKTfFdXVyjAqo6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULjNyO4NrlEJp+YZ0ZPWyxdwSP2zh0WiCpSXiHETkLI44RDVjeKkQ51Es3CW+3vxooEZySHK4rwlAZ1qlE/JBKUgclr3jI5COTMn4XeLEeTIorXFdzaAlMZ1oQVR8Ly2AjVum7tfi0r5+TB9LqCS9cioTovs1TYbgzX2Dy8dWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYg2gO63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B6BC4CECA;
	Wed,  4 Sep 2024 18:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725474598;
	bh=kL2piebXo3Utwe8dYmGRPzr5ytc0xKTfFdXVyjAqo6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kYg2gO633yhhL+8/dd5qudGjjrkbDA3DZNy+WoleukpLrlb4Slmq2QsMCCYTMweP2
	 PNtQnWD3yZjb3pyzJPBZw4yv2T3ZAinWclUBLaVpBarehbG3CpkU/Va+JVgLo3DTFx
	 V0We/pS5IgQnuCFRnMBg7hlz7tyDzKYNBjS0qwq4CHaRMqVVfJLqSw0BOAAEkFrFGK
	 0Rma1VABzYAanh2PI3TD71J7h2JFjHfI3eMAsFvDnhYjvZYUPuvW5QcfxntOvExXBK
	 Mkz7x2m7NwD9DEZjRMNIc03YiE53v0PC3C7ki2vyXd6holu5LzQbwwEqmfIADay8IL
	 JNeM9szfb+g1w==
From: Simon Horman <horms@kernel.org>
Date: Wed, 04 Sep 2024 19:29:37 +0100
Subject: [PATCH net-next v2 2/2] octeontx2-pf: Make iplen __be16 in
 otx2_sqe_add_ext()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-octeontx2-sparse-v2-2-14f2305fe4b2@kernel.org>
References: <20240904-octeontx2-sparse-v2-0-14f2305fe4b2@kernel.org>
In-Reply-To: <20240904-octeontx2-sparse-v2-0-14f2305fe4b2@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>, 
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netdev@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.14.0

In otx2_sqe_add_ext() iplen is used to hold a 16-bit big-endian value,
but it's type is u16, indicating a host byte order integer.

Address this mismatch by changing the type of iplen to __be16.

Flagged by Sparse as:

.../otx2_txrx.c:699:31: warning: incorrect type in assignment (different base types)
.../otx2_txrx.c:699:31:    expected unsigned short [usertype] iplen
.../otx2_txrx.c:699:31:    got restricted __be16 [usertype]
.../otx2_txrx.c:701:54: warning: incorrect type in assignment (different base types)
.../otx2_txrx.c:701:54:    expected restricted __be16 [usertype] tot_len
.../otx2_txrx.c:701:54:    got unsigned short [usertype] iplen
.../otx2_txrx.c:704:60: warning: incorrect type in assignment (different base types)
.../otx2_txrx.c:704:60:    expected restricted __be16 [usertype] payload_len
.../otx2_txrx.c:704:60:    got unsigned short [usertype] iplen

Introduced in
commit dc1a9bf2c816 ("octeontx2-pf: Add UDP segmentation offload support")

No functional change intended.
Compile tested only by author.

Tested-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 3eb85949677a..933e18ba2fb2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -687,7 +687,7 @@ static void otx2_sqe_add_ext(struct otx2_nic *pfvf, struct otx2_snd_queue *sq,
 		} else if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
 			__be16 l3_proto = vlan_get_protocol(skb);
 			struct udphdr *udph = udp_hdr(skb);
-			u16 iplen;
+			__be16 iplen;
 
 			ext->lso_sb = skb_transport_offset(skb) +
 					sizeof(struct udphdr);

-- 
2.45.2


