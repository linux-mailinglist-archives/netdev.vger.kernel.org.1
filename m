Return-Path: <netdev+bounces-158475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B107EA11F56
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFE6188504D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EFF231A49;
	Wed, 15 Jan 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNKFrfTw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F11E7C16
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936822; cv=none; b=mJUxDonPG9JN2XVX2eyCb4na6R4vfLBCjj5fIQHdwgLrPcX0WgvmXE6/OAjemdmgtarVmbwuzrzZrpBWqE3XH5Iv7FCfxA07guv+BZXcbc1j3K89LY17hO/Wu/kCaF3ybbngU9De4FMDvT2kFVuTiZy6eR1sb0mFx1hW24P1va8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936822; c=relaxed/simple;
	bh=odACzEB28j0z1iVmC2Ess7euhmNb1eOHPvCKxgTK3xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjKCwAGWQu8l4Wps5Vt9cSAV4Pi1EDUsXdNsoLQQ2evuuIFeS+k/unxrfBk69L0IOupH76o8bbU8MDzPYHx4bdlR8Y5bzpdFW5djLACsb20z7GKKGLfeRKf3xAktYijuZgaNQ0Kxu4KHvPo6NZx2XaovDr9b5CiCqyuOYA3vU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNKFrfTw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d9f0a6ad83so4736712a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736936819; x=1737541619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odACzEB28j0z1iVmC2Ess7euhmNb1eOHPvCKxgTK3xg=;
        b=VNKFrfTwGTM2inP18D5zoI+yBTLEl2H1lQCVk88tKqN4dIXBPO2EyyqQpSzXGxgGAE
         I1LY8rOov4BQIPuym26U0jb6Sqg2pR/V3H7NAvmPOL6cVgmrSyYZYTOWaMZmflrqucQR
         CiC1QEYDFGK9LkucxgPp/tgi9Wrnf0OBhA+EKVfAP35xnNRGtwNyZPJMw5YyckZ5hIhd
         klcrUWeKt2taaxXyZJPJMl7U7qMhECgFsspmyOsiYuwOgkZK6hiB5hk7M4TDa35W/dLB
         adQBnZum6Y8t+dQ9o7UAZFMr+aM4O/yNYP8zZVL/4E1ty54hJKHAxsRjtRy32CUff39K
         ZA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736936819; x=1737541619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odACzEB28j0z1iVmC2Ess7euhmNb1eOHPvCKxgTK3xg=;
        b=OuO6LIQ5kICIzuxQULW9i8anE6Mh4R2d0fg8DQ/jc1x2rWSKebma/q+cVleHp37vKp
         F/3B3zdS1ZE6Nf7PdPk+vXPVg80h3RNahVn0kA3VuvuuyF5cdVvjowxXaEsivEKfnh9a
         OMKVBh7925ilJIoC/RdIlq68BCwSBUE24iMdkaGaiPCLVAVKLfXMX4qUAjEWvUUFFiPA
         ac+Z+7QgIl9gy7wZqkNbPSNxc/2M2GqRY1TsFqwX1/iGBR4Fqp1ZkR/CdRuI/vty16gI
         RsDLuf3C5SdFg5iVNHZoi5diRdgaJTW7G0cJa1H7G3bUXWq2g5Fnjmaq8NsnzKyY5wgp
         Kfyw==
X-Forwarded-Encrypted: i=1; AJvYcCW3c5JCo7aUr2hIyp1KXQz6zMnXXoiWYj5fGyjGlRrXp73vti3aWydNBjiin5iQn6gr5NWBsBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1eclWaYwSw8ofs69HHiJckaY/K79Jwl+HjbXYvcP8NDoHqyST
	8WpqpFFEIcjOymZKJvVtX0YeXxEcD/jN1sWgtvmraQ1AZLL/Xl3W1OdPnjBAZQMeyfhiUJ/KgLg
	QM5K3ITjEoKCbOZHy2zySc2NLZmP2lI9dt/oT
X-Gm-Gg: ASbGnctKuirYYjSwwy1PmWsVPfT70axn3xpo09pPM0LdKToSJamKd9egBxkTpHFFw4r
	4wQyGWdwwxHZOkVoIOa1OaKVPkxT1+xLlBx62ag==
X-Google-Smtp-Source: AGHT+IG93d6Wv7ftiB5aagQVfE0aOqwIf2uwhM0//NXQRNdA7eRkf885IT9EvTYw1q1Efq3wVyC5QyePW0bFP2IUL7U=
X-Received: by 2002:a05:6402:5246:b0:5d0:ceec:dee1 with SMTP id
 4fb4d7f45d1cf-5d972e0af6bmr28173791a12.13.1736936819130; Wed, 15 Jan 2025
 02:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115095545.52709-1-kuniyu@amazon.com> <20250115095545.52709-3-kuniyu@amazon.com>
In-Reply-To: <20250115095545.52709-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Jan 2025 11:26:48 +0100
X-Gm-Features: AbW1kvYnNNfm3751qFW3JheUzqMU_mdn1RKkbtfr2jcxx3onzIC29gV-35kf6wQ
Message-ID: <CANn89iLBY6JQo5cEGVdU=+Z66aG-5rxOJtFS4wBAT=MxazjK_g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/3] dev: Remove devnet_rename_sem.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:57=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> devnet_rename_sem is no longer used since commit
> 0840556e5a3a ("net: Protect dev->name by seqlock.").
>
> Also, RTNL serialises dev_change_name().
>
> Let's remove devnet_rename_sem.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

