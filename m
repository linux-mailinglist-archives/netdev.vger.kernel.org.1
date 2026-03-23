Return-Path: <netdev+bounces-270472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GJwKPUYwWn5QQQAu9opvQ
	(envelope-from <netdev+bounces-270472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:41:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B952F05F5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B0473055634
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E2A38C41B;
	Mon, 23 Mar 2026 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="pNv5+xWY"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91493370D77;
	Mon, 23 Mar 2026 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262161; cv=none; b=LgIeqyCZ/D2Vwi4QJoMu/qoKerE3q+Nvp0v5gPXi5+Vqw830cj2yGbQgrdiGaG+cRJ2YVJamUym4LuJh+tRlK8BoMujmQ90KCPuJS+AdPpr4FM1u96JmD/vvpQIRBsRg7i4VKU9RmVHA/Wj3zByVIC1JfwVakxJJ4W0UTz/Ls4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262161; c=relaxed/simple;
	bh=511WxbZ+p/sORRoJ5GoD7VW32OIKEjZsdi/60CW6C7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8IXENcTwDTmqzY0WmkfLILCc7pW10fZxUckxmUBzjlyZqfiPhMnhqVsfmaPmwXgWwq9SxIU1KT4WtZ40k2aLSug5sxUnfA2/scpwqPhnk1kC7PLW33+nUERJK8TyblyGODyH8NJZqX1pi7HdOiQoGg7mO2751Gc+xzdaArT3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=pNv5+xWY; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8B5BF20D1C;
	Mon, 23 Mar 2026 10:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1774262150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wB/8hmIhHIYOZcP6n7qCZqxw3BgXqSCHAqTZavDQKfs=;
	b=pNv5+xWYOc4YBIYu3QmlifXrPhgpnzNrNnJN1SbmQ9AI+QfJhDZFGX760bxtXpQqOJB4ru
	+eQxXSLMFUY1CYyq2b+rvd8o8A5ET9LLF0B+Yj+u4tI1V7Lnbik/OrU0VMpWgtxLWplB0K
	flgRkfDIDiCkqGXzOnoXxiixWIDmu84=
From: Sven Eckelmann <sven@narfation.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: eladwf@gmail.com, daniel@makrotopia.org, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject:
 Re: [PATCH net-next] net: ethernet: mtk_eth_soc: ppe: prevent ppe update for
 non-mtk devices
Date: Mon, 23 Mar 2026 11:35:43 +0100
Message-ID: <4723146.LvFx2qVVIh@ripper>
In-Reply-To: <20240623175113.24437-1-eladwf@gmail.com>
References: <20240623175113.24437-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2405260.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270472-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,makrotopia.org,nbd.name,mediatek.com,kernel.org,davemloft.net,google.com,redhat.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,narfation.org:dkim]
X-Rspamd-Queue-Id: E0B952F05F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart2405260.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Elad Yifee <eladwf@gmail.com>
Date: Mon, 23 Mar 2026 11:35:43 +0100
Message-ID: <4723146.LvFx2qVVIh@ripper>
In-Reply-To: <20240623175113.24437-1-eladwf@gmail.com>
References: <20240623175113.24437-1-eladwf@gmail.com>
MIME-Version: 1.0

On Sunday, 23 June 2024 19:51:09 CET Elad Yifee wrote:
> Introduce an additional validation to ensure that the PPE index
> is modified exclusively for mtk_eth ingress devices.
> This primarily addresses the issue related
> to WED operation with multiple PPEs.
> 
> Fixes: dee4dd10c79a ("net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs")
> Signed-off-by: Elad Yifee <eladwf@gmail.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> index f80af73d0a1b..f20bb390df3a 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> @@ -266,7 +266,7 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
>  		flow_rule_match_meta(rule, &match);
>  		if (mtk_is_netsys_v2_or_greater(eth)) {
>  			idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
> -			if (idev) {
> +			if (idev && idev->netdev_ops == eth->netdev[0]->netdev_ops) {
>  				struct mtk_mac *mac = netdev_priv(idev);
>  
>  				if (WARN_ON(mac->ppe_idx >= eth->soc->ppe_num))
> 

This will immediately cause a NULL-deref when gmac0 is disabled but gmac1 (or 
gmac2) is enabled - and you try to offload a flow.

You have the problem that `eth->netdev[0]` is NULL and then you try to deref 
it to get to its netdev_ops.

Btw. can you describe what netdev[0] makes it so special that you need to 
check for it and not netdev[1] or netdev[2]? With something like:

diff --git i/drivers/net/ethernet/mediatek/mtk_ppe_offload.c w/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index cb30108f2bf6..5f88ad7eb27a 100644
--- i/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ w/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -244,6 +244,21 @@ mtk_flow_set_output_device(struct mtk_eth *eth, struct mtk_foe_entry *foe,
 	return 0;
 }
 
+static bool mtk_is_valid_mtk_netdev(const struct mtk_eth *eth, const struct net_device *idev)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->netdev); i++) {
+		if (!eth->netdev[i])
+			continue;
+
+		if (idev->netdev_ops == eth->netdev[i]->netdev_ops)
+			return true;
+	}
+
+	return false;
+}
+
 static int
 mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 			 int ppe_index)
@@ -270,7 +285,7 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		flow_rule_match_meta(rule, &match);
 		if (mtk_is_netsys_v2_or_greater(eth)) {
 			idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
-			if (idev && idev->netdev_ops == eth->netdev[0]->netdev_ops) {
+			if (idev && mtk_is_valid_mtk_netdev(eth, idev)) {
 				struct mtk_mac *mac = netdev_priv(idev);
 
 				if (WARN_ON(mac->ppe_idx >= eth->soc->ppe_num))


Regards,
	Sven
--nextPart2405260.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCacEXfwAKCRBND3cr0xT1
y02aAP4iDQQDf9UUbD2rqYq0CVAEhadpEw9XDmO6ZTE0YsynIQEAtuJGax+RdlgQ
aXVXzEzKdbIM1XUrhOCcz2ivNgWaUQI=
=b8QW
-----END PGP SIGNATURE-----

--nextPart2405260.ElGaqSPkdT--




