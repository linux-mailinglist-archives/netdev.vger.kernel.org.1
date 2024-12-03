Return-Path: <netdev+bounces-148339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69039E12DD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 06:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3A81616AF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 05:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7614F136;
	Tue,  3 Dec 2024 05:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbTYAUiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DB6FC3
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733203777; cv=none; b=lJlKwy9Exj3z6BoHjL16A+bTAz9KEA0Q5t+ZWiB3+NRmtwTu8dt3kkkDU6iL+vuRTB766pdLIlXMAEVgw7cAW6jDiv84OuQFfO1/1uJIE0FxuGZMNLKhQII9U99cGHrwVIkmCmMIJcPWisIzx66Vc1ZrvfdJ3epIS0EPylQ606M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733203777; c=relaxed/simple;
	bh=FA6Nfg4fs5uLTpeu4+b3cT5wm9C4CDYUlnGf6KIR8eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9k/dNHHyqAopQc70P3uuoO+Unhd/HhS/5ISwhCxKkCpHbML3CUMMkuH3bY7+FiCtE3jJ/dDK0tpBnvDL9876qi7z0u1Yu/NmSj5+U8CPDN4CWv5c9BZ/bHadGZ8/HekY+z8aRwIe3QvgoorLpN4Aucq0unfN+4a4xXcG9Da++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbTYAUiR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385f4a4093eso1152286f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 21:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733203774; x=1733808574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wXTpISMFcwIPKkx5X18bnSk9A1B4eCMKM721t2SrdJE=;
        b=TbTYAUiRbR95nPHbxZmIuLuP6TVwSA21j4c+cROoCHv+tr5jCB3AogkTqpvVt6hW4b
         Up2cQ4Ib2WKb5Cwonwyal7UoPxGAwqEtO/H2idF8A06xj15JTSUt/RmA9C3Bev1uhJCW
         +nqMPxJXrYEha8MT3fYDX48j0A/hJ6iGCRztO3nZhnmSqAj1Dax70P4Kz8WfdzfmFIRz
         jd6CczlkmIjVPIAADcGhsCPLRIzX+u1Z1Ug3fl/SAEtBxEg6iPxhlQH3BQibhQwRvbHg
         ukrBA2+gfVbeUBTk3L88mWHIieLR3n7xyu2iJ6mcgcVLRl4KJs+dQaBEsV56rLU3JzwE
         iqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733203774; x=1733808574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXTpISMFcwIPKkx5X18bnSk9A1B4eCMKM721t2SrdJE=;
        b=LZvySda85gPMwQKdnwWeyaotYdjKksF+r8upkV14pXy8OHb5IyN/LoWrEU079Z0dnk
         boRgzNmiG5YeaixKlWk2cPwErBYb9SvCLMYB8zBzVEhW7upIGbLjNFZQ4tTPWdzg3qDY
         ai0udOP5Hht5h2mkfrO8qXnalM6ZyDPbrHRJ/PckVsPgCJCs/Nm9QfspKKKC7V9vLMDt
         7h+YmTSl6zSFZ2pMQqsx2TQuTWI53PU32x6pjWqGv2aUzoYCb9cz+0nFkwgLI2ID26qs
         lcXii82DllRhKmpb36IYzPMhlEQ2Rpj2FYIBnffCMgty13NRO0xfj8fo2+E++slyMIOW
         BGRw==
X-Gm-Message-State: AOJu0YwPofh5zUr0lqCTKwM+mgiopLdeLEev7Hvg50wKo1mnNwGBVsh/
	v9UGFywhnhRTALfC2A3h2PXTbKYnQ0HYSOkFmutZMeTt74kLW02F6wURVnegYPYOn5+O+zLQF5G
	2lc2q4qkSRmnXE/r9Zzw1NfjoPl8=
X-Gm-Gg: ASbGncuJPuk8UMTfXghTnJ0bL3fwSnRzHrM9tYdqcCVaWL+0FkrJlbr4JLOWjpXIuqS
	2jwWAUmWjURUfCWNgfRv0MRabxb58A1iD
X-Google-Smtp-Source: AGHT+IHTL7oh/xbX/aI4Erdg5ljKkLfvsM1UWSyh8h1maWNMwB+lXvJ3KQvK1ia9j0sk5+HyLwJBw1RRzj5rZwRem1c=
X-Received: by 2002:a05:6000:1565:b0:385:f220:f789 with SMTP id
 ffacd0b85a97d-385fd42cb8fmr766185f8f.48.1733203773803; Mon, 02 Dec 2024
 21:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127221129.46155-1-jesse.vangavere@scioteq.com> <20241130140659.4518f4a3@kernel.org>
In-Reply-To: <20241130140659.4518f4a3@kernel.org>
From: Jesse Van Gavere <jesseevg@gmail.com>
Date: Tue, 3 Dec 2024 06:29:21 +0100
Message-ID: <CAMdwsN99s2C=qvxEO=hmpRfvjRH6E7tww0Mfp-Q044ufi8Rn-w@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: KSZ9896 register regmap alignment to
 32 bit boundaries
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com, 
	Jesse Van Gavere <jesse.vangavere@scioteq.com>, Tristram.Ha@microchip.com
Content-Type: text/plain; charset="UTF-8"

Hello Jakub, all,

Op za 30 nov 2024 om 23:07 schreef Jakub Kicinski <kuba@kernel.org>:
>
> On Wed, 27 Nov 2024 23:11:29 +0100 Jesse Van Gavere wrote:
> > Commit (SHA1: 8d7ae22ae9f8c8a4407f8e993df64440bdbd0cee) fixed this issue
> > for the KSZ9477 by adjusting the regmap ranges.
>
> The correct format for referring to other commits in Linux kernel is:
>  %h (\"%s\")
> IOW:
>
>  Commit 8d7ae22ae9f8 ("net: dsa: microchip: KSZ9477 register regmap
>  alignment to 32 bit boundaries") fixed this issue...
>
> > The same issue presents itself on the KSZ9896 regs and is fixed with
> > the same regmap range modification.
>
> Could you explain the impact? What will not work / break without this
> change? Please add a Fixes tag indicating where buggy code was added
> to make sure backporters know how far to backport.
Will do, still learning the ropes of contributing, thanks for the feedback!
> --
> pw-bot: cr

What do you think I preferably do to account for Tristram's feedback
in my next patch?
Should I incorporate it as-is, keep my patch with requested changes,
or perhaps even "fix" it with below suggestion across all registers
sets?
> The port address range 0x#100-0x#13F just maps to the PHY registers 0-31,
> so it can be simply one single regmap_reg_range(0x1100, 0x113f) instead
> of many.  I suggest using regmap_reg_range(0x1100, 0x111f) and
> regmap_reg_range(0x1120, 0x113f) to remind people the high range address
> needs special handling.

> I also do not know why those _register_set are not enforced across all
> KSZ9897 related switches.

Best regards,
Jesse

