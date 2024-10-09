Return-Path: <netdev+bounces-133907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4738997721
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5490DB23CA1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7361E1A13;
	Wed,  9 Oct 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXQDrUBl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430C188CDC
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507648; cv=none; b=pND0Xc09iBVLrUOKO4DNyviKtin0s8QDQ2X6TzAa4Y/OpmX8OnuVnre+whKF9oGUwrUQ5V0fACv+6HIW/LeRkOj5RoVfvLulX35KtC4AqwPY4ePvZzXFK5GBySC0RLdrbz8p3yEVBmiSU3wS/aDc5hgk7XGxDm/kbH9XoeRPGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507648; c=relaxed/simple;
	bh=Nd9XarDquioNchNr7M+UyQNGXD34fv9mmtYNvewQiEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WheT3G/M4lVIukQksROOdD8U1vsEmj4K+K0D+IMEvYDVeDGN7HkkWUquhRA43RGZz+srec8EEZujLOrFRTlmyiiwM+yVdy5FLn6a/vT3vo5tVFol8JTYBjCocxWFP/15YmqcEfOUlhDOXTSicjiZZwASKrIiPWx0jHlinT6lIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXQDrUBl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9963e47b69so37642466b.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728507645; x=1729112445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd9XarDquioNchNr7M+UyQNGXD34fv9mmtYNvewQiEs=;
        b=xXQDrUBlNlEBM0ZXcZqCw5VsstnXL9Ewpd9tc2m8oKO/yj6Lrhu+hshudCg81/fJD+
         5W3tjFPurUlUB5XNevMdtjmNdTeW+dRAxoTgJXRr2j4w6752dlWxAix5MVpkY1hTzJPc
         tRu3ih3I4fR2e/rI7OGGwT+rfomoWMuh7OihaDm4v6y+8B8bGrJeKjWnbQgZVn93QHBK
         G2hV3346/8hXbHLPTxpThrRbrBJxH/1A/OXxM3RfQ+uXvH4yW5poQlbPEKRUqh/w6LAi
         lVTHexlYERXmonivSr7pQQ41NMdPJ99ye8ygGA3zOikoar6G0Liwq1RTuEXI85+w+h3N
         Y8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728507645; x=1729112445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nd9XarDquioNchNr7M+UyQNGXD34fv9mmtYNvewQiEs=;
        b=g1z4jfGvGW+e2xMz1c4Evw1xwYGioQfcKVsLT53JuqhUdD/5dZGNy1tW2GBecFX7zs
         5ElW6i02Bb8yvAhszm0s78+pLrK18sq/Iqs1l5syREQT3Uw6gdf4m5l3Y+ykotkLiusw
         PtARjz+FxBvRctnCQnLSDNNTIrn0tKk+1DICPTL3hjd2/5o1pypLAOullq7oEZpNVGQV
         SQRwtQy8AVyRs6iDa2OcxOOHvvrEu21ALdbbWqeXebMbrvIfa5JPITXW5Xu6hg7TdlsF
         LMKGslykTS/I44hgsZmACpdIE4aix7qSHqlA1LjKOZVTTVL0lehn5SaxlSUiw71AjtiY
         UiEA==
X-Forwarded-Encrypted: i=1; AJvYcCWTdWwxg4oQXtm9Df+T9cicuSa53FpRRRKaT5CUb6gwRywfbVziVA2L6H+IGLnosgszfGjbjEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfV0LSvyLEeyFmh6KfvAv6We9RCvHlHi/JmKIhPtWxAUXgo/E
	rbBifsuktBUROmsfRaVpKdCCs1bPTJkoddYykT0MAlejx8/k7hMh7ulNJlTeh8MYf/72vWpYml4
	LRJgVAFsy73x1JgXiQlDUSJn2YH6Fw2Vi2xY=
X-Google-Smtp-Source: AGHT+IG6hF8OnOMd+ncEae7qi/hQ3JtWKyHhEKQxLhE0HVwRV7e37ko5qcN3yswQ/SlB99ADuvXLGXhSs8eLCCuAZOc=
X-Received: by 2002:a17:907:7ba9:b0:a99:3a96:fa9b with SMTP id
 a640c23a62f3a-a999e8f3fe7mr134337166b.58.1728507644343; Wed, 09 Oct 2024
 14:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-5-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-5-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 9 Oct 2024 14:00:32 -0700
Message-ID: <CANDhNCr8NL0ZgOdoOmFJffkQxAvGfJLekszuE0DGvdHiRNkgQw@mail.gmail.com>
Subject: Re: [PATCH v2 05/25] timekeeping: Simplify code in timekeeping_advance()
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> timekeeping_advance() takes the timekeeper_lock and releases it before
> returning. When an early return is required, goto statements are used to
> make sure the lock is realeased properly. When the code was written the
> locking guard() was not yet available.
>
> Use the guard() to simplify the code and while at it cleanup ordering of
> function variables. No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

