Return-Path: <netdev+bounces-288663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMu1Jb3KCGr65QMAu9opvQ
	(envelope-from <netdev+bounces-288663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:51:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7C55D9AE
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A8C300B629
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E232135E92B;
	Sat, 16 May 2026 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoudwtUS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpAexbo0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A1433FE0F
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778961071; cv=none; b=QoYkP19C/IelqJ+dFOOZQbuFEkE7IM8tFfwqOIbsodFZgYYXT8JmuNDmkanGFCZeKypnPKdvmKuLBMz57flgJE3S9DNFdCXXbqTVlnedTkuGwoVfuDp8m2IdSOtDeiL+k+Zms6ILVlVtHMCROo/G504WBJk/YGdvunemTTwD8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778961071; c=relaxed/simple;
	bh=43rTd5Ene4yn+JpV190cGLWCjk9OHFEhtRmY94yzDUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfFnSyHY2hAyZ5u96n9vXH3wy26cYEpEDKkANdRcu9BedIN2T/XMGAWG+B9ori4EjFHdrGwbPiJ+tneUAvW/CH0y2KSEIoVkHos/dfuOT0nKsHOmrAPD29ZziwIbcwxosGfefVagd8siGdoYSeNSobAaAyw53w4nP40YTE9jbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JoudwtUS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpAexbo0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778961069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+go7CdOEQbP9DvPRJDpPQ1a5N5jS5xDIf88wkMzAO4E=;
	b=JoudwtUSAjnDZbdQzWn9gm4qX9yHpmZ3TLORkof0RX3jme5SVaarXkz7U/ZiEnIRxVW82H
	TclF0lchY6xTAmPlHyQMC6D/2BjGzWW6OhRblb52icqn0ckGgSGuXmobDxZFXaoO6nbcp3
	1PnggOw6vyq6qFfFZvFubV0BP4RUhHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-qA6mARTIMwqWKUTSmu9Iqw-1; Sat, 16 May 2026 15:51:07 -0400
X-MC-Unique: qA6mARTIMwqWKUTSmu9Iqw-1
X-Mimecast-MFC-AGG-ID: qA6mARTIMwqWKUTSmu9Iqw_1778961066
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fde68e420so9229905e9.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778961066; x=1779565866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+go7CdOEQbP9DvPRJDpPQ1a5N5jS5xDIf88wkMzAO4E=;
        b=PpAexbo0X/cp7ZLFo1K51itibwLrADqhktl1msWvHVNiY4/BT3vvcex6hG+Bzc4Ifo
         oOAnjSorcQfOsgj5BS6L0u7F3Saz7KqKEE1Y2idKjaQsYivg/wUNnklOZsDKjgBTnLj2
         fF8lLbp9v1XoHGcUuAh84UfUyaPXF/R9wB3y3a97e4oQgJysRZOigMP/8f7Us6kB8g5z
         kx1RXem3Mvd4Hlr7NOBmiSjCEz3YFRWeYy7JS+rsjFAJlvL85Yz5STT+B4RI+xUq1Kyu
         LVJ8K4QH1qXAp48vWRkg+4tfCOUJSA2Dp4kCmdUFG0PlAfYGH9Xd/DEDSb21aAG80i/x
         X6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778961066; x=1779565866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+go7CdOEQbP9DvPRJDpPQ1a5N5jS5xDIf88wkMzAO4E=;
        b=mZNQsxVNTsL1QJ4mWf1x+ZnXfSjby3LKUru85SK4SAwqLnZRO7AXYt2yrz5rtN9U35
         rbCgDu9IqNqTrLSY2K1PGlxARhk3PiphXJl+ERHJYFUxvrxsU3NR1K8IhmlM0He8/fRH
         C1OC2ICUfkh0lUcyKXPrRXkkHV8xER7AO1UHUroN35gZr9Vg7kMG0GmzRr+P3+SqPS2T
         jE5tq0QrIaSRj+AmuV44gTtzaywBvHQBgxaIwaql1TW75kpe0Yr3tynwBuQQTvTtBbic
         azTW0tBDVAw8Rer7Qde3GmNlYUAq+QYQpatdJ8J5UzNc4ZACu2ShOYIf14pOTrLKjlW6
         Dk9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/exKGoxmvhFQ59Ir98gXOtvT15PnBB03uUAZmsXsNlTCUOnx0UmFs+eGXmFerMdlBrCSi1tJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkgFCMdkUFWREcfmT9JiRsuc1PtKiJr23NZ/JuwygnV78Qi6y
	3FEv12MkzjAZu/q2BRflDC2P+/GyxKNlgOl4mLDSEJoXwgS0Ar/KtuNJrfs43yjJs+S+4yJWE6z
	08KJJYaUCJNxYVTKyD8ZCSA7NffpH5Oi22ADFRVRYlSFpvpSvfuQHo/veQQ==
X-Gm-Gg: Acq92OEjrf62eLY0H6tw9yGjcfLxR/pHrv6uSLtJ3QkALAXjG0zT42DkhiizQbOMQKx
	7v9CTxRegrCq2/FYz+1GfFrjSUTN0yL2e7myPRWLJnuAJNHvvqntDM1dg84w2MGNXO20nbweXOY
	STO3aTk1coz+9b6kXxAjLltawInSKkwj/VDyOrd1WY/WjU2E/sBoba9Qc8h62dPsBi9KaLE/etj
	7loE2BP1XBVTaabU5h1DIZpyZyTaux95am/G2r6DRCsmpO7dZuZ+g3B7J+dSDS6z5z64k/5sLA5
	fDlJgGXc5RgNt92kgmpCoQxO90L94GVnW0VrZXzINGkv0XYn1NgLK25IJoWMbu/+Cz53GI8VSBu
	/oU1Ms9RH3PDA8jamNeH0
X-Received: by 2002:a05:600c:6383:b0:488:c014:34da with SMTP id 5b1f17b1804b1-48fe651690fmr132556935e9.26.1778961066455;
        Sat, 16 May 2026 12:51:06 -0700 (PDT)
X-Received: by 2002:a05:600c:6383:b0:488:c014:34da with SMTP id 5b1f17b1804b1-48fe651690fmr132556695e9.26.1778961066062;
        Sat, 16 May 2026 12:51:06 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe74a53sm44211185e9.27.2026.05.16.12.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 12:51:04 -0700 (PDT)
Message-ID: <ec58f781-2492-4dbd-a509-77cdda3a85f0@redhat.com>
Date: Sat, 16 May 2026 21:51:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpll: zl3073x: fix memory leak on pin registration
 failure
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260515193956.351092-1-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260515193956.351092-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 05A7C55D9AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288663-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/15/26 21:39, Ivan Vecera wrote:
> If zl3073x_dpll_pin_register() fails, the allocated pin is not yet
> added to zldpll->pins list. The error path calls
> zl3073x_dpll_pins_unregister() which only iterates pins on the list,
> so the current pin is leaked. Free the pin before jumping to the error
> label.
>
> Fixes: 75a71ecc2412 ("dpll: zl3073x: Register DPLL devices and pins")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index c95e93ef3ab0..d6232aa371be 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -1563,8 +1563,10 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
>   		}
>   
>   		rc = zl3073x_dpll_pin_register(pin, index);
> -		if (rc)
> +		if (rc) {
> +			zl3073x_dpll_pin_free(pin);
>   			goto error;
> +		}
>   
>   		list_add(&pin->list, &zldpll->pins);
>   	}

Reviewed-by: Petr Oros <poros@redhat.com>



