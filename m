Return-Path: <netdev+bounces-220222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E42BB44C9C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 06:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79AB7A9CE9
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8425D53B;
	Fri,  5 Sep 2025 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AJmhAq/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADF23185D
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757045409; cv=none; b=SrLW/9PJ8qeJNQQwf5ArQqJka3obAFIuxk/2oJQdMll+ACzLK73QpcyCG42VCq4NcWP73poUzn8P9RW+pjf11IF+QEQovffGbPyncCXLzPeRDdcqMT9TxwIUyPUl7O3cyXytfVIk3lE/VAMZ4Qs6wljb/Jp+/G2qgCF9mSJqDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757045409; c=relaxed/simple;
	bh=KLKUHPIcRB0O4muuVCBP8C+yFYqPCsP1VfYmF9nYOvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PezEe1+cyxhF6lGwMLE9EgBGXQkMFXDlzmYOVC+BH1XZs7iwsnUqMPxuXxhgAwjjts1wW4sP2bk//9/N9NXfouo0AEBY7HUMjDiTU2jEcfSp+iPOK/Bs/IULo5udpKDvPXYZLwdPdy6VZrXwACGx1TnZIysdRqUr1XbBaXKVMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AJmhAq/I; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f6507bd53so1841669e87.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757045405; x=1757650205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLKUHPIcRB0O4muuVCBP8C+yFYqPCsP1VfYmF9nYOvI=;
        b=AJmhAq/IP/BSeLkYccBXDi13Lp40Tvzens1nJ4WoC96MTkj51upPoaMdlbP2lw+rek
         HmuWGup7FR1jfacuCYzjWNmncw6qQwsRlHjJUpn0vB55FPRTxJZdnhEB+CjTekrH6Lht
         IhNDMHwmyGKR9OQW7QmfLz4Z7E3axvGkJpoXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757045405; x=1757650205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLKUHPIcRB0O4muuVCBP8C+yFYqPCsP1VfYmF9nYOvI=;
        b=TB8cjFBKSj8zsmFqY2c9FqTMRw9FOzTEgnBrpN6Szc8qq/sPdenEkhrPKDsHfovgX/
         q+U+nJuL0cqLRFGeixz+6iS5o4GL3XrQe1t2WUTCJA1jjvTm02BGahbDnCr+HvM9FrYg
         mkc7RLhMkGDB93mdPa/7kxb3GctpSwgzdX9Zs4E1CNT6SzFOiaucbV0ZOwxC3xuG8ewC
         d4N2mssjWFsD5lYoS6PauYcHkPnPr+YoktwLVpD3bIj+GaXVsPgRi/0lgwzdETQl9kdf
         70VeHPa2hUWrnDI9gKmgKEK77zbqmcvvxkjSwDPpoc0hopxBxh+hcConvbWOLQblQmMb
         KZtw==
X-Forwarded-Encrypted: i=1; AJvYcCV3udicmspltCOsigSlfe5CwTLwqvVsKZl6h6Gyw0xe8Kqn1O1W9oyG8XGkl4pPlifGTRxTweU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4l5NA8QnmYRpg3wCSo9QHNS7gU8I/nNaQGM359SNKWg2qtan
	x2BzaI82FT0VjrM+5XbXSwQJ4i7G+GYC9SHSLtEc0LKHWq+1ReIki7qDuDbDbq8/qD3wfNTxhvb
	JvTY5SN6f0WGgT9w4XoriRmtX/rYt5662T8sO8sVp
X-Gm-Gg: ASbGnctCJKwJyxrdQkAAzN+gVi3O5HxfqG/TDvEQnMgnaQZfuBIe0yYJAwHSs2FZzQ+
	DSAPg82P3a19+gvZt1FSfFM1+zeFBdWG3Ru+1pz1rTL1JgBGNWGci45hglTHaC+7m+exauAV7bC
	atekYHvN5+g2TabVRca3nVQY3hYEGde3yRlMy6+fMz1XMqNqagkZqGm1EEo4OgtARcrT3gkqrlq
	dKTB8IhMk6ytfgmalKpp9DE2fTemWeXsvE5Vw==
X-Google-Smtp-Source: AGHT+IH7HKhnxC6o9ewQ28R2ZzX9RmDQokY2C+2i+wMjE8WlWqsz+BTU++rL/6Yzgiv59B7OTvBGnUhQzmndeoe72TQ=
X-Received: by 2002:a05:6512:650f:b0:55f:65f9:512e with SMTP id
 2adb3069b0e04-55f708a2a7fmr4251279e87.6.1757045405415; Thu, 04 Sep 2025
 21:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-4-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-4-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 12:09:54 +0800
X-Gm-Features: Ac12FXx6pAx7CiAA-H5MAQbshXKRXROm_6MtHlpf5-g4LpJf9Fu8XFakXK69rOQ
Message-ID: <CAGXv+5ELv9vR7i_Xd7XCC7gBciMXPfQfDAD1WyNy89=pJaLC_w@mail.gmail.com>
Subject: Re: [PATCH v5 03/27] clk: mediatek: clk-mux: Add ops for mux gates
 with set/clr/upd and FENC
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:20=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> MT8196 uses set/clr/upd registers for mux gate enable/disable control,
> along with a FENC bit to check the status. Add new set of mux gate
> clock operations with support for set/clr/upd and FENC status logic.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

