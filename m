Return-Path: <netdev+bounces-109292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6F927BDC
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4EE1F22FFE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FAD2BCF6;
	Thu,  4 Jul 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWBXAUA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041144C9E;
	Thu,  4 Jul 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113721; cv=none; b=F2H/BmSCeP9eKEPTzCBQWx4IKxTgWC67MH3dnqanOhHECrpRzy3IAiRh5Zj4murt2EZUupTxW+urW6/SpRWBayJ3gp3CIz1IRwYMoKqioUFbN8dwqFQR7LZrOo9qbzEoigBPy1zt5arVI8FvGslIKbEA2UD732nAPD9XXE1KRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113721; c=relaxed/simple;
	bh=N5Rrw2MRuk1dzaCiuF3YDvfjUvsE9TiN6DdBtTtQZ8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1qTv6wdizsGbeljo5/hf56xM9vFc4J1qEUwSNrfmBjeItrQujFfXfgUbed8gHNH+gQ7nuxIR9Q0aSUC6XZJF5bV9RWMNUFrpYW60LJlMJmiWfT7QvoUW1vZxYkBZ/oEjp5H9x4KOScspzFIYp3QT3/3rBvwfGO+Wu+nSBZZCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWBXAUA+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367975543a8so565947f8f.3;
        Thu, 04 Jul 2024 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720113718; x=1720718518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xbMuRw1sQkRSiFh279rXdYSfGjfdwITvelsunE8eQ+o=;
        b=fWBXAUA+lTkpfUxhEbgPnjQ+/Jn4U+iYC8hWavjcHfKbJMSSiBQOJOqif47utsbmR0
         B+u3aVwKy34iFogc8rmFiFgN2MJdiBQJR/uWqanGx9emwmBAp/VKHn9Qo3AlPbhEBUaC
         RWtqkTFbzbvuJ639vAd2CqdjsofY33S1nZLNmrDBONPKzJGhVijtMNXB27NNgW/YB074
         scJ0DE/f0lqm5F8s2nJpeKCyVmxn5OZZEToCB+JDMhtWpeMDoYeGwcj8BoLaG6DIwFZQ
         p6xHM88Voyh+h7qRSNo+TSKlczsr6Ai+zORxO5i9rDfXNXt2AB1alCHROGorP7xVKBRo
         7XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720113718; x=1720718518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbMuRw1sQkRSiFh279rXdYSfGjfdwITvelsunE8eQ+o=;
        b=lNhpp8QK8TcR1+x8zaUrIKupPok6G1pP/NCylw0rxJqQETjCtSJgTiitO1/dcLMxxO
         ydTOchNfiEzsvhsz0aHpmsvEtTvMWnPT/IaVS4q50fQiF8GapH8mDcQunC8fSMvCE9Sg
         ++oYIM7KUAevdtApOvnEpGTrCprT2+WY+HNaFRZgol+h0RrbfYXQoa+9vOS+L4uzPcS5
         XyU88n5bHQsuW3EC4+8VGcuSHF+JVFMNx4VT5hubcNjVXU7DYIj0qW2V/5X5+kMsg0Ii
         d1PHXUrLiw5U4VOrGnCDByoZCmIrmjePCfOoTVvznzK5SSpEmNni4aawduoDCfRSK0rU
         ttcA==
X-Forwarded-Encrypted: i=1; AJvYcCVUIBnK6pXU0sexpksdPYnZD+I/rVgTCgoLJNknfF60ccGapHthG51pyyjYPEQJ7o09Nf/WPzbaLSruMkz+xalMp5KXgcTNs/bmk/c61KCCSMFGzguR3zJadLI5Zj7SXKELnd2k
X-Gm-Message-State: AOJu0YygRSr8FkmiPZh+GDDCb1D5ytXow61r4Ws0D7NHoupUdSfAsYyL
	yGEmomzbZteCjAXSGZ6fZDGA14x64OsHx2UOylq/OobzDRuPSjIi
X-Google-Smtp-Source: AGHT+IGdluLbnk0hTBC/jWbHuttDDQoIzwdZNIhKDlVq3XycWj2L2MDyVC25gNmwdtGq+W6484Ov3g==
X-Received: by 2002:adf:e94a:0:b0:367:88c2:23a5 with SMTP id ffacd0b85a97d-3679dd2b344mr1283829f8f.27.1720113717962;
        Thu, 04 Jul 2024 10:21:57 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367947ddebfsm4574672f8f.34.2024.07.04.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:21:57 -0700 (PDT)
Date: Thu, 4 Jul 2024 20:21:54 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <20240704172154.opqyrv2mfgbxj7ce@skbuf>
References: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
 <d3ac5584-8e52-46e0-b690-ad5faa1ede61@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3ac5584-8e52-46e0-b690-ad5faa1ede61@arinc9.com>

On Wed, Jul 03, 2024 at 10:03:09AM +0300, Arınç ÜNAL wrote:
> Works on standalone MT7530, MT7621's MCM MT7530, and MT7531. From MT7621's
> MCM MT7530:
> 
> [    1.357287] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip module

Why is the device corresponding to the first print located at address 1f,
then 0?

> [    1.364065] mt7530-mdio mdio-bus:00: [Firmware Warn]: impossible switch MDIO address in device tree, assuming 31
> [    1.374303] mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -14
> [...]
> [    1.448370] mt7530-mdio mdio-bus:1f: MT7530 adapts as multi-chip module
> [    1.477676] mt7530-mdio mdio-bus:1f: configuring for fixed/rgmii link mode
> [    1.485687] mt7530-mdio mdio-bus:1f: Link is Up - 1Gbps/Full - flow control rx/tx
> [    1.493480] mt7530-mdio mdio-bus:1f: configuring for fixed/trgmii link mode
> [    1.502680] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=17)
> [    1.513620] mt7530-mdio mdio-bus:1f: Link is Up - 1Gbps/Full - flow control rx/tx
> [    1.519671] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=18)
> [    1.533072] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=19)
> [    1.545042] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=20)
> [    1.557031] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=21)

