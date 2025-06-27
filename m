Return-Path: <netdev+bounces-201751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2D6AEAE52
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8101BC6BCC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 05:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C411DDC18;
	Fri, 27 Jun 2025 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1aVgGB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B461D63FC
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000860; cv=none; b=ts2XX9SGdL6dgTU+O/iPZnKDhapkcO1ZQEh1Rr7TvRthdywtgAwDNpy/rNCypnQlEu9Is5++cUYa726FavRnbEtBEUkgok0jgsmIoICtA29NdHlUtKNCwbWMfE21yBojJ7dC5IbO6nY8RNEGaiIifpHJzyd2lfwvAB/jTTWbGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000860; c=relaxed/simple;
	bh=2jTyaZEVZCDBOYHIG9nqVE9O1ZGXwzKw5BHDVbCFVlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R15EP0YOAUiMjTK6gxMFq92vTRmyIfcqi0MDWZiVRROzHPrbWOIulRMnpSjZaExeZoZzcUEquL5BFNw2sS3qlBeCXdYgRseSWM88BZKFLC9NRWthtDxbl6W3/E25bZiYM1aadk2uT6jq7nBuwyZPyA/301mvN65C8Ym05z/6EFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1aVgGB8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54d98aa5981so2533425e87.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 22:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751000857; x=1751605657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A7L9oBOR7PWGFeQM6s9A8luVlFRq3afb/H7jm8mtpw=;
        b=Y1aVgGB8NHRnGy9e8ovMXPhgR6al/f41FmYy+aL6JhrNiKrb1/DH32FeEYadYlfg7G
         fSeRMAISlSFKqgOmNHfuupK/btFUQleIQNqt2EjALJPSCqYRVx5XzYDVrJvXsuqISB7D
         abwYkY50V/X5gkJRlkmrdLaTs4r+7kByKPK8GEO5Ezb8H+4TyyFkjtPMNCtCuUi7gFaE
         ckAZwzRZTJG19GJV5PQMqeP8tvK2q5+NE/LX7DvaS17tjOGjO/BwaHKihlFFZ2/kYUh+
         kCDBDdieHcKgjOJ+jPG1uuG4zAecWcX/fPdjhhhwYDIleqgZN9tBEZ165DDkOib5GQW3
         QLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000857; x=1751605657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4A7L9oBOR7PWGFeQM6s9A8luVlFRq3afb/H7jm8mtpw=;
        b=feTLjrigB34REG4FgLqVlHXC09MjWm41ug34hRPq2qz1efWIemaU2Kn6vRATO+qOoe
         Tm8FJdboMtNaENpaNvY8CVpDrqFp7wSoNBh7x+zQzl6WrQxbp0C57Go0zVe23uASlq+Y
         YNBGIoSpsrwGSde2bIAw3dhqYm7uIcQaEr4bz75MPbHLvl+8eYj/NLAj+4+4wM9ogPkl
         /sY1cULEj954RZY6NkM6vkcGlytpgVaUFe5gh/eCLaO9RxeYTarzqsrJ/VbT+kS3H0Bd
         KM6LWt9Dw0mCfdmcSYA+6rF+2CvMMbmAKWH38yWcGSQa+2/9GkYFeSxD857rNv/pAl2d
         AcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW99TPj1c6r7qdNuzwGXx45vLd56CRACLTyjTAqMdL4HDLqwk1faMglCBAbc9nMKefxQ0DV4xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2keZ6N7H9w1DbfLPbHhBdrtvEoGt/FFVHXCzWDiylJPLV2Iq
	cQSA9Fgl6AfBdKdL4W5oh9skMqse5v6GGqGXipbjk89BGfDXdgbUjtk0zy0+MP3U/VCt4bKNn/J
	IjUnR2S8G+Y1RrDQ/EW4U6IBN/+iF0q9ad6BtV9s=
X-Gm-Gg: ASbGncshQ5m7OtV7WweN4bqKbf1UsoyNGPQB/zE/wFs+/+hqtwJ1/PNn8rLzDiS8sSn
	DovwU/H/2fnpCAJh4O2WPugYIfYcERz3OSPcB6TKP4+A7IcjZ3la43sPZGwMPqgB31WKt0aKOjp
	KxMbzKDRpV3o1LnCIBzQpN0zUnV4047VfoVxBWvzZmDrK/v8ORG3433ll0TcHeYQGGy3+9JEvjy
	L7EcQs17HQ=
X-Google-Smtp-Source: AGHT+IHFd/GSAXNRNxFTF0LRQgz6ri1puABY2Ac0mTsP3NA1X04IG6EZmsIhm+tJdZcYM08CHCqtcRGrtARbEE8gTkI=
X-Received: by 2002:a05:6512:1246:b0:553:aa2f:caa7 with SMTP id
 2adb3069b0e04-5550b88cd1emr592637e87.36.1751000856677; Thu, 26 Jun 2025
 22:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183758.444626478@linutronix.de>
In-Reply-To: <20250625183758.444626478@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 22:07:24 -0700
X-Gm-Features: Ac12FXweFyiwFx75YwCZ8m7yeIqdL1KJZjXU9Ynl5dP9hKBG-nBooG0LsViCxwA
Message-ID: <CANDhNCpmpftcJ2UfQ=dFL-ygvCFGR4rpfd4qStEcF6R-KeM6Xg@mail.gmail.com>
Subject: Re: [patch V3 11/11] timekeeping: Provide interface to control
 auxiliary clocks
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

On Wed, Jun 25, 2025 at 11:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Auxiliary clocks are disabled by default and attempts to access them
> fail.
>
> Provide an interface to enable/disable them at run-time.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Use kobject.h, clockid_t and cleanup the sysfs init - Thomas W.
>     Use aux_tkd, aux_tks for clarity - John
> ---

Acked-by: John Stultz <jstultz@google.com>

