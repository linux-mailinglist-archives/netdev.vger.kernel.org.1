Return-Path: <netdev+bounces-55474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CAE80AFAF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25931F21243
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A2241840;
	Fri,  8 Dec 2023 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWf4G2PI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C740171D
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:33:00 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-425a1e571f0so6237931cf.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 14:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702074779; x=1702679579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWEyWy9NF7dkHYtBOkW7ozmtUB4VJM91sEVxBig0Zdw=;
        b=QWf4G2PIOnTsn2KQWeQ9i1cCAqZTouaKqh6Ig0+xnsfQc6o/JLDtvihQV1lfmWwtWW
         aRJDVOW5rIZGFfEYYui37tG4lEhYhtksJrKZDs59ZHuvEL6HPv6JpDjQY6NNHDl6Ljb3
         T1M5aP5Kpm5hDk6TfbDuOgXRhtl05oBiAlu9TMWcdqYN8YlsWE2zQDiiQPdbdx2Ms+ir
         PbF5DESIvjBal1oKhnMJY93P1ObAPxd9nzIqZC5kfSbhAwLUzM7+8A9knX+n3oJVBbS/
         SzONrUUHawX2EMLpoRaFtzh6RwnRcgP0VR/OnpaUJPoINL0UzSfM58rViwugrTc2kVNN
         6yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074779; x=1702679579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWEyWy9NF7dkHYtBOkW7ozmtUB4VJM91sEVxBig0Zdw=;
        b=mCyUxbvkFdlOchRhCEaIqh8Y/6ULGwaf9ItEr58QZ+kVab34204sL84awxvsBacTCJ
         8GXG9ylQksU0Nqipavp1elm9hdIW3I9Y5KYiyMAYgPXmyXfdfHm6Bviz0LJroknoyGpj
         bqRC5CGBsx+lcjXwpOzzCtB5u2aanYngMiCVYQvDQB/rU4ZMsV30ZzVnyM3a8BIhXbDP
         Uj2QJNiH7ozzM2lbBYUN/MnO2gcBU/f25yyh5h64fWmMkdlKzUXGG78besUHsaTGjjkZ
         I5fvcyXkfNsJxY40voHxFAaeaAgyKdnx4g0l0KLUeAUmAP4sQ6qJrx2Roaea57RGh4Dj
         ryQA==
X-Gm-Message-State: AOJu0YwAYblMN4LBo2OkzdMqszPF98iplAOtA8Y71IGIToTZfIkrbTPG
	exid7LpT/KhXYkVLzlSecYpY19v694E=
X-Google-Smtp-Source: AGHT+IH5Mj+tUkKXRgbdxJJCGvpVOOuSFbye5Y+f4f7jRVkPAGQRiebVC0aI1Li/TtdaXLLXxiM+rQ==
X-Received: by 2002:a05:622a:1455:b0:425:74e5:6dbf with SMTP id v21-20020a05622a145500b0042574e56dbfmr906994qtx.67.1702074779580;
        Fri, 08 Dec 2023 14:32:59 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fj26-20020a05622a551a00b004181e5a724csm944185qtb.88.2023.12.08.14.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 14:32:58 -0800 (PST)
Message-ID: <f7e8b255-d069-4188-86f6-3411f02aaf6c@gmail.com>
Date: Fri, 8 Dec 2023 14:32:55 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] docs: net: dsa: document the tagger-owned storage
 mechanism
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Madhuri Sripada <madhuri.sripada@microchip.com>,
 Marcin Wojtas <mw@semihalf.com>, Linus Walleij <linus.walleij@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jonathan Corbet <corbet@lwn.net>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-2-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231208193518.2018114-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 11:35, Vladimir Oltean wrote:
> Introduced 2 years ago in commit dc452a471dba ("net: dsa: introduce
> tagger-owned storage for private and shared data"), the tagger-owned
> storage mechanism has recently sparked some discussions which denote a
> general lack of developer understanding / awareness of it. There was
> also a bug in the ksz switch driver which indicates the same thing.

Link: https://lore.kernel.org/all/20231206071655.1626479-1-sean@geanix.com/

> 
> Admittedly, it is also not obvious to see the design constraints that
> led to the creation of such a complicated mechanism.
> 
> Here are some paragraphs that explain what it's about.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


