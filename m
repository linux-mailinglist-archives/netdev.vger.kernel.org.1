Return-Path: <netdev+bounces-160608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D016A1A7EC
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23051664FA
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AC6212F86;
	Thu, 23 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGJC4Zmz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578FE211464;
	Thu, 23 Jan 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650119; cv=none; b=bvZJ22gH7gGs/Jdaz9+61du5fFh/e8ItPGX+hUPdvQwYny7+0n8W1X7L+H8biIimJiukmnhCM0ZJZ5poP8lFE9B6Fi3cOAa09IrgJkNIPuQ69RvkoXQYH1waABx12DLvjHg1leeJz76TiEMgpqoQMBf3txUTvYSIDFLXTNpFYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650119; c=relaxed/simple;
	bh=vF4G7cHCJjveZ2c96Umb8UF1SOgG7D16IAO8eiP//IY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lK0xh/EEQoO7QQPq2f90JVJwn0L92J3T8AfuDyUAcMS801sd/yrpj1M5KLaeneDeAlHebJ++CTj47prrMH4r2w0tEDdcco4PDAJncTcO/vkN1PHnmgX5UMBxQkmxrUEc0LzNP6NYMAkPetRWN+imsHpNNVg4NgJT0uWc9YZwNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGJC4Zmz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21644aca3a0so24999915ad.3;
        Thu, 23 Jan 2025 08:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737650117; x=1738254917; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=37PCcaFsphtONjU1WuGj3LJHxxawzOceGVtfL5iTpqc=;
        b=YGJC4ZmzkHr/s6CNGXpjutA1BrPqEoEGQUxOlbM95Uu+OwgSaWMy3Jwgj2OCrI2XRU
         uN17UgJ0Dw+eDWbMz4Ei7gJ6i6/gdHRghtpvFAa32JYobp5klBnRVIfpKYbcBaodUH3B
         l1rDH6BzJ3dzyAAMipJeoZHsjE4q4kz7u8G3T1E5uf6TQK2pN46NTMXIL+q5avkXMlD6
         UUSRao0SxhUMx2NkMK0N4hUVQsYKrsw19CojYbhpCC4w3bx0a16xMxckDhnmp4t9rV1B
         FT/4z6cXgAGlfazcPSvxuwzjZi7AxawzXAr9KE2S89bsLGoYqxUn94M3JSbOMKJ+Bpbb
         vCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737650117; x=1738254917;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37PCcaFsphtONjU1WuGj3LJHxxawzOceGVtfL5iTpqc=;
        b=FnNgfwiH8hHbUsYCH/DTJDLsXbfhtaD/e0DY5rPtZR/HvtSV5mIF7FFClovgJI38VZ
         1/jqt14WcI7cJEgj1dNZ3tcexdXRLeDW2/VOoDiNDsAtSR0cQ9ie3i8b46sUJ+pAe7Iz
         7EFtwOumxihld2PfYqiWAGHO7PB5E7mcCNyopjmTEJT4GSlzNbyzu/Sa3/gChNuLraI+
         MyfvdrpDH0i0e6eQzfGUp3Uai4vy84kpQVYQJk5D7L0UduGq79fNm92aCavhqQa+sYjr
         5v5sMaGdSdvtr62Ef0FhErQ6U55x1nT1F2LkcW+Op25mX7z6M/9V5bN0KUURE0wK9vGn
         Ow2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgR/SktY9Itk4MpSufk9Yu31f8N7My3gHkzh4H4sQ3KoR6Azg7iGfG9jnimqwHN3BzaSUOLgjlQgzQSuE=@vger.kernel.org, AJvYcCX4l1N5QQNlfimwKgmxq0zYzQEyjqOcBKUjMZTYEEqhg/C6l8FZrc/rpVo4eizg5wEwKV7pG9O4danAawE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoEl663hsjgG85+nnTdWDS/tlafEuQc5WYiJn2uhqL4m3pSyAv
	XXI0wePgJWTT19EnYmJGU8mncaXbC/e0mvNCRgWbSdve4ga/m0x3
X-Gm-Gg: ASbGnctQtpALuCE0uKTuuvW9CtzYLMFyYEm51O97kUXIQeplUg/sJ6J3omMYYlUtWW5
	WUHsroM1G3KKbtAjVnwI9p7tIhDEDWSGdS6QduYmu50Zzm9ypNbSF/gkBGyUb2c0Un/1r5YgMFC
	dOdMHXhNYGS11HbseBi/9D4fppFc/rAxHEBE6phMcFko1e/UpbjmdU+g6rnptmEA8at0jkoIXw+
	cR8LKdToXjYJJSwl9T6spDA2PQphY+3ixnZ72FQhSiPnD//pWGJz01+qCsAAalSqd9aX3Kqixkl
	cZ95ECyC
X-Google-Smtp-Source: AGHT+IFs4lUJjgFulZgoKt9vLCAMNVT+ssvpUR3RYJq7IZyHJnj6PWguIOa0Hbt9lV14uqVBhXgqSw==
X-Received: by 2002:a05:6a20:394b:b0:1e1:d22d:cf38 with SMTP id adf61e73a8af0-1eb214f0f61mr39291398637.21.1737650117287;
        Thu, 23 Jan 2025 08:35:17 -0800 (PST)
Received: from orangepi5-plus ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a76115bsm117705b3a.108.2025.01.23.08.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 08:35:16 -0800 (PST)
Date: Fri, 24 Jan 2025 00:35:01 +0800
From: Furong Xu <0x1207@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato
 <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, Brad Griffis
 <bgriffis@nvidia.com>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <20250124003501.5fff00bc@orangepi5-plus>
In-Reply-To: <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
References: <cover.1736910454.git.0x1207@gmail.com>
	<bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	<d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/uWm=6.JKohvenzJ_Cv9eW2I"

--MP_/uWm=6.JKohvenzJ_Cv9eW2I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jon,

On Thu, 23 Jan 2025 14:06:42 +0000, Jon Hunter wrote: 
> We have noticed a boot regression on -next when booting with NFS.
> Bisect is pointing to this commit and reverting this on top of -next
> does fix the problem.
> 
> I only see this on Tegra234 which uses the 
> drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c driver. Tegra194
> which uses the
> drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c driver
> appears to be fine.

What is the MTU of Tegra234 and NFS server? Are they both 1500?

Could you please try attached patch to confirm if this regression is
fixed?

If the attached patch fixes this regression, and so it seems to be a
cache coherence issue specific to Tegra234, since this patch avoid
memcpy and the page buffers may be modified by upper network stack of
course, then cache lines of page buffers may become dirty. But by
reverting this patch, cache lines of page buffers never become dirty,
this is the core difference.

--MP_/uWm=6.JKohvenzJ_Cv9eW2I
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=force-disable-rx-checksum.diff

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index edbf8994455d..f00bcfc65dd0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5442,7 +5442,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
        struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
        struct stmmac_channel *ch = &priv->channel[queue];
        unsigned int count = 0, error = 0, len = 0;
-       int status = 0, coe = priv->hw->rx_csum;
+       int status = 0, coe = 0;
        unsigned int next_entry = rx_q->cur_rx;
        enum dma_data_direction dma_dir;
        unsigned int desc_size;

--MP_/uWm=6.JKohvenzJ_Cv9eW2I--

