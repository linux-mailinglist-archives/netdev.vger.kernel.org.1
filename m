Return-Path: <netdev+bounces-266431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGGaDAjXsGnLngIAu9opvQ
	(envelope-from <netdev+bounces-266431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:44:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F525B17B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46F48302CB2E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3C3446C8;
	Wed, 11 Mar 2026 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW0pOIri"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94A33E368
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197061; cv=pass; b=Ejgwe26+HXAbsMriDNEgJd0Gf+AK3+m2I8S4Jo/CDQ/MlrWXJmnfvlGNB0iVKD9Ct1AtFsSxuuVg8wDngvC0tx2YHPwtdM09fUnJJz4XeslYucaxZfFSvZIaCvMBCrm2ufES6ePPORhr6JvzwHYnAzJ/uFbXqxB5mAz1VOGJgkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197061; c=relaxed/simple;
	bh=3JD0VC74mLxBvQCagNobJZ17Es9Rvor/QFxHcKAc4PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izMVCfZnfieMYQReVxIheO0f2la9gj+PtpGdYC6q9K+RBMZGRAosvb8i9UEX2JFNPoX3ADMCsFgnvV4GhBhPSX1l45iavV6Q1zrwjpwAY+i3OBxtbIhPpK7OzEMgnnS58NEWM8y6NZWLSoLY7yGU9/icPHLJGiRLFWtmSDxTJXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW0pOIri; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a32d36396so5095931fa.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773197059; cv=none;
        d=google.com; s=arc-20240605;
        b=cJ9/LzJMrdk1oSGe1esnn+TsG5GF/K19zd7vvbGelKXvW3df+z55dg/9ykG3+zhMEz
         EBbYCLUB+Sw2xSs9NBRhRaHUT7kxPIimOjI/P03Z1+0U6NEYq+lBhrNDn4Gd4FX59WbQ
         pjzdSQvPqC9amdD49S3pwGB5KDHIWuUiNsfs3XBh9TSF6PZ21My3lm8VNcAZCd6K93m/
         n8GIHuveTxlwvU6dSjfp2waKFXMWDlSsb5GnUkbDRcDzbdDndgwj8Tl+5dGitZ3qWhOb
         2dVPTAb3Qobwm+tT6FRe8xrlkWJvKiT6XEqbnG6mTANmuL+xj0aWx2qr5N/QEbCV8Rwk
         pL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3JD0VC74mLxBvQCagNobJZ17Es9Rvor/QFxHcKAc4PY=;
        fh=iOzaZurc18HmPsvcPtUWMSfsMeVi+CMrJnhPEoYEg74=;
        b=VcBWjTXqui4BpTJHO28rJp7t7CT7rchDKfoh0B9TBaGy7AxcupTMaJzKAqmLsIuWN3
         VaQDYCCr1r5g3HgIDHSkDk1PBE/f0QoTbVnZ9GcYhKy9ezcC4bQ6TSi8M6S8Tt8c5fix
         9tXo6hzWAh1bPx0ZH3Pmi76PjahxYuW2l8LPuBE8nnwHFYaTxxBylr7HgGd63HuN0hf2
         ao8lMqJl8WDA/CUmZuveMWZ2feJI9dlT5MNqu6pHEUmr0HfAzjt8W5Cbkw63XzKYSCqf
         GTW26YYOJeSWWzhx7SkEfmYJHWftvvRTdPXWQQhIRHvI+TLbcwunjk3OjF5LY5GusZ+Y
         gphQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773197059; x=1773801859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3JD0VC74mLxBvQCagNobJZ17Es9Rvor/QFxHcKAc4PY=;
        b=hW0pOIrivUoKBvarvQSHvFc30V2jba3GJ0Qeou35t/ox49itSt9d0uV8GzqhrBRSsu
         SYnHTNWcRqyXMSlBkqBO6+rJCgXUylqcdk/GYvMzM0l23aGYc23sr1gPAfRSYasFSUnQ
         q0H12yqx9fV/rVZRT1g3HG5q/XUDuwUNvKYwJK7Bs8ah2qzKdWh0jcmKtbbc5UhuWet/
         WHiV/JvTC7dyodeOv6hJ/DgcKILxsze1O8/JtaVGAJc8vIZFNNbwfZTk1F/o9PvWKm+7
         u6nHQhE7rPzAHVYQLHYF6i9tlLy1y48jgdmzjguip6Ca5Z/ZaJBOsEhWy83JzK6eYB5s
         Scsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773197059; x=1773801859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JD0VC74mLxBvQCagNobJZ17Es9Rvor/QFxHcKAc4PY=;
        b=tAFEX0h4ajG8WB00mIZmrhSySCVguyY1WsdIxljIoCV22n9hrI/weO9RYH16StuFOx
         rhMdoJtdpdppu91Y4opiHpz3JnqMLry40csCyYBV4NeDybz8EznJCjYb611QLfglyYN5
         5rt3tKsqxh5q0xKsQoKQnmiWIxS/DPJ3ermloOmdvDjqwu7ATCZpk2n9zAwLnFuMXnd9
         IKSfz+M5V0QDtqiB1ws0quKmHkYlLWQJlb1wRGMXzjy6jwDss9L86G8uCX0+jbRxSiFY
         6YjgPQDgLlDbfXB41eHjIXVLtgHYtI75zib/A4+VAYKfOp473BBXuknfSsJTnahM2clE
         typQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9julLig1Gm2PS4pKqTfxYdQOwdV3/cBD/gjhS6ApiWMAfzFHBCV5vR3qUASiynX2jT4Dx1uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLoxIlt9WY4JPfXY0lfRBU0kPc+zb/Vb2Z9ZZs1sjP+zvwL+aw
	aMPG/o/CJxrmZ/up6zqeqmKdd617FQZkvwrOefIDXFiK1p1gKlZ0RM5q/DwnadC17R/R4GYuiNE
	JO5sEwb96gltBFmoE2HfFvRfFrlpnSB8=
X-Gm-Gg: ATEYQzx9XgLCEU7JXxyz41bglr32q8hjXCDJVA42DM5skZzghXJR4Eti1TnKl9spBKf
	TD2CiuSaskugFRsrcpaDvMQVXp5z5vZb9AKDL9qq67RqUwYNtT4PYrgAcfHsZxpsbR6N7crOYgu
	Q59UVzNh5M6Wm/cvfm2RHn6uq3g49QECvZccqa2gtMKXaXbhHEWNhMv/UpC9qZpkRPI3et4hHNV
	QH/Bb+A4LNfohRd/0fNtA/pnsgNy8tlyvWaDyDQXROHS8RG63StqrUfZTF22vpjSWUtF9I2aDi5
	XQHs3PP2Mw==
X-Received: by 2002:a05:651c:210d:b0:38a:4b80:e534 with SMTP id
 38308e7fff4ca-38a67f5ae8dmr2810751fa.3.1773197058383; Tue, 10 Mar 2026
 19:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310151935.33197-1-muchamadcoirulanwar@gmail.com> <917edd8c-cda0-4d35-8300-47205a975a81@lunn.ch>
In-Reply-To: <917edd8c-cda0-4d35-8300-47205a975a81@lunn.ch>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 11 Mar 2026 09:44:06 +0700
X-Gm-Features: AaiRm53tAPWLpPZROu49-q3oM4oJc3tl3njecgh8WGFnl9_yaaODnFwzAHb91iU
Message-ID: <CAO26r3S_zF4CWt1Ms3rwWqR-Rm4FCu4YRCTKVYbtJdmJEnVwQg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: phy: rust: add experimental Davicom PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, ojeda@kernel.org, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CB7F525B17B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266431-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchamadcoirulanwar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Action: no action

Hi Andrew,

Thank you for the response and for reviewing this RFC.

On Tue, Mar 10, 2026 at 10:52 PM Andrew Lunn <andrew@lunn.ch> wrote:
> How good is the QEMU emulation of this PHY? What features does it
> support, compared to the real thing?
>
> Adding support for interrupts to the Rust API seems useful, but does
> the QEMU emulator support it? What emulated board are you using with
> this PHY? Does that board have interrupts wired up? Can you triggering
> interrupts by changing the link state?

I sincerely apologize for the ambiguity in my commit message. There is
actually no specific QEMU emulation for the Davicom PHY. By "verified
via QEMU", I only meant that I booted the compiled `bzImage` in a
generic x86_64 QEMU VM to ensure the module initialization did not
cause any kernel panics or memory issues.

> Does QEMU have the scrambler? What happens if you wrongly configure
> the scrambler.
>
> What does the emulation do if you don't isolate the PHY? Is there an
> errata for this PHY which tells you why it needs isolating?

Because there is no actual hardware emulation, I unfortunately cannot
test these specific hardware behaviors. The logic in this RFC was
strictly a 1:1 blind translation of the existing `davicom.c` to see
where the Rust compiler and current PHY abstractions would stop me.

> I don't want to add code which cannot be tested. Ideally, it should be
> tested on real hardware. We also are pushing back on duplicate C and
> Rust. So if you want to write a Rust PHY driver, i suggest you find
> some hardware which does not have a C driver, and add support for it
> using Rust. Then i would be happy to expand the Rust binding as
> needed.

I completely agree with your policy on untested code and avoiding
C/Rust duplication. My primary goal with this RFC was exactly what you
offered: to highlight the missing bindings (like `config_intr`,
`config_init`, etc.) so the Rust API could be expanded.

I will gladly take your advice, drop this Davicom port, and look for a
new/unsupported PHY chip to write a proper Rust driver for. If you or
the netdev team have any specific upcoming or unsupported PHY chips in
mind that would be a good target for a first Rust driver, please let
me know. I would be more than happy to purchase the hardware and work
on it.

Thanks again for your time and guidance!

Best regards,

Muchamad Coirul Anwar

