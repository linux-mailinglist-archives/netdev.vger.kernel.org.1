Return-Path: <netdev+bounces-161632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D28A22C90
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 12:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87B01672F9
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE5F1B4228;
	Thu, 30 Jan 2025 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNnZhTQr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CBB641
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738236865; cv=none; b=i6L+27zcu9JMzP2lBeC1XELwSzYSKPe6UqZriFdXxUoKHHQNmXepxj5wFCiD/1aV0N665pd9L42PTAhiBYXnkSYDvoClkqOFj2jcSay2bBxYTClOAjsz718Vy+KEmQNxl6YrWOrT5vAwW74QW53gfimDGfyhAqBZlqKl5FIaexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738236865; c=relaxed/simple;
	bh=KFnu8ilRLneYRXxS8LEvkL4i+coBbtCKTRmYf1kTUig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePRZA3jTgNkMKdR9uuKYnS1xY7sz0liygpLyjc4leT+yaMUgirO9+YQrjTvvOqqSjs3tP6ox5EDmGgUCLk21A69gUnL/wAuVGSUoOwRUZTYqryq92CnfaaZsMKjszwvr3RqnzrgK/4WcHKKOSu/rsZW284ORroe1cq8suIYEYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNnZhTQr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738236862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFnu8ilRLneYRXxS8LEvkL4i+coBbtCKTRmYf1kTUig=;
	b=RNnZhTQrUw5q+MOwVCHB3F0symkkoBNLvZmO29ukdIvmFsledSgtD/WP5PcZPtuKshM8Ya
	pWcY9HwONqiVRPv+ltufhyUD2eKxHsl5Oq7nfwMmwkxHCfiezgXNiXD947hy90g8ZzCaC/
	dzc/mcPBwCOI8V0ulaMcplnPVGSrpIE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-Qm7zLNDNMSqHE4IQJIE0ng-1; Thu, 30 Jan 2025 06:34:20 -0500
X-MC-Unique: Qm7zLNDNMSqHE4IQJIE0ng-1
X-Mimecast-MFC-AGG-ID: Qm7zLNDNMSqHE4IQJIE0ng
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43646b453bcso3329835e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 03:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738236860; x=1738841660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFnu8ilRLneYRXxS8LEvkL4i+coBbtCKTRmYf1kTUig=;
        b=nZcee0fStLkIaM098qc/flztTJlRwAif9bY04eyJBytTFm62kRtcyc8sGQL7In45Xe
         H4e2wUzzsbA+5U+VvPqYxNBLO+1FFpL2AbDmnMsn3AXwWIKL2kUtOyUKNkYv8XH4gbxA
         p3zvD1FyZQTZHbhBxhCEN8+r9rNgMQzGsx/XQdsQTypM8Bdqxz8fLlCTxCTcDQ2m403j
         YNHjB04DP1NriHGqN+C20nqUECeUW7B7Kuw4SgprFaH4B924VxGcxvleqvoIdyOulM87
         C8vDibtXk6/vjPO1jt6Edln+fW3LattzbZPUxwlmQZz6yFKh+Uyks+4TagPE1kXuZ7c8
         GycQ==
X-Gm-Message-State: AOJu0YxI99NcZrnhUIzTH4oZZEKW58i6APU1vMDNkRVHaig01dxqKdzj
	TKqOyGraS3vvKGDYJl18MEbRrAPrlouvegMekkmQYp/dhM53DiUy8VJb3wXvUCdcdXYchPaEBnl
	qjDavoN6bKbjiEActKtCrr8g6bixE06BedIQGdn5ajYbuyHm3X4hWew==
X-Gm-Gg: ASbGncuNt9jBJBnh0w8IlISi9N0nHrlXu/Vy8efiBhjY2P3Te/OwzjOtlA6Qsjvfuca
	1sQAAdc8lezSo9h9jCDFsxz4De9e8Ibfuxex+63iRigVELWQEPA/DnRl4yTE64Zyg9TfeiEUWi/
	qOTLIw2Me1rEA3+Rn/D5WOIC8rswpwm+3TK85qlR8/uRANUTymRGPN4Fy4WdhyZfYDWpF0PRAKc
	V5uzmyL6hjpqfzNciyTjPBSPwzEbTW3SsKGYfinK0nj6nAKZFQOEKOn68I4E8k7qR5QOrgVGJ+Z
	rIUhZm/gyLdEjyxAHYK9pJZLmVI9H+F9TCc=
X-Received: by 2002:a05:600c:4e09:b0:436:1c04:aa8e with SMTP id 5b1f17b1804b1-438dc3c8200mr65751185e9.16.1738236859747;
        Thu, 30 Jan 2025 03:34:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMOqkFVgkJT/N9OpRP+8HABFoiEk2Tp/MthEnnxk+Zun7kdDXSutwKQEKdZQj52UWwmCVQtA==
X-Received: by 2002:a05:600c:4e09:b0:436:1c04:aa8e with SMTP id 5b1f17b1804b1-438dc3c8200mr65750975e9.16.1738236859415;
        Thu, 30 Jan 2025 03:34:19 -0800 (PST)
Received: from [192.168.88.253] (146-241-12-107.dyn.eolo.it. [146.241.12.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc81941sm55568625e9.36.2025.01.30.03.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 03:34:18 -0800 (PST)
Message-ID: <21027e9a-60f1-4d4b-a09d-9d74f6a692e5@redhat.com>
Date: Thu, 30 Jan 2025 12:34:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, dsahern@kernel.org, justin.iurman@uliege.be
References: <20250130031519.2716843-1-kuba@kernel.org>
 <20250130031519.2716843-2-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250130031519.2716843-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/30/25 4:15 AM, Jakub Kicinski wrote:
> Some lwtunnels have a dst cache for post-transformation dst.
> If the packet destination did not change we may end up recording
> a reference to the lwtunnel in its own cache, and the lwtunnel
> state will never be freed.

The series LGTM, but I'm wondering if we can't have a similar loop for
input lwt?

Thanks,

Paolo


