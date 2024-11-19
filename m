Return-Path: <netdev+bounces-146208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F380C9D245A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A0F282DE1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0641C462D;
	Tue, 19 Nov 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAV/hKZf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004B1B0F2C
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014103; cv=none; b=bC0vZ7ddTYNRrs15SJ+7a0H6UIjNVxSi7quR6kC1wlu6RlbCp8cU+TuICpdp0DCvVRUEYyO87pKAHDNh+Zz6GIpGAnP0Gyqpcv0mmuR2sFuXysRH4+uTBMSB4pikMtABCHcb7q4Taxc9IqHUIQqIXA0cyKTe1icQGAuFPbo41j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014103; c=relaxed/simple;
	bh=dbMltewUQlMW0Sem8DhCaaHZBlr9ohwY1znjXghpqK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMAybw5g9ClS7/yg8+0DUQMNezZn9E2ygRZjMFP1DIyGeFKD+38YWBOfW5CDtojEc20BPaBOQv7qrLbHKv/ETRwLvICZrfu08iBDf4oPeHYDlkJHO836kxdeLDgx6DEMU19xWIILQgaxxg59Dy6/ff8ZHSZOp8wqngZqwTBDv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAV/hKZf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732014100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5x1zAmftlOxErhov99kYFrr4C3ad6y3JktV/UxDbWo=;
	b=DAV/hKZfoF1/mh56DbG5GESpXEQXO/fIv47lOzXymYGFA71dPd85/zleF1zCJNXj85zTZw
	NhMn/sTmBFNKs4Egfz5HU7bGifvcv99zPvITY43GbkPpXFI0o7bLkV6hL047lP6PMSBzRS
	Vp+gRW3j1gNOQKPH7KC7zxNvozEUDrs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-RISCUlnJNlCXHH_yVXGEZA-1; Tue, 19 Nov 2024 06:01:37 -0500
X-MC-Unique: RISCUlnJNlCXHH_yVXGEZA-1
X-Mimecast-MFC-AGG-ID: RISCUlnJNlCXHH_yVXGEZA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-432d04b3d40so33470525e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732014096; x=1732618896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5x1zAmftlOxErhov99kYFrr4C3ad6y3JktV/UxDbWo=;
        b=Fq54uxj3ZLBJwCNDLw8ZiMQY0CKdhKnUCSSx/SqC3LdVqFMi4OAa7rH8NIy8fKxXy0
         WDhtVssMV7mKXeuJCLtsEj+lVcvYhgOkPmxX3AWb/hxbgN/BG3G7Sgj0alwZGrUtGGPT
         fDeuvi8RAm9MuDVmQV3rgi2G2Oa3ioEYF90cSfoTHjAJhF0xrNcytnpbJYivy0MxvGl8
         POF9YrZRciBhcWoPwU2sfU8U9+p83lx43SJfZ4/0TFiCp1EeHiMReoecHKUXdfXZXbjg
         WuTTAIqTIsNi9jtnebUMhNSD+FvFitXjo3Ru2o2wKDNt6jEG62JwB4cCpkVlHx9TrPVx
         GoVQ==
X-Gm-Message-State: AOJu0YyHq9EDqRrRxEx9KYXYGj5TrndnXMj92EC1hlKD0D+xqCMxekc2
	U+yvnx48zxtu9efMb1QWrY8TQvv6j0eJw3eComybHAu3iY3Muln0whrrmVumerDiM5kH5TwI/wh
	TrHOtAtYXeTtBQYqHmHKHZGX44DqZgX77OZDgiIWtziBzrFBigsvgyg==
X-Received: by 2002:a05:600c:190c:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-432df798ea0mr120186435e9.33.1732014096350;
        Tue, 19 Nov 2024 03:01:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUgk3hoEITcm/fHjPQY0HbLJGUt2q30yrEQzJiBHczy6KT7QlivIFvtIT5gOta2ObouSh3gg==
X-Received: by 2002:a05:600c:190c:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-432df798ea0mr120186245e9.33.1732014096054;
        Tue, 19 Nov 2024 03:01:36 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac21a15sm187619345e9.38.2024.11.19.03.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 03:01:35 -0800 (PST)
Message-ID: <de23f3cd-833a-44c0-91bc-5a013458a05f@redhat.com>
Date: Tue, 19 Nov 2024 12:01:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/core/dev_ioctl: avoid invoking modprobe with empty
 ifr_name
To: Song Chen <chensong_2000@189.cn>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, kory.maincent@bootlin.com,
 aleksander.lobakin@intel.com, willemb@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241117045512.111515-1-chensong_2000@189.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241117045512.111515-1-chensong_2000@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/24 05:55, Song Chen wrote:
> dev_ioctl handles requests from user space if a process calls
> ioctl(sockfd, SIOCGIFINDEX, &ifr). However, if this user space
> process doesn't have interface name well specified, dev_ioctl
> doesn't give it an essential check, as a result, dev_load will
> invoke modprobe with a nonsense module name if the user happens
> to be sys admin or root, see following code in dev_load:
> 
>     no_module = !dev;
>     if (no_module && capable(CAP_NET_ADMIN))
>         no_module = request_module("netdev-%s", name);
>     if (no_module && capable(CAP_SYS_MODULE))
>         request_module("%s", name);
> 
> This patch checks if ifr_name is empty at the beginning, reduces
> the overhead of calling modprobe.

AFAICS technically this optimize a slow path (bad input from the
user-space) at the expense of the more usual path (additional unneeded
conditional) and still AFAICS, there are no functional issues addressed
here.

Note that even the latter more usual path is not a fast path, still the
optimization is not worthy.

/P


