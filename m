Return-Path: <netdev+bounces-147773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE029DBB46
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 17:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A68CB2187B
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E9847B;
	Thu, 28 Nov 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYl9eV9K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A180323D
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811480; cv=none; b=cl3y/xCBn2L1aEptQT1iVJc/ZzPPlmAoMFYrbVWDyr2NLWashroBeEHpkvn0znnPgs6p393H2s95E50raQK/2s470QbLboVnjHTRJa1+dA6sM6GVRLhugMCrCUvm8LGPT5b+RPNuet0G4WhbhLsP5ZMcd1TUmE62jQKw4CoiJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811480; c=relaxed/simple;
	bh=T5bYTSugQr7AMY6yhUXY3k9ybivyVtlD8Vvnvf1gZOs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EDTHy2AnpC64a3wWZdsgL8cHMQiPoefOjfU7OvGQIUVrZ4AusFG9X9G25NamNm6RbK8EoJJTBtOt8eq/PDfRfwoJZDOB5UIwNpLBB23SyKC0poaUG/Eg+JTIp5np3q4kSUGHt3kYq+7MPtRqOUOUeKQBduDrXvzkzBfCEIiUM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYl9eV9K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732811477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl5ohhcHbAFWTxMhKSNwfsocRoOXovZQW+P93IxtMY4=;
	b=cYl9eV9KnTdI37OMU9xviMdXCgqUGReN1Cw+3CfLCA3OFIHFeaqBrk5heS17pgbk9IHKxA
	oqUyfsGfYcdkERVzJ6ZX3DscmaHL6cGcsF8jdPvGU2ZGhjByYAnZLeBJ1xhplolklFPUdS
	VVBGnrLjfHefjsBDSvVbBHT9kf987Hw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-8CpE7tozM-WT_QthSxD7xQ-1; Thu, 28 Nov 2024 11:31:16 -0500
X-MC-Unique: 8CpE7tozM-WT_QthSxD7xQ-1
X-Mimecast-MFC-AGG-ID: 8CpE7tozM-WT_QthSxD7xQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d87d6c09baso5329286d6.3
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 08:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732811476; x=1733416276;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl5ohhcHbAFWTxMhKSNwfsocRoOXovZQW+P93IxtMY4=;
        b=WBoxXvWb1ONmur2VGKFeU7dgUTatYnUPsrVTfWDyVCUiZZWlSFizYAEZSZJjuewNEf
         35ikoLvuo5O4NG/s3PqpB/EH4713jwOvjpaxtPEQNt4n2e3U/uT4PO6o1qzrZUFvIyYr
         IE2L0YiLiDtjA8Hq5aHMg3DGzYZfWhWLV4CN8aKZq81yJgtGxjripMJO3SrEdS1uMVvl
         q3PZI+HIEbfmTKalzdwgASxTf3eBlPfby6p30RsGtTuYZfzbHssH6JiL656D/7/5O6SH
         SX2Q0k7LDf7A6QKt7hXryuRaQH6LCi5TysD5p1mSlypSAvDIc6+aqc2pni6Vj6NisEmX
         5Y4w==
X-Gm-Message-State: AOJu0YxFUj5mU1eTyiEqGri2r0hbSAj6mhyz7W/SiW5Uoo8IcHe2qa/e
	GkorhuZyFiUNQjw43pYtNe6In1AYJlaLpV5lLINest/uiBxNooeY1V28w1MNTYCO4tWVbSDY16D
	tIi+K139M9FV+8DlP3Ck66pBM5KRdYIEjjxFFQuZkzQJ8rtTbAnz7w4+OpLrRKJ1eaV2JRiUBuZ
	6dtJxsiZbXpbBJSTUVLOgQmIAiX8nj7nZWIyA=
X-Gm-Gg: ASbGncsS4dKV7DZ6LJMySCSURFAXGJii0D1V5YQ7ULfn4qPkC/BFEGhKMZ+QsoKy1Ir
	mNTsHK4RbviEjpeKeZag35xim4B9OefQK8e2eh97ws9e3aSBbczkK4aWpP3JD0ARLt7wIJP9C0n
	XqomVSvZvgKPHRZ3gG/nWsGGAj9Ec762aA2T6EIqsmLjVJ4qAwu9NC2Gh1OnWJdKhHhAMRuRXhe
	UvmekuLO9TCzWVdmt3grUedI+hO4MBYQPPwbDkQUIGiuPyhB17zW2J95ZM+yjtodbNZXUpe7LYE
X-Received: by 2002:a05:6214:2d46:b0:6d8:6a74:ae68 with SMTP id 6a1803df08f44-6d86a74b7a8mr107584026d6.29.1732811475790;
        Thu, 28 Nov 2024 08:31:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt/mycKbtcLjMyry9hT1weJbOVwVZ7IYXUJccyizN2KKY6ih5Y3dYVghdEpm/8322cC7Rmtw==
X-Received: by 2002:a05:6214:2d46:b0:6d8:6a74:ae68 with SMTP id 6a1803df08f44-6d86a74b7a8mr107583616d6.29.1732811475435;
        Thu, 28 Nov 2024 08:31:15 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87517fa22sm7942326d6.35.2024.11.28.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 08:31:15 -0800 (PST)
Message-ID: <8a3c423b-3298-49c2-8368-7b40faff0e55@redhat.com>
Date: Thu, 28 Nov 2024 17:31:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipmr: fix build with clang and DEBUG_NET disabled.
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 sashal@kernel.org
References: <ee75faa926b2446b8302ee5fc30e129d2df73b90.1732810228.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <ee75faa926b2446b8302ee5fc30e129d2df73b90.1732810228.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 17:18, Paolo Abeni wrote:
> Sasha reported a build issue in ipmr::
> 
> net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not \
> 	needed and will not be emitted \
> 	[-Werror,-Wunneeded-internal-declaration]
>    320 | static bool ipmr_can_free_table(struct net *net)
> 
> Apparently clang is too smart with BUILD_BUG_ON_INVALID(), let's
> fallback to a plain WARN_ON_ONCE().
> 
> Reported-by: Sasha Levin <sashal@kernel.org>
> Closes: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25635-g6813e2326f1e/testrun/26111580/suite/build/test/clang-nightly-lkftconfig/details/
> Fixes: 11b6e701bce9 ("ipmr: add debug check for mr table cleanup")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Given the issue is blocking today's PR, unless someone screams very loud
and very soon, I'm going to apply this fix in matter of minutes.

Thanks,

Paolo


