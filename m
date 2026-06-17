Return-Path: <netdev+bounces-300003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QGxSKEUFMmpZtwUAu9opvQ
	(envelope-from <netdev+bounces-300003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:24:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B17E56961F4
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=K7HqYxe2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300003-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300003-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 960F830151DF
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 02:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A9E29BDBB;
	Wed, 17 Jun 2026 02:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC7285C91
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:23:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662988; cv=none; b=LcyViJ8tMfJbo4oiT2bVvCd5t1Iu+yrIEYm8o9A/1xkEL2k7Ri/x6lmWVJSjhcjnQ4xwVRXVy3/Npqgi1wGukixTdF3kMhOPgAVItScvcpWk0Y/orOpTdlQ84PUeUDShB8OfTWbsOAI4bp329AjjjcfrxsMGoqCgmO4YoJIt45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662988; c=relaxed/simple;
	bh=onVULGk+R01lkgCQNR3Xb0v33frHa2V4MZlgLjlm81I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEDURNkTJ10x0mxC+jlvjKknIR7Egi8KbYlHp+v8zkVgw6pV/3Ojez/vBW4bbkU1RfaFhCQD/gg8b1IqUqeiRQJB5IJiKbXwJA7M0XZK/5aZ1F7MXAhp3X18TzpbFe4g6OxRc2BAm9rAhPPPeb6asz6LGZsroVGgWsV4aBKN9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K7HqYxe2; arc=none smtp.client-ip=91.218.175.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781662984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bK7DoZ1P9MNR1dJ3nH31NXwYy61BizuMZoLyrKupyVM=;
	b=K7HqYxe2C40Ldxxa51FWDmb6f4Qsh9rE9PEfrItemYy4VuYD1wHr0S3bD+Ab+z+/OexN3/
	KptDLVTcMbO8vQ27g1PyXfa9GeGrPupWTKuGRSZfQKjtMrKeJOV3UYpLHsNEzjxlWSGnGa
	nJQR+WO5kFBo8YSJtzLfskdb/9wkMaU=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	George McCollister <george.mccollister@gmail.com>,
	David Yang <mmyangfl@gmail.com>,
	netdev@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v2] net: dsa: Fix skb ownership in taggers
Date: Wed, 17 Jun 2026 10:22:47 +0800
Message-ID: <20260617022248.1500-1-qingfang.deng@linux.dev>
In-Reply-To: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
References: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300003-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B17E56961F4

On 16 Jun 2026 at 11:36:22 +0200, Linus Walleij wrote:
> --- a/net/dsa/tag_rtl4_a.c
> +++ b/net/dsa/tag_rtl4_a.c
> @@ -41,8 +41,10 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
>  	u16 out;
>  
>  	/* Pad out to at least 60 bytes */
> -	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
> +	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false))) {
> +		kfree_skb(skb);
>  		return NULL;
> +	}

This can be simplified to eth_skb_pad().

>  
>  	netdev_dbg(dev, "add realtek tag to package to port %d\n",
>  		   dp->index);
> --- a/net/dsa/tag_rzn1_a5psw.c
> +++ b/net/dsa/tag_rzn1_a5psw.c
> @@ -48,7 +48,7 @@ static struct sk_buff *a5psw_tag_xmit(struct sk_buff *skb, struct net_device *de
>  	 * least 60 bytes otherwise they will be discarded when they enter the
>  	 * switch port logic.
>  	 */
> -	if (__skb_put_padto(skb, ETH_ZLEN, false))
> +	if (skb_put_padto(skb, ETH_ZLEN))
>  		return NULL;

Same here.

>  
>  	/* provide 'A5PSW_TAG_LEN' bytes additional space */

- Qingfang

