Return-Path: <netdev+bounces-101990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C97901016
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 10:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803251F22013
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 08:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123B157A42;
	Sat,  8 Jun 2024 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guyy3sjb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D54CA40
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717833917; cv=none; b=jGxRVqMJry57HfkGraSe7c3ZVBLnPjseV/xPUWDnnh2pycpVbX/0m1LcQx8QoytXVPiTaESmAh9vnsioaW0ubaj2MSC9zjRzQ9/bxTs9seDeRMTuLIPHxCIdXR8TDxLDap74/JTGmNVqdntZt+WsX8bt5L/tjjCMYeGH8P82umI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717833917; c=relaxed/simple;
	bh=APRhzOIJ7x6eZpRT+NQUfIFNeuNwCdIi2tW7Cm1PfZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoyFUNGfqBcH//eRWzmttohvjRzTcJsOypr1+7VU8j8CsXSiiCoWLjJ5UIDqC0tOhgqD8v185ETcmotqu6Ku6IYYtxbbSPf6d7WHj7xFCtEzs5v8WwR0miVrrhLGGZjMhMwXTVtA17lDK30d/KkgBSkGfA6ucWO/roRphHBQvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guyy3sjb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3579ef2d436so124753f8f.2
        for <netdev@vger.kernel.org>; Sat, 08 Jun 2024 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717833915; x=1718438715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APRhzOIJ7x6eZpRT+NQUfIFNeuNwCdIi2tW7Cm1PfZM=;
        b=guyy3sjbi38OwCet0Xn9zV43/OrygYoiHBwmF5pA7o0GiI1hgzPA3DlyM5RT39MVKE
         ySJs7JNMvWneBhgiHej7mXNK3eQcpSvo0TIn22vZsDj63K23lqPBcdmjW6iYRAluCT4m
         xbb307cnSMU7nug/K3Enwb42orK5pxD2lKP42be6lDJU3d7VPVVIlz4zH8EcKoy3UFMN
         9oxg41YfpdNo0IrEJF4EjtKFHAQX+NfDTPqFQKuPWk44KiTV0ckSarKH8DbXLrgqwiqa
         ykBBvasBjf5MzAzsCca/FluYLhzO7oiIK9WoWGtiwmvEyuFTx5B6oZS0AucrazRkuJ3v
         hNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717833915; x=1718438715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APRhzOIJ7x6eZpRT+NQUfIFNeuNwCdIi2tW7Cm1PfZM=;
        b=BKLaPKfjMKnZGuDmY+psBM63ziSU0hNLbbCThqoOaGgREiFUAmdJcHlttB2UBDpbFV
         TbQw43fdMb6KeJpQoEBTPeCWFECVRnmpP82/3FphXgYcUbeNRUOLiyVImW+jMmlsnxjw
         AwXg/PG174aWTv8aVAh5qHHS2qcuHzbHNbWb2/7ccPOPA9CMvM1qwYoyqgcFyHWwusNR
         ja9yDM1YcFuYXRoYILzmWN/wbUhR5VpCOZjQLw2M9g/ylyBSuasNg4B2hvq2yjQXQfsR
         jrrhxSeTbXkM12wtdicCHypyQm5MuAJr+PZmMJ//FiGJrJkUkixoEmmEtGYBNzcANLjI
         ZlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4eyDTvolC1McRMBblWWItuPwouKBqyX94Iy/kySAgAx7gDbWwyy++KA1vN87cv1twK6bEeCAxGmzxAZAG/mn0Z5bQ14sx
X-Gm-Message-State: AOJu0Yz/5akIfENvHEJ5aAekSNdK/qtcGt0H1NLVqTmKM6JUblQH2nma
	iHBUC7qhOmy6/8WJmNPQU3OMv1Oi0gIfvVDi+Ep3IUjEV8ExgP4YXTeGPA==
X-Google-Smtp-Source: AGHT+IGLR4CH5vKgALCYJii0ToaErWVzgpIWV2Q+4xz/TXyB5THOq/fGfA2BnTZqgCe9bhC3jTSZSA==
X-Received: by 2002:a5d:6c65:0:b0:354:fc97:e6e3 with SMTP id ffacd0b85a97d-35efee1d38fmr3324528f8f.5.1717833914579;
        Sat, 08 Jun 2024 01:05:14 -0700 (PDT)
Received: from [10.0.0.4] ([37.166.160.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35efe03596fsm4135955f8f.96.2024.06.08.01.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 01:05:14 -0700 (PDT)
Message-ID: <541b6a89-bd1c-4e7f-a694-392649dbd778@gmail.com>
Date: Sat, 8 Jun 2024 10:05:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/sched: initialize noop_qdisc owner
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <CANn89iLyXx8iRScGr5zzBVJ+-BnN==3JJ7DivQE_VUpaQVO4iQ@mail.gmail.com>
 <20240607175340.786bfb938803.I493bf8422e36be4454c08880a8d3703cea8e421a@changeid>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20240607175340.786bfb938803.I493bf8422e36be4454c08880a8d3703cea8e421a@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/7/24 17:53, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> When the noop_qdisc owner isn't initialized, then it will be 0,
> so packets will erroneously be regarded as having been subject
> to recursion as long as only CPU 0 queues them. For non-SMP,
> that's all packets, of course. This causes a change in what's
> reported to userspace, normally noop_qdisc would drop packets
> silently, but with this change the syscall returns -ENOBUFS if
> RECVERR is also set on the socket.
>
> Fix this by initializing the owner field to -1, just like it
> would be for dynamically allocated qdiscs by qdisc_alloc().
>
> Fixes: 0f022d32c3ec ("net/sched: Fix mirred deadlock on device recursion")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>


I found this quite by luck.

Please CC maintainers next time, and blamed patch authors :/

Believe it or not, I do not follow netdev@ traffic.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.



