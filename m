Return-Path: <netdev+bounces-21520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7853763C98
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8262628207A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB2418036;
	Wed, 26 Jul 2023 16:36:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02591802C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:36:33 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3587C2719
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:36:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3175d5ca8dbso3273263f8f.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690389383; x=1690994183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeMoIBacfZeO68llFeOo9CIYM1efZwsrZVJHhcPHv/E=;
        b=dMp1braHn+bifqhnb8MvIg4xpun/tHE53Pob4oCM57BDb1GElSpGCZl6dPe+DDcmhW
         eXPBgDgjkQ4aegRNCkgt+H1ROXoHVZ9Vv7ZlMHQYWfSjpRNrqbLVKspz1/TrizD0Z0xR
         M+F0Hks3yPLzt5Sz+OfJBsSBMuLwzF+HkPweHabp9RPJNeWTOJKqEDt7MWwX6Z0tjSef
         GWdagRZ4VfdHCeX40N0/fLe0Si83ScBF+DBxqI1XEUOYA0CDW35KmKZAcftNp2RmZv5F
         WMEA/T0zEsq8KNjwKVjz60h08kr2jp1MbbMl9/slWeVBYG2A4m+u8Dwy5/VVBfRigyW0
         hHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690389383; x=1690994183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeMoIBacfZeO68llFeOo9CIYM1efZwsrZVJHhcPHv/E=;
        b=ft0NkorZmMcI05jyQqfrGKsHZtIRqBytmATEj3MxwgouGQCncxR7hUCYA70RmYozvD
         CnMOV1uQ0TUNWu0I2r84Wuxuy52j6AGfFaCye+ULbSUDh9xPqeo1nddufnCejX0GlwN9
         dj5krLlHoM6oeBiUU4ijm0MazWR3UYUgHhL630m/YySwS1gGmfTa1djoRjhq5XMY6TT0
         Tfdil+dtDicAqosqd5n/Ii35o+3X2Nn3q6YCQkN1Q1O7Pig/eC4l2iXUlR1iuB5Qjl44
         uJMz6pDQjwYMEnlL+cBBRBZspd24cQeHBDjLNu1P5Mf/VI6HTqKlhojeI4mmdqf9ECWg
         uLzQ==
X-Gm-Message-State: ABy/qLZzjTZblDL94bKLVJMTO8FVbIm8yN7UiOvtwiITnM562gCrIr9E
	R/6qUFRJILCXk/7SNQY1+EM=
X-Google-Smtp-Source: APBJJlH4B5HfZyaQIOYA2bWOz6gwawak+G1f3dyV3rlYO5mD508Osa5tbKi5vH3FS3PlTD4ZNATMLw==
X-Received: by 2002:a5d:6591:0:b0:314:1f1e:3a85 with SMTP id q17-20020a5d6591000000b003141f1e3a85mr1594595wru.61.1690389383406;
        Wed, 26 Jul 2023 09:36:23 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5492000000b003142e438e8csm20256163wrv.26.2023.07.26.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:36:23 -0700 (PDT)
Date: Wed, 26 Jul 2023 19:36:20 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Sergei Antonov <saproj@gmail.com>
Subject: Re: [PATCH net] net: dsa: fix older DSA drivers using phylink
Message-ID: <20230726163620.2vda2noig7wwk3jo@skbuf>
References: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 03:45:16PM +0100, Russell King (Oracle) wrote:
> Older DSA drivers that do not provide an dsa_ops adjust_link method end
> up using phylink. Unfortunately, a recent phylink change that requires
> its supported_interfaces bitmap to be filled breaks these drivers
> because the bitmap remains empty.
> 
> Rather than fixing each driver individually, fix it in the core code so
> we have a sensible set of defaults.
> 
> Reported-by: Sergei Antonov <saproj@gmail.com>
> Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com> # dsa_loop

Thanks!

>  net/dsa/port.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 0ce8fd311c78..2f6195d7b741 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -1727,8 +1727,15 @@ int dsa_port_phylink_create(struct dsa_port *dp)
>  	    ds->ops->phylink_mac_an_restart)
>  		dp->pl_config.legacy_pre_march2020 = true;
>  
> -	if (ds->ops->phylink_get_caps)
> +	if (ds->ops->phylink_get_caps) {
>  		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
> +	} else {
> +		/* For legacy drivers */
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  dp->pl_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_GMII,
> +			  dp->pl_config.supported_interfaces);
> +	}
>  
>  	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
>  			    mode, &dsa_port_phylink_mac_ops);
> -- 
> 2.30.2
> 

