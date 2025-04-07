Return-Path: <netdev+bounces-180009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECCDA7F0FA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9321891095
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C252163B8;
	Mon,  7 Apr 2025 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="YwtDhTTz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA41801
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744068660; cv=none; b=d369568Zn9BNXWO8HrCPX62QhWk1mmFWYYpT6JnaqSzBsUHGVFjDaG+QcU1xld3ASm60qkKqIBOrt7jBOz4aZA34E/2ssv0a4dcdLgSgczum0QkremJYTgyGxX2F683M5O7T2ej/aLBiGpm0+od8c7CTYch1m8PyjHyMLmneQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744068660; c=relaxed/simple;
	bh=Qroc7zYgO5GtS+tS1cfZmKHbrc5oFJJrEnDs4f+7dKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/FT2362jWlZfIbM6B/DWKTBoq5kZPDS2E+2EnYMZFuZlr2qGwx96+gnSjjpbpFcWCBOgF44FuUM8/Dy+0J5oWEMmgqt+0ZKq8S6pMcw5k4ydmtyZviDnU6KgzKsKHfG1ONvdfLG49q3ltanH813Eg8uVE2/zCCj6LY5f3fKjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=YwtDhTTz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6eae4819112so5350816d6.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 16:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744068658; x=1744673458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qroc7zYgO5GtS+tS1cfZmKHbrc5oFJJrEnDs4f+7dKw=;
        b=YwtDhTTzQBPj6jf4bUHIfJ8JrbslawTGtx0iQfw3uUDNd80l9ostyQOxuo8tv5CGmz
         bz6GBI7bgjMGle1bdbKU90GviRm6UdeBb+GzUL3LWZdAkaMroRHUELSJVz6FtSwEHIka
         UIb1vVZPiIiUyEclyC3dJCTxrwqLU2VPhURzuims5DoYW4vuTcTZ0qs0JHqHW0VIbC0t
         WlddW3BlQLiL6XfBcyRvP2T0tHhZ10yRAoj2zzvyrf0F03o575t6TZX9iOXodpTyiPfm
         8Aa9zrGf3VCfBjOtj8r/sjVt20Sbi9CajVj+03k1X4iMm7ZoJf2Wtyby5YHuM2se+PHL
         17Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744068658; x=1744673458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qroc7zYgO5GtS+tS1cfZmKHbrc5oFJJrEnDs4f+7dKw=;
        b=hfFA1eEh2yJ6NL3jEl5KSfHEDHMTEvJKiYHeLRJ4CS22bfd9ZUm3qG4mEEZGkHUOTj
         lCo43CruP2mXfdbBo4L0mgL6pVG6cqxng9q/QEg88AFkFUAj8NAhsjMFYGUrN3i/TGYE
         +5qkxjpQMtGeaUH0OYBuvVhO+FodRuRxykFCjkgcbu7G2YN4vxs+zwBXhP72Z96ALSxG
         iYF1ypICtYTPQxEzhg6KG4GYX6qzlwAqNCFDS9Sgm8E4/EuJsZcBEzQu3vJggvLI7s+9
         LxKCWuQ3aQQ5yGlVkPbQNPcQvMnmDUcxQ054dCZsJp8i0PbD5GqK7cN3nciY56uiDpib
         ohgw==
X-Forwarded-Encrypted: i=1; AJvYcCUX/07tIb9JrXXxSmilN9RoAX4bso5YBR+LenWbA003X+ROb5gzCTlv6PcMVHgJzRhfIfMbnLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMXC5Y/SKmMPEPzcEZy9/GsxWix5DKQL5hRwi14GjcodsO749/
	+IhbofK5dGcSNPB01oRFFu00qSxVrHbQbWs1J/CSgoleakN+56a4AvqsC7ns+rbNqhbQ4qaxPfd
	aABa/TceaOfpOaLD3hc/1RL+70Ayb4hYdJDHdGQ==
X-Gm-Gg: ASbGncsaxM6MHYiv2Bibc/iRyhW/JoW+uTO2Gc5cUL/xqvFaFDtS21x8PYVhtYfZJ8q
	1+UeDkqFaMUy0ppPpov/OQZbJvR2dSekquzlaT4mmwhq0oclxXvRPjgXF9uXi8b3VXxc4OcSfNa
	IzE/ol8Kpb63oZ7sctwzxANTBJMyH1O/qapB7u5jN5cVdhqFOAMpN16LjSkg==
X-Google-Smtp-Source: AGHT+IHhiCTRGlht8elOD+UVIUjl9aUsadYnn3EhdHTdvFS4AvvMPLcKoB1jRXmegFpEnN+3wGcgtz/u64tJZ+JrYUc=
X-Received: by 2002:ad4:5c8e:0:b0:6e8:f88f:b96a with SMTP id
 6a1803df08f44-6f00de91910mr93078266d6.1.1744068657938; Mon, 07 Apr 2025
 16:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404220221.1665428-3-jordan@jrife.io> <20250404232228.99744-1-kuniyu@amazon.com>
In-Reply-To: <20250404232228.99744-1-kuniyu@amazon.com>
From: Jordan Rife <jordan@jrife.io>
Date: Mon, 7 Apr 2025 16:30:46 -0700
X-Gm-Features: ATxdqUEjHSDiXYJqgh7obzV9QzLEoE7sCfD1sQC-LIOJ4P8NJ52rOMS3eMphom0
Message-ID: <CABi4-ogLNdQw=gLTRZ4aJ8qiQWiovHaO19sx5uz29Es6du8GKg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

> We may need to iterate all visited sockets again in this bucket if all
> unvisited sockets disappear from the previous iteration.

If the next socket disappears between iterator stop and start, the
outer loop would need to keep going until it finds a socket from last
time that still exists. In most cases, it seems unlikely that the next
socket will disappear between iterator reads, so in general the outer
loop would only need to iterate once; the common case should perform
the same as before with the offset approach. The worst case indeed
would be if all the sockets disappear between reads. Then you'd have
to scan through all items in the bucket n_cookies times. Again though,
this is hopefully a rare case.

> When the number of the unvisited sockets is small like 1, the duplicated
> records will not be rare and rather more often than before ?

Sorry if I'm missing something, but what's the relationship between
the number of unvisited sockets and rarity of duplicated records?

-Jordan

