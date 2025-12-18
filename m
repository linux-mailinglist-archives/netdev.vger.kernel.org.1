Return-Path: <netdev+bounces-245330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E97FCCB8E0
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A003A30E64F2
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09640319850;
	Thu, 18 Dec 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1rStvbO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C44318143
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055992; cv=none; b=ASqIF9hdpdjFV0pPCF0KHl9F03JQ4LurU/2ud2NhEmrc/RzbKNlgqcmEqYlKqayltn7xH/Df+PTT/dI6P+vUNiIIbu8UXvyK2+OCb6CU9cHlwRKcSBIfG1MPEEEJfXg6w3PlaIsECY0DyirTSyK7nlC0sib+lEXCXKH5S34+9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055992; c=relaxed/simple;
	bh=YdmSp98VOpb4w/1T9TrcnGT6vsEQNrGtK2z/qAxMy0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRrCdVlTaFIfCKNNV9ZCggnJhLgptry5jpRmglh1+5CvSGxIWlcLToCZIq8s6tvAXRLt374pCBSQORHusF5+xszqCBO3kAXVREKLm9l5Io78ivoqnQrjgfPSISBBwfuKR6TcvgCTgbRjT0o+6AawJM07DKwyDJ3EWrBexVCOUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1rStvbO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47a8195e515so4342995e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766055989; x=1766660789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdmSp98VOpb4w/1T9TrcnGT6vsEQNrGtK2z/qAxMy0I=;
        b=R1rStvbOQr7NSeZh4jY52XZ9TB7IioGPAQfJaZpIwuJOFmpU/F/IZ95KQ76/zXVMk9
         7Yxdn2c18SGxPHCmJ3qAOWBmBZdrvEtaFg72nchPjiKuUMs5eK2cMBdNq4w/IOPXCB4v
         mzVzrkQunocXzAAxtQUu7sH4LwetduVJXUONeSpvVfPRW9lvWUxGfE6FVrFtF3OER0h+
         Ac0JRvJ5k7blRXFgtXiX7qo9MTGSspytwDOqkc7LV9T2IyXJPbl1wyhAIa31NhUyg5pX
         yFibzmySo7nPrycOgG1M8g2cyVgNY+ECaSF424ueFbOktrFEabSaExPdH5mBH3yF4XX6
         UeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766055989; x=1766660789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdmSp98VOpb4w/1T9TrcnGT6vsEQNrGtK2z/qAxMy0I=;
        b=bQWm015cyKAouFh++3B8Tli9Z5XlZGDj4dd2WDA22aZK7jj+oNFc+9XR9tcLcawm16
         SVDx0DvGGvVzBOme2UJWX5M7Dh4seCFCcqx4gMbJaes4NmQEWC+0yo2E8gHxlvbpC5/P
         nUQs8UwPZOpqUybZhKg0NK1ARSdoL4mV7KVN88WNB9Kh09iMrXfkDPPPsPH4waiX4Gpd
         Mo4zXD3rN6K1UN+Keh/gmChioT5ouFwExSiU0o8K15Rn/AXgf+GraYiy7XG7SNtNLw7y
         4A7e+emwlpArc0htL6Weq3+wCMuLA9KJeWwfECjFH0OUVhnN85O6/zXKpFUL7W9JWoKG
         4KAw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ONWTwszgDnkuTfvghFbmTcTlF1C5Pr7GC11eGpTC3PIG1BruYoYxmoVlS0HRheP4B6bp82g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+VTNe2f7IS+VNC/OKKYxatcFsCCu3h68uTpT5SqbDv7TH+q5
	rYs0wlz0LnYr7Pu+DGKoWKCnFkiWQ3R9G/n/w8xJ/1Hak/0WNEdsoY76yMYROuaTFBKkoFVSMnl
	Az/nc1uSeI46mKL3LanB09UXcU/nU/9cAJa6hCb2W
X-Gm-Gg: AY/fxX5Y6X1mTXmfX+Ra9kL3BcTjavnDwTr2mAeEiE5UEjZm8LDayZlhANKJUGDb7wH
	YG8DDx56q/KsZIu1PS+fiqu7xideQo0n62GeWk3/kmGq3DJV5AJd/PdPd3H/KgQSGwcw+plGOGI
	tiwsIOxFvupei7r5HRFvGCRYTPa1tPQtCZ0aN+c0JleFtGEdmaQ+lz9ZfqvnRTlSqLFuuP4ly66
	6rVjh7P/01e0Bx3C03d2AX3/plssZrjQfkWbBuwqrCbmX5HDX6nMmJZsL6IETX3wkvDXg7I/4QB
	LvvF0pnARLsdo8Aetj7ayrN/3A==
X-Google-Smtp-Source: AGHT+IHUVbI/1P7zakDM7Wi5UCm2XC9PsUzzgUmoBdz1wcDrZw0JyEjKaERyGFb8Dk6P9ewUvmrPIJy5bf6RJ2inAko=
X-Received: by 2002:a05:6000:2311:b0:431:266:d150 with SMTP id
 ffacd0b85a97d-4310266d59dmr10262959f8f.44.1766055988640; Thu, 18 Dec 2025
 03:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aTV1KYdcDGvjXHos@redhat.com> <aTV1aJVZ8B8_n2LE@redhat.com>
In-Reply-To: <aTV1aJVZ8B8_n2LE@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Dec 2025 12:06:16 +0100
X-Gm-Features: AQt7F2oOZgjISObSjjmOs0kcLH0arkernyhqWoUniY0Q3NRwv2tC-Isq-vwEzQQ
Message-ID: <CAH5fLgiYyfrwvmPyVGYD=sbsyY_2G5Z3mbfNRDa4uC2PS6iQTQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] android/binder: don't abuse current->group_leader
To: Oleg Nesterov <oleg@redhat.com>
Cc: Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>, 
	Steven Price <steven.price@arm.com>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Liviu Dudau <liviu.dudau@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 1:39=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Cleanup and preparation to simplify the next changes.
>
> - Use current->tgid instead of current->group_leader->pid
>
> - Use the value returned by get_task_struct() to initialize proc->tsk
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

