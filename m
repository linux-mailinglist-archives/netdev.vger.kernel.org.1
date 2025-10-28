Return-Path: <netdev+bounces-233572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A301BC15A66
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF756777C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3687F33290A;
	Tue, 28 Oct 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zD7qzO2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A232D0C4
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666802; cv=none; b=bye4W4SftMYYAaAAtUGfvRA3A1IiXfNlWboe/mhASo4v7g4YcDA+gqnEOvwr2sluFmuvTJdvq1frYZbuVhqFOMVOjoLpg7rhlXLrw4AEEMpqePOs4A7bcEaJF4EiNtxgonSjNlj/FVaIjb0T0x1hoGDepZ5iNsTqEZbrNbdQDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666802; c=relaxed/simple;
	bh=bvubLNry8i2KgFkZtrgq5oxD9xLD4eBmItr1+AV//cQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTC4d+U3p9vJVLwT7vbu789dbwrwpTFXb+3ytjvgny1iI5pMKUMnsEiywou7gbdc6uWva9pboj+A7eGqY1YO0i623MQ/eXmYgtxPLUuZuTKMlOGxBzazuZMaUFAoM0cN1+cArir3NBkIGs7nMn+49eiUzJm1jZmH52sqLDWdqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zD7qzO2c; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-336b646768eso6344108a91.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761666800; x=1762271600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghHNPpIkVrYu62/YqFMFKRWudpG1mODk+3kt3NmNBok=;
        b=zD7qzO2cJnFg9n+oilba0f/J69xmkMPbY/mbMWM6V9Pf69cL7kWebvmq/BK3PCBWze
         BMfiRW8uiuumUlyRvm/Um0ih9HFx0ecFiUwle4RetUGUGt8/S8myskPuUKMid5GoPuUG
         OMvHYsQms202Czb+FvR1ttrm31VUlHesNhgW6g6Uc/P05IpGyms0MXpj5ACk/mewW4KE
         toabygEvXx4GJMSGbx6DFUHZdmtPqEgB/x0Ow+aCTibpviTSy+hqLUfdjNaRXecq4JsN
         U/cnt6Cn5EY76Av6wRk9mZOOpmvw9O+hmj54eLptI8uteBa8nlkwbVF8X2fv191MB7GX
         XEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666800; x=1762271600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghHNPpIkVrYu62/YqFMFKRWudpG1mODk+3kt3NmNBok=;
        b=dJlu7hs5rvDocmXwHhujZ9JD5v1aMT8xb9LxPZISnFfCAzfVwnqTGI1nfZ+EAb3JpB
         V/FoPBLmo4iho3Qx9raOdNXodjKOONJFGhvVvHuXLO9XeV0+th4/lS1h4QZhbaV/oJ7a
         Gm2g5jFa6bPBbgjgT30VRxZanKFIerUJytAxILbs1AsXzyHuDB3a+xCEKUDzTWIRkdQX
         Zur1IJwneL65RzTbvtWCQZroS5tlkS5Ipj6sAaIzYatX6zhoeXsVAXskSfpW32rRJFHj
         u5qd3sf2TJlG6aHsoyTRIPiMlMMMAIXmFoBjepdP/Q3nlwinw47aBRO7kqLG3YFBmCzy
         Brvg==
X-Forwarded-Encrypted: i=1; AJvYcCUqa5IlgDKlpGv40xqr+KL6Xh+FmR5SrA4JgDNPLSAvj7J6hFOcpJlpK/4j5U0XQkf+K3KnSLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjEyGqdCs3m0PhU+xCvCzlY2k4pdaSAtW1JOlhdCqppeqi09x
	aC8NuLEUgsbHV6bQGTNCARU1K2rIDerNZm5c1VkIES9cnO5tEtJXKA3t5v33Dt3rehcSYuRs5Vx
	Pxuww0Q==
X-Google-Smtp-Source: AGHT+IHFuR5DYWudiyV7h1agovuZqNOF3NC0YcpaGD25SCPgJSDGq9HjUwprk8+VKQsrML4GoiDI522EkQ0=
X-Received: from pjbsb7.prod.google.com ([2002:a17:90b:50c7:b0:33b:51fe:1a94])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c8c:b0:33f:eca0:47c6
 with SMTP id 98e67ed59e1d1-34027aac14fmr4416665a91.30.1761666800026; Tue, 28
 Oct 2025 08:53:20 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:51:50 +0000
In-Reply-To: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028155318.2537122-1-kuniyu@google.com>
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
From: Kuniyuki Iwashima <kuniyu@google.com>
To: richardcochran@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	junjie.cao@intel.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, kuniyu@google.com, thostet@google.com
Content-Type: text/plain; charset="UTF-8"

From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 28 Oct 2025 07:09:41 -0700
> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
> > Syzbot reports a NULL function pointer call on arm64 when
> > ptp_clock_gettime() falls back to ->gettime64() and the driver provides
> > neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
> > posix clock gettime path.
> 
> Drivers must provide a gettime method.
> 
> If they do not, then that is a bug in the driver.

AFAICT, only GVE does not have gettime() and settime(), and
Tim (CCed) was preparing a fix and mostly ready to post it.

