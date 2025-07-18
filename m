Return-Path: <netdev+bounces-208239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CD3B0AAC9
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596824E0161
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF20207DFE;
	Fri, 18 Jul 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3p+RQP/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020016DEB3
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867807; cv=none; b=sqCqmqVGE/kFFKkQjJygXfPc7cE7CWsMsC+Vw7OFohzG2GJMtA/df8noWJpPgaEqJVV3AWdTjjgt3j4lzDXIS4I72xwcoQXP7xItPStoVUUjl7M6I+2+BHa0WFoQfTQPxla+vVhZeLrMwsE3t4bpNgRi5Me+AUFvDZn1iYXGnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867807; c=relaxed/simple;
	bh=vc/VmrFlxVzErcEnXYsYhkbv5gOEzwL4WbWTK/AkNlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2NTPaa559WEzQsIWSiulAKVXO/8uasjv/02GBPbHwVKMXdC5s1E3JtTbdRjPvCrb6uAiWNMpbOi5HPvMd000wrd4I3JSAOr1MVds3d7ysgQhaOoP45aiSbqVHjGpxcv9+/SPI6tGh67KSQXU1kz7QcA+XbuXxCoZZ8bVyo6TAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B3p+RQP/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73e82d2ec52so226529a34.1
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752867805; x=1753472605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjJRtDB28HQJv9zp5NFeh6mYhC6w0nhNqDSOYYyUWCA=;
        b=B3p+RQP/q4ZrerntshpWQM56J29cne0mJh2VmY8yTmqUboudx9tixa/5DaWN1zVm50
         4/dkKt9+gNBNKXkzHHypJPVGgHiT95dSS8mxk6tdp40KXjxvjX85I9bbfWcZ2gXKoOby
         jIOeQmxppt8rL6jCdfIEf7mLyaJ4vqCPNWVvqmJV5kZB7U41RnlR+DrjWyIkx75dUGwa
         xcsE6bAg56RFdtjtwzLcxh/X583Cud+YEGjY/NoI1ZCQh5KVZywhPAVdHXS2tSrSKNSe
         7PwvuMQ9DwAaSvGsFAk67mJ62b6WKjVEZaA2RqpKTCyLKKBb70stuRtFP9H9FggzRbi9
         /WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752867805; x=1753472605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjJRtDB28HQJv9zp5NFeh6mYhC6w0nhNqDSOYYyUWCA=;
        b=DWD+UNaL8QRrvj5W2uTnhf46JgKQDJLJVyOX7tBVEm3J4cjZL2jNeP2sH4KwrEr/cs
         UiLEqXJwtk9QLA79tRZdZgK6bMk88y099r1zimYafo8Ki+2ad8YcxJK9gqCjN7ne7XZX
         zhjW3Ygxb1G8RgS8+VuW3c0mV4fa/00Sc9SBbgpDWshog9Qh2n4gresHuR82FEq+Hnrn
         lrN6oIKfgiR0ZMKDyQVaqI3ea3eeJlJPygqfD9y3Qagy12IxfnzTOZCyYcZ5QaBMWg+x
         tQm+anQo8sCPqSVigE+QCsLF+ekMKLcwmsh9TEIu0WESLpokdnVkr8HvJto/srppkuQZ
         dRzw==
X-Forwarded-Encrypted: i=1; AJvYcCVjNTE4wvQO9OL4hafV5znnVkmcgw6EhXQOzZfOdV8vVjn7rnMKzy5c+U1GCaBOje3zOC1wSQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxR+mOB+0Nm6z/X+AQiVA5cVXWARpN6YC4YHPmSF4zLHl5Gvn+
	HTTKkg5EaUJqWypKVHh59qthesO06GHnCjBoOVFVH4D2XMYF4L1SmroGagVbkb24ZYQ=
X-Gm-Gg: ASbGncvQV2NUMUCMXEK2w0bvRi4Qvwu4Asxzr/jir+naYDThWx8C0a0VQPmZAAR1bDe
	AWE4gy7QBjBB9air3HJ7mLloyCj5wT5vBK3LwG9KnPXNYkB3ZlqPZq2lqLOQhN4eabtbnU64l5j
	+PuhyhXgWVPMoN0N27e+Cibk8DVkx8o4zE0rFq1y/0PzPgOU23HQi1mj1IPVOxfg5MZHfAaTeJG
	BTUViZ3GT0W4XBwjBs7oJl2JBGooVipfbs2tb9N6CNMuMDSqqHhBCSS+spQJjkOwbEA7oIibihR
	Bz5FecIgdXSexKZWsa+sWAloU5gXTV9EyaVgSpMhXNyYtwYJk24IK+yn8oCjCqdhWJi/RI0FI7G
	lvwMmDjBbdQUSjHLOFRqrOlZiKcv4+rG3MMIXnTzp
X-Google-Smtp-Source: AGHT+IHZiCpng4QMWH9sk/7TwE3jJLjJURF1OcF7/mbNHwwtLRhDftAv/ZOv8q0QEV0VJD0Wemyz2w==
X-Received: by 2002:a05:6830:7204:b0:727:3664:ca3a with SMTP id 46e09a7af769-73e65f341d9mr8727641a34.0.1752867805105;
        Fri, 18 Jul 2025 12:43:25 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e5d3:a824:1a57:fcaf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83b5b82dsm864816a34.48.2025.07.18.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 12:43:24 -0700 (PDT)
Date: Fri, 18 Jul 2025 22:43:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Avoid triggering might_sleep in
 atomic context in qfq_delete_class
Message-ID: <01463f6f-a45b-4122-a7cf-8fbf7889fd48@suswa.mountain>
References: <20250717230128.159766-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717230128.159766-1-xmei5@asu.edu>

On Thu, Jul 17, 2025 at 04:01:28PM -0700, Xiang Mei wrote:
> might_sleep could be trigger in the atomic context in qfq_delete_class.
> 
> qfq_destroy_class was moved into atomic context locked
> by sch_tree_lock to avoid a race condition bug on
> qfq_aggregate. However, might_sleep could be triggered by
> qfq_destroy_class, which introduced sleeping in atomic context (path:
> qfq_destroy_class->qdisc_put->__qdisc_destroy->lockdep_unregister_key
> ->might_sleep).
> 
> Considering the race is on the qfq_aggregate objects, keeping
> qfq_rm_from_agg in the lock but moving the left part out can solve
> this issue.
> 
> Fixes: 5e28d5a3f774 ("net/sched: sch_qfq: Fix race condition on qfq_aggregate")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Link: https://patch.msgid.link/4a04e0cc-a64b-44e7-9213-2880ed641d77@sabinyo.mountain
> ---
> v1: Avoid might_sleep in atomic context

No need for this line on the first version of a patch.  It's just to
track changes between versions.

Anyway, looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter



