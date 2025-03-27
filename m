Return-Path: <netdev+bounces-178038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A517A74123
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E6D1895B8F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241631DF251;
	Thu, 27 Mar 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig9SoCK0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D8F1B6D08;
	Thu, 27 Mar 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115804; cv=none; b=jgj+e9amiDPfQH52d65k5AMMN/pA/ItCl50W3USzJEzPR7C6j5B9vHsdDNLlWEdHDuC2EclT4/T1OQPcGjWu8ZwfumvAMYTDVziH87kfE7UlnkKQ00dHrAezSdcVhHDCGxWLZsXaFIQzKVkLT4U7+Hc1SmjFd/AUufe5/Q2ivQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115804; c=relaxed/simple;
	bh=aNgKSZOvnwquGNkjEd+Rl/oUTq2Kr+uyVduD5vXxrtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ9ch8vr4dyw6g/5JeLGHs7dzyrcYXOOON5yGu659JaORl+pF4nrkF3RC3Gl1APzwVoLT8BXu0xnnDzm8FwZugujqDUFgYvAK/3ggCi4PHOMX0rhfasc29bY681cuCk4XHvwbOmiQMEgwiE45NB/1RkCJelcnffd9htDGOVnDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig9SoCK0; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso12829406d6.1;
        Thu, 27 Mar 2025 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743115801; x=1743720601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lgInEmn9kAXfLfJ08wUUe6niWuQHdC4fBten3a0reo=;
        b=Ig9SoCK0IqTVM9guRAxSuPCth9bBehAxhtT6Pn9VgPGtdbBguTUhQA+bvIGjqHHOvT
         V39pdO3MTqzGt8mu8FoxAOBsAVO054auzS2vVOReLGIP19hRQhuM7PmZp2w/eAkSUTs8
         ovSaitXgSSmkHZHOtou59Gjsy3uuMhxMFXR7WguYGwuUuj4wZZM5djnnwHuW3E5C2XvF
         9HwpfD3unMXX05C6wKd9Lc7HrOJoypvhb1seyUB7T1WwRuk96RFeatCGApYBhm8+r5fh
         RPwBoKpP+RvbcCs6jfSz2bL68b2RF3TsbOhTk5DxV9Rq6EnwQdfakudux+ir7BYsuKkP
         a8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115801; x=1743720601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lgInEmn9kAXfLfJ08wUUe6niWuQHdC4fBten3a0reo=;
        b=AAa8NutMwXWyIW8FpzVZ6fXfyL8/dzCDizbQQ7J7bfZupBOB9lzRucSL25Ssvor1it
         3umJq8aaTzBkqPug/Sww/aeVpv1dhYwD2OurGrN1tXWRUFz639QF3ZVttQOhW7IeAsEM
         +7ySFfSwWcBEjaXFOi8uGARVl3kUlm7OJHPDuMdvwmgGS5wkcmVLMv9pJZdHIqGzIVsF
         PCKaFn3pTggLyNhLb1OLE1QGkgywO+/KRDrkgPadyq+VRxxqpKmAh7VqavnVoRozYZK6
         xQRiH60oKwoIKUoUa+JWzseDF7BNhzKztWXe/2nP+fU1cdnGRMgzY1OiPvkeKJwGvm+j
         EM1g==
X-Forwarded-Encrypted: i=1; AJvYcCUjmxrrKnxCV6MUp1WmaVTppVAUilMXxO/B7MiZ2rvqla4kgCi9X3OmRSLfKMEmGgyAxLsc7Eor@vger.kernel.org, AJvYcCX0WxkaUsz/hFbb2J8FSEJD+Khz3v761GiSE9DBnFzZq4t05fa+/X2fb9S8Fhz9irSpHPI3k025wZovfz3u@vger.kernel.org, AJvYcCXa48VSkh9TRs3upUh7wSVyMwVdvrW9OKCuibueGP/yU09pvRqSyHQ9srqnloNNrQbIQcve8gnBhWOF@vger.kernel.org
X-Gm-Message-State: AOJu0YxgIZHzeEjyycT4fpgHtQwL07OBKJWZPpCOwqXR+oBYYmxcmXwL
	4L2THW5A2/i+yHWekIpstIPSWVrmG4jDAzz9ZFYKymtIJmE68dVC
X-Gm-Gg: ASbGncvijBbNCjZYxOpbX1aNsVB8FS/vMTMWCzMuIxi1bPqgs+tDMWhHlWjsZ4BQ1Ro
	rGzzIwJSHswjc8pd8CPDRBw3MNrEnBhotmewnYCRSI4sYUzT9GyPy/f3eun85eNvY4T2tsAPw/n
	neQVyIFSNcje4xGaKDUVsPNzOfjHPT6VoBui9h8G8VgZFryc6RO+WJYh5itQ4ER0NN7l79URJGl
	RT6Ft59ZE2wzM/EuSjlaktAFcXNnND/Tq9ilZfLsCGdXxWS6Lvxy5D0Mh4Sg4MpxG0JO+/hj599
	ZbjY6CcnDZ4l9dwV1QC+
X-Google-Smtp-Source: AGHT+IFGejPOWFa2kBeHBJnYYEtxpzTLMl4bpzMZ4nBGvC5E46HMYYnjk1nRZveE5zQwgNH6S+BLxA==
X-Received: by 2002:a05:6214:4002:b0:6e6:61a5:aa57 with SMTP id 6a1803df08f44-6ed23877f15mr84640566d6.14.1743115801133;
        Thu, 27 Mar 2025 15:50:01 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5f7682d9fsm41761185a.36.2025.03.27.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 15:50:00 -0700 (PDT)
Date: Fri, 28 Mar 2025 06:49:35 +0800
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
Message-ID: <an3mkqgwpq32bfab7i4bmbrwejluzbxnfiygjxt3rkxmow456v@5kz6qltekbia>
References: <20250226232320.93791-2-inochiama@gmail.com>
 <2c00c1fba1cd8115205efe265b7f1926.sboyd@kernel.org>
 <epnv7fp3s3osyxbqa6tpgbuxdcowahda6wwvflnip65tjysjig@3at3yqp2o3vp>
 <f1d5dc9b8f59b00fa21e8f9f2ac3794b.sboyd@kernel.org>
 <x43v3wn5rp2mkhmmmyjvdo7aov4l7hnus34wjw7snd2zbtzrbh@r5wrvn3kxxwv>
 <b816b3d1f11b4cc2ac3fa563fe5f4784.sboyd@kernel.org>
 <nxvuxo7lsljsir24brvghblk2xlssxkb3mfgx6lbjahmgr4kep@fvpmciimfikg>
 <f5228d559599f0670e6cbf26352bd1f1.sboyd@kernel.org>
 <txuujicelz5kbcnn3qyihwaspqrdc42z4kmijpwftkxlbofg2w@jsqmwj4lz662>
 <a9626bfa7a481cee3178f3aa80721520@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9626bfa7a481cee3178f3aa80721520@kernel.org>

On Thu, Mar 27, 2025 at 02:21:55PM -0700, Stephen Boyd wrote:
> Quoting Inochi Amaoto (2025-03-13 15:46:22)
> > On Thu, Mar 13, 2025 at 01:22:28PM -0700, Stephen Boyd wrote:
> > > Quoting Inochi Amaoto (2025-03-12 18:08:11)
> > > > On Wed, Mar 12, 2025 at 04:43:51PM -0700, Stephen Boyd wrote:
> > > > > Quoting Inochi Amaoto (2025-03-12 16:29:43)
> > > > > > On Wed, Mar 12, 2025 at 04:14:37PM -0700, Stephen Boyd wrote:
> > > > > > > Quoting Inochi Amaoto (2025-03-11 16:31:29)
> > > > > > > > 
> > > > > > > > > or if that syscon node should just have the #clock-cells property as
> > > > > > > > > part of the node instead.
> > > > > > > > 
> > > > > > > > This is not match the hardware I think. The pll area is on the middle
> > > > > > > > of the syscon and is hard to be separated as a subdevice of the syscon
> > > > > > > > or just add  "#clock-cells" to the syscon device. It is better to handle
> > > > > > > > them in one device/driver. So let the clock device reference it.
> > > > > > > 
> > > > > > > This happens all the time. We don't need a syscon for that unless the
> > > > > > > registers for the pll are both inside the syscon and in the register
> > > > > > > space 0x50002000. Is that the case? 
> > > > > > 
> > > > > > Yes, the clock has two areas, one in the clk controller and one in
> > > > > > the syscon, the vendor said this design is a heritage from other SoC.
> > > > > 
> > > > > My question is more if the PLL clk_ops need to access both the syscon
> > > > > register range and the clk controller register range. What part of the
> > > > > PLL clk_ops needs to access the clk controller at 0x50002000?
> > > > > 
> > > > 
> > > > The PLL clk_ops does nothing, but there is an implicit dependency:
> > > > When the PLL change rate, the mux attached to it must switch to 
> > > > another source to keep the output clock stable. This is the only
> > > > thing it needed.
> > > 
> > > I haven't looked at the clk_ops in detail (surprise! :) but that sounds
> > > a lot like the parent of the mux is the PLL and there's some "safe"
> > > source that is needed temporarily while the PLL is reprogrammed for a
> > > new rate. Is that right? I recall the notifier is in the driver so this
> > > sounds like that sort of design.
> > 
> > You are right, this design is like what you say. And this design is 
> > the reason that I prefer to just reference the syscon node but not
> > setting the syscon with "#clock-cell".
> > 
> 
> I don't see why a syscon phandle is preferred over #clock-cells. This
> temporary parent is still a clk, right? 

Yeah, it is true.

> In my opinion syscon should never be used. It signals that we lack a 
> proper framework in the kernel to handle something. Even in the 
> "miscellaneous" register range sort of design, we can say that this
> grab bag of registers is exposing resources like clks or gpios, etc. 
> as a one off sort of thing because it was too late to change other
> hardware blocks.

This is right, the syscon is not very good to be added. And I found
mfd framework is used in most case to provide multi-function. So I
think I make a mistake in design. I will try your advice and submit
a new version for it. Thanks for your kindly explanation.

Regards,
Inochi

