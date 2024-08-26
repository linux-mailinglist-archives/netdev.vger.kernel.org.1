Return-Path: <netdev+bounces-122068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4052395FCB2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DD8283204
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7539319D094;
	Mon, 26 Aug 2024 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVbODkgG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108313FD66
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711156; cv=none; b=A9frqkyJE5S71oAo/IiseJl1DYNsUrRir/uWqBK6xCEdwpIWYntIKYBDzzWBYM1Qvo4epTD7uaAZKqZX6eg1ruighodSbD+4+4/BpH0AXv264gg8lh3KT9U1U65toW4HzJR01tzbajSaDK01e7GszkbPiuihMcdq9nPYAm8tWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711156; c=relaxed/simple;
	bh=+YzYiUddl7WzqiuD3XFxFcsM07ACtx70EA9yzXEAw9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9Rp0c+inOAEQ33cGg+9Jl1TAsM+X4qALQU+2YjWMpoPrgZa44UuCxHKSFODQoF1i/Zb6E0qeYzxpwHPR5Q8yI/k0Wu+0UUn/poEefMhi8ayPPsdfl0BskVzw1lwkaTF+YVpR24nhHz7B6JP4LKyQ+C7S1pdyl89j4wfVRDe8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVbODkgG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724711153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fp/iLwSeDYxo+zs4Eu6WkmBXMKfgOlub9d3k+RLst98=;
	b=ZVbODkgGMVUXt80GTync2m+DFbsNjMTQN6iN1t37g1SrVBfrO6T54M1tRPknxTddFLT2J6
	+MwZTJxB9dR/Du4eF3JvCPyc7cADVIJs1sF5Z7VNU+KFsAFvbr9uQlhrWbRFn5KBPV7RAT
	692F9j4O370M6DhnsTHShpdmL/vXCRs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-402v6yAAMO2Y_24ZM-RYXA-1; Mon, 26 Aug 2024 18:25:52 -0400
X-MC-Unique: 402v6yAAMO2Y_24ZM-RYXA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6bf6a974541so59440416d6.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 15:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711151; x=1725315951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fp/iLwSeDYxo+zs4Eu6WkmBXMKfgOlub9d3k+RLst98=;
        b=QqBsnTeKph//JkpwCDj6PDxUZ5//9crsTqaCULyldNjk7lPVVJGtVt8sb/njgeDO1h
         7JBEInUCNa6UWIY0Pj/tEq+JnG0hmwNw/OfEGMeJhoue+3L9HU0hnCoiWHuxOxInLcsW
         790QOXbGG7h134GZRP3hr0i9gMv4bOQLnYMUvWXCu8gItNLHrMwm8Eej5RViEBT8WXrM
         1y5LhbjjRojJPJ0rhF06cRbdklkG3no7iSYuaXCzcVzcnRNCjEOzvJMH9EaEyQqOmoBC
         b9LI7EfZLvv64hd4DBHXA907DZDxqR5k8CX9XHeWK8tmjWetOEM+rEjEt0TeMJ875LMZ
         023Q==
X-Gm-Message-State: AOJu0YzXjvIzsqYUhqf6hDNfXqsHfhBs43T+FbcUqIfmomJZReTh5rrA
	VrkXRy6DhZLOKiLEsyDuIMXPbE+YeIVC+68+19/2A2P2PRVviFIm1ud0DZkUTWIA5B6KXF7xJMd
	ORmgJGGaRb6uzg/jzBUWyjT73IWfpaDw/SvJLLhl56sxGps1P2/+KYA==
X-Received: by 2002:a0c:f209:0:b0:6bf:7c43:c390 with SMTP id 6a1803df08f44-6c16df28accmr165362966d6.48.1724711151586;
        Mon, 26 Aug 2024 15:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6E8/uu5HzgtnUmuh1ISv3bLFbUm6t6E8SWIRIVwEfIumByBeTj9AeGtbyeQ3BXh72tLa8tw==
X-Received: by 2002:a0c:f209:0:b0:6bf:7c43:c390 with SMTP id 6a1803df08f44-6c16df28accmr165362626d6.48.1724711151090;
        Mon, 26 Aug 2024 15:25:51 -0700 (PDT)
Received: from [10.0.0.174] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcc904sm50182266d6.104.2024.08.26.15.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 15:25:50 -0700 (PDT)
Message-ID: <c9567ddd-cc84-4fbc-bb6d-b719b2cb723c@redhat.com>
Date: Mon, 26 Aug 2024 18:25:49 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top,
 sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, edumazet@google.com
References: <20240823211902.143210-1-jmaloy@redhat.com>
 <20240823211902.143210-2-jmaloy@redhat.com>
 <CAL+tcoDgq+MmNz6Eo_61eBJ2fduyxL1j+kbo_9AYtB4o3tJO5w@mail.gmail.com>
Content-Language: en-US
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CAL+tcoDgq+MmNz6Eo_61eBJ2fduyxL1j+kbo_9AYtB4o3tJO5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-08-23 19:51, Jason Xing wrote:
> On Sat, Aug 24, 2024 at 5:19 AM <jmaloy@redhat.com> wrote:
>> From: Jon Maloy <jmaloy@redhat.com>
>>
>> When we added the SO_PEEK_OFF socket option to TCP we forgot
>> to add it even for TCP on IPv6.
> Even though you said "we forgot", I'm not sure if this patch series
> belongs to net-next material...
I agree regarding the fix.
The selftest is new however, and belongs in net-next because of that.
Since I made it one series I decided for net-next, but I leave it to the 
discretion of Jakub and the maintainer of the linux-kselftest system to 
decide where they go.

///jon

>
>> We do that here.
>>
>> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
>> Tested-by: Stefano Brivio <sbrivio@redhat.com>
>> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> You seem to forget to carry Eric's Reviewed-by tag, please see the link :)
> https://lore.kernel.org/all/CANn89iJmdGdAN1OZEfoM2LNVOewkYDuPXObRoNWhGyn93P=8OQ@mail.gmail.com/
>
> Thanks,
> Jason
>


