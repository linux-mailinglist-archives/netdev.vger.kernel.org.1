Return-Path: <netdev+bounces-173417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B388A58BB1
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB24188CFC6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 05:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D055F1A9B5D;
	Mon, 10 Mar 2025 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYEMCrO2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4605F18FDAB;
	Mon, 10 Mar 2025 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741584798; cv=none; b=nCTkzppcoyqd6B6skRgv5FZi8FvNvVKwpjhKiQPOo65KWEzSXAesmhZgUiuul8gyp0LFrOGoCqBNoRskbZRw+ASl1tchLqiuU9v32QgQ7NsSucnjv2296YI27TyhVXKgus0XtSx5gPgKbA6mMK4pwUgFNHrdwjS9u3TavZaXKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741584798; c=relaxed/simple;
	bh=5EKnPa+Gv0TJNMpmdI3U2XN1GU78PygLTBll5PGGiwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqVVRllt+x6EAX8gwSEz69gAgBhF+HknLZFshg7X6ic3JGylZQWEe1rolCcY4XXKrtHLXUNLgqASEIxfaQQdaRJ66MNhgeZv1pohe3ob0bKWuXnEbSUuQ7ugBQARVzbmycTD+7KtDwylsWOclxi2lEI+RDypLDn7ZYkMZ/i0rHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYEMCrO2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso13195575ab.1;
        Sun, 09 Mar 2025 22:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741584796; x=1742189596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsZKVlTDMWzNmkdJJwpbPAsZ+Q8KwbX4bNw/XQxeEfI=;
        b=eYEMCrO2X9Xpdcd2K/sxz172C6dAGzVhAARpI98bXAFRY5bQLpBDTobt1kT2vIPXVy
         2RJl57i5D/WQbPevyZ5gH1DVnrQZxPm9MqG+b2tjgnBoI2tUYpwmPQugTdeprAcLvtm7
         SawbO8mpkyyLe41/QTZX6koRuN/cZ5b2i7h4vjuI9jX3zMLTPWzM7f68UHVW3qeqdwx4
         jqHQ9C0YA9nR5DCsDq56qAais+bUNbgq76X15fIMERA3HH4zG7btfaDcKOn4z6WtZ1ed
         cV8RRJxAuBRvYcFBluoLjWMozNvJnLXbx44MmUFhzAJkltY/0vbQqE59o7EBzNlw6LXt
         x5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741584796; x=1742189596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsZKVlTDMWzNmkdJJwpbPAsZ+Q8KwbX4bNw/XQxeEfI=;
        b=qrNfFrftHwKw0RR9yFJKP828O4KRilwj+/UQsscv9SNHH9m0vCCuK2nagDxKUjHKEf
         0hoy/I+/PrrPBmu99NPqenfwYGrL2ZUMpAxsuMXYAFP10ZrEeMGQBja8nLRtJLREqyS2
         N5OxYw03alAqfiBEwurcz7OmxnU2BBybKiVrRFWXD5Uch0fE/mqqcqGMzA1RQgeWVS58
         w+F/HmCA8lGCXav2C/NMNZQdFPp/KlS2Ypo2mVNgSapsRdp0lfn2JNzgHO68yXnP2v6h
         VahQEjj8nVz4vzVxqxjYTeedYpkGMSWgLJ/bNBR8mtTdk13FiwVQIvo4KsyuDS5Lngh3
         CEkw==
X-Forwarded-Encrypted: i=1; AJvYcCWt4HrvWJkCYNy4CB4YhEjJmL7XtiCAaywRET02a7PCphg9EzGd7GBDM65gm/bN7CZnjfpwmCDF@vger.kernel.org, AJvYcCXSi33HbXVZSjyokI+0/ePS8qXvBAXqR/han/ump4g37AO7ey9qqmg2GgCeHp/XCHlX9q6CGIPBOdC12Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXuouNYy3qco9De+g/Y/EXDeSefFXKmW/cOyw5b+8CIbp+VkXm
	mfhe8jGk27YSxU22GUqrTBAlqwgvloGd96wMYZOF5QbRrxmirA7NlJ3WfsPrKQBcbt/fPrygbuM
	mS87v2fCPfPgRbfzNP8IUpckLoQU=
X-Gm-Gg: ASbGncscWYQKzPC+aMO6hTUxYKjibbzN10jlzKHrdsBMONo6Uc1ZsIYgy8wfuSzsnto
	sEVAN3kCIGclpjZUfemI8zBtJ2Xz80QJGHFd0f6YodkSOHPqszq73fj0pZWCikB/EjjQvjK52j1
	/wGY1eW4gD2nWc7TwnnLx/AJYE
X-Google-Smtp-Source: AGHT+IGBGSMPs2GTHwSND0prawtDiEkRhRYzDk1J9LiPH4k9q5iJ7z5+KR4h5r3PptDgdAb4dqjmg3WjD8T17POF/pU=
X-Received: by 2002:a05:6e02:3a06:b0:3d3:ff09:432c with SMTP id
 e9e14a558f8ab-3d441947300mr137825135ab.4.1741584796241; Sun, 09 Mar 2025
 22:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 10 Mar 2025 06:32:39 +0100
X-Gm-Features: AQ5f1Jpx0SVCDs32H-oMiMAiaBWqfvJfV_H7pcz2o0HavBzGZk4aBE4z9L8bg2w
Message-ID: <CAL+tcoDhPe3G_iheA0M_9dO-Tij-dYROfneiGS3SUr8w7bhH8A@mail.gmail.com>
Subject: Re: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h
 with the kernel sources
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: edumazet@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 1:15=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
>
> Accidentally found while working on another patchset.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>

I'm not sure if it's a bug. As you may notice, in
arch/parisc/include/uapi/asm/socket.h, it has its own management of
definitions.

I'm worried that since this file is uapi, is it allowed to adjust the
number like this patch does if it's not a bug.

Otherwise, the change looks good to me.

Thanks,
Jason

> ---
>  tools/include/uapi/asm-generic/socket.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi=
/asm-generic/socket.h
> index ffff554a5230..aa5016ff3d91 100644
> --- a/tools/include/uapi/asm-generic/socket.h
> +++ b/tools/include/uapi/asm-generic/socket.h
> @@ -119,14 +119,31 @@
>
>  #define SO_DETACH_REUSEPORT_BPF 68
>
> +#define SO_PREFER_BUSY_POLL    69
> +#define SO_BUSY_POLL_BUDGET    70
> +
> +#define SO_NETNS_COOKIE                71
> +
> +#define SO_BUF_LOCK            72
> +
> +#define SO_RESERVE_MEM         73
> +
> +#define SO_TXREHASH            74
> +
>  #define SO_RCVMARK             75
>
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> -#define SCM_TS_OPT_ID          78
> +#define SO_DEVMEM_LINEAR       78
> +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF       79
> +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> +#define SO_DEVMEM_DONTNEED     80
> +
> +#define SCM_TS_OPT_ID          81
>
> -#define SO_RCVPRIORITY         79
> +#define SO_RCVPRIORITY         82
>
>  #if !defined(__KERNEL__)
>
> --
> 2.43.0
>

