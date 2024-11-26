Return-Path: <netdev+bounces-147388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E0C9D95BA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F00C1639C8
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198D91C5799;
	Tue, 26 Nov 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbEw++6G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4311B21AD
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617708; cv=none; b=I6VJhbkUe7PYaaUlFYbsTYIvGgU14+RPHhxxEaAxqtBHOFzCbqibgUrlUMAJ/lNh5r9GGOHyUuxs3ywPblgHPZsmW9HE0Osvmcq4KDxRQQIsTc1GJ9eC7rasGyJ1wn66P7aJUN6LrlkQ9NfdipSRY03QfLit8CSB5YK0Bmx43pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617708; c=relaxed/simple;
	bh=SB9RVzpPrIASoDg3bpjPyfTi6AefWnYI0OM14bBB/fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvsFLhPMjlsxrYFBrmeo6JsBG8VIdMfTHf8sb4tcxHX72W5uXiBD50x2Tn7abPHdyElOharHsHPYwVnhqJLlwzyQWHiPxd8ik84xz4hPt2kX2v6ubRIbYAw6d0luB+pQVj8ZYAUJtkUZyJaxhQb1Lk65krhD++tbg6iUEF1TMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbEw++6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732617704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c10oVoNw574UgZa8BPhDkAjnTCWOGhdZy0d+349O0RI=;
	b=CbEw++6GfCNUNg0hBsfhibcJ1UFW09b/ND7GeAtrPsgZS/RQgtNBCdV84oKScIraKjmcVY
	hfw8YAtEEnucaxrE74VN0b2466404HV3ONkmvY2udGGfUMUjzVdYctWvsMt9AmGADy4atw
	nKtnqcv6XAAu8Hq/os4xz7ottzxaUqs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-4tG6uJShOtaibMNHC8PkBQ-1; Tue, 26 Nov 2024 05:41:42 -0500
X-MC-Unique: 4tG6uJShOtaibMNHC8PkBQ-1
X-Mimecast-MFC-AGG-ID: 4tG6uJShOtaibMNHC8PkBQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-382299520fdso3442249f8f.3
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 02:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732617701; x=1733222501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c10oVoNw574UgZa8BPhDkAjnTCWOGhdZy0d+349O0RI=;
        b=no+4hrWsZuz2TNTK8jAEUtQWAxiM6TJJWNGiUzW81XGkP3Lg5JbmavqJVglC0uDSO2
         Qc6A7ZZh60Bu5TxQZ+l0ncER1GL8AxtdZz+yk69z4JvEi8DW7ZRS1Tdhx9KtQiHN+BXS
         lo2r3YyGJgXzsgXkz9XAkcWjQdH3xId5XwF9jXYtzadLIk+0E5R67u9NtX269Hy8QGwb
         UW9TwKr4l684EYg5uFmlLVCopU4XzyciC5V+2VorqdzcRg8WsFFk+/0O/0jytQAZf8QP
         F5+mrtgEGLBvegUo+oxvkfEYaPuYWIZNlZkevIa65TPrbKrElDkJjus361GyGOh3/vLK
         qZvw==
X-Gm-Message-State: AOJu0YwfkSmd5igGlNjS/2L1CXqFLzPBz8GkhQPITowbP8XRLcIV2Ghk
	CD31rX8HHrPsFo6MS61ooHih+GdWcqPjgPZIQCs03GwA43VtRBIH879dh2cQ3NQnSkkJfGAwlUb
	ICoO1AkHvOU3b70+iaQL6eDl9Z3rqrUbfsemy3QCbxFkON3gU4OJaCg==
X-Gm-Gg: ASbGncttq9rWiokf1BQe57zUbMZ+rxxVVV0zqifeJvkzLjshkLq2qqQtoQU9CU8YWOc
	tE04jaXsbaqaXsM14q08U5lUXiSY3uZ1izFE701plet3q8UhEewlRi4wgVRRSyZMfWYLndkXj1+
	8S4nrr8ri81c08Qxm6W9P4DCz8hH3LB7QVojlY8xd0eA1FgEMPoDU1ppi1k6peHL+tdhFwh4IrV
	lSSlyT7yTendLB9LLfbgTypHCMz0GZIxp81zVC6cOImIf2jEmGB3Zmmm2eui17JnVmRoS2Rx/Xe
X-Received: by 2002:a5d:5f4b:0:b0:382:4a1b:16de with SMTP id ffacd0b85a97d-38260b6b627mr14762629f8f.21.1732617701354;
        Tue, 26 Nov 2024 02:41:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb5Dbp1esF0ba97VSbOBzEQDfodzxC6H9YqoKX1VC2tWE64+bs74QfkZMoN9Is771saUdIEg==
X-Received: by 2002:a5d:5f4b:0:b0:382:4a1b:16de with SMTP id ffacd0b85a97d-38260b6b627mr14762614f8f.21.1732617701055;
        Tue, 26 Nov 2024 02:41:41 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a0c889c5sm54013395e9.2.2024.11.26.02.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 02:41:40 -0800 (PST)
Message-ID: <1d7f6fbc-bc3c-4a21-b55e-80fcd575e618@redhat.com>
Date: Tue, 26 Nov 2024 11:41:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com, jacob.e.keller@intel.com
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/22/24 11:21, Parthiban Veerasooran wrote:
> There are two skb pointers to manage tx skb's enqueued from n/w stack.
> waiting_tx_skb pointer points to the tx skb which needs to be processed
> and ongoing_tx_skb pointer points to the tx skb which is being processed.
> 
> SPI thread prepares the tx data chunks from the tx skb pointed by the
> ongoing_tx_skb pointer. When the tx skb pointed by the ongoing_tx_skb is
> processed, the tx skb pointed by the waiting_tx_skb is assigned to
> ongoing_tx_skb and the waiting_tx_skb pointer is assigned with NULL.
> Whenever there is a new tx skb from n/w stack, it will be assigned to
> waiting_tx_skb pointer if it is NULL. Enqueuing and processing of a tx skb
> handled in two different threads.
> 
> Consider a scenario where the SPI thread processed an ongoing_tx_skb and
> it moves next tx skb from waiting_tx_skb pointer to ongoing_tx_skb pointer
> without doing any NULL check. At this time, if the waiting_tx_skb pointer
> is NULL then ongoing_tx_skb pointer is also assigned with NULL. After
> that, if a new tx skb is assigned to waiting_tx_skb pointer by the n/w
> stack and there is a chance to overwrite the tx skb pointer with NULL in
> the SPI thread. Finally one of the tx skb will be left as unhandled,
> resulting packet missing and memory leak.
> To overcome the above issue, protect the moving of tx skb reference from
> waiting_tx_skb pointer to ongoing_tx_skb pointer so that the other thread
> can't access the waiting_tx_skb pointer until the current thread completes
> moving the tx skb reference safely.

A mutex looks overkill. Why don't you use a spinlock? why locking only
one side (the writer) would be enough?

Could you please report the exact sequence of events in a time diagram
leading to the bug, something alike the following?

CPU0					CPU1
oa_tc6_start_xmit
 ...
					oa_tc6_spi_thread_handler
					 ...

Thanks,

Paolo


