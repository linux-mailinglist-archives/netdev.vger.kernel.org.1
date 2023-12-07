Return-Path: <netdev+bounces-54940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 649EA808FAD
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953AC1C20967
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971374D583;
	Thu,  7 Dec 2023 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVwUTEM+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C3A10E3;
	Thu,  7 Dec 2023 10:19:03 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1f37fd4b53so95049066b.1;
        Thu, 07 Dec 2023 10:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701973142; x=1702577942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c9T9Dhk1u4UBA5bWyuf5C2EepRsZ1GhJrZKYEms2QYA=;
        b=VVwUTEM+XrKFHBEr6R/eD/Fv3vfBWLsM2f4uUxeZpomwdswdHUBcfw8xNU0/esTB+D
         1q+hK4oKS1BlaWzGt1PpEQUKq4o/tpBnONt6e+MKL4dfkh7uO7xNkRveg6CeQcyxUX+p
         SU1inDIRi640pIPD85ibmqQZ6le1HFmmAEUZKNv67IW7ByHfOogOCeVYlnnL+fiDvScZ
         sN/GvTmA9yeY3ESsAHf0Zcrdrt0hPwegqPvAR9NS8wFoezSAURDMX5Fsk0P8BTSCPwfk
         eicNofLSnis2TuobYrrPh+ZintPdcI4ig3Teld2GKL8uIB7e359KZwijpbZl1iBDOnC/
         cSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973142; x=1702577942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9T9Dhk1u4UBA5bWyuf5C2EepRsZ1GhJrZKYEms2QYA=;
        b=HXDQdLaO+7WIECCCShS/wLnqbOjNvg+IY1EzMQsJg/ShUiwyk2+nuzC/G8TaerEWqu
         U7KLoONsT5STde03vJXt6ULLWsplCjOX83qIluG2urvaiiKhX2VX/WOnTsAXRiJSHvC9
         3UsCFHYWM7GZx5MoB1Sfnk1cg7aSQGBfyQrHMpfcVt/C3EohptzVG+WkWaFDlNru3zls
         QkkAUYD11oOR26c1+AVGh71y3kX4JXwWagsCiBmUrPyjojPVyo7FuvoX3fb6xXmV8pG8
         /+rKFvsTfI6hgmZddt5QCpMcQx4JD+dV8mabcEHR1UIZIuFTisu0XHZ3LcqZg/WSJQZ5
         L+wA==
X-Gm-Message-State: AOJu0Yx/EI70ofgjWKar0ZqSSW4dW40yyTmKnUR4EQBi2PnHM/o7KQJe
	zUtVaz9l6Uia4kawGxDl9nU=
X-Google-Smtp-Source: AGHT+IHhlsosLWTuwyhAeqO++aHUvDn0g4qZutyh2cC8TSPxd5604m2eGpGCPcSESnypX9SXpSmSgg==
X-Received: by 2002:a17:906:43:b0:a19:39d1:f958 with SMTP id 3-20020a170906004300b00a1939d1f958mr1762530ejg.41.1701973141888;
        Thu, 07 Dec 2023 10:19:01 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1cbb289a7csm45995ejc.183.2023.12.07.10.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:19:01 -0800 (PST)
Date: Thu, 7 Dec 2023 20:18:58 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 06/15] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Message-ID: <20231207181858.ojbgt5pwyqq3tzjk@skbuf>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-7-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118123205.266819-7-arinc.unal@arinc9.com>

On Sat, Nov 18, 2023 at 03:31:56PM +0300, Arınç ÜNAL wrote:
> Do not set priv->p5_interface on mt7530_setup_port5(). There isn't a case
> where mt753x_phylink_mac_config() runs after mt7530_setup_port5() which
> setting priv->p5_interface would prevent mt7530_setup_port5() from running
> more than once.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  drivers/net/dsa/mt7530.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 069b3dfca6fa..fc87ec817672 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -978,8 +978,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
>  	dev_dbg(ds->dev, "Setup P5, HWTRAP=0x%x, intf_sel=%s, phy-mode=%s\n",
>  		val, p5_intf_modes(priv->p5_intf_sel), phy_modes(interface));
>  
> -	priv->p5_interface = interface;
> -
>  unlock_exit:
>  	mutex_unlock(&priv->reg_mutex);
>  }
> -- 
> 2.40.1
> 

Purely as a matter of theory, mt753x_phylink_mac_config() itself could
be called more than once, at any time there is a phylink_major_config() -
first during initial one, then upon any change of the phy_interface_t.
With the port being fixed and internal, maybe that is unlikely.

Destroying and re-creating the phylink instance could also make the
driver see more than 1 mt753x_phylink_mac_config() call. During periods
of -EPROBE_DEFER, maybe this could even happen.

I think what we need to see is a description of what the priv->p5_interface
test is really protecting against, because it certainly is uncommon in other
drivers to have this much logic to avoid mt753x_mac_config() being
called twice.

If there's nothing wrong with calling it twice and it's just an optimization,
I think that's enough of a justification for removing that extra protection.
At the same time, the optimization (and simplification) that we should
pursue is that we should remove the overlap between phylink and the
initial port setup made by the driver.

