Return-Path: <netdev+bounces-211880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39CB1C27D
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9743A4826
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 08:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A5289344;
	Wed,  6 Aug 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnjBdp8I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46128935F
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470310; cv=none; b=KXBNW5j/CjOCNnxhkbJwU+/J14FeHw60Qt5XQszCVy5t49fq6rBCC8f6jU1Zh/mweTLI6EUX+6IUJDwBt48S0x1CXRQ1qPEnqNs1gJ8QpiQJUxqv6FdJRQj/eltTt+YTK5tGP13k649fFM81U3Xw91z6w0BcnY7Kd+guQnLrM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470310; c=relaxed/simple;
	bh=qn+da6NUV+VK6TZyQ220xYn9XBWEkV1vJu5G8KrmkBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUufOFITuLCHmFmwHF99G/fQt5CS55i71SWOpbAlDnilJKHFBKqW+xQG//jTjSyDxZRGHkGfSHPD9enj7QsroUaMjHJMQdSzrr1FFcqkmjpCt9sLFkRnm+nfAPJnA1xl5yyvLZAG+rgyk2QBJFF0Fo0yXp5lU5HqkJU+hJ+iwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnjBdp8I; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b07d779287so21235491cf.2
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754470307; x=1755075107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn+da6NUV+VK6TZyQ220xYn9XBWEkV1vJu5G8KrmkBo=;
        b=vnjBdp8I7GiCT0wib5Bk5IB2YVWBwHyPvsdiIx3jY+uayeLdSjyIkkXTgB9tCDRhCE
         XGFql+zWOnix0VbRoJGb90p+cJD3eg+qaOWToLqcMMxyxvAPh9r3hrWhAZ5OGQNLgh5L
         W5Bgr+K1YlK2MCd3mnkgwKg9SaZD1gmjViYF7rwB/UAEvHNkl0547Q7cMOdCXMmwQC6/
         HGo66cf5c/bG+tzioAIi4qjR29G84saFeKlPdv7BGotYfOiQN4iXCeamAQssWv+pA8C2
         GUxmQA95JfO1AgPyeTOFYAuPk63zcNe5HcymWxGYdJhqIGMMmkg7lmLp2uMndw+9COIn
         Tyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470307; x=1755075107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn+da6NUV+VK6TZyQ220xYn9XBWEkV1vJu5G8KrmkBo=;
        b=WAQzy+bQH8MrYk5Jrk44LGcKgNZ+VdPamxct3vybE36OAFnkEMkKJq9cxx69GAj1SY
         VDRFfhZIqaFbhsjXDEoxOy7fC+HiVusr3OKLNYWM1vDcNGBfn3g1+4w4O7REamrFSAt6
         6JcdGmZ1Nh36yPDjEB62xmStOdX/Zj+cgZ2KAlcGTZxDIYny6EhLdkcfOYbl2E7vPVbq
         hQK27++t2UudxFuCNNk9Nu24XSnPKJsiwg86CZx3gaQyTcp/9dnvmO1TwlMnrPW6Pu7F
         Z1hqDxwYS2MuWHLsPSuSGNDUkKWOFse7geI3FnUkuRxYilhLpH7gw9xj2zEmio4EYJSV
         4h4A==
X-Forwarded-Encrypted: i=1; AJvYcCVkKSRmDwT+Fu4yIIXtSDn9AWdSf6xPge01Rrrj3a52+bR0RrvuV8oMbqY2sgMP+3ah5LhDAS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4D3d0vJJG5eNjcmZBFtaCDCCntJoeT5IfxrXkW4BAux5i8n6
	X859TcPJZM8BVQvIIf0oAcqqAs7nHbm9R8QnLCPC1bgwc4uYy6sfhxHtBkbDfo0VZvPB63ojyyp
	Sf1IVAUWuPipU4dPZ5sbPDdGyTz0Q+1PB0Dhy8wJf
X-Gm-Gg: ASbGncvGuRtPRwS89TTsbd30sy3K/acBjuZSYy9UPksWx/PyCHaiHkyLyd2jovEVLaU
	4/pK+UPo1vlPbrJUzOtsmd5dhE0B5qUJJ7yL7izXVMnR0O5iH2d1RqLkUQXCoCbj9PenimaN493
	ZgMxqgsRC7G0ISrrLr0kPuUJCMB7TDlzRjDHLGQznx+t9BoIgdg7LSzXU0p5G3EEm3519JIn0xr
	XOVlHo=
X-Google-Smtp-Source: AGHT+IGL6MT36ycjN/Z2kzDW4M5h69hOhbRXJ2BWZUCsi//eLzj+Pojd4e2nsf04f3CGggbntbB8f5Eau53j54zGrTw=
X-Received: by 2002:a05:622a:5519:b0:4ab:3d2a:7f6f with SMTP id
 d75a77b69052e-4b091543bb6mr33409941cf.33.1754470307253; Wed, 06 Aug 2025
 01:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806055210.1530081-1-jackzxcui1989@163.com>
In-Reply-To: <20250806055210.1530081-1-jackzxcui1989@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Aug 2025 01:51:36 -0700
X-Gm-Features: Ac12FXxf0CU4fmy-lD7GRMqvzg1F4P1w6fy3aRPBUx6y2GnFXkFQj6-DyAbECsI
Message-ID: <CANn89iKpG2-+oj45SEwOggj+3j682Cgh+L7+61HF6Q0YspPikQ@mail.gmail.com>
Subject: Re: [PATCH] net: af_packet: add af_packet hrtimer mode
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:52=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> wr=
ote:
>
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Add hrtimer mode to help
> compensate for the shortcomings in real-time performance.
>
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

I doubt we need another CONFIG option ?

Also this seems to be beneficial for HZ=3D100 or HZ=3D250 configuration,
maybe worth mentioning in the changelog.

But more importantly, I think you should explain what difference this
really makes,
in which circumstances this timer needs to fire...

If real-time is a concern, maybe using a timer to perform GC-style operatio=
n
is a no go anyway...

