Return-Path: <netdev+bounces-56895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C598D811352
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FE41F2172F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623F2D635;
	Wed, 13 Dec 2023 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7L/142h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A29C
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 05:48:07 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a22ed5f0440so240883666b.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 05:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702475285; x=1703080085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXQS0ODiNQ9JYf3ffZasS5CUJ0ayiouT1wEVbv6dfMM=;
        b=K7L/142hn8Xpuc76/d0BiXvGKjKYgLZyPq6SuT7kZAHTclc183aLdv++P+nmYyIfp9
         qDHaRWTsRV1cGhRV5TmVW6lCabLkN506kjIF/Enp6tGE55mFqzVAqGHqlPNKDrATt9hR
         B/b3IjizsNza6JRESgJL7NXJhG9iLCTwW5ubzk38fwINZFcbkUWH2PNu0vtr2RA8j62X
         M8fO17tqvoWCaa3Y42JGgo5Ug0x7mh87eNtZqtJQYA2L0/ZQJkZDVjyW9rL9TDYiCCtq
         AP37E7SUyFVNVl6n3R/tsv7fm2GlUmGYRtGq7Ytyb9QozupU04QTR7MtUc8j8L87eDjy
         jzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475285; x=1703080085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXQS0ODiNQ9JYf3ffZasS5CUJ0ayiouT1wEVbv6dfMM=;
        b=i4vXdIxg0u+UBglBC9bkA4jCeMRnS2zwImqRCLfAPI+v8G2Mf/OAEaqOyOJyeqMu02
         ztCFrS6I90Trl6DcI55Tc/K0uEAAQg3uUN0+u1ntKutRQkSujSHecRXPxg1lbZovJkAE
         L4rLEpaOg5r1BAtjWN5xk8P6Yo25h1PKklwaFN4uViSEhEH9ZfvcU79tKlSaltsbFzN/
         m0BbSQQ+KVG7JJKf/VE4vLMuUxbD5NTTsDxUxRcSGEYC7osAjbNOXX8fljprj7+acggC
         z/CrfuKdcxJGP7JEtRK8wzK2HNwQL8piarXGj+XUOsRFemsxuvXwqQtPunjG8lhzFnN4
         Mwaw==
X-Gm-Message-State: AOJu0YypmtocU+rJ8FOYnoTzweiuw1X3XQeXYsbo3J1YWTRKbc9rrvbn
	Yb2ecUPSMpY7U5UNcuFyKqI=
X-Google-Smtp-Source: AGHT+IH9n/nvkgwSYnet2Y3qvZhOU7xIOBstn6eItAOqVj96qiVCvgoTtqENcE/usfyrcsh0zF+LVw==
X-Received: by 2002:a17:906:a04f:b0:a19:a19b:424c with SMTP id bg15-20020a170906a04f00b00a19a19b424cmr2619894ejb.183.1702475285322;
        Wed, 13 Dec 2023 05:48:05 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id re13-20020a170907a2cd00b00a1d13fccec4sm7772171ejc.159.2023.12.13.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:48:05 -0800 (PST)
Date: Wed, 13 Dec 2023 15:48:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: davem@davemloft.net, kuba@kernel.org
Cc: andrew@lunn.ch, Tobias Waldekranz <tobias@waldekranz.com>,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/8] net: dsa: mv88e6xxx: Add "eth-mac" and
 "rmon" counter group support
Message-ID: <20231213134803.i2kkeky2s25r47mz@skbuf>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211223346.2497157-1-tobias@waldekranz.com>

On Mon, Dec 11, 2023 at 11:33:38PM +0100, Tobias Waldekranz wrote:
> The majority of the changes (2/8) are about refactoring the existing
> ethtool statistics support to make it possible to read individual
> counters, rather than the whole set.
> 
> 4/8 tries to collect all information about a stat in a single place
> using a mapper macro, which is then used to generate the original list
> of stats, along with a matching enum. checkpatch is less than amused
> with this construct, but prior art exists (__BPF_FUNC_MAPPER in
> include/uapi/linux/bpf.h, for example).
> 
> To support the histogram counters from the "rmon" group, we have to
> change mv88e6xxx's configuration of them. Instead of counting rx and
> tx, we restrict them to rx-only. 6/8 has the details.
> 
> With that in place, adding the actual counter groups is pretty
> straight forward (5,7/8).
> 
> Tie it all together with a selftest (8/8).

I plan to test and review this. Please do not merge it yet.

