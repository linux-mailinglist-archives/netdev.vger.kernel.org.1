Return-Path: <netdev+bounces-192704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7AAAC0DC6
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953581C0106C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D17C28C2BD;
	Thu, 22 May 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIzo6t0e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA128C034
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923014; cv=none; b=IgRDublK4CZyBRxRbdRG+ZJIiRdm1gBMfFs/ST0fWKGjYuNXyzeVSnZunp/4oSkhJLTRl4o7JVvl7wIygxLLKP1FzjskEpKCSZXd3hDZTSHDiD/RaYEq1yXQGAo2rzOUSwidkuSB/eWGrIIcVMvU1Yaa+mBI+LUKbjl9ZqOiIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923014; c=relaxed/simple;
	bh=D9jT123o/rgdvMENfKGZme/iraOXX3qYEZeNYWJeeGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWR1WuEvq94vInPkudXsjYCZYGBdp3N5RqTbO5OSLABtp4vlc05UzMioltnlXwAdr8qtRGvA8BNvlgyqq6bKLpcImR2jNDuryhHBc1bb2m728+NNOniB7AhFToK9iBfCF4aAyxqZ0WILVo8lONKmkWvNjguljwzJq5BYnHh0grY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIzo6t0e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747923012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEp3t9donGMcPjRNVFwKRlkntQpcJvUEeFhsZVRvNl4=;
	b=FIzo6t0e8hYvR/H02mcTAAQkHdVh5k772MzoQHOV306xvOU4ZM4K5nU+bYsh/hAPuG3DwT
	6po1stYOVV0FvYWF59Wwgwbx+jg4GP2xMQ3sW50P00r0ffaSPSpcQeDaQROz/YezYrhQa4
	tn66dpjSl73IUHOToZHORBUo8CBJBg0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-H8_a61PbMb6yp4DkAKinhw-1; Thu, 22 May 2025 10:10:10 -0400
X-MC-Unique: H8_a61PbMb6yp4DkAKinhw-1
X-Mimecast-MFC-AGG-ID: H8_a61PbMb6yp4DkAKinhw_1747923009
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so51474985e9.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747923009; x=1748527809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEp3t9donGMcPjRNVFwKRlkntQpcJvUEeFhsZVRvNl4=;
        b=YIWFK4WIJ3/nhzI+L++e8UM6DT4/mh58KzY5owWYWe+kj1qBMb7QdpHI5xeyvoByj+
         CyuyuxMhl0m5CD31wPbAKqHoOnMeQYEldotgvbAKe39GrLpGVdOf+ECgzxxx8rslCizj
         jle2rL+XSEmztB3acBNaNZeyThgN4+H+9whF/n1JSVycLboWH+TbVxHYEeazYHNbO/vk
         GQtRxfgE3CACLE9k4WfhPLzFhuPsv7WCk3hZXChS/TIDnnQkaw4htZVvu+aNo2qbE4xn
         x7hgZylSSfNoxFEJ9fO4+0h6qXAONjFa7hnM4LPbqynrTp1Xz/jQOvOeRMcVDWidhMpz
         hVyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbtUpYmO8CaO5VW9FY54BNIoCYwutJE2wO8OhJzprIPB6SUoq3evvgau3jDrndcI00Jto/cTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzXCksYHTB6LZbyS9thWhAQhKHP1KI2RogNiGSdY2uEFgOG+f
	0+ep1XP/l/Gd9iCViQDX1HC81r/fULj5BYqwJiabCHaKGkeUCltVGQ6rJvnKJKd01YJJfQp/uwJ
	6pebuKIVjaZH6SOQyXwAQFvKhLOUWN7JDwQIcZi5EXwKl0X7mQMyHNAwkdg==
X-Gm-Gg: ASbGncvPOLXi0WzSr28ONOTNgTWIUYujF+9IdIy2JwD1BpstAShD0I7Sjv+MO4ZfnQT
	9zc6+Ue5N2Y7tEa/ljotHDSthkLJ3dOSX2OUPVv+6qClqqW/BNUQLUU/eGC7Djj2poeBJ55RdvF
	XJmp9ij1QKhNfQpKSA5n2f/DDokIZoywyWHqq/8pSTFoJ2GHH8mUzdtqNGyH7BMGS8JCajQvKo4
	YMgC2jj+59rDNNiCEnJ0wCTp4us+b2TWUfVPOlZuCKiSBviNiZ/6PetxbJ/3PiA1sDFtFMWxyVX
	Lvr3iCCYlmUayrn4BpM=
X-Received: by 2002:a05:600c:1d88:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-442fd64dfbfmr254182715e9.19.1747923009262;
        Thu, 22 May 2025 07:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5M59KObi5W8JNqVE07ZLmiBRpyTYe9HIISKhG9Pya++Nlbo01Uat2vr+m/UJdQlRyHJj9LQ==
X-Received: by 2002:a05:600c:1d88:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-442fd64dfbfmr254182175e9.19.1747923008776;
        Thu, 22 May 2025 07:10:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f23c07bfsm107580585e9.23.2025.05.22.07.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 07:10:08 -0700 (PDT)
Message-ID: <649e3d9a-48b4-4660-99c5-1609e3cd06cf@redhat.com>
Date: Thu, 22 May 2025 16:10:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nft_queues.sh failures
To: Jakub Kicinski <kuba@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <584524ef-9fd7-4326-9f1b-693ca62c5692@redhat.com>
 <20250522065335.1cc26362@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250522065335.1cc26362@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 3:53 PM, Jakub Kicinski wrote:
> On Thu, 22 May 2025 12:09:01 +0200 Paolo Abeni wrote:
>> Recently the nipa CI infra went through some tuning, and the mentioned
>> self-test now often fails.
>>
>> As I could not find any applied or pending relevant change, I have a
>> vague suspect that the timeout applied to the server command now
>> triggers due to different timing. Could you please have a look?
> 
> Oh, I was just staring at:
> https://lore.kernel.org/all/20250522031835.4395-1-shiming.cheng@mediatek.com/
> do you think it's not that?

It's not obvious to me. The failing test case is:

tcp via loopback and re-queueing

There should be no S/W segmentation there, as the loopback interface
exposes TSO.

@Florian, I'm sorry I should have mentioned explicitly the failing test
before. Sample failures:

https://netdev-3.bots.linux.dev/vmksft-nf/results/131921/2-nft-queue-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-nf/results/131741/2-nft-queue-sh/stdout

I was wondering about this timeout specifically:

https://elixir.bootlin.com/linux/v6.15-rc7/source/tools/testing/selftests/net/netfilter/nft_queue.sh#L329

> I'll hide both that patch and Florian's fix from the queue for now, 
> for a test.

Fine by me.

Thanks,

Paolo


