Return-Path: <netdev+bounces-59975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB581CF7F
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 22:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938CCB22408
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471F2D035;
	Fri, 22 Dec 2023 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCglXIWW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D522E84B
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc6b56eadaso27553801fa.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 13:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703280755; x=1703885555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KhKdQgQARs8Nw5zRkTAj8NpihrgF8h55fm4MD7oCBHg=;
        b=lCglXIWWzyID4WAhvPpup2W1FRNczIjJu0ucTS9748dBWO7ZV+fskBV32m1UlHKUCJ
         ify9PAWcxRgwwPnxJSLkMfzthd3fvJ3JUE2IyLK7lKvS2ID2NpYUs/TUKJq+XhaNDgqx
         Gz7hziiWEX4nIGXmaa1dHdWU/xPrj6C6A7ldJP7sOCtG0kh9vFPBNfRpYWjUNKn6m+Mn
         4TNUe0Tl+vNUBpO5EVnQarcj5pGhAI2+35o6g1xS09J6P4lA9qywGr+ZuU5lUiAVTj/F
         aFKGlIl2AuTe/Sq97GEY51X8WjMtCYfR6+W6ME80SzDW8w08Zh3sF+A3tMUzlQGCF5oZ
         G30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703280755; x=1703885555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhKdQgQARs8Nw5zRkTAj8NpihrgF8h55fm4MD7oCBHg=;
        b=sg6dQNlqI15IftmwP/ybaW4TnBasEpFj8YcaU+BqIksC8czgys+9o3JXSA7MX4jmfX
         HhxbodWWkW/hwQApJVbl0I/w49aDTMPK50uVfMatn5Oro/rJhwZ0NAheYZMGlXHoBg7i
         ZOpy4BGg19HZoSF75hMsF/6qZF+O8iMSxmCK8AVitOdwpEfnZdZcf+c+E6tqRYV1RkCt
         89rSsAHbytmyXHZHxB55hY6b/h0x9/fK+GiBWR/D3JrkAk6Ts5dLt5Ap6La4pYx9YcsV
         wdkOm5c5skjLlRGIkm1zGiZ68IvWjnEgnzCnkcc67HiSsxSnrbGwp0CTP47WhKKVvVqW
         G4uA==
X-Gm-Message-State: AOJu0Yzu3buoet2SdQgVpfHm6nffHYeUdALzi+sW87837761MyV3oScr
	YR4xUH+eQ2WDHI3MYaluAglmtu7brJWg8lAuJlg=
X-Google-Smtp-Source: AGHT+IECDLrAVCX57P7dHSWmks7PJ6LBc1ADNeO0kckbWCYhTaN0r0uP+t3GzFjUbZEks+PDGANY9+v7H9eOEUbDetY=
X-Received: by 2002:a2e:980d:0:b0:2cc:3793:5575 with SMTP id
 a13-20020a2e980d000000b002cc37935575mr999573ljj.93.1703280755210; Fri, 22 Dec
 2023 13:32:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231221152133.a53rlyiha7kqyk5q@skbuf>
In-Reply-To: <20231221152133.a53rlyiha7kqyk5q@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 22 Dec 2023 18:32:24 -0300
Message-ID: <CAJq09z6xECtRwKGcUdPNCnACnseBHSgeKe+w9rRM_esFsryPsg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] net: dsa: realtek: variants to drivers,
 interfaces to a common module
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> Could you please do word wrapping at around 80 characters per line,
> so that the cover letter doesn't look horrible when used as the message
> for the merge commit? Thanks.

Sure. vim normally deals with that automatically. However, recently it
is avoiding breaking the lines while pasting. I just missed fixing
that this time. I'll check if I can force vim to obey the limit even
during pasting.

Regards,

Luiz

