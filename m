Return-Path: <netdev+bounces-307016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FWkHEHuHVGrNmwMAu9opvQ
	(envelope-from <netdev+bounces-307016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:36:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A1574790F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:36:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=AkpMLQIO;
	dkim=pass header.d=redhat.com header.s=google header.b=DQgKZSWL;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307016-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307016-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B9303004062
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C610381EA1;
	Mon, 13 Jul 2026 06:36:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8DA380FF5
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 06:36:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924596; cv=none; b=kC4IVZ68/XFslglLbXg2x+E0v/IBYmhhOKj7/lrKSHkWtCCrhl4hRtORnkBYUszh1EQ59b6rUjrNTl4xBiFwy8lY+2yf4zxxSCbWg2+qCf9b6ksa2xYDkVFGw0r587+kN//JWg/t1g6da62gvWimbxA7qe0z0AqcHnhMJFejEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924596; c=relaxed/simple;
	bh=Vc4u4HRzID6Fv2WL6ZDfoR80p9pWUurSOy7bn8WXlmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpCHCIfbPWoo+UMU6cI2P++mSyO+MC/p5y40Nc61ZV7G7mmWdyTA/5aFfSUGCDfeDmseCANm5IxsyMXItiX55Sr48iNLef681dwYluDdvrGYaA3o0ITZ21AYrc8QpCU0FY9TR4zXTTagYThZq/I0fIbASlEN4H/Z6gyIU4wjLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkpMLQIO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQgKZSWL; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783924593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K1nC1RCZXY372njdd6nbwpD+24kS6cgV1fUa231Xig0=;
	b=AkpMLQIOzwTctoJSqh8pKpvnnMGuca7koXPO8HDhG2KlnrmjO9/CiNaBtuRY3SGMIMJkFR
	8PMmZH9MdL9B4gMSXfPvi2mwb5WO841MbxTdGB0gtGG36KQ0DwHeYLv3AZNogCIZeeqFYt
	+u6uLNJYEeEcpFQ5ojL53kD7TDjk3E8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-pBs6iMuFMdSI8fxZ03Xi4A-1; Mon, 13 Jul 2026 02:36:32 -0400
X-MC-Unique: pBs6iMuFMdSI8fxZ03Xi4A-1
X-Mimecast-MFC-AGG-ID: pBs6iMuFMdSI8fxZ03Xi4A_1783924591
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4731a357b0aso2774713f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783924591; x=1784529391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1nC1RCZXY372njdd6nbwpD+24kS6cgV1fUa231Xig0=;
        b=DQgKZSWLgjF0FXWAGjuHGyOVtaTDLTDl6uEViDeH4E0gL3V9IXv/hLeQrVisuGkoeG
         m8zYa/81PePPbM8Fcooi9jC+Fg7Eimfm7gIdhTeWKAKTxWorufqoi6j5KJATAe1VdcmA
         FMcpzfhsktO6UtArvW15SymixQhgnZneUxh74oEP7+OpocOT5E+aA35U2t+oTwL08xBf
         EePfJTdO6dz5Q431Ae0RFNc4bYZB3qkamISd87DfEqgRG7SJDZ4zWWXWQrAAJyGlrpyJ
         j5N+F3n5ZTaJh/EEFiDPy4d40cyh5RNFhDpTnz6nkRwqXT28O3ua+ZV0/qBFetDxk9X1
         C8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783924591; x=1784529391;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1nC1RCZXY372njdd6nbwpD+24kS6cgV1fUa231Xig0=;
        b=TX9ABr8GAQM5Hes8fG4rwuelxCRBpdqSWHvpeQPpf6Xrdfi80yoAP7Eg9YTtfH3ynS
         CtcV/RGF/41MdvGUP+sgx56p+77GSEWVOo75mI6ESIBO1RGJy6vJBu7T1cZ1oYjQnibb
         u6gLAgqSq68Ow2s76T2CVxYudjkisY0xDzmWtDC/pNvwfOGd6mHsTuVNtHxVyUsRy+39
         ebyMNfAF/da6z6fKi7xIaiS8xztqswTnuYDEq8nyEe4osUY1ZqS3CUeP8s4E8Fkz/jV3
         1Uq67Ial/1WTTmeFYkwzrC7+lc3q5AkGc7BhmL0Pc2j/ZtMNYBzfAiRjlcpcU1QL2Zl8
         IlZA==
X-Gm-Message-State: AOJu0Yxj+0UxJkQyUX6xebdyM6BRekynbwzrdMJBB72xRHB4IJ1IgpLK
	0s7wyT5omYDUCcAJot9AAspj0lVZMctBDt5ETC8OLhO3pQOG/GZ4FQCm0/oPRc1XQS6FKS0Kdxr
	0yPwGnNlz8gsAi8HD2XmibXTAFjfMkuAwpDu373NpmPM1ZopdlgYSWN6t+w==
X-Gm-Gg: AfdE7ckOZ5IioA6+HdQeJzipuq3F2uzgd5yuKWnrUneV45WpvwGv7/oOnzXscD/yYEA
	xH5y7atisE/xryAQWAYkF8UIpXvrIPgR5Mt74pVnnb14Ezs16C1u+8Aifi9s0PAB3zrF8hlIKif
	RMZt01bXI/T/I6tgRokaRiDWqTDo0TOTn0rK7KCy9DzeQntZGv8nDNtb3RWODvxpbwM1nedrHVf
	cO2m+qRHyo0BaHkSSVmPucfoTx6xw4oGamJXc4E2Z6zXrLgbEf51L+xbeMsHP5RyJ/MU7zNOSg2
	jLlOWA4jhQQSFwXTxBRuAhV8viGtj0xUcHfrAU/DKR17m7a3uWRKNpxLE9+i5AL2x7UrejNFrQ6
	vxBq03Ljd
X-Received: by 2002:a05:600c:a14:b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-493f87e6c28mr82430005e9.14.1783924590850;
        Sun, 12 Jul 2026 23:36:30 -0700 (PDT)
X-Received: by 2002:a05:600c:a14:b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-493f87e6c28mr82429685e9.14.1783924590408;
        Sun, 12 Jul 2026 23:36:30 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2dad65fsm171802045e9.1.2026.07.12.23.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 23:36:28 -0700 (PDT)
Message-ID: <ab58f16b-f2b8-4d37-9db7-30c2482c4088@redhat.com>
Date: Mon, 13 Jul 2026 08:36:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: pcrypt - Remove pcrypt
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steffen Klassert <steffen.klassert@secunet.com>
References: <20260713032600.44355-1-ebiggers@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260713032600.44355-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307016-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:steffen.klassert@secunet.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[thuth@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thuth@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,narkive.com:url,stackexchange.com:url,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38A1574790F

On 13/07/2026 05.26, Eric Biggers wrote:
> pcrypt was originally intended to improve IPsec performance.  However,
> it's no longer useful for that.  Reports from the rare cases that anyone
> has actually tried to use it over the years indicate that it actually
> reduces IPsec performance, e.g.:
> 
> * https://github.com/libreswan/libreswan/wiki/Internals:-Cryptographic-Acceleration#obsoleted-ipsec-accelerations
> * https://users.strongswan.narkive.com/liqTaTq8/strongswan-problem-with-pcrypt
> * https://unix.stackexchange.com/questions/594336/ipsec-multithreading-via-pcrypt-worse-than-single-thread
> 
> It's also undocumented and quite difficult to actually use.  Its design
> is also broken, in that any unprivileged program can enable pcrypt
> systemwide at any time (by instantiating it using AF_ALG).
> 
> Meanwhile, pcrypt has been a regular source of bugs, including at least
> four that have received CVEs.
> 
> Let's just remove it.  No one seems to care about it anymore other than
> people looking for vulnerabilities.
> 
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting cryptodev/master
> 
>   Documentation/core-api/padata.rst           |   6 +-
>   MAINTAINERS                                 |   7 -
>   arch/loongarch/configs/loongson32_defconfig |   1 -
>   arch/loongarch/configs/loongson64_defconfig |   1 -
>   arch/s390/configs/debug_defconfig           |   1 -
>   arch/s390/configs/defconfig                 |   1 -
>   crypto/Kconfig                              |  10 -
>   crypto/Makefile                             |   1 -
>   crypto/pcrypt.c                             | 394 --------------------
>   include/crypto/pcrypt.h                     |  39 --
>   tools/crypto/tcrypt/tcrypt_speed_compare.py |   7 +-
>   11 files changed, 5 insertions(+), 463 deletions(-)
>   delete mode 100644 crypto/pcrypt.c
>   delete mode 100644 include/crypto/pcrypt.h

Thanks for the patch, I think it's a good idea!

> diff --git a/Documentation/core-api/padata.rst b/Documentation/core-api/padata.rst
> index 05b73c6c105f..b50df9768a5d 100644
> --- a/Documentation/core-api/padata.rst
> +++ b/Documentation/core-api/padata.rst
> @@ -55,9 +55,9 @@ processors are allowed to be used as the serialization callback processor.
>   cpumask specifies the new cpumask to use.
>   
>   There may be sysfs files for an instance's cpumasks.  For example, pcrypt's
> -live in /sys/kernel/pcrypt/<instance-name>.  Within an instance's directory
> -there are two files, parallel_cpumask and serial_cpumask, and either cpumask
> -may be changed by echoing a bitmask into the file, for example::
> +used to live in /sys/kernel/pcrypt/<instance-name>.  Within an instance's
> +directory there are two files, parallel_cpumask and serial_cpumask, and either
> +cpumask may be changed by echoing a bitmask into the file, for example::
>   
>       echo f > /sys/kernel/pcrypt/pencrypt/parallel_cpumask
I'd rather not keep examples for a non-existing sysfs entry around. Could 
you maybe change it to use e.g. /sys/devices/virtual/workqueue/cpumask instead?

  Thomas


