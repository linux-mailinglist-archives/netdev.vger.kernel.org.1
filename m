Return-Path: <netdev+bounces-39270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228517BE951
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8E8281965
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0371A70C;
	Mon,  9 Oct 2023 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aW6zBS3Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4563B288
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:31:06 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77111A6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:31:04 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c88b46710bso22992885ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696876264; x=1697481064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4YLGGXbrrLjvb4zCyI7F1AlXVbYIpxU4ak6ei/Asfk=;
        b=aW6zBS3QsW3eQpvI/D8FWHWl8BlNQeMCdQsgvlPEGOiIKeSx51PKH9F2h2D+o2ZPki
         SEG8VU9xYj8OlT+88GAYWnaM35NNq4xgCyF+zHrqZb4eMvrn36tvQhWElge892sKS/TT
         9/NcULfgX9BU+eNyf1VTxfst2QmCmEN2GiISg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876264; x=1697481064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4YLGGXbrrLjvb4zCyI7F1AlXVbYIpxU4ak6ei/Asfk=;
        b=a/eOAR1kU66P0DS8zSQwP7Ugl9b8Tm6CTD/d9NLIIC4ePB2NJbB/3HFO/Bcwjy+boq
         6pkrXIKwlQrRcXSRZIL94Z0YPgWmSZ980O57awULS5PPJcUUUzofbtBdaXIYHyCjM3eg
         7Um4V53DTK/i7KSUEqeWr1zUVz09KvaynD9QD1K2wXoXaUbdUFzPpnl2qcssKNfgJ5gu
         NNPYBsCA2z3BOECtFrCjpgiQydNfbs75Mnig5aMKL6prf3Xu47bE37Cn6Z6L3KwzhJYg
         rRcIRUBYwqSnNhbn+0ex+W7N0w/jRQ0YRrW+7lb2NBXjLFVfEy13c3yoNRJDahCpu5o5
         H32Q==
X-Gm-Message-State: AOJu0YxHaJrntHQ6RjuDmg2IJjlMYLLl7EXyPX5Xrg+rx1StX1TY6EVm
	HKik5RfNiENo35dSmz7ZEKXJ3A==
X-Google-Smtp-Source: AGHT+IEfZLu+q8z77f8yTs57x1Oc7X+rrXlwq2+A/E6WLeAqCfE6BHI+9FeLGHL6pUrvjkTjs5bmFA==
X-Received: by 2002:a17:902:7084:b0:1b6:649b:92cc with SMTP id z4-20020a170902708400b001b6649b92ccmr11607238plk.69.1696876263974;
        Mon, 09 Oct 2023 11:31:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001c5fc291ef9sm184216pld.209.2023.10.09.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:31:03 -0700 (PDT)
Date: Mon, 9 Oct 2023 11:31:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mt7530: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310091130.D951BA0A6@keescook>
References: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 06:29:19PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

