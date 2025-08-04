Return-Path: <netdev+bounces-211533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748A7B19FAD
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47051791D2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68972248F78;
	Mon,  4 Aug 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIwmfaBj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C422D7B6;
	Mon,  4 Aug 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303081; cv=none; b=rq1u/ocqSp9859aiQR25o624uQQkzJKqR3WZUMn50Op1Vy8e/rW6pLMuxRPjtiiUCoR10dfFM4Vq/nJqcdYcfH0L8TpRr4814BlULuZ0WEM2Ub1n189o8fP+DYyWTuxqHAPpV0bSsqcdY8yYBtVxvfWKByuTIDD79Xs7VJmVeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303081; c=relaxed/simple;
	bh=hIDBdkW99g69B4HnkAExdd+nAQt8TDGpkI3BB4o0Zsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYtxCVui1FZe/Zncv91RrYohNlp5Z8dJC4WYoKpQb7jQcsEmfKxtOCstRwIZZwJfa/oDYIXLG2ICGlinZ12ZkTh18gBY6wPGgt/t39Z3lhyEQz3Lbd9JmkjD/4H4J63+3dihuyfJXF1QVZxZorY2aPOVPgFC6oVWF1mSaq/xv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIwmfaBj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4594440145cso1799315e9.1;
        Mon, 04 Aug 2025 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754303076; x=1754907876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8wUDJsxaq95u88HYAIXo/Ebd/zt3NwnHAsNeMX0GAY=;
        b=JIwmfaBjXDJki5N+FZ6bQ7V1l8TeaUq1+rbcBItg2WwYlwYx5b+GaNGzQtc2oMTxzK
         4pM2y3ne+WjjihhTksvAH38HYiAKB65/wOL0PMwCzP8OyJkSt7bxKH7SXyo2wx3ebLap
         AW4k0HNOb4UIEACkrBVOOaDM3+wHtS1HAqNg7DqqWLGBrc1/W9CXfuOgOJOBc7zJ5+4S
         QjcbOhNIqjhfgWWL+Muxz2es0ulkn7rTi82CShgkhUwLqBE9BtTsB+U2G9GA+yXC10ew
         /BTR0TPMW3psxrOTykyrGn8QOZhI9hcbccdmiEqZT43Hre6vKphn2nOF7CPj6v9ecLtZ
         Qgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754303076; x=1754907876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8wUDJsxaq95u88HYAIXo/Ebd/zt3NwnHAsNeMX0GAY=;
        b=nnLl2iUbJj13YuhwVPqtlIuoasHNLmPwjgb2CtDhEFNA+NP6y3CMKNdwE0VLbqPnM1
         usW3syfuuEbD82RP2rnQLcf+y4isvx93737UfVBhlpYLQi7uVaJM6+IdUXECJ1Jru3O3
         evabCNeIGL7CFz8yLxe7a2J4whiS9PgFipaDmofAvj9pU48vnpwiAn6U7lmxSoptYGt/
         Hr75iMWITMLr7r3U3ta7MHP0FPogy+5LlgBhUUxqBG+rLRWImHIlIXmK5zsgTd9PKCuj
         N9hD49ljYUY2eNAR4y9JB5KyARr9REE0frEhdunCtMo551DcILcaHzw/nduhvVmy49Ot
         DFKg==
X-Forwarded-Encrypted: i=1; AJvYcCUhCK6K0nz0iY8BlY14xdmQkivkE0mYoIJ68drchFv6GH9f8yIjOkn8pPphebtjw/RcublwZMjOPxd/uHw=@vger.kernel.org, AJvYcCV8pdmoDJP5SammGBOmpp7fmtYmZpc38+9uqnS2x8e2FYxRYuBX3tiry2XPEZnIh17tkARnIhQM@vger.kernel.org
X-Gm-Message-State: AOJu0YyVe8EX6gDSTEGQ0ZHMaojCh5FsK9Lk6ir13DTYTiGPknDjZIMA
	V9gigY4XitGKjpZNbtFFgUJ+uovdxg6WWi8fwrgJgrwazJMXYt8KwyJB
X-Gm-Gg: ASbGncvrpnrRLG5EpnGkFEMyvDjb86hVOQ0swdb46OMg3nPNHfTaSuLiUdThocLIX2j
	Q2WkN24mpPoFjgVPrE0PJ/ro+HbYcinVkgn80EtsIvDIg8w04KT1I1TmoWAcIpA3BhX/78AbCMD
	MZUUu/UhosPDoLoxkQ3sybDH06rLJnBut1T6usF7M40dgqiLIhaRpJbi0gfaPPAgQeTjh2t9zYa
	Pqbn1LB9JxYJRSlc1XQoznYp9tnlRGIMqw1e7UuAi0NZMMAQQqSmQpWydIhK1t5K/d3bweY6Efh
	dtyIt7+aD1QHlj8NGd7ANHIhm8YdSSsBzDNbJllnohWjl5dvyUBgi3i1fu546+Jkfl0dYmsAddh
	VPLbdp7E/LIX8IH69WKxj6CcNDg==
X-Google-Smtp-Source: AGHT+IHeP2TGITy4Hev7AsM17CGlGKJQMYcRUbyKWb32e3LJsFvq9UKRJ5htQcmiFXedfLNQQ6X0Bw==
X-Received: by 2002:a05:6000:40cb:b0:3b7:95ad:a6d9 with SMTP id ffacd0b85a97d-3b8d9465ec4mr3116545f8f.1.1754303075566;
        Mon, 04 Aug 2025 03:24:35 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:1652:4e3c:1b0b:e326])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm15687201f8f.49.2025.08.04.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:24:34 -0700 (PDT)
Date: Mon, 4 Aug 2025 13:24:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com,
	atenart@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250804102432.lv7pfistwfbql64q@skbuf>
References: <20250731121920.2358292-1-horatiu.vultur@microchip.com>
 <20250731121920.2358292-1-horatiu.vultur@microchip.com>
 <20250801112648.4hm2h6n3b64guagi@skbuf>
 <20250804073940.4wgpstdm53atrbbq@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804073940.4wgpstdm53atrbbq@DEN-DL-M31836.microchip.com>

On Mon, Aug 04, 2025 at 09:39:40AM +0200, Horatiu Vultur wrote:
> I think it is a great idea. I can map struct vsc8531_skb directly on
> skb->cb and then drop the allocation.

Ok.

Another set of suggestions on the patch, all regarding list processing:

1 - shouldn't you use list_add_tail() rather than list_add() towards
    &vsc8531->rx_skbs_list? I am concerned that with multiple RX
    timestampable skbs in flight, you would be processing them in
    "stack" rather than "queue" order, effectively reordering them.

2 - you can use list_move_tail() to move an item from a list to another,
    or you can just call list_splice_tail_init() to move the entire
    contents of &priv->rx_skbs_list onto a separate on-stack list from
    which you later dequeue, and at the same time reinitialize
    &priv->rx_skbs_list to an empty queue. If you do that, you can
    shorten the atomic section with &priv->rx_skbs_lock, to just around
    the list_splice_tail_init() call.

3 - the following:

	struct list_head skbs;

	INIT_LIST_HEAD(&skbs);

can be simplified to:

	LIST_HEAD(skbs);

which combines initialization and declaration.

