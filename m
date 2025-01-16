Return-Path: <netdev+bounces-158853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F5EA138D5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8971675F4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D491DE2C4;
	Thu, 16 Jan 2025 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6BnzTQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FA1A4F09;
	Thu, 16 Jan 2025 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026511; cv=none; b=lIA4KpTc6dWSIXEBMgxgD0HvOqZKbUHSZtXWml69Y8QAzw0z9p3p/YS8UzMptutd8udPKIQxHJvGZhLiPCnwslI7ZSFHBCaWS3O5EkeCinUOWgu7n1unx2jGv/k+nPDbrcSrRsUGSJqNnnTEdD26OfOoz3A5l4tppEASNukyiEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026511; c=relaxed/simple;
	bh=m6SlfLnJPhNAQ2lHdg5Idcg5nkpZBJ4FUuHsHpmnIeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxZLW7uCM0HPxWxBQpuEo9HbHZ19l8DubGXqxx9p8D/DPanOM8NMROXwE0Iv6fGRjzy1nDBZI/C9DespufAeCcfq0NSEcfFeVFyPUhp8qbrISjJE5fXja7WrFO3SCyYRh3z6gWtiY3mX962WdGyPuWdMiDjaT6gswldVf+6drik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6BnzTQu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e0d47720so37937f8f.0;
        Thu, 16 Jan 2025 03:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737026508; x=1737631308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cnkfv5FiyIEMgQtii7tTFfT4tDOB+nEHJKZMDL+AF0=;
        b=L6BnzTQubx6298UFJPByTByrnO1LjmHBKu8ko+BLxF1MDn0mfsg1zUAjBm0MCw/Ehm
         0+za6YbZjqD0enYY0xWMApSchcwy99zGwq9E6O2THQU+yCsoQYYQQokR6vL/fSimVeAZ
         yR9tjIeHma74nYKpBpf/ukCKmAeNgS9dwjiQudSOvXftEEvD1KIBnGRCKHJE6K5myadq
         Fk5dM3jHfe+TD2MuQYX9yn0pXhj3pUx33VJ+AlATqCt9apgLHjDWD6NnGzf/WCYlsNZl
         u4QeFrfSb3EoB+nuMJzdp7fEkBnfqriuofNod46tmxNN12tXDi/FXJeMlccM1loUqOhT
         sVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737026508; x=1737631308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cnkfv5FiyIEMgQtii7tTFfT4tDOB+nEHJKZMDL+AF0=;
        b=OF+e2fEhEz7tDbes8NsIuK2n1ckwBLxGvb1qtI3kqJN24mYrrFj6lCVVvJlLSwvFiC
         gh4pf7f1D9IViPb0BWOu4sZpE3wYIyT6D2XzxCkiE1TMwvG61YtcKDQjwnxQ52UXWL6Z
         vqzrbC8QLGD4bw+mtuGVTIESE1BoGCnSYQe5UI5GucEdodZi2gL7eHgHAeA7yqDd9XcP
         MyZiJLE9Qa2uYa5UyAwy19Gtf3An0swEuFaEhC3qLBKARnWMwsiL9SSW4B9OjrOrnX3K
         sLdyLkdnSikKgu6S3STXSelsAn1cA8bp+6XOdTlMOG1Ge9JpAZKpPb6reAdBFj84Nm1B
         h8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWlw3at2+Svk4rStXLtoBBJB6l6RMiJyNKU6+R5dJsXvIc/PQwiQu8w4saYfglWChaZMmmXM7SanBFKgg=@vger.kernel.org, AJvYcCUski4/aLvcEgSWzM2VWHTrrgZ+9r7IaJzm5t5zuWg3C1rRse5R2gYNVU8SICmvNSBQ3s+gKRQZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwDIrBu+jwSFNslwe3TlcF9eOH3n3S1jWlb5VHb039uSDCXvjXZ
	Yt9dNW3oOeHVsqV0wYSqvbmiYDtEV3++c7bFzD3+eBY9MwNGD8/e
X-Gm-Gg: ASbGncvY7fh0Pt/AIXbb/849DJTve0r8+7xF9/BMrKhFK4qquGFMYTQkT375bDvAa1/
	V4m+ayZROqAHjscHaTC7K8VHU5yPPiJW5p4Vu8TBUMUEHSi0zLnoUQpqGJjXYlYz91wejjksd1u
	yEpjLNub6LpL/aDC+gi7zCRVL3Z+Vp+M6WrNVhakx3V/S/z0i02KAavoJU0vc+8Uvl05zFMT1eF
	YMBBK5n5rsnOK18KSwTSO3vwYXSsnsqlVmIfeXQwka6
X-Google-Smtp-Source: AGHT+IGR1I99IAClHX2s5usKK8sQLzjYpQJwqK000ODk6ec+5SUKtSwQDMHL01u64RwrWL1I31S41w==
X-Received: by 2002:a5d:5f86:0:b0:385:dd10:213f with SMTP id ffacd0b85a97d-38a8730ce34mr12493348f8f.9.1737026507386;
        Thu, 16 Jan 2025 03:21:47 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bddbf50a2sm9684180f8f.43.2025.01.16.03.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 03:21:46 -0800 (PST)
Date: Thu, 16 Jan 2025 13:21:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dsa: Use str_enable_disable-like helpers
Message-ID: <20250116112144.vtgaelbpq4lmipd6@skbuf>
References: <20250115194703.117074-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115194703.117074-1-krzysztof.kozlowski@linaro.org>

On Wed, Jan 15, 2025 at 08:47:03PM +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> I have more of similar patches in progress, but before I start spamming
> you with this let me know if you find such code more readable, specially
> for more complex conditions in ternary operators.

This is a positive change (especially because of reason #4), but I have
2 process-related complaints for the future (especially if more patches
are coming):

- "net: dsa: " for the commit prefix for patches on the "net/dsa/"
  core folder, and "net: dsa: $(driver name): " for patches on
  "drivers/net/dsa/$(driver name)", please
- I have observed a tendency for people with a Marvell DSA switch to
  not care about a Realtek switch and vice versa. Sometimes these people
  backport patches. It would be good for patches which can be split per
  driver to be split per driver, otherwise there is a risk that trivial
  context changes create a deep web of avoidable dependencies.

Not a reason to resend for this right now, just something to be aware of.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Side note: what are you going to do in the hypothetical situation when
the converted string used to be capitalized (like we have in this set
with "Force"/"Unforce")? Create str_Enable_Disable()?

