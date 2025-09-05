Return-Path: <netdev+bounces-220348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC1B45831
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96B4A07BB6
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922F350831;
	Fri,  5 Sep 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrZ9pimH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C254171C9;
	Fri,  5 Sep 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076747; cv=none; b=VbMwwqJBDRxQ7WnyyEgKx8KBBwcoAnQtDw8xwiywzzLGNQXHAR+/EPZVbLTEqhNb0BblhVylkCyNt9nLmEAkasC919yz/zxQGKHM0OsPy9R4eIHzf6y9aCfcG5nA/BDcFRj6swAo7ocHePPbH4ANXviN0SuN8hjf7+xXWOp7SOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076747; c=relaxed/simple;
	bh=NqYGLAacCanmEB6salf1RZZrzDNNn5EVGytjMgmWrs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2M1RQKa+I2Y5t4Jph69Rzx0mKp8HlE7PbJgpV1IBQSJFNpG74eRPmqvsbtYk/ZuIXPMWWBPiRIGJ6tFSyJEXhyGVI4+3JsnzNZkMGaH2R2U+dlBk6KCW6wekGclkJwvR7YUz0TLh1uZyu9Ov9KZ2WEG10GXwQA1/aMxfYUPLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrZ9pimH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b76f3b24eso3717035e9.2;
        Fri, 05 Sep 2025 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076744; x=1757681544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8EPKRftEsNcOg9bP+ysM+fNoxSdn7mQqqnV7bP4DPg=;
        b=mrZ9pimHZyaqLfaO61TtEU+NNcKhqBmYIeQH+x4+7hI6cU5g/Qwqs/20oONGLe9ZV3
         xVw+Hy7NavNBhjWudPCpJXB4lNAigFudZKjogUXXnaYhuliCbbDrrPhM64WZ7K00J6if
         lD/tB4Il51EBc+zYQvlrp7j9jZcKHybrXR8NaiGLpv50B4ta7aOKd2PrFj//iIYYSJaR
         QD5l7rfmcQzrYHzMG1u4L0qakQDrma90IRc5rnLLTqtzbBcTr+eyybU8DtYCADHjDxPj
         psmm/uPK7bJ8QuL/FvOWFV78/IkrJkKeL8XkCacC59zBL5xgk80JtBt0sylE5eaU0RXb
         SFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076744; x=1757681544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8EPKRftEsNcOg9bP+ysM+fNoxSdn7mQqqnV7bP4DPg=;
        b=nQEcXi735iKr0HvSmqmuw2FwD5Hwocukd26KbLc0EEGCAsFy+9bOddTdSaY7CzFMLP
         U9aWibtYVJsY77PBlHW6NIhL6wfFz/Lar/eTmW++c69PnaCxfvoNRn93zfgyB8fdkDwh
         O7I8S31Rkxe1+J+jQIussIuqs4zgXpY4M8iIT3B4AbRgxqmbPBdRSzLET/9dgAh+ZV8P
         jZY2YDS5z5C94ldEczJkBZQef6kXPF6b5BdFr5h+FIDp0hBiQAaaxrl9VOOah0+HUu5b
         HnJXlpOyxbFh3BGwTy9Eg5LUdknU16CrRWx73AMwSJI+HWhau1kU//3wnf3d6N56VYot
         IDYA==
X-Forwarded-Encrypted: i=1; AJvYcCVKsGNi63p3rBpnnbKyHUDpGKDUhHtUBwgCmAobXLNNGb4ysc8kx/EgeYecMrQ6w7hAI5NA2lSEbD34Tmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlOfbbMscrJHk0ZMj5mFFUYzNHaXH2MapeFEfzbrkqWJ6JpcR5
	Na9hXYermybeKzWfdKu3QgoTj04oHCBRKERKueDniGNgHvsTmCkU3pVQ
X-Gm-Gg: ASbGncvpEhBHOnWzodTqKW1UigjWrN65GCKUPzug//lUeyeBBVJF5PRjSMMH50Qi0Dv
	NQhlPwCKNXSOCoHDa2DQUGEEtTFMc3s1H9iGZ6sytFKom83CmG/QNYPoq/e3wN/XDi3Iurf29eN
	wuOA9uoUSwZ9DdYFl72nbZao5agxJEDU32t85o68FMB0xbzFPHfY+kZH529gmNKqYOylJi2rZav
	M3UmaAkqnAwa5ckQ1GCID7jED7S7hh0DJDqHm1/8cYjYmAubASdSCftLIr8tBxl4IGdb0WTtLaq
	PeroqwAecovVEZqr2X91kCunSGFLm4B+oxvPUatdfSSB2YFYd6zZTSmRXhGdTaHqKtCDfBA81Ks
	C3J6uF4v3iOtdhZSyhekftuLM
X-Google-Smtp-Source: AGHT+IGn+lDF15CI0F5SJdkwJYe2qk+NQ0oa2DTKUpp+SG3URaVCzFU6fw02csOvWGuKn6rPYnTF9Q==
X-Received: by 2002:a05:600c:a00c:b0:45c:b6d8:d82a with SMTP id 5b1f17b1804b1-45cb6d8f43emr41078165e9.6.1757076743480;
        Fri, 05 Sep 2025 05:52:23 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:d7a7:bdbb:3df8:b18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm319067535e9.10.2025.09.05.05.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:52:22 -0700 (PDT)
Date: Fri, 5 Sep 2025 15:52:20 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER" <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: enforce phy-mode presence
Message-ID: <20250905125220.mhy7ln4ufhg4onwo@skbuf>
References: <20250904203834.3660-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904203834.3660-1-rosenp@gmail.com>

On Thu, Sep 04, 2025 at 01:38:34PM -0700, Rosen Penev wrote:
> The documentation for lan966x states that phy-mode is a required
> property but the code does not enforce this. Add an error check.
> 
> Fixes: db8bcaad5393 ("net: lan966x: add the basic lan966x driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 7001584f1b7a..5d28710f4fd2 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -1199,6 +1199,9 @@ static int lan966x_probe(struct platform_device *pdev)
>  			continue;
>  
>  		phy_mode = fwnode_get_phy_mode(portnp);
> +		if (phy_mode)
> +			goto cleanup_ports;

It's not really great to submit bug fixes without testing them.

/**
 * fwnode_get_phy_mode - Get phy mode for given firmware node
 * @fwnode:	Pointer to the given node
 *
 * The function gets phy interface string from property 'phy-mode' or
 * 'phy-connection-type', and return its index in phy_modes table, or errno in
 * error case.
 */

The test you add will only pass for phy-mode = "", where phy_mode will
be PHY_INTERFACE_MODE_NA. Otherwise, it will be a negative error code,
or a positive phy_interface_t value, and both will result in a "goto
cleanup_ports".

What is the impact of the problem? What happens without your fix?

> +
>  		err = lan966x_probe_port(lan966x, p, phy_mode, portnp);
>  		if (err)
>  			goto cleanup_ports;
> -- 
> 2.51.0
> 
> 

