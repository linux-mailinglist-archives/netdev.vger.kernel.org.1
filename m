Return-Path: <netdev+bounces-212366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3646EB1FB0E
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B7D1894646
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34C9247281;
	Sun, 10 Aug 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVAi8pJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FB1AA7BF;
	Sun, 10 Aug 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844588; cv=none; b=ZAFPnYKTySXb0mF1NM662PubiFfvMvtApjdWophkbf8junzB9XzWIMnmcZixdOEhvzCB5fqo4bzK3RyWD+eQepPCOtPlDH2Sx/E/dR/xmEsCn+ZwyyZaFxwXSF+w0ZHoRpARiRN23cuUGF/cR/MMe6djN9HrtiIHhEUjua3f+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844588; c=relaxed/simple;
	bh=1O7Ir2JV9F3FRquanCEG57N9yilLJmRdcXyWCErqjXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktRrpiw2+IMHqgRh9m7qVKotK4BKj5RJEg+0pSgaN4riycFHI6XKTCcHS9+ZiZCdQ80xPN2YaTqyuyZZHvwc0LYUqDMEdz/hfyKX3GpcDzzX0ME3vTIi2HNbnc0obPyzw/rlIUUvBkFZUZGahEe1R5ze9jYeoVAB/kclw8Wr/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVAi8pJH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b788fdcc2dso265748f8f.1;
        Sun, 10 Aug 2025 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754844585; x=1755449385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1O7Ir2JV9F3FRquanCEG57N9yilLJmRdcXyWCErqjXM=;
        b=PVAi8pJHHY/8oHFlvuQvUSML7QDWKPFusHDklGm/f2/hVcBxddUGv2l69duDGRQzgU
         lcRS6JJ311x16P9T9iGrScxL7HypsU3m/ni27o9rAahBAvFBlxZ/hrT6py+Mhvz/BPyr
         uvOk7VRn91TNpZ4tRywZ+zETSmBbMKQBmr+fj0FfRzlur41hnk5fmC57a9H/bw4yno2S
         sLajvFyyC3ySesrSDPANAbqZCWNNhQ9JM3h7WmcDdQYjPrplAxSrZ76mxcKb0EKvpy3d
         SeVhcL26buhC1G8vybDgOv2XfgntQDNU2PUkER0QkTpTipw5lGG8KN/XPt+mw8VuPsjL
         iA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754844585; x=1755449385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O7Ir2JV9F3FRquanCEG57N9yilLJmRdcXyWCErqjXM=;
        b=kTq7IYcgQg+WPajneWiRyEdjigf9al7ArWA/qJrdV3EuaAyWXWuTNMhCVzPn3AXzxE
         tlcdrjHrOuho80lf+qXXH5ui+A9xXBVbnx4bb5nOPbRdH3PTCIG9ObFkAAvw06SGB4gt
         nKm8py4eqgpS8oAbGOLxBIXUszoRwdOa1OnJXs86fwDfmaEZAXIq0ymyopIRRQjdm4I9
         WG1htbB+SmohSpgcNYlSMv2wlr8seTIt6iMu2ZNx9wVsFRQwwg36baWOyyBxcoJmecMc
         jiXWj67x6WFLeD/pLyPQrX4sdt+a/JBzWazXiMS7+VXvg18XNMvBREFGpl1wbOM/aufs
         EulA==
X-Forwarded-Encrypted: i=1; AJvYcCUo+aKCmMWWcIkOxElHZexShrdGnhfDyfUFnD3yVnDEzK/XGf13fofxfnN7IJOLvWbJcYMvtWAF@vger.kernel.org, AJvYcCVltb8Gvn/dpWJmpPDhkBMgTaAgb4QjRp+lyjKd6U0zKmCkWLGtukUDYCCj1IJjKPtLDDmoHjXHVajq@vger.kernel.org, AJvYcCXl594th+50gUpVpj1yyjvdXKLKRxVyHayYUuYUfjn+vyQKvlLJNNN0P8Qk1rasXasAuYdeJDAah/fqq3xY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4aWw3RsEiO2KL4VsqGallW4BGF6utf8QsbXbVQqnyxWirvlDM
	Yjuw6BMuCwrDMogeD5BATzXfIy3PHbTUuTdOC3iZ68BI/Pc4yRKxGoUg
X-Gm-Gg: ASbGncsAJNPTSupt75YRxQozq8SIzLHwvR2SCTmOGix+tKtRO6QGAdnhwEN0beyNx5U
	k4s/xrXOCvpJyCZtDKx4zHV8jDDYUKAsJ30byYNCWmnSJTGratqs51izYgoFyH2aCR8X5SMjNNb
	6pXyGanb36p6N9/f7JYDwlRrNn2vqbJJx/SB955DKrm34cJOeMCO/256IZDd4F2UjfPy6dE8Fk5
	/P/lt9mHfStcebm6TcoNChdrFCX45mAMAcJzXi9j3AGAuZzdEc+OOhxmACtgQqCs9902r77nPmv
	xCJIs1xFNBq9sGb35xN7KsjJxedc5fcSHoSoUzvIDe7wD/0J2SMA7gFX0fsXUtWBopUjgGTOXBs
	1xaHVLgGbMZe1YMc=
X-Google-Smtp-Source: AGHT+IF3CiPbtmzEifmcmnCZ6v8i8GbiWTGaqS99ZpLMhFYLskKAThOPIcEoj6BjqGlkH2y/M2FuGw==
X-Received: by 2002:a05:600c:820a:b0:456:1a00:c745 with SMTP id 5b1f17b1804b1-459fd04c3e9mr22165455e9.3.1754844584509;
        Sun, 10 Aug 2025 09:49:44 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:f9ef:f5a3:456e:8480])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm38395980f8f.28.2025.08.10.09.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 09:49:43 -0700 (PDT)
Date: Sun, 10 Aug 2025 19:49:41 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, jonas@kwiboo.se, alsi@bang-olufsen.dk,
	conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com, heiko@sntech.de,
	krzk+dt@kernel.org, kuba@kernel.org, linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	pabeni@redhat.com, robh@kernel.org, ziyao@disroot.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
Message-ID: <20250810164941.4oezju3c4vhnunrx@skbuf>
References: <db1f42c3-c8bb-43ef-a605-12bfc8cd0d46@kwiboo.se>
 <20250810140115.661635-1-amadeus@jmu.edu.cn>
 <1f2f8eda-3056-48bd-9c86-3fb699f043f3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f2f8eda-3056-48bd-9c86-3fb699f043f3@lunn.ch>

On Sun, Aug 10, 2025 at 05:15:59PM +0200, Andrew Lunn wrote:
> Just a guess, but maybe it is a DSA tagger bug? Maybe the user frame
> is a VLAN frame. The tagger is placing the VLAN tag into the DSA
> header, so in effect, the frame is no longer a VLAN frame. But it is
> not calling __vlan_hwaccel_clear_tag() to indicate the skbuf no longer
> needs VLAN processing?

For the original skb to have had a VLAN hwaccel tag, validate_xmit_vlan()
would have had to not push it inside, so vlan_hw_offload_capable() must
have been true for DSA user ports. But we advertise neither the
NETIF_F_HW_VLAN_CTAG_TX nor the NETIF_F_HW_VLAN_STAG_TX netdev feature.
So the VLAN tags in skbs transmitted through DSA user ports should all
be in the skb head.

