Return-Path: <netdev+bounces-45813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E807DFBD1
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26360281D5D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E9F20335;
	Thu,  2 Nov 2023 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZIyIVCw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B11D680
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 21:00:31 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF618C
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:00:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1289051b3a.3
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698958822; x=1699563622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8KFumTag/+mfUr046qXGDZHDIauHHYyGcdwD8EXFRY=;
        b=JZIyIVCwD0ECTxQVk3G1/Ci2yYOqLuqNmMu2KPCbmd4HFX/q2nNzTTZYxyfmFDLYg0
         bgFDBtojDff9NEPVAdbup66Ulfsc/yAOnuKDctVk7jf6dalWD5meSdtrbkSTA7uqjiZK
         3UFg71SQe1vaYzXXRWpxMU9Kz777urhB4z6ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958822; x=1699563622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8KFumTag/+mfUr046qXGDZHDIauHHYyGcdwD8EXFRY=;
        b=FwfxKRuXCCsJfNTh/70NEDyVCdry0dX8nwgFCMCAeNfzv6MrEOgkQTurq2oA+PcAue
         gi3W7twVZE2wz7EaPmOkY6nSdrOZEBZxRp19mAvkyQpV78Mwj4EXmw0n0V8mmLwLRUyC
         oPRHUYvZEWcfwtHFNHw5pt4yrxH04rmgCUEwb8xDKzUNoJgphB4DFN0Xg8Hxs36FW3r1
         1xfkZqESsagF8EI+9uTt6WuZhkHs5q/azAUGnvwcGpb6cn6PbISqtOawF+6qq/HHq5Y6
         yBsayaMbxSrBsufvUJu5DUhazF/RLG4j8s3RngpIQCeBP5oPbVWOXRlRoui8e8yW3Dke
         ij6g==
X-Gm-Message-State: AOJu0YxDaq2SKn+S1dx7uzqMj2vssbdtIlSUgilZP7viIbIMiUm3HBDt
	I8unqwND01HSS/yT1FhU6YeP9w==
X-Google-Smtp-Source: AGHT+IHpWfHMpmZgu3Ki0ANwOyVLt9nZosdSKPzywMjZQkoftSaNFtV+rbheqzdq77GxD/borUX1wg==
X-Received: by 2002:a05:6a21:18a:b0:181:74fe:ba83 with SMTP id le10-20020a056a21018a00b0018174feba83mr5241243pzb.40.1698958822357;
        Thu, 02 Nov 2023 14:00:22 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:a601:95c2:1e12:1936])
        by smtp.gmail.com with UTF8SMTPSA id b7-20020a62cf07000000b0068842ebfd10sm174384pfg.160.2023.11.02.14.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 14:00:20 -0700 (PDT)
Date: Thu, 2 Nov 2023 14:00:17 -0700
From: Brian Norris <briannorris@chromium.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] net: mwifiex: add support for the SD8777 chipset
Message-ID: <ZUQN4Ua8byy-Fsy8@google.com>
References: <20231029111807.19261-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029111807.19261-1-balejk@matfyz.cz>

On Sun, Oct 29, 2023 at 12:08:15PM +0100, Karel Balej wrote:
> The driver requires proprietary firmware which is not yet part of
> linux-firmware, but it is packaged in postmarketOS.

You gotta get that done:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#new_driver

"have firmware images submitted for linux-firmware with an acceptable
license allowing redistribution"

We can't have a driver requesting a mrvl/sd8777_uapsta.bin firmware that
isn't available for anyone [1].

Until that's done, NAK.

[1] I think you might be referring to this:
https://github.com/xcover3/android_vendor_samsung_xcover3lte/commit/6e324b43b32dc607327d89148dd5d83a14429ee6

But I don't see any license info, so I don't think that's going to be
appropriate for linux-firmware.

