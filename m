Return-Path: <netdev+bounces-291110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKbyLcK6EWo5pQYAu9opvQ
	(envelope-from <netdev+bounces-291110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:33:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 107715BF639
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 618873021E8B
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A72E62A9;
	Sat, 23 May 2026 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qMfnV2Om"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F82DCC04
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546778; cv=none; b=nwBGZUM/SaM2knwFe8qlt5FiyHT7ObWNw9myhKKmk+2OqFXUCsPGREnGfzDEDjji5CoU8PuIk6J5JRGnyiaCi/1/1nsqCEaiXLGjWufexWIS1FayysS+Baqye3vJxB3U+OqVANO0NeahdpsKvN2hRtNVC0z8Fdad3wLkM7rprCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546778; c=relaxed/simple;
	bh=EkQgmsfdGZbdMffx/qvpeZ17fFVdHlkFu4wUhsTrCD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZ4BegN+pfWTgKrMQhVRDMacAxiv48RNxBijkpIMNB/OEpTNjTQWNsS2ym+0ETbr6tt2u8+qM9RRjiS0R47nWpV9UwOFFBb0LRae1FRomtZVTV5zTGuoDNPIbK2jdDe3pETXLGQ6PGGLghoskATvNgxhV6FIh+hxo6VgyTip+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qMfnV2Om; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8E44C1A368B;
	Sat, 23 May 2026 14:32:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D56660733;
	Sat, 23 May 2026 14:32:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C83C10811D9F;
	Sat, 23 May 2026 16:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779546764; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ubDFrB9Q4xQe7HWrc+hIZr40Wg4MUcI8hEZo/xRyfU8=;
	b=qMfnV2OmD8ZRa/dimdnHoAW1UKpKh4ni5xGRAQmI03za2gNnKlculz/z4ueSLyMPhQDdma
	ed0YKyQNwR7vOU2VlB1Gjc/BEOMJ5HZEgsmpYb6CHQO6zxsTwkYQrB5jv4d1QEhhBS48Gz
	BZfdVmeu5oDGiR9XxITP41fBbyRwtlaxbs+rMO9qwwV+N1SLkOg4gFBurlbCMWXfaAF5FH
	RjxWdrXYxQZw36msHwD+oQwo63Kep/ustNFSggMekPFoeihpWE9iGzsbW2bOs5BlOtGHKo
	gvUbW9UxqrX/+IVD3pAi915MWlMqGtLXre07w6AJUuCPxfKvgm6eQrcRc01pGQ==
Message-ID: <a43b1c60-4bd3-4070-b474-67e5d8d62eeb@bootlin.com>
Date: Sat, 23 May 2026 16:32:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/9] ethtool: module: avoid leaking a netdev ref on
 module flash errors
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, danieller@nvidia.com,
 petrm@nvidia.com, o.rempel@pengutronix.de, idosch@nvidia.com, andrew@lunn.ch
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-3-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260522231312.1710836-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291110-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 107715BF639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/23/26 01:13, Jakub Kicinski wrote:
> module_flash_fw_schedule() is missing undo for setting
> the "in_progress" flag and taking the netdev reference.
> Delay taking these, the device can't disappear while
> we are holding rtnl_lock.
> 
> Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> CC: danieller@nvidia.com
> CC: petrm@nvidia.com
> ---
>   net/ethtool/module.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/module.c b/net/ethtool/module.c
> index 741f6fb25d45..392c03935e5e 100644
> --- a/net/ethtool/module.c
> +++ b/net/ethtool/module.c
> @@ -319,8 +319,6 @@ module_flash_fw_schedule(struct net_device *dev, const char *file_name,
>   	if (err < 0)
>   		goto err_release_firmware;
>   
> -	dev->ethtool->module_fw_flash_in_progress = true;
> -	netdev_hold(dev, &module_fw->dev_tracker, GFP_KERNEL);
>   	fw_update->dev = dev;
>   	fw_update->ntf_params.portid = info->snd_portid;
>   	fw_update->ntf_params.seq = info->snd_seq;
> @@ -335,6 +333,9 @@ module_flash_fw_schedule(struct net_device *dev, const char *file_name,
>   	if (err < 0)
>   		goto err_release_firmware;
>   
> +	dev->ethtool->module_fw_flash_in_progress = true;
> +	netdev_hold(dev, &module_fw->dev_tracker, GFP_KERNEL);
> +
>   	schedule_work(&module_fw->work);
>   
>   	return 0;


