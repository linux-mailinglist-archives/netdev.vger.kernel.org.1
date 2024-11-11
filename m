Return-Path: <netdev+bounces-143711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC799C3C65
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A40B23A06
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F56143C72;
	Mon, 11 Nov 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwu4LHr0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABB156C52
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322072; cv=none; b=Qgqw1JO+A0I0Fvk518wKieDutLMG/4ppMtRAiASxSVb8bTydxzvLwxbJI2p8tRLamNR/elGdu7SpCAKmoy2O0phYod8FedgeVfEepNoc0eb1pgE1BT8ZK4RYgVtn5oYi4SJqZhyFWuqpAj7W1wBigT130jCAOms+pfqhwbpx+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322072; c=relaxed/simple;
	bh=uc1vt82iawRNskqRI/ggiVTpA8k8GCGlCr6IJdTEmxE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NZMagic4Yy0zK5W2v3wa2Q5lQPBj/Q3gsU21Tdj71pGXXsnJaaHzt/jEbcVoGRx/xuFDLUXHomzjamcacKO8tf1HMQ3rgC4vtpIe96SIZiuOp+lgr32ncMh1VgHvTY8nqC+fhMSAwMJBCwYezgm1Kb5V58hvIN89J6z04BZOlyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwu4LHr0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso55794611fa.3
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 02:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731322069; x=1731926869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhYlIgryFp1NkbyoMhZALoJYDa4LuTaM8fsW/hpxWxo=;
        b=kwu4LHr0AaWWH11LLA3odOoBjFsu2vJD7zMFfavjlYcqsfmHHMgCFKg4IIEHPoO9RW
         w6+vIdIegaSRT8Ie+2h0Mx1YjwXFokxZTVGaff53u1X8lWnjb27ciPqbxTGsf201ymtu
         3TqBIn98nlE15f3m2nlB/ugSuIuOKvMHabCOxBEukpWNDAameGHj2u8KeA+8LJijWXhD
         bRTQpM8XoH5dSZVMgfUlf80PQwlt8CZGQGueX5UTyCcjn3N455FHhk0huXvqu8un+Zy/
         5F983gt3pM8fu8qSHCaEeuomcvPTMRABXVFLFHeT7lfyC7DrShK7v6Fmm+8uvBJFPrDa
         TJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322069; x=1731926869;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhYlIgryFp1NkbyoMhZALoJYDa4LuTaM8fsW/hpxWxo=;
        b=JlLXCZOZEhG5SWLQ6qa1QLChSo8oPeskBklNYjpqn1Y0scbIyLG/OTdNB1yakVyBMF
         89w4v0aD2dMpbF0aPJKoANpXVPUKZVgog//G+3HzcmdLjBq9eCn/gC9jOaYgGsr4bY3G
         dwWZbzDJ8ZZQMmmid64WKv531SCjb9yDF5qb/tk4MR8F/HfDUm+OScAMYl+I8J5/WlS+
         F50SVcP/1e3fwLpJsKfJKJf4/NGqhKAyNVr+H4yYJa6zJBCAmgDIgs+dUd9VNvEiEuBw
         qBX2FBeiKzOsc5+ggB4W+BgYVwAKqiLpDp4wwmhuLSqMSGxpqr0c8k7un/ti5kjxt3Q4
         Eu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEb0sx9Sdf6XcIO6c8LsS/sENX5vLjymdwyTqENj5+Aw83mdYmNUUUNOnAWmskpgRksHTeasI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27ttSJG04GPxrrIzPUM2Z+5ikDY6WgS3fhRyxRs1Ixp7AjSa1
	+YmnZSpxu3t+L/zmtQNE/RieQtWEczhloS7wiHGDriuHkExbGRfT
X-Google-Smtp-Source: AGHT+IGEeaseyAAIGq2mfjMQzXlYn9RpB1g3/dLrSJemGekAaMFdw9DyMzJ3snHRBrr+yM8bZuQ8Eg==
X-Received: by 2002:a05:651c:220e:b0:2fb:cff:b535 with SMTP id 38308e7fff4ca-2ff20188264mr74292341fa.13.1731322068528;
        Mon, 11 Nov 2024 02:47:48 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c97sm576642066b.131.2024.11.11.02.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 02:47:48 -0800 (PST)
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action
 explicit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, Daniel Xu <dxu@dxuuu.xyz>,
 davem@davemloft.net, mkubecek@suse.cz, martin.lau@linux.dev,
 netdev@vger.kernel.org, kernel-team@meta.com
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
 <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
 <Zy516d25BMTUWEo4@LQ3V64L9R2>
 <58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
 <20241109094209.7e2e63db@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <7724370d-5e8a-bf98-421a-3a69294daa8c@gmail.com>
Date: Mon, 11 Nov 2024 10:47:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241109094209.7e2e63db@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/11/2024 17:42, Jakub Kicinski wrote:
> I'd suggest we merge Daniel's patch (almost) as is, and you can
> (re)establish the behavior sfc wants but you owe us:
>  - fixes for helpers used in "is the queue in use" checks like
>    ethtool_get_max_rss_ctx_channel()
>  - "opt in" flag for drivers which actually support this rather 
>    than silently ignoring ring_cookie if rss ctx is set
>  - selftest

Sure, I'll get to work on those.
But I don't think Daniel's patch should be merged; the old output
 is confusing or misleading, but the new output is incorrect (when
 run against a current kernel and sfc, or a future fixed kernel and
 any driver that opts in to allow nonzero ring_cookie).
If ring_cookie is nonzero then it *must* be printed, unless ethtool
 has some way to *know* it's ignored.  Regressions are worse than
 existing bugs, after all.

