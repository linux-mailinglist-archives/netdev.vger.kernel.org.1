Return-Path: <netdev+bounces-286813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLOVCrYyAmrSowEAu9opvQ
	(envelope-from <netdev+bounces-286813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:49:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE9515411
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C950330358AD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9180F378D94;
	Mon, 11 May 2026 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKLAs8SQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1483A286881
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528945; cv=none; b=BwvYsG8ajIgwi1IElmfOFDqYeliN7Vr0qEwS6EhnvM7N8+J6xXjWldx5k5hYv7QNllzmusRvm+mQjs28BxOPINvFka/DwnvdW1YDdsq+8oAh/SjycXgHYPKg6FNBblz7vQVQTMLMXmfayx7L435dtJXz8sQLMwZ6CN7Jznks4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528945; c=relaxed/simple;
	bh=QHHzaIEonCbI1C5dXpKIlAYjdgalgcGFxXhTpOB8rKw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r95QzTixaP2lKFQffbXnmH98Pw8coYEbO7wZyH6D1GwC9G3Rm0yfl10lSLkdCWEoyvD2ScHvWtV19AYdtIlUl3+R0agc0aNmnkaBTLgyUJ1QJtHm5IsVwTEP6C8tMB+b/BlV0rLXTSMXKYQhN2e68QQq3vRfo3j7hsr8H91RZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKLAs8SQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bf1433b80cso32093067b3.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778528943; x=1779133743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUstqJlu3gWnJgtR+FhxyIiNP8zbdgleP0vcu3c2vng=;
        b=LKLAs8SQKiyUR4XUJjyiu7d6Wvjfle+/Ownp/MVmYtT3Kvd7uNAjz0/CkKUSOPSRsl
         uvqEK/HUs5SY8nJGHpaIBX6sZnnFrIzAErmmJqpJRvRmne6fyE95MCKDDadyn5DFbZMj
         Zw/vgnXld4zH+tv/F0z/Vmm7oZlIZze0IJ1qpybZfdYb6DPJEewHd90Q+NGeIBIPUotm
         NPJJgF3q3ybjm6d4EsqcUdHHr+gJ3yhARM3R6B40FmS+3DGy9NRB6V5g02wcgKULp8rl
         OlNbhV10n2QkOj1N9kqYhvZzQQfjZzNikW3vkoZhItUI1ALMp7VRx2tpX2YGi7MrMO/v
         TIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778528943; x=1779133743;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUstqJlu3gWnJgtR+FhxyIiNP8zbdgleP0vcu3c2vng=;
        b=orXY2+oWg2XQutMMS9YjespwpjLSojfKGcneH30hg8hWzlp6kGHCFKOOwE7CrCBorA
         HOSjHHXZlzMzgDRrjB2LpmblwpS1auNxUQ5lsPvl5WFYt+PfRkWRHPsxTS5vQb5EV0wO
         1ZCEb12mGnihou2F/eiseWJhifBKCJlNF+5rLPwVFhMXGzTRkiK7HX/Dcs2HdvVPiW2W
         KoQMvDKU8QmSWrW2g8Iw5vN9h1k1R3yk4PicNj/0/t3+M/vy6XMYjKrt7FvjN6kqEuC1
         VpwJH7PnPxHD/bbKFYjL3t014s4Pcf4wRa4XyjMhw4h7r0qtHDrnmKb8ABKBMpNnY9qy
         iufw==
X-Gm-Message-State: AOJu0Yw4GRMHk1hl6nYOIcmyoXs+IFoh/izpofIZACPd3t8BbYtGBP7s
	bBqWHATICrIUfqmrsfXGU8Rwzx6Y/DYsI65UQglBDX7cadv8Msomg04h
X-Gm-Gg: Acq92OFQLTe//R7aaOJXyyLl3XKVbGZxGT6F+tFuYLPODzpQNlc61W/HcrjApGjomLM
	F/e7w+MUq3XvoCocUAm8qJci9MEI4vFviXE50yx7j8HHZtE0YcejZftggTkUeXxXt1OSovbLsPA
	uzzB0BeAJsgyEtXqg4PUfjFxjtd9J15rWFRlou0QrDnI3qTJEA82Fj+9J/YzOGDOU1qHcHukCF8
	01LNafB7KLlODOQfIqVyYA8gYi4MCLqP8UOdXdt381madujBY/AVKmQq8vLyP0ZqyUdEl64qaKY
	vCtFsOLa5M2ktZiEKJ8AwTXxBJ2P7GjjItxE+dVE7fBnQKvHfeTGjfwSVNrsLlN7Il1cPB3NrtG
	4GbcPQ61bqvEO2I09Ay7HCLrJvHC4kYYTkA6m99Dp5gpUu0+JAnRMp/XSleXQlXtkett8KOUUWL
	UeYD4GmaechbtK5hbEwSkUruGceDG3XXo1d9rFMP30oqgSamy1mXIlSDsNN8B+npTytPyaKHZYN
	OGK
X-Received: by 2002:a05:690c:298:b0:7c4:86d:5e4b with SMTP id 00721157ae682-7c4086d6187mr37021717b3.41.1778528942944;
        Mon, 11 May 2026 12:49:02 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bed8946d5dsm73201827b3.14.2026.05.11.12.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:49:01 -0700 (PDT)
Date: Mon, 11 May 2026 15:49:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.36d2fcc3d2e74@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-4-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-4-4b50ed09b794@gmail.com>
Subject: Re: [PATCH net-next 4/6] netdevsim: psp: implement kdf from psp spec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9BFE9515411
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286813-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Daniel Zahka wrote:
> Implement the PSP key derivation function (KDF) per the PSP
> Architecture Spec.
> 
> The kdf is used to generate spi + session key pairs, and will also be

Text is a bit ambiguous here: the kdf does not generate the spi. It
derives a session key from the master key and spi.

> used in the rx path to re-derive the tx key used by the peer.
> 
> Also, remove support for psd->generation, as it is not needed for
> netdevsim after removing the fake authentication hack.

Is psd->generation only used inside driver code, not by the core PSP
stack? Else it should be set to !!(ns->psp.spi & PSP_SPI_KEY_PHASE) on
key rotation. If only used by the driver, no need to reset it on each
rotation.

> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

>  enum skb_drop_reason
>  nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns)
>  {
> @@ -155,7 +189,7 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
>  		  struct netlink_ext_ack *extack)
>  {
>  	struct netdevsim *ns = psd->drv_priv;
> -	int i;
> +	unsigned int phase;
>  
>  	if ((ns->psp.spi ^ (ns->psp.spi + 1)) & PSP_SPI_KEY_PHASE) {
>  		NL_SET_ERR_MSG(extack, "SPI space exhausted");
> @@ -163,9 +197,11 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
>  	}
>  
>  	assoc->spi = cpu_to_be32(++ns->psp.spi);
> -	assoc->key[0] = psd->generation;
> -	for (i = 1; i < PSP_MAX_KEY; i++)
> -		assoc->key[i] = ns->psp.spi + i;
> +	phase = !!(ns->psp.spi & PSP_SPI_KEY_PHASE);
> +
> +	/* dev_keys_lock not needed because of psd->lock */

Can you elaborate a bit?

Is dev_keys_lock only used to synchronize the writers, then? Which after
device init would only be concurrent invocations of nsim_key_rotate. But
that operation correctly also holds the device lock using
psp_device_get_locked.

> +	nsim_psp_derive_key(ns->psp.dev_keys[phase], assoc->spi, version,
> +			    assoc->key);
>  
>  	return 0;
>  }
> @@ -186,8 +222,15 @@ static int nsim_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
>  static int nsim_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *extack)
>  {
>  	struct netdevsim *ns = psd->drv_priv;
> +	unsigned int next_phase;
>  
> +	psd->generation = 0;
>  	ns->psp.spi = (ns->psp.spi & PSP_SPI_KEY_PHASE) ^ PSP_SPI_KEY_PHASE;
> +	next_phase = !!(ns->psp.spi & PSP_SPI_KEY_PHASE);
> +
> +	spin_lock_bh(&ns->psp.dev_keys_lock);
> +	get_random_bytes(ns->psp.dev_keys[next_phase], NSIM_PSP_DEV_KEY_SIZE);
> +	spin_unlock_bh(&ns->psp.dev_keys_lock);
>  
>  	return 0;
>  }
> @@ -295,6 +338,10 @@ int nsim_psp_init(struct netdevsim *ns)
>  	struct dentry *ddir = ns->nsim_dev_port->ddir;
>  	struct psp_dev *psd;
>  
> +	spin_lock_init(&ns->psp.dev_keys_lock);
> +	get_random_bytes(ns->psp.dev_keys[0], NSIM_PSP_DEV_KEY_SIZE);
> +	get_random_bytes(ns->psp.dev_keys[1], NSIM_PSP_DEV_KEY_SIZE);
> +
>  	psd = psp_dev_create(ns->netdev, &nsim_psp_ops, &nsim_psp_caps, ns);
>  	if (IS_ERR(psd))
>  		return PTR_ERR(psd);
> 
> -- 
> 2.52.0
> 



