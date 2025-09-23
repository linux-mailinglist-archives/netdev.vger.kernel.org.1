Return-Path: <netdev+bounces-225558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66BCB95680
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7C02A15C2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2931D381;
	Tue, 23 Sep 2025 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkowXnC1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F22ECE86
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622460; cv=none; b=j8jSLSSKxIUzRkPNoqL3saNnaT2fDvoUoRY2XO6bRUGVX5k77lymAVwurssu+3DUV9sBS4aQ6kNaxalSImXftTx2VJlHCQCspO8cCzNZvPWzavhfd3eqSoUK03bkSho1wOqNeuWCUDe/DmoZsOpXQ0XAPHOjLqbFWa6FQrmePso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622460; c=relaxed/simple;
	bh=PB7RTh2tkmTB3/Z3OmF5DIITDSFcvCKR9iFhCuOZMCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZvM+ZKB3Wk4ZhGMbogvsp/rQMlRiq/+vBalEx42RMp2TX3HzlWpd1/ttOsMwOgKI6684UnBXFsGgdz5OH6u4eq8x+dOTTWoOBF1AJTA495nFwYEKag8n5oCHJyZaMdrKuXugS3O6R7PxMZKQl1u1l4tdsYgXDCo3QiRCGtWXPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkowXnC1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758622456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvoidjNPKx0LbqZQ6ZyfhvwOmvcCE/1oZtLmb8HEGok=;
	b=OkowXnC1OW0RKcegST2Ir2K+ZsPJ/CmhBLDL2jLRzey/+1DB6v1EsEX0skb8fWAz5tqCLD
	AzwkQ0I2Y2DprrESAs7g4neHEfBhox7PQTG63lM1kXtmsDXRL8zwCHTjL86nBJrtd/QLO+
	g9Ia7QjTVWcnKOlKVeWtf5XKWoID2DU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-jedmsNduOMWmDj_itgP0Dw-1; Tue, 23 Sep 2025 06:14:15 -0400
X-MC-Unique: jedmsNduOMWmDj_itgP0Dw-1
X-Mimecast-MFC-AGG-ID: jedmsNduOMWmDj_itgP0Dw_1758622454
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb604427fso29889295e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 03:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758622454; x=1759227254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvoidjNPKx0LbqZQ6ZyfhvwOmvcCE/1oZtLmb8HEGok=;
        b=LE4V1R64f5D/w//1Ao8MnTJii8Q07D4x4wf9YbVZH846lrxg6WNXWtybkAFGGGc5Kx
         Qgrqi0FmwSIrWhGlwObwJNGq1kg5X4MANAOhEcpFL4DFe6xVlnJdskjlpSAHZmG0VTu7
         I+kZhsOtfDlOCGhH2J8VAKvjIiiiy3MKAeZLjqXe3K4OtH8+8znPZa4Pi89GWdU5Xqx6
         QdEmES9w3Yd7vE41V4kX48pGDKZvMFq7REvZsdrz9wdCbSPDNJzjMAeUV6MAF4Rno7LH
         m1LkffxVcPn46bNolgFiiR14Z8WVJqqdMd+FxlNiMtTuCwNuABgQ5tJDsZEFUH4S37yO
         0kWw==
X-Forwarded-Encrypted: i=1; AJvYcCWxD+QHuNPx55ZPZj1MvGUvd/+Ly8dg+uekHcP7HzxPBmD9TynW049XlzDlvRP4cEbKankZxFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9IqPdv9aUt2pgBHazSsgjzk5dq+h7KLhFqI4zGh++0qVOhK2
	hiVEk3WQ7p5C5iXQK4tTKrUFss3qnlEeoppU7KH1lXJC3zOczNoeL8r2d8gHTEL7rsbkHeu0xMl
	42+rTcEy02qZ4DMopTpogJ21/V67D1BxOaE0vfNUvXLz9RItzljbBQA2k8g==
X-Gm-Gg: ASbGncvtsjEnjqU6PI5RPOqpgpw24EUqdsjQmIgtcA13l57ldNQbrTm3Ny7zynR2IT9
	1h+Mn6l1otVD9vpJOXHI8V1eO3GmzSo+vwS8zqLseq5zmm3A9LJhGaRHhulo46L9RAuvrEtvnot
	S9Ofa6TOBZRXFvwg2Q6SgOM+10/NQiT2g08bKQ9/4ACGZugHOhkwHjZ4UcewCybE0bmvL5bPUim
	/HU1NbwLaRcdcaeuc870vxwJTmHQxHmtfKhgaoYYe+0HEIU2kG06RVFDk5iAKGUbBU75Ub/JUfF
	QYJ8r2XCxz+tkpKlQxulwLme4Efh0utK2g+HC+M7v2R92dLP4jCiYqlWD6TqFgiluK01QZajYR3
	537e7fADOReXn
X-Received: by 2002:a05:600c:190e:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e1dab8219mr23578795e9.24.1758622454133;
        Tue, 23 Sep 2025 03:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfxcysg2CPLWO7CKaUjf7VjUD/s/qwqr1QLzNIPiHoxbXJnS5UWMoepWPmpljqyYqsxssm0w==
X-Received: by 2002:a05:600c:190e:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e1dab8219mr23578095e9.24.1758622453537;
        Tue, 23 Sep 2025 03:14:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-401d7fa1729sm5378032f8f.5.2025.09.23.03.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:14:13 -0700 (PDT)
Message-ID: <feca7414-31fc-4eb2-9b25-e8adc70c2394@redhat.com>
Date: Tue, 23 Sep 2025 12:14:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/14] tcp: accecn: handle unexpected AccECN
 negotiation feedback
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-7-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-7-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
> has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
> then receives a SYN/ACK with the currently reserved combination
> (AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
> combination, the Client MUST enable AccECN mode as if the SYN/ACK
> confirmed that the Server supported AccECN and as if it fed back that
> the IP-ECN field on the SYN had arrived unchanged.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This looks like a fix for an incorrect behavior introduced by a previous
AccECN patch. If so, please add a suitable fixes tag. We accept such
tags even for net-next material, and it's better to explicitly call out
needed fixes.

Thanks,

Paolo


