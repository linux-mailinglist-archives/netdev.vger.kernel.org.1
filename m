Return-Path: <netdev+bounces-197247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4DAD7E70
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E306B3A4732
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390F2D876E;
	Thu, 12 Jun 2025 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x6sSDVgx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE3230D1E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767708; cv=none; b=dULLTMbacWKa2wrpsrXrZ3IMizS/b3BBEEfu21jMx8zBllw1L9B1XpSsayIbXvMkc+63XbNDenRAyhKutib03aWHqXLOn3zipC+hkX+cfAHBjuxHB45n3KpzI0NcfYj3nUfuSt2QrwPyw2hDkhdG7SuwHfcBeD3RgnMuevxmpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767708; c=relaxed/simple;
	bh=QA2tFYqN2RlJKEYGmIpVctDIKIpy36En/K5HHqEQ9c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPeS4FomZNqots1gq6gTBCOeHnRob3q0Wc9hvQrOJl4DgSnZDqe50qy1WC9YQWuyBBSeO0wHlL5XeAlFuMTSw91UTyYyA2kpF7hXIuJCAve0SPDLR4hkOdZ2zh6Un6uFpt3MgzrV2zLNAhFOlTYcahUDiNhyXbVuzi4rDRpmBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x6sSDVgx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553241d30b3so1255879e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749767704; x=1750372504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA2tFYqN2RlJKEYGmIpVctDIKIpy36En/K5HHqEQ9c4=;
        b=x6sSDVgxEKu9+/jNIUGNkkSa6u5Fw/fmnn58DJpu60m1P9yGIwciRzBLqitV9j/asV
         Nlkvv8fIsEQNlCLCSixipf3M08vVJPkHqzFtsKo4k8SaJuXaNkCeRQttZnrr9SJH3lCH
         okEPAQRrzgEFYQQcE6QWf9bPKQMTRMVRnjKBE1kDF+0P18ZC9vtiNjUsPiUSU/41nKaU
         gHfNepT4/cvse7RtkqaLgxUPF8MuuptH/aGMr+VXKT++wP8FAnAszteBiw+0c+QMokLz
         m7uU0yNDgP8o8Wb2VSp34QQGIyV7BC3x07hd9+ZZOtEQHy5IrSVSJXlsls7qPd6milKR
         tR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749767704; x=1750372504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA2tFYqN2RlJKEYGmIpVctDIKIpy36En/K5HHqEQ9c4=;
        b=AbfSgu70oTy/cLfWK0BTVjdVhNYkgcbxdvAQKiC/yjowOXipKoWPaRhYqz+/ppZnMB
         CCvep4CWMujMb1ZnO4VWfB/FR8dRAxy++GLlsWFRsUFl7bGYkKiDDCQOLl7d7n2lWdFM
         1svoK90CBNfGtrih5LYChBQ1/xWtor4joScZ5vdobFBCRXbWaIOe39UztIwtmlrF5gk/
         d/CMIHVZ914+vGPJkmfryp2NQxEKmZDrdOiNF8q2ZPWGygNY5CKQqwfdDTL27CONkeZJ
         /M/yz0l7pYQjKkF68ag8JYE1SHT207Z00Vh4wF1EmI+r0Ze/FBA6P8njHOsvlX1oSRxB
         J0NA==
X-Forwarded-Encrypted: i=1; AJvYcCXFCxNapKkHcfu6QyaD6Hl0vOgRXq3LAVxklCg0h6xEL686Y4espo1drMcKpvVFBoybiNEFhZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOL6oyaxaeVmrD7erXW01XUc+LGk70PMfcI7bSUneIlQzE/zHW
	MsScT/Zs/5B7q8MY6YfpubEyeUk1XenZ3VuI+RMwHydxwhX2MGmF48xMN3uIWzp2q4MkUdugkC2
	+j4kqg53HYO8iTldwupQghYCAZHKcCo+pihcVsuU=
X-Gm-Gg: ASbGnctIv3yLPGSnwedZHdwKlTRRCSdU51nP2ndoyjSYLW/9a49rz5VVH/y1TPEUQbO
	loojekg8SOjAvvRORJm4WNVSJKcmqYbir2O27mMrxMm9iFWqNhWWMixTxE86eAZHoi76KLMje/R
	9fdmWb8YJ8kpZzBkVE/EfrtWY8hDRJVs0KmEf4i9Ft2dkrxGmAEZGPQxuKpUUs07lEcSCS3cSr
X-Google-Smtp-Source: AGHT+IFDTJC/Vdt2wLIjM69G0c0CvJ2GlOg6VdkTRaJzAf9o9CG2KNlttV9DkWauNgtO6mb1ZL3ESwCTBOwtfSJnIJ4=
X-Received: by 2002:a05:6512:b1f:b0:553:a30b:ee04 with SMTP id
 2adb3069b0e04-553af907766mr218487e87.14.1749767704397; Thu, 12 Jun 2025
 15:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083025.652611452@linutronix.de>
In-Reply-To: <20250519083025.652611452@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Jun 2025 15:34:52 -0700
X-Gm-Features: AX0GCFu6c6tQwPqQEiNiejJsors8-caVPvvKXKm_2z8brWLY2l8YznTJmGjnNoM
Message-ID: <CANDhNCqWeX2TX4Yne-g55Rpat4xj1QHo5xvuTMt_7R3B78kvFA@mail.gmail.com>
Subject: Re: [patch V2 01/26] timekeeping: Remove hardcoded access to tk_core
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> This was overlooked in the initial conversion. Use the provided pointer t=
o
> access the shadow timekeeper.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

