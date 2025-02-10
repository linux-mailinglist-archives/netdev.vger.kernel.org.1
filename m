Return-Path: <netdev+bounces-164933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7ECA2FBEC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3083A336C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F301BC9F4;
	Mon, 10 Feb 2025 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjopnkVI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAA26462C
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222671; cv=none; b=IPygamDOeZpDuCI8W1wFstYOdL8vWa3qS7pKNbDaV4Y8fr19/XC6Ud+YKzdQ8hmLeb/by3cAzY54pPjt5jgqGccgYP+5XBvR0SdL/MtwI8YoAl3uMtYSKGEyAn6uiShra9TO1W2X9+R4+zdyqGJwhPOKOzHVIjNvHPsB2tehEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222671; c=relaxed/simple;
	bh=6eQPhG3VJDheP6tAMYzmie8tSLcoUiy8pym9u2SmCFg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZXqSFEChxgypsUAi6TmQehAMPzXHWgOFpr78bFyeoveKdJRjga5nUNUB9C2xR/3tYYB+RsiU73gtT1lebV6eWCCCZfSiZoS+64zp8QM0r7cEWRD6ifp5W2FCEKzVipmC1kRdBDLqsxZcds7xu4zdSauD1NFy1zrAl7FwsIOf5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjopnkVI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739222668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Scv1Scy0OfB/e4IvAqMPFoUY+utnkhHsPpWlS5lUy00=;
	b=AjopnkVIAdolccw1axwfVkLDZASgolsH9I76fzZuFLlu/HP/MWiqUoy6e1/AniBgMJZ9RP
	2R5iCsqJ3gsAKCxLbrr4AjebYrE+nmyYbUXHSbTRSyUASCbfXhq52SUF5d9BHish7NnyhP
	tPCX9tjBcQUrBDzMJYEyLiebo2oATO8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-IHtCW9hEMauJBPH5l2fnrA-1; Mon, 10 Feb 2025 16:24:27 -0500
X-MC-Unique: IHtCW9hEMauJBPH5l2fnrA-1
X-Mimecast-MFC-AGG-ID: IHtCW9hEMauJBPH5l2fnrA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38de0201875so648196f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 13:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739222666; x=1739827466;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Scv1Scy0OfB/e4IvAqMPFoUY+utnkhHsPpWlS5lUy00=;
        b=U11+ux3yPNypsUlGWxt4SFAY8DreTYRbAFDEGfECVAGtQZFbiipvX2G4bZojwqLmQ6
         S0fpJNMiFcti7hueshZKaEl/oSqLe2oD/t2JO+ExIZXa7P385hZIHGO+EiTBH00c9D3K
         DCM0bmKsL/CL8B+Uw/t02dUFEsqx56PELC4CnStZOI4hyAcu5OiGopp6SeFcFgtZgB/e
         ZPOAhq0jUe/YmDAPWrj7KwOpeRM/yAT6thxmgb3inTrzu9rRYKtkhegfcmKG56sdS39t
         6RmPHvZyjGcpzUdyUsv0vvmzeUTL0+i/9EU4XGJlQpj8ql/a+i3n3QsOkpoZTMmfsUHW
         fO2g==
X-Gm-Message-State: AOJu0Yw1k0jpVRbJoXDrNcrxvMVF2KlrGUc/LjyH4KnPgCO/S9QaGinJ
	5iMB2namt4UPgO4R0+8Q/Z5k/pxkmpMNvxEvX11z+iBvBYUOdPz2rj8+aBIixVh69q+NHTrMqK7
	h/u8NfnFuNCLEdtFzlp0zLIE/XOkx7+1wqaGuX4uOek5SSpU1sBQaPA==
X-Gm-Gg: ASbGncvOzwEHZz7X7oZyiQ7GILSyR43W86mrW3OUxz5vSvzyIuT9FM4WVEB1KIk1aic
	YAuQkSAF1fmcWoiY2XquP8phxvxhY6+okCz7Iu8iR7AnFMurEbQUc9W1c6Nm1PsL6FV+KQdcXl1
	NACxKgiQgL1ARy2e5G/hYmRyE+k4yqj/NiUPSuWVwoMhC6jhebPQdcSk9HRFEnkCvAxpvayIAKD
	fKtrUdHtQjV3XPFNk2rT35Bunf+ra5XamHPtrIXMK3oWWBAq391TWn12NYXDAoJDLFMb3/ocZPQ
	+8XgtKF6SHG8lhNGUQlBcG0dtWm/6gKJoEA=
X-Received: by 2002:a05:6000:2aa:b0:38d:daf3:be60 with SMTP id ffacd0b85a97d-38ddaf3c056mr7012422f8f.48.1739222665865;
        Mon, 10 Feb 2025 13:24:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG77JwtaWYjuudPYip25W42f2kDALEhijzqJd66hkg6PJCO81v+o/OJNYU9XkbxvbBADpLOw==
X-Received: by 2002:a05:6000:2aa:b0:38d:daf3:be60 with SMTP id ffacd0b85a97d-38ddaf3c056mr7012406f8f.48.1739222665518;
        Mon, 10 Feb 2025 13:24:25 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390db11200sm189853145e9.38.2025.02.10.13.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 13:24:24 -0800 (PST)
Message-ID: <0a7773a4-596d-4c14-9fbe-290faa1f8d01@redhat.com>
Date: Mon, 10 Feb 2025 22:24:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>
References: <cover.1738940816.git.pabeni@redhat.com>
 <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
 <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com>
 <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com>
Content-Language: en-US
In-Reply-To: <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 5:16 PM, Paolo Abeni wrote:
> I expect the change you propose would perform alike the RFC patches, but
> I'll try to do an explicit test later (and report here the results).

I ran my test on the sock layout change, and it gave the same (good)
results as the RFC. Note that such test uses a single socket receiver,
so it's not affected in any way by the eventual increase of touched
'struct sock' cachelines.

BTW it just occurred to me that if we could use another bit from
sk_flags, something alike the following (completely untested!!!) would
do, without changing the struct sock layout and without adding other
sock proto ops:

---
diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..a526db7f5c60 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -954,6 +954,7 @@ enum sock_flags {
 	SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
 	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
+	SOCK_TIMESTAMPING_ANY, /* sk_tsflags & TSFLAGS_ANY */
 };

 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL <<
SOCK_TIMESTAMPING_RX_SOFTWARE))
@@ -2665,12 +2666,12 @@ static inline void sock_recv_cmsgs(struct msghdr
*msg, struct sock *sk,
 #define FLAGS_RECV_CMSGS ((1UL << SOCK_RXQ_OVFL)			| \
 			   (1UL << SOCK_RCVTSTAMP)			| \
 			   (1UL << SOCK_RCVMARK)			|\
-			   (1UL << SOCK_RCVPRIORITY))
+			   (1UL << SOCK_RCVPRIORITY)			|\
+			   (1UL << SOCK_TIMESTAMPING_ANY))
 #define TSFLAGS_ANY	  (SOF_TIMESTAMPING_SOFTWARE			| \
 			   SOF_TIMESTAMPING_RAW_HARDWARE)

-	if (sk->sk_flags & FLAGS_RECV_CMSGS ||
-	    READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY)
+	if (sk->sk_flags & FLAGS_RECV_CMSGS)
 		__sock_recv_cmsgs(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e0..a197f0a0b878 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -938,6 +938,7 @@ int sock_set_timestamping(struct sock *sk, int optname,

 	WRITE_ONCE(sk->sk_tsflags, val);
 	sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
+	sock_valbool_flag(sk, SOCK_TIMESTAMPING_ANY, !!(val & TSFLAGS_ANY));

 	if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
 		sock_enable_timestamp(sk,

Cheers,

Paolo


