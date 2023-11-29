Return-Path: <netdev+bounces-52245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDB97FDF6D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43216282544
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821A3399B;
	Wed, 29 Nov 2023 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvPAMN9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541B133
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:40:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so10456866b.3
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701283252; x=1701888052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZczDnUJK3Tlk8LitBnvF9jlH240bcLj70zET4pTVZ1Y=;
        b=dvPAMN9lvEU0h4ZacSIML0WQ5z5UQsQndwIrS1MCA0Fzy2L2wP+VPm4F8KuukRxozn
         Jgp5BOlS9cCiUBttFV8tpwK9vQqQJejQTWypvtiGTA29Imxatr0W6kEdenYKGm5N4ha5
         PAPnUvXjHnseJbJb+15bYQiQD8xAMFZiuCSnJQ1GSLHAL7BKU/5dwx27QJ6LtkG7Po4J
         AOqR1+0p3pgjhLfppBD99F24TBSNyvGtjfNFJe19xgQSNwgvXhmcD/wype1Qw3Qx9sMQ
         dFc2xDRg7cUZjKY+AV4bBDdhVidEzbNVfPW6gc6vchaoM7jxXG29WmC3k212igqbFy3L
         yRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701283252; x=1701888052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZczDnUJK3Tlk8LitBnvF9jlH240bcLj70zET4pTVZ1Y=;
        b=q89MGYHGK5+rwUI3hdYtBU02BHSSTCgQ/f/tl7nXZPAIcf9fFUwxarlpzW73cK3XBG
         Jd00NzoHk7T4vUuNt6cSMLckzcmQHMrEsMXeRiXKVgknBYCiHK7lqTasLOi6vS27Xrdd
         8Q9HdwVqg0kx0nT7+3EuIr7SPtXtGMysvQlFMUDxBG5Hgbm7cXUX+/PHVr5D2xzM7K7w
         kA0ICFTIpm3lq8erCLwKjYfvNzMZX5nduI72iULR4T9j/Zc+6VJS7hJn18ztxjoCEdod
         G/NPbRZ3r1wipVUKKDWO1X94GPSOUaZTGswMuxJ2pcX0Vx4jkvLWSNxzEtuzRIjmUToh
         rxMg==
X-Gm-Message-State: AOJu0YzwtHCVc7RBuQyZzNcpaxa6m8FRY4gnWBYnomDkiPfxPcT3xGNZ
	z0Inm2be7TxZ4cfaFOqrPc4=
X-Google-Smtp-Source: AGHT+IFZKivQSWNjSyvesdNWpq+FcFrQ02/ogazPdAE94dlNnPe02oq0WFuWF0+PgBrLuvnQWzOp+Q==
X-Received: by 2002:a17:906:cb8e:b0:a0d:6bc6:4811 with SMTP id mf14-20020a170906cb8e00b00a0d6bc64811mr10287702ejb.37.1701283251857;
        Wed, 29 Nov 2023 10:40:51 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id ks20-20020a170906f85400b009db53aa4f7bsm8120920ejb.28.2023.11.29.10.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:40:50 -0800 (PST)
Date: Wed, 29 Nov 2023 20:40:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 06/10] docs: bridge: add VLAN doc
Message-ID: <20231129184048.k3fdtu7va6sewpqt@skbuf>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-7-liuhangbin@gmail.com>
 <20231128084943.637091-7-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128084943.637091-7-liuhangbin@gmail.com>
 <20231128084943.637091-7-liuhangbin@gmail.com>

On Tue, Nov 28, 2023 at 04:49:39PM +0800, Hangbin Liu wrote:
> Add VLAN part for bridge document.
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

