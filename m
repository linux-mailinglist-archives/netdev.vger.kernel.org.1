Return-Path: <netdev+bounces-149991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD299E86CD
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECEF188532B
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4549187862;
	Sun,  8 Dec 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AOnJoTG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299418732C
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677176; cv=none; b=mizkFMjhtUou2AOXQsvQvCDJA0PpzpC3BJbx1oYNE4Y+S6xLUmQQ5jdicnlybCMsxjopAitsMNw8IXVAsUJCYqnjTjR+fHdxfAfzADJDR6kDprm1J36MM3OnXCnV8pQ0lpubub9+aWY8s/VQaRXmqXR2On6VoYppKOx75hx45TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677176; c=relaxed/simple;
	bh=azq1B8QuNnX4C8HwV3S96dnhxIhN0sy//FVR989QCMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCQ3O8FSsiwctdCJSFJaMIieFa0IQPVT+eLWowStHGyKikgB6I9Uo4oDfASVDToxTO9fhlE3HQR5bFXYKnASYal1MJL3MR91fUx60RsrPY0S+GOAnafYY58Jt0apzx+m+gATqW1COuHAzcWGYl2yWPllpTZy/Ojs3L/ltsFxnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=AOnJoTG9; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3982e9278bso3659978276.2
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733677174; x=1734281974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlFfwVqRXK/paRpbQAVFV3F3tMqaWvPJwZQA+19pyHg=;
        b=AOnJoTG9p2WTiuOX21wG2tfNrHtxElmyUm8i+ieHRJ877b+Fp4/uY74Jyli20N0Dv2
         KB2Abi53ZVGJznrbhvACI9+nc9YfnO5Mqwrktp6iQjwndUPBT4Tguv+SKN7/trb0QjPK
         s8TBQfnQqPn06STQn1EJY7t+QPan58cMwgv9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733677174; x=1734281974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlFfwVqRXK/paRpbQAVFV3F3tMqaWvPJwZQA+19pyHg=;
        b=bvVKgH5mhazz0nwMhc1czDcq9q+rGu2hApEbwlrgYCUvEClJ20lIBCsG8XCYxkDTrH
         WPUMtNRXq709RmtY6O1BQlGCIceL2FjKvun15qaP48UecG5sNeGW2zS4EhMLn5Kdv4i2
         OFFKHsLV0tLkUZlHgEWXi4r4JFSlCg2W4nkU9G2oxYOFnKDIKfy3QRbfyzD5tppB0wyr
         jWFZtBelltU1YhS61UCWN3tg4hjAnYx+I/WyJVsfokzwET88r3LmOaZweahz82XPgzKO
         wrIfxc8SDmx9d05efM+utpUTPPRvJZH+jhFsstZV9cYQ/b3qBJkJNCkgPWZkhhu2N/ev
         pTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHY1kTveS3w6eLsAQMvrkyW5vT/H8Or0JzeXeIGF8QjMXUlzpm5W1Z8oS87J+haGmDhuwhFiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZzxo9a5O6hlSx7L8M3kzzVWE7ltbt3hht680+OqSgmDt4Fsj
	7Esf0DY9Enubt+JpmLPF4pjfT+NYtZFv15/kGfGOHEEJ7I7Ho1drYSln85DTmpgtGrSauVn6Tj4
	FMxc88Cmlg+AmTa4jeoQqLbPA5mJovVKQljn7CQ==
X-Gm-Gg: ASbGncsEl7qGSYIpwtBeHvSRj/fo9QBBdGLynVbbxvLQ2Nc0N342bKoRNjNa6F9a0kI
	6nB8LEEyes87w9zBkXCfka5Yw+daY
X-Google-Smtp-Source: AGHT+IHc2fwFI+591nR9iKIG3YHjGTjB6Bxuk5sHYVwNbNdHEzV9blLi8vqQvdYTmxx4bc63U1c9ZKmKAJezuz8XeJ8=
X-Received: by 2002:a05:6902:268a:b0:e39:6c6a:f2da with SMTP id
 3f1490d57ef6-e3a0b0b6415mr8620220276.19.1733677173884; Sun, 08 Dec 2024
 08:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 8 Dec 2024 17:59:23 +0100
Message-ID: <CABGWkvp=VdpOUGdHep8E6p8C+gFGsZyhMEtcjkx-zNaG-X_r3g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Add helpers for stats and error frames
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Gal Pressman <gal@nvidia.com>, Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shannon Nelson <shannon.nelson@amd.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:46=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> This series originates from some tests I ran on a CAN communication for
> one of my clients that reports sporadic errors. After enabling BERR
> reporting, I was surprised that the command:
>
> ip -details -statistics link show can0
>
> did not display the occurrence of different types of errors, but only the
> generic ones for reception and transmission. In trying to export this
> information, I felt that the code related to managing statistics and hand=
ling
> CAN errors (CRC, STUF, BIT, ACK, and FORM) was quite duplicated in the
> implementation of various drivers, and there wasn't a generic function li=
ke
> in the case of state changes (i. e. can_change_state). This led to the id=
ea
> of adding can_update_bus_error_stats() and the helpers for setting up the
> CAN error frame.
>
> Regarding patch 5/6 ("can: netlink: extend stats to the error types (ack,
> CRC, form, ..."), I ran
>
> ./scripts/check-uapi.sh
>
> which found
>
> "error - 1/934 UAPI headers compatible with x86 appear _not_ to be backwa=
rds
> compatible."
>
> I included it in the series because I am currently interested in understa=
nding
> whether the idea behind each of the submitted patches makes sense, and I =
can
> adjust them later if the response is positive, following your suggestions=
.
>
> Changes in v3:
> - Drop double assignement of "priv" variable.
> - Check "dev" parameter is not NULL.
> - Drop the check of "cf" parameter not NULL
>
> Changes in v2:
> - Replace macros with static inline functions
> - Update the commit message
> - Replace the macros with static inline funcions calls.
> - Update the commit message
>
> Dario Binacchi (6):
>   can: dev: add generic function can_update_bus_error_stats()
>   can: flexcan: use can_update_bus_error_stats()
>   can: dev: add helpers to setup an error frame
>   can: flexcan: use helpers to setup the error frame
>   can: netlink: extend stats to the error types (ack, CRC, form, ...)
>   can: dev: update the error types stats (ack, CRC, form, ...)
>
>  drivers/net/can/dev/dev.c              | 45 ++++++++++++++++++++++++++
>  drivers/net/can/flexcan/flexcan-core.c | 29 +++++------------
>  include/linux/can/dev.h                | 38 ++++++++++++++++++++++
>  include/uapi/linux/can/netlink.h       |  6 ++++
>  4 files changed, 97 insertions(+), 21 deletions(-)
>
> --
> 2.43.0
>

A gentle ping to remind you of this series.

Could this series or some of its patches make sense to consider?
IMHO, if all the controllers indicate the type of error, I would expect
the user space to be aware of it as well.
Or is there something I might be missing?

Thanks and regards,
Dario


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

