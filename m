Return-Path: <netdev+bounces-223334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDA7B58C15
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 04:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A61C3B0615
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B776D23ABA1;
	Tue, 16 Sep 2025 02:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M145WT4S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9922128B
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991512; cv=none; b=nKYILze0bJZMp+S/+YBl5k/7huz5EtxeSULrB2HXFDhJ4INKMQHJRyo6KgdHA0zfh/IToBRnwTb3ELJnu028ZaBHt4qo/Wj5QXIv3+pVMw88uGQT9qihQlAB4oBefJ8yttan73W4f8RNikKYPsKPiifiV/AsBeYyCzeXmWp5/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991512; c=relaxed/simple;
	bh=0WNzQt6DCc1oCSopHUcGNsX0og3Qo+mNU8x/1pWS9J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbmqCs5slVL5XuYJag3qBW9rOsbhzJCjaJN4Lf9ac8wdeRRINIZA2uS23JskUpvFbeSXRWIGYhT2iUuE4fRvw0JaRfYRvvUtZ42gB7GhW+Z0aWGFm/+1yHBXQ7HepO8VLwpbeo9h0om1uJt82uSdR+YKL0wJCW5wDH58Vi3kDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M145WT4S; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-73400edf776so15004027b3.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 19:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757991510; x=1758596310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WNzQt6DCc1oCSopHUcGNsX0og3Qo+mNU8x/1pWS9J8=;
        b=M145WT4Ss1/MVQpODuXyGL91Z4sDRfDXG2y17ZS4Nbp3xb3TfZlQZ7rDnUykYpKF5L
         iaSeF3CaoRjRbg+eHPDEB0W2sFRW4oifb1ZfQ6zlnndwhd4Q6Khnfw99SIGMGX2ReYNu
         okUOHiG/f474zdp6NgauRr56mY5PQXzmRGIsJtYNKPUJibH+uSIFNxLGgna08wx6Sp10
         gvG4q+NLtj2jligTfx1KxGLIZDoCPZS7lKiDdXB4S9U5Qi9Tj5KljnEf2h3Rx128tgHD
         222jY22ZpIUovH4MLFp3j48HB0laWzhs57bPzVtrQXaNMYY2E0/FgLtDKoxsP+RpIssD
         ibKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757991510; x=1758596310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WNzQt6DCc1oCSopHUcGNsX0og3Qo+mNU8x/1pWS9J8=;
        b=XYLVfRqUqBeIGeKL0CdVP2IBtunSFCG36uOzDYKZDUDjWJPieZTNgTWy7CWEtl6tQS
         hhQTdjd5a+6qlJMCIbEmI7fiZdvQfRmaJ015XxvDfeIIxFXJQwPkxkhv1FaIA73lX8s8
         AwTCHo0/vO8CKsmYGlMdU1p+FUBzcEJqgmfRgnS/+Nz/vuEReO+cx/bnO0Jdwh3F2h59
         Ms7iQZK4b6kNoF13QIWuMYbJmA3LQC2cth/oGqTxEKjQXC259P0udrqtzh+19IfL6vQh
         vxG46uYe8IiNu2ep9IHU0ZDMmaIntAhOIWXabN5TFNjX1l60IlFaXOS8i3Jld1PjFLxi
         VDww==
X-Forwarded-Encrypted: i=1; AJvYcCXhI2OfuTnTEQlkb52U8z32rPRi6QgFdWLVDWmu7rPlSaTWIu3MxsbOYYkxdBzHay1aY+5Y9Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybcRGgSh4SfMsElkWrQKZptNyVYRlIV0Dvys6eV0B6udB579fT
	5gRVV1xqOIOwHF5fu3Y5HXiYlPUaiK2cL0y+uR8Mz3J3oN8ENwxVWmbpFP6Iu7rSElBNpcCbQYJ
	i6nfzwQQi1lsM6fNtz2pQV7PCYe0y0SI=
X-Gm-Gg: ASbGncua9G9RxiTmxOhij1OtuQ7g98cNTRPvj3uotMLf5FAauxuP9Vjwm3hGFlYe7y3
	VBv5GCHHY0vYy9vwjc4I4eFRVGK7+L7tVJU+EEWFoe1SXyCt5aCeafoBpzze1n2vu6+M7Z+9mSr
	JX+UJskUxDa+HibEJmafBOjmoIyexwroPm/7GRcuRLA3I3WT59rLagSInQG6w4mLoUnSzcLdg84
	VOpHBCiC2BCG3k6ehr1exFbrQroc9OIx6s=
X-Google-Smtp-Source: AGHT+IFoV8QGVxMrnTri70cXeQyLaQNEjmdLeZFLqkE+amnPx3JsydwAPu1HRgnuRf2sZ6BK97hxGf+G6+9fDlrhK/A=
X-Received: by 2002:a05:690c:6488:b0:735:4c38:34 with SMTP id
 00721157ae682-7354c380739mr40186397b3.27.1757991510063; Mon, 15 Sep 2025
 19:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912095928.1532113-1-dqfext@gmail.com> <20250915181015.67588ec2@kernel.org>
In-Reply-To: <20250915181015.67588ec2@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 16 Sep 2025 10:57:49 +0800
X-Gm-Features: Ac12FXx5b4SkRyivmeumpyy1hPkwx_2MizrBQEAH_5KP5izuBh4_VosS6gNuxWw
Message-ID: <CALW65jYgDYxXfWFmwYBjXfNtqWqZ7VDWPYsbzAH_EzcRtyn0DQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ppp: enable TX scatter-gather
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Tue, Sep 16, 2025 at 9:10=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Seems a bit racy. We can't netdev_update_features() under the spin lock
> so there's going to be a window of time where datapath will see new
> state but netdev flags won't be cleared, yet?
>
> We either need to add a explicit linearization check in the xmit path,
> or always reset the flags to disabled before we start tweaking the
> config and re-enable after config (tho the latter feels like a bit of
> a hack).

Can I modify dev->features directly under the spin lock (without
.ndo_fix_features) ?

> --
> pw-bot: cr

