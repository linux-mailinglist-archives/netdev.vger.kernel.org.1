Return-Path: <netdev+bounces-103992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD83990AC91
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846221F22D17
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37319047D;
	Mon, 17 Jun 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y1Mf+C6N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2C73164
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622301; cv=none; b=qmF9HAzJh1LYYl+2mLHynIpofdw0tBQdnEv55ZqZuEaQIlbP4h92Pl1AQeFsbTY12CLO/YTY3UkcQdRuJQPEQtgtMLO9QABTCIpaeQ/xRMWlE5GqnDY9bvpZOJHENa3+uvFYS02aPzUEZWpGyyTPg/tlH60wfGO4NfT7Q9CCXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622301; c=relaxed/simple;
	bh=3qORiEE5M9optyTrFU3CyLuP3Jx28FNOfatBvsvLqeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEewsR53CXZdF+xEjE4JdQJU3lao/kATxMNCftjh6qLe7ycveAATB1vyQKEWhLad1JZpMf4p7HVU7pyM8QohUw4FU5CgILw+bIJlw9mPW+E8rGBB3uIQ2sj8hei3nr/V8wFqBYGkr5MnnQ7++nA8WjCOQa32JhX6XGX0X9ojatE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=y1Mf+C6N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217d808034so36930465e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718622298; x=1719227098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qORiEE5M9optyTrFU3CyLuP3Jx28FNOfatBvsvLqeo=;
        b=y1Mf+C6NeQ6TgKAeqkA1L+I6VYMVIcrG6Yoc+wbHOoZX9+s9h1I+CJh8Mv3Fo0tIW+
         4fVLhEBY+WG4IIN7XKLYmmg1V7MYwoh+2hXEn3D0ItnmTN5D3s+G+L4OOV2ANFFjw00D
         Yxp48K7Huf0YJ4uJWZ6vVGkBedVPb0022d/xnebdLG5a9z4Sr1MuD2xAYKduaq6bPppQ
         gcgayeMBjJB6sLdLsNsQYeFH3zdlvFdXA7F3MFA4+7e9DVKe2gpdVZvTqf0htxKcqd6g
         hvT2uv0/hZkJqdcMHad0Vf7L8wGi6pHZ/1Dwwiv6NujpEQM/7pUxDZWWnF5xIpCZs9Iw
         YdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718622298; x=1719227098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qORiEE5M9optyTrFU3CyLuP3Jx28FNOfatBvsvLqeo=;
        b=rgQaU9hR60xsJEPPCGPeh9SSTCID1SblWe6NO36FCzAZIcOVo8ZN2mSRBkzGpzNScq
         Fjr5yZKtYt2mH660MowdqypuB3J++mm+9lBlkIqZevfmKtNKjCSV/+TJgL1fr2h8p1C+
         54G4Ofp0gRYFOpQdwszYK+3huetSshtHNqQwfSUdLvze6fwydvpFzAkhbZ6skUE8JQrS
         64oVhpNcDomjSg/93zyi7ENpN+Cci3F/jANqtYsCOUmi1lMUOlU1CIVvKfJXZrBmh+zx
         rw3IT8ilMzpnPCzo1DtovGGUrEMf1/OGjBhgbtiv+JKmHFtBEJGg5gN4cq+p04O5iq8o
         5fgw==
X-Forwarded-Encrypted: i=1; AJvYcCWDPegFYLMSZDmwkRRv4H9mGlydce2sMM2VHVHchz4EWhsdypnG16OOORvn93eJ3uijsCvtif721eaB3das2XIMvOGAfO/o
X-Gm-Message-State: AOJu0Yyuxog4yZlF18D9roQOu/k3IrXmYjiroW00YwKcEhbtymqdfByL
	Xlh4VUBWN4EE95rIGVJA1QXELu+ws6aKQmmA+z2/DM37YsfZGMJAdwHYOszxLdY+emokkIQlLEP
	0xKjx3w==
X-Google-Smtp-Source: AGHT+IHY80bEQptoc3M5uPoOPvK/WIzy5fFAbdS0fC6vAPCAtC/168s+7ed/XFen5aGNMn9KBFDXFQ==
X-Received: by 2002:a05:600c:1e29:b0:422:1a82:3ebf with SMTP id 5b1f17b1804b1-423048592dbmr72452565e9.35.1718622297510;
        Mon, 17 Jun 2024 04:04:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602ee95sm159482515e9.13.2024.06.17.04.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:04:56 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:04:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: dwc-xlgmac: fix missing MODULE_DESCRIPTION() warning
Message-ID: <ZnAYVU5AKG_tHjip@nanopsycho.orion>
References: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>

Sun, Jun 16, 2024 at 10:01:48PM CEST, quic_jjohnson@quicinc.com wrote:
>With ARCH=hexagon, make allmodconfig && make W=1 C=1 reports:
>WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/synopsys/dwc-xlgmac.o
>
>With most other ARCH settings the MODULE_DESCRIPTION() is provided by
>the macro invocation in dwc-xlgmac-pci.c. However, for hexagon, the
>PCI bus is not enabled, and hence CONFIG_DWC_XLGMAC_PCI is not set.
>As a result, dwc-xlgmac-pci.c is not compiled, and hence is not linked
>into dwc-xlgmac.o.
>
>To avoid this issue, relocate the MODULE_DESCRIPTION() and other
>related macros from dwc-xlgmac-pci.c to dwc-xlgmac-common.c, since
>that file already has an existing MODULE_LICENSE() and it is
>unconditionally linked into dwc-xlgmac.o.
>
>Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Looks okay. Missing "Fixes" tag though. Please add it and send v2.
Also, please make obvious what tree you target using "[PATCH net]"
prefix.

Thanks.

pw-bot: cr

