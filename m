Return-Path: <netdev+bounces-253216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WbdSMsuMdmmqRwEAu9opvQ
	(envelope-from <netdev+bounces-253216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:36:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCDC82846
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD393004202
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3353002D7;
	Sun, 25 Jan 2026 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYwmXtrO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0CC3FCC
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376968; cv=none; b=QFimGN11hGmsY1Cht9vcDWNuiVScBIq/LurRM+tkSdIlPE0Saw3PTViLuOh5iVOGRE5oNn/MDVKVnX5VFcRWqxEo3KtWUDX1Q2OJuZbixkouzvdSSs8Z7cTUmSrqm6KqfHlczj25/0RF4MCTl4ZrCINuis2KP0zf1oPiBpNf86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376968; c=relaxed/simple;
	bh=c3DQkGTg1M2NGHjQVSQTsJg6xQRSKDp67dfbOT1A6XU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtKDwf2WMJ5eX3aEDNo3m/dGIYCNaPybgFywgDmaY7BG2ELM9hBPs6zyGSpoYk+rjOKzDfNNOa7WaXpH66Arwg6dqTC2NsQ2IxFFxnxVoSJoa2vmWXSzvEgbkUOF4vqKxV7VgNy7MJgbJ4x8MIy3nWvCnAE/IGYpkWXwHzPd9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYwmXtrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455DBC4CEF1;
	Sun, 25 Jan 2026 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769376967;
	bh=c3DQkGTg1M2NGHjQVSQTsJg6xQRSKDp67dfbOT1A6XU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BYwmXtrOkxAeBCUQR0WPPfRGVRNMnlxzYAu96Y8egutt2aQSD8BJfYHL8wdFIV8hZ
	 z8dDjhtMtdR1ObniDpAk6p+mktg9jrnfvhQrURW5aoUVIqGq7mFeSJbDEyaaMAGA43
	 yR5LFTwf08JH2T0YCInHCxXEKCxUL+wrYSSpU0zP/K7YuLx4cl+wBPx36X6rwJqG9N
	 S+joJKuf4EVUrE9ZKbLVkWqeExmwzrLDecPrVYIxJaONiBgiRLFYEciGg5CexbU5lk
	 s94VpwviD/Yf+AmsByo5en9btLUifvnKHGz/COYXlOcraBHf0IsjzImfDz7laR16GR
	 6ZZEyvzrTJq9w==
Date: Sun, 25 Jan 2026 13:36:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v3] net: ethernet: mtk_eth_soc: avoid writing
 to ESW registers on MT7628
Message-ID: <20260125133606.1257ff61@kernel.org>
In-Reply-To: <20260122191822.1476732-1-joey@tinyisr.com>
References: <20260122191822.1476732-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253216-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADCDC82846
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 20:58:08 +0200 Joris Vaisvila wrote:
> The MT7628 has a fixed-link PHY and does not expose MAC control
> registers. Writes to these registers only corrupt the ESW VLAN
> configuration.
> 
> This patch registers empty phylink_mac_ops for MT7628, as removing the
> invalid register accesses leaves nothing to do on this SoC.
> 
> Fixes: 296c9120752b ("net: ethernet: mediatek: Add MT7628/88 SoC support")

If we're going with net-next please drop the Fixes tag.
We don't need a backport. You can quote the commit if you prefer eg:

This code was introduced by commit 296c9120752b ("net: ethernet:
mediatek: Add MT7628/88 SoC support")

> +static void rt5350_mac_config(struct phylink_config *config, unsigned int mode,
> +				const struct phylink_link_state *state)
> +{
> +}
> +
> +static void rt5350_mac_link_down(struct phylink_config *config, unsigned int mode,
> +				phy_interface_t interface)
> +{
> +}
> +
> +static void rt5350_mac_link_up(struct phylink_config *config,
> +			    struct phy_device *phy,
> +			    unsigned int mode, phy_interface_t interface,
> +			    int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +}

Is there any other driver that implements fixed link with phylink this
way? I know regrettably little about phylink. I'd think that mac up/down
usually would still do _something_.

> @@ -4779,6 +4801,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
>  	int id, err;
>  	int txqs = 1;
>  	u32 val;
> +	const struct phylink_mac_ops *mac_ops = &mtk_phylink_ops;

nit: try to keep local variables ordered longest line to shortest

>  	if (!_id) {
>  		dev_err(eth->dev, "missing mac id\n");
> @@ -4906,9 +4929,15 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
>  			  mac->phylink_config.supported_interfaces);
>  	}
>  
> +

nit: double new line

> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
> +		mac_ops = &rt5350_phylink_ops;
> +
>  	phylink = phylink_create(&mac->phylink_config,
>  				 of_fwnode_handle(mac->of_node),
> -				 phy_mode, &mtk_phylink_ops);
> +				 phy_mode,
> +				 mac_ops);
> +

nit: please don't insert empty lines between function call and its
error check

>  	if (IS_ERR(phylink)) {
>  		err = PTR_ERR(phylink);
>  		goto free_netdev;
-- 
pw-bot: cr

