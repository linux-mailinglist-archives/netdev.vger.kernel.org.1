Return-Path: <netdev+bounces-119423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05559558E9
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E6B1F21905
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31A9155327;
	Sat, 17 Aug 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wb8Qxq0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8A1547F2
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912004; cv=none; b=cYonb/SdselsOr/YisKOYpNDSk8087EvEoWh6A7ebHZ+YdKX7o1d0tsI+VemuqKm3WpW0Ks6VkHVnjkO7kbc95cRMunvakUyY6qHcwNChbz5pLDJTmWktW3/8q/jnXwBvpOyDITIFrl4XZII7xVIzJolYsEF+9dUpbT71Jj4ohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912004; c=relaxed/simple;
	bh=9dkMY8jFzFQfn6EKGYFPV4tiA60zbFODArOLJ5YzeIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbV+smICeRpt9gCWNS3PMN+t1IZAsBohaI1acNeKf5VOlKBvAk7WLmkpEZg/NBz6ycg9InUu7vbef1CwfO1VBxKW3kPUOniM/dG2KNPFXm+7XDS4DvyUL6+keHpH+PrGU7xvilN+UYr8KZuMUeYfiqgMWxmw79+DMdfKmUnwplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wb8Qxq0Q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371b098e699so322195f8f.2
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723912001; x=1724516801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=Wb8Qxq0Q6QlvbrL4LYHVdGcdP1ReqQ6RM71H9fGG7sYMu2jIALrtu4opf2UmjB/bDW
         EttNaZssMQoiZ5rBDaPL3jPPV56ajuJx59Z98XGZWo/EZ8HZEjBVvp1SZxOwQcJnm5HH
         bUJgmTz4wZmxQT05vumNN2OOUSwr6LKhmtKYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912001; x=1724516801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=guYKm6Dv2kt9F5YEr9dnAZpGdIjgReX7n0WK5xwfNJJYY5JVZsaekweWV0cFCX+ZGB
         ArS8CkjyipVogMoemqKitOei6bQU3ArjHjlNcNJLEfCdYfm5S97UIryAefoISkBYzGMs
         ZBUSivfPGrAi6NPbALoJm+HbPGEbIHmzfFL+RzbGzybX+5UKWIl694Urdak8fPySH6Y5
         z9V7I9KSDTufFpCoccKAmT/xt5WC02DkK7D5KEapglrKa/8+IdMcjH9n+5Ssmt7jhx4p
         CHOaekOqwPKMJhDeqX29bJF/98+GAhZ6KouB5xUYa4gQemQtMKdPtAOPpVf2KVlWHgxI
         5WtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDBHyXVOw2TBs1SRrGTuMrGFKNlu0VV0pngW6WcsmQxdElbA18IH1EB6pGo71DahPJRZWCclh46wHm/KBJbny8hfrPuLmi
X-Gm-Message-State: AOJu0YzAnBjZpkbzIAM7q4NBZguh6jukEiVQqaKtn2kVs8W2v2qRKEIO
	hqziSakLb93sUa3H6Jav6MZnHs9ifXAnY6/Y+DPvJqLIto1x5qb+rZrvhKUUutArSEWp7UQr7oF
	rcyTBzA==
X-Google-Smtp-Source: AGHT+IHxvaDhLQvAjPJK8gujLoHOvgoayMi/6g7UN8sodF98JiUox16kH4mweXCyMatYO1K6gLzPUA==
X-Received: by 2002:a5d:5a15:0:b0:371:8e9c:e608 with SMTP id ffacd0b85a97d-371946a1a0dmr8285566f8f.52.1723912000690;
        Sat, 17 Aug 2024 09:26:40 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c67d3sm417758866b.1.2024.08.17.09.26.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bed92f638fso502193a12.2
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 09:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXi1CosyaHFi3SoZuhNP0lO1+n5u2YEg70iwk1wSQNKbpW/uqRR1FVTw1xCxEKnSSX/fTWD82FCoA4pVrbaqbzlRPR9LiVT
X-Received: by 2002:a05:6402:278b:b0:5a1:b6d8:b561 with SMTP id
 4fb4d7f45d1cf-5beca527ec4mr6027442a12.9.1723911998605; Sat, 17 Aug 2024
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
In-Reply-To: <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Aug 2024 09:26:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
To: Alejandro Colomar <alx@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, justinstitt@google.com, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 01:48, Alejandro Colomar <alx@kernel.org> wrote:
>
> I would compact the above to:
>
>         len = strlen(s);
>         buf = kmalloc_track_caller(len + 1, gfp);
>         if (buf)
>                 strcpy(mempcpy(buf, s, len), "");

No, we're not doing this kind of horror.

If _FORTIFY_SOURCE has problems with a simple "memcpy and add NUL",
then _FORTIFY_SOURCE needs to be fixed.

We don't replace a "buf[len] = 0" with strcpy(,""). Yes, compilers may
simplify it, but dammit, it's an unreadable incomprehensible mess to
humans, and humans still matter a LOT more.

                Linus

