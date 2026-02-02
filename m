Return-Path: <netdev+bounces-255828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBOkOCV9gGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:32:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEFBCB046
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C64530142AA
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835A356A2C;
	Mon,  2 Feb 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTCEMllO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3D3563FE
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027966; cv=none; b=EAJ9xicYKPeiAqeBfiXA7VXS1HvJWkYBvZWcA69A4V3BmHFVFcfX5jkjFZQ3wUfBjRr/rHxFsBNTyDXmis6JNPHAII2kGcu6mURUjveI3CAwwlUjC82A1HYtQH64MVr22yAsjAaKVYLrdy2MI646+MfxpsgUtsoXYnMBukK93t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027966; c=relaxed/simple;
	bh=6RkpVDdjKS1cEqhzp4qh0H5+8SIuppW8dS6hrwHz7rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/qxNnZFzj4fflS0slYvJAJA9RccTDVBs+IiDoYzkVLUDbBth/Dm0831zPB1yZRBjM5eppEqPgjk8BhTMsl4oSmYX6NRl1RAqRCZQNzTSl2owt7zflSNwHLVhTlhPrgmiPjneOI2DihCaf4a2ei6yLOB73IfbP79nZPWaAbGBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTCEMllO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-658b7d13f09so7755164a12.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 02:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770027962; x=1770632762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhuLtSgA6l7SJff+B0SV6cgaLcC02S6ZNZgIorj/3O0=;
        b=fTCEMllOArZ6D6u4ooO6sf7ExW0JdTyd9kExqlJgEhwc6BL67fm2pCog+GTIKfWDuZ
         0YpJMH4Vg3Djs15utnD21vanO5ZWZMNge16SlxzQqfWXDXDENPv1sgL+y1+TP81eE9cN
         6HyRtHzhmddAVem02l0fc7b51UghQtnNVcJcVuLs6Mf9Pk02bPOLm7IflREz6Ev2bmpr
         /6QZrHxEl0CPzr85YZj7ZLaO4mf9o8xumHi36TffHzNc9OGiCmbLMaEjYhPfrhNvq8k1
         g/g7ej6GYEdeBUfeKCzVqlL7zdu7i7RrQoqe9odLABfNxiO6PDEgT6PxrwioSvSujjwA
         aYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027962; x=1770632762;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhuLtSgA6l7SJff+B0SV6cgaLcC02S6ZNZgIorj/3O0=;
        b=vRJ+OaBLYm9wlyHU9IB4r0Oeg6ohu91Sjs/OJAuzju5+kGpNhj6yilctgsbK25JeyW
         1gLBKNejFPUY5wRCvaSNgHnn4rd8M9l1ZYXv2tOpcNrpkqUufHPwbz9qfEQ80qetsp4u
         oStDUwR3t7cVu4MpD4/vx6aodlrzpVW6oxtbMEn97fqoONEr5UAgfQoBiiCXDtnA9g+D
         up+dg2yzaLhm9IXunZCMeb4IeXGVHiQ6wt48nMWNRMyRMOHYTikQm0VuqLolQNp9PM2i
         zs+/oYb2XGID5y84ncvtM+LSuApRdKQOxjPBAJDNLIpKv3wRJLoHYRx/a0ZTz3e7l7Be
         lVyg==
X-Forwarded-Encrypted: i=1; AJvYcCUoXvNk1cJsqxuQxKfmlYMSYwmX0pKv8nE3jM0/1b+ZdtJHEjP8+bhHu/xwDVSVV4iasy3SRac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+eHKuh1t5kx6ZE8ITHLL8WhKzCzu34guArcnWNK3Rs7XecrS
	9sRHH9RHnqdGsJbfheMoQ8Xlyfew4Zze2zAodpEDnYAl0C4Xcv0/5bCV
X-Gm-Gg: AZuq6aKYAHzvSeZPONdEhFTSRlInPNT20U4dWPm71bjjHzBXfgD9+7dFmenBHjNypqu
	SApf0o7Uw4+ntVBGaZHsdyjrVkD5T3ynj7ip6FoWB4wVduE8H5C/VmpXZbMu2dfC96uxbYs/wwe
	Zy6MFo85DeDzupxuacozbD6SvfsLF5Fu6hmaOzzJjGWUwCf/ltYdS88PTCFgrgh3wwZ4E7xyrra
	woWqMMAAtP5AwbL565pk6EuMnG535BwJvuhDrA7m2ya3a9awmziiPtwe5B75gaSYZzoedKIVMus
	DL6Vjth8YY1Q5w9AF/y9qMcQKfYwPNaoJwm69ewqC9ZiaV0ZwUIl++oKIuFRkm3GQuZOJ2B/Z30
	KbEIbF2bxSxWy0hJrX7VCsTi9OmicX/Q91vfl7P2xmo8ATlJJ/Q4VjzUNMgSO1i9EyPrjKVjOS+
	zNqnCJU23cx1E8hbNcn5OYkbi7anuNSELNJvvTe1xrlCpeOx58V8OD5DCAmGULJEaAu50aqtlg
X-Received: by 2002:a17:907:e10d:b0:b80:3846:d46 with SMTP id a640c23a62f3a-b8dff5e4a92mr500803966b.20.1770027961757;
        Mon, 02 Feb 2026 02:26:01 -0800 (PST)
Received: from [192.168.0.2] (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc6995sm833886366b.24.2026.02.02.02.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:26:01 -0800 (PST)
Message-ID: <795c3351-d65b-4a9a-83dc-b530177b9d28@gmail.com>
Date: Mon, 2 Feb 2026 11:26:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: marvell: prestera: fix FEC error message
 for SFP ports
To: Alok Tiwari <alok.a.tiwari@oracle.com>, tchornyi@marvell.com,
 vmytnyk@marvell.com, yevhen.orlov@plvision.eu, vkochan@marvell.com,
 taras.chornyi@plvision.eu, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com
References: <20260202052816.28191-1-alok.a.tiwari@oracle.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Content-Language: en-US
In-Reply-To: <20260202052816.28191-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FEFBCB046
X-Rspamd-Action: no action

Hi,

On 02/02/2026 06:28, Alok Tiwari wrote:
> In prestera_ethtool_set_fecparam(), the error message is opposite of
> the condition checking PRESTERA_PORT_TCVR_SFP. FEC configuration is
> not allowed on SFP ports, but the message says "non-SFP ports", which
> does not match the condition.
> 
> Fix the message to match the condition.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> index 2f52daba58e6..a259da9f30f4 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_ethtool.c
> @@ -718,7 +718,7 @@ static int prestera_ethtool_set_fecparam(struct net_device *dev,
>  	}
>  
>  	if (port->caps.transceiver == PRESTERA_PORT_TCVR_SFP) {
> -		netdev_err(dev, "FEC set is not allowed on non-SFP ports\n");
> +		netdev_err(dev, "FEC set is not allowed on SFP ports\n");
>  		return -EINVAL;
>  	}
>  

I'm pretty sure that the condition here is wrong, not the error message.

AFAIK it doesn't make sense to configure FEC on ethernet/copper ports,
but for SFP ports, it may be required depending on the transceiver or
cable used, especially for fiber modules.

I may be wrong though.

This check was introduced with bb5dbf2cc64d ("net: marvell: prestera:
add firmware v4.0 support"), but that commit does not offer any
explanation for it in the commit message.

Best regards,
Jonas

