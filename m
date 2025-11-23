Return-Path: <netdev+bounces-241055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC03C7E384
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 17:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717C63A8807
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEAF2D3218;
	Sun, 23 Nov 2025 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNIIDiP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A022C3272
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915205; cv=none; b=pZQj6vuftjt5nr9miGxnSbacN+kC3dqQp2EIOuStscg3f6dSL4KpEB3Fa1DaRYPBGghMOgxOoZfmYQNKTtoFCgq4czkr7S+yPkdc0blQxnOjtd22k2uTTmveiJKVID4HJ+ZveYrwovtEs2AEqUqa4IHyCPxzbREfz8HzdAGUeoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915205; c=relaxed/simple;
	bh=JqqkbPPOMTGL7UZFdxUpPrXHPq5mMtVOVKmvQnQXf1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XChZTOUf/jyMP6zFiFtw6r6ILgkaK8MLxUD12CzmGw4xOvE6ZH6LrZ/z3UgQNfiigj8ZfGedlIYCUpicxtsHJ8PedLcjGNAz5rbjZ3gAvhNAMOwyl2kIlEfDUoDhIG8Clk9VqqBLMSj76mvEhFZ7x2G37YY7mHoxwdWeWicpkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNIIDiP8; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-786943affbaso25327847b3.0
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763915202; x=1764520002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/yEak0/VhIVcITIVmPRu+n2pxJ6V2Ej3mVS7RKEQmPI=;
        b=SNIIDiP8FSn87febVoRvIEQGBMJB5GhjzTmU+D3FiPhMG3y4ShsoTTMdgV0sr6evsp
         htoDB9MXvdCucQkjwLYDUkCOkhP2Q7MNY/xvM5qxX4gExO6Zzh7FJx565Tg1jbPGxmRC
         56AVwN7bzhR+DvAJhwTGABO+towGGeuDjBBBURnE/ZAJOqn4V4VZLjpqQ9MDavDGO1Qf
         IMl5p0JtkH5RdRpyeR0+K2rgv/aNOvCzXTmr8WINvWbzETrIPkg9uPzY36EbfzURe059
         6d+qxVTnPe7CgYTIFVBsSn7OS+tTaIqm//rRzXtpxYpSX05mQHjNNN8swuwHR4owv77z
         Jjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763915202; x=1764520002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yEak0/VhIVcITIVmPRu+n2pxJ6V2Ej3mVS7RKEQmPI=;
        b=vk5D5sIgXXYkmtimViFybFsKkyTDuO1PB2zDT7Bc7k36gM2fHXdmn7f2x78etsKy16
         dfMUFoHM67gYh9m5sCPNlb0BFko0KA2yyI2DCY4w2UDDMvPUhIWgWuK/uvrNFixQ+vYS
         77Q2WuaR8gpSamvDZIIU8a5FNaPYT1mU8Ezw2qi3ewpwNLoTaIED5e6NKxmP987QYqlb
         Fq4V47fgCHMlcJTF354PQcwn9k+dmAVz4fXWEE+MX5q54wUo2+3CBh3coqcFYVIsXdOh
         OCAzYXgEuIWYZPzMc9+TSrwQryfV3+wmEVZDEHQsw4oHO2dkuo7LTOQZhOFodjXYWwTd
         oIjg==
X-Forwarded-Encrypted: i=1; AJvYcCVzUn15Jzr3zPmxM5U+cMtITmweKkPwV9uG4FdRMiuPeyINfVM0kBbbjufKMqDN7AAhbgoeSAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwaCL6C79lA6mlHfogawlqsWZ4Ugp3uao8t6JOEJNi4VQMr/D8
	nAmXjmNDLpEPW00Bfp+qllCZQjORD8AgRKNcvPWB3jONtnmWqVGRWKjbO6CV0I1lUM17oQ0i/mv
	UXDQyA3uY0REAwVSuAM7nAPWG7ZWJhcM=
X-Gm-Gg: ASbGncvQRIEBY6xRLSkCJiago074B/KCMQFw6gh3juxbjjWfZOrTV4tXCWP1YqflGrG
	D8kRqg2Ci6KCSB2eNNg6zb2kDGp4D6LS8qfLCaiU5vf3ukHeB/G1EIppD5L4/1FCxsNUw5cnX5c
	suxqS3GzHdJDT9DcxF7zSiNfJu2iSmOJcHDt6BHZEOh45VwN5MvrMgx8BIZHUYiD4TNF/sVfqSh
	Q86vLsYFTW4zM9RLwJuFnOyXwc2NQJ/Crad8BqblZfQXJAtapz2yM0r0IcwTbaABtrMuiZZyIX0
	JPZYgtZPEH4CoRGvyxpqsN4PgfU=
X-Google-Smtp-Source: AGHT+IF0L7jy0r/zGjcxwan3uQk1Q16wBySTMX2Viw4qC0rxSKQ1Elz0YswWZYmqPDDa2e5IKa3k1qB/6/WMBEE6cE4=
X-Received: by 2002:a05:690c:fce:b0:787:ffc0:40c7 with SMTP id
 00721157ae682-78a8b576c0cmr66318837b3.68.1763915202429; Sun, 23 Nov 2025
 08:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com> <aSDLYiBftMR9ArUI@google.com>
 <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
In-Reply-To: <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Date: Sun, 23 Nov 2025 17:26:31 +0100
X-Gm-Features: AWmQ_bnmXFXnZk3E-9ArMUzkwcxSpAiF99kueXp6ClNTv-q45ZUQk9s7lDIgVpA
Message-ID: <CAN9vWDLGSDQQMPBVesOwAR3vvPko+ZG-eyxrL96OUM=1J05Ojg@mail.gmail.com>
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +       }, {
> +               PHY_ID_MATCH_EXACT(0x001ccbff),
> +               .name           = "Realtek SFP PHY Mode",
> +               .flags          = PHY_IS_INTERNAL,
> +               .probe          = rtl822x_probe,
> +               .get_features   = rtlgen_sfp_get_features,
> +               .config_aneg    = rtlgen_sfp_config_aneg,
> +               .read_status    = rtl822x_read_status,
> +               .suspend        = genphy_suspend,
> +               .resume         = rtlgen_resume,
> +               .read_page      = rtl821x_read_page,
> +               .write_page     = rtl821x_write_page,
> +               .read_mmd       = rtl822x_read_mmd,
> +               .write_mmd      = rtl822x_write_mmd,

I didn't get a chance to test your patch, yet, but is this intended to
match RTL8127AF? Because that's not it's phy id. It's the same as
RTL_8261C and currently matches "Realtek Internal NBASE-T PHY":

# cat /proc/self/net/r8127/enp8s0/debug/eth_phy

Dump Ethernet PHY

Offset  Value
------  -----

####################page 0##################

0x00:   0040 798d 001c c890 1c01 0000 0064 2001
0x08:   0000 0000 0000 0000 0000 0000 0000 2000
####################extra reg##################

0xa400: 0040 798d 001c c890 1c01 0000 0064 2001
0xa410: 0000 0000 0000
0xa434: 0a0c
0xa5d0: 0000 0000 0001 4000
0xa61a: 0400
0xa6d0: 0000 0000 0000

