Return-Path: <netdev+bounces-253246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHOYEriadmmqSwEAu9opvQ
	(envelope-from <netdev+bounces-253246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:35:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C217B82B4B
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4745730056CE
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBB130E82E;
	Sun, 25 Jan 2026 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSCJJ2Be"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0E2F362A
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380503; cv=none; b=UBRliFuGHUa9V5CI2ibIYfm28RLgCASSz8qoJqqtPdg6vgwD19Ki/cUCaOroHjwTAVHZ1hJw8HJNDKaHteftOPcAc66m5XloasFbMVsAH/WNzF49ejCNT8uk8h5StqizqnQ2duMva3mEFSLD4ASBtPCSMlVEjpqN2BV4wBx+ilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380503; c=relaxed/simple;
	bh=zSJsrelPe72OF5BSJWMzvjNyxJBtK7WlsleC8j161ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqHd92jUaaA/tYjAg/D9XEGv+2lynzGpL1dxcaKF6itiNhrJM0SmC3Kp4maFEQrzpC9iFIx38DhA1ZIGBagtm8IXff5Mt04bEnhGzrLfvkcpKG7nxQUevTlDXCygG6qPopJCfEWpIU+dwv/QOPjbUsDAPRm4DJikcDPaX64EQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSCJJ2Be; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so31875945e9.3
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 14:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769380500; x=1769985300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5wfJAo9SBLVU6wNmnYh+V5LIeGoq+TArwEbDi1cTkk=;
        b=iSCJJ2BekV2B0frxiVPUrp/ALSP9/vSjpviTumqWU1U8CSyf7nV/llbs8CR4yl+o6X
         /ABlPiyJ5dM+f2kAEERTpCNotgyNlhnJ0tHGxc9xL4e2nMSoA9BNuLKZfnrCFpg4wJzf
         UTnf65RDOnoVwWWfRCc8KUwPh/FvaBU4NK5feRvXv3O6+pxV8augkh/uWnKBWvQaO1KX
         8ZqhVg5HEU+FsLPJ/7nrG5mnAQ3PTTUDAXELvObv1U38J9HqxIu4iSPZ2WQS4R5sFM7D
         LHhGsNnpLMgAP3ahn+BUi3IbAYvaF8+Efe2ipMEeyPXdM5Qg95qZRPDTpLrdcvxX1DWt
         3XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769380500; x=1769985300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5wfJAo9SBLVU6wNmnYh+V5LIeGoq+TArwEbDi1cTkk=;
        b=b1dBKm7CJnlObj4skmGVr4mVH4k61r/MFzkbQ/4czPXMWYy7H6vj7ucwWlwtg5f+Ao
         8pFoMB9i5sjEMwvtBa6JC2fy3Cxf84Gn42YV28t/aU4bt5weMnXX/YViUIVQkZAafaZr
         PkOttPDguEhnJTi8rYJTv9U9bSQ1fCw9PvXiz60FZxSBcWBxMSBLxheIJkBTMLXLklhT
         vp2/CGkSSLuKujmvYIPotLOklbx6FIs/EnPiUk0gN5zRH1JjHQ4En14YXopb4pWp+uKo
         sZGvK2YCIYnInsVgsrM1nFVSwQyd2d9M6lK9aNG+wMjHWvz5NxnzdiikO+TeXiTobBts
         WClA==
X-Gm-Message-State: AOJu0Yx3fcJGbxXRGP8GFPBWkji4hZtB/obH1BE9KUbUGB18o1e9zGqz
	dInXvlbf0Ra/VBEkVGVvvl3Z5sGtWgJ7O//GqxG6NrER5iXXg5aw6PuP0ZSsIw==
X-Gm-Gg: AZuq6aIDiqMBmeddP7IcKPhTpPCIXKE+XHnm5bHEQ5hdsyoCkLsaQ2QUY7fZsNiE4jJ
	0QFjLq6e04OPEwPrruSctCrXJeZPu7XSaZt213JHtD4KoS637ivpwtYXNbrh9W7dG63hAEoONDl
	635Gc/qcng2bb98q3Pq2iBSWAXdfrDykPiWk2mOgbKx+S5KAHOq0eC2rfT3AkJMVCY1JOzAg1hp
	DAacbXVP9GgJzvZlJ+ONePFWFxaaSMa7pMc9P3Nowu4fwZ80nDb7HwQzW0ITiVD1J85bXjr84XF
	s9YM8UiYOMJSisOzcwb5qfjoGTa4vX4RQAfKO1VpeSGtU04OZ7FWgPwVVc/BE73JOTWWP5nlOXR
	2tY2/ZQs57kSF60RI6RAHuiMpRyCZNlRhsu5WO5kqD4HTiiavWwIGAcmgqkLnXqyKnsEcNX/Ar/
	h5SrV7MtsLUAvNGZd+VsVkI6u4s7JklZmXWMAv01SALp/YrNcYGyMS
X-Received: by 2002:a05:600c:4e4a:b0:47e:e20e:bbb0 with SMTP id 5b1f17b1804b1-4805cd40fcfmr49219325e9.6.1769380500182;
        Sun, 25 Jan 2026 14:35:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d8a5c32sm277706295e9.11.2026.01.25.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:34:59 -0800 (PST)
Date: Sun, 25 Jan 2026 22:34:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Use u64_stats_t with
 u64_stats_sync properly
Message-ID: <20260125223455.31fd7a93@pumpkin>
In-Reply-To: <20260122185255.2761568-1-mmyangfl@gmail.com>
References: <20260122185255.2761568-1-mmyangfl@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253246-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: C217B82B4B
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 02:52:51 +0800
David Yang <mmyangfl@gmail.com> wrote:

> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 136 +++++++++++------------
>  drivers/net/ethernet/airoha/airoha_eth.h |  34 +++---
>  2 files changed, 85 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 62bcbbbe2a95..6ed220e5a094 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1472,131 +1472,131 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
>  
>  	/* TX */
>  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> -	port->stats.tx_ok_pkts += ((u64)val << 32);
> +	u64_stats_add(&port->stats.tx_ok_pkts, (u64)val << 32);
>  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> -	port->stats.tx_ok_pkts += val;
> +	u64_stats_add(&port->stats.tx_ok_pkts, val);

Wouldn't that be better written as:
	u64 val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
	val = val << 32 + airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
	port->stats.tx_ok_pkts += val;
(Assuming there something has stopped the hardware increment the register
between the two accesses, and there is an associated atomic zero.)

Otherwise you are generating 'tearing' on 64bit systems by adding the high
and low halves separately - regardless of how the stats are read.
I think that works for 32bit as well.

Making the code completely unreadable with 'special' types and 'special'
copy routines really doesn't seem worth while.
The compiler won't generate code that does 'data tearing' for aligned word
accesses, and even if it did nothing would really break.
The most you want is a memcpy_in_words() function that guarantees to use
'word' size tranfsers for aligned buffers - and is probably an alias for
normal memcpy() on all current systems.

OTOH data tearing can be seen for 64 bit adds on 32bit systems.

It is worth nothing that on 32bits the 'packet count' and 'byte count'
increments get seen as a pair, this doesn't happen on 64bit - one happens
before the other.

	David




