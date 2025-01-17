Return-Path: <netdev+bounces-159462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D055A15905
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B4166952
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFC233062;
	Fri, 17 Jan 2025 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKyNwXEz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01071714A1;
	Fri, 17 Jan 2025 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149472; cv=none; b=Ryq511+plhJaNVM+EmGjbOMjuQrdvnbYREV0JHchGT97To9EEFhxoOXNF969JD4UvY1y7zjyKwM7LhCZg09vT7OiXfHz1E1vMszrO0N+FUj6SVuQ9HStyn0Os4vr1Zw1H8motCUSEHo3+uEBk1D8eSBM2UVRNYMzCcsYHgTEPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149472; c=relaxed/simple;
	bh=Re7V12fE4yW1Kve9lUOFrT0wX3guCjphFuvEb1LpgTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtI445ZpC1K1UzYTahicb/Cz1fZLU7jAqKzjB4qh0PoojScW4/bBK2wtigntp6u1xZE/ij7B+eNIG5zugIIAWZcjdvr6owBZyHB60tEUog55IX5p7VgHBKTXk8Mfz8tpRf2dV/3HtsggaUpaTqxlfhQv964AcnmThCrD0+zF/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKyNwXEz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so22753071fa.3;
        Fri, 17 Jan 2025 13:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737149469; x=1737754269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re7V12fE4yW1Kve9lUOFrT0wX3guCjphFuvEb1LpgTc=;
        b=CKyNwXEzqb5tlPG1IrcXCvecVyJQZSAqSJbMSdFyrMMKGWlfKTS63ka75yz3MRhvWB
         0Z2n9TuEw/KnLFTi9E2jHioCWYXz3ZObPTk05gliuURTHKeB9h7pB56MG88rkTbhj+6a
         tIEs5Iwf3xprV0k3kdiK4QLt66/wUUjY4Rc/g4cvkoS8DOMhV7m6W8Aak6OkOzKV5pyp
         aw4+RqUUi9cwO4IH+Y/AIARazRb6PF6Tb2bTSYDVr8FBdvmHf1Mz/UukFu5DnZ+XXvW1
         EMzfTswCjip8xS77rfEPw2SJEvqvKGgvzUyRFmWD/LLFbcQZOBtPBFb/RJVTLmG8VL5Z
         ezZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737149469; x=1737754269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Re7V12fE4yW1Kve9lUOFrT0wX3guCjphFuvEb1LpgTc=;
        b=J4/bEb3NRD2Ygz//reyEfZ/YuwWWiMLdgBB2kQCaU2h7wfXHIYQqG8CpK6bz8Se74o
         UO8l+65zLtFMVLAZtm6KNwq+tfj6GnMtsDb3zvScYwXtdA1jEPSmqpb89dgECWk5v9YJ
         amYAAdUUOARfk5Fgc4BcV2BIGq8IUrWOgbPl6IUdtxzhAjsvayTJH6eafI3zfW+TT3l6
         eLKAe640grn7KeI3pUrwVr6se/0tiu9YYqVKr+f6pcZk06IOiiOPsPxKT1gwMGU/WbZp
         l0kiYGFsFS5Z555l6eP3W/a7eaoY7ZB9rZf7FNVf94BjAYnAwzAtaWMEkpfzNAfCMgul
         ie4A==
X-Forwarded-Encrypted: i=1; AJvYcCUpHGNFUmqr3LZMXg6a+EGVYMPrbx8t7n9subW9ln9whGo61F2FzvGWO4pxntJwiX7holq8mWFz@vger.kernel.org, AJvYcCXpnvRSLa+DmDggAEPlYuYrG7CL4msP8lZcy6jSolo3JvqvLWyaaClynSG4hz7YP7LNS0xpIxDz7UiQ0lUdnJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhK4+yoPNGR2POH/dwnvfSdpnF4CWcY7tO6Clk/iV1z3oKTyhc
	oXFWPDEg/zm34zZUuzXQCmPef1z3RBiQOGwTYxBCKSZid9TF2pOpA2kLIu6NyDH1mtwnuSAHVp1
	hnNGrTF+ZefV2Oyf4uExlAWNAOU/20AtI
X-Gm-Gg: ASbGncv40ak9BK1p+Dezy0COr578D2MHLCDJfaLLULwj+xbrAyzXatE4Ar69o7ajC3O
	LlcVDRaIN2ABoKNgfeZaxKa2x8KX2LZePFHzjvGo=
X-Google-Smtp-Source: AGHT+IEe2Vlk48LzgdA9l7OdOia6l1NmszPBcY6RJC+Y3nZQ/nXGt9AbShVCCLDkLYKuLsznQ0MlTb0rdHOqVqkjz5U=
X-Received: by 2002:a05:651c:b12:b0:304:d31f:2fbc with SMTP id
 38308e7fff4ca-3072cb817c5mr14625101fa.36.1737149468493; Fri, 17 Jan 2025
 13:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115210606.3582241-1-luiz.dentz@gmail.com>
 <CABBYNZJ_LfmEzZaZjxwY7uG8Bx1=+-QE5B07emtz5sios9XZ0A@mail.gmail.com> <20250117131711.2b687441@kernel.org>
In-Reply-To: <20250117131711.2b687441@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jan 2025 16:30:56 -0500
X-Gm-Features: AbW1kvZgVg1AuxPUDQIa42a5NHqJSQXAh51avJdLcdlSfRSIBZIfEoUAz2xlxnI
Message-ID: <CABBYNZ+Vosag0qPnrWqc-uQddg3E9aJOMDJaiVTi9bYnXiebFw@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2025-01-15
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Fri, Jan 17, 2025 at 4:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Jan 2025 11:17:36 -0500 Luiz Augusto von Dentz wrote:
> > Looks like Ive only send this to linux-bluetooth by mistake:
>
> Could you do a fresh repost? patchwork will not gobble it up from
> a quoted email :(

Resending...

--=20
Luiz Augusto von Dentz

