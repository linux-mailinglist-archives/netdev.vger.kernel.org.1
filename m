Return-Path: <netdev+bounces-28441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254DC77F771
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D71C211C8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02414265;
	Thu, 17 Aug 2023 13:14:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AA100CC
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:14:07 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F5D3593;
	Thu, 17 Aug 2023 06:13:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 463AE2186F;
	Thu, 17 Aug 2023 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692278025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGHE/p4sCN/7vLHlmX0J+FqvhKQ1k35l/n9hGy5/t7c=;
	b=XATF+sc2ch6jyL/Ol3PBJJrxuZy/17xDRjLCXeNYd/uwMJ9cFkmb/B5FxUdDGdWbcjZSQc
	LGGC0yXo6eYLlVc7lnjiyoz/CdoOD/v+slsPtPSd8SnBc1bwsDvSu9ugKIX8ItoNJyASdG
	Nj+TqJBPWzOGgKztFEu9EbQiYiokeL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692278025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGHE/p4sCN/7vLHlmX0J+FqvhKQ1k35l/n9hGy5/t7c=;
	b=xzwuIRVlHRiYyaurPVGprTL3wIO4zWyUCB2BWFYfr96ExKvodWemqZxLwOY3DZuScNJ+iN
	WZS+SG96HGLGXuDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1892D1392B;
	Thu, 17 Aug 2023 13:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vCQuBQkd3mTvdwAAMHmgww
	(envelope-from <dkirjanov@suse.de>); Thu, 17 Aug 2023 13:13:45 +0000
Message-ID: <565a8248-c4d1-f135-2499-6bbfe76def53@suse.de>
Date: Thu, 17 Aug 2023 16:13:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH net-next] net: pcs: lynxi: fully reconfigure if link is
 down
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Alexander Couzens <lynxis@fe80.eu>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <e9831ec99acd5a8ab03c76fce87fa750c7041e60.1692273723.git.daniel@makrotopia.org>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <e9831ec99acd5a8ab03c76fce87fa750c7041e60.1692273723.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/23 15:04, Daniel Golle wrote:
> On MT7988 When switching from 10GBase-R/5GBase-R/USXGMII to one of the
> interface modes provided by mtk-pcs-lynxi we need to make sure to
> always perform a full configuration of the PHYA.
> As the idea behind not doing that was mostly to prevent an existing link
> going down without any need for it to do so. Hence we can just always
> perform a full confinguration in case the link is down.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/pcs/pcs-mtk-lynxi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> index b0f3ede945d96..788c2ccde064e 100644
> --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> @@ -108,8 +108,8 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  				bool permit_pause_to_mac)
>  {
>  	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
> -	bool mode_changed = false, changed;
> -	unsigned int rgc3, sgm_mode, bmcr;
> +	bool mode_changed = false, changed, link;
> +	unsigned int bm, rgc3, sgm_mode, bmcr;
>  	int advertise, link_timer;
>  
>  	advertise = phylink_mii_c22_pcs_encode_advertisement(interface,
> @@ -117,6 +117,10 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	if (advertise < 0)
>  		return advertise;
>  
> +	/* Check if link is currently up */
> +	regmap_read(mpcs->regmap, SGMSYS_PCS_CONTROL_1, &bm);
> +	link = !!(FIELD_GET(SGMII_BMSR, bm) & BMSR_LSTATUS);
> +
>  	/* Clearing IF_MODE_BIT0 switches the PCS to BASE-X mode, and
>  	 * we assume that fixes it's speed at bitrate = line rate (in
>  	 * other words, 1000Mbps or 2500Mbps).
> @@ -137,7 +141,10 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  		bmcr = 0;
>  	}
>  
> -	if (mpcs->interface != interface) {
> +	/* Do a full reconfiguration only if the link is down or the interface
> +	 * mode has changed
> +	 */
> +	if (mpcs->interface != interface || !link) {

btw is it a thread-safe to check the mpcs->interface member?
I've quick checked and phylink_pcs_config can be invoked from different places
and the code below does the following assignment:
mpcs->interface = interface;



>  		link_timer = phylink_get_link_timer_ns(interface);
>  		if (link_timer < 0)
>  			return link_timer;

