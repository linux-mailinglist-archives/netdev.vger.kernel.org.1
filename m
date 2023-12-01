Return-Path: <netdev+bounces-53043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EB6801279
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991BB281594
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095054F20E;
	Fri,  1 Dec 2023 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZTUi7WpS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D18C133
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:19:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c194b111d6so646347a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454745; x=1702059545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/r/b5wB85MlFGGxmClGr6DvtbRffHHrqFc2cNWTq5OA=;
        b=ZTUi7WpSDb9JrgxXhR8Mn9De27rOF3QKwQKZ+qrR1VXDKAoBP83teE3Po6dHcfAHY6
         8ATW/ZwWC57obYIuy+PzzUuc/2Dq6T472DJRAUXHXxC04/IJJzH3DAOVDOfksqnCKTo1
         B6VqqlTW7gov/di+ENcFu/St39frG+D2VwxAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454745; x=1702059545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r/b5wB85MlFGGxmClGr6DvtbRffHHrqFc2cNWTq5OA=;
        b=ZQtim95fIjCU4x6hnHM46yvLjggeVmpKQRSVMVYCjHyPNcAKaVfdN5D3M4zgiqkbbY
         XCy0zKImWybrCAWzQMsARUlP7C4GqozXXbx1pPYjx8OGz+MaF1uBVNKFECU1fOUGGmfV
         iTixSXUL5nMT4QCTeEcywL5ZdJm835FnNKlWIqINqUzg9wFeCC9Lf6tOyydahRYsKtHJ
         m5IRBX4MVf5CMY4GOG3/mdxVG6WM4lwQ+GpU62fmp2PEzK2MQz2eIr/p0wV3DNXoZmI+
         9BEbqh6Be/TOMNQcc/eI8HUV0i65xyyoH4fpRTTJicPS5Ml2BEzFaMd8qDEL6WsudcGi
         7USw==
X-Gm-Message-State: AOJu0YzWe2SQeL2anjecC4uX1dxn8p72C/N0NsuecXmgt4noEf/V5nWw
	CUg4qcfcLmnFfqeU3zwGZ0ojMw==
X-Google-Smtp-Source: AGHT+IH5qSt9M18U01kU6sw+qA2MJgSEFcLkf+LsZsRTecXMRfrV5OLB5yPRo3yAJ5pGP5A3jCWsgg==
X-Received: by 2002:a17:90b:80b:b0:285:8673:450d with SMTP id bk11-20020a17090b080b00b002858673450dmr26239658pjb.40.1701454745518;
        Fri, 01 Dec 2023 10:19:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q32-20020a17090a17a300b002860a7acca1sm3780052pja.10.2023.12.01.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:19:04 -0800 (PST)
Date: Fri, 1 Dec 2023 10:19:04 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for
 lan9303_get_strings()
Message-ID: <202312011018.478B0E750@keescook>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
 <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
 <20231130224021.41d1d453@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130224021.41d1d453@kernel.org>

On Thu, Nov 30, 2023 at 10:40:21PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 13:59:58 -0800 Kees Cook wrote:
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
> >       https://git.kernel.org/kees/c/f1c7720549bf
> 
> Please drop this, it got changes requested on our end because
> I figured Alexander's comment is worth addressing.

Done. Justin, can you please refresh this patch (or, actually, make sure
the ethtool_puts() series lands?)

-- 
Kees Cook

