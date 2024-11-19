Return-Path: <netdev+bounces-146220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606A9D250C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3731F22D8C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABD1C9EBF;
	Tue, 19 Nov 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DP0YiKqT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946D1C876D
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016468; cv=none; b=ogVmk/hNIyarh1Z1TW7jNUi0ELkZsOedbTomd6kWL/Rb5lUYF+WEnadQwQdO3t8fm6BPIc0t31OblaZGSdtL+QNBRGFm4bj92DT9MTvDyTVndOYOIzx8dTXdGoTI5BDkyTBsPz+F1TboVhv7ki3hhIsPBow4rAdSozbQRC37f/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016468; c=relaxed/simple;
	bh=B6tGFGc/acnVM3Qye2kgK47gJP4agRKP+KzyCFDdH6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+CvjUNtItubCMn1lqwoaayd7PVPgiHNA6wiMnHc7ieb77/Zciy5kvoPnY/4VYSo3gxyHcUoVhF3RAwJ+il7PlM5BrS4qNfjf/+RayAsQFOdI1RC2dTZObeOEr7GJeaRlkWAC0xHbI+zuuE2R0ZF4l688CeflyvEaEDs05z++eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DP0YiKqT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732016466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSO7rRgJI8m9saV4ky7Ejp+AThjtq//l80mNHJPVY1A=;
	b=DP0YiKqT9vOn2Ki/CuDdBcI4vNLQlYyC0HhEchXXBRlcCPRqFXY902rOpQo5uhSt38PBkI
	fplbK59WdPawl/nCv63BVYWc8W+jV39WYO61MzoAovthhO7TnRzzfIy9BFj83Ufhpl5SM0
	SUPTZ8V2mcJXcihng9jAwRdCsRuj8GM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-UbBaoZb5OJ6hGyJXihS9sw-1; Tue, 19 Nov 2024 06:41:04 -0500
X-MC-Unique: UbBaoZb5OJ6hGyJXihS9sw-1
X-Mimecast-MFC-AGG-ID: UbBaoZb5OJ6hGyJXihS9sw
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d425b9dedeso11152606d6.3
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016464; x=1732621264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSO7rRgJI8m9saV4ky7Ejp+AThjtq//l80mNHJPVY1A=;
        b=tcEsTpQbAvdPmVS0rx7qDuARdQvCCXivW5BKIZ5/FedsOvafunMB5omF4pQxYzmmYC
         5aOIVCJxHk3nhK+wiVBPS7V7GE00J46vdjRbeyab5TIFn7ze7Ojgyd8W5byZzq8CJ9eH
         j28jIEjYVThvd9+cNsKoPPf4ftuigWrVI41Pe3mXOt03O50iPl+tEMqUXWqB7yEoVXXL
         QZGYGA4dfbpRBT8SG7X3drHJxTy+6FOp8IQ7jUxQQeUanejjozGslWd91Jf9yMKM7tqu
         XON5U3hymMAq0pJ2PPAe0dDx1ywaNuOGv5RB6i8ImDWYOD0/sI6IPTs/DK2e/mp1SnRy
         1HsQ==
X-Gm-Message-State: AOJu0Ywg/SzxOONU1Cf6d/9Ffc+J+IPX25kceCyGx8bAxPhNZzwYl68J
	dkw54i9ZmxTmgV7pkI55aidDz3Rv/Rb6brq0PMhcJZCo3DY2GlZQASNn5AqMrgKJ1QqxNipyAVi
	J5f0OG9k4GfEW3e9BilEdPxxITGKl8m7GYxB8wHUfldud/+U2X7B9Vg==
X-Received: by 2002:a05:6214:c65:b0:6d4:ab3:e19b with SMTP id 6a1803df08f44-6d40ab3e1abmr192732236d6.42.1732016464383;
        Tue, 19 Nov 2024 03:41:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSL+CvUXEPORupLRfcZC0IPSOYYNVWZYJtS4mmscYBrBcgg3M5ByxsUOZ5P6MeA/A9Dqar/A==
X-Received: by 2002:a05:6214:c65:b0:6d4:ab3:e19b with SMTP id 6a1803df08f44-6d40ab3e1abmr192732066d6.42.1732016464058;
        Tue, 19 Nov 2024 03:41:04 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc7ada9sm47266936d6.69.2024.11.19.03.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 03:41:03 -0800 (PST)
Message-ID: <06940878-8a7c-441c-958b-7cd7e7408beb@redhat.com>
Date: Tue, 19 Nov 2024 12:40:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] mm: page_frag: fix a compile error when
 kernel is not compiled
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Alexander Duyck <alexanderduyck@fb.com>, Linux-MM <linux-mm@kvack.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119033012.257525-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119033012.257525-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 04:30, Yunsheng Lin wrote:
> page_frag test module is an out of tree module, but built
> using KDIR as the main kernel tree, the mm test suite is
> just getting skipped if newly added page_frag test module
> fails to compile due to kernel not yet compiled.
> 
> Fix the above problem by ensuring both kernel is built first
> and a newer kernel which has page_frag_cache.h is used.
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Alexander Duyck <alexanderduyck@fb.com>
> CC: Linux-MM <linux-mm@kvack.org>
> Fixes: 7fef0dec415c ("mm: page_frag: add a test module for page_frag")
> Fixes: 65941f10caf2 ("mm: move the page fragment allocator from page_alloc into its own file")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Tested-by: Mark Brown <broonie@kernel.org>

I'm closing the net-next PR right now, and we must either apply this
patch even on short notice or reverting the blamed series.

As this fix should not cause any more conflict than the original series,
looks reasonable to me and has been tested by Mark, I'm going to apply it.

/P


