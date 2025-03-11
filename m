Return-Path: <netdev+bounces-173986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36EDA5CC59
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619C01893023
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D631E2620FB;
	Tue, 11 Mar 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijkfF3jN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7A260A3A
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714681; cv=none; b=CwDUOK4eEd6TTr94eCQYf1GL1Ji5rTV3kg2Q2WiK/uHfdqhVg3rw/Gdp1JqeXP98lEWhxQFW9+WalqMn3UfZq7nn5ggkaoAWKj4PG9hPqxV5zi82sseTMCT6/Lghcux1QBsNdVHAFa3FHebsL6ALapksMCDeFbdqcRG2zBaILLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714681; c=relaxed/simple;
	bh=M9lQsVkFtQZYKlU1EOuksm+fbdEirumVV9qUrZ6Xu24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLVyCvGkXnWbXycAB9aPjfALXuRmMYwNyzt8dFVg8dcgiaEc1Xi2RMzSRh3FzTpQc1NrLWDod0m1/LHGxXkOoa/P+mePiWbiXTPNiJfqPrcun+VUqWMiOS4+VAeK/2cw8YxlVWWiD0jDAajgCBaJI0dMgYCRZ+hWpqQ8WHRsrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijkfF3jN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741714679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cboLsX3HODyXqMOT09ab35ClTZdo8T6zuqQCaZF5L4=;
	b=ijkfF3jNa0vWPDFNe33sp9ND1cRb+9eLgr2TN2MtPKd1UXXLBmRdYDPxJy6cRHpMHQPXuY
	aSvLcr4WhXL1YV0xC/zOvL6S7EaU0v6roiyY0G3Ya1FdeZtljxTa9IVMYqgA8V0HN6A3rT
	ozARDRxb2HPTDCn3KCWnBOC/NBZt4uo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-AHGkcVZ2O4mDGn9tW1BpyA-1; Tue, 11 Mar 2025 13:37:57 -0400
X-MC-Unique: AHGkcVZ2O4mDGn9tW1BpyA-1
X-Mimecast-MFC-AGG-ID: AHGkcVZ2O4mDGn9tW1BpyA_1741714677
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912539665cso24441f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 10:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714676; x=1742319476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cboLsX3HODyXqMOT09ab35ClTZdo8T6zuqQCaZF5L4=;
        b=DcUIro6PJpWkZmmTCczMEjiB2RUYK1XGbNIeAKYWxHlOgi2V69rOSujmN4izcnMbey
         YzrI+LDKg0c6yg5DzCLHIGBZvKn5+n1e2R5JiK8U5HSdas8Hj+ELNh40Mz9gXlFLRGbO
         RbTZrLSooBquRrHbmhH+vwE9jsntdZ/B0yueIxm7W500RIEdXxkqY1Q4ZOCoW4vbqSMS
         cqzewDSQCncKaQniMgm5nilNPn23r/qCe1o6rHpPsFochfeLdpvrlli/tfrIiPRn7fww
         Mq3KTYITYRusdzgTVuJg9h+2tIQDaSMMcP2GgwfFZanrrKxpaDq8KfG752MrSp00aAXt
         tR/A==
X-Forwarded-Encrypted: i=1; AJvYcCXTUyr3T8PiMB/vGaCVcGFPqzEMi54IzGwKdf1aQud1X/dO6jzomjVzvkes6yKyrBnXJiMQJso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlMI0qnAlosBqWmiW6NMsjW2XlXtJuVlZx3ffz4NLxO7RNfpjR
	Cb1NuPitTrlzV+DqpUTf/vprRYDAioyDJRrliwb3W58+RoXoM67Es2ePlWrP5R2q2gJdl9HWxPh
	YB4pGwhhKIYUiLUYcnmjIDLKvvZuzNc2RvqExT8/PLK4pY+8/V/ioEw==
X-Gm-Gg: ASbGncvgjrW9slNjfWMTVwuCRGogpeD6IugNjP06EforK0AE4ujhBAgWS+7g8MnpUp2
	VuhLhcj0sX/STi7i7w57dAkoobFAfqzdE5YW+TEvdnWFzQBLof/R5pKCgNvLo4xXmY0WzGpZFBE
	bz8OwCOxS8MB/rxTaWNrxjs7yJmFn+FDGQ5I83rM+KMQzLx+hqz2YjCBOkVfNowM5TX0LkF9lWV
	SpuPw08v0S9U8XkfYTuXlxxApidzzbld4gWIK1hJCaXi5kj42x/50ObtF2ciBFDYsEVsk+VUqij
	NCAnmQ7qdPJCNzDpe2RA+o/EdZNSzappvBNfnbhHXk0ziw==
X-Received: by 2002:a5d:6dac:0:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3926c5a55bcmr5392139f8f.8.1741714676671;
        Tue, 11 Mar 2025 10:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKeXmCLqvTrWNDOQNMUWuaCunGzzpC6RjB3RED6mtt5hY3Qa6WYncS34lhINb/m6afETcwWQ==
X-Received: by 2002:a5d:6dac:0:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3926c5a55bcmr5392121f8f.8.1741714676338;
        Tue, 11 Mar 2025 10:37:56 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103aa5sm18946122f8f.94.2025.03.11.10.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:37:55 -0700 (PDT)
Message-ID: <44a45278-8ebf-4d79-b64d-f1ad557c8948@redhat.com>
Date: Tue, 11 Mar 2025 18:37:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 kuniyu@amazon.com
References: <cover.1741632298.git.pabeni@redhat.com>
 <fe46117f2eaf14cf4e89a767d04170a900390fe0.1741632298.git.pabeni@redhat.com>
 <67cfa0c7382ef_28a0b3294dd@willemb.c.googlers.com.notmuch>
 <7a4c78fa-1eeb-4fa9-9360-269821ff5fdb@redhat.com>
 <67d0730b8bee7_2fa72c29418@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67d0730b8bee7_2fa72c29418@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 6:29 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> On 3/11/25 3:32 AM, Willem de Bruijn wrote:
>>> What about packets with a non-local daddr (e.g., forwarding)?
>>
>> I'm unsure if I understand the question. Such incoming packets at the
>> GRO stage will match the given tunnel socket, either by full socket
>> lookup or by dport only selection.
>>
>> If the GSO packet will be forwarded, it will segmented an xmit time.
>>
>> Possibly you mean something entirely different?!?
> 
> Thanks, no that is exactly what I meant:
> 
> Is a false positive possible? So answer is yes.
> 
> Is it safe. So, yes again, as further down the stack it just handles
> the GSO packet correctly.
> 
> Would you mind adding that to commit message explicitly, since you're
> respinning anyway?

I was confused because this patch does not change the current behaviour.

I'll add a note in v4.

Thanks,

Paolo


