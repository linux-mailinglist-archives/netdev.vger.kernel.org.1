Return-Path: <netdev+bounces-272784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFR0FE/5x2lMfQUAu9opvQ
	(envelope-from <netdev+bounces-272784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:52:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA31B34F03D
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E9B030041CC
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A472B342510;
	Sat, 28 Mar 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTFwf9Vp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E213AA2D
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774713164; cv=none; b=BIKOHDH4/jDCCkWwSfWrgV7PPd0okmS9FKtN7AvcuA5sZJpDT7c4JHxIu3wR5hd3hJbf5RwLj0QCI2Q7YL4VMZcaaKecdPZWUeyWDsQ82nX8o7I6Ovw41+woubS0C7xsv+qSAPb1VgBOUFhTb8tP5G5To7i5DqyF64oYmaDMHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774713164; c=relaxed/simple;
	bh=93XagFVPNl3duxbBvxcwUDBo3vyzqKak8SMWenv0TS4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g4goCk+eI+0acwIEasCuNauBD7WZNXZqSO8jCgjSiDzOX+e/2K0c9rgl2CbH9Wq57EuKrttPJraPRzDETsUqUOVeOY/wASNXDqyNXkpeET4rHu9tuiTCT5f9ZmqECLyww2BdnV5YxrX1MNuL2/pCzzR+hsGVusUvZL8P72deERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTFwf9Vp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a43f1f978so26962711fa.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774713161; x=1775317961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y7pyXU2qFzEOnU8j2MDB/XlKYkbXJkeDxLklHnoWscA=;
        b=pTFwf9VpgkkL4V5yKtX9uG2X9s24eusiMb8jCAgtWMPXsvm3Bu1ATv5obC0bO0oOHp
         MwsgX/gU+2ZzI+puBX2XvkCANrQlzYP7vfn2pf8xjyz406QCN7XN7Hk9ohKfrNbP/u4g
         6Vax+X5kbWBNGZaHgGykzKINTVEJdDphIqrS2kcmCIoc1ocfJ+lkvK/6LiBX1eIG1gGW
         QKukpLK1XsYZi90GDtvLFbdPZ1YCi7u6KzoMjxnUSj3t3Tct5xKxKqOOhb20CV+evgYs
         R/OIyQp0CqVHJrZrh/ZsdrMirI+TDuuNL8WmAUZ3/sdGXgnIOUM47A2voOi1OQlTfles
         3yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774713161; x=1775317961;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7pyXU2qFzEOnU8j2MDB/XlKYkbXJkeDxLklHnoWscA=;
        b=JFNUUtqDWaQ2BS5trvN/U+kBHylFoN2U7AVtbN5Blnkxj2wyRjBmjdfJFxEqynmScX
         5Fcc45n3Ty74J9SQFCX3sHymJkSRf8z47ISbD98Tm7tvy9GwPr5BuXZqV0lrA2biTR/4
         YQykyMKgXBfO4x08IAnjDg7O2y5RoNq2+JemiNVn/GeMYzhfwuHI+phAOP0QxjlwFcno
         H1GMibQTDxQkYDikAG/++ijM15Zqwyksf1UVJUFfGUeMu3SBGcGJoOB4IkryjdxwrhQU
         EsNKjusO5p9Cpi+7AHW394LbbZKv2o7E1kIRve+hzcaLNI+We/TFmgP+Jg4WiuxEmy7x
         yUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAh32mxCS8WvxIwK34MdsqkwrTH1O1LdzFI5TEuRuBSHDgq8wBMzyzs4lG1YzUVCXxggEpL/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqecf6KI8CSZ+yEnnQMNg2BoM7vnggFQyOyIwRgNZNuewC5BkH
	D+hzrVt0VqINhNlcDxv//o1P/ZBFwwAZarW17ndZfzFfjQEKMudl3otOT6qfgA==
X-Gm-Gg: ATEYQzwiukmE9ABJGzVkAmAbvQue24NEHLN0psU2cpZOf52KZ26cI4wOOxDHiRbLkPW
	ug/690Hq8f0qJcz6NuoGWcv1Ewe2+BTx8kxrb/1QglramTPFRlbpZeIDh56FzoISy0PGP0ljepb
	+y+jjS/FwxbAXPUwrMTVoLW++3yQtdgKHoO1Stp/rf7pIBlAp7BCKJc4qbVGblPNqyR+wKrRTNu
	atwFJQ72H7TXs3mGk0HKIj6x0Mh6jPVCnrfjPlDcHKtYKC/hNW3xKABJ8w07aU38Fm2V4GmZnAP
	HE5JKmdfEbeKNCVXLE/AdEnPQ2AVPCTG+lSqUJCJ4KcGcGmizUqtNU+84Fo8vmOkXEoMZ0RHY5J
	xzGvCxvGau9LwOG8kCPi5VU2FQ/0mWBDo4HylyExInQEAXfrTQnf44c5Cw98XDTme9HvwmkbMl+
	VZQcuWSffvz70tkpGdMQ5uAPYNYoqL2ynFhFHScFr8zuvpH5mtJJHuudjagR91BLemizF80qaYx
	KkyzfVdcSd+udAtNGwQ6+z+gzqgwVsdTpQrHtNuY87duNTo13uWxCyZYDJAafS8yqoc7/BgQdhs
	jCpQAbJgZqpNYfh7rxY2WEoAkZcQw3hB4w==
X-Received: by 2002:a17:907:1c1e:b0:b98:5b6b:9138 with SMTP id a640c23a62f3a-b9b50363003mr311019166b.19.1774693320670;
        Sat, 28 Mar 2026 03:22:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1e3aeesm62735466b.48.2026.03.28.03.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:22:00 -0700 (PDT)
Message-ID: <6f42d92b-a26d-49a4-bef7-2227c252eea7@gmail.com>
Date: Sat, 28 Mar 2026 11:21:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
From: Eric Woudstra <ericwouds@gmail.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no
Cc: frank-w@public-files.de, daniel@makrotopia.org, lucien.jheng@airoha.com
References: <20260326153518.8387-1-lucienzx159@gmail.com>
 <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
Content-Language: en-US
In-Reply-To: <edeee8e5-0de3-48ea-aeb5-cc705fdcd469@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272784-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA31B34F03D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/27/26 5:41 AM, Eric Woudstra wrote:
> static int __air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
> 				u32 pbus_data)
> {
> 	int ret;
> 
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
> 			      (u16)(pbus_address >> 6));
> 	if (ret < 0)
> 		return ret;
> 
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf,
> 			      (u16)pbus_data);
> 	if (ret < 0)
> 		return ret;
> 
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH,
> 			      (u16)(pbus_data >> 16));
> 	if (ret < 0)
> 		return ret;
> 
> 	return 0;
> }
> 
> static int air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
> 			      u32 pbus_data)
> {
> 	int ret;
> 
> 	mutex_lock(&mdio->bus->mdio_lock);
> 
> 	ret = __air_pbus_reg_write(mdio, pbus_address, pbus_data);
> 	if (ret < 0)
> 		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
> 			pbus_address, ret);
> 
> 	mutex_unlock(&mdio->bus->mdio_lock);
> 
> 	return ret;
> }
> 
> static int __air_pbus_reg_read(struct mdio_device *mdio, u32 pbus_address,
> 			       u32 *pbus_data)
> {
> 	int ret, pbus_data_low;
> 
> 	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
> 			      (u16)(pbus_address >> 6));
> 	if (ret < 0)
> 		return ret;
> 
> 	ret = __mdiobus_read(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf);
> 	if (ret < 0)
> 		return ret;
> 	pbus_data_low = ret;
> 
> 	ret = __mdiobus_read(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH);
> 	if (ret < 0)
> 		return ret;
> 
> 	*pbus_data = (ret << 16) + pbus_data_low;
> 
> 	return 0;
> }
> 
> static int air_pbus_reg_read(struct mdio_device *mdio, u32 pbus_address,
> 			     u32 *pbus_data)
> {
> 	int ret;
> 
> 	mutex_lock(&mdio->bus->mdio_lock);
> 
> 	ret = __air_pbus_reg_read(mdio, pbus_address, pbus_data);
> 	if (ret < 0)
> 		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
> 			pbus_address, ret);
> 
> 	mutex_unlock(&mdio->bus->mdio_lock);
> 
> 	return ret;
> }
> 
> With:
> 
> #define AIR_PBUS_DATA_HIGH		0x10

Small correction using upper_16_bits() and lower_16_bits():

static int __air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
				u32 pbus_data)
{
	int ret;

	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_EXT_PAGE_ACCESS,
			      (u16)(pbus_address >> 6));
	if (ret < 0)
		return ret;

	ret = __mdiobus_write(mdio->bus, mdio->addr, (pbus_address >> 2) & 0xf,
			      lower_16_bits(pbus_data));
	if (ret < 0)
		return ret;

	ret = __mdiobus_write(mdio->bus, mdio->addr, AIR_PBUS_DATA_HIGH,
			      upper_16_bits(pbus_data));
	if (ret < 0)
		return ret;

	return 0;
}

static int air_pbus_reg_write(struct mdio_device *mdio, u32 pbus_address,
			      u32 pbus_data)
{
	int ret;

	mutex_lock(&mdio->bus->mdio_lock);

	ret = __air_pbus_reg_write(mdio, pbus_address, pbus_data);
	if (ret < 0)
		dev_err(&mdio->dev, "%s 0x%08x failed: %d\n", __func__,
			pbus_address, ret);

	mutex_unlock(&mdio->bus->mdio_lock);

	return ret;
}


