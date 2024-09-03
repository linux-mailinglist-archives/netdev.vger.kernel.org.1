Return-Path: <netdev+bounces-124633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1550596A440
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C676D282BBC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7618BB9A;
	Tue,  3 Sep 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAFuA8H4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ECC18BB98;
	Tue,  3 Sep 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380833; cv=none; b=jOq1wwSy+B/UrwUxQwvMTrVaNQMiO0KM+8fJC6wKuAP36UARzYLuRDGIpQNQNq2lwevIcCJ5HKQifre/VlNOMFMB0KkGT7ZEvg6o0MidSxG8+uKet6dVYRh2CO87lt2n4Arb7pFBg1dFafJQd7vI7xOpy50iUGvu4rfcvczHBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380833; c=relaxed/simple;
	bh=vhaMH9nB7L0B5h8YVg4047SSaEis2Kis9LFU6jI5oVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uutURBJgqTWAJhPmSay31ks3GM1XD0dG85quPzZ5Qg8zwIEZAPL0+LU+Nuv+zSK5xZ7WkiDt3YtyiYrtNWzVkauiQPMr5YEiV8Rk78HOzvKF7FJXSSRk7TuODxHxwQ5jUibrZ3ntn8iQzpVEO7Yz9hcETRkjkSf7EgIrXbWYOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAFuA8H4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E29C4CECA;
	Tue,  3 Sep 2024 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725380832;
	bh=vhaMH9nB7L0B5h8YVg4047SSaEis2Kis9LFU6jI5oVU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KAFuA8H4UrstlOD0JoeX3mhoqbbICkQhhXaKFpMIGPKc+ol6KEp3xotXNqF6C4SU/
	 OXe4iqYRgCq4ZHJNKZ0gp2nxHfAeY4kVQnKHOGCYTOzbJKRuXun/OUeWyYG9xkZp51
	 8jLW/D4xzU63b7KsUGDCjpJmRGd7YIPu9JXbJYdYcRyksxIXSu3jHHGP6xhBZ1aKXB
	 aEiCpzlsNvZr+vAH6csX022kDQQYD40AH/Vi9ZX137ptN2ZvuDNYZEKT0I9/ZZQPOL
	 gI1hz8b0ZRFaUpzFqCVoFmRCuuzUoJpyvJwbuNZgU81LJkA51/sx7MUt7jpFrzLNxJ
	 VKhaBARzWakQg==
From: Simon Horman <horms@kernel.org>
Date: Tue, 03 Sep 2024 17:26:54 +0100
Subject: [PATCH net-next 2/2] octeontx2-pf: Make iplen __be16 in
 otx2_sqe_add_ext()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-octeontx2-sparse-v1-2-f190309ecb0a@kernel.org>
References: <20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org>
In-Reply-To: <20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org>
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
Compile tested only.

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


