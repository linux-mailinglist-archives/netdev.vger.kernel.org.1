Return-Path: <netdev+bounces-123485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF29650AF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7931C21F72
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D11B9B51;
	Thu, 29 Aug 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz1JNluW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D3015AAB6;
	Thu, 29 Aug 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962876; cv=none; b=BaZUxsqTcZCUiJQuGe7BRgA9BQLZ7yose9kbyYPxOPiokCTJtPZfEMVn/cFm/lxtThSDK4I+9mZ85IYXR86ENhKsWvn7vYZKvNtWK3d4MTg+FVE+pNsHPELMcH5Sl0HDVEubfbIaWKiylZF3dFvpkrnzpowQ3fyang52drVvLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962876; c=relaxed/simple;
	bh=wQY+2Uzxn46aPZCkb6ELEWKIY4fIyb07Bp7GBWFMe6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naDdtcwSCq1J6aE+gdAfESLeJtTZX7sNZZOEChiOPYZbhPrP2l/3gg8BiQuqEcNGphdgZoiH3ICVzkNA0WIsHn0FEYyFLaWHf1l3Pucm3Y+5GER9BpnQ189XUlL58SfQwZ0x5kyih90gOm6wbV7naZ5mX4ep8sbjMaDGQKV30DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz1JNluW; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-68518bc1407so13371417b3.2;
        Thu, 29 Aug 2024 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724962874; x=1725567674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQY+2Uzxn46aPZCkb6ELEWKIY4fIyb07Bp7GBWFMe6o=;
        b=Fz1JNluW+RpP4Ug0Cs+wRHmBZRfuY9hOa4DpopFyUuCFeXXFk8HlYzM9qQyVto22ag
         lkTQxAPMIe3S2RYXaS+Qpy92C2rwzGU4B+hAjo8ySfi66LjeVo7WTr9ikyKIyWy+F5TX
         38hDXNlKq6PPknbwQ/r96LNlHK7Fob5KdluZUbhvXZg7qJbYvfdp7NNTGZ6xBLaLacrn
         TJY3DDP7U/1G6B0jsVRVaKgC1xZFezZaduAlvGWWkesricBxu4xjxKARAFe8LPbjV3Di
         xQfNfWq4CMrJUXepJZGkh+IeF9ZArT5rUczjvh0jorv4PbS/XKl5uNSqIiQYGf3ZY4AG
         wktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962874; x=1725567674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQY+2Uzxn46aPZCkb6ELEWKIY4fIyb07Bp7GBWFMe6o=;
        b=K4VIl72JsUGVrF4J6TiPmh4OQCLI6SIESCkxZpNtEOH/+aidWtgSLZjRtzZShZPfV4
         jzQECcPr2FOK9GogwEfPpILfUtfZguzR62pSH9R6M7o2YgMPiIsjJUCmtDFMEEWQX1ZB
         U0eA8Epjyp7jzfN18LI5vg+gAZiegOdRY0W6xUqIwzx58CvFrQ3O0Q27Wntg8IvChWEt
         GANs6+s7msCmg4jRe5WF+l+v+QeR4cW9gyk3dcFo6cnfoveUtQQU6n/mzVkBsYsFd8/g
         nPrcHamCPeoyXSeyZYksL1eNiNYDW7MikPTXoKJraUbmF9Ie0Ct31pGfWN7yuGDNYwnD
         XRcw==
X-Forwarded-Encrypted: i=1; AJvYcCUGMYpGUBiqvjkF3+biTQkn3FadSVl+9dZmmbHB0bpkYeKc5sJ8CYR7/i77YrMBZzvjLMNeDmyP@vger.kernel.org, AJvYcCV1EtqqLNzPhVNtBjwm+mnyhtoCTjsPYcSkAr0rGNydvPHTJtxpsyjXVKQXcDg1XTmgwJMj6uoRa987Q68=@vger.kernel.org
X-Gm-Message-State: AOJu0YywGgnQymVtP4Fhc8DCqpas/UGiv/qInxjwAX3+y7Q4oP0W5C+X
	XJzxKfluKLTVjtSaTpkO0J/0AgwRnZDgGFjmMw19tKq9dp2EMnrSuGIZ9W1YwCliBDFH1wNIehF
	1VZFqwrTYbN5uzIITnOY30A8dkyuPAvVW
X-Google-Smtp-Source: AGHT+IGCT0BwEBuQdp6cHnJO6I6b0cXq7zY+BJ1+WC35c+LqcRkq4EwHsM7LoS89zH399xgKJD2u5NnclFKqnRt3XMw=
X-Received: by 2002:a05:690c:d96:b0:6af:fc23:178e with SMTP id
 00721157ae682-6d275865f7fmr46704527b3.1.1724962873708; Thu, 29 Aug 2024
 13:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828223931.153610-1-rosenp@gmail.com> <20240829165234.GV1368797@kernel.org>
 <CAKxU2N8j5Fw1spACmNyWniKGpSWtMt0H3KY5JZj5zYaA0c69kA@mail.gmail.com> <20240829124752.6ce254da@kernel.org>
In-Reply-To: <20240829124752.6ce254da@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 29 Aug 2024 13:21:02 -0700
Message-ID: <CAKxU2N9F6+nZzW=me_ti76RwUFiKqG5RT0Ztgztc8yE9O3fwhQ@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: ag71xx: update FIFO bits and descriptions
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 12:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 29 Aug 2024 10:47:01 -0700 Rosen Penev wrote:
> > > Please consider a patch to allow compilation of this driver with
> > > COMPILE_TEST in order to increase build coverage.
> > Is that just
>
> Aha, do that and run an allmodconfig build on x86 to make sure nothing
> breaks. If it's all fine please submit
Funny enough it did break due to a mistake (L0 vs LO). I guess I'll
send a series just to keep these patches together.

