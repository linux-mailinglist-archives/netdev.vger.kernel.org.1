Return-Path: <netdev+bounces-56600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79E680F957
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B6FB20EDD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8135B6413E;
	Tue, 12 Dec 2023 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YjG2mwyE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31979188
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 13:27:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d3448937ddso6625355ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 13:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702416457; x=1703021257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMWCFeEilpyi5Ac7Brep5JSzMOQ0AtnLLpOVe467uSo=;
        b=YjG2mwyEofdEFA+8fIhlpT2lC2Ie4VWo3Ue9ae+Gy1Kq24N5K4jfDYZYARfuSS0t9k
         jGkl0R0llkYoZrMi3JrOUUXriAMIAPX0x+bY4a1MCqkHNIuGZLITki/d9bfKjj4QmkH6
         5W1OHshD/bc+xc0a3ouSMReLdcp19iQfdIYZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416457; x=1703021257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMWCFeEilpyi5Ac7Brep5JSzMOQ0AtnLLpOVe467uSo=;
        b=TP45LRS1xQNg4M86YZYllRmdBz835T2wvKXQoOTZlbg/Y5OtGZvEQQXQLAY9cL9nN4
         B/uiinycXHiu/jUae7HbNPNqEqTKvNb6jgjZbC3Oe6e8SrWBz2YChUSij1EazzY6iPoA
         KBfACVJ21443zbTPtmbOEVbLPD1xrTkXDlnbN0/JXfIMIvYg5D7t9rV+AmCNNBYrlF0f
         y2Lw7TZK2uLPG4r74U9VjR6KZ/WU2ES6eziTAqpiWxgUVJyY8H1PasWEIJIZCHd5HryL
         yNpBbO7gScI0ReBo60igRYuQTivFVZccLOPeE11Wnn1WfhOKxIFJd6uJBnfgGGcrLKxV
         hS7A==
X-Gm-Message-State: AOJu0Yz4ye0b6uufwhr1K4xdyrV90DJ/vEOC4xG2CrgeWiLqXh51iTrk
	bzHaixjfjTB6ew79UkLIEuvtSw==
X-Google-Smtp-Source: AGHT+IFsjK/4jl3htSAqRzNOqZiI1jZZt9gjZFvHm2rukC0crml0pXcWxmpZQRnGChnn1/ujf3LPnA==
X-Received: by 2002:a17:902:cec5:b0:1d0:6ffd:f217 with SMTP id d5-20020a170902cec500b001d06ffdf217mr4199501plg.109.1702416457607;
        Tue, 12 Dec 2023 13:27:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id be3-20020a170902aa0300b001cfc6838e30sm9003034plb.308.2023.12.12.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:27:37 -0800 (PST)
Date: Tue, 12 Dec 2023 13:27:36 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] net: mdio-gpio: replace deprecated strncpy with
 strscpy
Message-ID: <202312121327.3A71BECDF1@keescook>
References: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>

On Mon, Dec 11, 2023 at 07:10:00PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> Due to this, a suitable replacement is `strscpy` [2] due to the fact
> that it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> We can also use sizeof() instead of a length macro as this more closely
> ties the maximum buffer size to the destination buffer. Do this for two
> instances.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks like a clean replacement. (And a nice sizeof cleanup.)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

