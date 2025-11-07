Return-Path: <netdev+bounces-236705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDDAC3F1A2
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C453A3B93
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4687318131;
	Fri,  7 Nov 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZJ+Tzia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5AA316912
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506774; cv=none; b=sqnMWYr07mzvUVva9dcJJ583MFj0+RE3p8g6OGevZO5Zqc2VR/SATH1xbGcqwwyCeqtHx/U73N5mysOStPESpwMDDYm0PTRG9JDcA9jzzgsNmRx5uWDXlwnMIGlLm/NuZEHXnpfdGZ5GLDTlsC8Z5zgTgIvxt0/mcV29P6kAjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506774; c=relaxed/simple;
	bh=ySb+pop94SqpdbyZsYpGfmunwgkKv5LASXUw8Mbt2b0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaX50VLeZg22HRbvg6cTUs4xtXqqT4753b6A8h/tiFw+yJ9U+afH7JFh6FgJATpl09iF+e82osY/J+OK9zQiKSw9z2AHR8059bW/z8arv6LlxnbAZ98AhDomxeaD61MVjKliB8qu3pbilr3eFbN5js4Zdwaef8/woFL+2FPrQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZJ+Tzia; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so282815f8f.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762506771; x=1763111571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwbNx98NAV67oyTmVbgDZ/t5BsyU5lLwVlOoJ6t3e0g=;
        b=mZJ+TziathtEj0lCeVghoJ8qe5Og/eCculTzvtfLW7O4TCQmbpYaopK8zm+OfFQAVe
         50Cl9A9mjJX1v6BDyftxzxMIOK4K4XmF3xdtLz3dYY2n2dHduLbqcBrc7lpEZc8/pSQ+
         AmtSmiTIa/pswSLxfcxQ6a8wS+HWHlofa2FnCPKICvxo9m1PL0BDQHMVQWwd0nKgDuf4
         /aIq3e3Uy0tGEmL6tBbwmdlRlqdG0e8xcVU+ovpw2qE+R9zEOuNXpFezzj4R2XDNVFZ3
         wZS1kAIAlLEzs63cLGCBj+4cmz9hmrM97e5HMceViOtkiGL/8jACByqHknakrcpI76XU
         cY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762506771; x=1763111571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwbNx98NAV67oyTmVbgDZ/t5BsyU5lLwVlOoJ6t3e0g=;
        b=GE5BzkYCI2fYSThdSsU243RrgXTJobL8k6JcXTB5JWvbPwLRFfxZBRPSde6zp9X27w
         QInhIWFMZLDjmo0YpFlSRYFhn5hA1wfiaJoSP5hQM6KI1YpEKAhX9u1xguf5m3l+OKGJ
         HyhdAzX5YPaFVDE3mIQps5S5H2KNUgcWyzHJUOt22rl+GXef0aJstP+3w0fZRcaSOiZ8
         a/jT/lRgZcnU1OE0bX/FgOSmGoVKbbFJzmgobuzM9LV4oRkns3pOjBB4z0ozPKio0j29
         AKqP0y71pl9Sk7BJSiKel4MWA0zwuyHfE8nP80sbBiIxKCLMb3n4OlwJnWVvaeqqOjJh
         7w9g==
X-Forwarded-Encrypted: i=1; AJvYcCUhRAqK4bud6n20rvI/vNZ20EzJzuLTXBEO6j45rdx0lRIgKDrC3Ib20yiDaNyN/pXrtMZnXQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJVq6mJAhSUkihbNg1S0JDGwmVsB0eEQ4ZzmDLLB1l8KqInUM
	f2BK8wMMuS1szrZRZCDjMdU3WqF9WHw6b7PwJ/Wf+ZyLasATDhAn9rrV
X-Gm-Gg: ASbGncv1DH8mpRjSJRBj7Y0nJkB33CSUgN1NG1IpoCcZUBYaNvmkShnZfUKEk3tXHcY
	30J3Jgk+sv/qNS2lWwfMtxbuXD+JUJvr9lSQ8FarpXQeGOwCuYt3rAWstxsyKx5P5zco1ZJhht6
	v3SFaOOrUaG009uPFrL7Kfm6u+OYVCisoKSZLeqjEoLIm+cZi8kifLpSbYWWMRcsmmjmMFe6elW
	nw7g4DHCw1GUbTReUOZavHoSTiexwV9r7tOsMEbZiXHLowDMkQvfA7hJawpWnuIupxXzkrDXxgX
	1AZrbEWMXWoLwzazy5UFhcfJfeB9ExF8rHTsy3UQHNrUrN4rCvEzYRzAjNVQI5/vOtx5UApP4On
	in89cOiKrccwgOQ/wyS0s0DPJjx+NDkNGKNwCwUfI1FyjnvOExihnWrlu9uhc35R1E9fEeWOlcp
	7PCq3xCyEvQjrpS3ouRomlrHBVsPZmnokH3/Abc65H0L34XqQpDDNR
X-Google-Smtp-Source: AGHT+IG9saNXs40oR1IEnqn2ZJqpHZqHgNAPFU5PXOa3lUzB4P6UMLrs3Ay2s/I5KpU2wmqmBc0PbQ==
X-Received: by 2002:a05:6000:40db:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-42ae58812c9mr1862887f8f.23.1762506770833;
        Fri, 07 Nov 2025 01:12:50 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf35sm4130393f8f.7.2025.11.07.01.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:12:50 -0800 (PST)
Date: Fri, 7 Nov 2025 09:12:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Junrui Luo <moonafterrain@outlook.com>, linux-kernel@vger.kernel.org,
 pmladek@suse.com, rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
 tiwai@suse.com, perex@perex.cz, linux-sound@vger.kernel.org,
 mchehab@kernel.org, awalls@md.metrocast.net, linux-media@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <20251107091246.4e5900f4@pumpkin>
In-Reply-To: <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
	<SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 21:38:33 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:
> 
> > +/**
> > + * scnprintf_append - Append a formatted string to a buffer
> > + * @buf: The buffer to append to (must be null-terminated)
> > + * @size: The size of the buffer
> > + * @fmt: Format string
> > + * @...: Arguments for the format string
> > + *
> > + * This function appends a formatted string to an existing null-terminated
> > + * buffer. It is safe to use in a chain of calls, as it returns the total
> > + * length of the string.
> > + *
> > + * Returns: The total length of the string in @buf  
> 
> It wouldn't hurt to describe the behavior when this runs out of space
> in *buf.
> 
> 
> 
> The whole thing is a bit unweildy - how much space must the caller
> allocate for `buf'?  I bet that's a wild old guess.

That is true for all the snprintf() functions.

> I wonder if we should instead implement a kasprintf() version of this
> which reallocs each time and then switch all the callers over to that.

That adds the cost of a malloc, and I, like kasprintf() probably ends up
doing all the work of snprintf twice.

I'd be tempted to avoid the strlen() by passing in the offset.
So (say):
#define scnprintf_at(buf, len, off, ...) \
	scnprintf((buf) + off, (len) - off, __VA_ARGS__)

Then you can chain calls, eg:
	off = scnprintf(buf, sizeof buf, ....);
	off += scnprintf_at(buf, sizeof buf, off, ....);

    David

