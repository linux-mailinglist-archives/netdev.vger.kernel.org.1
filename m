Return-Path: <netdev+bounces-174777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE5A604A0
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0003BDA2D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7C1F791E;
	Thu, 13 Mar 2025 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na28z13R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A531F5608;
	Thu, 13 Mar 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905995; cv=none; b=cayGN52lcrob99WXa/1rhAXIrNW5I627OqJGlhaZDS2nWUE28XzSpQQ0b6mPzThVfrDNNLHE1oF9DOyHs4JzxtMu6XE0n/IUAc6jq/+ooDdkGJPOJT/y0SMthoVdjMcEAhssY2Fv6MHOJSKGG0Y5iIV1xJ5NZdPqhwmnJkN0FuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905995; c=relaxed/simple;
	bh=QOeWgJa3zFHIM7eilY1J0Y00uN0Q8k5nTUHUnDWrk3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdyH8tHFfyBJGVvBDWrHOoDFGQBmJugPOlBOe71jw319RcdaDfZPN0UMVEDGdkJlGML3zd5qQPzKx2Lq5C5m0voxTNCvC6GvYCq4e4fUCOFMIdKPUr3Ej8jjed1f909RP43iVu4DNLV3uc0InDIffg4anjQ1kQRAY2A0LqiADA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na28z13R; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f8657f29so12967756d6.3;
        Thu, 13 Mar 2025 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741905992; x=1742510792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pydKdgNblpGj5h7sZOGmI2zMsvih3t2v6u7UCPYQDt4=;
        b=Na28z13RHHwG8TxXrCEgJB1QzXJuhd8/sRiZxYDOjC8zqz+/9hV1CFqDcMjyIOGpqr
         QVJp47jcVglf3GvgCRXM+hiW9bWtYC5V/wh2h9fMcXy4GZuul8gwArkT7YsDNDkj8Sxx
         MXmTCAdmluH6U+BdZ2d872ShV5RKsKJOjMyhaMM73tRWTrvDr/kGqCuROSrnDOCLwIat
         QRojiVKWcDPQoGOsP845nOt/E7WOilEF6lADee+0u0+N4s3cJNPrC4a6tuLrI2sVGc3b
         NzfUf1sM7p/ZegHWfV0pK4ljDAtNPE5nyTtMZxjWPQDYJVKadB4nTRshsTT+1+E3i/Gp
         0+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741905992; x=1742510792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pydKdgNblpGj5h7sZOGmI2zMsvih3t2v6u7UCPYQDt4=;
        b=FQAf1NWSE17wuo150xuE1xUIVwb1KjG7B9G10tG36ogkuhBjrKqUOC1jItRSJdwjsI
         Vy2OSQC7SXoGFepPtRu/NFFouj9fbzdJEsGWzgsKBdfKAMGwvZfWJ2BBOtO1oaevMjP+
         fZXlP8X9dBh233VLT6l41QkbMazt+nZJuklap3j0tOZi7IkS1xJkhqe9xUsXxMW+LgmL
         QRbbxOdwza5axZLTY/kXHkqCgCezjxbLQwB5LKoeBtsDo0P2w3w8r+qlrh7dmq3lmnaw
         8IUqPJe/o8/sgiOirTZb+VgqfE/49uMj5KtcydYZcMTOKzlzuTQrcBZQ80jQEy0F0KN6
         HOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYC7T3UDtXZ43GFSiezlD+EhNlPgwYIU8XPQ9LHLRWahGtw3BoAdR6NswnHe7Fe3mOuDuybuATuncd@vger.kernel.org, AJvYcCWcQc5zL62iGCLCDufXMd2iYmqOjA2Z4v0Rg7zlmRmM5TpHEYBMvU1QDjJvokYs95oGg96/zEHE@vger.kernel.org, AJvYcCXS+ExQ9M68kILeD4bonqn3uFqFnDm2o34u7TgPJIV8UE8sstJvr8fgMPAeUCrA6F4/KevLa+j7uoN3/mab@vger.kernel.org
X-Gm-Message-State: AOJu0YzCiCjmpRP4/CnzRYe4w0dXsaOtDT56cAyH2slzKNLNt+pFqirV
	hD9+yV30cf3UQr1fMU0rMWywAE536mrSS3AWnejRSC3kNC/FsuNP
X-Gm-Gg: ASbGncshZP2PPR8PT5CddCylk7ygqfZWOtmEaN1kkeddJl+yx9wLr/jLMgW61SWBd2j
	cPxqFqQsbzEdA9UabkfCHN+Y7yzgNX2v8W91OTGe8yDQUfwMCIsNjOdZFY8ow+1DDvu8nw9oQeb
	XEtBWyBh00/dW12vNSgzGE5St/oS+PkJY/Uzmz7mTYpxglA0MpRvCs9lwH8xg0TVhcfvS/nCYoO
	LUDMCRQo3IjUviY6H5nG6VF3ZB6xVngXPGmF5IgO9up/pzPBTUuRbjBIORdA4NEqIg2tBTfcAkP
	6O9nhRXFx1vEe59BAktR
X-Google-Smtp-Source: AGHT+IFqkOHBtuKsF1XowHyy1ib8FDyL6+pkzITiQkL+N8KWE76/yTSNJDscUTJ0dRbwpaXJOoTbcg==
X-Received: by 2002:a05:6214:4009:b0:6e8:f3b0:fa33 with SMTP id 6a1803df08f44-6eaea9ed9e0mr3028786d6.8.1741905992624;
        Thu, 13 Mar 2025 15:46:32 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade208e6bsm14898746d6.1.2025.03.13.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 15:46:32 -0700 (PDT)
Date: Fri, 14 Mar 2025 06:46:22 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: add clock controller
 for SG2044
Message-ID: <txuujicelz5kbcnn3qyihwaspqrdc42z4kmijpwftkxlbofg2w@jsqmwj4lz662>
References: <20250226232320.93791-1-inochiama@gmail.com>
 <20250226232320.93791-2-inochiama@gmail.com>
 <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org>
 <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp>
 <f1d5dc9b8f59b00fa21e8f9f2ac3794b.sboyd@kernel.org>
 <x43v3wn5rp2mkhmmmyjvdo7aov4l7hnus34wjw7snd2zbtzrbh@r5wrvn3kxxwv>
 <b816b3d1f11b4cc2ac3fa563fe5f4784.sboyd@kernel.org>
 <nxvuxo7lsljsir24brvghblk2xlssxkb3mfgx6lbjahmgr4kep@fvpmciimfikg>
 <f5228d559599f0670e6cbf26352bd1f1.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5228d559599f0670e6cbf26352bd1f1.sboyd@kernel.org>

On Thu, Mar 13, 2025 at 01:22:28PM -0700, Stephen Boyd wrote:
> Quoting Inochi Amaoto (2025-03-12 18:08:11)
> > On Wed, Mar 12, 2025 at 04:43:51PM -0700, Stephen Boyd wrote:
> > > Quoting Inochi Amaoto (2025-03-12 16:29:43)
> > > > On Wed, Mar 12, 2025 at 04:14:37PM -0700, Stephen Boyd wrote:
> > > > > Quoting Inochi Amaoto (2025-03-11 16:31:29)
> > > > > > 
> > > > > > > or if that syscon node should just have the #clock-cells property as
> > > > > > > part of the node instead.
> > > > > > 
> > > > > > This is not match the hardware I think. The pll area is on the middle
> > > > > > of the syscon and is hard to be separated as a subdevice of the syscon
> > > > > > or just add  "#clock-cells" to the syscon device. It is better to handle
> > > > > > them in one device/driver. So let the clock device reference it.
> > > > > 
> > > > > This happens all the time. We don't need a syscon for that unless the
> > > > > registers for the pll are both inside the syscon and in the register
> > > > > space 0x50002000. Is that the case? 
> > > > 
> > > > Yes, the clock has two areas, one in the clk controller and one in
> > > > the syscon, the vendor said this design is a heritage from other SoC.
> > > 
> > > My question is more if the PLL clk_ops need to access both the syscon
> > > register range and the clk controller register range. What part of the
> > > PLL clk_ops needs to access the clk controller at 0x50002000?
> > > 
> > 
> > The PLL clk_ops does nothing, but there is an implicit dependency:
> > When the PLL change rate, the mux attached to it must switch to 
> > another source to keep the output clock stable. This is the only
> > thing it needed.
> 
> I haven't looked at the clk_ops in detail (surprise! :) but that sounds
> a lot like the parent of the mux is the PLL and there's some "safe"
> source that is needed temporarily while the PLL is reprogrammed for a
> new rate. Is that right? I recall the notifier is in the driver so this
> sounds like that sort of design.

You are right, this design is like what you say. And this design is 
the reason that I prefer to just reference the syscon node but not
setting the syscon with "#clock-cell".

Regards,
Inochi

