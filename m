Return-Path: <netdev+bounces-115950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560E994888C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 06:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113C52818E9
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 04:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03115C12F;
	Tue,  6 Aug 2024 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4fTcYv6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7801AB52E;
	Tue,  6 Aug 2024 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722920140; cv=none; b=Kboa6bKaCIHau9qR1F6a0Bx8hJM9f190xT8Pncs3CVnsSWEvJO+0LxzeWBstK5VkDaplBimT6Geb1588CatZbDeksZcFwAQpdYywxH+M/kG4tcKytGUogW2IYP3T+VnCatyH5pLwlkzLzqvPNhXLuQW5m5Fx6Jo6//lgaIBbHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722920140; c=relaxed/simple;
	bh=V6aEin38HIBAhSWBUgzuxQ/TflAZ/IatsBUD75c3jOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiM3cOScpIhyhWDpi4uQn1y4N3VSQeTd1qVubqwPQXLG3xrqgqGgLkgf73w2rigxMw5s1X56rUUTGsmPHsW0zSIk65y53dEVw6sfbwZT/XFE1jeSW/ftaXcJzKuyGHTiVQyt7tuaUjYSXsaJSv8kDsu97dYjcfNK3q9+To+3wQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4fTcYv6; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7bcf8077742so299368a12.0;
        Mon, 05 Aug 2024 21:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722920138; x=1723524938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85q65meJHydsbw2SpNer02iCevJGYGCAkmgA8yKAoQk=;
        b=V4fTcYv6ysmJLTe3WsE5nzA5xFkMNgcNwotpGpzugh6UbAYiCZumsPjeeOyCaYK+uM
         DIJHv8E1yRTiooOzqWnw+iTy2zYnkt1yEfuQPfRwyRYFhrmDY2juaoHwPvSvCL9ojT1R
         behYm274AeGV7oH/AjXlOBYwodsnFsdzopxyDDmn5jvrR1cpmF1X8zrqlrreZQdGNU8v
         /2dAUFraeu5QeDxq4oOFAPiU/TvFW49p6ECPfob5OHbHl1MDwXQjhcobPoMOMY2hID6n
         7raLRCCVMU4mRwXRsAOjfUj4UkA1WekAWNlr/tlBAF6EoDyjwTiY+hsTEDpxnJEa4xCu
         30Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722920138; x=1723524938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85q65meJHydsbw2SpNer02iCevJGYGCAkmgA8yKAoQk=;
        b=o8AH7zbFKr1BQJ2UQeQaKPeA/mGxq9uQFOy/yG8s4wlq3IvSpCiEsfgHsjJv37wN7G
         gdrgxnBudBF/7nYjbmWzqS4mwlQIhl0mompa9Rb+riXbgYh9s9EA7v01fWow8qeLplmU
         n8eeL5ZMEIPRCsc2LVMmG6hhMp6onxzNn+sWWVCxhiP8tyVPVjyKfIcPmfhmO5RhY1vl
         Td1VDshKjp1HttOH5q1VbaPCjW6AogKoWk646sAynxh/hMa4hF8zbFyxWapUnY0SuiBB
         b1htr9Usggsh20Gcpr4n6Lh2wiYswoxrkfPbm6VYG87gaIAstWi7lfOONPDYTicgglRK
         dnNg==
X-Forwarded-Encrypted: i=1; AJvYcCU1UD8HeCt3uxrCycx/mhpS208Al/k4CfGzFQcHzEI/vFkCtHrz7ngU78fIhvmGsuNHneFPfSAkVFDJi5Y=@vger.kernel.org, AJvYcCUrYeNeRVWZw/R8SGniqhlEgr5/6iTpPNfyf/OZN5YmHj3lamfrRhUm+k5cd8GfFvQEbCP+omEK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa30wxSCSaD3OtIa3w6nmMEKqF90wnghhJamMICbTYkWtk0sBY
	GulCCPdiYfBkEGHRtktAtMUQqa4ByJ6QrsU7Tr7BJ8eTfhnBmmR4
X-Google-Smtp-Source: AGHT+IG9oatnH1xHVkWpI886BnKzAhj9hlfqXwSP17RhqetcsZVbRZp41LdrRYdy6alY4pR/K0sltQ==
X-Received: by 2002:a17:90b:1094:b0:2cf:f3c5:871b with SMTP id 98e67ed59e1d1-2cff93d40f1mr16111394a91.6.1722920137930;
        Mon, 05 Aug 2024 21:55:37 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb36bd3dsm8080980a91.36.2024.08.05.21.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 21:55:37 -0700 (PDT)
Date: Tue, 6 Aug 2024 12:55:24 +0800
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 0/5] net: stmmac: FPE via ethtool + tc
Message-ID: <20240806125524.00005f51@gmail.com>
In-Reply-To: <max7qd6eafatuse22ymmbfhumrctvf2lenwzhn6sxsm5ugebh6@udblqrtlblbf>
References: <cover.1722421644.git.0x1207@gmail.com>
	<max7qd6eafatuse22ymmbfhumrctvf2lenwzhn6sxsm5ugebh6@udblqrtlblbf>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Serge

On Mon, 5 Aug 2024 20:11:10 +0300, Serge Semin <fancer.lancer@gmail.com> wrote:
> Hi Furong
> 
> Thank you very much for the series. I am not that much aware of the
> FPE and ethtool MAC Merge guts. But I had a thoughtful glance to the
> FPE-handshaking algo and got to a realization that all the FPE-related
> data defined in the include/linux/stmmac.h weren't actually
> platform-data. All of that are the run-time settings utilized during
> the handshaking algo execution.
> 
> So could you please move the fpe_cfg field to the stmmac_priv data and
> move the FPE-related declarations from the include/linux/stmmac.h
> header file to the drivers/net/ethernet/stmicro/stmmac/stmmac.h file?
> It's better to be done in a pre-requisite (preparation) patch of your
> series.
This will be included in V2 of this patchset.

> 
> Another useful cleanup would be moving the entire FPE-implementation
> from stmmac_main.c to a separate module. Thus the main
> driver code would be simplified a bit. I guess it could be moved to
> the stmmac_tc.c file since FPE is the TC-related feature. Right?

Thanks for your advice.

A few weeks ago, I sent a patchset to refactor FPE implementation:
https://lore.kernel.org/all/cover.1720512888.git.0x1207@gmail.com/

Vladimir suggested me to move the FPE over to the new standard API,
then this patchset comes.

I am working on V2 of this patchset, once this patchset get merged,
a new FPE implementation will be sent to review.

