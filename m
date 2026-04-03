Return-Path: <netdev+bounces-274976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wESzEEmRz2lqxQYAu9opvQ
	(envelope-from <netdev+bounces-274976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:07:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18A393244
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD9F5303133D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA8B204C36;
	Fri,  3 Apr 2026 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVLkdo7p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4886243951
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210442; cv=none; b=JNl3JCaOmyft6bf3wxJC9RT0nYtuTZVxxWGmN/VyaN9dJWf2p9FLDDUERoNkahJwUI1/kwHG/LLXpc3Dvz4QyGURS7Kz1HvYfxSbMMHdxD+ZH46TI2hRHUZAK2b37u9y5OjpTh5tKgrT605hTd0x/4EvrIu3yNaNJs4pG4/6mG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210442; c=relaxed/simple;
	bh=u3wtL4yMDY+97XJDt1C1qZKie2I4mckMY85xtqF0VvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9ozdv0+mM1N1oi4tR/UX3PSq/cBFS0gxvG71CbT8JarLx14/dUPF7B7YL3Njpf00F34aGOAJ1PFDcyE0KEZTTfWeoevMgJrW3IWu3t+aFkfeg47QyrpdSFkNr0pguqYczt/J/MIA8jh+2o4noBX0QqVWxhIcMmKD4X2ehlLGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVLkdo7p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so17402265e9.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775210436; x=1775815236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p5XixUxCC27uL4fhvJqLess3RgiwpsA47qI4D+6Ayk=;
        b=RVLkdo7pQmhtWj1fWuUK6kMBw32GiV3SS0YuVJ0mTRdFmtQ8cMfkGbfwMvOsWvUosJ
         cBbsx4W9kyPG2wxxTCULHt9sIkkDd6cBZebJyBkzs/zzKxHYgGsn5ac7lMW/pmR5ulmR
         PC3NN+uAKB4N7yf5DE6BLlbkdzefW0gmqr2CnG06PudF4eUbydqoJ5obSydnXLd4kPtw
         ygEMuRCLo9Ng1/ciajnvJ7Ul6AWtRqdZjY1jFXkdCDWQ0gCxI/4viM8A/uHyH5Kyznw3
         6WlO81csB6njnrwP5V2pxntlVYenBMGkOXXCjjGWhX40f5pMrtRfWD2AO/hzdq+EqJuI
         khDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210436; x=1775815236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/p5XixUxCC27uL4fhvJqLess3RgiwpsA47qI4D+6Ayk=;
        b=WdQHrW2eIDA+A6r4lNMTcATeYFHVZA12yZkIg3ACvdfU/1rdGofNnaD990CbI/U5B0
         lXotT2m6mg6JI1Yy5Hczitj9z1myJMGrrWwcrTDGcaVadmTfOK2jYJ3lfV1LMuAE3p05
         T3KSmSOml4Lin7tO1yQHTf3K5hBk7n4frS8QFoSM1CbHVZ9OxzxC66kFsn9n3kVAZtvq
         W04L+AkRw9/rDM8JWNKpe2lLcf/PnL7goaw3rEjhAXthU3QCEMTbOjcT5uj7rLMQP7Km
         NSRuh7xIyIlzKeBEvq4KR4LDo5haBzWPOrik9ckBXVMpVAVLV6rpJmO1DMXF5vlsaaD/
         dtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQoR3ekdYF3tu+9SHoom37k8fy5312GxrqujPI2feo65Dp0GjRa9pX79RL+aLtZNeA7wbqtM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+bJj6TsI+ri5MApy/3OgQysMRUVTLfxZJcGQZ84yWESEsL8h
	m6yvZfOujsmwgxyfyA3v1xd1gkxQSsq6gWJXANt1UjzXBPDof7VX2Rs+
X-Gm-Gg: ATEYQzxdbaSbcbhBqL+D8DYGjpvsh8ShzvmOLL1v+75PZY8hXKg2KhDFc2BEdgn9UoZ
	PRU18fX2rs9aZIL5aKIMR2e8fSjKEhVoIRT3RvnKPKtB6a05F/gn2+1nBEPRHPDicvFBToMLsOT
	Jhkl2Kg5gBvlJAjlzyvwmZZppWZnDH/eLsfpYzTSSs3jS3LE8VrDXtvRatLKQ2N6Dvbo/c6apKv
	f+hQ1h+swuYdeLHNdfdikFyfseWykzylbtryv6eUKYw/zbqUJnw8mF8lMt3Jv0V2qgs0+Iex3mI
	jR6VFeahHeas0WVdXp962cY8fPXrGmE7+p0AYA9GAt2HTEHJguwkCvG+NABnReT/Z7EVgJJwLzU
	VBIOq0Nb5Ka5cnmxZwDQyuX9UyDzVRstOS3zkyJ1YQTzrYVnbFBqkfPKo6Y1SeCQ1Q12GTpP3wM
	ZQfrw6kpb0W8MgfLNroKyIdvwW9vA73jNXEf66LTYUgY2L0h4bKAMvytwWT6Sd
X-Received: by 2002:a05:600c:5292:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-488997a51b2mr37684005e9.22.1775210436221;
        Fri, 03 Apr 2026 03:00:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1b12bsm20958925e9.5.2026.04.03.03.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:00:35 -0700 (PDT)
Date: Fri, 3 Apr 2026 11:00:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ixgbe: fix integer overflow and wrong bit
 position in ixgbe_validate_rtr()
Message-ID: <20260403110034.6fe45f70@pumpkin>
In-Reply-To: <20260327073046.134085-10-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
	<20260327073046.134085-10-aleksandr.loktionov@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-274976-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 8F18A393244
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 08:30:44 +0100
Aleksandr Loktionov <aleksandr.loktionov@intel.com> wrote:

> Two bugs in the same loop in ixgbe_validate_rtr():
> 
> 1. When extracting 3-bit traffic class values from the IXGBE_RTRUP2TC
>    register the shifted value was assigned directly to a u8, silently
>    truncating any bits above bit 7.  Mask with IXGBE_RTRUP2TC_UP_MASK
>    before the assignment so only the intended 3 bits are kept.
> 
> 2. When clearing an out-of-bounds entry the mask was always shifted by
>    the fixed constant IXGBE_RTRUP2TC_UP_SHIFT (== 3), regardless of
>    which loop iteration was being processed.  This means only the entry
>    at bit position 3 was ever cleared; entries at bit positions 0, 6, 9,
>    ..., 21 were left unreset.  Use i * IXGBE_RTRUP2TC_UP_SHIFT to target
>    the correct field for each iteration.
> 
> Also replace the hardcoded 0x7 literal with the IXGBE_RTRUP2TC_UP_MASK
> constant for consistency with other parts of the driver.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 9aec66c..53b82a5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9798,11 +9798,12 @@ static void ixgbe_validate_rtr(struct ixgbe_adapter *adapter, u8 tc)
>  	rsave = reg;
>  
>  	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
> -		u8 up2tc = reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT);
> +		u8 up2tc = IXGBE_RTRUP2TC_UP_MASK &
> +			   (reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT));

That really ought to be the opposite way round: expr & constant.
Or add a second line to mask the value.

	David

>  
>  		/* If up2tc is out of bounds default to zero */
>  		if (up2tc > tc)
> -			reg &= ~(0x7 << IXGBE_RTRUP2TC_UP_SHIFT);
> +			reg &= ~(IXGBE_RTRUP2TC_UP_MASK << (i * IXGBE_RTRUP2TC_UP_SHIFT));
>  	}
>  
>  	if (reg != rsave)


