Return-Path: <netdev+bounces-184302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D105A947EB
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 14:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D9C188BC7B
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474F1DE2C4;
	Sun, 20 Apr 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cri1YXgG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458D9262A6;
	Sun, 20 Apr 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745153939; cv=none; b=KTbjlx/dSf6x9ylxZd4p2ydHRoFVzazgWJ/kW8+u+H6rW8AbfbJdyKow0KdQ7IVOzYRgeTfO2YlBRBj7QqgQCR2L6WZfEct+TswcGH2Oa3N2G05989GjFZvdrti8LHnfA3YUIXZYbjUNYEcXcrujpCyktX9qWxb8yFEN5ZyZcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745153939; c=relaxed/simple;
	bh=UCZvDwV/3O+qNBEYL6pnnrYcLnAJfQKYsFh4ngJIuDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHcsmznYHB8TOGhR1+4dwh5e9hub/YRENkf3mtxktXfOA4xA2gAwSxVn5Ce63btUsTsSuLP66j7XVm09AmxMzQf90OdvyH5DS7t3pMVs4KOKquSRnNsLduNXHYbucOn/JEqhYekXUyny7ALvY2n0zbBXoQsL7XJ2zm/jWfFb4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cri1YXgG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af52a624283so2695946a12.0;
        Sun, 20 Apr 2025 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745153937; x=1745758737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UCZvDwV/3O+qNBEYL6pnnrYcLnAJfQKYsFh4ngJIuDU=;
        b=Cri1YXgGKBXp0eplATWBNb8mg+6BTtbG49WiFei3ZTPoTjiG5AiDsKJu/jVYgJE18W
         o+pzEd8HD3oLiT2Up6ohQyztmYSwnXPuQeKW67aDqMMJvWKdH9EjngIwN6cOoHYvdI5D
         1L8Dyl/nfZDsau7AgIGTOuHv4Zwh+5j+Bo9qTSurpWziPi8zWqp+iLqLIv8D6BQDEGaI
         sCYmpMEAexFGd454kLe7lyjUL/5asW09QLPuMOtwsDfTB+vPB0v7PlmOjVZCm+J3wr89
         7ViP9624B9N2wbEihvJcebtCLcJpg/aFmkZxBqQfuu78DHhOghuqmhgd3JyC9pewyjTA
         Z6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745153937; x=1745758737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCZvDwV/3O+qNBEYL6pnnrYcLnAJfQKYsFh4ngJIuDU=;
        b=D1S2St7WzLpB3B0bjz6kYke1w91yCHmGYdQfK3O3+3mJxg2TD2k1ZijrWFssbAnZJl
         JRDIJ0/kQ8+icXuf8Ut6emweKs7LCiPYOW3UuzUscubi7KuNA9hfsrvDqFxDmtY4HO29
         mLZS9BdZI4gSgTq1o7MJLXBVc4kqwPovbSShUX42KEl5IhlzAr7HbmuwFKhAVv+0E9C+
         hS7QdHzmuqiuz9lkOfkKQIed3RF20aWWJ3Hx/QH5wgYAnMvMIKRQXjnWCgCJDWkXhaH7
         kT8Fc6DycNYo4I1F03ZXVQ2D1SbcX06/JjIvUsBBq7hDzKCkLyO2wRR3Vztfge04LqC6
         0cwg==
X-Forwarded-Encrypted: i=1; AJvYcCVWagQMhIC+VXZ5NLF1BQaZckPZknkvfKiZJI8i7vYrMXjA9no5LWe2Bngh3YHVwKNul8cWEL7dTJ/3HVk=@vger.kernel.org, AJvYcCWI5ruqcxwzDmSeeFeNA6obtxtruHieaE9Xr0e5Xy3lqmqmHwiY2NVU9BQpzzLULmoYopDK5YEJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0iih5IiIZ+aWcqSE/xbqe8vNGzLIpqPl2bJ3G428m9Okze28w
	tx68x9wtPHsHYTZYzk7eKR0Re5ZmYKF/+XyE6IH4a7zRd87bPojA/fNl4Kq8ux1dvzsEFgNtfQa
	1kKOJJHyYvSq6klcyJgSoR0MEyA==
X-Gm-Gg: ASbGncv6+jqNyrKev+dmg1lo/55V/9De53McoLS2A+JCjuaoC0whYUH5TlNK7wW6bUB
	hzNyQubI8EOnFCbNM4+5u2BaoXAzkLvXIPyYPInvJyHW3VsURDHpx1NXZ8GI8zG5VWmL4HYJZst
	vd49+y1//C1QFWN2UpbzMIi/fEn6ErDW3IpzRC9DbSi7jnGhUhyTzqsA0=
X-Google-Smtp-Source: AGHT+IHtMeXmS4UKgx5A5QB88cc2HxcM6scLRIB0dHKGqExW1c0WFSB5gbD0xJtGTuW1xFeUYM9K345PPIhrpAwRSyc=
X-Received: by 2002:a17:90b:2802:b0:2ee:5c9b:35c0 with SMTP id
 98e67ed59e1d1-3087c2ea0fcmr10981397a91.9.1745153937273; Sun, 20 Apr 2025
 05:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALkFLL+LxVk+M--+qHiP6g31rcvXxBGRJpKvp=CCFekL9OyUww@mail.gmail.com>
 <94abe22f-ae52-4bc6-aef1-4378db38f494@broadcom.com>
In-Reply-To: <94abe22f-ae52-4bc6-aef1-4378db38f494@broadcom.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Sun, 20 Apr 2025 18:28:44 +0530
X-Gm-Features: ATxdqUEeJUcRFWQGEjAyEzo5cG5q_EHvWSmcHW3NQF-xR1II9mKcyHOkRYwkZmw
Message-ID: <CALkFLL+gBK0v8nG_fRTgqg44+E7caMeF=nNpiTnJLVQ2q=5Njg@mail.gmail.com>
Subject: Re: [ethernet/broadcom/bgmac]: Implement software multicast filter clear
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

> Given that these controllers are always interfaced with either an
> integrated or an external Ethernet switch chip, the design was done
> assuming that the switch will be operated in managed mode and multicast
> filtering will be done on the switch side.

Thanks for the info, I wasn't aware of this. I infer that this is
relevant from your message and the codebase:
https://docs.kernel.org/networking/dsa/dsa.html

If I understand correctly, this TODO is basically a no-op because DSA
already implements `dsa_mc_add` / `dsa_mc_del`
for handling multicast addresses on the switch side.

I'll hop over to `bcnxt` as I see some TODOs there, or find something
easier to work with for starters. Thanks again.

--- Ujwal.

