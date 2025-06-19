Return-Path: <netdev+bounces-199399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA44AE0281
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FDF17BBBF
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3354C2206AC;
	Thu, 19 Jun 2025 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNeySb04"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECF2045B1
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328347; cv=none; b=GUUUIgt2fL3656Yd5XezRxPfHnjpT97NK0YYNeljB6ECfNMLD6q1GXe/Hlhl0+kYh8bNLZf2Fxq1TQLC95sUd12A/wyK3eLI/EOfnzVvgdmOXhBvMoN+Y4SKIV/O0oQe/nb2M1au7CrmUUeOr1/dwD1kELHIhjSAByW8u+IwUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328347; c=relaxed/simple;
	bh=QxcrWrDzmT5qDxiPBHVxDzd7eo9zaDZClalZxn6QmfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imdzP+9zkcxYaVpMcleCIcfgTJadeKwQPuqVYXKIOlPg9NfygnWRlVChobSukmBSS2C00fy/6sHfhwPDwH7SWlQRw3CopUgKlGgb7uQ7FYZpJDsws5k5ebMbSmzdDoiZoB/qqVZlW9pVYfjl9thMEf3zIVtQdsT40FpbI8hmnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNeySb04; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750328344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZMbkYrAFZZpSC6AKGt4y26Fx2Z7Ssey9c7q2T5AbSw=;
	b=PNeySb04Tu3ouAmpnjjci1P/TxBSYViyXNhO65VBtryonbHwhhOIpKfzLn1kzht1FLOzab
	C2ylBqDQf97Z9bqq+rnK3l248P5rKB7pcX3Ni/DuToZVIZB140CQrbzn5StIzH9D/jJPM+
	6wyesE//RqhojHq6c8/1BPAAOjkOl4I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-P6DMEe8aM2Sp_fADsZfaoQ-1; Thu, 19 Jun 2025 06:19:02 -0400
X-MC-Unique: P6DMEe8aM2Sp_fADsZfaoQ-1
X-Mimecast-MFC-AGG-ID: P6DMEe8aM2Sp_fADsZfaoQ_1750328342
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eed325461so3873125e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 03:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750328342; x=1750933142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZMbkYrAFZZpSC6AKGt4y26Fx2Z7Ssey9c7q2T5AbSw=;
        b=jOiBmomjRlds8OvR6TKJk3ACIR+QKU58eXKpapIIDM5OXBFwjv3dQsDPE0hBPcBQB9
         MXnVhwu9+XduRrBmhXQlvcz2Zovrrr8x7+7fQyKLRLHGCvr0Vi5wFjfErnci7DdS5zu3
         gocq6Onvb7jss0M4QFWOPm/X6nTTpIG40FOwKzaylQ0wEudp0ZTsMPavlMJYn/9sYOVb
         uQvyMsrOE09FRHY7LvHs/Bnt70O7ABbYroGQMVxZ9az6ROKIiI8sDf1af4WHEVfpfm4O
         sSqj3eNZtvp9dkugrRG0u8yhjmdMGN+EEhbOiJ9JVFJw+YNoQ4vnXBsNQ5Y3ifsa1J2m
         tORg==
X-Gm-Message-State: AOJu0YzHUVVqYf92xAOvQDdtYbRNxpu5GEOj+G+p4NTTti4Gyh3HP3b0
	hrgY/mchFrRUzVIfvKBk10d7y5mIwdiyDEaXPT7bqFzUvr2tKu+1h9HPlK0Oo+q4dxrFzweWa2P
	+6tgZt25oHEYCCuToF5pYa0kOLYwztOkIu0+f9z/3Mt0v/qH0GwgACJzNOA==
X-Gm-Gg: ASbGnctrxnQpUVblGh3/vzoCtpxx87iZCV1NRQmop4bTKRCj90JIygoCoPqdINDVGa6
	QFMGHdVTQu2cU5QS03qb6x13M2uziUh7hrH6cO6WY15vSuneAHvkCSWjZpNZUn0wcoLiQQeQe3f
	h/jhBcM3jw2Ddftn9Nihx2sLqv/2y/5eIAb64XVLOTL6uGzkt7oKYXCgkDNz3jMrdRAvaHCfU8d
	hi+5uIklAnRKtcfWMZd948+uzh6ZSHtTa3WqV57GzMz+pDqn33mOy2/sywqEECrjjlQu4Fq+jcC
	EVghJeqTQinwb8DebBsyIHgC6dL3hdBgRfiB9rETIsd1yEF8Ek1f7OHv9A3VEHAajkeQNw==
X-Received: by 2002:a05:600c:620b:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-4533cb4bea8mr184394685e9.23.1750328341597;
        Thu, 19 Jun 2025 03:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnVhS3wRcwd6OpwJYScQB2a2wa1s4YsVp6XXDYz8L0IyCHZ1AV8p90Y2WWj/9QGHID5MIX0A==
X-Received: by 2002:a05:600c:620b:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-4533cb4bea8mr184394385e9.23.1750328341187;
        Thu, 19 Jun 2025 03:19:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310:d5d8:c311:8743:3e10? ([2a0d:3344:271a:7310:d5d8:c311:8743:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535fdf82f9sm15075505e9.29.2025.06.19.03.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 03:18:59 -0700 (PDT)
Message-ID: <9ed6bff1-9210-4b2d-a897-2321316ac3b9@redhat.com>
Date: Thu, 19 Jun 2025 12:18:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] eth: fbnic: avoid double free when failing to DMA-map
 FW msg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, lee@trager.us, jacob.e.keller@intel.com,
 Alexander Duyck <alexanderduyck@fb.com>
References: <20250616195510.225819-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250616195510.225819-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 9:55 PM, Jakub Kicinski wrote:
> The semantics are that caller of fbnic_mbx_map_msg() retains
> the ownership of the message on error. 

FWIW, I think the opposite semantic would lead to simpler/smaller code
overall, but no objections to retain the current one.

/P


