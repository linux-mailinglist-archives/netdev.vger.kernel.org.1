Return-Path: <netdev+bounces-206635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3662FB03D2E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D4E174638
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47075244696;
	Mon, 14 Jul 2025 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCo43i71"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046519AD48
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492017; cv=none; b=IpLgApNzjMP2xFMOD5uM3/ivEEoOUktGbgp2h2ymbMbC8YTdF8rei+iTHoHOLceyO1Y9hWwHryzdQuZxXPOw/PNSF/5KYut3Dh3Lr6N6lxNOJ3uT2qpo5M6IXjcVGVTMe8BhzAabf58/lAQIhlGO8R2Vsds52ao7+M1ValSiJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492017; c=relaxed/simple;
	bh=U+ABV2Z/K8FhS1tVsDtWSNLoxl2AP1Zy78uF8iTobqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h5e0EGXwMfjwUT53yKbM2EIz2NnlNyO7jKwftEIjzQiSq8esDmGR/g5mfmfePQW0La/iIySGnLXxzPs/R5FBbeSDl+QU6K6telUwvUTyosEhD36qqZGqppJ02c12ZYwKKQp0QielPf1vXtitG0+3bRDV/a9Z/00GYxW6sJ6t+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCo43i71; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752492013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y2GjFqzQOcWBUPguZ9USD97IUATEowPrFd5x574Jlc=;
	b=TCo43i71mxbIFTPT/vwzSGnUEtXb3Hjb3IMFYn40LP3/UAwGr6K87DzTxp0oOAmFl9kFk1
	NlwV8UxpB5h5APA2ZXySSL3XxSEfiF4IoWX1qbRRA84gXQDCY5A8KeQ+rTy6U4ejmhwrho
	le56Hs2AM2PXctT+f8WTI+lT0ZV3AJI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-C7NToHHNOAqiJr38uynuMQ-1; Mon, 14 Jul 2025 07:20:12 -0400
X-MC-Unique: C7NToHHNOAqiJr38uynuMQ-1
X-Mimecast-MFC-AGG-ID: C7NToHHNOAqiJr38uynuMQ_1752492011
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5780e8137so2792427f8f.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 04:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752492011; x=1753096811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y2GjFqzQOcWBUPguZ9USD97IUATEowPrFd5x574Jlc=;
        b=C0DQcJjcn4sT3B6KIBgwRVTvZq/743wdC8irtdmxWanHubpOAdL3Vcsbjc7CxlmSPm
         qrrQH9KurlA+kYYS7fxYcbbUrSdWIPFZLcaVOEr8vHripcOQ9PhqUYx2N7eR9qe+uVHW
         i/wSQSrBCNNTAahWCjAQIzRxbiB/6xStqBuKQR3H+4zk8LWytHhL0L0Ghxnv6k2TaQdg
         wLRQ3vEUyfj5DnS/Iv7x6A1eaHt8FnBtCefmQH/6uoN9VvNJi4gZSqoAfFbxDaGEtH/x
         IM8klMG4xbnoqsXrXy5M6xB7MWjXu53KKutzt1uu4ky5mRDVbrJ0jEgcDvZXVBrlJI9e
         z2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUide6qB6nAEOSQfy3OhgWM+PbXYTzTiFhJieIAy70c2jidFvZeZusEE1fVn2RvhP1ADbkkdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+L5PDubtKq66aEcVgxC/qy2z6Z0LEcWS8pH1GZDSAZQHOguS
	+LtQRFYrMnEss3JKAvQyT+IwUValvrbDyi1+/fMc4iDYjdXlJP2QYJg+B+03nSwayFzJ9n9aOlb
	Q4rMzwhRKyxKkEm6G8FgObqGk3Cq82ndG2+mFGSczxKmVSe839PJ3PV3h0A==
X-Gm-Gg: ASbGncuL3eeSQtcQS2FgYuDvPG2tCWWviL9XGrg31FjxWGn9b79YOJ/s9RGtC7q2mN5
	YO/q7XQpF40AcwU2Ddq8tbY2fRdsqmEfnmcwYINu0CD0D545aTPqQPcCfpMF0zKwnDYfyUR1yoL
	QiCoVsnC0R3Rg6pOeFMNiGM8U3/tY+MmYIimzwYGwURmlIoILp0hbgSSE+Sb6TcHjUGcbVB+lx7
	6b7gNhAx70Ot2pMAm/A55xUJoZKeHzMdym23488A4pxMTZKkBn+hht8ORxBKisREkRX9OrP5mk3
	6dGJ8cP3MmMhp5JaSs0zeNVHkmNZE7efEebfNs624GQ=
X-Received: by 2002:a05:6000:240e:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b5e7f13a0amr13230082f8f.12.1752492010670;
        Mon, 14 Jul 2025 04:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY5XrOya3yhJllGztjovrFQKpCxb10L3EkWzmPKdKNg7g1cHqucJ9l4yQULMvIkstPwMqvTQ==
X-Received: by 2002:a05:6000:240e:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b5e7f13a0amr13230053f8f.12.1752492010098;
        Mon, 14 Jul 2025 04:20:10 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm11984844f8f.22.2025.07.14.04.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 04:20:09 -0700 (PDT)
Message-ID: <b8f0ae48-b059-4137-9b74-f69c122f98f9@redhat.com>
Date: Mon, 14 Jul 2025 13:20:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 04/15] tcp: ecn functions in separated
 include file
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
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> The following patches will modify ECN helpers and add AccECN herlpers,
> and this patch moves the existing ones into a separated include file.
> 
> No functional changes.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


