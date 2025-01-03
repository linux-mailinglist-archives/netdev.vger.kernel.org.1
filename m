Return-Path: <netdev+bounces-155004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69751A009E1
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 14:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481B13A4026
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA7B1F9F7D;
	Fri,  3 Jan 2025 13:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B5D14EC73;
	Fri,  3 Jan 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735910671; cv=none; b=QNPa4ilTecJGy1pHLlwFVeA0cPyFk6oORgYpU0gYu7XjaQfPD25iP8st004XloFvHjcoxNQGcomzUt0SSMV5enHg7Bn822wVw3HoPhLrGilOFsKwejOzXqrOb0TQ7LDhSzoBOEm1I1qsE82NH8IAj3aWnH9qpKlDrDpYw+Ccfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735910671; c=relaxed/simple;
	bh=5mosSW1GQgZZpo2i7DEPinZwWzekIYiJeoitfDrejDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R70KcLVcbxasvP2FXwW9KVpy/mrhMp9SXlxeilGaKndUQfTcrtTA7OcZIyk2uNsAqneZl2gFZv5BtwA7KLBHZaCCPwGUcAYqaY1oP+fyyE9yBoxBskNZSvzzqryFa3QVpQD9mGaKuaLowjMssTxXUC5GrHSUnof/FrxZzzLc0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaedd529ba1so1232492066b.1;
        Fri, 03 Jan 2025 05:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735910666; x=1736515466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii4Mx9K10izgFBAK7vrCyOL6NunbY8j95Pq8dx+ja4A=;
        b=PpaoJr9MJTbhjP3i6DZZRDXsFb1DxIUFhAHuFr1JVsHpwawcPcib9oFJdk/ve7oOaD
         bveHO0XERBogiTyRAT+4KJXvQaPMHL/cVO1K4+fbh9kOgNhlv0XfPKLhFD+UqVgMOF9k
         qYdL/9nM5EAu1L7FxZ4bM9FWEIVryMzM2fGktCYAKqp45W2r4v9cVuaB7yvQ1Jsyke7D
         rM63nIxNYBM1inZpJwDSCI4e0x71BwTEwek0A0Vvw2ZcN7ciyrarcowePj3/xWLF8y7S
         yv4m4btayHY2IVhAX4w3QKPSn7os0BNi0uV/gai9t2CzntpqBWXt03UGPUnudPUbEF5s
         XyVg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Xf64JMoHJ1Qo3zlFeBoL+f8h1aGSNJE7/FmHJrBwu8HhEeLpya1q0UimmTx7OAkEsWg/4PQo79Ki714=@vger.kernel.org, AJvYcCWgwJN4Uz70ClbnoV4+R2rK0NIldFtfjsG2YZbCGYvb1O2XhfezXYsF7srjBAWNPHpIfU4vwfwo@vger.kernel.org
X-Gm-Message-State: AOJu0YzOARhdScg/tBCLEezvo8IXVtFyuPBaSuGDufJbIeNSJhwmnovt
	ThFptxHUbc+ZrHwjSTOXw8XnUGo7Yis2T8oQ3Zd3Q4dWkoHV0Hoz
X-Gm-Gg: ASbGncvcBN4wDfBDxcz9cJaaxKNw7vH/3yqfSrTk0S72lJns3Q8VzZRegO/YJfGZBaq
	EgYmNvc11BPlZHQOWqswKmKW2mrP7U7+mgLv6/g0HOky95FjuPFqGN42ODwya8uqEQgPHiUr8Q3
	UesgVyLWBx2oSV3g4CLVGjWCMlNZknHKI8vL8f3wfvIbiXGk4eh+7tbwG0gkjtNUWTpOGL0xPaf
	5DKQVOU0bHMiQhJS9EMc47/K/lT9IV7gtQwBBtO+3VIm+k=
X-Google-Smtp-Source: AGHT+IEsKEO0m272u/gjUvVEqepoFc2Ef3nYK/nUsVaQ6TKpjg97McLRHEVz6tIUsL6l1/+1e69spg==
X-Received: by 2002:a05:6402:50d3:b0:5d0:9054:b119 with SMTP id 4fb4d7f45d1cf-5d81de06605mr101048634a12.21.1735910665548;
        Fri, 03 Jan 2025 05:24:25 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae3b3dsm1893328466b.82.2025.01.03.05.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 05:24:24 -0800 (PST)
Date: Fri, 3 Jan 2025 05:24:22 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, jsperbeck@google.com
Cc: John Sperbeck <jsperbeck@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netpoll: ensure skb_pool list is always initialized
Message-ID: <20250103-passionate-mighty-seagull-29cebe@leitao>
References: <20241222012334.249021-1-jsperbeck@google.com>
 <20241230175707.5e18ae96@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230175707.5e18ae96@kernel.org>

On Mon, Dec 30, 2024 at 05:57:07PM -0800, Jakub Kicinski wrote:
> On Sat, 21 Dec 2024 17:23:34 -0800 John Sperbeck wrote:
> > Move the skb_pool list initialization into __netpoll_setup().  Also,
> > have netpoll_setup() call this before allocating its initial pool of
> > packets.
> > 
> > Fixes: 6c59f16f1770 ("net: netpoll: flush skb pool during cleanup")
> 
> The fixes tag seems to be off by one? Wasn't the problem was introduced
> by commit 221a9c1df790 ("net: netpoll: Individualize the skb pool") ?

You are correct. The regression was caused by 221a9c1df790 ("net:
netpoll: Individualize the skb pool"), when I mistakenly moved
skb_queue_head_init() out of netpoll_init() into netpoll_setup().

> Since __netpoll_setup() can be called by other drivers, shouldn't 
> we move refill in there? Since the pool is per np?

I'd say so.

It is not a big deal to have it in netpoll_setup(), since find_skb()
will refill the SKBs in the very first message being transmitted
(which will undesirably delay the very first netconsole TX).

On the other side, having it in refill_skbs() in the __netpoll_setup(),
as Jakub suggested, will avoid this extra delay in the very first TX,
and make the workflow cohesive.

Anyway, thanks John for spotting this regression and working in the fix,
--breno

