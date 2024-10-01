Return-Path: <netdev+bounces-130835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D533398BB55
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE891F21284
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27661BE241;
	Tue,  1 Oct 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rI6FGBKR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1671C0DCC
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782618; cv=none; b=qGtqI4cWTNOJJM1Txl9QD726poMIZ3JEI8nssbi+fWeEIIno6ej+TUE0fLcwSbpbioYWyVga/2OIW6vetWZzH80lRi42CDumcZOHG/UQL4hnG5C+6jhZOnoK8HdpFA02/65PT+lVuVIyhrRHiAOoPnp8Le2jNbfX9e9pM1OS8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782618; c=relaxed/simple;
	bh=dOeIz7dVJrL5Hj6JkVPd8ph2UjBqhmhQj0jSH3MFbhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vr4+B3Ta67g2mTGJDuYhhE66i39wKO1uKnJzp7P7NCkZ2Snic1pC159PyZXinfBgwekNsu5/OiEFJijlk3yfrtOl4ZWkJ89DvvLX8TzABz8VnSaFEIL35u5OcS4esRzPHeEjMJ50GbbcwVTMNf02U7FVHmpDF0ceVy2twD5v/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rI6FGBKR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37ccc597b96so3470010f8f.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727782614; x=1728387414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYdBnDP7QZTIip4//6Zh5tkTuHOxecL4KL4JxgRuAus=;
        b=rI6FGBKRfHYxJuXTFKOVcKi0t9C3a0ezTxjBpfhk6rNBbTlB97WgpUvhczEIyqlR8C
         jFaupjnAmNoxvnvUt5cC+PUYwAiODpdvQE9volzlZcSeVrv1Ur16xZG4ob51yUuVFpe9
         fcGsTc8UdugII8St0+/rio9pis2ZEis+qWGH4WCmTkM4toIoZRwVZbbpAM4/coMJxYnH
         NHQMKA89hJST8PXrxvXmlS7HDWIvlfniEZDAbym/pzkflxvGlQ15TXYOM4XcVSgJGNZ4
         qzt+89Xk1FNMJf6dJtHBIZ1z2Jo+HvoHcs2yZNL68WAJWDyTfqiJ7pwlialNm5dhf8Ky
         i/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782614; x=1728387414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYdBnDP7QZTIip4//6Zh5tkTuHOxecL4KL4JxgRuAus=;
        b=RTgyGlacmj/E0lMCkY8ITSiecgLWNqLP5Ifs6zfEPi4ZVpno0A5jjRcnWhYY5ROOjy
         IowqxBGVBWGfngzz987y9jKGuHo9DcSWYik2LMY/Q5u2ur32GGTGoUXAl2jPfyou96jM
         tFuJLnbi3+Ly4KzCEEhwWK8OVjuHYo3CugSU1u5AaRfc2Hk+gtuIIjNlFwl2FbHl8QTk
         O0UAMNg3lr7iFBoZnU+c8Uf0sarHROLpEK/bjJyAp+2Acox3bDD0EHfK/osXSblyEaiP
         jg6Q8mUeIG+uQWUtvHbgMSGO5K9QgNPNRpaE2sTIEL96MX/e8GThUQtRvICPK/co/H2S
         Wdiw==
X-Gm-Message-State: AOJu0YzQhqyPKFByh+qyNWc1x8QCgbLUqtk8/VyGua5k9nHmODAJJ6Xp
	28Wuz84Y73NGu1cS6Z609tbtN761BFeBsI7icYblWdZtc3CJtwXBisAWJme0tbkcCK9L4UxlFFQ
	lydl5gHMa6tzcdq26YD+fX+hMSukEb1WdBooA
X-Google-Smtp-Source: AGHT+IGiOUCFCbJKyNx9oXZW9aK0PJkmokecNoNDgCXC3ibG4deERBcCGTGDAlnaW90/XEH09gI9nKdB+dGZilB/tmA=
X-Received: by 2002:a5d:494b:0:b0:37c:ce58:5a1b with SMTP id
 ffacd0b85a97d-37cd5b105a9mr8710458f8f.51.1727782613907; Tue, 01 Oct 2024
 04:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001112512.4861-1-fujita.tomonori@gmail.com> <20241001112512.4861-3-fujita.tomonori@gmail.com>
In-Reply-To: <20241001112512.4861-3-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 13:36:41 +0200
Message-ID: <CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] net: phy: qt2025: wait until PHY becomes ready
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 1:27=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Wait until a PHY becomes ready in the probe callback by using a sleep
> function.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  drivers/net/phy/qt2025.rs | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
> index 28d8981f410b..3a8ef9f73642 100644
> --- a/drivers/net/phy/qt2025.rs
> +++ b/drivers/net/phy/qt2025.rs
> @@ -93,8 +93,15 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
>          // The micro-controller will start running from SRAM.
>          dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
>
> -        // TODO: sleep here until the hw becomes ready.
> -        Ok(())
> +        // sleep here until the hw becomes ready.
> +        for _ in 0..60 {
> +            kernel::delay::sleep(core::time::Duration::from_millis(50));
> +            let val =3D dev.read(C45::new(Mmd::PCS, 0xd7fd))?;
> +            if val !=3D 0x00 && val !=3D 0x10 {
> +                return Ok(());
> +            }

Why not place the sleep after this check? That way, we don't need to
sleep if the check succeeds immediately.

> +        }
> +        Err(code::ENODEV)

This sleeps for up to 3 seconds. Is that the right amount to sleep?

Alice

