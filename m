Return-Path: <netdev+bounces-122253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC7D96086D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7163B1C22367
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74991A01B7;
	Tue, 27 Aug 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZsxPebU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179B1A0720
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757607; cv=none; b=d1GcmmxZ/r1o1iNXts13eD8RwcFIyzsx5Rq8+N4qD7/Vwdh7NmlYeyrB0pfH/Uv7GmP4Ga7gs/WboWVp2yA+dhRtzh+t5vhm0rLf6YPJzFEGqHsbkWAZQAfbkGzsdANkAwK11eEMmBRvl5dwvqAOBU1CJQnZLOfwohGMb5hN0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757607; c=relaxed/simple;
	bh=zPTMEjhHKawSK0fVOh5cFY/m0zfy2MzI2cerjKHrAxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXtfUH8M/9WN7xwruAgeBvooiUkJwsaFfJmUgKJ2aQ3SKx85nHYT+I6D8dntKOjosBSbT/SFDq8r3VXypwDHiDe5uDbDep1EuGe0wbCHiRCI9rUt8MXrR/2HuGnnXNdAeHyNFPdZl7BmV8wa3JH6NZ8/vOeoAvGV6yGo33qkOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZsxPebU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724757604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MECBd/hSEibWGsRQlj3xvU/VnK1E0855dY6x5mvZ7gA=;
	b=cZsxPebUTcTccSil891HpRKkkxE9xMsSmYdGVUTikml66Dh0ix5Fx8Inm/9izE9BPBytit
	ZxrPx+0rKcjbhSVO0PsxjZtfERMxFxBXp0ScOBD/cg/JU8iWTMgcMgv1+DmvLS2/9E7ZIg
	zpvv0CCQpacFDqFo/o7wTrP5uwEu3Jg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-SLwU-bPbNhCpacHZKEQb2g-1; Tue, 27 Aug 2024 07:20:03 -0400
X-MC-Unique: SLwU-bPbNhCpacHZKEQb2g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37189fa7ad6so3889311f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 04:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724757602; x=1725362402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MECBd/hSEibWGsRQlj3xvU/VnK1E0855dY6x5mvZ7gA=;
        b=FBbrrhUQGxgLVjIWlmIdLHeF6dATGrTzN5ADSMoor4CMaVnYwjzm1+HAIKjuWNEvjH
         rVDW9vfJd33VBhX7dp58ENvXc62o1elTVegtux8lpLgyFg2YxQu7/nfHSSX4fW2/tL22
         /WXN8GDqfS3K1qhG0QtkdRumeVAP4jRrEJeJNOUJxoamRl7U/AlxT/r3HhdeDJ/X2c/T
         B4XtE6Q4vcZ8vr6CaEmdLXw0BO7TFpGJoAShqXWUxSEjOk7A149VBoa0NJfQsrknR4Vz
         a8yjPanRv3LvlUZAAnUl9VWS+1VEDZz3PYY6Yd3XLvZ5n4DRJhPxdAK3xmR0XUYQ2Yah
         cLGg==
X-Forwarded-Encrypted: i=1; AJvYcCUcfAuhCCFdAl5klmIpn748xD6ckURm0qGjmv8Gi91Pm6Pw0ypwfZhz1aeIGBPiJ225zATlUKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyQ+iZjDuw+K2RSaZ4Z1DrHeRCMuulnqeoDfH9yLUbV9fAG9B
	2pOIr8U/BJ+23eFx5J0H5LbjpqlxfMka/SfX5qOdCODLzzgAiVttP23OrRn481ZYS5CRcsrAduN
	SPjqpv6gGokEZVidaE8hhOrs8A3qOeLh11IztdPUrP2b1LXK+rAmH9A==
X-Received: by 2002:a5d:4e10:0:b0:371:8e9c:e608 with SMTP id ffacd0b85a97d-373118e3327mr10656422f8f.52.1724757602100;
        Tue, 27 Aug 2024 04:20:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYvhXTuSl+sI44eFe058b0E+jARsnoT9juypCVTahh5G9OkBjlQCUYH8EuqxJDKhKuXE431g==
X-Received: by 2002:a5d:4e10:0:b0:371:8e9c:e608 with SMTP id ffacd0b85a97d-373118e3327mr10656385f8f.52.1724757601665;
        Tue, 27 Aug 2024 04:20:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c459sm12768823f8f.27.2024.08.27.04.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 04:20:01 -0700 (PDT)
Message-ID: <fd2a06d5-370f-4e07-af84-cab089b82a4b@redhat.com>
Date: Tue, 27 Aug 2024 13:19:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/xen-netback: prevent UAF in xenvif_flush_hash()
To: Jeongjun Park <aha310510@gmail.com>, wei.liu@kernel.org, paul@xen.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 madhuparnabhowmik04@gmail.com, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240822181109.2577354-1-aha310510@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822181109.2577354-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 20:11, Jeongjun Park wrote:
> During the list_for_each_entry_rcu iteration call of xenvif_flush_hash,
> kfree_rcu does not exist inside the rcu read critical section, so if

The above wording is confusing, do you mean "kfree_rcu does not exit 
from "...?

> kfree_rcu is called when the rcu grace period ends during the iteration,
> UAF occurs when accessing head->next after the entry becomes free.

The loop runs with irq disabled, the RCU critical section extends over 
it, uninterrupted.

Do you have a splat for the reported UAF?

This does not look the correct solution.

Thanks,

Paolo


