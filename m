Return-Path: <netdev+bounces-152510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4879F45D4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1A41600CE
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D91DAC93;
	Tue, 17 Dec 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajqB7DlV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9721DA0ED
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423395; cv=none; b=iWQwhbDud47dgSJLaip5pjagoWTfdheA3hUoVEKBZZVdeUeIv53Q0rPn4526lF2K3mUGtnVVL7oUKCrBbvLhxukfeh5MjduwOYtnvuGQEU7eHWoUrhYLbv9zFTMaurNjeIICgNSLFn05eIfguCpIfGx5C6e3fgA/rlEhLRwLE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423395; c=relaxed/simple;
	bh=TEQwfjMPGkhdsR+WurQ2jiRxK3ahF+A9mPh6oCOch4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4/Rn/INvHOS351BwhA+NHw9stPDTyVNEq7jmhGhlCbBEVC9b6fkAiWSoFxYwn9636rSQi25zcV2Q4vmUbAK3b00OQpSSXbpc63BLuzCrntnkfNsd0yav4HpB2D0P5ZWDtXfQpdmF3QFjZwct9Lt/sichSV0myUSQBqxKJ4WHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajqB7DlV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso7930598a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734423392; x=1735028192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL2feE5AJ6SSI4pvTMa55DednyFd7NS2A7NZzkYnzHo=;
        b=ajqB7DlVyyMvz3Jb6onUgI2rK1paJZDmsfk3fsgpLfl2yOSmW5TV05Vzo/aUkXAE+h
         LsXDpoJsQ+UAcRKszEcsadhYkUv5+ukYkCYpZdacHFB1MbSpDsxz9W0k+RZTDZp55PJT
         aAACnTz6QcSRraQQkHODNiLODDjYqgcH18TKxPG5Gha63X0fcMabAH4Uy+A/rMYctDEZ
         F6Z0z5lXRXF+/sYL97TFIS6KUuMITqlZVE+b9IXHVCepq1VOfJUamza5Q2Xt/46NXdxE
         DU6xsiHd2SIOhgzIZ2mtqMTQFzvh77EiZesLPyVoiS5wTNH7pUHyBcVK+aP7OqKMU4iW
         r3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734423392; x=1735028192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL2feE5AJ6SSI4pvTMa55DednyFd7NS2A7NZzkYnzHo=;
        b=FDSGUbLFbYtlY9OQHXc3TRzC2vQloUvWuLfui23ubHYFLLPdMep0tLs7xVKF7i+tet
         E5GUht4sduUnrN0SVGL8kjYye6LAdl462bdEds2fBmxR7QG/j+hErvHUX+C69TeogMNb
         uunnWq6AYq99BC4ZETZ+9ZGSw910agA11AOcpsU6uMW3hN4IhPLxzu+KptBBrP23FIkf
         JiWvrQWjFdzYLvwU+Nbf84s9tjJkmCjyRAUCKm10sCZLIBpbmCqy4YLSjRGLPYgGpKa5
         pEuAe7yRCnUGu6m4pArNi6Ip5AKOiZoLEmT9ZqK8Oaz99AsQ9/3jfQh/tn6n9lzGQAPF
         Cd6g==
X-Forwarded-Encrypted: i=1; AJvYcCXdwlfHcB6+VgjP5b2UqmD8rtQbEP5/MHNhPfCA8AnHtuiQ6WO0QFQuStrNpGvyity7e8UAbAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxghstBT8ie0H7U2qkf5HhXzFLSzHzlRFwbihDrG8yAURYC0wbA
	W0dVlTvVToL86tsOkc5x+0Iv5+80qhj5Tx3FMDI+0K2m9ExM9dMwPr3p7szl8df96dVeRVi44Q9
	aEY5HprAaa3WaJ+FDW7LJb1ebIDQYYTdBXT5Q
X-Gm-Gg: ASbGnctXW1tkTnZHf/jyWP0q9c7VAROUduojUswPJLJGxNVK4tHfJl5MytLJpGIBvet
	mAedSBDK38uIz6ZGYRIt7EN6EmWQxXCIt2qzZUZ1ZxmJmqW1ceygYCVihI5CUV11aIETzNm3Y
X-Google-Smtp-Source: AGHT+IHvOQNHHUzZZhpakqGzbgg0f+KZLUwMpZirhCCXzghhhZojKMMtWfuof6FgPRbxHa3SPEkaCDyvaCOA0s5LVS0=
X-Received: by 2002:a05:6402:1ed5:b0:5d3:e79b:3b3d with SMTP id
 4fb4d7f45d1cf-5d63c42a44dmr14310743a12.28.1734423391517; Tue, 17 Dec 2024
 00:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 09:16:20 +0100
Message-ID: <CANn89iK1+oLktXjHXs0U3Wo4zRZEqimoSgfPVzGGycH7R_HxnA@mail.gmail.com>
Subject: Re: [PATCH net] net: sysfs: Fix deadlock situation in sysfs accesses
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>, 
	CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 8:18=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> The following problem is encountered on kernel built with
> CONFIG_PREEMPT. An snmp daemon running with normal priority is
> regularly calling ioctl(SIOCGMIIPHY). Another process running with
> SCHED_FIFO policy is regularly reading /sys/class/net/eth0/carrier.
>
> After some random time, the snmp daemon gets preempted while holding
> the RTNL mutex then the high priority process is busy looping into
> carrier_show which bails out early due to a non-successfull
> rtnl_trylock() which implies restart_syscall(). Because the snmp
> daemon has a lower priority, it never gets the chances to release
> the RTNL mutex and the high-priority task continues to loop forever.
>
> Replace the trylock by lock_interruptible. This will increase the
> priority of the task holding the lock so that it can release it and
> allow the reader of /sys/class/net/eth0/carrier to actually perform
> its read.
>
> The problem can be reproduced with the following two simple apps:
>
> The one below runs with normal SCHED_OTHER priority:
>
>         int main(int argc, char **argv)
>         {
>                 int sk =3D socket(AF_INET, SOCK_DGRAM, 0);
>                 char buf[32];
>                 struct ifreq ifr =3D {.ifr_name =3D "eth0"};
>
>                 for (;;)
>                         ioctl(sk, SIOCGMIIPHY, &ifr);
>
>                 exit(0);
>         }
>
> And the following one is started with chrt -f 80 so it runs with
> SCHED_FIFO policy:
>
>         int main(int argc, char **argv)
>         {
>                 int fd =3D open("/sys/class/net/eth0/carrier", O_RDONLY);
>                 char buf[32];
>
>                 for (;;) {
>                         read(fd, buf, sizeof(buf));
>                         lseek(fd, 0, SEEK_SET);
>                         usleep(5000);
>                 }
>
>                 exit(0);
>         }
>
> When running alone, that high priority task takes approx 6% CPU time.
>
> When running together with the first one above, the high priority task
> reaches almost 100% of CPU time.
>
> With this fix applied, the high priority task remains at 6% CPU time
> while the other one takes the remaining CPU time available.
>
> Fixes: 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in sysfs methods.")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---

At a first glance, this might resurface the deadlock issue Eric W. Biederma=
n
was trying to fix in 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in
sysfs methods.")

I was hoping that at some point, some sysfs write methods could be
marked as : "We do not need to hold the sysfs lock"

