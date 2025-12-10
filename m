Return-Path: <netdev+bounces-244228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B11CB2A05
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 756323006591
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7426C3090EA;
	Wed, 10 Dec 2025 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTUSbCfY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF883090D5
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361104; cv=none; b=ddfY+zVzlGUFv5gjDrNVT/ztQgsadjr2ZliNLZ7o1K62Gecx/9VZH3ogmb3qMtM8gHGzkiSA1gJkCiJA0ppl/fp8XCs+ZLba5e1BbJ73LVuxjQYlKby93pxShpYPjevI55e7u4nQuiQ7/93TRcy/ZmXa/HxmvJX5R4zauT3ky1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361104; c=relaxed/simple;
	bh=mn4zdl3vn29wXnpVK+tSko8k/DOvLsEFY2jIMYzzMAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzxXfIo+nzCFA30VBcHfN1vDEi0WYyqP7PjsvWZZtxBAa+11AtDh35Rpudky1SRe1iEg1xYFXSshnQrVXasA/x+2Djwq+oaP1jXtfNllzH0O8JSMKu/zCa4Jxb5vGcI0p9om7NToN3fhc1okCf4sbupPh4mRJ/M3ZLImi6y+APA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTUSbCfY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so62247775e9.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 02:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765361101; x=1765965901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM9jv5+Xf8bSG44VGgVRyBWdElgj5hCgqPr3kHTSQBM=;
        b=TTUSbCfYyOtNhOmldmbpenarwGIfT0H4MDYD9MsV5RqxWql3COoITbKzYia9PIU2v1
         NwCulhObWQkfxCK2VqS9u3ALRcjYAKb1ZBoyTfPTt8ovBe7eHstkmzPLVPm/INspRYvB
         iVqRw+uF57YAPLNwFKqVKx80zHz7EKLC84qSYmqBKnik1Id1cK/Y0CGufzk80POj5Xbo
         jdBkC/VMrn5GfXUpCykmmMH5q2nK04DQSOJ7o5m7FzYn3OWaeXQmrB61zZyJGQSTBOV5
         DZufdlqZkk5m1RnfQ5W3Bj8YbcBWfZybUexgiCG7Jz7xikFfWRJlDXXZdh+1SPbTrtar
         jKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765361101; x=1765965901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uM9jv5+Xf8bSG44VGgVRyBWdElgj5hCgqPr3kHTSQBM=;
        b=mXxcEgJn483iK0FXLMyWgIZtfo86vFFSKi168Ljwedl+3c2JUjtRxkHOnPCj3OrWYc
         n+rQcdhn60WQhXqsi3iMtkkMW7v7GZx6cffu92pi3wKZ7lKlrsp9zX38S9g3ze6qMoRn
         6o0qbRqu636rfiENJhJbDEIRuniL8DXSh28AQ7tfm9WlBOcXoQyUONIv1GQvvurKZhKH
         3bE4XObcGyZVi423y6PEASNOO+bKwm6Z1MA3TRt7SApFkZniSqNGFKg7U0ldBM3bmq+9
         8o61zABA29eEG1XSFPAAunnUQnKDC2DOBXBq33k55MAjkJ8PtYNoZCFr+t1WpUiHJWwh
         swDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh/03bJT+bavIX1lGQE4wX0hPT3pf4E3JIz93DNhuY1Q4RmuJqxSenMP1EzOmdXXv3uOSRqDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqtj7Lw/yjiIwVH5t+34hk+6MBBOMinj8FMEAyzFQ7ga0Gzhlg
	nULjaqwqNt7uIcCTkzzdE/xCICLQ9NRmIu5FMbn/brVhy+2ImPIxwD6u
X-Gm-Gg: AY/fxX54X2nFjRjhfvcTltwNPAXI5TKOXy9Yz4Ln/ulsNlXKAnMK9x6pWbuU53TJcSu
	LkD/UfhOYmQsTpa5MBa6jiYpnET0f94OICTmFpKYaibwRDqmVrFc381qS10SbXydm6p7CUXLnp7
	sZ8RNSyR7E1gN+zUfaaoaNUuPQSt8PKN5LiPXIOdTGM/fLkbpctlawQbIoxGLdg/oTIAaUEPrUO
	VR4gL/b01SZtvANI30xpz160+QrJ5sLqouFaE9tT6Hfoy8VhYCFao8kL7jpkfGw5AjKOBgm8gLD
	Yd7ym8O1luz+ApQE5ZnelkFN+xiHzbh/60jONzL1X1NexBLSLlHDddB7XD7Fxm8b4qXrhOCpf+y
	eZy8K2vVdvI29H8VYXHAVXuxg78KoxBXyTG9z4ge0kPuJ5YfscO4B8EqQpGmDrAwRLCdl0f6tY0
	EPepdTV4eXdFhjm63xagSDwyWr2XkUe8qUguNQqcGxqDluh5n/rqbz
X-Google-Smtp-Source: AGHT+IGc/2temuso/dMXAd/z/Fp268Bw24VHuUY6WJXcwM+QAE/5iSiD8jpsCrHfLSA7sKTxPtCcmQ==
X-Received: by 2002:a05:6000:290f:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-42fa39d1f95mr1650927f8f.14.1765361100899;
        Wed, 10 Dec 2025 02:05:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222484sm37265629f8f.24.2025.12.10.02.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 02:05:00 -0800 (PST)
Date: Wed, 10 Dec 2025 10:04:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <simon.horman@netronome.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 1/9] nfp: Call FIELD_PREP() in NFP_ETH_SET_BIT_CONFIG()
 wrapper
Message-ID: <20251210100458.57620549@pumpkin>
In-Reply-To: <20251210182947.3f628953@kernel.org>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-2-david.laight.linux@gmail.com>
	<20251210182947.3f628953@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 18:29:47 +0900
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue,  9 Dec 2025 10:03:05 +0000 david.laight.linux@gmail.com wrote:
> > Rather than use a define that should be internal to the implementation
> > of FIELD_PREP(), pass the shifted 'val' to nfp_eth_set_bit_config()
> > and change the test for 'value unchanged' to match.
> > 
> > This is a simpler change than the one used to avoid calling both
> > FIELD_GET() and FIELD_PREP() with non-constant mask values.  
> 
> I'd like this code to be left out of the subjective churn please.
> I like it the way I wrote it.

The 'problem' is that I want to remove __BF_FIELD_CHECK().
It has already been split into two (for 6.19) but it makes sense
to split into three (to avoid code-bloat in the cpp output).

IMHO Using a define that is part of the implementation of FIELD_xxxx()
is wrong anyway.

> I also liked the bitfield.h the way
> I wrote it but I guess that part "belongs" to the community at large.

There are already significant changes there for 6.19-rc1

	David

> 
> FWIW - thumbs up for patch 8, no opinion on the rest.


