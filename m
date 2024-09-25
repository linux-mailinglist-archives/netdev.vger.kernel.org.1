Return-Path: <netdev+bounces-129781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE0198609A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B67287F5B
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5EED512;
	Wed, 25 Sep 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZquZkHsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432417BB4
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270124; cv=none; b=Uv3zN+EzsUDvoF2ulGzOtmRr/scm7y+UKBySJzXL8CJVsh7rluP2hDy6WGIIIQCpS9V15kcZpyAM7W4cXj99LXJVUjssNO5QEEHDjZhzFB0DV2e/C22rTdrv+3oiLp7U2lem4//AcOJC3QJyB9BYjq6wlFrNYBcrZlfEsxGgH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270124; c=relaxed/simple;
	bh=d+FurBr9taJUPTXY7JbgQj44RlJEmW5xyYWvXZCuXVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYJ5tUXI2lKJs0CjoJpCpHRn8jDnmr7N0mZ5EfFqDtwFHSJf+g4eRlgHgFRm/HW2yfABiW5qSHz5++YZTKQyoexx6FgBcjcVrGOL8IX/hUKDX4KeLo/JioL9G7hWYMikntsMZy9pGJT3ParBu2J6hZx4Unhofc2pCNdIyeMi+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZquZkHsK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a913874b8so70538566b.2
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727270121; x=1727874921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIRGXiqbpCwHel3eJFGrUBbElkNnKUDcIxPay6UwVps=;
        b=ZquZkHsKSH+oqPLpYgDCecz2nk7HMTcM8CsPoRekHYPV6rUwTmt4jZw6GLutwrVmgg
         5s1wkFXvlIzXKsGk2M/S5mBWkTKWKza2U89ECa6bOXa8q1DNR0S6OvKnU2n4N/2g/lfI
         e2iASGMAYMf7n3tO0Havlzz9Q8c3n+yHnhv/3hYEuN0HEoTaFhmEif83mXrouz0FTLOo
         6XoDH0e/lwbbQp6Wh6PuZYZB0GtqU66Fz/qJ5sGj7+x1BA5ANBWcsMikop//yzoVXEIh
         Q3Lky/jtWdztwvCP8KH1PcNNVyElhoaSmkjQtG37p0dWKwaw7LwP1WWMzrG/nJyzE1y+
         i1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727270121; x=1727874921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIRGXiqbpCwHel3eJFGrUBbElkNnKUDcIxPay6UwVps=;
        b=L8bWgNl8JpP8Zyj0xP+ZFoYTvvDe6gKYqfKS9bTMN/+Cw7ymiANiKh4esUsHMkVUK2
         v1ZHu8kABXKHB4JWBYL35EQRDHZtkH5P4ViamvnNtVpJtuUKIQ38Rgxv7zIuQobGDlon
         Z5yRm/W8WicfAhersMlNNQzjhQJO90M69L+k5tjqrxR+FRRdrdmAYKZ9hW42s9BWGb2k
         87RrGtfKxUFADy/hKCBexSNMb1a+SdbApAMhu8eQDKgIZjSQyN8jcXkdJHPdR9uQY3V2
         Ja4V6cKgqJ7jAUhCv0qwCsYtAR7sJ0mCLf8osJiLY+GKJwShZGCfTIOZ0/fRie/FtXJh
         pUtA==
X-Forwarded-Encrypted: i=1; AJvYcCWyhPYBOIrSYVpIcbEl01HhJ5IP2lVqs8r6QO+WZazzaAdM2u1DZ0HuZBAAwp9guWn0r1COaA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8TK2cj3gLf+rtpPxutO/ezxs4ZQKKOCdl+3VpeD+mF1eUE5ZK
	wE5FWb+0C5nGjzZrT/uhkg9hzvWJHIHjqat7Ok7Si1wfTotFoihE
X-Google-Smtp-Source: AGHT+IHPosmiTyDgIhqNvtBau0LzG3wa4V86DjV0jr65QSkropiwCmtHnOleQT5i1l2q4KClBF+Opw==
X-Received: by 2002:a17:907:3f96:b0:a80:a294:f8a with SMTP id a640c23a62f3a-a93a035c2c6mr115963566b.1.1727270120189;
        Wed, 25 Sep 2024 06:15:20 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f787dsm205784366b.157.2024.09.25.06.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:15:19 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:15:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 06/10] net: dsa: sja1105: simplify static
 configuration reload
Message-ID: <20240925131517.s562xmc5ekkslkhp@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcz-005Ns9-D5@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ssjcz-005Ns9-D5@rmk-PC.armlinux.org.uk>

On Mon, Sep 23, 2024 at 03:01:25PM +0100, Russell King (Oracle) wrote:
> The static configuration reload saves the port speed in the static
> configuration tables by first converting it from the internal
> respresentation to the SPEED_xxx ethtool representation, and then
> converts it back to restore the setting. This is because
> sja1105_adjust_port_config() takes the speed as SPEED_xxx.
> 
> However, this is unnecessarily complex. If we split
> sja1105_adjust_port_config() up, we can simply save and restore the
> mac[port].speed member in the static configuration tables.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Thanks for the patch, and the idea is good.

>  drivers/net/dsa/sja1105/sja1105_main.c | 63 +++++++++++++-------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
> index bc7e50dcb57c..b95c64b7e705 100644
> --- a/drivers/net/dsa/sja1105/sja1105_main.c
> +++ b/drivers/net/dsa/sja1105/sja1105_main.c
> @@ -1257,29 +1257,11 @@ static int sja1105_parse_dt(struct sja1105_private *priv)
>  	return rc;
>  }
>  
> -/* Convert link speed from SJA1105 to ethtool encoding */
> -static int sja1105_port_speed_to_ethtool(struct sja1105_private *priv,
> -					 u64 speed)
> -{
> -	if (speed == priv->info->port_speed[SJA1105_SPEED_10MBPS])
> -		return SPEED_10;
> -	if (speed == priv->info->port_speed[SJA1105_SPEED_100MBPS])
> -		return SPEED_100;
> -	if (speed == priv->info->port_speed[SJA1105_SPEED_1000MBPS])
> -		return SPEED_1000;
> -	if (speed == priv->info->port_speed[SJA1105_SPEED_2500MBPS])
> -		return SPEED_2500;
> -	return SPEED_UNKNOWN;
> -}
> -
> -/* Set link speed in the MAC configuration for a specific port. */
> -static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
> -				      int speed_mbps)
> +static int sja1105_set_port_speed(struct sja1105_private *priv, int port,
> +				  int speed_mbps)
>  {
>  	struct sja1105_mac_config_entry *mac;
> -	struct device *dev = priv->ds->dev;

I think if you could keep this line in the new sja1105_set_port_speed()
function..

>  	u64 speed;
> -	int rc;
>  
>  	/* On P/Q/R/S, one can read from the device via the MAC reconfiguration
>  	 * tables. On E/T, MAC reconfig tables are not readable, only writable.
> @@ -1313,7 +1295,7 @@ static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
>  		speed = priv->info->port_speed[SJA1105_SPEED_2500MBPS];
>  		break;
>  	default:
> -		dev_err(dev, "Invalid speed %iMbps\n", speed_mbps);
> +		dev_err(priv->ds->dev, "Invalid speed %iMbps\n", speed_mbps);

you could also get rid of this unnecessary line change.

>  		return -EINVAL;
>  	}

There are 2 more changes which I believe should be made in sja1105_set_port_speed():
- since it isn't called from mac_config() anymore but from mac_link_up()
  (change which happened quite a while ago), it mustn't handle SPEED_UNKNOWN
- we can trust that phylink will not call mac_link_up() with a speed
  outside what we provided in mac_capabilities, so we can remove the
  -EINVAL "default" speed_mbps case, and make this method return void,
  as it can never truly cause an error

But I believe these are incremental changes which should be done after
this patch. I've made a note of them and will create 2 patches on top
when I have the spare time.

>  
> @@ -1325,11 +1307,29 @@ static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
>  	 * we need to configure the PCS only (if even that).
>  	 */
>  	if (priv->phy_mode[port] == PHY_INTERFACE_MODE_SGMII)
> -		mac[port].speed = priv->info->port_speed[SJA1105_SPEED_1000MBPS];
> +		speed = priv->info->port_speed[SJA1105_SPEED_1000MBPS];
>  	else if (priv->phy_mode[port] == PHY_INTERFACE_MODE_2500BASEX)
> -		mac[port].speed = priv->info->port_speed[SJA1105_SPEED_2500MBPS];
> -	else
> -		mac[port].speed = speed;
> +		speed = priv->info->port_speed[SJA1105_SPEED_2500MBPS];
> +
> +	mac[port].speed = speed;
> +
> +	return 0;
> +}
> +
> +/* Set link speed in the MAC configuration for a specific port. */

Could this comment state this instead? "Write the MAC Configuration
Table entry and, if necessary, the CGU settings, after a link speed
change for this port."

> +static int sja1105_set_port_config(struct sja1105_private *priv, int port)
> +{
> +	struct sja1105_mac_config_entry *mac;
> +	struct device *dev = priv->ds->dev;
> +	int rc;
> +
> +	/* On P/Q/R/S, one can read from the device via the MAC reconfiguration
> +	 * tables. On E/T, MAC reconfig tables are not readable, only writable.
> +	 * We have to *know* what the MAC looks like.  For the sake of keeping
> +	 * the code common, we'll use the static configuration tables as a
> +	 * reasonable approximation for both E/T and P/Q/R/S.
> +	 */
> +	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
>  
>  	/* Write to the dynamic reconfiguration tables */
>  	rc = sja1105_dynamic_config_write(priv, BLK_IDX_MAC_CONFIG, port,
> @@ -1390,7 +1390,8 @@ static void sja1105_mac_link_up(struct phylink_config *config,
>  	struct sja1105_private *priv = dp->ds->priv;
>  	int port = dp->index;
>  
> -	sja1105_adjust_port_config(priv, port, speed);
> +	if (!sja1105_set_port_speed(priv, port, speed))
> +		sja1105_set_port_config(priv, port);
>  
>  	sja1105_inhibit_tx(priv, BIT(port), false);
>  }
> @@ -2293,7 +2294,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
>  {
>  	struct ptp_system_timestamp ptp_sts_before;
>  	struct ptp_system_timestamp ptp_sts_after;
> -	int speed_mbps[SJA1105_MAX_NUM_PORTS];
> +	u64 mac_speed[SJA1105_MAX_NUM_PORTS];

Could you move this line lower to preserve the ordering by decreasing line length?

>  	u16 bmcr[SJA1105_MAX_NUM_PORTS] = {0};
>  	struct sja1105_mac_config_entry *mac;
>  	struct dsa_switch *ds = priv->ds;
> @@ -2307,14 +2308,13 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
>  
>  	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
>  
> -	/* Back up the dynamic link speed changed by sja1105_adjust_port_config
> +	/* Back up the dynamic link speed changed by sja1105_set_port_speed

Could you please put () after the function name? I know the original
code did not have it, but my coding style has changed in the past 5 years.

>  	 * in order to temporarily restore it to SJA1105_SPEED_AUTO - which the
>  	 * switch wants to see in the static config in order to allow us to
>  	 * change it through the dynamic interface later.
>  	 */
>  	for (i = 0; i < ds->num_ports; i++) {
> -		speed_mbps[i] = sja1105_port_speed_to_ethtool(priv,
> -							      mac[i].speed);
> +		mac_speed[i] = mac[i].speed;
>  		mac[i].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
>  
>  		if (priv->xpcs[i])
> @@ -2377,7 +2377,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
>  		struct dw_xpcs *xpcs = priv->xpcs[i];
>  		unsigned int neg_mode;
>  
> -		rc = sja1105_adjust_port_config(priv, i, speed_mbps[i]);
> +		mac[i].speed = mac_speed[i];
> +		rc = sja1105_set_port_config(priv, i);
>  		if (rc < 0)
>  			goto out;
>  
> -- 
> 2.30.2
> 

