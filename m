Return-Path: <netdev+bounces-180010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F3DA7F11F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CE93AE229
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E822A7E5;
	Mon,  7 Apr 2025 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="oeEvrwgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A8229B28
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069179; cv=none; b=tfGvfjne/kYLglpDcbZTs+1dvFBVvnk10cscfo+wKwcY+XfWp97KBvEkgbxe8w2sfp3pK8kQBy12j8g2OZPcrEtsMHtyJ+0fsC/W7GrbNg/iP/FRSPWQf/Dndh9ydsN8AWhZbGETrh+UopWlK4Bue3u7GnCDglJ8V7qXKdddmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069179; c=relaxed/simple;
	bh=3UH7Z7Dq8GEREWQ6P+Sm1ZE59Mnz1DfU7JXq75pFA78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhhiVN7Xhj22SzsdbwUpBf993Q7kf5TFvLSj/7mQtCY3DAyquLKB94nab1QxJqnhQHBsRYRNT1lgDxcMB9FcyOl0bskDyG7mIYI+BxpbfEH+fMIwGzaxzm0ERPwwsKi/Y+gBlnr5ktxHRyXO0nj2y75NWuz6p7nSKKyfX6L2dlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=oeEvrwgi; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6eee95fb531so4368616d6.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744069177; x=1744673977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3UH7Z7Dq8GEREWQ6P+Sm1ZE59Mnz1DfU7JXq75pFA78=;
        b=oeEvrwgi59Ho8A6y8nD67HJS+7fjlVyHR8W5RdVNr5cEY9zPHUcQYwntJCSyy+GFhd
         8eF2xpEGzgJiWnoJCMVdBA4sdn8RU2oOX9giCUQtX/sK/5wEr0a5y9tWHtlgJXpJdSYR
         1K25zYDTc5JYd2UzIf+sQF11ZbVoyv/Q+A5gAVp2ToxGwxQ2UPUs+KZDt2jtZrMPrMa3
         PpJadHCCm4zH7bJ7K/WXCo2Op4M0pkWxiyrhQ6M8iRR1RMj0P685Cq9pP5aeaPNqUk/5
         WDm51Ea0aOg2lio7qBXf++yiSsQnDzLXgAjLFXbJvSl2KK+IDjXRNv2+IWWRCqyTCD68
         pCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069177; x=1744673977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UH7Z7Dq8GEREWQ6P+Sm1ZE59Mnz1DfU7JXq75pFA78=;
        b=qnuoSXxfj3a+YJNfLITresa2qfD3HNRbOu0KAQMar6dXVTkXSFy+GAUaGQB7P/BYH3
         Sx16VicSjCZS3D18OwcG8XlisKzUQLGNq3LHzZHbqj7fP09Cz4w1Itmc2Vje0kJXhWt/
         lXyoxnm1jJRGyQ2andEltGFdPHNJ46GdERU7BXaLvINsybfrjUphCYFLUR+R/QcpXdfi
         2lEdX7mV4blApxDcTAou4uhi6+0rpIdTkrt+GN4yUZl49gvSelgQOUG4ReYLMXLdsxHo
         Y1d036xUZUMNwUZavVN4zS6dii9YN2pLwV5xR5DRkqUc9XCWCPpsmSanqG+nOkdnszfJ
         xDVw==
X-Gm-Message-State: AOJu0YzdMhWOYA9MLf+7r10sz/J8U6JTS+MOl3OZkV8gPoBUVE2Fo7pF
	NjA3uCNqzY1aquX5L5AswMTOdwzZK5I0WE4WD3h61J29Dg5sm0QkpOx5PUqyq17/a5bu5/bdwdS
	JHogzQoC7Za4dvn53TCUNRTkfpuBpBruIbJ4org==
X-Gm-Gg: ASbGncuZGOpwRwdjJPl/HO4ZDBL2DoK657MtUWfQ/Zq2zXwwgYulGe7Z9udRj9Acl8A
	flaW5gELHvEKSfMk/KotKA6/Hl1ZINCCe4AoiF+xYF80zaRN9K7JKEicZhFp7Hz7wIHO7bfqira
	bsEflR7MEyET5f3nTEMrlCiGNV4VQTDyAsYClWw9AOIdBhKxCc+wplqH30Lg==
X-Google-Smtp-Source: AGHT+IHc42AQVEkUwmZmXJGyXnkAedrIOrsc4+/x3i8NlRUwiXXfJffVYHjAOYvbfVZebfi+P4uO9GfeMWy1QYlRqng=
X-Received: by 2002:a05:620a:444e:b0:7c5:ac1b:83a7 with SMTP id
 af79cd13be357-7c774dc30eemr752344585a.12.1744069176967; Mon, 07 Apr 2025
 16:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404220221.1665428-1-jordan@jrife.io> <20250404220221.1665428-3-jordan@jrife.io>
 <58bfc722-5dc4-4119-9c5c-49fb6b3da6cd@linux.dev>
In-Reply-To: <58bfc722-5dc4-4119-9c5c-49fb6b3da6cd@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Mon, 7 Apr 2025 16:39:25 -0700
X-Gm-Features: ATxdqUF9MoPCdK8Xa8UMGrgTqCHK5hhzVuewwPy99zP09jIB_-XAntGwFXLlzCw
Message-ID: <CABi4-oiXH+H=6=LaajcQK5faqDn20tUQ86cTJXF0Om-zcxNSUQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> nit. It is to get the first entry? May be directly do
> hlist_entry_safe(hslot2->head.first, ... ) instead.

Sure, I can change this and drop the RFC tag for the next iteration of
this series.

> My understanding is that it may or may not batch something newer than the last
> stop(). This behavior should be similar to the current offset approach also. I
> think it is fine. The similar situation is true for the next bucket anyway.

Assuming it's rare that the first unvisited socket disappears between
stop and start, which seems like a reasonable assumption, you should
generally only need to scan through the list once to find that socket
(similar amount of work to offset). Worst case is if every socket from
last time is no longer there. Then you'd end up scanning through the
full list end_cookie - find_cookie times. And yeah, I think the
iterator shouldn't really care if new sockets are seen or not as long
as you see all sockets that were there when you started iterating.

-Jordan

