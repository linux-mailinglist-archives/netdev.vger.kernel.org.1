Return-Path: <netdev+bounces-55973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3315580D037
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31B228218F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBAF4C3A5;
	Mon, 11 Dec 2023 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMUH0NCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D11CE8;
	Mon, 11 Dec 2023 07:58:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3360be874d4so2660892f8f.3;
        Mon, 11 Dec 2023 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702310282; x=1702915082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UP8QCAWkix+ah/u9MRF4/PqN0THuXQv8JTue99twEPM=;
        b=DMUH0NCaMTVIancrPGRkt4tExIpqGk5H6ffHCNOANie9fbokfTloj9ihVbrpzcpmfZ
         lfF2ULsbHJ3WhD74q84ljivlSwvmh/xg/n1yU2LWKtDTkMxAaoeIMtjlHjDB4LgxGuX1
         QbytMVIPcdhIu2QZmqlqJlInEC9K8v/9vK/jIcr+yhl/Nz2qW+JpP7xv84M812DQN31x
         sq028tcVJyFZcxHfbZcm+UnfbqKUWKl94UB2E6nsHUyck1NeIhMfUcKHn6y/eeb6yN1D
         cqKZpXQ9opV1cuM40nctBOQLZpNYJ/+MD3I7510MPmySKa4p/hqQKodDdeU0lx5bwIW6
         Yb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310282; x=1702915082;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP8QCAWkix+ah/u9MRF4/PqN0THuXQv8JTue99twEPM=;
        b=uw1bxSz1qKyHCoEXhxEx8NHDmTe0misQTZbhC8PuxJgoymUMU33dPY63E6DR7I4ClP
         IJV74PP3du/cF8ZN3iLQTVhSmjZKd2eYecT9B0fZagatgUjBpHlEL/Lus6cdKN8pDpmA
         GT8Ig3vd9M8wV4lFzxtBAhG0vlnlxLDlLcek8G1+N2znsSTpzI+xAD3QIP4g8aGIhB43
         j5D7E3ZkOxM5NJz0HQkl2bxVdMlNu/Wb7ic7fhxY2rl5LQdvfFjRgdoIgdJljr9vjx9+
         3caaODqxAoh2sYqpK/7FnKBt9zYGzkOGY/F/MEMknqZQnGEE9cPbYfji/0N+PT4WmTLe
         O3Eg==
X-Gm-Message-State: AOJu0Ywy7rtI+ixF/M/nOyCkLRAkkIoudvQZnrnbCdDwxSMjtKtk5x53
	lPbXDmSc+AnLsz1fq2N0X4o=
X-Google-Smtp-Source: AGHT+IE3PIwrbyCPohhj/ocKMyOeIvakszvi1+b+ijQLiHsIK5f6LFgIRukyFs+Inv48XGMyz9kVOg==
X-Received: by 2002:adf:db51:0:b0:333:2fd2:51de with SMTP id f17-20020adfdb51000000b003332fd251demr2070036wrj.87.1702310281638;
        Mon, 11 Dec 2023 07:58:01 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d46cc000000b003335c061a2asm8886526wrs.33.2023.12.11.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:58:01 -0800 (PST)
Message-ID: <65773189.5d0a0220.8ca72.00c2@mx.google.com>
X-Google-Original-Message-ID: <ZXcxhjYN77frSDdp@Ansuel-xps.>
Date: Mon, 11 Dec 2023 16:57:58 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
 <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
 <65772f6f.050a0220.8a2bb.80c7@mx.google.com>
 <6fce1c46-f7ae-4729-b9d4-763af45f6146@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fce1c46-f7ae-4729-b9d4-763af45f6146@lunn.ch>

On Mon, Dec 11, 2023 at 04:51:56PM +0100, Andrew Lunn wrote:
> On Mon, Dec 11, 2023 at 04:49:00PM +0100, Christian Marangi wrote:
> > On Mon, Dec 11, 2023 at 04:44:06PM +0100, Andrew Lunn wrote:
> > > > +properties:
> > > > +  qca,led-active-high:
> > > > +    description: Set all the LEDs to active high to be turned on.
> > > > +    type: boolean
> > > 
> > > I would of expected active high is the default. An active low property
> > > would make more sense. It should also be a generic property, not a
> > > vendor property. As such, we either want the phylib core to parse it,
> > > or the LED core.
> > >
> > 
> > Also sorry for the double email... Any help for the problem of the
> > missing link_2500 define in net-next? (merged in Lee tree?)
> 
> You need to email Lee and Jakub, ask for a stable branch which can be
> pulled into net-next.
>

Thanks I sent a followup email to the merged series.

-- 
	Ansuel

