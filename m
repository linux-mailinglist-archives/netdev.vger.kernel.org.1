Return-Path: <netdev+bounces-61757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA12824CDF
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 03:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD3FB211FD
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A87E1FB4;
	Fri,  5 Jan 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8lQ96la"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819C1FC4
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc7d2c1ff0so13743741fa.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 18:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704421313; x=1705026113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ElkEnkWu9oxhV/CT9r3HuZ6Xpmb7FzXlipHbOeyRiyQ=;
        b=d8lQ96labBvBwn2Mxiwnuj0/PxBaDblW+FwZVnGHpyLhXhYZcnIHuetqD70uxeD6Ab
         5h7/xDyOfnguPkRL/v6MbMWDvI7nvLl9odfA7TL1wNVmdxBXMiHZM6C+/2qC2FgKpCu/
         82XqzDs6KzK8DWZf2gm5Nm0LS+UkB8clnUPEvBiUCdarnW4baHKFR6HTD88AnlNPh73K
         A7XvhglNYaRjRdH0+Vw/T89tCYjIJPAd8HFZHHpqzFAAv76CcZP9kOt+DwiPs0/9MFRi
         zxYcvtgOr9UMxoArDUvXsqBsQLjwgRMreCrHzfgXaTZl0jLvjEJLWkLSaxmEGGln7OY+
         zH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704421313; x=1705026113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElkEnkWu9oxhV/CT9r3HuZ6Xpmb7FzXlipHbOeyRiyQ=;
        b=Tk9q0HXOpUOqug5X0eW9tz3x5P43RrdLLA8ie/neMxnhH4vBUQzHkpcLXbBlZgVSsR
         cYxMIhgsRmYQnBWBgCAAAW9F5CqgTzfQt7CaUD4ihVis9zqEDScvFyXgQprDefKZNHrV
         1ZdgYEDbeGYfqNV1eYEeOsCn0wKKa2xkizGy2rpISYVFH6eAOon/yhLKnh2P4rf+xLhp
         BNf7xjlgjfwn/6vuwOQhkcXdOSFEnU9ErT3wCcUzSRqD+myDtkspVYPTkh7SCC1tikTj
         buJScGSl9A/sl8YYq3vmar+Lk5O/T/wl1Saw5460Wn0s0dmeAvhclzmVulYqLu7qAZhc
         zQZA==
X-Gm-Message-State: AOJu0YwqzbBeQ8n3mNboLpKS/ZjBUArVcJXt+QaXe8porqSZuHX1Yf51
	vf2WQp+Ey89lc6vNeUybd+cxhNWLajCfpheb8CE=
X-Google-Smtp-Source: AGHT+IGOlUXu2XN6GfRBb/dq6nD9hWCUd8MZlD+ZV2unMyH0tbpQJL/crMZ7nluPQEvg47yd2eRneSOr9JNF9gLP7Is=
X-Received: by 2002:a2e:7308:0:b0:2cc:a586:8059 with SMTP id
 o8-20020a2e7308000000b002cca5868059mr829260ljc.42.1704421312628; Thu, 04 Jan
 2024 18:21:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104140037.374166-1-vladimir.oltean@nxp.com> <20240104140037.374166-9-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-9-vladimir.oltean@nxp.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 4 Jan 2024 23:21:41 -0300
Message-ID: <CAJq09z40O+h5w4WfU38P0mjO6uN+pv1u51zdsH5foRFzbGGEtw@mail.gmail.com>
Subject: Re: [PATCH net-next 08/10] net: dsa: qca8k: use "dev" consistently
 within qca8k_mdio_register()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>, 
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> Accessed either through priv->dev or ds->dev, it is the same device
> structure. Keep a single variable which holds a reference to it, and use
> it consistently.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

