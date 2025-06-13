Return-Path: <netdev+bounces-197257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144CDAD7F85
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B962F16ADDC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD4572624;
	Fri, 13 Jun 2025 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjcCqDkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4242EEBA
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773677; cv=none; b=jPU6Z7VIRhKh8PWw1+7y5LdZwLVpufiXxBlG/gEtnBVkmM/kTqknWfvQeKtF5c+VyMbHmW7UoMEwGHEHRXZ2/MrDL7P+JcCpJIZewTEI3F5ZewUS3kp+9A1Qw8IqsGODKho2RckDBuHY8maEYIQ3Vs+IMCQXJSH0+eNIXFR8Rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773677; c=relaxed/simple;
	bh=W95sicYb3DBTHTvhMHg2QIVP9uKVoy9ZGlZkVbqNXxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F75krbYqoNFFmeJdlqSeQzfdv8LXyLVGBdJwk7kgXTA8PkKW/qy3zDJhH7JRzE8L2EcnEtiafmWSMdTXVKNowVYQPpMVYouZgyaGNMthUgT8dFQ1doMezBE1C4dKmUoitOsVQL4RKOWRTSGGCxv+Twr5KnBicn3y9WfH+vanAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjcCqDkG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55324062ea8so1786740e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 17:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749773674; x=1750378474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W95sicYb3DBTHTvhMHg2QIVP9uKVoy9ZGlZkVbqNXxs=;
        b=gjcCqDkG/+nPWjDV8HT13gTmFg8QZ4RMpV//zhRXTmaWJTUbLCREWx1xV7T5/6ReIW
         INxuaazjm8rPM+B1yShVPcluW7HqG0pEF45hzKde9gRtfBjHXzGOrri5bo6S3X4Altwi
         JDkzyWXaf+Hag4Ad32UtIuN1dwVK4oUTzbiPZwINw8BAGADnUqPgf5omUkAzHOp6OcnO
         1fqE2gkxhYVnn4t0AgKyipLu7FTxeKcKlpdJni5bMqHm3V1RFhSMhiFQn4c1VjYucNRR
         N578ZwlneVUjMqHADRcvr5EdtAqKAoVOA2InsXlg3CstRVLeN9jGmH4E+vTmBoW+1U6n
         vBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749773674; x=1750378474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W95sicYb3DBTHTvhMHg2QIVP9uKVoy9ZGlZkVbqNXxs=;
        b=qH1ZhF01Icc60YqkdCFReC56ip5mIe4OjBzPR43vNChtHOk1p1MSFxhltu2HAkosL2
         lGpixNJEWX7wqvA/qsdFNW4nNR8bytq3J03WcZxW6mo42W0mnlnwZ3xH2YtXJtuN5Ot0
         TcFmDZxrxAXSgtRKWEZHUP+cDl/Y5Ymz8E1RESSKGXJ5sXFiAIVkQEtR62ucFIAxywKW
         0X1Q1PJINXJP0SU6/9pGTbzEnKYf3vBhlq7CIYZCouKXVZNhOszORw0R3IGeJvToQSAa
         Z5cjBGY/wBC8J93hZUEuoXa3RxO5ASrDXwGRAXi+1sCPHW3xlRF9b3tY6A2dKeIvvGyx
         g3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUutDu8qtVbOwcrbrR7wTIGWK7e1uetpSrPeJMY6QgP7W4zPStXe3BULws5ruifDDaL52RgUAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUN6118czeiGH+ohd5Oks/4+wFFpv0BSima/cIkJsThxIeGFl
	RV6j5FGp0LlS6OM2+itmLPgBBbL1U4zUklaBmofmbsJpcZn1o1wfgTlAARlxnNH6KTlKePu+79T
	eQeSLJJrbKq3d/3lDerX71iEFlqylqNN2mvNguXI=
X-Gm-Gg: ASbGncvnOSlWsRlbq0sg+LYGXMigfzyyyRAhySpqQIHNnGrmLzv8QIPBw6vlTc6GFHA
	GTUOvw6q5bMFW5n0E2qGWuk6AXUQV5Qs2QAMGLhLgWwSneE5rWjDe85PiNv+LdgvmsKTkqABRp9
	xyxlEQJZB6fpebp/lYPGK/PAdvO5UTXAcs07o5G0xBm/SLwtVYXGRUZY2rI3TyhEYBDJQ0F6MV
X-Google-Smtp-Source: AGHT+IGXfe072/S+IbrdLEVdgbY1mrI48ADBA/gbdqhoZm57Qazo5mnk0mGi8CKpUzjLaZXKIg32S2LPiScek293jjo=
X-Received: by 2002:a05:6512:108d:b0:553:267e:914e with SMTP id
 2adb3069b0e04-553af8f1103mr237080e87.1.1749773673482; Thu, 12 Jun 2025
 17:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083025.969000914@linutronix.de>
In-Reply-To: <20250519083025.969000914@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Jun 2025 17:14:21 -0700
X-Gm-Features: AX0GCFs5q8dW1D4KFUP8MHqTFKr2PwuUJB0Zhfra-q9b68lRNxXBwYSYoWZY8_E
Message-ID: <CANDhNCpouVL82iGnBb_gDVBVkjPs36wx0T0Dp+zPYbatTgeY3g@mail.gmail.com>
Subject: Re: [patch V2 06/26] ntp: Add support for auxiliary timekeepers
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
> If auxiliary clocks are enabled, provide an array of NTP data so that the
> auxiliary timekeepers can be steered independently of the core timekeeper=
.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

