Return-Path: <netdev+bounces-127563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E29975BB5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E851A284961
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF661BB680;
	Wed, 11 Sep 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEfvoARy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08D1B9B5E
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086443; cv=none; b=DigMjemFEzVP6thS8MianGrAAZOl/wWP5o1BmcAkMxgeDGEdWrEQIXGv8Y0ZphGvkCcFKnOB052s6BbwXAR8bR8QJeBLT54G2M0dpnWCwgwrN1uqWDmXe/UqAo97oUcVhTLN8VlGGBHcg5kduB9wqvazltaQGjkYUujtC86uzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086443; c=relaxed/simple;
	bh=usQB6eg6mpIjrsouU/6sUW2LWu5N/XOscjT9iNplmEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n97zNEHxzH2SWb+LTCM7NAT7XhYybABvWdBVuEAaTFFGGLKYaLar9jJ2Wt3GtieyO92IpseG8AZNG+cEKS5fk9aVsHwq9TRVt7kS8Fd2oIYdXQzGqkUbZ/JRcF2aNUlZNvrXcCQywvT/eSgim4UzQNFMnwRDpaaK2AtgGh73+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEfvoARy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365aa568ceso273249e87.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086440; x=1726691240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usQB6eg6mpIjrsouU/6sUW2LWu5N/XOscjT9iNplmEo=;
        b=YEfvoARyWSQ3LozHIRtsuSCZbRcDqLuHPpYK0CnEHBOACmLm4qSdM3bOT8ZZRndG/e
         NgGspu/x3ym85FPBXT0kNtdq6cHunvEzERWMILpBEUV8CCi4zI2fuJRdExq5oIPrfl6P
         5vJpp2HR91ZJZ/rhj7/mLH8h3jQLcvchCgbutIYL32h0sEJJqihab32CoMhtRRQZiMuV
         dHsdC64xeWYf6cA5bN8QcBbIQXNr/oyR4fIlElCULLXNPAWvp8NIndp+1nF1Cow0ZN89
         tBkrFj0l4AfK5mbqGQvRFJ56/9PXpzyX5YV0j64e5lh6t/Rwl9lP1TGm/5RtIAHl5x3L
         XhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086440; x=1726691240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usQB6eg6mpIjrsouU/6sUW2LWu5N/XOscjT9iNplmEo=;
        b=HhGzVdnnRBRn05T8lh7KagJgQlWyQwY0Q+05Tc1NGakBsX8YXyupcriDhLrxMksF0Q
         1ASjWPNB/6mcfiq0i6S+85LHLlzHiqYrXXgD5coE375HtU/uSZ/GPGN5S2Eb7uSqHTZc
         TwlD2g8sfngaskpa+JIXrXpKHqTWrgJliarchYj63dJa5ako2BR3XIYARf2G9SbFYH3b
         ewyKRPlZca49iwfCrPSTd9nzRdkLyLoywNrGRHogQRBwYNlqNyZdA2D4eWvZhGTFX22d
         n6T9QYPpJdDLAtShGbgSAbBGZgXj+NVfh3FUNLV1OgMdC43kEH2do+EURKn6xrZtQ1BI
         /MUA==
X-Forwarded-Encrypted: i=1; AJvYcCXGXGUDL/l3PIZJ+VTajWtgiNh0RFfNCMxrhK0DEO/KknMt2yOUJCD7dVEOxbQAR/9ae+DclBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfARsipnPTR3SZezw3lz3zkLzZAnSA10YrV9ktSEn6qMZ0ZhT
	MciW/5+0mWxyffawf3LWxzEEnBySzxUD7AqAygF+FT3GKiPrLDP3i3Ll+JREsBsr4OkO3L9E2/9
	KoUkF4phmHA3TmdZndDA+jtW+DfcX5KLyTN8=
X-Google-Smtp-Source: AGHT+IG4PlV5COBYM0Q2Nd2Q2wDM/W9ZwRGrJE/N0l3sWkn7WmQMK2BHy4vlP8e6y/RG0l80VfT0klkI72P4nGw8EEE=
X-Received: by 2002:a05:6512:318e:b0:535:6a34:b8c3 with SMTP id
 2adb3069b0e04-53678fab4a8mr420583e87.5.1726086439266; Wed, 11 Sep 2024
 13:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-10-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-10-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:27:07 -0700
Message-ID: <CANDhNCrNpLWEbBmx=6a5i6HVtCe4FXrJG9RsY_ak3gi5-1eHPw@mail.gmail.com>
Subject: Re: [PATCH 10/21] ntp: Move time_offset/constant into ntp_data
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

Same optional suggestion on dropping the time_ prefix, otherwise:

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

