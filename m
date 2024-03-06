Return-Path: <netdev+bounces-77805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F98730DC
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0439B1F25D08
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461195D486;
	Wed,  6 Mar 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2eDjqv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A59433B9
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714214; cv=none; b=WaHHCr1BUwgLsOlbIo4T10uVL3xHa/igSOHVcXYkYBAMGwLMiWKgWG4xyffBBQRUVpfmWE01m7STlzk5ej1RAOL01A7LX9jwv834nDaNqLqx3zgUo/I5kO4Va4eAWSkxl0JkCNhR9+VfDHEnkUwtGXkQKBhG5+rYsAhE1izvXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714214; c=relaxed/simple;
	bh=NNDsCpgXUqnTVgldDCq7tpB4bN5RG3gam93XXun2jNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHDiSzeM7W0OAP+v5/T0vbBG7JcpAUxRorv1EvhZc23dLWQQQe6Mm9wsffqOdTedvejh5FyGuQANsrg02rmSf4PQaOqUhahBBLoCFZoc29ZjrE9hjGDUrL+g8Oy9U0q8tBt8Y6j+m+UNXTbe4zHf+IzsclFASUpyj+dEUp+GkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2eDjqv7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608ceccb5f4so43578807b3.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 00:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709714211; x=1710319011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNDsCpgXUqnTVgldDCq7tpB4bN5RG3gam93XXun2jNA=;
        b=s2eDjqv7jqsJ4zBbZy7H4nbxPI3zMt1X+pz4RHClVdS1MZNJHO8R021QcnCTt+7A56
         QuVBa8fxzE63hnE4Ga43xbAxaL3g6MUznnbxNDl7slrxP4c+jxadnA7ljZIGTiYydPcU
         131GpF/Ca7ldFvE1G3ZzGEA5nytyXZuhNZj9g3wJpZlqbQjlHrzlIXbQ18sWsJlYmVzO
         c/ylnQ9ip8AEJYmx6pRPz6rpjRQyJwoFSIfZQm7Bn39iNZPeXNdyogx3Z5d8DOzI7yhH
         YM5nAHbPIpldnQ22DNxkG0LWYRKr5VCl0sJuQGWb21YfY4s0beZSO7iAVQODekk+Xo4z
         9Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709714211; x=1710319011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNDsCpgXUqnTVgldDCq7tpB4bN5RG3gam93XXun2jNA=;
        b=aCP4AXvszh1oPsM4WGAmQrgKQ53xBT5oewGIV58U114IglMyJUJNVN85u7XG+DHifr
         XeOondzlXyiUUvC923cPVDBL005SjDQOO4DDmGZPMMkudzUs0TX0TKnTEf3IWDdPMIhk
         5UagYNgn0Ykj/IJlwiZF3kgTmSUc2v8cz9yO9pjgQnahLSrPcnfxLzXm0Svm1fvYLyza
         eo8VTKNfHuye74AERk09OkrDF3lSiIbbsVyqPH6qCv4y89KEH6uN+j0yPnE8yfF4OVnC
         4JBqPC12PyWwVyOOcfiijL0g3uRj4Fta/w2B9T6lMiPliMWo8xvuvUMQzYfYiLCJ28EE
         /FtQ==
X-Gm-Message-State: AOJu0Yz5bGarpljpmissEmV0l2dp+wKnIF6mTG22o/vc9Hy2fxi5rxtb
	JBhP5VMYYxXSIU8fzUYPkgBvGtD9qwmNRK1zbj6xV3vqmI+igndi4zYfDwOWmSlZTRYD6JZOVig
	syeE7cPB+QgOcf15xwVcXMZ+HgeRukMldmfxR3A==
X-Google-Smtp-Source: AGHT+IGLhNjtxQWwYkQUglxPcEa+RvZcCcxoSRdy5ObAW+Xzq2pgWa2jlr2vpOMdsBIBcGp+Eq2YbuY3bzzRUpIAt6o=
X-Received: by 2002:a81:c211:0:b0:607:f4b9:11aa with SMTP id
 z17-20020a81c211000000b00607f4b911aamr14072266ywc.21.1709714211516; Wed, 06
 Mar 2024 00:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-17-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-17-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 09:36:40 +0100
Message-ID: <CACRpkdbRrnHtknbQV_CEpWu_bsaZEdOEa-AmXWXp2Rs4bKXxTA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 16/16] net: dsa: vsc73xx: start treating the
 BR_LEARNING flag
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:18=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
> which are required for properly treating the BR_LEARNING flag. Also,
> .port_stp_state_set() is tweaked and now disables learning for standalone
> ports.
>
> Disabling learning for standalone ports is required to avoid situations
> where one port sees traffic originating from another, which could cause
> invalid operations.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

This looks right to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I looked at all patches that I understand, the VLAN tag stuff needs to
be reviewed by Vladimir who I think has a clear idea of how that should
be done. You can add my Acked-by because I looked at them and they
look right but I can't claim to have made a thorough review on those.

Yours,
Linus Walleij

