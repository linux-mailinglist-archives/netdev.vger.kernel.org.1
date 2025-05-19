Return-Path: <netdev+bounces-191397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8841ABB62B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCABA175110
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA72676E9;
	Mon, 19 May 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOwuvj5c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2170267396
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639806; cv=none; b=ZbCUIB6yICkmb8X5erxCJwT7T+77luz6OkEeq8pk7Su1Fx3zQ3jeSV65/gsInClsC5mic3SBQOv/u+2iveNr4MWX/E4eNpMAaPaa2WlXe4cQ7CE2xM0NZ/J2dN/2l3V1WheRvcLP1Q5mLgQ8idj1s+ej7dXgws0/HSxSPg6PN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639806; c=relaxed/simple;
	bh=8DQrGW3fNond81i8XUM1ng5L2vDaVpermOep4R9MteE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTsvFmtdQGdsCJLpLyEs26Ln056C48vMZQPjm5KUtmkvzB6A43gVtJ6AwN5JIW1Mkj93UDtmSxixy5H6MPJFfWk8Ajqt4ZDc7VqhTiM7xnJcRBV/73hvVPG58Lq3SAyGPoIWOFX4elKSfh+4Ao4p/zlqveYRFjzkXuXnd0E2Tjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOwuvj5c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747639803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joHJ7VkBkFOgihuRaFy1ry6ubQhRRYbdaHEDufKQwd0=;
	b=XOwuvj5cvxrk7xqsCyQYZYYOE/Fm5CixgSiOfRPrCXA6qFKJ1hfBrFLvq0PLSubjd6FUeG
	heVGkl8eQ6ii2Bky12LmtdzzvkC/kqKBNzRwMDwl2i7mbIn5hoJxGoUicBo/dhsVnmcWQT
	lX2jfhU5sKBL/RTD1T7jzZ+SriOQP/A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-mnRXCct8MqyxKMMxjKUBIw-1; Mon, 19 May 2025 03:30:02 -0400
X-MC-Unique: mnRXCct8MqyxKMMxjKUBIw-1
X-Mimecast-MFC-AGG-ID: mnRXCct8MqyxKMMxjKUBIw_1747639801
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso21349595e9.3
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 00:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747639801; x=1748244601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joHJ7VkBkFOgihuRaFy1ry6ubQhRRYbdaHEDufKQwd0=;
        b=WSIg+FmcaUCMNCpblBKiYIX1wUxBgsuzue6vT7mcqaCGB69DQnUP3N3RYpKijHyABi
         LnjzCqUWdHCoxoKBXWjDv+12xQIstEbUacSTjSS9UVVZN0hkSb9ixa2Pp4S0rLhvAdkz
         BY1ydLDC+l4s2HSLVITRoJ0pYQ62oIHNBAuPGV8cNRlNc7ChNsUjeOHZKCcNNwFSODii
         TgUXEWEwagDekoSNbC3CQD52j4jhlqvbtTVF3QnaH34r4AWDfNW4OBKDqxZ6XIuHuVB4
         d8oKbVmp9COdZtu1T9K1IwekVvUIHAJW6EHE7eZcRc/55SXpYGnlCl8oZKMpRGLIuUZG
         jDFw==
X-Gm-Message-State: AOJu0YzxDhUI/Wm5GRbnBvcTVc/YCH1zdXc0LZ2eds8eEhSrI3s/vwx5
	Sk6qnbNTHhica8loNYs5H7ovyLxsIpt8vfZYK9ak3UUHG2pGAEGBdPnLO6gFFxo6Gp4Pf0DXPFg
	9arhWqqzlTJ/bfE9P/y8U/CWFBw8/Oz1SztXke4o2oRkqNcQqKaWyGI8uDA==
X-Gm-Gg: ASbGnctYYrlQEjZbmGhsHJFpTqTMcMfXXwsVkLW/j83dgiKGSBqgczmIY46ks32AaGM
	YZwvz5/KMNktOLsDT4bctdjfeDHzuC6J3qLLy5we+NQmYSsXnLqZENx2Fgo0psxaXlZPABr34Ht
	0XYz/k5D3QVZL+0QkgOnxOZkocf1fo8gWVWrKlMBJLlufMj8u7WvtjmQp82SSI8qJFsUxqd3Wmz
	wHJinqA9O1oRD9rkb6ENZBWzdGJfIZIusgfYntE0Garu/M4/RqDJvhZuArxcKpF0VjCTFpHJpvM
	7tZ1Dohsi+ipuvWNw8Q=
X-Received: by 2002:a05:600c:468a:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-442fefee29dmr92666365e9.11.1747639801118;
        Mon, 19 May 2025 00:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Y4WKeNu3TbKYtE/Els3B0YLR831MXjCS7lvm9kYztKB54r+MlAwo8fTOt0TbLPAwQD5Dqg==
X-Received: by 2002:a05:600c:468a:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-442fefee29dmr92666045e9.11.1747639800739;
        Mon, 19 May 2025 00:30:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f9053b4dsm156471475e9.4.2025.05.19.00.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 00:30:00 -0700 (PDT)
Message-ID: <71d0fbf8-00f7-4e0b-819d-d0b6efb01f03@redhat.com>
Date: Mon, 19 May 2025 09:29:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
To: Jakub Kicinski <kuba@kernel.org>, Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org, Guolin Yang <guolin.yang@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, open list <linux-kernel@vger.kernel.org>
References: <20250513210504.1866-1-ronak.doshi@broadcom.com>
 <20250515070250.7c277988@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250515070250.7c277988@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 4:02 PM, Jakub Kicinski wrote:
> On Tue, 13 May 2025 21:05:02 +0000 Ronak Doshi wrote:
>> +				skb->encapsulation = 1;
>>  			}
>>  			WARN_ON_ONCE(!(gdesc->rcd.tcp || gdesc->rcd.udp) &&
>>  				     !(le32_to_cpu(gdesc->dword[0]) &
>> @@ -1465,6 +1466,7 @@ vmxnet3_rx_csum(struct vmxnet3_adapter *adapter,
>>  			if ((le32_to_cpu(gdesc->dword[0]) &
>>  				     (1UL << VMXNET3_RCD_HDR_INNER_SHIFT))) {
>>  				skb->csum_level = 1;
>> +				skb->encapsulation = 1;
> 
> IIRC ->encapsulation means that ->inner.. fields are valid, no?
> And I don't see you setting any of these.
> 
> Paolo, please keep me honest, IIUC you have very recent and very
> relevant experience with virtio.

Yes. Specifically the GSO code expect the inner headers to be set,
otherwise the segmentation will yield quite wrong results.

Note that reproducing the issue requires a quite specific setup, i.e.
bridging (or tc redirecting) the ingress traffic from an
UDP-tunnel-HW-GRO enabled device into an egress device not supporting
tx-udp_tnl-segmentation.

If otherwise the traffic goes into the UDP tunnel rx path, such
processing will set the needed field correctly and no issue could/should
be observed AFAICS.

@Ronak: I think the problem pre-exists this specific patch, but since
you are fixing the relevant offload, I think it should be better to
address the problem now.

Thanks,

Paolo





