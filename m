Return-Path: <netdev+bounces-287778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOPxGjorBWo4TAIAu9opvQ
	(envelope-from <netdev+bounces-287778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:54:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A265B53CE0E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1DAE301FDF3
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6232F3622;
	Thu, 14 May 2026 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3Ata02/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26725A354;
	Thu, 14 May 2026 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723637; cv=none; b=q2N8dwiLWZYSjyT1SEFYQ7LeoOHDzS5puxjXXXyf46OX2rMPHViFQwsUsk5/n9ygJzsh2FkzzLkEpBFe430goDFEQWk2OrH3KbYTIX0kJePi7dkXZQiYxZQL86E9ihNDO010+RCRldEKP3Zy2O/nus2PN98pf4Wo52LZ2u9fWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723637; c=relaxed/simple;
	bh=Q1VpBQM50Yn3gZ371kogckumiz1tEUSOReWT97QXvUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfHh08V1P5Yc1u4yUQ3iORAkEwTQ7BAJA9Tl5qyznxfU2oaJNXyxIq2k38aMIOowqUMiuorsFHLF3MD00un1VOULds3qe77ANe/DfFPNRwEUyBSK0axjBRvFZNft1S8JgZUbOgoQ7MY/gcafANpA3+UKnloyAgkBd6QqHj+F/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3Ata02/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D0C19425;
	Thu, 14 May 2026 01:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723636;
	bh=Q1VpBQM50Yn3gZ371kogckumiz1tEUSOReWT97QXvUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q3Ata02/VEERalLaUvFCj6TCjwaPOownTlkECTxQWB3C4NtbHWKTMnQ3gABen+7kA
	 yTprbbdgliGsfqb5MFiQpJ1umq9JhN0LxVTdse2WJxd+3hrOUDinrG1xl6t5s0boZS
	 ipI9/RadHXALChuJOgvmux9PfHu+ZAAvXgBLbsy/mpyk+sIuH8C0+fFjkEba1EJu9u
	 OMsy3pfJEPCbgD4iNEBaCxfYZ/wbYlpHPWEAFfYc3SQJQRa9fYUJ8hrIffizOiU2cn
	 0PWxTbPC0AScp7am/KaPy5dmWT5x1+R40eia7lE8FN8TZAm+KEyl89NF+GffJABT0K
	 l0t8sqHXT46TA==
Date: Wed, 13 May 2026 18:53:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, Frank Wunderlich
 <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Mason Chang
 <mason-cw.chang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [net-next v8 3/3] net: ethernet: mtk_eth_soc: Add LRO support
Message-ID: <20260513185354.31e97941@kernel.org>
In-Reply-To: <20260509190938.169290-4-linux@fw-web.de>
References: <20260509190938.169290-1-linux@fw-web.de>
	<20260509190938.169290-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A265B53CE0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk,public-files.de,vger.kernel.org,lists.infradead.org,mediatek.com,makrotopia.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat,  9 May 2026 21:09:32 +0200 Frank Wunderlich wrote:
> +			mtk_rx_irq_disable(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)));
> +			napi_synchronize(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
> +			napi_disable(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);

What purpose that napi_synchronize() serve?
Also we don't charge for temporary variables, maybe save that
MTK_HW_LRO_RING(eth, i) to make this slightly more readable.

