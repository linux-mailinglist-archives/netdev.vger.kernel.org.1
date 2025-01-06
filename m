Return-Path: <netdev+bounces-155493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3224EA02835
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5873A2970
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E31DDC3C;
	Mon,  6 Jan 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="tn6Ebh3/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC41C69D
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174365; cv=none; b=QzlRVElRDX/+ukvULo0uIwvwIHLD2fhaJgGOwrNUVJX7xzpxFBFMvX0ZhRNsFL2v6Pr6uoLLg1uw9rOkyapFVQUR7CRM+vgDSpgdx3CGBjp/YvpvlfS9Du/JfATGNf/D2wKmmiW+gk45mNEW+54AsyugRxZq93gaTCnmc1w7Mh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174365; c=relaxed/simple;
	bh=0MwAaiKZvtWvZA8vqVSveS1BCAORPxilApk9BlQQfec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dQz1YSBQ30cWcaOdQajRQP/DRDZzqe8Ss3NwMs7RbUkM+6TccdfldnBOn8/ZRPSiygD9+x0gUt2jV4yH3O2gyeSfpJJbi4ax1thieWIHyzB4uYYpbTQZEPbiKk8QJyUAHBU3iAv2cQXgiHdxhO3iP/ZL489eYEjRmeRvicFnaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=tn6Ebh3/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53f757134cdso15306160e87.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 06:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1736174360; x=1736779160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpOH+Vk42pIySfwZc+3b4dkxw9D5HiZHSYRzJLEA65U=;
        b=tn6Ebh3/hT9v76PI6H9CPUpNMAKtyCBpOYHuNSq6+57Jp5bzM5FfJyQJdDh2SseuI8
         foAKy/D1bBsR4OexSMeBUb/aUD1CDB3w7L9FLWKMU9tJDoqDI+h53DGLk7kFi5WMai0L
         QNgQD0Zld4+NqDrq+FQjHNFTTI9zdX+WZaMDni2Ous2/gUI5qLgaD3oIVKDqgssb0SJf
         2aLYBM8fEfqigs4xyqu6c2rtxZSI9U6CKMJJcAvZrsQISPnYvp0fgq/Co8uOrcBY5TTp
         kVEiwkswMq4L37iJWC1G/wZgXSuG+AjSCIM7NnWJEDXe5zRjvNsOcxLMv6Hce804O4rN
         YmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174360; x=1736779160;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpOH+Vk42pIySfwZc+3b4dkxw9D5HiZHSYRzJLEA65U=;
        b=VMZcJMDS8DlRfCpxAgHhdY2sSrz+vuVyHcYIstQt2DTyGvN0CMFIdjDrKOr47VsLw8
         LoMakEsas5/tkSjzEv3tjAi7U1KZDsdvG6ivpsjvjlb5aSN4ztq9j97Iv/l0Ltr+w3+h
         G1kpgLN4qb/EKGptMNjFjs0lbJyJ9/vSXLq9bhdon5t8vU18yKHMHUvLrx07E0rmZobj
         /QMT3RrMFR3zU+H1NYEvkFLohn7qs1CAXhGOEaJSXj363XacVAk+YfC3f/nEuuq/jXj1
         KGDwr+cuC6UvlSHS5v03XGiLjV70/OhHF5RUeIwEvy6Y5+RFAxDPpyWYBKkUNRrgy5zm
         0TKA==
X-Forwarded-Encrypted: i=1; AJvYcCXBwd5hhrxBJsIqvvw1bl7MmBRFyE9FYmL0or8m24NgdIEphu2Q6BxOj3mYPhqBkGvqHY7lULE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlHl39KHFFoFoYWLfcwM3FEzG6SuJ0SqgEQMvUjGVre2XZ71m
	p8vR5Zotsqp15Av4F5v77R6xQWZaseI+WZGz0/9BJ3SzOZ51871+faLhOvyokk4=
X-Gm-Gg: ASbGncv23RDMa68g4xgqRvpWqZTWJYRRNQQX/KvyXghMt+pkz52WG8ofOiD8u5JL109
	kEjbLUlAv980tloQg7oAMjruAa5YDAUBvDoLzjn35kvLsId2PGR4tPPqNGT3VhPsvRF2GanMV1c
	Z31ub/tTHnz1Raqj1hOJyFbjQiDqBt4dmvVmBwCm9I/pl8MHYQoO+WL2KP7CeXMKvfVVSafxRxe
	9L/Nj06eQ0ovA9YQTxChP8if4I4RRZmrnZjMs0CbyNvvtZ1qY7+LxwdTTnAgkSVOqwqKsmmQzjP
	wds8KQYoAaT7Rw==
X-Google-Smtp-Source: AGHT+IEYzNYgLYbNCqVK31QCisG2QOUTZWpQ9q4gXe3TiI0tZs8IBbhEvEaYATDqHS4yDof7nDwF2w==
X-Received: by 2002:a05:6512:2399:b0:53e:395c:688e with SMTP id 2adb3069b0e04-54229524737mr18573340e87.10.1736174360058;
        Mon, 06 Jan 2025 06:39:20 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238138fbsm4852529e87.159.2025.01.06.06.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:39:19 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
 chris.packham@alliedtelesis.co.nz, pabeni@redhat.com, marek.behun@nic.cz
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
In-Reply-To: <Z3uSXFH9bryiuVqX@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
 <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk> <87zfk974br.fsf@waldekranz.com>
 <Z3bIF7xaXrje79D8@shell.armlinux.org.uk> <87pll26z2b.fsf@waldekranz.com>
 <Z3mxsEziH_ylpCD_@shell.armlinux.org.uk> <87msg66uh4.fsf@waldekranz.com>
 <Z3ph3P9AFankiZxW@shell.armlinux.org.uk> <87h66c7sa6.fsf@waldekranz.com>
 <Z3uSXFH9bryiuVqX@shell.armlinux.org.uk>
Date: Mon, 06 Jan 2025 15:39:17 +0100
Message-ID: <87ed1g6m7e.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On m=C3=A5n, jan 06, 2025 at 08:20, "Russell King (Oracle)" <linux@armlinux=
.org.uk> wrote:
> On Mon, Jan 06, 2025 at 12:30:25AM +0100, Tobias Waldekranz wrote:
>> On s=C3=B6n, jan 05, 2025 at 10:41, "Russell King (Oracle)" <linux@armli=
nux.org.uk> wrote:
>> > On Sun, Jan 05, 2025 at 12:16:07AM +0100, Tobias Waldekranz wrote:
>> >> On l=C3=B6r, jan 04, 2025 at 22:09, "Russell King (Oracle)" <linux@ar=
mlinux.org.uk> wrote:
>> >> > Host system:
>> >> >
>> >> >   ---------------------------+
>> >> >     NIC (or DSA switch port) |
>> >> >      +-------+    +-------+  |
>> >> >      |       |    |       |  |
>> >> >      |  MAC  <---->  PCS  <-----------------------> PHY, SFP or med=
ia
>> >> >      |       |    |       |  |     ^
>> >> >      +-------+    +-------+  |     |
>> >> >                              |   phy interface type
>> >> >   ---------------------------+   also in-band signalling
>> >> >                                  which managed =3D "in-band-status"
>> >> > 				 applies to
>> >>=20
>> >> This part is 100% clear
>> >
>> > Apparently it isn't, because...
>> >
>> >> In other words, my question is:
>> >>=20
>> >> For a NIC driver to properly support the `managed` property, how shou=
ld
>> >> the setup and/or runtime behavior of the hardware and/or the driver
>> >> differ with the two following configs?
>> >>=20
>> >>     &eth0 {
>> >>         phy-connection-type =3D "sgmii";
>> >>         managed =3D "auto";
>> >>     };
>> >>=20
>> >> vs.
>> >>=20
>> >>     &eth0 {
>> >>         phy-connection-type =3D "sgmii";
>> >>         managed =3D "in-band-status";
>> >>     };
>> >
>> > if it were, you wouldn't be asking this question.
>> >
>> > Once again. The "managed" property defines whether in-band signalling
>> > is used over the "phy-connection-type" link, which for SGMII will be
>> > between the PCS and PHY, as shown in my diagram above that you claim
>> > to understand 100%, but by the fact you are again asking this question,
>> > you do not understand it AT ALL.
>> >
>> > I don't know how to better explain it to you, because I think I've been
>> > absolutely clear at every stage what the "managed" property describes.
>> > I now have nothing further to add if you still can't understand it, so,
>> > sorry, I'm giving up answering your emails on this topic, because it's
>> > just too frustrating to me to continue if you still don't "get it".
>>=20
>> I agree that you have clearly explained what it describes, many times.
>>=20
>> My remaining question - which you acknowledge that I asked twice, yet
>> chose not to answer - was how software is supposed to _act_ on that
>
> I *have* answered it. Every time.
>
>> description; presuming that the property is not in the DT merely for
>> documentation purposes.
>
> Utter claptap. Total rubbish. Completely wrong. It is acted on. It

I have _never_ said that is was not.  In the very sentence you are
quoting I stated my presumption that it was _not_ merely there as
documentation.  I simply wanted to _how_ the kernel acts on it - the
thing you summerize with the following sentence...

> causes phylink to enter in-band mode, and use the PCS to obtain the
> in-band data instead of the PHY.

..._this_ is the process I wanted to learn more about.  How phylink
operates in the two different modes, what the responsibilites of the NIC
driver are, of the PHY driver (if applicable), etc.

> YOU are the one refusing to listen to what I'm saying, yet you claim
> my explanations are clear and you understand them. You parently do
> not.

I am sure that there are several points you have made that I ought to
have groked sooner, and that I could have stated my questions more
clearly.  I am only human.  Let me assure you that I have read each of
your replies many times over, each time wanting nothing more than to
have that light bulb moment.

Sincerely, I am thankful that you have taken the time to try to help me,
and I never meant to cause any distress.

