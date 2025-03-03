Return-Path: <netdev+bounces-171282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07B7A4C56F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C819B162DBE
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3B9461;
	Mon,  3 Mar 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dewesoft.com header.i=@dewesoft.com header.b="uJguMj8p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74A15689A
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016529; cv=none; b=PzRSYNXp/CpclOjNUxiXxCOdwYqnp/aRjmR/UHytdrAlfWA/Ft9QjQeBGK8lwNI2XSr7AhiRwhzv/SqQbB+pIPep01CU4G6MOPQ4dLHk88PJW0FkeM0Tl2cS8FR/Zu/p027k5IIoOnlvIZkR1XbccWYn8QCwt5yXKKFYXMmfuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016529; c=relaxed/simple;
	bh=NCeiuXZasXVnEoWKhbBh7q0nCnXvh1in/5xX8SeTgG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYpmSu9djB5oV6oeHjh5glrnXiYUtXS40imGLKDf+op8Cya19oJrSPlbtXg+eZkRLWUCfKJYgFmI4l0e6rIWjmKCPiEqNx3+3kjNb73R9QTK+5k/ZME9Wf2Y/x1buBVvEUFl9ujucUuERKYn/H+H8QbeFjCeIVwgqirk6vcZcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewesoft.com; spf=pass smtp.mailfrom=dewesoft.com; dkim=pass (1024-bit key) header.d=dewesoft.com header.i=@dewesoft.com header.b=uJguMj8p; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewesoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dewesoft.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fee4d9c2efso2695227a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 07:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dewesoft.com; s=google; t=1741016527; x=1741621327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn3hULIm4DDHKCq8F6d3jSV2qyZ5ibwAU1c3f0ePgrY=;
        b=uJguMj8pZd9cXNa8FTEBytP6kucm0YaFGUJ/Jnz0z/OlB1tI/m7wRj0YyAyeOfiG6p
         x3aE2zprHe9bSgV/wzL6GUS5AUeynSH7G398uGSPrTqNregm6zO+XBDIiOSY1moMH307
         qEoTE+mGo1Z/mOECpwtAAP1vMd1zFa/EWrYKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016527; x=1741621327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn3hULIm4DDHKCq8F6d3jSV2qyZ5ibwAU1c3f0ePgrY=;
        b=ePgzbd2SNIcaEoR528hBQdPNhUavedy9IVSu+F7o0qAEtOjDUzlBCrU5pMfUPoIPQS
         yjCjrabe5q8eDzYr13ydHvClybahZ5VOKXVcRK36VbkaytccHo9GPTn3SIKyURE4YNK7
         kQ3JOuSbBd30qK8hQ3roo8s//8JGTpZffWcZmL6G2ucbVIm/v2bnH2KCMNQJULWTb+Je
         YRRa782mYONba3OUJv80c3vBnP2ztFSNy+1uuMamCT0w+yL1jwGKm9RRsBmCEX/qBWlw
         qMWXQatn0V6bf/jKasvGMJjHH/2Lmweume5PFexSCsm8XFl2OzTZDKtH0gbFSN0er4bg
         jvFA==
X-Forwarded-Encrypted: i=1; AJvYcCUE9tmrX8zaQfR5UcDu7Cpi9JsHMsolXqYEVV+MC6PYyN3cA2YjrV0FKbBIN3fDQ2NMbywhoGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLY9FH2wSaxuelBFFgFLt45w90/XTdA3Z6GFq4wCLghfszKlz4
	QSkcYIEai3b3EBKsGk2mJoG4qmBfnzsMN/enPxA4cIdCKiGEU/taYEfgYkibXmZ2vAalYlNVy5j
	hQU9L6jJDgkCNK5qG49xz/SvBuicUiWc386Y8tQ==
X-Gm-Gg: ASbGnctE2ynarGq5eJramDKZui18YCGXGptjCF3thUwT38xJktmjr1p/MKDx1Zu6UKd
	UPvHN92ZMRbljVAI30OIIxoEpxLJbd7bAL2a5LocHyrR//sNUCV4L01YNtniPnhEskq0zlY3n74
	70SaH3YKpO0cIMgWT3OAVo8jUt
X-Google-Smtp-Source: AGHT+IHOYKQtaKBUev0fAfiY4J4Jr7syPAtKpI+gPvvIEr5YZy3mqGVDJn0hRZyvCYQFSsdW5o1gIeyo10PL1Vjhb/4=
X-Received: by 2002:a17:90b:1b47:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-2febab2ebdamr22439528a91.2.1741016526915; Mon, 03 Mar 2025
 07:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303102739.137058-1-viktar.palstsiuk@dewesoft.com> <3a80404e-9baf-423c-bc5e-22c3d80a0cec@lunn.ch>
In-Reply-To: <3a80404e-9baf-423c-bc5e-22c3d80a0cec@lunn.ch>
From: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>
Date: Mon, 3 Mar 2025 16:41:54 +0100
X-Gm-Features: AQ5f1JqrSUCb43McddORlNMJRRgMyIEldyB6oTNtVvbKOCkiFlczmw9At9WrOK4
Message-ID: <CAHQtF0u3zXqLcd73xk5G0+g5Tek65M=NfOSkfvRz75B7wY3pXA@mail.gmail.com>
Subject: Re: [PATCH] net: phy: dp83869: fix status reporting for speed optimization
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, the term "speed optimization" is used in the DP83869 datasheet
for downshift.
Viktar

On Mon, Mar 3, 2025 at 2:31=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Mar 03, 2025 at 11:27:39AM +0100, Viktar Palstsiuk wrote:
> > Speed optimization is enabled for the PHY, but unlike the DP83867,
> > the DP83869 driver does not take the PHY status register into account.
>
> Is speed optimisation another name for downshift? When the cable is
> broken, the PHY will find two pairs that work and use 100Mbps over
> them? In the kernel we call this downshift.
>
>         Andrew

