Return-Path: <netdev+bounces-170358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813BAA484F0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7973AE837
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF481AF0B0;
	Thu, 27 Feb 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZHaI9M9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0D1ADFE4
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673499; cv=none; b=I/XI8VX9zQZrLBg5RwpegOjbjRgEewQKtdflxaOJHjrdRXKfWTqQxEVMJaDtHb7PblgLyEEPh4n7u4FQcIXSzjoBvHnBszY8PsJLQ0EfDfDbkHmMX/Pu2vBpqvfdybd2Orf813Zm+2EyRKIevpRmcbeLKWOBHMov4t25SHKBvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673499; c=relaxed/simple;
	bh=nqzsX9lgGrAsUBBb+N0y4WfOs5zr7BrMzaelAUe7PMA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BZLGMIs6hE7D/dnN/epzCmfASU/d1SOZTBREZKavtFWC9QjMEznGWP0gmH98+zu2zAOH3cIYGl4In9WiDwSO9GW9ajslzdq4r5CQN0zJupACPCl55BCakWMyeKD57mBEo2AyVISym2+R+evb+BwEr0wy1wPqGWVjGr3Zr2HUogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZHaI9M9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5454f00fc8dso1048104e87.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740673496; x=1741278296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJycCnYja/TKtLCwbFEAQQZMIJXGBqyhy/fIXPm5a6w=;
        b=CZHaI9M9HBg8ygN88ggYvrHGswPdfoW6VoZ11L2zJJyStdokXZW8b4Yad+3AQPDwiS
         x2LcrvL7pasYdSPp7+jrDyozLAuAwQpWWcP+3ILcJi6kYvc57+wVVm9xK/ohIjAVAS4U
         ScLoNtEwlArKCJyaseKzleBbu8rh8DqwZPZ9VNDSk0JozuOC5xrkWB6ZuuGjfPzritKc
         wH7knEwM7KkIYxTHnPQyUduTG/peXfxZ89+h+5aLSVcknkrfE3K0SsfITRwU1vorEgkP
         ZCRatT8rBfQzOi27c/vN3ZilTcqKK5ZT+tI2BsHs7u2bzepf8H+h3hof5r6p/FKj1/79
         jkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673496; x=1741278296;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJycCnYja/TKtLCwbFEAQQZMIJXGBqyhy/fIXPm5a6w=;
        b=j00veqPnbEwxazEatfzuw78C4gCPJKFRGbdAdKB/2sEdf5Pdy0wif7S2zodKnJkxio
         oKEBwRGrjsNbsmPo+DrAPZMt6s57T6OJXFKza4AtytLsmF0Dd3GYMl96XBmsg9KzNJ/l
         YpdX0WGpad48KqH75wOoZd95VnbyiyuEx4Kmc0ghSCJwmiBtDzKi0IeAdfzStipY4d5z
         yFxvJyPsYtKZae+Sytt2nD4S3uMdFBO9OGS+IkxKijYdG/aqiqvqK2n+xJ6cck+vOQeU
         oI9yrB54mKUHNpUYyvWeqIfgCEMnTspoecQnUNweSeUMgmlkRBYGqQI09UYF/0+8PA6m
         6Wcw==
X-Forwarded-Encrypted: i=1; AJvYcCUGVsbt15Z4gpE0500GSPw7zHEt0AvqJSHQCXB+4H44hd5qL5rXE/T8Y52wEAaEOllBYPBDWsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3g8+08YExCZ5TTBwKSDL8DIoxzdzQ/mCvVaST35M9ZqTmKug
	bFivbNlAcWV8AKfgxwMIgRgfK1zy3XzgMgSvpN/WLVIXt6D0Iqib
X-Gm-Gg: ASbGncvXUgNk6hpJjmUZcmWYWf/Y7xTWED65tPN9bkBQQ40vqhDLvf5iZfWjtTzbBT9
	ztZJs++Vr0tJPAFXcl/4vl7x41d6BIeZVfGKBeFggCF5RpAsY2m2i2V95CEj4IwVH7o+zBkh93c
	pzJ5jYyXyBq5Hovq8cmqLCwB1Wt3XLqflfUuYK8B3mrofB6AWapdV+vYITXrp1r2a8AM40geWWU
	yIX/g9EGjbi5X1h/FYgMKp0bVDy9lAyn0G0J/XelsArL1cj4PcgutHGdJ6BkNcc77YvDoSJFO8b
	au7jCy6Ucd75uotLy6e2RMulIzWdRb6maHcWPiOIGwAJuGEBxlPdVqA9eFwhOwUxumbktFSRwqB
	tLmlEx5SzFpBYVg==
X-Google-Smtp-Source: AGHT+IGrZudmX2AN/o1bZ4NroWR2krrjNPqQ+YeWKqQOTxwAEOo+p9RjfW3Lkhrp6PUvmlTV2yiMuQ==
X-Received: by 2002:a05:6512:3f02:b0:545:154:52b0 with SMTP id 2adb3069b0e04-5494c328f47mr14225e87.22.1740673494652;
        Thu, 27 Feb 2025 08:24:54 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443be977sm204033e87.199.2025.02.27.08.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:24:54 -0800 (PST)
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context exists
 in case of context 0
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20250225071348.509432-1-gal@nvidia.com>
 <20250225170128.590baea1@kernel.org>
 <8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
 <20250226182717.0bead94b@kernel.org> <20250226204503.77010912@kernel.org>
 <275696e3-b2dd-3000-1d7b-633fff4748f0@gmail.com>
 <20250227072933.5bbb4e2c@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c034259f-ec9a-2e78-1fc0-f16981cd4e54@gmail.com>
Date: Thu, 27 Feb 2025 16:24:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250227072933.5bbb4e2c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 27/02/2025 15:29, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 15:18:47 +0000 Edward Cree wrote:
>> On 27/02/2025 04:45, Jakub Kicinski wrote:
>>> The ordering guarantees of ntuple filters are a bit unclear.
>>> My understanding was that first match terminates the search,
>>> actually, so your example wouldn't work :S  
>>
>> My understanding is that in most ntuple implementations more-
>>  specific filters override less-specific ones, in which case
>>  Gal's setup would work.
> 
> The behavior of partially overlapping rules being undefined?

In the general case yes; for our implementation I think there's
 a total order of match masks defined by firmware that extends
 the partial order from the subset relation.  (Unlike our MAE
 implementation for *TC* rules on ef100, where it really is
 undefined.)

> I never uttered the thought that lead me to opposing. 
> ctx 0 is a poor man's pass / accept. If someone needs a pass we should
> add an explicit "action pass".

To me 'pass' is just a shorthand for whatever specific behaviour
 happens to match the default.  I.e. if you can already express
 that behaviour directly, then 'pass' is a strictly nonorthogonal
 addition and therefore bad interface design.
But then, I'm the guy who thinks ed(1) is a good UI, so...

> Or am I missing something magical that
> ctx 0 would do that's not 100% the same as pass (modulo the queue
> offset)?

Nothing comes to mind.

> Using ctx 0 as implicit pass is a very easy thing to miss
> for driver developers.

I don't see why drivers need anything special to handle "0 is
 pass".  They need to handle "0 isn't in the xarray" (so map it
 to the default HW context), which I suppose we ought to call out
 explicitly in the struct ethtool_rxnfc kdoc if we're going to
 continue allowing it, but it's not the fact that it's "an
 implicit pass" that makes this necessary.  If there's something
 I'm missing here please educate me :)

