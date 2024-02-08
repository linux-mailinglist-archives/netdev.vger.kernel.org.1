Return-Path: <netdev+bounces-70236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE484E207
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFAC1C22457
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC2762F0;
	Thu,  8 Feb 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5MI+vnM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2735763ED
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399221; cv=none; b=KSwybmVHr4dSUdDHcNLqdvjA4MkGog1iDgtzQh4tCIwE2JiFZctuTLoFkW31pxrjDV9nIKrYck6XGN7fT685Ct9vqe4eAVNL/coIreBSKn6+2CR2TK+1lDqGHzsPfwlIWY6jlYnWwl1MJ3Tq/2y4IBlwRt/yePvj7Toyw43MZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399221; c=relaxed/simple;
	bh=uwg8e/SSObZj/d0gxqE/R9ODBprLN69TzA/q2Ocp1Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/MNwoKZd7qn4D60o0nLbsaTBgry9jycRVFjdtBZ1hL/3zoHpeMwSGCyXLm9OY7KSud7j1T6FMHBXlKRfreh3UkQAWh46/clPSO2hsZxv25JLnTX9WmxD8edj+uaE6hZmPdkrE04FzyVf4zKvTbKp9MeuVNBTcKR02Oj4OLVKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w5MI+vnM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a389a3b9601so184820166b.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 05:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707399218; x=1708004018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAZScWmvmfNw3hJ0Kzts3QAp8ijRdo0YEPv4kKu7VRE=;
        b=w5MI+vnMQps3QI1wsH61VmspRvcC2JV8pPAxyPvyenj/ajdywPQAySxsEh9zrqzDWZ
         S07d7xBatCjnpmrYi5uKc9kr5A685nsjQl0xg4aTS1H7YD/rlJvvJDepaw7ufFuLZutv
         e6j9kxt+CN9LNdNjD9ZqCm8z7/OwI7kbfW3SiAstYTsmJZSBN0031twkFOMXuvrF3V9M
         xIatY3hCIAUT1sBDUA8XDECi1RylCavJ49xQ6X+O5iCYqLw1T/7M4vuYObIcsNLHAwTW
         P9Bq1L4EV09rLAc4vQSpAHCiIz500w9yatfEMHFfaULSZgMCItJ2FcZPjVcNZ5k7fNJ4
         8L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399218; x=1708004018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAZScWmvmfNw3hJ0Kzts3QAp8ijRdo0YEPv4kKu7VRE=;
        b=hWXcLQQmPplBooiEXyIWb9FwehSfLl5JVR5bZCQUhtG8j2iclxP6ogvTDGCieuovGF
         amxw68lRUSLl+Cbr2Iep8px0kXN25gYe5FiGPWptZDeeVqI1gpJcC4t9GN+6/zUfVXMJ
         5rp7Iyr4oLi2VQtYnqYmLFfGrbKPAelWvPveQLtHuX7OLBoFaNcP5383Y5lRSnKt4+gV
         ZanVXv02uPsnv6XY71FZn1hl8RnxvOBiXGwnwsYFtSS+kGVcj7IEBwEQ1XNGbTnMYBhO
         DSr9L6rlW+mgfJDBWsz77yd4uTMi3b2b2nJIhdi9UAZpZG1xC4bZUJ+Wms+GGLVK1NYF
         MTHA==
X-Forwarded-Encrypted: i=1; AJvYcCW5XcjGuJK6MTJajPH0OwNt+f7fIT0GUCButndyO8GDP6Rz30F61DYpZIqbMa/S5DkakC+4FnXUrCI0HSQzWgB4AFFIiucK
X-Gm-Message-State: AOJu0YwMJWjwcquKhITY1iFzFMXf0Z2X+fGA/xuT6I0kcOgRJPe1fZHK
	YJcNdAxR+WZ4jjLOczne34Af2BPvn493SpOgaZPqmp/pS6A2vTe/V77mqdzlhxk=
X-Google-Smtp-Source: AGHT+IGRDWbRNVcLqSGrv9YXWUg4LgfTgg3tROD5dYUX+AN/HfzNvHnJ+JfsKgBnO8wZS5lAlS+dpw==
X-Received: by 2002:a17:906:2011:b0:a31:64d2:d0c2 with SMTP id 17-20020a170906201100b00a3164d2d0c2mr5872835ejo.10.1707399217873;
        Thu, 08 Feb 2024 05:33:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSPglBFIjF1UdjGtaXkGX6szJlI3ur8kUXpBu9db2x8h2Mz3DLRSu8unoD2WAo5ebdysqkTZ+77X1PTdD1gwTIbE0wm4havh4slWnTc4n50h06Eymy7ySxQaqSSOMqx1XIAvCC5rdZWJem02LEpYklwv3Im3pvonM4hyI6YLjdZ0nLroP3KWxd+o36AC8E5Z7Dj+qmdtWn3L89zT6AHuflRl01Zo47K59is1eL4SrPwH16P4F9XDxMgNEp2L+b5MEY3AyNm4jLJfXAWKUzRPKt+gwVBraLV710PlenpOdD+7HfrSgCkFsTrRo8XSnkmTKnhNwvNvAnhqJ1G9MNATUYGuYSUFUNkXbUmZldVyjkxS6DEw9Nw9Vf9VMasFvEA4EDndQE7PWV8HTaIyDu0LqnrQoaeso0btUjskvVGT0NU7ifNBuyWdvJA+GT+gOp14KLyrlRtTIcf4JzkDBUf6g=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id pw6-20020a17090720a600b00a37624d003fsm43264ejb.121.2024.02.08.05.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:33:37 -0800 (PST)
Date: Thu, 8 Feb 2024 16:33:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
	rogerq@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, vigneshr@ti.com,
	jan.kiszka@siemens.com, robh@kernel.org, grygorii.strashko@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ti: icssg-prueth: Remove duplicate cleanup
 calls in emac_ndo_stop()
Message-ID: <2fa5f053-6b4f-40e4-86f5-807c3c6dfee9@moroto.mountain>
References: <20240206152052.98217-1-diogo.ivo@siemens.com>
 <20240208104700.GF1435458@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208104700.GF1435458@kernel.org>

On Thu, Feb 08, 2024 at 10:47:00AM +0000, Simon Horman wrote:
> On Tue, Feb 06, 2024 at 03:20:51PM +0000, Diogo Ivo wrote:
> > Remove the duplicate calls to prueth_emac_stop() and
> > prueth_cleanup_tx_chns() in emac_ndo_stop().
> > 
> > Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> > Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> > Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> 
> Hi Doigo,
> 
> I see that there are indeed duplicate calls,
> but I do wonder if this is a cleanup rather than a bug:
> is there a user-visible problem that this addresses?
> 
> If so, I think it would be good to spell this out in the commit message.
> 
> ...

So far as I can see from reviewing the code there is no user visible
effect.

rproc_shutdown() calls rproc_stop() which sets "rproc->state = RPROC_OFFLINE;"
so the second call will return be a no-op and return -EINVAL.  But the
return value is not checked so no problem.

prueth_cleanup_tx_chns() uses memset to zero out the emac->tx_chns[] so
the second call will be a no-op.

regards,
dan carpenter

