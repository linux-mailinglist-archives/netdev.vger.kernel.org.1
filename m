Return-Path: <netdev+bounces-191097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A4ABA0CA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C41916ABDC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A61586C8;
	Fri, 16 May 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvBiS03H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4A7261B
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413022; cv=none; b=SXY7PqmyOcmyHAwZqqTIuIAVs+V+kmfZ3xg4WLD+IODfdK1tgjgy8oDauSyQs2O8ZkBNtGorAVZbwTZ/yFSK0+UOMJp3RCb8p8S1/bGbgy3FhityweCDQSbksD2L4oC6z3uM+RXqORXcewVD0VQ/zqe3kbETLxXYp788+lSbBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413022; c=relaxed/simple;
	bh=gPpFfKE4/BMdkxKTHh0j+IUzgUPhjtq1SQ8z3wbjpmA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pUV+A2MyU6cUfcfZ4N5NhJe+b29Y/d6hlsVbm/fNuWYFtb6oRBfddgWI0KlJrh47Hs77i9F9hIY7zZBhQqbmsTA4VeL8NQq0C/c5N5XeHPlb/wW1UgYa/0hymrk0T3RfbV8r9zHOrCELndONj7CvFbdJXks8txRARyygGbOaaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvBiS03H; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8c2e87757so1462106d6.2
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747413020; x=1748017820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6Pkr9c/xKKo46hz6f64WqTPv25bEp8K5wh01KOi/os=;
        b=NvBiS03HbGG6131/A1j6gEooSK4/jGpbhXF7cGx0s3DX8sT/PvQ/Np6ytm/DI0uU60
         iF6StSz2NvJe7CCBjb1jh1TB2cCabENIQ2RfTzFm3i/xEK7CpplWZbhRDhW91T2vOAU2
         F4OgdNwaeO7fzaBUrggJhvEISjU3Vc1q4+Qw9NE5yfvTMs5muKWCiz50aARiTjqtR5qu
         dZoNivDzuf8iA+duovOlN6Z3wAV3qcW1SJ+ziYERjGJR/YVIaaPhAYfddjGmmrUT7kcA
         N3ssEg3qfWwOCpWndxUhw29YdNlUWdVl0ht5ANLNi8txMkd0lPQSb3Q57FFx+vWw0PWU
         gGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747413020; x=1748017820;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c6Pkr9c/xKKo46hz6f64WqTPv25bEp8K5wh01KOi/os=;
        b=Yg5aEfBIzoWodCV5yvbwW1iAJbBvxKRPfZWVLyZQaSrTo+W7SnZc9XgWFvN6AItUQu
         J25viSYKkXgl3v+QrV5kE2/ekELmH+Ts21YvVXtcy8BMXl5RISI5r/2xPZYpFdrFV4KJ
         wA2EoIprSUbk72X6daOsc7QTLT0TQ8hzhjEz9105zCivDI/FNU4026xmdCeU8daTr845
         mUgqIebm3h1nJv59N1saU4txa55+ToTU0+hg5zIc/h2kW7pswS+QsyPprOaxvt52K+Dq
         aBQsdtkR3ai0VAAQtbBx1cX95XqxdV3QC0Tu+OfeoFSkLhOUle38/xbIT/0x8VyXn1/I
         9rxA==
X-Forwarded-Encrypted: i=1; AJvYcCVfbFQrW8Lc3z+s5kxxCf4YLRPkOx1tl6YKr9s1JLrzb87EtCVpZHpvPm4Exsea5lhccy1/OLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwNCIZNd6c9EtLXLt5DNFvk2oTMKdO0gilVqqgPgKp3KX1zXD
	tBmPAN+37bUP9w20oIdIc04xMB2rx1BKvEIE2v27AMHDuq00bXQfG7Mr
X-Gm-Gg: ASbGncv9fWCrS0OioRiJg3fsQ5JPntZs9mhY7o78zqrqjbdjo4lQ3aYax63D4JxNYkI
	r8dvZe0XojnTcmWToOKaUQwI3wOJFiOcZx15xLClpGRBnTPbAsILuQoUlnLWh/E6tMM0puXWvvp
	HxbPvBMM2i3zFMw4N0ZVcyCk1NWSO61M3Iuy7uv17RkzhddY3BqxWKbX0pbqcQayERcrTWJpMCq
	fuPYRaQC4RN+T4BAaVIsiEUgkf7hdvU2ncR4hgv0zsJaU7JazMngUMbzWk0cMCzuKxvIIcOELya
	qhW2wPOlkMzsQqbtzjT+uNmarjHAzkThMsat708q19dTOfWDKE9egVuPjboYB7ivA5FCO8lyzLX
	7OJOu8RACEEBy5nOgPbRzBAd8dcb1U3qygg==
X-Google-Smtp-Source: AGHT+IGuw6/HD77XYoz3umV1kHFTAEC2AiYCw7t51GxmfF0W06eKZW/kyAhef0eEh/zUrxErGXd2+g==
X-Received: by 2002:a05:622a:192a:b0:478:f6e7:2886 with SMTP id d75a77b69052e-494ae4346dfmr64696601cf.47.1747413019449;
        Fri, 16 May 2025 09:30:19 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae4fdb23sm12778241cf.62.2025.05.16.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 09:30:18 -0700 (PDT)
Date: Fri, 16 May 2025 12:30:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <6827681a5a986_2af52b29458@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250515224946.6931-9-kuniyu@amazon.com>
References: <20250515224946.6931-1-kuniyu@amazon.com>
 <20250515224946.6931-9-kuniyu@amazon.com>
Subject: Re: [PATCH v4 net-next 8/9] af_unix: Introduce SO_PASSRIGHTS.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> possible to avoid receiving file descriptors via SCM_RIGHTS.
> 
> This behaviour has occasionally been flagged as problematic, as
> it can be (ab)used to trigger DoS during close(), for example, by
> passing a FUSE-controlled fd or a hung NFS fd.
> 
> For instance, as noted on the uAPI Group page [0], an untrusted peer
> could send a file descriptor pointing to a hung NFS mount and then
> close it.  Once the receiver calls recvmsg() with msg_control, the
> descriptor is automatically installed, and then the responsibility
> for the final close() now falls on the receiver, which may result
> in blocking the process for a long time.
> 
> Regarding this, systemd calls cmsg_close_all() [1] after each
> recvmsg() to close() unwanted file descriptors sent via SCM_RIGHTS.
> 
> However, this cannot work around the issue at all, because the final
> fput() may still occur on the receiver's side once sendmsg() with
> SCM_RIGHTS succeeds.  Also, even filtering by LSM at recvmsg() does
> not work for the same reason.
> 
> Thus, we need a better way to refuse SCM_RIGHTS at sendmsg().
> 
> Let's introduce SO_PASSRIGHTS to disable SCM_RIGHTS.
> 
> Note that this option is enabled by default for backward
> compatibility.
> 
> Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
> Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

