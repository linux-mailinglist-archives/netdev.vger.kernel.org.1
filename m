Return-Path: <netdev+bounces-204036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE85AF8850
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5702A542AE6
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2F3263F59;
	Fri,  4 Jul 2025 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZMDT0Lsq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68A262FE5
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751611964; cv=none; b=IW4+8nxjVvYx/Mc0xIJo1peYcpGqYj5tqM0v6T242C2H27XOAw8hDLOuPAssRzQvIY7Dr7NsXAv1ym4+lloGI22nAy2ApaGOLVohzkXKijya6UtUNw0/yTAyGKDaKiRRhfbi+JVtqmOwPWvqXcJmlpYpal7ATJVRUnY2g95KA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751611964; c=relaxed/simple;
	bh=Tv4gB4IzmA09TgqZAyPP+TGiF9YCCa1B+JrlwcTCnmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7AWegHuBDrZv9YUpDT9sBWZo+2bAaQOy/W22T7Jd3z2vLaTKUwPNRP1rZoevVh2bIAryxr2M1ezEbvAtEssjW9sVdatW213mXZ4fHZcFF650Ioqt6jjGuXkYGn0U1a4f5ePgobpGTfS7L0icGyzq/9JX/zhX36gq6MF1OwEsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZMDT0Lsq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 106193F91D
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751611960;
	bh=Tv4gB4IzmA09TgqZAyPP+TGiF9YCCa1B+JrlwcTCnmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ZMDT0LsqzJYbpqAg0pgTwx0phG0NcgEfh0IwT3/xlrqszixi5CYBcjNcI1hRjNOcz
	 YZ+47/H455eTGRIdhkWdjc6uH0A06FwF1a/ZIIwKW3bM4n2wwGyErk4z4XjrBnaxii
	 eJnNrIgqMZ+MdFlICAn1A3rDCBEtrR9P+fiJDvZkbytuprZ1ERYl4u/Z0PUnyY7xY2
	 hq/ut8pSQ9sXbHIShAIlwrzhQH7nCzZF668bCAxPvEAcRmtRK4EtZX+es48NZKTRbq
	 DisLGQNiCPZYLGZgI25uPa7LKZdAhrljj4++2LWqKgoSAcvEqIQB8rzR8FZYN+K3sd
	 2TaKlZrkPR4/w==
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4e9ba1b473dso492929137.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751611956; x=1752216756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv4gB4IzmA09TgqZAyPP+TGiF9YCCa1B+JrlwcTCnmU=;
        b=lpiIlEZSdY0m5ymr8RVG2xKpC3bW1oxfUkxkYekuC1c1wECKWoV65lM8Ztp1NoqBEm
         r2VasyDH8unPZrAra8W/AMqit14o+mw9l/941rci5qLveb3ETRZDGJVPI3enAElW06XZ
         nFMvpBRGuLw2jKhfg1Uaqi/sm4xO8MYkwknNGy45JOY+2wfJVLuB25F2n/YQa2jWIKE9
         qw8YRbqHXNo1atEjlZ+GRsmzCSPDrpFtIbizorXQafZnHJuknfMVT9wAZggTnSaKUDxz
         PHlzyGI14iGAOS4hVSkt42HGAByOhQntrG1O/cz0AFIf3dkYmOGzEZrmXD/5flh73Mz6
         kYjA==
X-Forwarded-Encrypted: i=1; AJvYcCWr8CMgpXcLlhQzUH2MmhNxmr95NmnVPlv25cT1qnK8R1S561XWmio/xkUq4X5eoU5ZKQnMJw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycFwRO9p33590aEte2swlhkqpgCiDaypbjX30x4J+8vWtnDwin
	WX1htUnyDy1yHdYmSJ8WDYyzlOdCoPfs2ACIGeVBbSLhyzWqEEQog5PBTJZ2ocv27XJk9hT5fIO
	kaN60tq5Kixd0ubF7E7LD5ID0GxUbm8z5SSv4n9f5zD7xKCuBx7oZmJWlIBd/Ow3bSsPkNymxq7
	iWRYA3FLQLPy51noLKYvSeQAoEvsbtSpP000Sz1XFzf6tb29nZ
X-Gm-Gg: ASbGncv/2g3wO05rrQ/1H0ax8gWAaK4dJ8ExABuQrWNfrTXdsYGxe1LxavsRX5C+2YJ
	GtH24nDXynNutS4+RZgXvmSVm6fGluW5TJlvvUtV2pTg2c2QoX6KcDN273G0cW4ajI9J4eddR07
	H/TwYt
X-Received: by 2002:a05:6102:50ab:b0:4e5:9138:29ab with SMTP id ada2fe7eead31-4f2f18cfc95mr441090137.15.1751611956017;
        Thu, 03 Jul 2025 23:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB7HfZmQOhR9Isg874gqYf7ux5G+ZxtwZDg/dj07LCt1Yk4BMJUJdZLZ+cFBmHmnW+F1WX3cb4/8peLVtympU=
X-Received: by 2002:a05:6102:50ab:b0:4e5:9138:29ab with SMTP id
 ada2fe7eead31-4f2f18cfc95mr441078137.15.1751611955653; Thu, 03 Jul 2025
 23:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
 <20250703222314.309967-7-aleksandr.mikhalitsyn@canonical.com> <CAAVpQUDn6vjd2SpwZj8v9KM=yzmC6ZjB1sf3xO4fc=sr4s367g@mail.gmail.com>
In-Reply-To: <CAAVpQUDn6vjd2SpwZj8v9KM=yzmC6ZjB1sf3xO4fc=sr4s367g@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 4 Jul 2025 08:52:24 +0200
X-Gm-Features: Ac12FXxtIsZihNOxSNCXS3Jjflo4OPvAJ9izvZuFGthK8qAmPo3MPUpvzqlW5DM
Message-ID: <CAEivzxeM3+TwwU7jR0i-=GrhZEyd+uffAQeODvyb6ZRRd7gsDg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] af_unix: enable handing out pidfds for
 reaped tasks in SCM_PIDFD
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, David Rheinsberg <david@readahead.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 8:38=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Thu, Jul 3, 2025 at 3:24=E2=80=AFPM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > Now everything is ready to pass PIDFD_STALE to pidfd_prepare().
> > This will allow opening pidfd for reaped tasks.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > Cc: Luca Boccassi <bluca@debian.org>
> > Cc: David Rheinsberg <david@readahead.eu>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Overall looks good, thanks!

Thanks, Kuniyuki for your help and reviews ;-)

Kind regards,
Alex

