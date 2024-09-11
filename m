Return-Path: <netdev+bounces-127565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915D975BBB
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F3285096
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A6E13C9D9;
	Wed, 11 Sep 2024 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u69Ldnqa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DD13B284
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086616; cv=none; b=iNz767+xPt+Q1R/vcv9AMbtEA7aUg6/jcl75NpX9nrJIcKl9T1FfV7jn3Jage40bzqytWGRj+nbtbscDwy9/BE/WYGTn+SivHrCOQaumocgtsuKTmD7XAsaubuhMNQfDT5f3JT6qOJL1tqbHVrSOWdgvBD/zd1nmlFs5utYTTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086616; c=relaxed/simple;
	bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gObOecwWntEhVIwlQCYNq4liSB5atv70xhylzcdkk9oz5k/bvExhHluJvl57EGegWuL5dty+rE3Zoph8vPkibJ7/fgbENbTGN6du5RmoaEjWPw6M0rLWBID7F/wFI6Kf2LJxRlf9d0afDEnnHwLYdF2xwcVR4Ex4+953lPzw6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u69Ldnqa; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53659867cbdso312020e87.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086613; x=1726691413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
        b=u69LdnqaRUJUeDb3MAKLAFTddgN1dijZr0GZQO2/vbf4ZoHwREu+y+4YucnWWPC+Th
         p7vOpF9m/DpiYj3Wn/OIzfDDPRpyNqUatUJjYHprbkd8vbqqGlPngDT+Ufu6rt6byM/Z
         Gy3Rxtv62nmElN8eN7+hIkf8X3OkYXkMbM4scE4RbTYdHQTj1Y0dNDr9otNntB1lfbQE
         9FyHWiKwHfRdL1pcyEruQIW0ISPUO7mwHbBVK2HxSLq2XAFnDGEg1viJoY1XlSSV5ieo
         /DCUUIxha6Yl8aZ6l5dA3+Z16SE1kUQvmfv1jbC69sDz7i0XDbIBQKicNvpYGDwCGw4w
         YISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086613; x=1726691413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD3jHmQWAY6Oppf574BbgavHABRgp9MNGZT+gDX+xM8=;
        b=fQpSV4keO9BT13tHkrAPX/kKIHq7FBzTd/aYF8mRCAL9YAd2c2LD0uLPYXxrOYcLxX
         Yy1Mon2bcfOe3Np9SBLyZNUwbJjsRnlG/qexJ2f+oobH8rYy7ku9slhvKGeUyihkJzZs
         5Fh7kLQkg7NJgJCcCyrlbZreJaZtQrubFxHKApUEQhpzy9qssOZ+TUnx7Kp/BqtP2R2E
         DxeSC0skRPcj/+6d808w26+cqOKN/1rcEZCGl3m0QGmfgIDNdMFwDqj8ye763GfQvpbY
         eMubCq0NrOIZZYmSctIPGw/uTNZ7X96NRLNzAfPlbk1/o/obztzqI/N6J6CQB7VaM5MM
         0Ytg==
X-Forwarded-Encrypted: i=1; AJvYcCVdn/NyMTsb2qYgieE2o7tTHYNBsmoBjJZ5lvgv8oiVjidQZcDsLUvUWrw6ow3XgdjKhDRUVkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjzBj84qyUW00iJUv7VtKV/odHuNex7RnWTSZtL7AR+xhZirK
	RYtavTPb5KAlzf2AkcvTpCAE1pUT1e+6E/68EDfSsYKOOCTUyx/FSe544XQvS+KTqARaD2le21U
	tPFGU7CACB6CdoMDRZ6JFwRj3+j1vx1DEoD4=
X-Google-Smtp-Source: AGHT+IERcbJP4ldP3RrpCdk2BA8bRtJ+on/WCKShhXzF0zUXYdidRdEPSkU72ClAH1VJnLWbwQdtsrdQzHzVv8h9Q7k=
X-Received: by 2002:a05:6512:ba5:b0:533:45c9:67fe with SMTP id
 2adb3069b0e04-53678fe69bdmr533917e87.48.1726086612587; Wed, 11 Sep 2024
 13:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-12-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-12-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:30:00 -0700
Message-ID: <CANDhNCpCudSmPLmh9FKWYONhbma3Ua+qzkPGOtQmOEbhj2DAJw@mail.gmail.com>
Subject: Re: [PATCH 12/21] ntp: Move time_freq/reftime into ntp_data
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Continue the conversion from static variables to struct based data.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

