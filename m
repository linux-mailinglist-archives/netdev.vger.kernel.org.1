Return-Path: <netdev+bounces-236983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37FC42CC2
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 13:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCB53B08A8
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17DB54654;
	Sat,  8 Nov 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Loam7QVj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8B1E86E
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762605069; cv=none; b=RIev7NRGOndL8XzZgx5U6x28W7YwYnqCwnR+FCSn6p3myyQ+LiiZft+tevfwOwVcS4zYul9YgxO1fFE3zhLL+2YZyMoPpUnGU6BQQNYEOxAPXJ6XU9xZEQwXJHuSO9m7ZuYocHbM89TcEAHWqz399LeHSTfQuYN2YR8pdMWj3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762605069; c=relaxed/simple;
	bh=8xzpprXbiGBlRsIHbzms9s8FVApMbHJGm/eVCI6hf4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQWzL4vsM7xLzZAj8uc2JRJab58uABpopwmL4jeK0QRoUIpWUhamT191LBQl1yMq1XeES8jIbBgE+XJgk+c+Hyf0amQIwY1yjV65nymalfALHEiCCh8RTpxk96DP9qHJqQ763/yyNzK9nYXBL3kd59ENXpY+pcjx5gfAy1YE02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Loam7QVj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7af73974a4bso1047288b3a.0
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 04:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762605067; x=1763209867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xzpprXbiGBlRsIHbzms9s8FVApMbHJGm/eVCI6hf4Q=;
        b=Loam7QVj44sMASwft12mduNAZuzz+cLafIIEDIrjbBLczNzLbg8qnK1ezBPqY8x5D4
         aPR00wjmWD7MDtbXA6JgENpaKoeQpCkOEQLYBsLqmeZ8ti/HAau/W7kSQVL4orbyp2cn
         wmKdx7oO+xid1qjlNZM3lF3qPJ2Ic6+J26WsDhgNYj5pGhF5FuOpE8JIwWBGkgUvdBXa
         Q4CgPSXSKJXcEBlygS07lxq/HGubsz/y3cLQP3T3eHGq5++H/xYiEXcO3X+nbMQwW7ch
         TepEfPR0tvDfpxfy4KLRKEm3DdkG4R0FncZUbjIaCIFk2NBFCvqOhA3/uVuoSRb99bya
         4viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762605067; x=1763209867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8xzpprXbiGBlRsIHbzms9s8FVApMbHJGm/eVCI6hf4Q=;
        b=VjGSHN8EzXRt0E5OKpB4DMQWZCv8fYTqn42k11ByVkmXCJ2NP/qLuQ2MH1WPBnUwo1
         FxBJLIXVHjkKvelCKXp4L4GWtKhxJSdKAbzWwxcbCEaIKkdUVsU4OiISf6d0waZz0nwg
         qFCKrzK6dX+16fwTn0QFlKxK2DwLkh57JX+o9xCXX2uUZKj+Ez9tYMBL/GolO+QQgp31
         2gZ3zOWCrzIf5HEFDUhx1VscY41oUCUMhR4RIapwpaQZj4OxkLXg+OPon9SGCto3hdN+
         BHyst8xEWX1oGvjABV+WxTb0PlAtc5kduv9Ob2wksjl9I3wjZ3FNXi3lrdYKERYiZbLg
         NFRA==
X-Forwarded-Encrypted: i=1; AJvYcCUshbILGJJYINe3+jUxvSCYQwmq26w9zJLEt2PcHdagov8rOoREk0Yzl+oJcR0/lzZfVh7MOus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+R359kGUCx2eh0PCqbLmUVLvqzwiFGmYx+E7KCv7tlsumTEEC
	2QUZ465muJ4n6lGcxYH1UuyOLjD1yaXq+D+BbZ3X0dEtjGZiiK4/YmWBQYkBhbPWD8BZVD1XVva
	rnlYmaOq1fGhkCzD0eaX/4dVQEJgS09U=
X-Gm-Gg: ASbGncunR4nJ9wweOlAotM4z16pgccbwM1qTGe6Q79ijkh7txefuiOSncage00eG7b2
	aiAZYfXlQURH76sbg4Suh58xG2kNad7O6HY1IJrfVJU+Tt2SHrE0BNZ6hGxr86KrkgG8cKSG3VX
	EgxbxqOC2Wwm0PF7v3uj/QOOWZ/LlyLjixTOgiT96GOZQSX4TTpc2NkkN9m8veZW6eFBsOdH++R
	+uNmGydQbNupeVW/XVbPVbLCfyMT5weemIOnQ/+/XWVq5L5bvkKf+FbmMyFI9P9WE6A3Y+7NXod
	ZZqnzAJHqdcrUmmm
X-Google-Smtp-Source: AGHT+IEuHvgMZMmDRNRPAfeOAymHEAn1hYvpEGWDduP2LeVblYn4NjcSRVQL/UdeJaq1Z4u9o2SDmDIZmKAPg0jARQs=
X-Received: by 2002:a17:903:3804:b0:295:5898:ff5c with SMTP id
 d9443c01a7336-297e1e3429emr34741885ad.16.1762605067406; Sat, 08 Nov 2025
 04:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQ4ByErmsnAPSHIL@shell.armlinux.org.uk> <E1vHNSB-0000000DkSb-3fWL@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vHNSB-0000000DkSb-3fWL@rmk-PC.armlinux.org.uk>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 8 Nov 2025 13:30:56 +0100
X-Gm-Features: AWmQ_bkQCCCHuH8ylnNhyHhFQTUKFqSEN4LNOb9Me0YP6OYeddbK-4LWE8Q83H4
Message-ID: <CAFBinCDf4rHs-Q1ZVo_WqF1r8_aLJ745B0tG+=6NpmbBOe2c9A@mail.gmail.com>
Subject: Re: [PATCH net-next 08/16] net: stmmac: meson8b: use phy_intf_sel directly
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Matthias Brugger <matthias.bgg@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	netdev@vger.kernel.org, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 3:29=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Rearrange meson_axg_set_phy_mode() to use phy_intf_sel directly,
> converting it to the register field for meson8b_dwmac_mask_bits().
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

