Return-Path: <netdev+bounces-214930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF0FB2BF5B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E923A701D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6950F322C87;
	Tue, 19 Aug 2025 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipz/jLoE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570525F98E;
	Tue, 19 Aug 2025 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600663; cv=none; b=UM9SyD1gBqcLSO6Wtyn2BP3hkun3mjK4TiqHD1cRFggdWBckBhlvCT1uhNGFwzW5yB2woHwBHzKzFE2qjyk0upt8OxLg7edvqf9MHIVSbiH4kPBiPdltxY/3hyJ15uHRGLpAjkj4jdtvYx6zcQ864Fnlpr9xT1eXbJqR7YvBJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600663; c=relaxed/simple;
	bh=8KEVwwRsMjn8LNeo7Swyhi+N5womecG4rF5cMId69UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckBEVlTOi/dvidngvtJGKO8hNP55nc72OPZvLeHASynxkrPqsgXTYhJrBvdQICj+SkJyDHU9IGKShN5HMtJ2h8Vo09KoH1bgtxzWD6FunE2Kr7V+YmDyasYGxNMJ6PbQNGYRzoHTnRs8l3b+EBsKO5NxsXtlYrTEFI3XrvFu7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipz/jLoE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ab87ffso81339666b.3;
        Tue, 19 Aug 2025 03:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755600660; x=1756205460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=om1w44JMuLFe2q43lus4Kq7PZlXJuu4rWOapDSJq7cQ=;
        b=ipz/jLoENUSMr5Zw0ONXbo6A+MTYolUxkB9KLUi9evbdjqpEL8fJSLt2gk/PX5SVqW
         4UmHtBX38G9XX3PQVr3VnI5PqFbP2+KQEgPM2MjAcuiNjA816Z8FCiIzfCyCOlfn6DHK
         iwupeGjoUUeji/Z67X/1vCo/RGk61ELNbNUBWbUFnBfjmog8e2J4KZfNS/Wb5rhPnYtj
         5fiUzUnbjTsF3v7o/gAhj/LA021qtINmOBDb7cF0AzbDfVxJ74UWjmM8jvW8BNCVQpg/
         Ay84ilS9kXIP6iuJwGzMjRKN/Y1PfA9ZuL6QuVCJUYBPleOE0u4oBvFeiObuqMQzOLkN
         I7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600660; x=1756205460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om1w44JMuLFe2q43lus4Kq7PZlXJuu4rWOapDSJq7cQ=;
        b=xJeuocXCzo4eSib51992ojPyTdP/KyziY3c1gaqy9+vAzK7aaR+ElJj7jXlre8iMJF
         h2jN6tULUeM+6fC89AIA02gUmoJbtawVapUyR+lO3+RVv/87X5hV13ALCnm0w1/0I/zw
         13D9VIlfHZBjK8c6YKr2AW+rl0WIN9D7HYRxCYxIKt2My50EuzVFv+9iYq/+SrAiKdGU
         1dT+3Oln1isuk5DsAq5aw6DZCQezpj1C3RQoLbAEHiHfx1kj1XOaNP5gcTIzgADkD9CB
         VdEUfTDa7752Izy/SbQC0uxOvCPdTdZKdPTvcbB7I1Jjmrfo1d36tpknakN6S4GF3tNX
         75hA==
X-Forwarded-Encrypted: i=1; AJvYcCVe/VYsbTX0Dh2SvcaZPJozClGqj3u4sALWDbZv5Cjj30hdgxecggTJYsGdC6QIWtf7LB1fh2Cc@vger.kernel.org, AJvYcCW61pwwh2sWFsZAFBWBcRj1RZDVgbF6sLFrXlAKcW3LYQvFp1hStJZxZoGnWdIZU+VQyGycHPEfC/xPYZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWsixtG9bAT+k9nefloRs3IfYgLvYRa7C0+5RwZ6uqbJWrJAC1
	z1CKP18kLcGW4Lz1MFmzj4j40zaoKwU/+x11Yu8vLkaY5zfv9mBiAWok
X-Gm-Gg: ASbGncuQEgYe0BcMyanxtb11mshkVz/XsgyVwebtH0VW/QZA4aHUPFvpa8G+HMigoas
	8dCBoxKewPuhB6OoYMfmDzA6UsadHMk8ZuMyM9VIbmyKGppsvteQLSsjYZZx0qVzMfDhZcgzv9+
	gXjNXIfgbuae99zJ8uKEoQqy+hLWADUnJg/mNyHAyGPzeiqraNHsJpJW9IpyKvv0gCo0ZCNgjf7
	E/DCKz1Z5twmRIkRX14O3gKovt2ctqhhRVXG0AP2j2MQBCnd8op6zyVwpIJOgfks6eMxhE+LQ1w
	SCya6iCA9rDS61H9GDjJ9vONzEDoNgaCsVPLgTR31b0HUzrFg/f9SJEUjt3Jac0idHOLTd5gole
	07dVSOUpg7YgDQ0g=
X-Google-Smtp-Source: AGHT+IEL2vxh7dpWujXHcBIp7VEe4dRbjpE9sbfahe//i2YudEjHNEvyvA24gblBb6k9jt9EpvYnoQ==
X-Received: by 2002:a17:907:969e:b0:af8:fc60:5008 with SMTP id a640c23a62f3a-afddcd113eemr98473466b.4.1755600659743;
        Tue, 19 Aug 2025 03:50:59 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:5508:97d1:7a8e:6531])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd010d4csm967064066b.85.2025.08.19.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:50:58 -0700 (PDT)
Date: Tue, 19 Aug 2025 13:50:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 3/8] net: dsa: lantiq_gswip: move definitions
 to header
Message-ID: <20250819105055.tuig57u66sit2mlu@skbuf>
References: <cover.1755564606.git.daniel@makrotopia.org>
 <cover.1755564606.git.daniel@makrotopia.org>
 <a6dd825d9e3eefa175a578a43e302b6eaae2b9dd.1755564606.git.daniel@makrotopia.org>
 <a6dd825d9e3eefa175a578a43e302b6eaae2b9dd.1755564606.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6dd825d9e3eefa175a578a43e302b6eaae2b9dd.1755564606.git.daniel@makrotopia.org>
 <a6dd825d9e3eefa175a578a43e302b6eaae2b9dd.1755564606.git.daniel@makrotopia.org>

On Tue, Aug 19, 2025 at 02:33:02AM +0100, Daniel Golle wrote:
> +#define GSWIP_TABLE_ACTIVE_VLAN		0x01
> +#define GSWIP_TABLE_VLAN_MAPPING	0x02
> +#define GSWIP_TABLE_MAC_BRIDGE		0x0b
> +#define  GSWIP_TABLE_MAC_BRIDGE_KEY3_FID	GENMASK(5, 0)	/* Filtering identifier */
> +#define  GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT	GENMASK(7, 4)	/* Port on learned entries */
> +#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC	BIT(0)		/* Static, non-aging entry */
> +#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID	BIT(1)		/* Valid bit */

The VAL1_VALID bit definition sneaked in, there was no such thing in the
code being moved.

I'm willing to let this pass (I don't think I have other review comments
that would justify a resend), but it's not a good practice to introduce
changes in large quantities of code as you're moving them around.

