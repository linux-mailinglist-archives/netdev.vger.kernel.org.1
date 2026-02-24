Return-Path: <netdev+bounces-260266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI0YNz7snGnqMAQAu9opvQ
	(envelope-from <netdev+bounces-260266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:09:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF3180249
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6841A304EF60
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FD639FCE;
	Tue, 24 Feb 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9ymiQJK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0A288AD
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891740; cv=none; b=PqzAvA+m7aVb5MPttNOc95yFjpTbBppiKQ/tUsYNOUex15GokqsnpbMxmMcFD96kbsZgbMe7Kbl457zAqNJ1PhWJspbEkZZLMQpLC+VqpCd1mZ1Cy7e+UQbT4LZPZksYkPEiNC59p26m73o4rp6veqcOPuFuqJ6Jb2FvJCw358g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891740; c=relaxed/simple;
	bh=opvt71RIkrzadiPKM7qq7mrYaCtBjFVG0c79usEbR0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deNpzjZpsvB645YnUErXFsn/0KvWEm2WNOCWwDacPjCtTKGw1YeG+fyZxoHKy5IyAgbNU2GkPbR4t1bRtc6zYJ+85QiM0vxe0t5vqydfW1FfZQ5riGJN8R7ED9v3P8tu9QG6IoyrWn6iUHShR2Cf6X3PQ8ZZdmCvWWtcho+sbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9ymiQJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4206DC116C6;
	Tue, 24 Feb 2026 00:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771891739;
	bh=opvt71RIkrzadiPKM7qq7mrYaCtBjFVG0c79usEbR0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9ymiQJKTh5RStQEtTEJ8Kwt+2HT63D35v+4XxhlIMofWNb2BDvG1/Tje9N+3vF/s
	 hEqx0EmWof1xLA0n+5AarrE6iNCxFw7TUGuXl2MxWNStd2zNs2CNwSiqfP7zTNXM89
	 WGsuMI+0UWPftk/SnpMmDXYo5Dh21XpCQQkJQTwfLZ8FItaXpaC9YgWhnP2KvJ6Vrl
	 N/SZln9+U0RUrs64jGx4Wl4IBIfFAp8TPS5nnVLvIHqmHaI0xa//pc4iX1Wjo1J2RI
	 xLxnK5hBVitDkxTSk/2LoKdCpr86NHDOiJAh4XKDt6ltVLm3NKS4Z4Vi8jMJXeJ24v
	 W50CAfCJGnvzg==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	edumazet@google.com,
	pabeni@redhat.com,
	theo.lebrun@bootlin.com,
	netdev@vger.kernel.org,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch
Subject: Re: [net-next,v2,6/8] net: macb: make macb_tx_skb generic
Date: Mon, 23 Feb 2026 16:08:51 -0800
Message-ID: <20260224000851.140522-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223182632.1681809-7-pvalerio@redhat.com>
References: <20260223182632.1681809-7-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260266-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 44EF3180249
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: macb: make macb_tx_skb generic

The macb_tx_skb structure is renamed to macb_tx_buff with no functional
changes. This is a preparatory step for adding xdp xmit support.

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 33a963b6dd4d..4e3cc0e9ea87 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -959,7 +959,7 @@ struct macb_dma_desc_ptp {
>  /* Scaled PPM fraction */
>  #define PPM_FRACTION	16
>
> -/* struct macb_tx_skb - data about an skb which is being transmitted
> +/* struct macb_tx_buff - data about an skb which is being transmitted
>   * @skb: skb currently being transmitted, only set for the last buffer
>   *       of the frame

The comment documentation still describes this structure exclusively in
terms of sk_buff ('data about an skb which is being transmitted' and 'skb
currently being transmitted'), but the field type is being changed from
'struct sk_buff *' to 'void *' to support future XDP buffers.

Should the documentation be updated to reflect the generic purpose? For
example, indicating that the field can hold either an sk_buff pointer or an
XDP buffer pointer, which aligns with the intent stated in the commit
message about preparing for XDP xmit support.

>   * @mapping: DMA address of the skb's fragment buffer
> @@ -967,8 +967,8 @@ struct macb_dma_desc_ptp {
>   * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
>   *                  false when buffer was mapped with dma_map_single()
>   */
> -struct macb_tx_skb {
> -	struct sk_buff		*skb;
> +struct macb_tx_buff {
> +	void			*skb;
>  	dma_addr_t		mapping;
>  	size_t			size;
>  	bool			mapped_as_page;

[ ... ]

