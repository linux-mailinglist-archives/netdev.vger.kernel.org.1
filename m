Return-Path: <netdev+bounces-76429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF2786DB80
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 07:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0526A288796
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A687D63407;
	Fri,  1 Mar 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlHp8fvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D567C74
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274805; cv=none; b=HlSrZyumcCeyozOTqdc8bI8zoYBJF90YmU1EjnmpP868tHoNWObjIpQygsS7JLBVukjZiORvyeOC//pXoh6zOMzbV6a0gglec8Bw7i7tubVjfjBZ2/nWxTrElacfzqXJZnQ6tDOGokDCsRg//t7ETCAh743oneSnaVzP1edZEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274805; c=relaxed/simple;
	bh=nDOja5tFv2kw4myGXPIMJqbuRiw4W1oOPbG/TQFLCSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjwmY5E3MSOMwiSxWgSsQV0/6lpH9VfcKS6EfU8SMP8IVux/YhVCP9rfB3bmxYFnY9ZYnVJD9HG95wbK4DW2RPZ4MlshG/bQ/eizA+1GKIPlY949vr8gcd1DLx6P7yUpO2jekYQTa07MJzNkEcdFARh+ku4gbm/uyE8OUjsT5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RlHp8fvq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d26227d508so19591361fa.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 22:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709274802; x=1709879602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I4AvLK/FjCNfuk8kByJg2sRy0XAPgz7MRQQYrJtxRXE=;
        b=RlHp8fvq1+dHuszktO9r9Ybyukn+PpTZ7g8MLtu+uNeNtSWOkWUpZz08I2qBOj1ubq
         azRpt4ykhUPACOH0al4g+cfG6Enb1El3beJ8vj0fLmcpBGLevZQ0MWSOhj0ZrxYY3orB
         qO9zU2qY8zKxrI6BsnfNk1IgLeYbu6LmUilxjK04cY3G8IYi6dbx24ksnsAcdV9jZNqU
         5O1P9TqRWrRcbRrJA8vcpxF/vlnZ8MJ5jNOLwOL7p6nOAxd2FiFdLUO5fEPIvsCJVXeD
         PANb6XrCshizD32ALET4uuQIRCNKq7E5rTiQEtjDnz78jQMH5JEINXs1LYCPoLihVAWC
         027A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709274802; x=1709879602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4AvLK/FjCNfuk8kByJg2sRy0XAPgz7MRQQYrJtxRXE=;
        b=SlRhMpd/OBWo03m4cLntmdf7SqRMl0S75GCnRHSrny7+ssY/vhvVO8e87eVOeuuSZ8
         PhKnlnXm03tYRPwdSxrf4pUbxd+9dOZllG26KFu9ccFFVBUSO370zc+0mWtFyPpkIbme
         ieBkXuECjT2bhJuW5YRgZI38N8NmLuR0orhlMcc6cBh1kGlnBAhPZ2c3DfCp9RY3v7SO
         Y6DpIVUKZ+luFuINXcbjHQxHMuMnsmbp2tpdO/js3OR27/i3/+fs89iiXQublOjbgv1a
         q6eO37YXxcow8KEdnxcnaMJ0imbEkUpDU3SkU3amIOZTplI2essX5MrsYrKcP7hQmoHN
         MtUg==
X-Forwarded-Encrypted: i=1; AJvYcCVIom6jbyVNreMUSXvpL2dEDaGQhkS47OmpQ1BJESWvVOR5fWKhjiTzrc3/u0ZA3ZdHl62+O49jnCondy+Y4qe38cYScxXT
X-Gm-Message-State: AOJu0YxJEj3jaT8C5V/kAjYk76k0b++1tZdLB5olkGUbGGePl0dU/fy6
	fGe2u7eetI8y3WEJzKdnNXQvGBjVbFalPvnVq+9zcoU0BN+an8Qwjbf3lzWWONspnB38ZPjLXla
	8YQURmXVXhZ0ybVd+jpOA3ZVT9jytUb/XdWyN2w==
X-Google-Smtp-Source: AGHT+IF53t416hDTlEtbXDXQmjAY2eCQAvbfGdjlHpLL4jfA6RJI4WdAuRVR4lP0YB8xoY72Ina08cBomwWxYjV/f70=
X-Received: by 2002:a05:6512:200b:b0:512:ee1f:b5af with SMTP id
 a11-20020a056512200b00b00512ee1fb5afmr453495lfb.41.1709274802001; Thu, 29 Feb
 2024 22:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301063214.2310855-1-kojima.masahisa@socionext.com>
In-Reply-To: <20240301063214.2310855-1-kojima.masahisa@socionext.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Mar 2024 08:32:45 +0200
Message-ID: <CAC_iWjLtDjHUd-eD-xDaV-mw4e_bzAPcO9+XXPOSDZ62E8x_oA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: net: netsec: add myself as co-maintainer
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: jaswinder.singh@linaro.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 08:32, Masahisa Kojima
<kojima.masahisa@socionext.com> wrote:
>
> Add myself as co-maintainer for Socionext netsec driver.
> This commit also removes Jassi from maintainer since he
> no longer has a Developerbox.
>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ecaaec6a6bf..494e08683b64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20214,8 +20214,8 @@ F:      Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml
>  F:     drivers/net/ethernet/socionext/sni_ave.c
>
>  SOCIONEXT (SNI) NETSEC NETWORK DRIVER
> -M:     Jassi Brar <jaswinder.singh@linaro.org>
>  M:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
> +M:     Masahisa Kojima <kojima.masahisa@socionext.com>
>  L:     netdev@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/net/socionext,synquacer-netsec.yaml
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

