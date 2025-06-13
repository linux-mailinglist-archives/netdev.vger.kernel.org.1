Return-Path: <netdev+bounces-197260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864ECAD7F96
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0798C3B4065
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408461B4233;
	Fri, 13 Jun 2025 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2qwPmHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96361219E0
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749774208; cv=none; b=A8IDAmRh33sBl1OB1YJLDCFxPypZwErOMJtLPiwPXRa3oTsSIcZUzt5R7WGK9UMsfTXkmf9oqAsQGRpcj2WQHaIclYC9QaMqHrKza7BPAXVQrrjpVTme/Xf+5MOj4JgRVlUtNZ/Jq1VENlxoHdUQsAteCz4o59oYv7CdQhxDcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749774208; c=relaxed/simple;
	bh=TS3wkFdfUoxaY5a+vs416VExxBsFbCH8qzAMg6qQqmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxlM4uDvmJmRmTGm3pqgMB9Moak6khBxsIQQuQl0GEWvwXAkYq5gigdeL7IgYhbEkN964YT8/jbHa4FCIV49KFowQax+J7OMWP+oGRy8OT5IkHWdiMdACtOSpIPJq1GT7OGFzrFR6g3Y+bwhmhphKJxZNYs7pghNjlRF/jtC4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2qwPmHm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553241d30b3so1311286e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749774205; x=1750379005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS3wkFdfUoxaY5a+vs416VExxBsFbCH8qzAMg6qQqmU=;
        b=Q2qwPmHmrRgvWHlr5SsyAQJBCR3mHq/Gf1GjZviP4ctCmcYx6yRYGe8+kJ8D4jVaib
         n87rACLU6wyPmSyNsbe3FjWOW14zyD9Og/SSimie5D2T5XvgZxmC/f8qvoqgY4LHEODr
         wfPNpK4KF4kxP1RzZKQkgg0+wpRc81vo5RaKHAK0hN1i8X0edpb/Ch495sZ1HJKNyUZp
         doeaRfEf9fTMmHx90SXfQPo5+6pRqTvfgxEmRyCASyIDajY6sWE6Q06g+lH5DWLVkpvd
         eK3mE3JJCHSaliiKJpPoTAKkaOB+yb7M3RgnNvBRsIp1GA4XJckNh7XWj8Unz6qiXHTL
         c0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749774205; x=1750379005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS3wkFdfUoxaY5a+vs416VExxBsFbCH8qzAMg6qQqmU=;
        b=t71RnkiTJw/Fmbo12jL0IWMrB9WKKgdW6mqnoF14dl6psdbGv62IEluEO558MiIjkP
         nW61tZrtmQCL4RNwn8ZCrhKtKvYrt1zVjWJ/kaByJc/8W3g1LpnGR3mO5znzANXpc51s
         vJwljo4kqpKMSj3KGBf0tHnUSnmw1zMgrKUfktBQ9rOvLWSv92+GwLHL/nz1CYwHeWtQ
         X2i4EnNickxctOAV8e5A8lJ7kQMbFbgZC5gDL/z5EMKzIBmyClXPMN5x6MhQWG+uUx2M
         0uRrmCt1l24yVQqAQRltGoKK5uInKacZrdrPGaQEsbfhI6IQyhH/h1YX/Hs44Ps1+nkK
         kzgw==
X-Forwarded-Encrypted: i=1; AJvYcCVmI04p6nM07aSOjZq1pyzcfRo02md2PzrQrP97/UGZ53clMBfSx1mxOC2gtZLy7c17kiJniy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSVFOUazmAdAeedz9ZZfkMfmUIBzd0LyR/RP6S9iPMSrWoY2p
	xWDsrgFXomqM1bAsgJIjVQnVv7vsUyc/jaKeoNPHofeaMMpkMpBrlRJoafNIk6GjC+f6zGPkDqU
	qP2bt8Dp80CqoHW9rPilLo5cYCteWpcu3r13Qqb8=
X-Gm-Gg: ASbGncudQ+RzCiWgAqR6dNAXQRKBwn/+va9fCNB5FNN99WdAyzRo5LHhFi8eX+aCU9U
	SknS/gLI/SOwjYWJ1qjPO5Mh0mKhxpke6/3oscLIFxXOJWl5jWG6PK+4e8jNCVcgkK7X4c0maa0
	p0OQw8+YiQAHqUAjXtwVN6W7Z9BOzdTMkLenk78lhglDfNoWHvuUyRb7afGAMFySXZIjTeK14t
X-Google-Smtp-Source: AGHT+IHcAoV0ZONWAntX/rSo3VVoA4FvIxK60Y8BbvgIcNzQhU9I/mNNOCSSR75Je2/IGqS6rDIM4xMyeYKoYouHXdo=
X-Received: by 2002:a05:6512:b1f:b0:553:a30b:ee04 with SMTP id
 2adb3069b0e04-553af907766mr267255e87.14.1749774204575; Thu, 12 Jun 2025
 17:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083026.160967312@linutronix.de>
In-Reply-To: <20250519083026.160967312@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Jun 2025 17:23:13 -0700
X-Gm-Features: AX0GCFtV2q7e7qLHBw_niNRwvEth_ypgrFE49dyQa37Y-AtXub8AEe7HUlEA0tU
Message-ID: <CANDhNCq8SGR0oD=OZGVVn0z329P20fUt+fxFRGJOv4J_fyJSLA@mail.gmail.com>
Subject: Re: [patch V2 09/26] timekeeping: Make __timekeeping_advance() reusable
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
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> In __timekeeping_advance() the pointer to struct tk_data is hardcoded by =
the
> use of &tk_core. As long as there is only a single timekeeper (tk_core),
> this is not a problem. But when __timekeeping_advance() will be reused fo=
r
> per auxiliary timekeepers, __timekeeping_advance() needs to be generalize=
d.
>
> Add a pointer to struct tk_data as function argument of
> __timekeeping_advance() and adapt all call sites.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

