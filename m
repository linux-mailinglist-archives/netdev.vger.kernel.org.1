Return-Path: <netdev+bounces-77686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC844872A64
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 23:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB101C21BDB
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 22:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9142112BEA3;
	Tue,  5 Mar 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxdjCd65"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517C12A16A
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678752; cv=none; b=GkfOwE2EWDPHSvhZ/UDGU2mzh9bDZp5Y73XshH32XsWB/J7qdNlcV/Ynn3Jn27FzN3EljxuVKEP1K69OSGO1Ji2/st97vB8r0nPqiljP6fHXLz8HZuZSEIHt3oJDzZRuZn/etK5svxs89c8fszSf9vDECUBBpN6Yp42IqPX1Q50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678752; c=relaxed/simple;
	bh=jtM/RjfeuOYALyILOB3IoGS/0L6GWVnfUaDVIucLSgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8kLq1pGXQI+NE6QDql5hf9/wYbJAKtFIQyl1z2K4U7ctU+cDqW/8xTF9q4GVqP3tQnR/9I+IR+c6re4ekAUGLesV7C5xIkeAYPItVFYVPJ8jDD+QBlOb0OXUY5hp08iix+P6dU3gUhAOqfRGf861bol0q7t/4E0oDvl/Lo0r3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lxdjCd65; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so272181276.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 14:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709678750; x=1710283550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtM/RjfeuOYALyILOB3IoGS/0L6GWVnfUaDVIucLSgs=;
        b=lxdjCd65Baf+2A1XSEzUeVJd5i/eoiHZ4fPI/rG8Q6dogfwMMaoWqtouF2jkI/POSF
         lmbdW1dR4/aMTOvCoXO4EMrP4MS/Kf12Sxu20fPnZagciSaZUVtOeRrupIkbTGtdOnd3
         bwGWArxh+w3gKyz0eEgsLVtkbmXF8mfTzRszMdmuGkU0C/AGO1uQUVthRkltliKPc3Ml
         b88/0Mp42nCZb5UiyquARB3grtEAT9DKbLgTybMxS1W/TNQdt1rygd9ZaizdIA0+n47T
         ZY1MmTB7lBWwR+EVOvbB0UY9RaRbjNrLUC7CflIxGYAzeHn0WXB/OuvtAYJvE/hnDtoJ
         jGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709678750; x=1710283550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtM/RjfeuOYALyILOB3IoGS/0L6GWVnfUaDVIucLSgs=;
        b=ViebEi6SnLOO2deHh3FVYjwWPfokZ7r2I96kzW1xoQg+tfnQ+gCoWSiILbLVqcxDJN
         Pbgo6mlZltV8i4Vda3pm5RCYwk593mw2X2ithjmZKGVKyJY77yS0AD1zAiTTY8Os19wa
         NXnFZamKaEbVuzcE7tzeGL3qQJ7TKty3mpDfSY/8Au+PclYXkhbJyrOt3mFUjrF5KB6E
         JqDgS0AMYoI3vvr3zhHU1DPGRRNC4XJAdI9GdvoRADB+NV3IktNe5O4+IQj2fNvdItdb
         0/tClin0cpSNQk8LUkkeiqH51JBK0njBhJi3xBvDx5OOR+4uVF+xwbakkRkyU9zLAEGe
         WxSA==
X-Gm-Message-State: AOJu0Yyl6sEABt9tr921wi9cZl3YVbVWZ0FbNsxvnf+5C4c4lpJ+oZ02
	KNuob2hNz3hn5l41f0OHec/CLP7ToX5R3g/aFyLr1E6NEU6k+10avfapol7GpRIIURvgE7eN2h0
	bCPGoc8DgIANVT1qsEtvnag3Mh/IYWifOhvrxYI4MAAgFzWDWM5c=
X-Google-Smtp-Source: AGHT+IHJzuPy26fVcm9Bfi8lrllbWjsH8MnEDwTMR6XgU2zPh46aAe3ia9QjdcGO3U5lMTwPinVC0sHP87rW8pzMSIU=
X-Received: by 2002:a25:d887:0:b0:dc6:c670:c957 with SMTP id
 p129-20020a25d887000000b00dc6c670c957mr2933253ybg.32.1709678749981; Tue, 05
 Mar 2024 14:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-1-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 23:45:19 +0100
Message-ID: <CACRpkdY1QfeqRfU-doq_qss8VzgWo9jLnULQREGmHPqsgpqWaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/16] net: dsa: vsc73xx: Make vsc73xx usable
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

On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This patch series focuses on making vsc73xx usable.

Can't help to think it is a bit funny regarding how many units
of this chips are shipped in e.g. home routers.

They all work pretty much like the in-kernel driver, or a bit
less than that, just hammered down spraying packets in all
directions.

Yours,
Linus Walleij

