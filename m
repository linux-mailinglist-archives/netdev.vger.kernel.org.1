Return-Path: <netdev+bounces-243860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C2CA8A98
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E72E310E9C5
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F40350D5E;
	Fri,  5 Dec 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngrO7crZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980D26B2DA
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955910; cv=none; b=Ij3tJnzqE+5MZhZvKO1MGp5slP9MbGW1W9ewX2+a38uZHo1vIjnBWKKYnxLsfToVgdtqygqoBHJSJPpvTL1iKYgqulRyvG6It4UeaeGXl0VGWCLL3VmvJHqZ78QRfOVpVrVEQrpESCSd5CN6MWzhF+hFxJgpXsDHF9emRB0HciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955910; c=relaxed/simple;
	bh=e9CoZSp8ppByynofzj4R8fDqOU91q19IDQEVdfN/Rho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgMFXAT98f5TwTz+njnDg2eiA2wYVX3TPDCwoVKA2eTmwn4ulLlBrpHfM/sHGUw9wcOvUlkNvsDaSDMq7qieKSzhonc56VK7pU4QfDj5A/F2LonH6B4TNDyxePRs0eHMKh2fL2KWDIRgSkVmBqFSMyd3Yfk1s+w0G8HXULsQbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngrO7crZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b713c7096f9so362053666b.3
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764955906; x=1765560706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JRTQ5qP3nDJv7XXYMbTJlNjt9BNu8NHYBKExw2nneY=;
        b=ngrO7crZoD//Q5eTsIcdJCLVOLciaLwGj+bzv5klL4CI8XH0sej9ITJuvPcZUZhv+j
         NBIy8dvcqR2prZPLFc8PJcijbHRf0bfxf8h0KWA8t1H54X7GaS6nmQ7QV8u5WhR2hEJD
         2hhRNd9MhO3VzqdQ45FSr3WzQUytEkpyd4KkjtCrykl3p6j9v43xxxv8Mq3m85ACadwM
         v9+xBkOeAPF/6rANBJuhlh3NeyxBO+bmXytpvSoJ7xeqCx5vTU6lKjTu5mHrxqKjOwXz
         3sjAdZ2AvPwam/Lqu01cMsMQsXe3C8rDOKShN0mnbbeUqd7BJRlwXEtSmw/+HirAApVx
         wDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955906; x=1765560706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JRTQ5qP3nDJv7XXYMbTJlNjt9BNu8NHYBKExw2nneY=;
        b=Qs2u6yRJSv9sPGeU+sDj21YVZTbCbOOCb6eV0TxTAmNLnZOJJId2xfIOnc+y+DBeKS
         waAmLh4ZmKQnYWp9u50Eh4Tcrvi211qPSeNaZR0PjVO5sNs1E80NtSYEpNUhYDwVK5AM
         1C8kBWcUkCgSQzpUwEWLSYDKSsuD3qLGgVSkmUtqiwMATo7XvgHk61ekVg1noJd4wE27
         7AfvsmE+fBNHjI7aYof6j7+RFPSavjNzUE67h5YxC3xnU2SLqThtseeJ7HrzWrAsP8Re
         LmX5wL8LgCNAoZIl3OUntuy4+/82bCm6ZGim1vTq5BVbwSsJxrXI9oWAanhDEzMtTz8g
         7AOw==
X-Forwarded-Encrypted: i=1; AJvYcCWh8svVK0PzLhxHcwUWAt3lGf4IQ+Hrax5g4WJqHaOpxSeOX5LHlKOLCJ9E6EG+iYzmBDQUc8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKc0RivqcNTwT0HMojHyWKwXZ8m1IF2kWBWRs66vOEx1ZQ/rT
	buONaXxtJJieVNb8VNB9KbXgCDgg8Vfzb+7as3fRg7IlesfYY7ffGaUu/p6F4+pmE/TMb2pvKbV
	P7nMWkOpjzxy1QIgRTq+IkTmKj+TYucY=
X-Gm-Gg: ASbGncv9TUrAoFCbHbHHMYbIOix83+eyMwGM1DdkLcDHd2UTYs98P4ucdzNg0fnEZ4o
	FITtr6+DcvolUU/I2m5PIurt0YQqEwxQTh5cu4/tctihw9pqXpUn5j4b50dymh8/JBQ3FosLbW/
	yLLh/kq3UYmtGsY660HlfUpe9K8B2D9/QXbJnsCt7iN6VIYtOZeIoLd63cY24aoX/NOw3nkERuA
	zTuIfoe9llH1j3S5bqe78fI0Ubci+lYHxSdAPbLxIdi5T0UOfkJMeuzR+0E5UFOJARs83sM63X4
	Q35q5ETsVImwK/7uRgoCiPef5D6IHA==
X-Google-Smtp-Source: AGHT+IFRCgHfKGsAkZVPOlUmrl9vw+MR8hBEZgtV7PRhOjUmwdoMWwyUcdUQ+ugYeG8JzPcdndAeoqqxibr+uphApf4=
X-Received: by 2002:a17:906:dc95:b0:b6d:73f8:3168 with SMTP id
 a640c23a62f3a-b79dbe71c0amr1072539666b.3.1764955905366; Fri, 05 Dec 2025
 09:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205171010.515236-1-linux@roeck-us.net> <20251205171010.515236-13-linux@roeck-us.net>
In-Reply-To: <20251205171010.515236-13-linux@roeck-us.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Dec 2025 18:31:33 +0100
X-Gm-Features: AWmQ_blDI-utBDx2W6qm1w5i1hudk3paNzpT1OYcZ7gDhfKrn0IT4xpTqmkqetY
Message-ID: <CAOQ4uxiqK6Hj2ggtcD-c7BAtuBcm+LrKVkQOxi93OXhwSE98Dw@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] selftests/fs/mount-notify-ns: Fix build warning
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, wine-devel@winehq.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 6:12=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> Fix
>
> mount-notify_test_ns.c: In function =E2=80=98fanotify_rmdir=E2=80=99:
> mount-notify_test_ns.c:494:17: warning:
>         ignoring return value of =E2=80=98chdir=E2=80=99 declared with at=
tribute =E2=80=98warn_unused_result=E2=80=99
>
> by checking the return value of chdir() and displaying an error message
> if it returns an error.
>
> Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant runn=
ing inside userns")
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Update subject and description to reflect that the patch fixes a buil=
d
>     warning.
>     Use perror() to display an error message if chdir() returns an error.
>
>  .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notif=
y_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify=
_test_ns.c
> index 9f57ca46e3af..90bec6faf64e 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> @@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
>         ASSERT_GE(ret, 0);
>
>         if (ret =3D=3D 0) {
> -               chdir("/");
> +               if (chdir("/"))
> +                       perror("chdir()");

ASSERT_EQ(0, chdir("/"));

and there is another one like this in mount-notify_test.c

Thanks,
Amir.

