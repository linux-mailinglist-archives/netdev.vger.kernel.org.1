Return-Path: <netdev+bounces-46204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49C7E25DD
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 14:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914721C20A36
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D798249E2;
	Mon,  6 Nov 2023 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6a3onPK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED0241FC
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 13:43:36 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10485D8;
	Mon,  6 Nov 2023 05:43:35 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so671389466b.2;
        Mon, 06 Nov 2023 05:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699278213; x=1699883013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bIyalhCg66VMh95Lz1+QG+xtj+2//dT9BezOv0mZgc=;
        b=E6a3onPK43GgUXizfDzGgG04DBJwTXN+5eEkvZxDlBxVvXylOUg2kke1YOyKPpT2Ym
         +p5TG9qTbRX7tGS+N/OgLn2U30XkE0UlMHzsAFWl69rjO+BiMklyQIyN1OBR6TewzvbH
         T0wegWO5jcOl17rFo1Zwt1JyS0SwFhsi/xWsPsKDdoEv2vcfeiiyh9ZlXmpNNbNOia/I
         EwsoJPcTQtHwiel+zAv9qwOpjswdBfts7P4M7VgCiJzfyianbsiiA60XzfWDVQUMbh1T
         mBProqF69tTaliuhQpopIAhtS2ObUWSnxuqInINavzyQutOXg0JqQZdPfaPluWIlNuqH
         ub0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699278213; x=1699883013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bIyalhCg66VMh95Lz1+QG+xtj+2//dT9BezOv0mZgc=;
        b=J0JguYX3ket4TArTSYNsdGzb5h44xvLNYOZs3tOujb3C369GDBYxksFpxCq8drQjpo
         xkYVN78kKT+pltvLitOouKuIQoPobsPsc0/kFMHK1kmbrXoQeeW3qtFU6jMyHiiB71PZ
         c90mzm8ly0BQF+0rlLwRRcnPvPkV+svumpxZJpU/Wrbcnbn+4sxoHMEScj4HCyZURoyo
         qzQuFsMR7ABDzZd1EdH1H+nsy6CMfu/JI22o58i/OJZVuNVYuUBFbldurGi8FvH7RxAx
         kTUW+ub4DSusSTQGwfm05BNwRiF8gLpq13rWGTUCQSG/H++qum0KZNmA+am5B9arui17
         ly/Q==
X-Gm-Message-State: AOJu0YwRKCz19AY82JwVeWB8PW0eDdlOY3qGL58eFzsDBTeZj0dvnp1I
	T2EVdUOunlGVWkMVF1F9dGs=
X-Google-Smtp-Source: AGHT+IFNT/wOvgssp9+QJ9PKC1UhtTdtUU1ANukS40GMcmrWqn/ZGkvf0CRwKrQ2Tqf73Z447jiglA==
X-Received: by 2002:a17:907:7255:b0:9bf:10f3:e435 with SMTP id ds21-20020a170907725500b009bf10f3e435mr13613113ejc.1.1699278213249;
        Mon, 06 Nov 2023 05:43:33 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906260300b009887f4e0291sm4113208ejc.27.2023.11.06.05.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 05:43:33 -0800 (PST)
Date: Mon, 6 Nov 2023 15:43:30 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 4/4] net: ethernet: cortina: Handle large frames
Message-ID: <20231106134330.nyxuayv5g6q4l43y@skbuf>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-4-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-4-cd3a5aa6c496@linaro.org>
 <20231106132626.orn5r57cc7n5ditj@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106132626.orn5r57cc7n5ditj@skbuf>

On Mon, Nov 06, 2023 at 03:26:26PM +0200, Vladimir Oltean wrote:
> Gemini should never attempt to provide checksums for DSA-tagged packets
> unless it is able to take skb->csum_start into consideration, otherwise
> it will get it wrong.

Additionally, since Gemini does not put NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
in vlan_features, DSA won't inherit (thus won't have) them. So,
validate_xmit_skb() should perform the skb checksum during the xmit on
the user port, which is earlier compared to the xmit on the conduit.
So, I guess skb->ip_summed should already be CHECKSUM_NONE here?
I think the only problem for DSA is the lack of the TSS_BYPASS_BIT. The
rest is unrelated.

