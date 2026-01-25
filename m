Return-Path: <netdev+bounces-253245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NlsFJCadmmqSwEAu9opvQ
	(envelope-from <netdev+bounces-253245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:34:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A45F682B3C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B44D30037F3
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E84F30E0E4;
	Sun, 25 Jan 2026 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT+JZiaF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03BF30DD27;
	Sun, 25 Jan 2026 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380492; cv=none; b=tM0TOtJXxrKVZae9VC9AYsyPnXHMrCPHdRLKbvLC4Giulq3TBOLFuon1/hhjdRCtyIguKbyyfV4AyqABpGrzflgLslZqIzh06od3Cu/SSI0MjkrxgMX9pDUwSSxGAajHwm2GDWnOvcVRDJ4twOEd2b3Yx4hna+ZE4CQrYGxo/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380492; c=relaxed/simple;
	bh=KAdNjrycKqLluc/HY6/6mSsy/Qr4u2lzh7VnmF31KKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjYpUQxQ20nmnWaE/5HhKZyLkjrsW7qshIxHrJF18sx+/Z/21VhFBOAzs9+TQNWsV5fHgIA8KsdekWnAZJ5v+Gs9IxesNyy5j6A4PMUwhgjx1hp9ZWsev2P/L1jtUFPpwUyP+JQWK7oibXm4hRmcvXnjcx1OLsrsZGERAAq8g3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT+JZiaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8883C4CEF1;
	Sun, 25 Jan 2026 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769380492;
	bh=KAdNjrycKqLluc/HY6/6mSsy/Qr4u2lzh7VnmF31KKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tT+JZiaFIZ4K+RbANXzsvLiIxvVV9fqs+E2gxs0Oc77Fw8CvrurCzWCSLrSMosA5R
	 xB7dLvADSRcK+1NgWyFmbP2parSrY1Hxpg6SL39Vl8VwdKSLvM3WM4TaQIT52BlgEs
	 FUFIVB1xUHS1BTSbXlMW55fujfe36xSpv0ertQGCIl9FvqHOgLm+JtjZYRfa2LO6mc
	 LUAcN6Ikv7bc6rTyyDEyWy5amLbttQeLW8D436lWWaPK0G9d0iu64n7HP066ILa5ne
	 DC17xNfIGQ7pim8YEju/1BuRZ3+Ftm3ysx+wajbsGWYZTZmxsDNHYghfVWL/g61TRd
	 kgh0oYnUUqHHQ==
From: Jakub Kicinski <kuba@kernel.org>
To: qikeyu2017@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	johannes@sipsolutions.net,
	pabeni@redhat.com,
	chandrashekar.devegowda@intel.com,
	edumazet@google.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	haijun.liu@mediatek.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	ricardo.martinez@linux.intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	davem@davemloft.net
Subject: Re: net: wwan: t7xx: fix potential skb->frags overflow in RX path
Date: Sun, 25 Jan 2026 14:34:43 -0800
Message-ID: <20260125223443.3404985-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121091853.1758-2-qikeyu2017@gmail.com>
References: <20260121091853.1758-2-qikeyu2017@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253245-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,sipsolutions.net,redhat.com,intel.com,google.com,oss.qualcomm.com,gmail.com,mediatek.com,vger.kernel.org,lunn.ch,linux.intel.com,davemloft.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A45F682B3C
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: wwan: t7xx: fix potential skb->frags overflow in RX path

This patch adds a bounds check to prevent skb->frags[] array overflow
when the modem firmware sends packets with excessive fragments. The fix
adds a check for nr_frags >= MAX_SKB_FRAGS before calling skb_add_rx_frag().

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> index b76bea6ab2d7..b041e6f48732 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> @@ -395,6 +395,7 @@ static int t7xx_dpmaif_set_frag_to_skb(const struct dpmaif_rx_queue *rxq,
>  				       struct sk_buff *skb)
>  {
>  	unsigned long long data_bus_addr, data_base_addr;
> +	struct skb_shared_info *shinfo = skb_shinfo(skb);
>  	struct device *dev = rxq->dpmaif_ctrl->dev;
>  	struct dpmaif_bat_page *page_info;
>  	unsigned int data_len;
> @@ -407,13 +408,16 @@ static int t7xx_dpmaif_set_frag_to_skb(const struct dpmaif_rx_queue *rxq,
>  	if (!page_info->page)
>  		return -EINVAL;
>
> +	if (shinfo->nr_frags >= MAX_SKB_FRAGS)
> +		return -EINVAL;

When this new error path is taken, it appears that page_info->page has
already had its DMA mapping removed via dma_unmap_page() earlier in the
function, but the page itself is not freed (put_page is not called) and
page_info->page is not set to NULL.

Could this cause a page leak? On this error path:
- dma_unmap_page() has already been called
- page_info->page still holds a reference to the page
- t7xx_dpmaif_set_bat_mask() is not called in the caller t7xx_dpmaif_get_frag()

When the device is eventually torn down, t7xx_dpmaif_bat_free() will
iterate all entries and call t7xx_unmap_bat_page(), which will call
dma_unmap_page() again on the same (now stale) data_bus_addr. Is there a
concern about calling dma_unmap_page() twice for the same mapping?

It looks like the page cleanup on this error path should either:
- Move the new bounds check before dma_unmap_page(), or
- Add put_page() and set page_info->page = NULL on the error path

> +
>  	data_bus_addr = le32_to_cpu(pkt_info->pd.data_addr_h);

[ ... ]
-- 
pw-bot: cr

