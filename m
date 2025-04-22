Return-Path: <netdev+bounces-184830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B2A97687
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DFB16BE0E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D6B2989BC;
	Tue, 22 Apr 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfFvYMVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB719F464
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352598; cv=none; b=SLmez7gsKVeSPSsxTg5oRXhkTxibUvADkBloV+ZvWtfh1gI2Sv/LyUKBciJF/Ky2yQSR8M9/fMR8stSdR7CVyxEBFGnQgeysBSZDK/Jf4DfWYAo+u+mIWTx9b5EhAlO/MZ42oixIhFmCEJ3ufX892ocZer1tfBfH863GRq14c10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352598; c=relaxed/simple;
	bh=BfWAJ6bxkBGl0yezZ5bW/FKNrEZJ2E0o4DEtdJr2UJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0sDUL5TiI6QRvqIjuZXL2JEnLXt0LbjGGaD7xtJuBkOkug1nMK0jirigwye8G2HuZIWwAZ/b7VA51StLWRBMmLiDtNZadV/tfHOrxUJH3LlitFEDA+OOwwytUTTtQYrriZ1iLI3CcWZx7eU+eou69WApwHkLUg8wcBUCEp5fos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfFvYMVk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a823036so46249855e9.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745352595; x=1745957395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rytiEaA+xetW7E0iSeqWcwwCllu9E8GtP78YvjVrrhY=;
        b=UfFvYMVkLebeSfnPhzviIkB4S5qa9GrX/0dVZpfSftW7moQrew7oDTPNSo/tJNZc3W
         layb9orqk7jdbwwk/3HtMhAa5Q0ojvtQ/K8BiyuuOPG6U1zSXM85dCPG/33CYxZhjva6
         Wgt8M76cexQ03WbFVE3wPFV3UQwDyPZryumK6ZS9xAUHw1hH6ou/yXZIVz6crfFvOGwu
         2q1AI5lYvpaE7VYtJuS85wdgaZ+n1Wq/a67lGFN82nl9fmTzLpKN1uYii9dnv7aDBDc/
         vucqp2zV3HPWZLWTyzwQI0wvoEmmfSpOYAFdNcgTBgIYROEfjmyRyN0GUIMVRrVBCTEC
         9Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745352595; x=1745957395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rytiEaA+xetW7E0iSeqWcwwCllu9E8GtP78YvjVrrhY=;
        b=fGRkYOPRivwxD7lokXku86QNv2sUSTd9RHoTqkWbPTRq+eS2CzpvLLTe+1gDQ7abEu
         yZeZYAgTC+FG0quRRBRomKW7LDze5L1A8z075eQDw624T4hwgI6JYI5tL5MCFsAkH2J6
         hXwEQXQCpeMoRA8sYZMGxZ27wPqHNephgZATIxzbof4HqcO3BsEQHVRy6Rs+sEy9S8BV
         klIcNEbMQ/6QW4SaJ2i/OwOXtXkXV6WZesB6WZqJBZLiEfcar8hXFudnmRoP/739Fhwz
         pEPsTcA3Ip31RLM+upcVtTON4bThiQKn4HgD7WzQFZy8gIqHR8KAxFIrBbNwU7/DlJ0e
         6f5g==
X-Forwarded-Encrypted: i=1; AJvYcCWbWBtiJWwwYv0zdhuBJbvdo7LQoSxUVSKiecOyki2gIY+fPSgpzuAGJjFAhpCuyL4A5iUVfZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jnXQZRBq/hY+RrU28chj852oDe9uxQghwYn0npZRlS3EgB9G
	9eSA40ZrUV89EhcS1HBIjEAtCvOj+KpSDet3YcqwPxAsc8VXXYBFHOot9JEOKy918gnJjrJqhlk
	Whq1W3J6AQTkvbDV5I4CyMUCTYGg=
X-Gm-Gg: ASbGncsf1Rh4SGQRSEI1c0Bcj0YRpxC7GG46ur9KyUBL1xZnKj0FrO/8KAeFigUHlFh
	TeAotzZwSseZVhfPIKFXuqCSfTRtkt8M2FI55t4Jolq3EuIHi+tk8ZbBIAN80G+t9mqqsJ1Tmyf
	zuvwnU+ylNjYSF45MqF4BI7evAriJmVugl6JHUPggupQUROCUNIQr068M=
X-Google-Smtp-Source: AGHT+IElga2PLQofAWl28v8QX9N42I27yW+FIKjtHT2U7mdPACtJo1jZRR/dl0DY8QlmLx9urg5qDFLRallw5JtO5gg=
X-Received: by 2002:a05:600c:3c85:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-4406ab98242mr124737975e9.8.1745352594455; Tue, 22 Apr 2025
 13:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z__URcfITnra19xy@shell.armlinux.org.uk> <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
 <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
 <aAERy1qnTyTGT-_w@shell.armlinux.org.uk> <aAEc3HZbSZTiWB8s@shell.armlinux.org.uk>
 <CAKgT0Uf2a48D7O_OSFV8W7j3DJjn_patFbjRbvktazt9UTKoLQ@mail.gmail.com>
 <aAE59VOdtyOwv0Rv@shell.armlinux.org.uk> <CAKgT0Uc_O_5wMQOG66PS2Dc2Bn3WZ_vtw2tZV8He=EU9m5LsjQ@mail.gmail.com>
 <aAdmhIcBDDIskr3J@shell.armlinux.org.uk> <CAKgT0Uei=6GABwke2vv0D-dY=03uSnkVN4KnKuDR_DNfem2tWg@mail.gmail.com>
 <156d5309-dc73-4ce0-9c26-48a3a28621dd@lunn.ch>
In-Reply-To: <156d5309-dc73-4ce0-9c26-48a3a28621dd@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 Apr 2025 13:09:17 -0700
X-Gm-Features: ATxdqUFoyhSoOB3rRpGa7M7Y62WsyNVMHyPGuuYMVxaJVTN2hyXUSAlj83mA6r4
Message-ID: <CAKgT0Uc3-KRSkKCZpOeh6FyNhL1ZYAnwqUBEhNKgSyQNpbn_uQ@mail.gmail.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled and
 link down
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 9:00=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > For us to fit we are going to have to expand things quite a bit as we
> > need to add support for higher speeds, QSFP, QSFP-DD, FEC, BMC, and
> > multi-host type behavior at a minimum. I had more-or-less assumed
> > there was a desire to push the interface support up to 100G or more
> > and that was one motivation for pushing us into phylink. By pushing us
> > in it was a way to get there with us as the lead test/development
> > vehicle since we are one of the first high speed NICs to actually
> > expose most of the hardware and not hide it behind firmware.
> >
> > That said,  I have come to see some of the advantages for us as well.
> > Things like the QSFP support seems like it should be a light lift as I
> > just have to add support for basic SFF-8636, which isn't too
> > dissimilar to SFF-8472, and the rest seems to mostly fall in place
> > with the device picking up the interface mode from the QSFP module as
> > there isn't much needed for a DA cable.
>
> You should also get hwmon for the SFP for free. ethtool
> --dump-module-eeprom will need a little work in sfp.c, but less work
> than a whole MAC driver implementation. With that in place firmware
> upgrade of the SFP should be easy. And we have a good quirk
> infrastructure in place for dealing with SFPs, which all seem broken
> in some way. No need to reinvent that.

Actually the hwmon will need some work as I recall. The issue is that
it is reliant on the a2 page support and we don't have that in QSFP
since it is based on SFF-8636.

As far as the QSFP modules we are using we also don't have to deal
with FW upgrades and such since we are just dealing with direct attach
modules, and the quirks for now don't do much for us either for much
the same reason. However there is always the potential for us to use
something other than basic direct-attach cables in the future.

