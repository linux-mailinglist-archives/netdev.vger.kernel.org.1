Return-Path: <netdev+bounces-103501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAFF9085B3
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788DE1C21DA0
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0515185091;
	Fri, 14 Jun 2024 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dr+i4lKe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8818413E
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352601; cv=none; b=DllHcTrMpY+/Y28DotLp7C8jENdmCYXxKiTIeX4lIZIqTD8cKpSLisvNKFMMK+koMa/4F3L1lYGWWii5NxFwj8JJR1RerhXrFukqrJLVKQ8hA2nAzNdDDXemIZ3/v1ZWk5rHsMmgFd8A8BXniIByZLH3cFrpkVJwmsfVDGbpEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352601; c=relaxed/simple;
	bh=07sN0rozFupB3KVDJ2ujRXSWOpuv4cGxuHIeIFmDozI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzaHQ8GspD5l/aO54voEq5VR7lhyp/g6yWu8vavXjCSmDciTUyqJ12v/7TVHtEjhw44+feV8b6kOyAlma9D4N265Z8nEIrNbNVMA4u74NzgN0Kwxlfh++bGf1HEKFP5iFbzdWQF4gN2KxcCietD7PLVpB2WMHSip9O/Ar3YQQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dr+i4lKe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718352599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=07sN0rozFupB3KVDJ2ujRXSWOpuv4cGxuHIeIFmDozI=;
	b=dr+i4lKed+iFM+pUeJbcHgm11xrlmFEawY1NNlj+4UiGhprgIQceQSBdBlSwJqgik96JT8
	RiNvivjNrlAOGr/BDXvevHesygYHyN89oYkOi4tIfIiKUDO6S9iLW4YBiUZe4zRmA1S1EU
	GiB+2dmtkRnOBLJvmNRdjIH2MTAZfpY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-lzll6S3BPLmYi-usxwuqYg-1; Fri, 14 Jun 2024 04:09:56 -0400
X-MC-Unique: lzll6S3BPLmYi-usxwuqYg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebf477ed09so3110561fa.0
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 01:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352594; x=1718957394;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07sN0rozFupB3KVDJ2ujRXSWOpuv4cGxuHIeIFmDozI=;
        b=BUK3vP8P2YEDkKXa1GWV077DOb8fvb73renAqZoVt6rBgRobeOyI4vo538/2Vpkik+
         /ufoLBcGHTYJpESzod0EW6rWYxActjxqShCy9CqEwbcOALcZsVOvMhvMFlVuZPgMIDnS
         dZhVcE/Wr1uDtarmsK1XPWdqUo9A2n+m0hgnSe+LhPmd6Il/zMhve+FPHm3K0x61Kv3c
         h5/Mctj+jWlLDOjOVdvqjoPaAn8LJc1p4JoDyrm16BkaZ/e338nx4FvUy0THZ+spG2J/
         RVBnABzDy9be8oPa+EalsUXxx919mK9rmiTFz+rdV07tNri4X+bErnPEdhuNROulgXN9
         vhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpU/aOZPRzLksSKKcJqrVMtsTCPhbYJlazOXGlrTtXNtsz0mTI9jSWhipa3AHlHkO3kW+xKxAChXkHEIJfc+mS41Qx6P7P
X-Gm-Message-State: AOJu0YwGH+QyKRzWpLC1cpC7bdoJd0Zpe7Jq9g2+slNPZVKBsEW1ANcR
	HF6Vjl9rqDm/tlOICJbpi/jEWrnrYr+dx53/pJEqqCu/sVwQem2088OWfEzLT8Ok1sm8UH5JrH1
	OnIv7truhEmiB21UiAvR3QZybp32rwum1s+/Gn/075F6PbmDtpR8Dqw==
X-Received: by 2002:a2e:a7d4:0:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ec0e5bcd63mr13427701fa.4.1718352594654;
        Fri, 14 Jun 2024 01:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbnj/wUARZGCSnPtpGXrqUaztU9wGKj+7M4hvQP3ofG5dGi2o3qiVT0U3tw/x2CC40PMvHYQ==
X-Received: by 2002:a2e:a7d4:0:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ec0e5bcd63mr13427501fa.4.1718352594164;
        Fri, 14 Jun 2024 01:09:54 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b083:7210:de1e:fd05:fa25:40db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-423047e28b7sm24566125e9.44.2024.06.14.01.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:09:53 -0700 (PDT)
Message-ID: <c4ae602bd44e6b6ad739e1e17c444ca75587435e.camel@redhat.com>
Subject: Re: [PATCH net-next] tcp: Add tracepoint for rxtstamp coalescing
From: Paolo Abeni <pabeni@redhat.com>
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org, 
	edumazet@google.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com,  davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org,  xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com
Date: Fri, 14 Jun 2024 10:09:51 +0200
In-Reply-To: <20240611045830.67640-1-lulie@linux.alibaba.com>
References: <20240611045830.67640-1-lulie@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-11 at 12:58 +0800, Philo Lu wrote:
> During tcp coalescence, rx timestamps of the former skb ("to" in
> tcp_try_coalesce), will be lost. This may lead to inaccurate
> timestamping results if skbs come out of order.
>=20
> Here is an example.
> Assume a message consists of 3 skbs, namely A, B, and C. And these skbs
> are processed by tcp in the following order:
> A -(1us)-> C -(1ms)-> B

IMHO the above order makes the changelog confusing

> If C is coalesced to B, the final rx timestamps of the message will be
> those of C. That is, the timestamps show that we received the message
> when C came (including hardware and software). However, we actually
> received it 1ms later (when B came).
>=20
> With the added tracepoint, we can recognize such cases and report them
> if we want.

We really need very good reasons to add new tracepoints to TCP. I'm
unsure if the above example match such requirement. The reported
timestamp actually matches the first byte in the aggregate segment,
inferring anything more is IMHO stretching too far the API semantic.

Cheers,

Paolo


