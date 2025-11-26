Return-Path: <netdev+bounces-242015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA6DC8BB42
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050B73AA51A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12055340280;
	Wed, 26 Nov 2025 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="CLHPpxHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917D33A03D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186519; cv=none; b=Y91Ar6sHUqSV6S8NaT5ejucGAs/8l8hV19eBhRTeodx/j5nCgQYytQY8sVzICFYab/eyOCFbaNtdH6CYzXfq8/EuVTtz3aEV3Hh5zvMEDbWkqmDKNYUo7EQQTZ6YvK8vcG2zaiSFjxphRPVxdGhvhxjsTujBVGkYrjWg54JWO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186519; c=relaxed/simple;
	bh=4l/eVF0LjRuyNp3BZsNWBZgkuh53B6k85dZFfS46vYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfwk9FpNicYaaDwklAXjkql0k0UlLC5D3gX/sAU8VEDOfl/WyLT7e0aD5Mw2oN15qoj7hlIOvYXUQwkNv4xjdvlKupSZGoARpkEeoyjOXIih1qZueWPqpYX0OcahY1Y17YtKRHQ8bDcLHEkr8epzFPAox/pV1Vxsh8X4r4wOvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=CLHPpxHm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2ea2b9631so9098685a.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764186516; x=1764791316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFotFf9eRXbFpwRIPK8Y1pStWXq1Ooupie4cSLAWHYE=;
        b=CLHPpxHmHdLzjyc2a31ELPXRAaupMFltXVdp6I7rQcuCQRjhyykyX4FuoC9n6hl6tz
         ASfOMsffDvlvaYIwchFo0FL278s0+pMNiqP96Jmx74G+i/SK1wxnLzhbxuSWzxZiC9zq
         D68rBg5nk2LM+vh/ythpmf0BiG+yXS4RUKXtPHXVBeKoCzsyWQNi6Aob7pbQzred4AQM
         lWjpcHxqjrCu5KKg8G9H2CqbHOrJNdjiBWhvCVzbAe+uW5wB/HcIaOotmaz1GOl4c1L4
         7z0CAdUCvX9PRpuVZ+efoy/zhHjFAbh1sy7CBaxr6LImHa8MM7ZajndPDZzu75+CQ+YT
         2l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186516; x=1764791316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFotFf9eRXbFpwRIPK8Y1pStWXq1Ooupie4cSLAWHYE=;
        b=nnHyheKYfUVlBz33ylIb32mADqny52IAQSGsEumd8jnGQbyuU4UN2sjqRChth1X1kw
         HJyqCKIKHathXU5XD3ZVjaOOH1fqZZ8Lmf1bzzXfScW0j4Y8d7SsC35qnNiB7oTwlJAB
         QpixVg02ASPbl70LUu4J0nGkyle41se5T7SqxTSG1gnz+2fUBHRr20YJuYXAyQu8y9T9
         llIsR0RzX9h5DRUJfl3hTDZ9k6RrHx6jX87zc3AIJJT4juq+F3UXGURxbogKQXehEwFR
         WDyIzPAIHDXUWq58by1h8zZUCeccB0AjpKwumfyhCvRBxnjMUloNPxhfS+m4MRXaJ0BF
         jCBw==
X-Forwarded-Encrypted: i=1; AJvYcCUjIXJ+nxwF3toOVBYrPI+vfRrYuv1EvcfycrtwkKJhLsGZAK32eJVjMaO/AjH+Z7f8TZQZFKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6L0xmajmQ6auLLmlEd6uyawUaKzxQQi5Gwm6ezMq5v3L+pg/
	0/zhj95dK37gG3C9X+xv0LWZ44Kq0sZCDUoWNWxAMO9e1YZQCexP+bb7Gap47EArzi+qTWvI4RH
	dsznVabuvVZlI8q570a9HT/SBEmItfWM8Sdlr0Dlk
X-Gm-Gg: ASbGncuUkk+khkBFzfi4qkGMWjl3RFSoDH8On2YgsDdQ8U9JOyWgaLg5MIjxEJJSBwe
	FoJBkdXIzKCSOYYtM3LENO/9h2u69f5qCoMvST8YnWsEL7EZiwNVZM3ThRrtK2/T3ELfZJzGBts
	BW4zxpY98eU5pWO8kgjQIR4bROWJOjtvA0hsh0rWH9MrKn7JxlxHyNv2OvZWVtg14jSrrjQNj2f
	DaAfzsejY+bnE3eXLZmFBcG6JSlHkmdeSuO4o0Edj14v0UN7+Xsd/M1+/T6So2qThzoEBfN
X-Google-Smtp-Source: AGHT+IENrgViP+CJjX20jMp6vNHT546q8bzoXHJFb0lfZj5ixlrK/z5Tv9Mq9Nyut67ffu4w/nPa/B0AUGPOFzYFx4c=
X-Received: by 2002:a05:620a:2a14:b0:8b2:ef6c:802f with SMTP id
 af79cd13be357-8b4ebdbd606mr951117585a.59.1764186516257; Wed, 26 Nov 2025
 11:48:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125220213.3155360-1-xmei5@asu.edu> <20251125220213.3155360-2-xmei5@asu.edu>
 <aSZ9QhUImq0nH8mi@pop-os.localdomain>
In-Reply-To: <aSZ9QhUImq0nH8mi@pop-os.localdomain>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 26 Nov 2025 12:48:25 -0700
X-Gm-Features: AWmQ_bnZLgaO-xI4nwZnXo7XsCIxODjbujQeVlbyfZNDMBHPfOXW9JHL9HQrTRY
Message-ID: <CAPpSM+TZoqTUYvy=NjNJVN5QaScJ+YuCGghikAW5nxCr1R0VLw@mail.gmail.com>
Subject: Re: [PATCH net v6 2/2] selftests/tc-testing: Check Cake Scheduler
 when enqueue drops packets
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: security@kernel.org, netdev@vger.kernel.org, toke@toke.dk, 
	cake@lists.bufferbloat.net, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the tips. I have sent the new patch: I moved the test to
qdisc.json and tested it with the patch in 1/2. Appreciate your
review.

Best,
Xiang


On Tue, Nov 25, 2025 at 9:08=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Tue, Nov 25, 2025 at 03:02:13PM -0700, Xiang Mei wrote:
> > Add tests that trigger packet drops in cake_enqueue(). The tests use
> > CAKE under a QFQ parent/class, then replace CAKE with NETEM to exercise
> > the previously fixed bug where cake_enqueue() drops a packet in the
> > same flow and returns NET_XMIT_CN.
> >
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  .../tc-testing/tc-tests/qdiscs/cake.json      | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
>
> Usually tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> is a better place for testing Qdisc combinations.
>
> Regards,
> Cong

