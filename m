Return-Path: <netdev+bounces-236315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2854FC3AC50
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 13:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674D81AA5BDD
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A03319604;
	Thu,  6 Nov 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kz9m2Xjr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHLMlYjd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A7C30EF85
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430191; cv=none; b=p6KCp1W4C9yBoAwr/KzSN8NjkWuhTEU3x1UXLgCpOFT/2zAosSobS9v8iff5GRk8HEAM5ba4VndnoXSeN2JGNwEfe/UM2agkdNQ2r9Qr1hBHb7IgWZGlWXNPgGB1WLibDvMwiNgwrD1/5UXbO8tioZIkz8W4tOkgm0lnzuvZvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430191; c=relaxed/simple;
	bh=YeroezC/007S9WCZ1zjfYLqrdykQ/FoCz8WVrVp3klk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uxl1JiOOgjrq+FFzAzuKuqQddYUJX3uvEQSEDICsfTqf3qaiyIvcgLsOwhiBwia96ht0Z+CSqRpj8toXOo+/QzLgyUespeOiGZaV+Vp6ved5oiX9UmdU9/MUIJc9cWJyotuiuJaxmL5a6j4t5EEuUraHv4IQObt1ySKp/DOIvL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kz9m2Xjr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHLMlYjd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762430188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9le/TR6EJL7OtK2G5F8XjAJfAro4XHRnCrWtY3w0ANA=;
	b=Kz9m2Xjr1sKrbmsF7OIaIUdrHXTd6MU4xaWTJfiowSH0swnRQ35FmVOKaeFFCvqD2TYgX0
	d2FRUzndloPqPnXv3+2rH/4Vc99YY1tt1PVCRCqCtnFs9jpuzkjLDJQ7W7uhzIT6z6dEcl
	ohpBaCke5qoMLUQkXeCYk6F0GUbAq9I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-eGibYKDzPsCs3tj1yT3oFw-1; Thu, 06 Nov 2025 06:56:27 -0500
X-MC-Unique: eGibYKDzPsCs3tj1yT3oFw-1
X-Mimecast-MFC-AGG-ID: eGibYKDzPsCs3tj1yT3oFw_1762430186
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47769a0a13bso2018645e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762430186; x=1763034986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9le/TR6EJL7OtK2G5F8XjAJfAro4XHRnCrWtY3w0ANA=;
        b=PHLMlYjdxUBj6bWlLwLy3L+PAqdN/yWe5NFwfbr/v7b74jWR9C0c8uRC+RGNgKtdZO
         mDBQTBUzwU7mhVOLX9x/jgK8k9blURU6S+X82n1DRDLaosRW7m6/SLbcYfIz5ozAIk70
         Ygtr5s6fgN5rrZM3YQlU+1r5rs8rUPlTV3xV5Ft0m4qfWQAImYfXQAtQn6YTLNdRhkkl
         dCQy5hfiSjnrlfAII/EWMrdXAkQ7BUhQp7exFi3PlAyZ4MxG6DFTfpWK+nZe/X0ogRgw
         3I7jgWVG6qen5ZQvtpwME8mu7+VAQ+1sK/dRNGBPRYsRnGJn1FcJJ76KWQPhEHlADMJ8
         5OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430186; x=1763034986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9le/TR6EJL7OtK2G5F8XjAJfAro4XHRnCrWtY3w0ANA=;
        b=QilfYaTOujpXuQE7CMkGW5HDOrQlsQjs2NABIWT6JVsrgslvDbOf0q9TrPZAcY//PY
         UXgqW8zCfenHTTrcr74iUoH0rM2di2q9Eezl/lRi7Xh3iSxWM4pHsjPwdxTUEtKEk2s8
         PVpibvcKTIC6oWLtWWCKw/7ystlr6e1h1x+eSni2fsfDWFyDYEk+GjkQ7qLCvqvCcJ+Q
         orjvpwJHbFeO5mP+I7hNPzY0CrFF0vPdgcDSUTNNRWfrKS/p1cU/08UDtFRFumh2TGoX
         snW9+WeEOwi5wXxzIvbfcuHupXe3FFIX+H3t72R5s+MYNGNEIQXxUwxf6ZlKdBRIAZ2h
         Yu7w==
X-Forwarded-Encrypted: i=1; AJvYcCUd6X+RpxyX6/FRTHoYCBRxO39VavhKRhnThtPwmWTxFkS5X0eDOsn7Z34UFMFqDwVnGt4i4sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJY0SGA48+7m/MNiNFEInnoaqXAkDEfSXQE/tESM6brB0vJ6x
	8lrdzf+P/4GIq0+7Q1/GFsK+8CzRdqlN6RyGcgmf/410tgR4co3Jn/vWP4nX5QKNBn5nI6NjL/M
	m/DT/885zMHTX0huuGmXwuhJsMh/47IdRwKnORT7u0Wk/W2CutV6NMveo5w==
X-Gm-Gg: ASbGncsJJ994Kn0dREqBSDpOXu/vetsY3s8X+q3Gq+AqG2dCkGhLyCH2zzVS9FTGL9q
	c3PRO1DoNVaK/M6XeIXQh99jsFQVot8FTaQ7eT+g+EKXefRZI3pADNn96XZFyb3JLSKL+MVftde
	XItLK6LbIMoOTORvEHPOq/cLjQUFpXHuq485iGCVavprfTMJXJyG3R4cGOc3pM8Csi9ORd8kAnJ
	pS2s4yv1vVZXaijtpj0Dr6W+OucPFU017cJwWYZ+c/phvEqwSycaAOwXp9/ncRuCAMJIaimgiR3
	fc05HtLU/4WPKHRYC0WwQimphtIBTcn4Oa4Bff9oi3vSt4Crg4WTP2FObGevPgq/79AggzuNSR9
	mTA==
X-Received: by 2002:a05:600c:621a:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4775ce206f3mr53397985e9.33.1762430186378;
        Thu, 06 Nov 2025 03:56:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeNjObPV82BW3NmBnsDhrNmHHpx+fbtiOXZTi7CtBgVaPdD09D56F002RyajJ9jcqH6Y5d4w==
X-Received: by 2002:a05:600c:621a:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4775ce206f3mr53397525e9.33.1762430185911;
        Thu, 06 Nov 2025 03:56:25 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625eabf3sm55632995e9.16.2025.11.06.03.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:56:25 -0800 (PST)
Message-ID: <4eef8fe1-b2b8-47c8-a21a-bcb4b75c3a0e@redhat.com>
Date: Thu, 6 Nov 2025 12:56:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 09/14] tcp: move increment of num_retrans
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Before this patch, num_retrans = 0 for the first SYN/ACK and the first
> retransmitted SYN/ACK; however, an upcoming change will need to
> differentiate between those two conditions. 

AFAICS, send_synack is invoked with a NULL dst only on retransmissions.
Perhaps you could use that info instead? moving forward and backward a
counter is not so nice.

/P


