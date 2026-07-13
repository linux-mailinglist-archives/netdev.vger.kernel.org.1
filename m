Return-Path: <netdev+bounces-307285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0vkmOZZVVWoenAAAu9opvQ
	(envelope-from <netdev+bounces-307285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:16:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EBA74F358
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:16:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Do7EiwmZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307285-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307285-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B510303740A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F83733E348;
	Mon, 13 Jul 2026 21:16:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37E2652A2
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:16:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977362; cv=none; b=qRLuPFIp4EHfh5wpcSnJEpDeg+mvLlXAkRwWaR6LDR/cepYYlwrKbjBa7epWGClxLKIoL0Inso9QPRnWEJOiHku96fars4k5dsZMULGOj0TnBBH92BOUMXE5c4e6ii9rigoXZZEcgRsjIRTyYYtMEhxzRQt/FFEKSnkDY5O2orY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977362; c=relaxed/simple;
	bh=OjupI1J8Uf6ZmRz+nFaqT/63B4bo16S2X+GqHuBV27E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2uR5o+05PGPLBcyxMS+AFGDD9NM/Jm8GGAvHM0+cWgeTGMvu0yB48jpDULfcNyAA9NRzWAI3rlqriRCt3nY4Snnr7AmrcKK8JUNcous9GWPsyKxrHqi9yWp++GsyMpCki1IYtYyrAlJswb6RzOhnoh8IBFnvDiudaSvejtWSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do7EiwmZ; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493f140ca8eso22418355e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783977359; x=1784582159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2wQJEgASjgsy4yDd4CAOFiJYx60jS5AQH+okUrcyglg=;
        b=Do7EiwmZjZewBwE5xIaH16fPw5ti35pFMVzdFswhPRtuCuRgMmzQj/bcYHXi88RJey
         EkIff1FRN+EUdwI3KFX7a5qnq3/ou+PP3tv1nRH7pcqcOmtWVo2YYU7g4sD5ahVvbXyP
         yQkVufcyd8z5A76iPwg03lwqM+p8QNzKkMH+vk7E8OR1DJamSHuDQTzaW/IPJfe142Y9
         HG9rylTBXOxomReUX2BXVK/rnhs6WPHoaGYAo4sqfLjW+SOC0/RszY81sM5RpS25FEKu
         P9h5phXcT+qDgw4Ju7Vil+2M5mUdFyn+LiAAUjRnkidokAgo6LAz72swbQKZM1Go3FBz
         CcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977359; x=1784582159;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wQJEgASjgsy4yDd4CAOFiJYx60jS5AQH+okUrcyglg=;
        b=fxF/EZ4NiklVpuRxAmCSft6h/4YzZ/2nBRgmcdpsJmg+4ixxAT/ZVpVus2iv+TsjtD
         nMHDu0Fu8HszyugboU1GSk03U7PgSPzoF5QOYTykXWau3HSB8WH3SVe+SYferPxXLNAv
         NnLIktzMD6GIW4ZLxZiW/4ryU2PctJmmNc50d55wD/PWxcJ3/4b6BZC4IaWmgL8XMlEN
         CwwNpVzDYfEVq4L7p3SvIXanIqa/5rtXSkd5Jb1HZbs4pA4/8Tvl0w6rUPY139DYf1BR
         BY9ixaktgI3EzwQzHhQoxTCQ2983z3ACHwEC/BJPaMPbyDsM2woh3FuRwnoqMRpVUSXr
         Qw3w==
X-Forwarded-Encrypted: i=1; AHgh+RqREJGqaDvxMLeA0pXQPHm76NzAhWsE1wBjTIbli1tvlR1nZx/6faNQ4EgyWRShioJCO3f7G/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIvIJDIjikbZeeI39jsvl1gvimd7LvnGTEGWoZQKMdBk1unBE
	kz/OEg1fVy9irDJg32EN3a/WYicBRaeoAYPT8av720UgnrEgK+AqunRx
X-Gm-Gg: AfdE7ck7wNY7ikFFrstkV0w5w0jONMNSnZbFN+Q0PF1h3K7o2Y1wwmTrydXxbT8zHdc
	x8tRyoaB+TNPgN0uYe65xcCAycoJKWLD0gku5sJOabCtzvzXNIDwMYIH78o1EtV/+GZlsrJ3qmj
	qO+V0fu6tmRqK4jbvREsdEZf46JkWiEfxjrkWUnEneMnPAPvipOzQh6SPoIYrDhX+xOhA8vU2K6
	USzg7pekd1OD2oqZTuNvEaO2bEEdLe3I6DgeEPypV/elj3oXVzpt3Wbo9ccj+kEukH8k8ScDbWz
	ygfJSOli04p8MCLwKoU34wJrgJeXw9Nu0ZTWnVnyO7HxZ4GR0MQIOBWULtZflYYOuy4ae2MMaL3
	NX1hqyTqkvH/eJLVo8PwPEPtW0bpZT7g4vyz/MHje1x+Ie5IKFPQMiIvt22W9RR5y+8kMsPqnk0
	8j4Q6hbPKtVNNQlrFhQkYObwXp0GcV1JPIzHQ50K9zvOINLrPT8+sqWsCUSDJz
X-Received: by 2002:a05:600c:464a:b0:492:7083:e5a with SMTP id 5b1f17b1804b1-493f882b117mr72487425e9.31.1783977358718;
        Mon, 13 Jul 2026 14:15:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f462e0cb2sm2500839f8f.0.2026.07.13.14.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:15:58 -0700 (PDT)
Date: Mon, 13 Jul 2026 22:15:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: david@ixit.cz, vadim.fedorenko@linux.dev, horms@kernel.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: llcp: reject PDUs shorter than the LLCP
 header
Message-ID: <20260713221556.13a830b8@pumpkin>
In-Reply-To: <20260713155848.55530-1-doruk@0sec.ai>
References: <20260713155848.55530-1-doruk@0sec.ai>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307285-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:david@ixit.cz,m:vadim.fedorenko@linux.dev,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41EBA74F358

On Mon, 13 Jul 2026 17:58:48 +0200
Doruk Tan Ozturk <doruk@0sec.ai> wrote:

> Every LLCP PDU begins with a two-byte header (DSAP/SSAP + PTYPE), but the
> receive path never checked that a frame is at least LLCP_HEADER_SIZE bytes
> before parsing it.

Is there a similar problem with non-linear skb?
Maybe they can't get into this code, but who knows what can happen
with unusual configs.

	David


> A peer LLCP PDU travels: NFC-DEP frame -> nfc_tm_data_received() (target /
> NCI path) or nfc_llcp_recv() (initiator data-exchange callback) ->
> __nfc_llcp_recv() -> rx_work -> nfc_llcp_rx_skb() ->
> nfc_llcp_recv_connect(). For a CONNECT (or CC) PDU nfc_llcp_recv_connect()
> computes
> 
> 	tlv_array_len = skb->len - LLCP_HEADER_SIZE;
> 
> as a size_t and hands it to the TLV walk. When skb->len is 0 or 1 the
> subtraction wraps to a huge value and the walk runs far past the skb,
> causing an out-of-bounds read; nfc_llcp_ptype()/nfc_llcp_ssap() likewise
> read pdu->data[1] for such a short frame.
> 
> A nearby NFC device can reach this without authentication; LLCP link
> activation happens automatically after NFC-DEP.
> 
> Reject PDUs shorter than the LLCP header in __nfc_llcp_recv(), the common
> choke point shared by both the target (nfc_llcp_data_received()) and
> initiator (nfc_llcp_recv()) receive paths, so a short skb is freed before
> the rx_work worker is scheduled.
> 
> Reproduced with a KFENCE out-of-bounds read via /dev/virtual_nci on
> linux-next.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis.
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v2: move the check into __nfc_llcp_recv() so a short skb is dropped
>     before the rx_work worker is scheduled (Vadim Fedorenko), which also
>     covers the initiator nfc_llcp_recv() path. Reword the commit message
>     (drop the "same guard as AGF" wording) and add a KFENCE reproduction
>     note.
> 
>  net/nfc/llcp_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index aed5fe1afef0..72b6e707ad0c 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1565,6 +1565,11 @@ static void nfc_llcp_rx_work(struct work_struct *work)
>  
>  static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
>  {
> +	if (skb->len < LLCP_HEADER_SIZE) {
> +		kfree_skb(skb);
> +		return;
> +	}
> +
>  	local->rx_pending = skb;
>  	timer_delete(&local->link_timer);
>  	schedule_work(&local->rx_work);


