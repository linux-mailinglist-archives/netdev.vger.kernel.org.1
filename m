Return-Path: <netdev+bounces-306331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HpE+GxrkT2pNpwIAu9opvQ
	(envelope-from <netdev+bounces-306331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:10:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A896C73424A
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:10:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ro7YFmc0;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306331-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306331-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6228305045D
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1B2AE78;
	Thu,  9 Jul 2026 18:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2944DB560
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 18:08:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620509; cv=none; b=mMBZzUG1WsH725i409yj4l2S4NcWoAS9F6EoRhaA+rT8x9psHyfXoUV4IBSWPCuGUfTkpqnw4vMi/+djbDo1n2bBzCI8ZW+HivpPNbqh5ftJBuqqDdEEVWNOO/7k1r69dZ18O1KrJjPvC/1UM9h8bO3E1Fqcs2mvU4UWSYlppa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620509; c=relaxed/simple;
	bh=EEtuaxTwR102JEh0ZC+x1Q8aBf5Sm3FTSQNJ5TVYLeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IwwmEB1R9TE31Zr7iHXp7gXEfajpbar17NtgNIZV1/QeTgrt8lV8Kkif/8ptS33Ye2SPjRRa5wmp36Ia6bR8Y7MMc/u1zcpQqnoRaFSJe/f51U+j7cB3R1pNMBH0EhCiOkcwEB0V3D3Sgfx5RkYZcj7S1azPgGbtlf6eSb6d6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro7YFmc0; arc=none smtp.client-ip=209.85.167.42
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b015b2d792so76083e87.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783620506; x=1784225306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJ/35sfI2w0o9nlJZmYbFh8MdV+S5eqHFuS7SPUgcX0=;
        b=Ro7YFmc0OzsHzmAKhOnPLdFzQy0Gi0TSr3fFi8kxDG5WXj6MX41OOyioUZFG7ad+F6
         M3geJOAteBkV4XfuXsB68ohRPyJEhBmgF3pKAJXioQkGzPzxgb2V9IwyqlPsnx0lSWml
         r7agGV7EokrpAmKdIrt47vaSL0y/3QsG3MDHll64nH36oNe8kC6Nx2afwHe+q5P+4EZi
         Bq4piMnGmwz7cBv8uMSYgTWA8f+xVIE7kHYfYYx9mSgKPY7jRO4x2TkqnHPf5NQiy9Dk
         uB+lsYA+Af5yxTGx69Z34EphdXUPav2xQOuRYiEF8yfe4qzc6DpIgrdAp/+YTa0kLkBY
         VlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783620506; x=1784225306;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJ/35sfI2w0o9nlJZmYbFh8MdV+S5eqHFuS7SPUgcX0=;
        b=E3Qxn0uPOT8B/Rfx68DMhtOSIxAxOmO8dKW8if9pk4arEq130C7OXq46kTUF9NcKTS
         +JZ+n3rL0getJA4g3qDo0XBDnE41T9Ia0ehIWjpx2XMqkWI8psf3UvxyQwGDQfWTc3kb
         9c+kjReF6aivgfO2zWYCKq/g6hhXPLb0p7Jlmfa0pb7G5fOLheKU9z0khEREL8Fits5h
         RXPQXApEi4UdFast7qjoUcfxeDK96vPgyiWoPeFGJ/ZtHi0WuGr8l7CPAyVVySFcpzyG
         6fZfQI4zdRoSlf+A4OeClvEjk0o/BEgekH0jl8D8HUyiQw9vuBHjsSLjURALkZsrCJlV
         vIVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5A65ywKN3VE3b8I0oduTBZ3AFqHepuWHFkcxIGjKpvDRfiPtl95CaFB/YxiWJSBfNqaN9CqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+IYcgnjlUxSrNLD3BGOTaC0lgS2cdqzq6DevDv1gZmYVsSc1
	94FU6gHSLCDEoD+j8eYufRZLOaXiY7NDeHVOZO9tDZv0NhjbpGTWpaau
X-Gm-Gg: AfdE7cn1WW3yKDudrqmx8FV5nl4spzWsC+4TUwu/xjBAyvdqwKTwaFnU7JFtVF5pl50
	IoOkTNiadRWJ3fPN1hksfJBvKr9vQqRPfSUw4QQcQGDyPsivmMHrKxxWIGKKExbnH9i4iFI2LAr
	HlGDLlpQjoWInmCjsPpXKMSE0h3XhfOexbRlzMrV2A+S25CPegsXdvuCJqNv/8rUNd6g6EmW2ZW
	mC1L5qjhmtKytZLZ4ON6H1uWzoSydAKj/0GD7YVm5DCtZiIKqAoTgeG0/MTSeLYXqmMENzqoBaS
	3aEpQxqMsdJSI2mJTrX+WjrkSOUaqauhL+rbinJCK/qiI9IigkrJ75PdNcGJruVeR8uzS5q8t5w
	ieNlIBU49tmu/SdJY+JnVoV/uwEf+DAckfhpZ6tiOU2GJDSFHcTlDS/pHEtffB7bt74WO34RTGS
	+m2q+Dv+PIxI/TYYnIY+b3r63ijoHU7ZLfWaToXIX/1E0klo1dyJ8W8CINlBuzUiTMRSNZQr1TA
	O5jCNut
X-Received: by 2002:a05:6512:6205:b0:5ae:bf95:38e7 with SMTP id 2adb3069b0e04-5b01141ebc1mr2157730e87.10.1783620505779;
        Thu, 09 Jul 2026 11:08:25 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:4643:94f5:446d:2b9e:c745:c7dd? ([2a00:1fa0:4643:94f5:446d:2b9e:c745:c7dd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4a38dsm13112e87.17.2026.07.09.11.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 11:08:25 -0700 (PDT)
Message-ID: <603ce94f-bd90-4abe-9f23-3bc92acce534@gmail.com>
Date: Thu, 9 Jul 2026 21:08:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 6/7] net: usb: remove dependencies on cdc_ether
To: Oliver Neukum <oneukum@suse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, manuelebner@mailbox.org
References: <20260709120116.1423033-1-oneukum@suse.com>
 <20260709120116.1423033-6-oneukum@suse.com>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260709120116.1423033-6-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sergeishtylyov@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oneukum@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manuelebner@mailbox.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergeishtylyov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A896C73424A

On 7/9/26 3:01 PM, Oliver Neukum wrote:

> Now that the driver no longer exports symbols to act
> as a library for other drivers other drivers don't
> depend on it. Remove the dependencies.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
> 
> v2:
> - added to allow removal of dependencies
> 
>  drivers/net/usb/Kconfig | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
> index da0f6a138f4f..622ff080218e 100644
> --- a/drivers/net/usb/Kconfig
> +++ b/drivers/net/usb/Kconfig
[...]> @@ -634,7 +631,7 @@ config USB_NET_AQC111
>  
>  config USB_RTL8153_ECM
>  	tristate
> -	depends on USB_NET_CDCETHER && (USB_RTL8152 || USB_RTL8152=n)
> +	depends on (USB_RTL8152 || USB_RTL8152=n)

   I think you could drop the parens, while at it...

[...]

MBR, Sergey


