Return-Path: <netdev+bounces-233319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB38C11E24
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 23:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696481A66944
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 22:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B730C37A;
	Mon, 27 Oct 2025 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGAz02J7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24E78F43
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605249; cv=none; b=VQxU6SpNWlMlMk3JrJgn8BJ0urg5/iheHa29LSZzPKpD6XqpKfPcj6/cdGSAlNptcLoxO33m+O75k3BxpkrwGJZIbDfvpBDpPNMVIQR3N/klHpLMKgofPyPIE+giWGKAq+cXQt1MgLqHTePKiFYKmlqcH/4MaQTgiUc0whRjI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605249; c=relaxed/simple;
	bh=m88xe+CFu7eQlOKAj62e4b+NZw6EJaqpxFhk3oJIzNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bp4fqSZEKQjg/n9G/xu+mziP9Xvk7ppPcg8pEHi8bcLK8rh3nx8JR2B+I1mj+q1lvV4G2pxXVxcTFkoRNFA2EIZQNrp1mZJ0L4/s6xJqmOHrQJ434qXxEHN4m9m3tl0Dbb8BPDOR/EYqVkuzYvnuWq/OrYUiw97ieTjAQmLqPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGAz02J7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d414d4c7eso97684466b.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761605246; x=1762210046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xICsdCX2OPVmE7J35So75daqsj8TFidqC709lELfyCQ=;
        b=SGAz02J7aTOTspclcWYv2+ALIRXQh7s2rFsxFAw7jlEi5Sz8KJj6Y0lmeqDVmy6Yyj
         Hdq9dcakoaQDmakSZAuR7M0vxZr8vvo/FtzTJ0m6U74m5piDxv+BmU0Eb2TXo+pXuhp1
         SO/Z0EjBEOM8s/Cx40SUGS944XqM5dA+pf5iEyw2tHmWYYetH1qEaTs+IfwSGnIfccxL
         NKDlnq3aapj2cMG5eyemSJmnGvFJ9sOQDqdsFq8rzGV7ByrpUh8B3fzIm3stk0NiBtzS
         F6YiH+T9/r1LaB+/CksMNev1mBERFSTu9mkURw3qc8BCpsFEVCUe06ettl4WYn//tvkn
         7pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605246; x=1762210046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xICsdCX2OPVmE7J35So75daqsj8TFidqC709lELfyCQ=;
        b=LKjo+tJenBylXqGLjfiMFmGPOM5pTTx+qKJ2tzEXRUi2mGLcCQHxa/oEZu7S37TzJG
         cNzexq0jxArYVjvYo0lVZ7R6lNyuxA6g5CU0IQRSoHo5nEEi0x5F0Od6iebrOlL+EPed
         17YrGPfFOtvI1uEgsVStiu6Jg98gaQqlBLp7Zy/TRt07AELhi0OeU32KfIKJxs3C/2eC
         OP3f7rgDI/bJ+/6RKCCokB7NRCyUifFHx23Ef0+1sUI7a/ygGxXe6Cgho0TRUaHyU6+I
         CukPA39KTijp0Yqh0ILWJs8+Xra3GwX2nOiAZwltfGCxq8evHZ6v+FKQc5DInx5wfCJm
         5pJA==
X-Forwarded-Encrypted: i=1; AJvYcCUswLzN3zmNkZNYHCRnY4iKFVf+K4uhneCMVhDlny5nrOMozkx15AIngxT9T2WGqT1jdqqiukY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3oBGyaOl7lxwMca4Xh/cRgguVdHbFqE9BranALRTyOk2ycNu
	Hd8cCeF8FzXCSwtxGCQ9FahhACx/misBLVSG7KUjMdWuIrMcoGdIH5h3
X-Gm-Gg: ASbGncu/s1Cgne7649bcajwTi6OkYgf/oKRKLU2d8hOk0PXXGlisZor4qhpo9UHgAEb
	jcdyp/BoSEfDH3zN2xCzEOVY87QBDl10ww7fPV1CRHWmDjI2/6vVq4FkOXzmdM7HCM1Pc+aLvTo
	uw9ylDVeOshyzCWzKbtFiLBqk7NQnjo8bAseXTO9eJtcOYMJ79s+h3ted8glwiKE0YUuCjJkDDC
	N4LQUDo/6dtfFQ7r9VJl6FKXdi4QkC35Vom6/blZDedLudPU4bAU/BYtO0yUCU0FbNg5AYBnx5a
	x9Z7nwfOFYkMr4ZdzCJmb/JmqTBlp7HXXDWC1TM7uf2Q4sjfLCXxj5nUJlLU2Y88yaQJNId6+tY
	xcuev5Ii300swr3cJCBWS0W3hTOs1E7Q3ITRpVlaBMH6hTBXCbiFYksmSinMZriX3FBAWonLQlO
	lt4RUG0n7NGKx/Cw==
X-Google-Smtp-Source: AGHT+IHsT6znAJ/IU5WiN+lCitGKC0rENZLS+TtfXHEris+/Fh6vEEJWdxGjs849S6TJtLzLEjWn5w==
X-Received: by 2002:a17:907:3f24:b0:b57:1fd6:5528 with SMTP id a640c23a62f3a-b6dba5d558amr90605566b.10.1761605245829;
        Mon, 27 Oct 2025 15:47:25 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85359687sm891347566b.23.2025.10.27.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:47:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 00:47:22 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
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
Subject: Re: [PATCH net-next v3 05/12] net: dsa: lantiq_gswip: define and use
 GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
Message-ID: <20251027224722.akxniuim6yvfuq6d@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <78a2743dc2b903b650cc0ff16de8d93cf334b391.1761521845.git.daniel@makrotopia.org>
 <78a2743dc2b903b650cc0ff16de8d93cf334b391.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a2743dc2b903b650cc0ff16de8d93cf334b391.1761521845.git.daniel@makrotopia.org>
 <78a2743dc2b903b650cc0ff16de8d93cf334b391.1761521845.git.daniel@makrotopia.org>

On Sun, Oct 26, 2025 at 11:44:50PM +0000, Daniel Golle wrote:
> When adding FDB entries to the MAC bridge table it is needed to set an
> (undocumented) bit to mark the entry as valid. If this bit isn't set for
> entries in the MAC bridge table, then those entries won't be considered as
> valid MAC addresses.

Irrespective of GSWIP version? Does this issue have a user visible
impact that would justify targeting stable kernels? My reading of the
commit description is that the driver can never program static FDB entries?

> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/lantiq/lantiq_gswip.h        | 1 +
>  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
> index 56de869fc472..42000954d842 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
> @@ -224,6 +224,7 @@
>  #define  GSWIP_TABLE_MAC_BRIDGE_KEY3_FID	GENMASK(5, 0)	/* Filtering identifier */
>  #define  GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT	GENMASK(7, 4)	/* Port on learned entries */
>  #define  GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC	BIT(0)		/* Static, non-aging entry */
> +#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID	BIT(1)		/* Valid bit */
>  
>  #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
>  
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> index 0ac87eb23bb5..94b187899db6 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> @@ -1149,7 +1149,8 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
>  	mac_bridge.key[2] = addr[1] | (addr[0] << 8);
>  	mac_bridge.key[3] = FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_KEY3_FID, fid);
>  	mac_bridge.val[0] = add ? BIT(port) : 0; /* port map */
> -	mac_bridge.val[1] = GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC;
> +	mac_bridge.val[1] = add ? (GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC |
> +				   GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID) : 0;
>  	mac_bridge.valid = add;
>  
>  	err = gswip_pce_table_entry_write(priv, &mac_bridge);
> -- 
> 2.51.1

There is a second change, which is that GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC
no longer gets set when "add=false". If it was deliberate according to
the commit message (for example if it appears to not matter, the FDB
entry is deleted anyway), it would have been fine, but nothing is said
about it, so I have to wonder.

