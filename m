Return-Path: <netdev+bounces-163656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F108A2B2AA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A841885C5A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B51A76AC;
	Thu,  6 Feb 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTqKhg3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455113AD22
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871440; cv=none; b=itZm/hk967kDq2GT19v5Tj9POVSN9MC8GG5LmHPQGSJewe18pqp81HeE4eDSrJzTs0V9j5PaeiRjhTTGpqlskFp3XInCxKqpCjRt5Qij/pUFt0/GQU3visw2auNronrPvtFNqOav9zu5QkOZV1CpB1RNaXK7uOFBs4Z3kzgkMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871440; c=relaxed/simple;
	bh=Co1grKELUkvUgMKFKXLCW321I5UFcxze2o5ke5+dHSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZ7mEw1UmbtQrjGbKx0PefSu/YGHsgNXUczi4ED+rF/VGNc4zU/82WSDGlPJP7hmTKRxVBQEv33qLXzPOSK+tYdcg44eRDkr+eNMgGsnc0DFPzr1kaTGaHRlEEjrLlw040W7/nKLcisXjVZO2CYT2E9aL4LBoZkjWfzVCvK/KvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTqKhg3p; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38dc962f1b9so35451f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738871437; x=1739476237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx9RGSucXKR6m/04jR0irB9Emraokf1Acse/SiEeZT4=;
        b=VTqKhg3pLJAF/PrHeMKWGnXQeKIJ0CG0/reXS9h69br+JxY8NLGDXmfMEIVinBuF/F
         0yCkwZEUfEGr7CIfPHoO7sz7qX9lz0IWtlNgXA4GWmGWip24XivafbMwadunBolZQynN
         NsUAuFLUNBRRl1cC0T5R+PhF+yCXJpJGqHvyw5K0e4LJ7mfmOKzBSSmnuumY6ex9ZhPo
         5H7IU+rfv/MXiqpoJCzqBhK/WleAPCKUFVgOLCNVqKUuPAwcVNh6m8OVXO4YaR7ePoAu
         xF1vDPGwSuckUWBklp830ifQN5Fnk8OTlws9t3XCQ8pc6kSDLyHzUVYNAb11QeG3scM3
         2SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738871437; x=1739476237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx9RGSucXKR6m/04jR0irB9Emraokf1Acse/SiEeZT4=;
        b=lXjHlkJgkxHnKgYIdrROqbk2Q+shg1IqaVL8kYVN/qjjRxoubxriaI8oDxISwentCj
         DjeOYa2Sf81cV82hB+qgLs3m7ayVFkeKMu2FCjeh67WgGoVUYLaj7OaJkKgiEOGu9Q4w
         mmwctIHj4Ncc+UfIlNV6c58/jPxebOqBmkehR4dx0nNVnlZcNDUh+fbapV4n90rCvfon
         AyE0hDWGrx12f+4wNHlZtaKzO0QDC3QU034hfKGGqfbQtJWJh0f+1veYQzflTvI/6pHK
         lIcGNNkvDf1RuNtRyAodVCv3AxZYwyQYSxfDFMk6aDxjqTv5B7K1guycPc9bnTBBdFy5
         Gw6w==
X-Forwarded-Encrypted: i=1; AJvYcCWyafj1aqcwTntdN7Iv3GXrmov+DXYRrHS7MsuKMNMbznUeVbwUDolFr/aKC71hm48iukJrcUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+VgM/NzhjmNoZlLHJAxjRXfLktQranEB1e/T1PG+AEwyslzU
	Wyk7JpylUa8GtFX9p/P7p/QuvAhrcI/jBULhDsf6B8UOQrfeYrog
X-Gm-Gg: ASbGncsSIhFof6A5zgwlaCOJRlovOMphN1/oWmu4Yy348ZxFmezaX3HlUfUg91N+9rh
	FzNbXpEzJO73SxAlSlNyWF09rRpRo0yom1dxKAK6ksZCovPjN3OiPy9HhjgENws/FrdWdDIQyfO
	ylIvy48xezLMr6z7LesG4SoTf49uJgiE3EjNYbZjU28OyUzF2S6Lz68vMYZbwMZ4hRutQNv/3Q4
	pF0rzCaZZxrXLijkVerP2WjohzfOhuR/r7Vy6LOpC3mAq89tfnJBfI6BSJljGRsStE2CzCo66hi
	/xogDB0F99dZH4z4VwWHjj59pVVDIQ0VBME6f73QJXd/JTqPGzb/Ww==
X-Google-Smtp-Source: AGHT+IG8JE7qt6OLG0g8eWraPkGG+BHKmLMWLZXjXQoCpIraOg+/hMxCLwMjibL7F7BcbO3TnO+OXg==
X-Received: by 2002:a5d:64c3:0:b0:386:459e:e138 with SMTP id ffacd0b85a97d-38dc934968fmr169231f8f.36.1738871436793;
        Thu, 06 Feb 2025 11:50:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da96502sm30130245e9.1.2025.02.06.11.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:50:36 -0800 (PST)
Date: Thu, 6 Feb 2025 19:50:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dave Taht <dave.taht@gmail.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy
 poll
Message-ID: <20250206195035.12d64d8a@pumpkin>
In-Reply-To: <CAA93jw7tVyiz6Kj8B5zXMqYKxLZSnctGiwbH5hC+4_ZTWpg3fA@mail.gmail.com>
References: <20250205001052.2590140-1-skhawaja@google.com>
	<CAA93jw7tVyiz6Kj8B5zXMqYKxLZSnctGiwbH5hC+4_ZTWpg3fA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 21:36:31 -0800
Dave Taht <dave.taht@gmail.com> wrote:

> I have often wondered the effects of reducing napi poll weight from 64
> to 16 or less.

Doesn't that just move the loop from inside 'NAPI' to the softint scheduler.
Which could easily slow things down because of L1 I-cache pressure.

IIRC what happens next the the softint scheduler decides it has run too
many functions on the current process stack and decides to defer further
calls to a thread context.
Since the thread runs at a normal user priority hardware receive rings
then overflow (discarding packets) because the receive code has suddenly
gone from being very high priority (higher than any RT process) to really
quite low.

On a system doing real work all the ethernet receive code needs to run
at a reasonably high priority (eg a low/bad FIFO one) in order to avoid
packet loss for anything needing high rx packet rates.

	David

