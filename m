Return-Path: <netdev+bounces-75010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961B6867AEE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71591C2181B
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166212BE92;
	Mon, 26 Feb 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lOsnafvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0912B14C
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963048; cv=none; b=aYowO4PXCZ+OxeqFkJ4sosw/G08ox1RMjHFy77x9ur77UPJaAsmAw7Jlk/fHjcCZc+VxD4H0TI2kss9FSUHhyZxkikfa/aezvNJcBm38Dp4Xe97ipUKmizIFWu5aCnc6JejSn6MeVSVzmWbGbqm/uuEj5MRQbzkNg6r8bHM3hVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963048; c=relaxed/simple;
	bh=zTNTM49OA/p5qcnY//Weehg9C1E+papHhw1uhLvVgAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOTa8R4Th5WOPOUMjZse+k1EALL+zWbmragFmLTMGFxB2zmC6qA4tkTQNmx3BR7HsYE6+gL9za2FKZfPqb5FYu4mYNiT5zg3b7G9W9uHSUEqON0Z8Ns1TpijTp7wV2ompy+ThpHwv4lg3RG9cF7rg+y9SB311KqoiBT9iX6sUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lOsnafvW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a9a61545so2039555e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708963045; x=1709567845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hXZ8M5gssPpIvtBId1LdXaw/y91eMaOYnyD3sRn150=;
        b=lOsnafvWVVanQz3/kurGSQdAng/6skBzY1ma4zWJ5dVJJoFVx9cFeC+nA9BFOtAZkd
         jAF2Nzg+TZXpKiIUgkpSbVyENcFQi1kE9ALT0iiDq54/xe2Hyhd8JSlcRP5WOw0aIWwa
         OnxwA5nMhECeiHhGxJJc2MXAMrkUCFiMCJV08ucmHcXmEtceNQ+te9RS1To5AhHzN4Am
         WpPbsxZLr97Y1j5bHWZx52uy2Ona1H7c7SUZQKXL4nV7c2QxNVLaN19n9tBnPOkIj2ac
         7bd0IIL6UZb04qGI5FJZM9Q0mWcbNVrPpNtvqqANfPQCcz93wU+3YXk2evcaDDQjmQGn
         nzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963045; x=1709567845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hXZ8M5gssPpIvtBId1LdXaw/y91eMaOYnyD3sRn150=;
        b=SueQ6vZHb742Mg3LCHDxo65tUku9AftjGz+NI6KiMLiOwn39U67PM7bIjBbiM3g9LS
         xlr8aIri4Vdo4lZtjDOizyYb6FGv04GcA8RjYDLk9gMhHTmJo/IbN6L+bssbajN6PId8
         MNSb1g0d2PH5ikDxlTvJkd7bMOKmkKIGvwBDOI9pA6hK+B9dQI8sus49/athsmbgf13U
         AItwY1Yfsg/6gyKRfC44MN1sXccHp9ixJHX3fWaA+Vo+aooUSYlNZQhZHMGrbzApy3xA
         lZLzVC2czDcNXgx3/IpKEYpX7jTZs/D0Tb9ozVsP3qNfEkYRzjMkr+OC/JYz4dkTCgF9
         gDZg==
X-Gm-Message-State: AOJu0YzwiW7e8MwiAgfgt176nfj13XH2JLCyrehpEJ3av4GdbPZpLoSN
	Re5sipjdOt8e8TjQsUn/zmbh/Xf3jj8T0XbHszaQHLH7uyTmn8Q4XjDGxE0piTo=
X-Google-Smtp-Source: AGHT+IEfaI/3A/nwk8XyCizrEyD1TIA6M12wSgg7yUaz8maH0lblPwbX4P4z4Z5NttLxfJo7bopFRQ==
X-Received: by 2002:a05:600c:1c1c:b0:412:8d4d:b4c with SMTP id j28-20020a05600c1c1c00b004128d4d0b4cmr5783835wms.15.1708963045187;
        Mon, 26 Feb 2024 07:57:25 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id x1-20020a05600c2a4100b0041292306f2csm12256063wme.16.2024.02.26.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:57:24 -0800 (PST)
Date: Mon, 26 Feb 2024 16:57:21 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com
Subject: Re: [PATCH net v2] stmmac: Clear variable when destroying workqueue
Message-ID: <Zdy04YvIFlkOl3Z-@nanopsycho>
References: <CGME20240226154254eucas1p2bedde2c58f147809f83b23d455af9289@eucas1p2.samsung.com>
 <20240226154216.144734-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226154216.144734-1-j.raczynski@samsung.com>

Mon, Feb 26, 2024 at 04:42:17PM CET, j.raczynski@samsung.com wrote:
>Currently when suspending driver and stopping workqueue it is checked whether
>workqueue is not NULL and if so, it is destroyed.
>Function destroy_workqueue() does drain queue and does clear variable, but
>it does not set workqueue variable to NULL. This can cause kernel/module
>panic if code attempts to clear workqueue that was not initialized.
>
>This scenario is possible when resuming suspended driver in stmmac_resume(),
>because there is no handling for failed stmmac_hw_setup(),
>which can fail and return if DMA engine has failed to initialize,
>and workqueue is initialized after DMA engine.
>Should DMA engine fail to initialize, resume will proceed normally,
>but interface won't work and TX queue will eventually timeout,
>causing 'Reset adapter' error.
>This then does destroy workqueue during reset process.
>And since workqueue is initialized after DMA engine and can be skipped,
>it will cause kernel/module panic.

If you have a trace, it is good to inline it here so the future
reader/backporter can immediately match it.

>
>This commit sets workqueue variable to NULL when destroying workqueue,

Don't talk about "this commit" in the patch description, just tell the
codebase what to do using imperative mood:
https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes


>which secures against that possible driver crash.
>
>Fixes: 5a5586112b929 ("net: stmmac: support FPE link partner hand-shaking procedure")
>Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
>---
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>index 75d029704503..0681029a2489 100644
>--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>@@ -4005,8 +4005,10 @@ static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
> {
> 	set_bit(__FPE_REMOVING, &priv->fpe_task_state);
> 
>-	if (priv->fpe_wq)
>+	if (priv->fpe_wq) {
> 		destroy_workqueue(priv->fpe_wq);
>+		priv->fpe_wq = NULL;
>+	}
> 
> 	netdev_info(priv->dev, "FPE workqueue stop");
> }
>-- 
>2.34.1
>
>

