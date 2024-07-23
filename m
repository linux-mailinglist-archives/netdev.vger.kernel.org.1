Return-Path: <netdev+bounces-112543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D909939D4F
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD082283110
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A1E14BFB4;
	Tue, 23 Jul 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFuUGskK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989013B2AF
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726003; cv=none; b=oMWa6BAbJNo818afzixjX8k63h/TztmrSyq32mQuq/rVKphWhSzphLLtIT3bmtzu/IFubiCNZnUogq4ifHaHWKiFWEMqI7W7Cm10za0iVLd9y39K4x6VLlOaSb0atcsJbD9lnrO6sKRy5Pr/Aw4hi3cvdJWm+ypubrvAyG2Wpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726003; c=relaxed/simple;
	bh=+ye3TbGwDHVRBUVi+ILlMkK4EdIzu3ZNPHjQkCc34WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVRMxMAY+hkvqmJ8hKH85g9BFYZcVBrCKPvWXeFxI3xt4QXujsY/FhRAGm7pWuJWnnyVlHpOyNLaFOxFqJ7m7RRY0VSysaUZJvrVcKXYdrCeo7SpMMGwzKdozBP8wyGmuQi7XBmetjtCcqs8Wzt+aDlhUSdVyOdRE+K4thPTEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFuUGskK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721726000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvbU4BFYRnv+rPsucUG4sbEsSj0ztOqkC9YXGeI05eo=;
	b=MFuUGskKQaAFYWgZf795/MWtxVBxFOGAMxf8CZHaSTOjjr3s5Ui4Vm/b/+H183XBso/uzF
	xGPyLV0+du0quwzZqLQPXN0eJ0qRmCfXW+HXYRNS1egtUgeqLJ5JCMBZhveI0lGentBVFp
	U2x1Zx837bscuQe0nCD62zJdoctMmEE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-ZEd9Ksz-Mzy8b3KVuyupUA-1; Tue, 23 Jul 2024 05:13:19 -0400
X-MC-Unique: ZEd9Ksz-Mzy8b3KVuyupUA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3684636eb06so639341f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 02:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721725997; x=1722330797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvbU4BFYRnv+rPsucUG4sbEsSj0ztOqkC9YXGeI05eo=;
        b=RO/ViPUNMgVqQtwSLih2riI9QxA0mWqmFMz1eNklynPM6/gIBqp7n3v0CDXbzeGzuO
         vNwgN4Sgr+Vec341ZcCFI1zY+3FziFEZxVYaBjv2uI4I4qNOgRM6I3rnY7l1MyYAnMKn
         wt2R8DYuGPdERerVkfMvab+xUEZpQ45hs+6uMtW5T7yVoFi5hFD18M5CPGS3KmDiusga
         R7c7VC/zj++GQyF1XxOr+OHX6Ya8KQ8vpzQKlIK4wIHbn3npOOcWGaSkH7Yy5wdWtugx
         ZBdfXYeoOGhryGR6vr+VfHuftYfR+3tDGJ0eZVPjlGUJ06pkvIBZ1n7K4LzpmCJfDkag
         Qhkw==
X-Forwarded-Encrypted: i=1; AJvYcCVZN5PB4xUINf5aZV4B/lNNyUBH2deBCgUtUeIcVS9isTG0jr8Y9s2HOoN6mhi+wWIXgCQkBD0qX6brqQaCrEkBT7dR3Eoc
X-Gm-Message-State: AOJu0YzOyWW4cjJYxU0TUbVFWHXtdLpqhWBAwpB3nfBWEETLIb7lyTf9
	Y3tGmX+RzAFSnklPOlkRvwoq2qyy9irvEHCNXhMI43E3wWttWieJ20fEbThJr+/X6ubUk4QTotK
	L345x3BR6kbV6NUJ2L9P5nxn9/VS6f88Yamwx1gcJW6Tl/hG/MJzqcsKFmpI6/w==
X-Received: by 2002:a05:6000:2a1:b0:367:4d9d:56a6 with SMTP id ffacd0b85a97d-369b6750465mr4216204f8f.1.1721725997622;
        Tue, 23 Jul 2024 02:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9r6M0nfIGyt6REY+V1FXPQWmhuUwS4nAOxlTpt+QnoMNPb56n7jI/2Bi+V10KYhTSI9h70w==
X-Received: by 2002:a05:6000:2a1:b0:367:4d9d:56a6 with SMTP id ffacd0b85a97d-369b6750465mr4216196f8f.1.1721725997226;
        Tue, 23 Jul 2024 02:13:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368786943d3sm10868651f8f.50.2024.07.23.02.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 02:13:16 -0700 (PDT)
Message-ID: <0a0ebced-e19b-4dbe-9621-08b1867d313b@redhat.com>
Date: Tue, 23 Jul 2024 11:13:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] l2tp: make session IDR and tunnel session list
 coherent
To: James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 tparkin@katalix.com, samuel.thibault@ens-lyon.org, thorsten.blum@toblux.com
References: <20240718134348.289865-1-jchapman@katalix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718134348.289865-1-jchapman@katalix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 15:43, James Chapman wrote:
> Modify l2tp_session_register and l2tp_session_unhash so that the
> session IDR and tunnel session lists remain coherent. To do so, hold
> the session IDR lock and the tunnel's session list lock when making
> any changes to either list.

Looks good for net.

AFAICS, after this patch, every time 'l2tp_session_idr_lock' is 
acquired, 'list_lock' is already held; as a possible net-next follow-up 
you could remove completely the 'l2tp_session_idr_lock' lock, and update 
accordingly the related lockdep_assert_held() assertion.

Cheers,

Paolo


