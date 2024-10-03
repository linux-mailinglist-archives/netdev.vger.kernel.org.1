Return-Path: <netdev+bounces-131555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62A198ED54
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB121C20E74
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC3E14F123;
	Thu,  3 Oct 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgN6Q5iN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E413D8AC;
	Thu,  3 Oct 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952666; cv=none; b=OOAQWDfb+Pm+psbRyQB1kE/ZbT+ewo5JGGW62b+mD02YyQgGy2TmoW60wjnTERpg5IX+T4xmnrx+W8aVgRj487iAdyxNFH1GRtVk3dfLdJXBWadgNK0eqoi4S6pBa9IjZzqYtDZBluOGlypyqH9RyKec+D6OgEi7GdFgE6H6mZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952666; c=relaxed/simple;
	bh=2na18iOrAbDVZr2So/dIXChzraseuFNijAEVsON/iW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVOlWYnRkP0qXBhZA/xrHYU2OZ3s1MZM2Fwz2Cs6szWnG2k8oHAZ9+kE3Ovz72p6gRzg2larI6tswY44m45JUJ+S4jARSXFCfXlOCMIBKtdCp8EdufKXKZhP5QyJ5dYPamaqSlYfon4sW0YgTX1pWtgN9Mo2ETapxofFKdPeRDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgN6Q5iN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71829963767so153712b3a.1;
        Thu, 03 Oct 2024 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727952664; x=1728557464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2na18iOrAbDVZr2So/dIXChzraseuFNijAEVsON/iW4=;
        b=HgN6Q5iNq54O0Exx3jOUTTUfMRiKc6dJ7zw5xSk4L9WqpmFGsphhNS1lYUbB7zUO3Q
         s++R0Hre9XWhEe2+RnoEf0Ja5tMQvDgyW5szSqMzS0udzQs/orr5ZT7yZ13/u8/2oyXc
         EDMyDugSLLFmx7x8bG5uqrmRql2v63SU+1LmEF2ZrleptMiBrJbtRy09tp2CxOl/agcj
         69FJcUMKQswg//y2DobHLjNw17uHn3bo32iavmPK06tv9JJ/0v8cZPMyMeikZUi16D0+
         LdSVFWCGPIzDNg4DtAaBlcbeEATjdhoc+n0j2U/CGBzdDcYOAWHlOa7WJAoBRrpyZ/MV
         NXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727952664; x=1728557464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2na18iOrAbDVZr2So/dIXChzraseuFNijAEVsON/iW4=;
        b=m6qpOswstUdwipaqep5hoi5iOT/hpJLVzzmixuQ9SV5T+fixO1jHuVVslrbMo/b9eI
         fenDVZRUXjJ0hK+bHfVYDbhUjQDDVlGaV7GTwoFOILfnd8N8xCNSDHdTyqDXSuia+cah
         m3favvJnlCi4g6jwmLQ+MkVD/htj064Jaj3Nucpy8jYclGjSi8eIhf358NgPkEK1SzCA
         qjNabRzldXXTE5lzyZFPjLKF0TgAbdBlHNIti+kemgR2CDRDBYgPzbzNzVpHyNmK4jRP
         GafSWbUnEjU8ELV+ago67mrC5Aiq5cQF24Lh5n4h3q2lMR/f9JjjDv1PgFckrpOsADk6
         wfqw==
X-Forwarded-Encrypted: i=1; AJvYcCUALFBzpDwJO12L7qUn0b5mBfV67Mop83j/gRESBuNq7RD7Ve24Tsxpy8kTZiwxS5nczdu1gahnYOCkiYktNPQ=@vger.kernel.org, AJvYcCV+2zTX8mi9ugP3t7dYqaA91CaPQopSK1LMJ8PYaFyP4k9Ic5fxyLzecG2mONt5q5IBZRtTQSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0H5XIzLnHY9GMNto91FTJnyMk38tO8t7JiFn72WRuSV0jGGh
	DNLVAnYCaeUM8f3xaSbIM8zlX5jaKnldinkAepZNkXTe/19OUH8iigYHaEprmtlUz+lncZUDY68
	5w/OmSikLTxO7eO09KPm4jhEauVIMm1tBxFobSA==
X-Google-Smtp-Source: AGHT+IH7PyEMQU+9NizssqKWrNLhXPbC5BtP3FcbBIRpleAxdeauWBw6DVPjUi9P2fkAxomgqSZ3NTLgD3TiASchoBc=
X-Received: by 2002:a05:6a00:1304:b0:70d:2c09:45ff with SMTP id
 d2e1a72fcca58-71dc5d7ff02mr4250471b3a.4.1727952664334; Thu, 03 Oct 2024
 03:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002.144007.1148085658686203349.fujita.tomonori@gmail.com>
 <CANiq72kf+NrKA14RqA=4pnRhB-=nbUuxOWRg-EXA8oV1KUFWdg@mail.gmail.com>
 <87bk02wawy.ffs@tglx> <20241003.012444.1141005464454659219.fujita.tomonori@gmail.com>
In-Reply-To: <20241003.012444.1141005464454659219.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 12:50:51 +0200
Message-ID: <CANiq72n5y7ruB1bgGquONWctPK=LBZUWugBAP_1QOSzvOY+amw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: tglx@linutronix.de, aliceryhl@google.com, andrew@lunn.ch, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:24=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Rust abstractions are typically merged with their users. I'm trying to
> push the delay abstractions with a fix for QT2025 PHY driver
> (drivers/net/phy/qt2025.rs), which uses delay.

To clarify, in case it helps: users indeed drive the need for
abstractions (i.e. we don't merge abstractions without an expected
user), and it can happen that they go together in the same patch
series for convenience, that is true.

However, I don't think I would say "typically", since most
abstractions went in on their own so far, and each patch still needs
to Cc the relevant maintainers/lists and the respective maintainers
should say they are OK moving it through another tree.

In other words, the "default" is that the abstractions go through
their tree, i.e. delay wouldn't go through netdev, unless the
maintainers are OK with that (e.g. perhaps because it is simpler in a
given case).

I have some more notes at
https://rust-for-linux.com/contributing#the-rust-subsystem.

Of course, in most cases to review abstractions it helps seeing the
expected user, so sometimes it may help to show the users in the same
patch series, and sometimes it may make more sense to just add a link
to Lore to the user, or to a branch; and sometimes examples in the
commit message or in the abstractions' docs themselves are enough.

Cheers,
Miguel

