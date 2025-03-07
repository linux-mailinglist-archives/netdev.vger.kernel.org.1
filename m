Return-Path: <netdev+bounces-172729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D189A55D0B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70E716435F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E014EC62;
	Fri,  7 Mar 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeoOWRJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2627464;
	Fri,  7 Mar 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310408; cv=none; b=frIBXncMhHcl72AYlma3sNELY+Uh+lQkYTH6CvrI8K6VDntOh/FzsFQPzJ1slOfEyvZFXXjHDEcTi9d2IM7Nklsmo3CmrO0DXrIQDdXotABzC6/0ANpk3rIhCGM7Xc3XhRiPlOJp1GV6g5BP9TCxYsn1A9F3Gu02q7fGG5XMBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310408; c=relaxed/simple;
	bh=8GcQhSv2jnHrui9KgDgnUkx3PYLViq3+B67GwCjUl50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS4KIj0uxF/UqbO8r8MqX2CfGkYdf7/bfXWE4T67wpbppEJf20PNhs3m7Po1LorCLcNYeJ7WWfQld1/NlVi3S75w/BlNNa6OcGpSyyHB1Xzyj5dHTIkPaV0/KfHrvgj4g+Dacah8S0lk+DeHreMWp7/ic1tO40YwrhcxQDZoADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeoOWRJj; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3b63dfebfso143842685a.3;
        Thu, 06 Mar 2025 17:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741310404; x=1741915204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxS+VSdF+25Ta0OPbr+oK1VDaaV8dgOLYKtTqCm4wmA=;
        b=UeoOWRJjMylrpGydI+xqwh7pqnMaYb+HXNcCmUCEajSFAazB206UgWrXJE2YhaIH0m
         SjU5jty+E7DxAj51Gxt3vLy7zs0ibaePM4/2UomfE7+sy+bp2eiNcAPxPRV8Bl6ZuUNt
         rtG8FSXEnxZYYncFCtioGWnf3rZuXh8QwbviYe1+8M0L6T4In+tRSqE5QXvJBvVzmxp3
         2T2QnUjWddfDoZfIgcujBkf1D3bxT2QLMxD92RYxQExz0lwXHvQdI3JFSx1p+l4Dtvwt
         aEaMlYuI/5iyfDc6cIik+g6hTIhM87LXH7OCbjJMImfA3BpgCEaM/YXhREEPQcr9K11X
         3nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741310404; x=1741915204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxS+VSdF+25Ta0OPbr+oK1VDaaV8dgOLYKtTqCm4wmA=;
        b=sMvRDPVPu5mRUy8Qfuq0F+B29Xe3tKFg81PJUJ9F6G3H03Pg2brpRe8nCFxZzHvhVF
         yO2cbNieyO08Zi3wcfYI4TLoKtfERGj0SrDGY35t6Xwn+nxzIJL1P9+2PWJoMRZEuSnO
         hJmZZFqNcDXKK8SjYUOa1VYyahN9hxm0EYPxwMIeyx5ccJ5Tp4CjDnOVxTwlp7RB5mZG
         SFxs4OvwCFPVLegdpT0MLz8k2yZn61rQbK6T/GnBdU61zILp1bPztFp7eTaYxL8F4BLv
         AZ2kAoy8xuWbAEKmAokdJQZ5nzR0gyNT8gOi//Ad+1yC9Yrg1th5w9OzoGHuF63qA6V9
         EuDg==
X-Forwarded-Encrypted: i=1; AJvYcCU9JJTczlGR7Q4O5wTR4DN0sH/E8EPNZEUqZ2bbYNBLFH0ocCPC7IoRLj6BJy7YfyHf5DihEPk/@vger.kernel.org, AJvYcCUMJG9QgTX1jgFuYGu0jxqjndJ9szTPb0L2dorh/RKDZfML2yqLy5VpQNsy8BxJdXr04Fl87h76qBck@vger.kernel.org, AJvYcCWZ58XDJ4DmUsM056b0QL0R9McJ7y9BqYL0flmws4z1sq9YhzJKXTuVdiXeW0xvbBmsNhM4onIZSy1vekwq@vger.kernel.org
X-Gm-Message-State: AOJu0YwTnngnKpPiDlwiXXsV3wrvL3UYZt0ImNOFcMTw71Eu59OPweiS
	vfdkGTopwB/Jo6GQuBqXmQ1v5hy6OFQFeqx9gVMfH8pCPOblTl3z
X-Gm-Gg: ASbGncsFXrYpVT6vChoN4kfGGMmAxphVxzjsE1hXe/p2GpxmNB0w5Eq/q1KFA84lb89
	x5e0Q5tIIzekLUrEe/9ACCTdZL0cmb5msH34x2QcPBOTvrkq+ccyyDens8EGsL08EokMnBqkl/f
	+W/Pse8sLaMjkknrMq93Mn4/dyiy+z0BrR7Ho/Vg1FR7C7665nxkEfBt0QPyKG6rEH0bSqHqJHq
	TvyY2ryRHA0WT0v9xzN1davU7fNf4jg7QsaPkjSDdjmHoVcOL4qOtyzxW+XplORdsDD8TItcYwm
	339vs8vdCdXdTJG7eYSe
X-Google-Smtp-Source: AGHT+IGUO6/phCwAva8wDxFUHQEGREx4oP4CpMn1qmy+ZBLZmOEMjsqOLMniC66oleMf4LpqVxo2lw==
X-Received: by 2002:a05:620a:838c:b0:7c0:a0ba:2029 with SMTP id af79cd13be357-7c4e6178ce4mr254618085a.40.1741310404496;
        Thu, 06 Mar 2025 17:20:04 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e551181dsm164602585a.110.2025.03.06.17.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:20:04 -0800 (PST)
Date: Fri, 7 Mar 2025 09:20:00 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Romain Gantois <romain.gantois@bootlin.com>, 
	Hariprasad Kelam <hkelam@marvell.com>, Jisheng Zhang <jszhang@kernel.org>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
	Simon Horman <horms@kernel.org>, Furong Xu <0x1207@gmail.com>, 
	Lothar Rubusch <l.rubusch@gmail.com>, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v6 0/4] riscv: sophgo: Add ethernet support for
 SG2044
Message-ID: <w7p3jnevmwumcblrkbpot7wpvajgf6enwpl4db5rbme4322hej@mxm54kytlguy>
References: <20250305063920.803601-1-inochiama@gmail.com>
 <20250306165931.7ffefe3a@kernel.org>
 <ptq4ujomkffgpizhikejfjjbjcg44vyzw4pwbs7kureqqndy6e@alxgdc3qkm7q>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ptq4ujomkffgpizhikejfjjbjcg44vyzw4pwbs7kureqqndy6e@alxgdc3qkm7q>

On Fri, Mar 07, 2025 at 09:12:33AM +0800, Inochi Amaoto wrote:
> On Thu, Mar 06, 2025 at 04:59:31PM -0800, Jakub Kicinski wrote:
> > On Wed,  5 Mar 2025 14:39:12 +0800 Inochi Amaoto wrote:
> > > The ethernet controller of SG2044 is Synopsys DesignWare IP with
> > > custom clock. Add glue layer for it.
> > 
> > Looks like we have a conflict on the binding, could you rebase
> > against latest net-next/main and repost?
> > -- 
> > pw-bot: cr
> 
> Yeah, I see a auto merge when cherry-pick here. I will send a
> new version for it.
> 

Here is the new version:
https://lore.kernel.org/netdev/20250307011623.440792-1-inochiama@gmail.com/

Regards,
Inochi

