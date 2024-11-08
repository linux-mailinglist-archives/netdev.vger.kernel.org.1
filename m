Return-Path: <netdev+bounces-143233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65589C17B0
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 09:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5ABB23BAF
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7AF1DAC8E;
	Fri,  8 Nov 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5IvwzxA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0A1D63DC
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053940; cv=none; b=RdU2Ym0krkEx2Se5FGn0nZDXwFNOkvHqpoA4p8g+ksqmuAUDrLXKXVHcePN8IILo0x2P3POjFzktlqXN4//QwqiKjoUk6sh5/nxxXrak8ibQEiCr6QWStj7ECjZPMKk+Yxlmm0n2YXxlo+gIAEYgFrTauYzoS2FtByO7u1GodIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053940; c=relaxed/simple;
	bh=U0jdlpjGj9J+texZ51ynRWmquMVsx3tc4YKsZb3IV+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPyKDkVE3KR7OxznGNx5Qji9ZAz+hXLSMQ7Prp/Wamo742U12wZeiB8Ov/VAXyloSQs9GaUBPHu6D0aijGbscoz3r4YRp3nxRS/dW3cVbg86UF24jynqX4FL4rJMldPstytTBD8S5redoapwMDi7+NY9oxFe2PK/48QyW3yK2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5IvwzxA; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so18994611fa.0
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 00:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731053937; x=1731658737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7weDCW+gN74xem4t7h6tdCuTguG0yxU10+YOsux9xyA=;
        b=n5IvwzxAGNKap2gMQtwCcud2t6JCKPl7yXRlFgKD3Zo4EFAIpyxUIiqJumC2MdxhuD
         AtKAvLA+sKPkg71mpTJAKVYDGu6ks9y1gCVrqQHZKaXQmYDfLv9k7O5bdVCwvB6Tp8vp
         EUpJnf0SIjKaaTfSloXgdIYiL30dZCmpsjsschGgd0izjYCDiN26l/63Y7X59AlgqK0N
         oq+gTiQg89Ywv3ZhZ+lTdzU2o+Mqc0Kzd/ixWPqnnbd/v3gdfrcw2q0kj4ip9H8L4BWH
         ZMY6lGuEu3/xwTCI6QLECpQgZitoe4F8Mw81MwIfySU0uFSY1Db7ktiIeUOL/QXOq5Hl
         RyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053937; x=1731658737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7weDCW+gN74xem4t7h6tdCuTguG0yxU10+YOsux9xyA=;
        b=eu2WiOImvsaLpWk0zePUB2j5dEXAl/9BjElSR7u0vCt9MoxEgLCdizuSLgv3+9n0Zp
         Otg41a6jk16i4JyjqLFOPKz/klkgqDcCrbYIs1YGT0A2mGTNbFAHRLgKqpeTgJjD3jFc
         8KaefUUWJeup/GazZUcaUAMaOeq4RwCtWjWt24m1n1Hsri3F0F7lp/RNX4NTXb3Ns2TU
         VAod6kPThqD1B27v5xhxB2YyISSCzlBBNL9nt/Kc0tVoc5Yql1+M8ubA0g7T/mn9BzEg
         uGE2uoxYSQIRkTd67pm9xeN5+A4AR6Priqdfxn3wioduI4RYRwxM1biRc5VNuYiMOT/v
         KCAg==
X-Forwarded-Encrypted: i=1; AJvYcCX1xpOppMoMEfYv2ppSxwwZ02jY5UlOO3lRwpZ89aWgpCuc3t1QGlQbx5fTZbaTfIvw+pT/yBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjt95To9BkiQOrysCdtHj30SJQjPO7aPfskldr5YcNOZ7ExXc
	0uPHwbkFTTBrOH66skyl2bt7ZDJ0+70LJqtFggTwJZdkcCTbYSTaGrcGxzz5NP3Mp9e8G3MlHH0
	aQaGG+EkSCWVOzjtNVP36+e+tKw3+ESr+l2I22A==
X-Google-Smtp-Source: AGHT+IHCIxuHEoVE8+BFhK198XyG/6aUMFHKEpPKf+uJvRzG/l802RGWVl7otTIHAYFAGrY/bbYUdRjkiACDFEhl8zE=
X-Received: by 2002:a2e:a914:0:b0:2ff:191d:f077 with SMTP id
 38308e7fff4ca-2ff200809a3mr9758101fa.0.1731053936611; Fri, 08 Nov 2024
 00:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410301531.7Vr9UkCn-lkp@intel.com>
In-Reply-To: <202410301531.7Vr9UkCn-lkp@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:18:45 +0100
Message-ID: <CACRpkdbW5kheaWPzKip9ucEwK2uv+Cmf5SwT1necfa3Ynct6Ag@mail.gmail.com>
Subject: Re: drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
To: kernel test robot <lkp@intel.com>, 
	"linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, netdev <netdev@vger.kernel.org>
Cc: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:05=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   c1e939a21eb111a6d6067b38e8e04b8809b64c4e
> commit: b28d1ccf921a4333be14017d82066386d419e638 powerpc/io: Expect immut=
able pointer in virt_to_phys() prototype

Ugh Stanislav do you have ideas around this one?

>    drivers/net/ethernet/freescale/ucc_geth.c:244:21: sparse:     got rest=
ricted __be32 [noderef] __iomem *
>    drivers/net/ethernet/freescale/ucc_geth.c:405:22: sparse: sparse: inco=
rrect type in argument 1 (different base types) @@     expected unsigned sh=
ort volatile [noderef] [usertype] __iomem *addr @@     got restricted __be1=
6 [noderef] [usertype] __iomem * @@

They all look the same, it's from this:

static void set_mac_addr(__be16 __iomem *reg, u8 *mac)
{
    out_be16(&reg[0], ((u16)mac[5] << 8) | mac[4]);
    out_be16(&reg[1], ((u16)mac[3] << 8) | mac[2]);
    out_be16(&reg[2], ((u16)mac[1] << 8) | mac[0]);
}

Is it simply that we need a paranthesis extra around the thing casted
to (u16) else it becomes u32?

I.e. change:

out_be16(&reg[0], ((u16)mac[5] << 8) | mac[4]);

to:

out_be16(&reg[0], ((u16)(mac[5] << 8) | mac[4]));

everywhere in this driver?

In that case it's a straight-forward fix (and the code is buggy to begin wi=
th).

Yours,
Linus Walleij

