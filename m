Return-Path: <netdev+bounces-123384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B0964ABD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6274E1F24AF7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA801B4C30;
	Thu, 29 Aug 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UYGeYzLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D71B3B36
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946999; cv=none; b=SEkJ64rrNS/JzRtzApkn04zZDiFTsxKNg9godxyKcrsMiv38XEgdB7aB7co/OpPZLTSNtnlJ8KViO9vTK1ouVpbERnBXloD/noOpgsvQA8UTLxy+XYXlnj96Xl6s++81tik+/IMj1oYhdEiW6r+49iwLXyGzUpyDvDeFrI/W6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946999; c=relaxed/simple;
	bh=BBqKX133p9uAfTL/pwOLNDA/VyV9Sy6IKhFXpLLIDyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=acGv9dKAL18RsnPiJcOd5O2jL+oZkUg37jFpJdXv+tQY8y8i3v9QKUdxNoZ33egUDtiILrdwErknVuMWpJ79DNNu1uIbExGFx4gMd4idduPlWMJ1vhYtVAfQjT1FcEOSGN3LVxSzhJeXQIQysV2/AXbBg5busZOsuaLRAbxkE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UYGeYzLO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f504652853so8977111fa.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1724946995; x=1725551795; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBqKX133p9uAfTL/pwOLNDA/VyV9Sy6IKhFXpLLIDyw=;
        b=UYGeYzLOkCB+JendhzPh6b4eT1tVBt4dsIm6tOpuLKU4a1ZCvIXcLe4mmLq9c3QkwJ
         GRn2D/anmeBL3eeHEtCFSzi1Ns1pminDRyJiNjMrzqsR5qlHep351Hyr32QfIWauPHxy
         edsZxSJd/pk7BKlaqblCAg19zrUh1/+vtKvrzlkGs2QFOd2qlFCkUsiGCNIFqIzfJv7J
         CNpP74LkPJibVwm1qotWKuxqxbrFlfQwNFzYjljUmRo8ZqEgakEDUhVxzxu703IsvFaP
         Z2BxDfPf3EtRt/6AhYzi1umGREYQYZ0AVJ/hQZQIXOv3E0bQQFvNA8qU0vxTGAq1Gb6G
         vckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946995; x=1725551795;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBqKX133p9uAfTL/pwOLNDA/VyV9Sy6IKhFXpLLIDyw=;
        b=u+R4i8afQ3h4nryNujvtxELjUXrXouoB7vlxM7qSsPqWiRxEdjidg0dG7NYze3n6Tx
         +XiMvcspQ8wboI+KIyWVSO/JLQdEqWwRJn2KZ9jSJaYPHtURy5owmKH8JC5I18IN0SIO
         O7m6Dhido92426v7gfsqxlLj6OgpU6m1FsMsJ+FWGkt4+//7sSI8Hy55PSPLj14vh9vJ
         vEQDA5szN0C00/EUkJKaZoOc4AqcP1E3xnVBTcZxUfdCWf8Oeo1VkB4PB8aOOOuBekvY
         mg8njx8BO8SksffbZ6LUws3FhEKCqjk/B2cvRDHmImSvxb3jtNANL7jKRgzOxTopMRsp
         jmFg==
X-Gm-Message-State: AOJu0Yw/K+bHnjbgP48AyJVfBxKIpFzJAdapoLXcQc0CRXJ/N4gpUEay
	Oo6J636R2/0L+qcrQR+W0QmNUOhVFlNvLUMkfGElVSkLPITlf1If9v7vxPYnR0A=
X-Google-Smtp-Source: AGHT+IH/TF/DXk+LKRSXXVi35QIzFpLF5dSEeiLFij7z4Dzn16uZrsamMOWW4Y8gBHG3t15eAvBs8Q==
X-Received: by 2002:a05:6512:4003:b0:530:aea3:4659 with SMTP id 2adb3069b0e04-5353e54736amr2047454e87.9.1724946995032;
        Thu, 29 Aug 2024 08:56:35 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f055sm94706966b.67.2024.08.29.08.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:56:34 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Yaxin Chen <yaxin.chen1@bytedance.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  Cong Wang
 <cong.wang@bytedance.com>,  John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch net-next] tcp_bpf: remove an unused parameter for
 bpf_tcp_ingress()
In-Reply-To: <20240823224843.1985277-1-yaxin.chen1@bytedance.com> (Yaxin
	Chen's message of "Fri, 23 Aug 2024 15:48:43 -0700")
References: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Thu, 29 Aug 2024 17:56:33 +0200
Message-ID: <87r0a7uxu6.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 23, 2024 at 03:48 PM -07, Yaxin Chen wrote:
> Parameter flags is not used in bpf_tcp_ingress().
>
> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Yaxin Chen <yaxin.chen1@bytedance.com>
> ---

First introduced in commit 8934ce2fd081 ("bpf: sockmap redirect ingress
support") [1]. Looks like it was never in use from the beginning.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8934ce2fd08171e8605f7fada91ee7619fe17ab8

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>


