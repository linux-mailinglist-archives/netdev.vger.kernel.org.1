Return-Path: <netdev+bounces-237528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61746C4CDAB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 967284EC34C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3002EDD51;
	Tue, 11 Nov 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbZM9Qzx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKJh887p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40CD263F49
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855021; cv=none; b=V7YKsjzsnOV58lZs3eH627thdnAmAn6uNjEAOXe0RUQ0aC66BYxXHzK9pvgx1VCkAslhwnvd3LAex2lQ2AxCTnp98X0AvWDA3u3xio5jkZFWjBXf+nNeMmcEH4z3oDZ2v3webXZDICOofEoKuj4tqLdhd5RVj4/3OkNuNeVCmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855021; c=relaxed/simple;
	bh=l12ymeNTzARVxKjN4MzfmoUUlxp3V7+nqfamuhDOwq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaPTudM/kRjwNJuc/PVQOYBnexMDDqaKVwpNgPgrXvgq8Fdcy+RtwyUh4/ko+lvBG/vWSAuWTJvlRL8ZUbP9g1K5qugtNWsjYHKSVs8LonKXLqZYWtYebgeG51X+blwQxtQQXgfg5wnKe6AbmMn5w33jkyhiEmB2pnihaJJ3ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbZM9Qzx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKJh887p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762855018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l12ymeNTzARVxKjN4MzfmoUUlxp3V7+nqfamuhDOwq4=;
	b=RbZM9QzxZf4zYdp3X3Umun0SI/mfWB3RV14UP2/hxsRxoq+tORTpwp1v2E6h3ISx7w+HUF
	VMI/N8P4wLl4tomWjiQNR9WVlLJgsi7xEPuvY+tvyLzAeTJZCuLrk58ErPpxdNKAY6X/BU
	RcrBPBCZbm+t14p8Sj8DWuoDOPDcjBg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-PMZYAsnZO5m27JxTDZnACQ-1; Tue, 11 Nov 2025 04:56:55 -0500
X-MC-Unique: PMZYAsnZO5m27JxTDZnACQ-1
X-Mimecast-MFC-AGG-ID: PMZYAsnZO5m27JxTDZnACQ_1762855014
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cbd8299cso1463363f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762855014; x=1763459814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l12ymeNTzARVxKjN4MzfmoUUlxp3V7+nqfamuhDOwq4=;
        b=HKJh887pb0y5zQGvpdTenR+eDwekIPcvn+rEcF7ITyZjYisaleZfdprSj1fkQU5srL
         b2No6lzbv6+RiOa0UdRtU5jFMFjfTzLz76pvDFmWO0G6J5NZqgLBSpGeA937kl5bH+Jf
         dLc/B5WmBvWD0sq3LIbo/trsuRaC0YvbDOG5Wz1btKDHo5u60YQYMaXJPE0XWtHqd2zm
         U8zuDKFBK5dHHXANMfQbNIS6TdMqgVgi6KowBb43mm/dRRye7My3OFU5StdnHS40tfLX
         fV1W8mlY55mIoQqHr4NdKLsx3lKLrS0b4+Ji/fzwEOVJwPNploEmc/Md+Qvj3ZQYWNd2
         qqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855014; x=1763459814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l12ymeNTzARVxKjN4MzfmoUUlxp3V7+nqfamuhDOwq4=;
        b=QDSjI4cZ571jvTroxlYcHz6w5rDJehUFcqCJbGWDjT/otpPcmOS6oiASfmZOwUk7j3
         HHDxR02JNYU9YzvospCMbCChxZ+TQAcPZ/hr+ckoWf0sGfof5RFuqjdRvw4yZyHduBVQ
         g1i0YSqRext6E6Mic7z6NgiaiPzhIwhhZlsFD44jR+6Z/612EFniUKdbZb7U5Na71QBD
         VC3qKfcsSMLPH5K4Q28O8PxfGp2d+3Yy/jAZcH5RdWSxucTaHJEY9GjHSi9zvVXLhcsd
         yeontdOGwRY91S7/yrLK3yyEHaj3GiuIT7r1Tw3owmKAPk7+b8fWH1PHQKkVdaH0HdHu
         2Hkg==
X-Forwarded-Encrypted: i=1; AJvYcCVRXNaewV6S1AGZvJr5pnRljTmJn964YgVQfMNQEf1T0FWrSBgFM3bJREHlKmr8/hnxcUES4pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMCvDbNXytgqo5ykPmX2+xfbO3SrBwHBfiSTNiJLv+Zcj+Xsd
	NR8JksOR4G0i0GPPDJyl1rLBgALjwIOqxYH/e2iGiKuPUmMK3nlrAMnkCOHkKFWkKaXLqJuxIrI
	T8dujQNCr4ZOBm1YO3z3c+2Quy1F9d2BPHBpuWV8NhS4fiKc7RdhS4mafMQ==
X-Gm-Gg: ASbGncvKOkxsSd1G11xhBq/ndYlOUJCvZOmrxn4xoVjCSfhH3QeSa0FXOhZvnWQihRF
	v9SrA4Lzy0T6tOnaLvi7wDJs6Y8pHbbalZ6c07FvQ7I+uQFTJgEVsm9g9wXMqmkj16v/PFrlPEe
	0VeM6/mQc6KP1P8JtUpZM4SeulhVdrzRb2Q5UmeXKJ3RgjbR+zWBCnJEFQjAeGFbQh/zJ7DVE+s
	B90EyCeJLj7WqBz5gxLqv+dAI8xr7Tye2pJ6ZFQ//JbjGCJ2pn2vvWw5D0caH7UcM1EfjbLyxqJ
	X1bsg9gJ5t4FcIiXSskaij3HfOaCyfmanYYxgm3xojfhsjZmkCEdLpfIAm/GoFDx5MF20QDf+Cd
	0jA==
X-Received: by 2002:a05:6000:2c13:b0:42b:3339:c7ff with SMTP id ffacd0b85a97d-42b3339ca1dmr7021894f8f.43.1762855014108;
        Tue, 11 Nov 2025 01:56:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnnCrUXz3DU7xyZSDIRUUb4v/RhdNRZA/rYxNXOFVm8SbOAfq48ykMbLva4Fw0QZMa7yA9Vw==
X-Received: by 2002:a05:6000:2c13:b0:42b:3339:c7ff with SMTP id ffacd0b85a97d-42b3339ca1dmr7021869f8f.43.1762855013763;
        Tue, 11 Nov 2025 01:56:53 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b330f6899sm15561233f8f.21.2025.11.11.01.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 01:56:53 -0800 (PST)
Message-ID: <8d27a7f9-0443-4c9e-9b7c-d98ba2ae450c@redhat.com>
Date: Tue, 11 Nov 2025 10:56:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v2 3/4] net/ipv6: use ipv6_fl_get_saddr in
 output
To: David Lamparter <equinox@diac24.net>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>, Patrick Rohr <prohr@google.com>
References: <20251104144824.19648-1-equinox@diac24.net>
 <20251104144824.19648-4-equinox@diac24.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251104144824.19648-4-equinox@diac24.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 3:48 PM, David Lamparter wrote:
> Flatten ip6_route_get_saddr() into ip6_dst_lookup_tail (which really
> just means handling fib6_prefsrc), and then replace ipv6_dev_get_saddr
> with ipv6_fl_get_saddr to pass down the flow information.

What about replacing directly the call in ip6_route_get_saddr()? It
should make the patch (and series) smaller and more easily reviewable.

Since `daddr` is a always derived from `fl6` and `prefs` from `sk`, the
total number of argument will not increase.

/P


