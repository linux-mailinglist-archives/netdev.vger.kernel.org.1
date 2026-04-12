Return-Path: <netdev+bounces-277778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CjSTCVaC22lRCwkAu9opvQ
	(envelope-from <netdev+bounces-277778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 515203E3A7B
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BF00301456F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873E34AB00;
	Sun, 12 Apr 2026 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh9CIAp/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0CE3793DF
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775993407; cv=none; b=Z8MwWqayzYDCpDzzxkGiZ3pDw2idsBv5TjZuE9h5UWr8vtsknnGCVyTQ1DrSdC2vq+Op6d1jhbRovjmqCPhUCRo1oEZbuh5b5gSYfcNT3Ao2xZqHTGrA0TnQ1UwwmekDvjBsyRsN2TXTmknBdCWi6guFAIPabs973H7DtVQqkYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775993407; c=relaxed/simple;
	bh=bVLOIjrrUsUnbk1fhwzRyD1mIsunyx4T5oK8UP2HQxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9g1HrpTtVELZierda78p4qhZ7izB82XWxME1+iEHtC9S7vpdNDmUaA+6bXowGv+vR8CuYVXeZagktzYev4jiYo/1UT1mvezHy9/0OgcKj++toOVxANI2jUvWrEchvmTm8tveCXW3hGy3DaPfH7C9Tig20b9ABlRhQ0osfrC0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh9CIAp/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so24617385e9.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775993404; x=1776598204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwus+O9c1GdfyFp5uZba+e/DkD2g+5jrtF9z2A1ucdw=;
        b=Hh9CIAp/xoEby4xnmokJB9FKtNXCjIAqq4Caq8DB1IP/MOBJiSM7S2EMDRSfNmo20x
         AKdFto4zwhKi8pxVXWyFK9/9nYzmLdyWx5MP0pGDPF+wKyidAdRIJYWPwFLHp5LgCiti
         V76uEZNdxg3memsfFbtl+QBd2TgmQfWEgmRfpseVyCj0bXON0XCyY7t11oUTOVzTbXiW
         RrZDz8XnApKdO1eIhkpfVY1zMfgIuCssO7Af8K5CoCwYr6puf8EKCfR9eVA1dSYt1Hqm
         ebQJZm1EldKVjEWcWaJdjhJitd/DbSl9Ntnvtk36v+Ip+aLRTOxDY6zqYDVSdbkG+SRV
         uiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775993404; x=1776598204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwus+O9c1GdfyFp5uZba+e/DkD2g+5jrtF9z2A1ucdw=;
        b=KqI6vbdcE+e4SDOq0h7vMjrv/wBHYDZNsIMt7seL/1ESCJ926RIopGPZyORkmszWsu
         tz8fzcdPKTZaM3/jkMKJhnNk7Os201cAV65GCJUKaCA0c6zLhdAAnYcqXZ2Qx5DYURsD
         Dce0joPRCXjLOQ24VLAHhD/E4QfBKArSF9JaaKyDO5LId82qiWUiIMAJkSHxDH8EgHcQ
         XCipKjNHLaq0XdbzvuR5szBXQUTPK7BAH3lDQUiPkO+zciKa5DoucPufMEQEc1x0f7oh
         i26NNu29SjPpzt2+YrxOWvZohfdjBuHAddtxj5x09Fa6tt/ED1pGksWEcJCCa2DLJb4x
         k17A==
X-Forwarded-Encrypted: i=1; AJvYcCVO25iqx8jeO6ybZB3dPvz/5n1gf6TC/kuvoh53ms1zlRPNLRwcJr+zmkMrNoi5hAdNv3+yfNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Qb58nlise/lxaz1jUDmxnDe/LHVCPkKpI4KV7YHpDpIBAyG3
	hAbxOc17kXfCEwhdkyoOcYRe3TEcP8j4+TeNk0JzPZBKlp6WI9aN9JyS
X-Gm-Gg: AeBDievLNGGSMRVmukrW47CoQGPC2w2U8yMflclo5AlinCVmdYxhjpt+FlTaJiCrde1
	XzzHoSg+93QnHeTNgYWMGGbzVLbqCKgQzQhJ3hjE/KbrqLB2xstvMrRMm7RtIa4mak88wXaE8dC
	X1aLkUak1l+rCAiJ3svkagyc/g22l/uTVbSxJGT/wYrEsTahXO56mARtroG2M8gLOakYxN/GKu5
	LEItnejPB1Wu3pVjqP2AYVQuzI8dqOpvBFgujNx0RhFGEtGfsdNtuQ9dkQvEXU0HvyXbZwubtpP
	REJqEFlOuJFzi0HsGYA7Kamx2BYDZlm9XvxBf1eAyU8nHSLs0RqHs1R3TjvFXKl9Wy+rhxHqaqi
	0WOaw10EbdZPrZ7d/9kVGz4mo1mO6bP0hURnA0F8OyJkcEjWgbpXg4LBSv1wJJ1yjAyN/CDHOrA
	yzTeQDCSLc9qBxfOwEL3ZTDAVodoPFpMAJEmZA303aT4o1feioP+EH6jzyP2f0lYFjvoGsak27Q
	Vn1Hq4rIMQ75pJtPmTRlinAh3y0/seIoYSHDx7MiKzDfF/H3VTmSxq+ye33rhY=
X-Received: by 2002:a05:600c:450a:b0:488:a882:b7 with SMTP id 5b1f17b1804b1-488d6ad17e6mr125276955e9.29.1775993403889;
        Sun, 12 Apr 2026 04:30:03 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f46:8d00:509:2813:3a95:e5b2? (p200300ea8f468d00050928133a95e5b2.dip0.t-ipconnect.de. [2003:ea:8f46:8d00:509:2813:3a95:e5b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d53807d7sm330792645e9.10.2026.04.12.04.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 04:30:03 -0700 (PDT)
Message-ID: <d0e1bab5-3476-4b58-834c-6e742e89539d@gmail.com>
Date: Sun, 12 Apr 2026 13:30:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: Use napi_schedule_irqoff()
To: Matt Vollrath <tactii@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, nic_swsd@realtek.com
References: <20260412014031.525061-1-tactii@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260412014031.525061-1-tactii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 515203E3A7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12.04.2026 03:40, Matt Vollrath wrote:
> napi_schedule() masks hard interrupts while doing its work, which is
> redundant when called from an interrupt handler where hard interrupts
> are already masked. Use napi_schedule_irqoff() instead to bypass this
> redundant masking. This is an optimization.
> 
> Tested on a Lenovo RTL8168h/8111h.
> 
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..4c0ad0de3410 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4873,7 +4873,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		phy_mac_interrupt(tp->phydev);
>  
>  	rtl_irq_disable(tp);
> -	napi_schedule(&tp->napi);
> +	napi_schedule_irqoff(&tp->napi);
>  out:
>  	rtl_ack_events(tp, status);
>  

Not using napi_schedule_irqoff() here is intentional,
see 2734a24e6e5d18522fbf599135c59b82ec9b2c9e.


