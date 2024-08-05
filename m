Return-Path: <netdev+bounces-115844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7E948017
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34E9B2288F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B0715E5BA;
	Mon,  5 Aug 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROYTTswA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016DD155351;
	Mon,  5 Aug 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877877; cv=none; b=pKEg65CwQnpDMLtTHTtyjIIbV5PUrSp4gBSnV06pAjAhhz6j39NxxFDPuczROAp/P/5GD4S43XpSZoGnLjus53xlwPvnAjqgzKOd7gqbUTQbrTYedwnOPy7Sna6Ze5Q5MIdNTgp8basbKy7l3Yif8aeCBIqd5KKC2YfaN3Mom84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877877; c=relaxed/simple;
	bh=VbsbK8PogrHdKKvp3HO4vpHsdt+bePXo9w1wBcUQz5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAkAB9fPJjq7c+el/ukCC1NPiNAxx+YOV4rd2fTubTOrEfZ2Kb1/H3MQ+9fhBra2bZRx5IW6vXilWAMzYiRvqhG+AUXaqhLgn0HriXXHsV0UP0YzCulnkGOYa8Qtsxoge4gNZB62UlvFBJHRJFEcNiFlQzlXNntjXzz+aAqpKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROYTTswA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so164898781fa.2;
        Mon, 05 Aug 2024 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722877874; x=1723482674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+a9I4B8X1X5aIxeJdN5EzFMzXDoBQTuQJmnsOqPxxQ=;
        b=ROYTTswAJZlT4Er9TtUVWrOHB0dg4M0e8CEIV4CD9H/lIE74NqvEdC68+p/OzmbmTt
         VwQ641mxwOAzEdvd/WPTrbhB4g3fZmSlDO9jSI8KLL2lqx3ezbYR2Y/AoOTOiAxiLkfz
         GqdZjrkFebQlM4Gt5Zg288cUXoJd4Mj9vfr3+70jF0Iu2B2r+/mC31aHi8+zogVsIta3
         dbK0fSeJI3Qjq69UyuAPjxsHKHDQHhSbNGrh21vwoktjTpOF+KuVZCT1CXiOeE+cldks
         Ts/KLT0XCL1bbBukRiqtlixVbI6cnKSgrdOSH9K7vknUGMozwB3GEMcrze6lD6HCnlO/
         EUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877874; x=1723482674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+a9I4B8X1X5aIxeJdN5EzFMzXDoBQTuQJmnsOqPxxQ=;
        b=hqWowqwzUg3cgMX3MPhGTp3VU32IA0eQNm5BpvR7WyOz5MFFxj18FmJt4+5ZAtBlC5
         h6RKXuaXTZJqU3wxktsO8kk/ugcFOsthAH9jF8DmrgiiMo5Bo1prFzqKJljo4v4fRosd
         MxHkEi/P3sXzWjOTtBfhpOy1K1LmUpr2HdbCemZ2kqJ40jAniu1MxhOco8DfmJB50mEu
         8Ay1w/ulUVCi40iwqD5S0teEJrRIpPKM1IPMCPF9PDUYizpfe3r4fox4dmDr7ygggHjp
         RJUK3PzimhLjoXgIQqbnQ4jXZMW5Dq6QJd0xRyFCQnKHQgThq3QHUuBx3wGAXwybLkDY
         5BTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnJ+Vo3ZeqlVc0ydnn48HAvmlsFNvetiyqQEwMEF7c51dQWlGV/osAfaw22npydeg19QKN+UzUw3KakGZ8Hn0Zg87niaVXdQHtDGpG0zeFWpZBMmvqnx45Pl5WnOSnnKZfXBMG
X-Gm-Message-State: AOJu0YzIJ1foTiI7nErJ6Q2HOEJXCdsttwd3dTramdLJcKKft2F93zs8
	Fi6PAdhbzOgZU75xNNrSR/JK/bHh/WO9GYQiRMHNJhvDtRd63w11
X-Google-Smtp-Source: AGHT+IGReApxJ2c/JFELCklqQSZ8g1Zowv7VKiMDnfR8yosFr20pzjqYqbBTCKh6qA5FufB227lXRg==
X-Received: by 2002:a05:6512:3b06:b0:52e:9dee:a6f5 with SMTP id 2adb3069b0e04-530bb4d7621mr7953615e87.46.1722877873589;
        Mon, 05 Aug 2024 10:11:13 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba4aa0esm1202769e87.309.2024.08.05.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:11:13 -0700 (PDT)
Date: Mon, 5 Aug 2024 20:11:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 0/5] net: stmmac: FPE via ethtool + tc
Message-ID: <max7qd6eafatuse22ymmbfhumrctvf2lenwzhn6sxsm5ugebh6@udblqrtlblbf>
References: <cover.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722421644.git.0x1207@gmail.com>

Hi Furong

On Wed, Jul 31, 2024 at 06:43:11PM +0800, Furong Xu wrote:
> Move the Frame Preemption(FPE) over to the new standard API which uses
> ethtool-mm/tc-mqprio/tc-taprio.

Thank you very much for the series. I am not that much aware of the
FPE and ethtool MAC Merge guts. But I had a thoughtful glance to the
FPE-handshaking algo and got to a realization that all the FPE-related
data defined in the include/linux/stmmac.h weren't actually
platform-data. All of that are the run-time settings utilized during
the handshaking algo execution.

So could you please move the fpe_cfg field to the stmmac_priv data and
move the FPE-related declarations from the include/linux/stmmac.h
header file to the drivers/net/ethernet/stmicro/stmmac/stmmac.h file?
It's better to be done in a pre-requisite (preparation) patch of your
series.

Another useful cleanup would be moving the entire FPE-implementation
from stmmac_main.c to a separate module. Thus the main
driver code would be simplified a bit. I guess it could be moved to
the stmmac_tc.c file since FPE is the TC-related feature. Right?

Vladimir, what do you think about the suggestions above?

-Serge(y)

> 
> Furong Xu (5):
>   net: stmmac: configure FPE via ethtool-mm
>   net: stmmac: support fp parameter of tc-mqprio
>   net: stmmac: support fp parameter of tc-taprio
>   net: stmmac: drop unneeded FPE handshake code
>   net: stmmac: silence FPE kernel logs
> 
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   6 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  37 +++++-
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |   7 ++
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  14 +++
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   3 +
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 111 ++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  25 ++--
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  95 ++++++++++-----
>  include/linux/stmmac.h                        |   2 +-
>  9 files changed, 248 insertions(+), 52 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

