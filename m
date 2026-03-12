Return-Path: <netdev+bounces-267018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDfDFKmasmnENwAAu9opvQ
	(envelope-from <netdev+bounces-267018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:51:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D2270811
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B23BC306CC06
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0DC390CAA;
	Thu, 12 Mar 2026 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuTYXSN9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsMy/Set"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FD40DFAB
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312673; cv=none; b=NRTcani+pJpzdoXbHtkIWXd8kt+g8m80bbxtHAcXl21+kZvc0Nv/E5JNp2ZvR7OcgHFBUzH5IykWBda+Wc1iKzoOS1xo/FVEwGcE/u45C0wpJamvX0BqoU/gDaP8p9NwrFFfKUb/q5hoFOOGRQ6ZWV7ez43fsnX63c4PpO55M6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312673; c=relaxed/simple;
	bh=EQkW6+lM7nq1mEy4KqkJc8bvPxN1VhQdmSs8sInnBXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wzo2zVBZS6BC5s02Cu01pjYmOL7oq+B3NnqsnutUn2rdqNF7owtbCifMG8ohIGkjuUqSH787z0c25U98AGhHQaLdvppFV38EchMi1VkIlLon+2dTIFOe6FksZsVE5HEfe9d531hfbzKWhWcNcaUyOwPb9uaYj99NZHTAlMucRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuTYXSN9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsMy/Set; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773312669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsY/vQXT9rNKMEUwHJ7p9ZkQrv3cw72S9U06qV9qj28=;
	b=OuTYXSN9dIB3yL+VSZD5VhyCmw2eGAPZAAv3FKI1y0uTYgDZH2eOmySy3gbBr5jOEjOoq9
	sxsM67bbHxSu2LdoQB6cy5Tg2Zqt50x0eQn5qt5Kq4ICJGWKQQ4PkMC0clPHJNSaYDcOog
	LnVWsXaTOqt3xoXimTekVBmJSG91SCw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-Vm0jUYPpPgSR469pKrEbTw-1; Thu, 12 Mar 2026 06:51:08 -0400
X-MC-Unique: Vm0jUYPpPgSR469pKrEbTw-1
X-Mimecast-MFC-AGG-ID: Vm0jUYPpPgSR469pKrEbTw_1773312667
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853553944fso13018905e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773312667; x=1773917467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CsY/vQXT9rNKMEUwHJ7p9ZkQrv3cw72S9U06qV9qj28=;
        b=hsMy/SetE+gflMxauowE/FCbKtG10b5eMz4KW+HzAblRRBPNkNdppDJorgvhVUNwn5
         HpzesIm9DkMLuJYn0ZYeFZKKLCis2tTSEFHPjtxBXU+Vv9rYYscvBVE3ZrGGxf3qPI37
         Xzwr80CcYpnnhRcvrM4E3QZIyyxor9KkfoG0jAptBZ8l//rd9xON+j/QdWvSbyHINMKA
         4qm9bg8rt1nkyi2O5RV6DiYU4beSBONVvRYLoVA+HzP89RpA/Ig1PrXnk874sEcxo0WM
         FDRZTGuh5Bw4u7MimJu+VKcogLfRLD6dfWc9PoCXCgPCQYa7Ms9KxFMRszLjoPkH9Rmm
         k5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773312667; x=1773917467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsY/vQXT9rNKMEUwHJ7p9ZkQrv3cw72S9U06qV9qj28=;
        b=n7IvpeWqgMLuT0inDdhtaaewN0scsLDThvgWABOYCNHopIsKlat1a0xkz5/WvONt41
         svbWc3lGJSC3wEpCtyC9Po93pFnuSaguJ43vSWc4SP3HmtxCcvAHl/wQVjxrr8sGNLma
         zVRPm4CXJ6c3NG+tD6b9bzsHEs5SuyAGTuUQd/Iyo5DRL4Xyp0nXwkxYCNjxaLl7R8lZ
         Lv7Dac+jukYnGjuAj3k0VgG/PaCE7sB7hZluDXplNSv8+vIiw2SxMF7aTfPkFBgNrn37
         Xx6z8pGnPcwg5ewL/xYJpYYD0zBXIxWHgZNSOADwzdjIX/mukzIdZwAyVdRQ5jdNkqDc
         xxTw==
X-Forwarded-Encrypted: i=1; AJvYcCXzwaR4iQoG1dKr9tT04dubnzZcftIH24gdOAHB/u55bVEpFy3utOGCx63ojKdqNiJkb90uMNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmfNE9S1QNbi6ui+OnoiY80JhCJ/uIQ2YPz1AzqTCO1z1+jOPv
	/pyqNhng8btTpOENmg6AQDUpP1Kh27LRPkLvwtPCH4M4cB4VxU8cd060T1DkYSN2Btl8SOxTcBu
	ETG1MGUqi/wvJ8aHh7z5l5wfBLHf6LTBJSWjVUJbnZ/8Gv3ghto6z3LXD9Q==
X-Gm-Gg: ATEYQzz/tufZ3VaQ6mz3FMcn1o6gDzgUOmZtYbliA+nd5V3gP+1HMJGbfpC3lJOuHsw
	TqNwglCGTJsZ86cuzwKAUFzypdgzJjTgFJCH0b3BhzcnwRNPolrorReU2VbWQnfb9noAyYlRKPF
	M8INhBzMQ2JeqyWeat0QIXPRD/PW1KcD9ezaUiHexBOY24xe+4m3e4CWBIq3MsxXYNVDTI2OS3G
	MxQKYtSKMCn51KonqxMV/po77xv6puvWA8t1Gx7ogxWoVyPMmCnTnShIDaOhOimUdqzhwIuv6z8
	ZGuxlLssfhVxzeleWU5QCQgkDc7mXBRl+K+Io19t6v3q5rgx01kwYbuVxSIu4jHyXUizAi5b3Os
	PgwHjRZ3Eufz3TCcXV4aEJYBlVF4eGIvs3q7c7UAGEMq+THzaEVE4Oss=
X-Received: by 2002:a05:600c:c4a4:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-4854f583e77mr36424165e9.9.1773312667381;
        Thu, 12 Mar 2026 03:51:07 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a4:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-4854f583e77mr36423755e9.9.1773312666862;
        Thu, 12 Mar 2026 03:51:06 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm311838795e9.2.2026.03.12.03.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 03:51:06 -0700 (PDT)
Message-ID: <d69b5b88-449a-40c9-a704-9ccdfb616ca0@redhat.com>
Date: Thu, 12 Mar 2026 11:51:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v7,05/10] net: phy: Represent PHY-less SFP modules with
 phy_port
To: maxime.chevallier@bootlin.com
Cc: o.rempel@pengutronix.de, herve.codina@bootlin.com, andrew@lunn.ch,
 edumazet@google.com, linux-kernel@vger.kernel.org, hkallweit1@gmail.com,
 netdev@vger.kernel.org, kuba@kernel.org, romain.gantois@bootlin.com,
 f.fainelli@gmail.com, christophe.leroy@csgroup.eu,
 kory.maincent@bootlin.com, mwojtas@chromium.org,
 dimitri.fedrau@liebherr.com, nicveronese@gmail.com, horms@kernel.org,
 daniel@makrotopia.org, kabel@kernel.org, linux@armlinux.org.uk,
 vladimir.oltean@nxp.com, davem@davemloft.net, thomas.petazzoni@bootlin.com,
 bjorn@kernel.org
References: <20260309152747.702373-6-maxime.chevallier@bootlin.com>
 <20260312104733.87688-1-pabeni@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260312104733.87688-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,google.com,vger.kernel.org,gmail.com,kernel.org,csgroup.eu,chromium.org,liebherr.com,makrotopia.org,armlinux.org.uk,nxp.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-267018-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: AC9D2270811
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:47 AM, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: phy: Represent PHY-less SFP modules with phy_port
> 
> Now that the SFP bus infrastructure notifies when PHY-less modules are
> connected, we can create a phy_port to represent it. Instead of letting
> the SFP subsystem handle that, the Bus' upstream is in charge of
> maintaining that phy_port and register it to the topology, as the
> upstream (in this case a phy device) is directly interacting with the
> underlying net_device.
> 
> Add a phy_caps helper to get the achievable modes on this module based
> on what the phy_port representing the bus supports.
> 
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 4b06644866b2..faa58a780477 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
> 
> [ ... ]
> 
>> @@ -1483,6 +1483,8 @@ static int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
>>  	struct phy_device *phydev = upstream;
>>  	struct net_device *dev = phydev->attached_dev;
>>
>> +	phydev->has_sfp_mod_phy = true;
>> +
>>  	if (dev)
>>  		return phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);
> 
> If phy_link_topo_add_phy() fails, does has_sfp_mod_phy get cleaned up
> correctly?
> 
> Looking at the SFP framework, when phy_link_topo_add_phy() fails here,
> sfp_sm_probe_phy() in sfp.c will free the PHY but won't call
> disconnect_phy (because sfp->mod_phy was not set). This leaves
> has_sfp_mod_phy stuck as true.
> 
> On a subsequent SFP module insertion, phy_sfp_module_start() checks
> !phydev->has_sfp_mod_phy:
> 
> drivers/net/phy/phy_device.c:phy_sfp_module_start() {
> 	if (!phydev->has_sfp_mod_phy)
> 		return phy_add_sfp_mod_port(phydev);
> }
> 
> Seeing has_sfp_mod_phy is true (stale), it skips creating the mod_port
> for a PHY-less module. The module then won't be represented in the link
> topology.
> 
> Would it be better to either set has_sfp_mod_phy after
> phy_link_topo_add_phy() succeeds, or clear it in an error path?

Out of sheer ignorance IDK if phy_sfp_module_start() could really happen
in practice after a phy_sfp_connect_phy() failure, but the inconsistency
is likely worthy a cleanup?

Leaving the series alive in PW, in case the phy crew disagree or a
follow-up is preferred to a repost.

/P


