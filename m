Return-Path: <netdev+bounces-104178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B601F90B79A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D09B2263F
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99551662E0;
	Mon, 17 Jun 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUBbOFPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569F161904
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643035; cv=none; b=V8bWz4dYhJWdmxffQaBdNiGpzgqE+kd3s903sUPb+rZEzCMkQs3XEt8Mz1DaEmYgKiWN3CjEM71IDPtSVFMXwMa0fjgSUiMq5S3wGG3JO2WxwFPbjth3edUzZabSpiFdUGqBLbVoZslgKCUC0W4VsyDBUBLkw5V5dCNQVdOknv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643035; c=relaxed/simple;
	bh=D63MtkbAqqlmii321085ZHjnulMiTBM6NBCGF/gfAFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A/KS8e7HUr00rcF2Vl5RcccoY61SoGnH7Y75qm2adduniW5IarAMUU8T+PL/63jXDXhxx8xUcJoGCm/9hA9nblC9RQbXr7RneAwRXe8LRUCxQeHM9TfHEDYN7mW+ip+z3OO3J18TLSm4dA9Zazv3Qlo5Nr7QNFCtdl3o/vq88bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUBbOFPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7D3C2BD10;
	Mon, 17 Jun 2024 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718643035;
	bh=D63MtkbAqqlmii321085ZHjnulMiTBM6NBCGF/gfAFY=;
	h=From:Date:Subject:To:Cc:From;
	b=ZUBbOFPDLkbM7fKOZglIn5VzgEZkp89y+1IPZ2NFW0DnzPL01cRRU2ccQV+0fz010
	 +A3Z4g7T4memPFqGbl1mdnBIN6l8gFMlD0Lbfwm03qaF6k36mSVqM9HZTvzYvQHseH
	 ehgNgwzS/LTGbTtiKxH+L5wdW9c+/cEBuny5kNj78es03ZPsG01BbangP/+w528xYp
	 8+YVrAeUl62OPZhL4uJSYKVzrNjcYSlQ66Whkl9VAtkqj0N2EWV8iduC7WOVAsmYBp
	 emhB3PykckJuiWcsx/8GrH6x93BTxTIsTHPOFUqZWbnFbpy7j4CdjGuoQGt+HN9WFt
	 sXV7IH4ZS1R6Q==
From: Simon Horman <horms@kernel.org>
Date: Mon, 17 Jun 2024 17:50:26 +0100
Subject: [PATCH net] octeontx2-pf: Add error handling to VLAN unoffload
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-otx2-vlan-push-v1-1-5cf20a70570e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFJpcGYC/x3MSQqAMAxA0atI1gbsQKteRVw4pBqQKq2KULy7x
 eVb/J8gUmCK0BYJAt0cefcZoixgWge/EPKcDbKSujLC4n4+Eu9t8HhccUXljB1rZXVjBeToCOT
 4+YcdeDqhf98PR6f+0WUAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Hariprasad Kelam <hkelam@marvell.com>, 
 Naveen Mamindlapalli <naveenm@marvell.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

otx2_sq_append_skb makes used of __vlan_hwaccel_push_inside()
to unoffload VLANs - push them from skb meta data into skb data.
However, it omitts a check for __vlan_hwaccel_push_inside()
returning NULL.

Found by inspection based on [1] and [2].
Compile tested only.

[1] Re: [PATCH net-next v1] net: stmmac: Enable TSO on VLANs
    https://lore.kernel.org/all/ZmrN2W8Fye450TKs@shell.armlinux.org.uk/
[2] Re: [PATCH net-next v2] net: stmmac: Enable TSO on VLANs
    https://lore.kernel.org/all/CANn89i+11L5=tKsa7V7Aeyxaj6nYGRwy35PAbCRYJ73G+b25sg@mail.gmail.com/

Fixes: fd9d7859db6c ("octeontx2-pf: Implement ingress/egress VLAN offload")
Signed-off-by: Simon Horman <horms@kernel.org>
---
I audited callers of __vlan_hwaccel_push_inside in net
and this appears to be the only one that needs this fix.
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index a16e9f244117..929b4eac25d9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1174,8 +1174,11 @@ bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
 
 	if (skb_shinfo(skb)->gso_size && !is_hw_tso_supported(pfvf, skb)) {
 		/* Insert vlan tag before giving pkt to tso */
-		if (skb_vlan_tag_present(skb))
+		if (skb_vlan_tag_present(skb)) {
 			skb = __vlan_hwaccel_push_inside(skb);
+			if (!skb)
+				return true;
+		}
 		otx2_sq_append_tso(pfvf, sq, skb, qidx);
 		return true;
 	}


