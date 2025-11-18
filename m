Return-Path: <netdev+bounces-239505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA1C68E10
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E57B4E1DF9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02230346E59;
	Tue, 18 Nov 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WixSIKAR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8C32ED2E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462572; cv=none; b=bQ2wZiVYXrAquMhJchDzwTxoB7gibGvHatCe6UE1BiBW1JVZkICgl70fw/wWFE5nY1akYaTYpVWF3teZSXs33jRN9RTVCfz7RkVqyHcbvesAPvynQWIvFpnRA23UeWVw4PPv9ny1swmAatBeSsd7Y3MiKJiPCtpMmhNyBOY8GY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462572; c=relaxed/simple;
	bh=vpkBfMqQ3K5js2CMNGkRdtr+acWamucEKHJA/OdeC2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAffI5WYMf+SWHA5dAmSYmkbPOhBfHFpg0i7zhE+obV9I010Ptxq/LFHH+2EZHAgpfiQ+UrnPnXV6fi6Th+SPFSL6/KTcxnLrgQCDBNpR6mHfd7dd+bn/fynySO4dgPNjvforaRO2KX777FatzXyTL2h8aTWcc55bV5GAxuo3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WixSIKAR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47774d3536dso43970185e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763462570; x=1764067370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LNZ7kLM8T15IVuj4fqsK7U08DBmLHPEhW/eCbNKEog=;
        b=WixSIKAReuRriWrHH/O0afMEFN/LnVUKfBhDwBttKdP2tbgUOjBwzNJ/Kt6x16YPWZ
         RquHE7uWc7x5pDkMn6ZZq3twVbVFWoEXtlRDA0eWEJAUpI7jlgzZ/k8xwMulr+D6YRbS
         fTEjYdfKlV6mP/yz+gLkqiGrHuyd/u8pIjLw+Q+qqmdz7q4HtGJ/7eTZB5OcKigRNFHo
         v5B8UwXkPuNUMpZQvUjLKvIxoETTrtwl1+95Mn1FSIPaPWKzreLeouCSDUGKIRihP7WK
         N+vePZQQCTseZi1Kww1diZpZCMHpnnLJpM0i5DKldiQl1DmYA9ZICJi5VX0KULOhIabd
         xmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763462570; x=1764067370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LNZ7kLM8T15IVuj4fqsK7U08DBmLHPEhW/eCbNKEog=;
        b=kT3jMTbLftNZizkPG2agV1oLTetVfdP9GayIvDA8HvIsT6TtU1Qn1Ty/Wcdnn40iAN
         42aSTLsnkIodcAJmPG56bW3cz1pouwgmvrcaycq6cCLiSia1kE+26dt+8XNQFs8II26t
         ss+eQkuvRF+Y5R+RJYzfJNrGhnosFqOCxku0yeNNH4lxe6a8Z8+AJtP+e434kK5USUF+
         tLO4ldIAayp0RgLmTbQTEA/1aphIMDeLZaEpX1In6Hx5FdvvbK6U6v0Qg1sg5Ov9CzKO
         vuA+ejszJp2lPp3gFeKzFyRevF6S6pd+aNVsmermNrikYRrSBeIvU4fZV8DB5L9u1mMc
         teeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdccrx+EaIHOv1Vca5y5Yjkh5S7wf+lp3U7C+GPBhYIwCILGjtBbTZRyHEQuJaMyq8i0Kw4NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ilZ2I55TF+R/cECKaMDWzotcjhuta2gfZQm/g/imxkZxcJXH
	f49kjCo8779VZdGf50Fk5TQDA5NEBaym3k5M8dGbHJAaD9tzKxgTUc0u
X-Gm-Gg: ASbGncstQZSaG7tWolMG7ZhtlsfM0WZiAN1yuEEYyyRZDSu8/tdm1ocjSRXJ0Txd4MU
	615GtUbY/cscXLN6tOOuvUHnvqDy6nOD4EMbXQoYVxOcyRK8qo0nPKc1MjSQn3OK+G3ef8ovw/a
	orV7eUlR1pRU78JSKkXHmaCLV2C23oj9+QN7AJCU4IOJRP63GasojeWrCyP6GhKnjl7GdP3r/zm
	eFgmhjuz/R7TqhROHVplaw9rmQU5C7JIfAMSuIPGMZAe7GwmDczsD9ecAzteHP8OdpCKxyXJaGB
	bMJ5MUwM/IYnVY8AxKZnueITQbtDj8RSzUDZFM2mv3VkiA5z7rVSEZTDql/DBOpsFxJsVuHKya7
	JqmKq1632ZJlPJSDhPN2+OLtWNFac2fBHflHCFrTzBQQHcZbSO6Sd3UsmgRH1DuLaDqG4xPXRXv
	0w6xB7zdsgAgSbynwYPGars6PYF61MLXZiaAvjT5OpePg6iEjApw9qULxfCWzNsA4Oal5OT9mvQ
	w==
X-Google-Smtp-Source: AGHT+IEBUYaX4Bp2LkqHG3fEIEVxQRNem8L5c5rq2F9Th3HxY/EOPdLBnO8LsPHmltiaFAAMNb258A==
X-Received: by 2002:a05:600c:3b13:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-477a94acd85mr27682085e9.3.1763462569245;
        Tue, 18 Nov 2025 02:42:49 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779a2892c8sm182555035e9.1.2025.11.18.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:42:49 -0800 (PST)
Date: Tue, 18 Nov 2025 10:42:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
Message-ID: <20251118104247.0bf0b17d@pumpkin>
In-Reply-To: <CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
References: <20251117191515.2934026-1-ameryhung@gmail.com>
	<CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 05:16:50 -0500
Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:

> On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > Locking a resilient queued spinlock can fail when deadlock or timeout
> > happen. Mark the lock acquring functions with __must_check to make sure
> > callers always handle the returned error.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---  
> 
> Looks like it's working :)
> I would just explicitly ignore with (void) cast the locktorture case.

I'm not sure that works - I usually have to try a lot harder to ignore
a '__must_check' result.

	David

