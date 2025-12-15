Return-Path: <netdev+bounces-244658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E96CBC23E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 01:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84FD23005EA5
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 00:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964EB2E7648;
	Mon, 15 Dec 2025 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="cHAbBHJ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2C202C5C
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765758228; cv=none; b=CvR0hJhUXQYL1RAgt87PVXmb0VndsZe+3KerQvuSxqXbaY2BozafnrYobhSSrDb071l1doI8N8pGamKp6hNqY7he2nW64vi5xiz4SsthbxklvE+1fo2mPchYW8/Vz9Toe087s1JNfGDaItbs5G1LksUAuwEWShazNvwYZwc3D64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765758228; c=relaxed/simple;
	bh=CMG7Rc09Ecs8W0UZdIGb74+5K+6Xqvuiw6gqiTzvfNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eoc41M1dP3PwOqQr4EP4lZxtONiJqx7B9iR+mNMof9rBSnU9xx/6UVLP5CRok3Xb+UaQfB+KM53Bgc651Rv/pwAvd8VNosm98FSZkZRKfTSRHVXscXf/46R29CbfKr7J2T6J2qoXWnIGSq3OyhqaHpw01kQdgIgAqLkZ4XKRqk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cHAbBHJ4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d52768ccso7409785ad.1
        for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1765758226; x=1766363026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlCKrxLybqHjLRhTvOIn7bogNdT4SoZaH8wpptd1dKE=;
        b=cHAbBHJ45g9kC4M7+blzVjtFkgnqu6b6bESGTld24oRkhe4qQxMlAl+L5XgRwTp78O
         corWN/1IeW104I7+l5CGfY7BkZPF7Lnj2UyLxzF1u6bmzD1RFdB7UvQ2okfUkzD9nbEh
         dBgEOZvnUPWmgu3vqOLISksYWDsw8eblsXVRAJVP5T4VataHNr8Uxm9wFR8vRGCtp30G
         n9fGcYJooNH/EM8N9E+ktprREFeJdgolwpaY+CMqQz0r/lh5EhRdPX5zXL1OfCjqa05s
         YkFGhN+ucSaCgxplGvfqO9cpx0RDE0mvqHmUagSkUNwdQDnYfk3gMx3cLN2B6mSUqeO8
         gbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765758226; x=1766363026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlCKrxLybqHjLRhTvOIn7bogNdT4SoZaH8wpptd1dKE=;
        b=oeRvDIYnJYxNyFHP7fbP4wL19vsXsvkBj3Hs3PZNShCz062sh1vRm+3fru/Pa8ZQ50
         x0BfRyYE6NtWu19o04tp9mgX+duXMfDWTwuA49cu4PzMrH5Ds81/HRrTYvZmmanDWwlC
         Srk7AxNm7/mu7HP5cdnudxQ5falGPnrmDnndcq+tCgusqq66ywUyEgD8h7phOIle+6YR
         C4OByCiSDc2r6obQrm4/I+0qlGsNt3V+VxV/DxWc76oPpwHTrOw1zqNY4rz0ZwD1oojO
         EG0WtdmAdonydsNpYS6HSav5D48iQxrF3HJT8u6c+LofRAUhF9jTHRTiIV2JEABqRBlc
         oJLg==
X-Forwarded-Encrypted: i=1; AJvYcCXdsjt/nqhEQBNe8I0Ly+fPRcdgOBon5lrAYzeiuVxzXalP4d7dl3/+qPMNSNj60PZA7OOTkKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmmdwRRy+88eOShhzVUO/rlOfdd9vKY+C4CWnDeGaTawxeiP2d
	94k5xTm8yDg/gjpGdbYjRgYh/z4c7d19Rn9Yq64EvcuVu6slMy0kMPn7CSl/jnOGmw==
X-Gm-Gg: AY/fxX5q2u35eITQjZvJwCPMKu7S8zxad8kIHE38w4Ae3BEB1TJK6YnQiXvFC5mMoKf
	Nuxv0kf8hgM4OYmYlNT9+BCPOB0DhPt4JxvrJq26YaFIeYkqftzOYQea60WZZr+hx1tIwWgndIi
	IIksryLWcIM1WDuEfqG8JiPS8fgh6JhfXSN9RmEwdjpUAZBX/7Vt/ZHQEyTigvjAmSKGj8ibuC0
	aZnA23EgGAH4NGR94QSRqnsrmgsdocJZ1wWU0UwqF77jqy7udydVhvVzRlzk7jZPBJzaZ9o51JR
	zLmBpDoVJxQaaBeM5ud64jCGOeWyryTFDRiV1LP37Xj+3oFN3bVN5B/BN5RbirqXhnUuPCQAYdN
	RJQWGAWINKBozN18ZMHYDNeY6O9v4gjZCh8DnFW19hZ3INF2wU2kkO5Z48SUmnkVzDZL12T9aNY
	hAPHwG1PZUJAflfqi9
X-Google-Smtp-Source: AGHT+IGkS9yQah7qQoen+qo561a83AlrIP2VlZu5WfJUiEuNJ4agHM9GriGNSE5AdQvnalfJ+uKTog==
X-Received: by 2002:a05:7022:e20:b0:119:e56b:9590 with SMTP id a92af1059eb24-11f34bf9f44mr9321442c88.21.1765758225934;
        Sun, 14 Dec 2025 16:23:45 -0800 (PST)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb2f4sm38718530c88.3.2025.12.14.16.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 16:23:45 -0800 (PST)
Date: Sun, 14 Dec 2025 17:23:43 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, security@kernel.org, 
	netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [PATCH net] net/sched: sch_qfq: Fix NULL deref when deactivating
Message-ID: <mhp4ctfcrwebw57lnq66pqtqlcktzkubgt2f3ikhomk7ouyt5k@hs5qjwj4vxex>
References: <20251205014855.736723-1-xmei5@asu.edu>
 <4mxbjdgdxufrv7rm7krt4j7nknqlwi6kcilpjg2tbcxzgrxif3@tdobbjya7euj>
 <aTYDlZ+uJfm7cQAn@pop-os.localdomain>
 <CAPpSM+T51DDkcSehkc-3r3FbcYQzXkTq4LGx8RRfD2fACwM8pg@mail.gmail.com>
 <20251211182303.5251e1e2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211182303.5251e1e2@kernel.org>

On Thu, Dec 11, 2025 at 06:23:03PM +0900, Jakub Kicinski wrote:
> On Mon, 8 Dec 2025 15:17:57 -0700 Xiang Mei wrote:
> > Sorry for not explaining that. This PoC could be complex to use TC to
> > trigger. I was thinking about the same thing: transforming this C
> > program to `tc` commands so we can have a tc-tests case, but this bug
> > is related to a race condition.
> > 
> > We have to use racing to create the state mentioned in the commit
> > message: "Two qfq_class objects may point to the same
> > leaf_qdisc"(Racing between tc_new_tfilter and qdisc_delete). I failed
> > to find a clean way to use `tc` to trigger this race after several
> > hours of trial, so I gave up on that. For non-race condition bugs,
> > I'll try to provide self-tests.
> 
> Speaking under correction here, but you can submit the test as C code
> to the tools/testing/selftests/net directory. It doesn't have to use
> existing bash tooling. It needs to follow kernel coding style as Cong
> alluded to, however. Ideally if you could rewrite the reproducer to use
> YNL C that'd be save a lot of netlink boilerplate.. I think QFQ is
> supported by YNL tho not sure if that support is sufficient.

Thanks for the tip. I agree that a C self-test case could be a better
choice. For this particular issue, writing a reliable YNL testcase is
unfortunately time-consuming. The hardest part is hitting the race
condition between qdisc_delete and tc_new_tfilter:

1. Build qfq_qdisc, qfq_class, and attach a tfilter to qfq_class
2. Thread 1: call tc_new_tfilter to have refcnt++
3. Thread 2: call qdisc_get to delete the qfq_qdisc
4. Thread 2: create a new qfq_qdisc and a new qfdq_class
5. Thread 2: enqueue a packet so we have the leaf qdisc->q.qlen++
6. Thread 1: refcnt-- in tc_new_tfilter to trigger qfq_reset

As the procedure listed above, we have 3 things (4 syscalls) to do between
step 2 and 6. Considering the time window between step 2 and 6 is not big,
we have to make these 4 syscalls faster. In the C reproducer, we can
repeatedly call these syscalls to warm up (faster syscalls). However,
using the commands makes this harder. Also, the uncertainty makes the test
case less valuable.

For the C self-test case, I am also concerned about the time cost,
considering we have to transform the C reproducer to a format that is
readable and maintainable. As a security researcher, I understand the
importance of having test cases, but for complex/hard-to-trigger bugs, the
time cost pressure could be concerning for the vulnerability
fixers/reporters.

> 
> Two more asks/questions
>  - could you please add the crash info to the commit message

Thanks for the tip. I'll add it to the next version.

>  - there is a similar code construct in qfq_deact_rm_from_agg()
>    does it also need to be fixed?

That's a good question.
The ideal fix would indeed be to consistently rely on the active_list
state rather than cl->qdisc->q.qlen for all qdiscs under net. However,
in this case it appears unnecessary.

> 
> And a reminder to not top post on the kernel mailing lists, please.
> -- 
> pw-bot: cr

Thanks for the tip.

Best,
Xiang

