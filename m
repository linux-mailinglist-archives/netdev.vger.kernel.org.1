Return-Path: <netdev+bounces-190234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F5AB5D0A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EAA3A7935
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7428F93E;
	Tue, 13 May 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZVpP+2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425821CD0C;
	Tue, 13 May 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164067; cv=none; b=ArbGBlI8oud9exRFPjP7rT7VYS2c4g4FgwVOlk+331RuFWgRu0Wt0HBWBo+/F06q8YAy+UfGy61l34ZH/CpJgpmWRcKdwOQo0oLepnf26fKmi+aDXPABnAZY3e7/tCpaSr3+uv5uABaWt5uNO7ogafU7oiDBIS0UgSECWpozIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164067; c=relaxed/simple;
	bh=KWugkH9owyqMi3cH+lBmBgwoiciqoa1WdpBYWBn9Zy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnGUiemaCBzh/qwZDrH2CfFilVSbxVcfQPyjHW+4VQHESLVVOxGI80lUbxxzmcyIpHl/h0xKm59oS+2/w33uqdrP6OI2PYlLnOX89dmc2zCeO71lZsbZLqYvptfl6KRxMjeUc6jRYqvs1/NZDeB2mKf9A83R5iOgu+76IH8PhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZVpP+2g; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0618746bso46192245e9.2;
        Tue, 13 May 2025 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747164063; x=1747768863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KWugkH9owyqMi3cH+lBmBgwoiciqoa1WdpBYWBn9Zy8=;
        b=MZVpP+2gxgo2Nh23fjVqAI6jX1lZi1Q1Gtn9ed/LIqzVc7cVCGth9HZxKZ3/aQBcqJ
         26Ejn1+0se7uwhgoDPE6ZdgGvg+p+sV+Xvy+x7woHIrYXSx+LSvkecTtxEddotnUiHLx
         WMFfL1vtPXojVG3j3t824V2QrGYomdVz4Czv2z2vfXM8SYuuOwjBX3oIeYA4M1JG6egC
         odfakDVUQJqFhxWOyTZ/xZmUlhe05sHcVscybfyXc4XVB48T3BTeWil7gy2D08W5zD5/
         nWspeHb/A0Zd1zsJD4539rCJwhzUv7QTvngaHBl+9vfRZJj1hsu4C+kDYL0Hx2yOkT9U
         zkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747164063; x=1747768863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWugkH9owyqMi3cH+lBmBgwoiciqoa1WdpBYWBn9Zy8=;
        b=I7U2mK+9G/twslL4mqyoDAuIz8wPDWpeYF51FEMGv7wDLJ0gLlM/BP/B/Ur2OM7o4Y
         DWg8nG97+ohNqNPum+4kH9GMGt9dYt1DA7uBbRdN02UHRWJ6i6/cChMqdb/KYo11Z48c
         3xzF3w5Ign6UhPL0S8hnbW8g0Xk9KuV3goQz5xWB3L8DI8eJ8azyQbeGoWimqQVJKQ+R
         6f59um9XfM/zl+UkB8lSiZXQWMpgeyejBs7DGbk0uZndA8ZLwSA3Glx19hfyCXxtaeG1
         rx9tIMbWtTX5ah+eBdN/V74+J1ghMfW3pRLKakai6uW7Ue6KCZ6qAc4qLErNFV0beI7e
         QNiw==
X-Forwarded-Encrypted: i=1; AJvYcCWRHZMz0j5l/5OrYPjZmnRhqTKzI2QmGpJkq8mwjjlozeL0MkxArv/iImlcv2PbzwHIvEb1B7kA@vger.kernel.org, AJvYcCWmBpkuSDFWa3X3xtcGD3H5FNXBNT+DoseiFTiWdWsG+DhHcmmWY41IYFPNKr1iIXEbbMCWmUbvxt+zPPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQBpjSRU0I2IFMC+kuQFDOJmWjl+w6WQQ4afPA5381X4tl8vA
	kgcVZPzEm0oonwMPDWDIB8weXj41UWxAXipPgBzlddNNIC+WgKq6/PrcMwWM88uWujh9QZgAhYS
	3j8PWZjPQbH0ScvnOkRQ5wP59egI=
X-Gm-Gg: ASbGncszT0aqBwrFWkRWfmZ8Astlk4DyFJSM0m33MB0T7G5b5ynkQocn59FkmJENDQz
	ZKNr2unWDgak6lEHIuuGLqdxCXricUU/GXJOfE5LUcn4qLXes0jjGox2uQp3cYJh8Mk7UIIS6W8
	+lIh0Ly1INtZqTCFnQsLZySXm4NMuc3Ur2DLCmKc4EOCXgRiJvz54yPv9W/PVvCZ+2uOU=
X-Google-Smtp-Source: AGHT+IFFD0bIascMFJs5DAYZGzzmLLObhHeuIOwMPJBROnuNKXxs2pWRRLolHFdcj+r/LY6ZlnOhV1Wg/eFw5Q7QxdU=
X-Received: by 2002:a05:6000:2a8:b0:3a2:3c51:f4a1 with SMTP id
 ffacd0b85a97d-3a34969ad98mr413296f8f.7.1747164063367; Tue, 13 May 2025
 12:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511214037.2805-1-zakkemble@gmail.com> <e9830d60-d711-4fab-a4e8-329c5a3353f5@broadcom.com>
In-Reply-To: <e9830d60-d711-4fab-a4e8-329c5a3353f5@broadcom.com>
From: Zak Kemble <zakkemble@gmail.com>
Date: Tue, 13 May 2025 20:20:51 +0100
X-Gm-Features: AX0GCFtbzNY-sGYxywLd2p0dsXhZbl_2oMgDjh89v8ZxC8foayYnEIl-iCQWnu8
Message-ID: <CAA+QEuR0BDAwrboJrGkHf4y0FGoUef4jcjpz9wx0uJn-t0sUyw@mail.gmail.com>
Subject: Re: [PATCH] net: bcmgenet: tidy up stats, expose more stats in ethtool
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Heya, I've split up the changes and updated the stats reporting to use
ndo_get_stats64 etc. here -
https://lore.kernel.org/all/20250513144107.1989-1-zakkemble@gmail.com/


On Mon, 12 May 2025 at 15:35, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 5/11/2025 11:40 PM, zakkemble@gmail.com wrote:
> > From: Zak Kemble <zakkemble@gmail.com>
> >
> > This patch exposes more statistics counters in ethtool and tidies up the
> > counters so that they are all per-queue. The netdev counters are now only
> > updated synchronously in bcmgenet_get_stats instead of a mix of sync/async
> > throughout the driver. Hardware discarded packets are now counted in their
> > own missed stat instead of being lumped in with general errors.
> >
> > Signed-off-by: Zak Kemble <zakkemble@gmail.com>
>
> If you are making changes to the driver around statistics, I would
> rather you modernize the driver to report statistics according to how it
> should be done, that is following what bcmasp2 does. Thank you.
> --
> Florian
>

