Return-Path: <netdev+bounces-222149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F158EB53437
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1874C5A0A13
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B532BF38;
	Thu, 11 Sep 2025 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KV6s2Kzg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9232ED5A
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598256; cv=none; b=FfiPn+8YTBqt2JQ3c8Wo+41CWbTOCdIJlz1Jv8Wer+QrWpTwT5nLxtySl2WCj06ryYyWHQhi6pD969Cjx4VuF4X/wQnJNCY/7iSEzPSFYHTivdC4ZnV1c2QUfSCC32EipWnWI7TJtg2QCw3KcM0rytcUtQIZesUT3eKUSRU3qM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598256; c=relaxed/simple;
	bh=HkAZ0Kt/yUdzEX45B/RZ/c/qMrt/pd3IhmoW9iBArws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCS06Yyb9LvTn8VJxR+mk7U60gOj3fBfwfgImXkVXMA0sjK9TZaiC/mAVb2W0dxxAflXYHgI4NKh81H/C3W8Dtombb75uQivnHA3rJbt6jt7mr/hijux3tr8RAI7/Y11cGYr06I8XV1k5QiXmXmHCDpSIz+0Rgkfkid+71SYGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KV6s2Kzg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757598252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwAjWrRN0pzT10Wjc1bUO1cYpYUDMP9nSIEO2gnNqs0=;
	b=KV6s2KzgOKbL5AIpB1DnWa1YyJKXRW6HB8Pm489Bcxokr4roTk3Cu97uKMY9T7ptFoD/8Q
	20nE9eCr89a0HKsKwx9FW83UnNMguuiB3CYAOkJtHQ2BZrEVdNLcps0k8GFyG5jqazA+fR
	TBGLvegVDkD2eFdVFsdTVVOGX8myNPc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-MxkEE5-TOretJYv5nXaX9g-1; Thu, 11 Sep 2025 09:44:11 -0400
X-MC-Unique: MxkEE5-TOretJYv5nXaX9g-1
X-Mimecast-MFC-AGG-ID: MxkEE5-TOretJYv5nXaX9g_1757598249
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb6d8f42bso8185165e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598249; x=1758203049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwAjWrRN0pzT10Wjc1bUO1cYpYUDMP9nSIEO2gnNqs0=;
        b=xHZ0RpVh3SXD9anN2f1BIpPb1V0KYhWAUKS0MXI7Da8TN4jwL6+21el0QY9+5mdoye
         CA3dYSz9IH7J7Z7vpYtP/9sLX9PDvEYlmn3nNtg0Ipz7iIWEx7FpM6dVMVIT1Uodw63B
         hPONHFR3K4e49gt+Q13zeICaed0IBjMnyU54iJ9H7VZ6suzmVOOoLfG2xLp0J8bj6TNX
         wgpqjLuO8jGD58kzaWcamYb2qqfK5ExOFdl1hpkjiKX84MMdt1iDfpy1E8OmR1r4FExo
         Qq0+RNlbFPJjtEcddOtzpnRpmNsRrMrUJegpO6lXmlMSxh0fGaEs10yHWc26pacY1LKR
         tZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCXMXcHIquxcihZ9LaBzB4yAFH2EJ6EYh0Cd8w9hLh39inYaGCsJgHlo6hEfksNn/3vZ7zQVb/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBlwUOsEFeeTibEVo6s7n9SLUxPm8wd4C1S97c+15BwvSKEXS
	dSkkTch38ygTUWcRC1yFc4nJuQT4W6fzpUny75sto2Qtpkq0NMeWZuEnUQvAAkIhyKkyZANNP97
	py1SWaknRrCjThCx9VCgzXwQD/Hn/Za6V4e2iSREQMYnk5u4znbDxpPeMfA==
X-Gm-Gg: ASbGncushr6lkdJBOTnrxLUjTAe4VCd7UjPU3llvSBLZ3qmLVyLPTJlHF3YacIDy1KU
	FhC0KuzdWN9zORXk6bxg9T4Hg8MKmC74BF1watKddn2oMsX2whQp9NzNMA8xAbWJrVtPM8rLikV
	DsRoLOpWZNNX81T5S5yStqBEkj6x4WtSlfbjeKd8jX2T142WskUP/2YuRcgTyzQlHua4wc7WFot
	AfQdxGUGklSmnx8pNZVwoXa6IWfbJSEhuVqa2gd9JQgPUURFpO8hKZcP3yNGxoknijrqy5xb7hK
	2Uo3o4k1pZEVsPeZfQRdg8VGWjZ2g1NMprvxH0uaE4w=
X-Received: by 2002:a05:600c:1384:b0:45b:47e1:ef69 with SMTP id 5b1f17b1804b1-45ddded4afamr186730855e9.36.1757598249050;
        Thu, 11 Sep 2025 06:44:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFnhOpPfJ248AG5aW6NkGVSvZN0QAAuNtu6V+wAMMZx6/yjbdiaJWKPBuTo80kpv+6pqSL1w==
X-Received: by 2002:a05:600c:1384:b0:45b:47e1:ef69 with SMTP id 5b1f17b1804b1-45ddded4afamr186730515e9.36.1757598248594;
        Thu, 11 Sep 2025 06:44:08 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078761asm2546122f8f.25.2025.09.11.06.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:44:08 -0700 (PDT)
Message-ID: <c0030cf4-a9b8-40a9-afdc-41de022517b0@redhat.com>
Date: Thu, 11 Sep 2025 15:44:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/19] net: psp: add socket security
 association code
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
 <20250911014735.118695-9-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911014735.118695-9-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 3:47 AM, Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add the ability to install PSP Rx and Tx crypto keys on TCP
> connections. Netlink ops are provided for both operations.
> Rx side combines allocating a new Rx key and installing it
> on the socket. Theoretically these are separate actions,
> but in practice they will always be used one after the
> other. We can add distinct "alloc" and "install" ops later.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


