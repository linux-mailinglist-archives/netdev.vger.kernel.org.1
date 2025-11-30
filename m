Return-Path: <netdev+bounces-242836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB5C95465
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 21:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1AEA341FE3
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E881219319;
	Sun, 30 Nov 2025 20:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D262213254
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764534643; cv=none; b=nQNhaAhMlpLbKOe7femelfJimKOLeK/jBJX70inxKeuiGBTGgtNffrFgV+w5Utw17fN7+7JgquRDQY72haR2ih0P1lgOWfCjWTqRDAdfZwUyDJFVtAifz9Y4TrIyRiGC6zCXX54OEWvqsOCcEceNiwfjzK1xw/+0cPwZ0mq1qMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764534643; c=relaxed/simple;
	bh=wxDHYGASRkYEzgGWn/OKmQaGs6C8SuYjkQ2scIIJGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEK4SQFY20DQVIUxmp11KvfS+EzTbtp3fN2AQe6Vzlujux2RKpmDQsBPd2CDgw3K3e0j1lPbK4P7Y9KAScMgqsqIV2WVW+U1aIj089FoJxZNb3kITFbVC3cUFiPOzbbenuS/KQUoxMUwiCs36/iV93NMec7DYxLfzhwPoEJFiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vPo3z-000000001g3-1U3v;
	Sun, 30 Nov 2025 20:30:31 +0000
Date: Sun, 30 Nov 2025 20:30:22 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH net-next 01/15] net: dsa: mt7530: unexport
 mt7530_switch_ops
Message-ID: <aSypSUayaaCMgAkH@makrotopia.org>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
 <20251130131657.65080-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130131657.65080-2-vladimir.oltean@nxp.com>

On Sun, Nov 30, 2025 at 03:16:43PM +0200, Vladimir Oltean wrote:
> Commit cb675afcddbb ("net: dsa: mt7530: introduce separate MDIO driver")
> exported mt7530_switch_ops for use from mt7530-mmio.c. Later in the
> patch set, mt7530-mmio.c used mt7530_probe_common() to access the
> mt7530_switch_ops still from mt7530.c - see commit 110c18bfed41 ("net:
> dsa: mt7530: introduce driver for MT7988 built-in switch").
> 
> This proves that exporting mt7530_switch_ops was unnecessary, so
> unexport it back.
> 
> Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: DENG Qingfang <dqfext@gmail.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/dsa/mt7530.c | 3 +--
>  drivers/net/dsa/mt7530.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 548b85befbf4..1acb57002014 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -3254,7 +3254,7 @@ static int mt7988_setup(struct dsa_switch *ds)
>  	return mt7531_setup_common(ds);
>  }
>  
> -const struct dsa_switch_ops mt7530_switch_ops = {
> +static const struct dsa_switch_ops mt7530_switch_ops = {
>  	.get_tag_protocol	= mtk_get_tag_protocol,
>  	.setup			= mt753x_setup,
>  	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
> @@ -3291,7 +3291,6 @@ const struct dsa_switch_ops mt7530_switch_ops = {
>  	.conduit_state_change	= mt753x_conduit_state_change,
>  	.port_setup_tc		= mt753x_setup_tc,
>  };
> -EXPORT_SYMBOL_GPL(mt7530_switch_ops);
>  
>  static const struct phylink_mac_ops mt753x_phylink_mac_ops = {
>  	.mac_select_pcs	= mt753x_phylink_mac_select_pcs,
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 7e47cd9af256..3e0090bed298 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -939,7 +939,6 @@ static inline void INIT_MT7530_DUMMY_POLL(struct mt7530_dummy_poll *p,
>  int mt7530_probe_common(struct mt7530_priv *priv);
>  void mt7530_remove_common(struct mt7530_priv *priv);
>  
> -extern const struct dsa_switch_ops mt7530_switch_ops;
>  extern const struct mt753x_info mt753x_table[];
>  
>  #endif /* __MT7530_H */
> -- 
> 2.34.1
> 

