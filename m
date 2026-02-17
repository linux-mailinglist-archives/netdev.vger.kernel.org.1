Return-Path: <netdev+bounces-258979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC5fIUwllGnXAAIAu9opvQ
	(envelope-from <netdev+bounces-258979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:22:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1896149E56
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF763008215
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361F42DCF45;
	Tue, 17 Feb 2026 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lfe06shC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pZyRD2kQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44EF33993
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316554; cv=none; b=b09plZZqIz2xBaihxadBXLqj9N1zTP9rXo/w7f/Pzqcjk8jsiaL96KtzgbTXd3PCT3BEVVxUdUNJk9POoG2TmnDKeq5t9tjFO+J2FL7yZeMMmWEZjFG6SKrs+Yp5d5Diyq30WWQi6rA7lO3OU6hHvazieypT3shq+qhUb6i372k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316554; c=relaxed/simple;
	bh=mTBibbIrxTo705P0hKuLMeHpa+PbJX0gNSLzGp96SJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7JFg3YVGIzO8Pdw8C1hSXTscF9Awyeur+VzhWNggVjWlZ7gTHlVN5rPXuvJciG/7SZ4E6hlsaN8y1iL7XkVaiQuZhKUwDnvWhWr3A7Yl6//8M/lc26qEo1+IL7U5pz4Kwlb4dUSd34SL8hrcM8/a2dNsLwpJ/ekGN30WkkJIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lfe06shC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pZyRD2kQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771316551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bx/q5VhEMKYi6ocCTPiZ6xHKLvhxYLjeRnABX5dgCdQ=;
	b=Lfe06shCztUDWiaz7VfgsB3jcLJQG0P5euhiX0GduLZxSXk6ijHbmF/ep3vgXlcKhA2GIs
	hcTmuZcTOCmckzRZwzV3n96d6GrmGoHXinLFYeZypyT6XGnzYCVYqBNdjjZJc1CMiibwW3
	QZi08FAoxbpwI119d6pA4cCmC169qGM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-EIb534YWPSewvtXrXR0wjA-1; Tue, 17 Feb 2026 03:22:30 -0500
X-MC-Unique: EIb534YWPSewvtXrXR0wjA-1
X-Mimecast-MFC-AGG-ID: EIb534YWPSewvtXrXR0wjA_1771316549
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837a71903aso16806005e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771316549; x=1771921349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bx/q5VhEMKYi6ocCTPiZ6xHKLvhxYLjeRnABX5dgCdQ=;
        b=pZyRD2kQFFOGMrvXRcYTEPMiCVQtu4b1UsDJSCxPd5cjCWdTMca5r0/Fsm43oWtZlo
         PgEHl6fR+JqSdNK5cUyEdaZfFNNLt91706/75Y3yPiAv9UHJjSbppkvWSV7fNIS0Da8b
         Blx9B1v4GX4AViBaImjNeJsf98GJggs6qv0AxuGx5Ww3hYFUw1aQo2qWC9/rPMRLo9AQ
         4W69X7pBaCw97xgbNcHRZmNhqyAgIq7ABTibVMrIIBFBNKXctMEc8XMhed3T0byZE9dX
         UZXB35Fz6qicHddOkOhY4Yfdvw+UmEdHqPr8KZHco7rNZzPZT5hNXLs3YluSXGnHTxxA
         WevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771316549; x=1771921349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx/q5VhEMKYi6ocCTPiZ6xHKLvhxYLjeRnABX5dgCdQ=;
        b=J59BDrvvzTaqH8xPND8imM6khGgpaRN/GEVGsQByGEUY+naQAUSCG4NEttbMZLhTVb
         epgz2EfCX7FLFugIHW6JxgrRK3E8gMwj9t8d/Qaot7Kots8Vxa9/29ACmCWLsHehXwum
         LIxyb6HnRNw68K7nJA7IDNhtGrNTgOujocN8AsgD7F0ZqAaDA7LZwc3PbUCCKfFAF1vx
         VS08SGasOMdIjJt66QW0KI/15diPQUPpCSmAFL3qwMJiZ/xswoJl/2DmBAGOyXDUFhCX
         alS92uhxb1yaNoCT+dfVl0Q4sU9boYN7/1rEKXllXuavb35Y4klWNneH3Ndw2LOsYfao
         9Vqw==
X-Forwarded-Encrypted: i=1; AJvYcCUhJN5v0uqGaOkFtm9iv/qyAfdGhpUbJ4W5yrAnGL/2GSMvPNRX3+6lQSVz67pQzn1cR17xda4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5SDkLrZZLgUJD8g487F3MxHqQy/yw/IabjOi9gG7n+rE0fqYa
	uUZ2a6xwdY8imE/mIBZKPl2R+3X+/N7ftxp8iIID6xoIX5hNGj8l2WxCX0QHMtvVVs7fHBJ2iiK
	+4l0Bi08fJCCtMdczIX8gkEPtrbBtBdMb1WF071JTOWUxo4zK9fczzyolhg==
X-Gm-Gg: AZuq6aJCl7D1UPU3ARjQgStch7zjRbG3CY7p+QoBB8NqokCjwinQ3YtTxSEMmOoTXFl
	WVD5ht2KREUc2NHmFpI+GTmeXOp1cA79r8dloLBckxy4YtY7qJjSb+PAaqS4kYRMu1HKaKW647n
	XfB00cets7yHpf42yMmINN5wrxBKqdpjdf8wQP4dFlyiXqY1Y6IrI4tKpzlGdyQsO+316IIWllu
	/3N7CqtNOth22DXOZDAxYd4gR3mYGMDm+67oCR9Bfs521PSe1tQmK8raMUV20AOtFfQTs8FwQfs
	xkcUDnYzz7nHnsMWzx0Zxwbcc9owY6vOPPcQYeQTW51zepDtMCRbzL2SJD+NLiztp73HZ/QxTk8
	YAZjpfvMGhhvvil65PINZcBSYQQ==
X-Received: by 2002:a05:600c:8b6d:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-48379c31ca1mr174280575e9.33.1771316549290;
        Tue, 17 Feb 2026 00:22:29 -0800 (PST)
X-Received: by 2002:a05:600c:8b6d:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-48379c31ca1mr174280285e9.33.1771316548782;
        Tue, 17 Feb 2026 00:22:28 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a409a5sm100104465e9.26.2026.02.17.00.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 00:22:28 -0800 (PST)
Message-ID: <173190b1-aed6-4366-bb7d-c6ea64d26899@redhat.com>
Date: Tue, 17 Feb 2026 09:22:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phylink: guard link replay helpers against
 NULL phylink instance
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260205192344.21797-1-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260205192344.21797-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258979-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: E1896149E56
X-Rspamd-Action: no action

On 2/5/26 8:23 PM, Vladimir Oltean wrote:
> There is a crash when unbinding the sja1105 driver under special
> circumstances:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> Call trace:
> phylink_run_resolve_and_disable+0x10/0x90
> sja1105_static_config_reload+0xc0/0x410
> sja1105_vlan_filtering+0x100/0x140
> dsa_port_vlan_filtering+0x13c/0x368
> dsa_port_reset_vlan_filtering.isra.0+0xe8/0x198
> dsa_port_bridge_leave+0x130/0x248
> dsa_user_changeupper.part.0+0x74/0x158
> dsa_user_netdevice_event+0x50c/0xa50
> notifier_call_chain+0x78/0x148
> raw_notifier_call_chain+0x20/0x38
> call_netdevice_notifiers_info+0x58/0xa8
> __netdev_upper_dev_unlink+0xac/0x220
> netdev_upper_dev_unlink+0x38/0x70
> del_nbp+0x1a4/0x320
> br_del_if+0x3c/0xd8
> br_device_event+0xf8/0x2d8
> notifier_call_chain+0x78/0x148
> raw_notifier_call_chain+0x20/0x38
> call_netdevice_notifiers_info+0x58/0xa8
> unregister_netdevice_many_notify+0x314/0x848
> unregister_netdevice_queue+0xe8/0xf8
> dsa_user_destroy+0x50/0xa8
> dsa_port_teardown+0x80/0x98
> dsa_switch_teardown_ports+0x4c/0xb8
> dsa_switch_deinit+0x94/0xb8
> dsa_switch_put_tree+0x2c/0xc0
> dsa_unregister_switch+0x38/0x60
> sja1105_remove+0x24/0x40
> spi_remove+0x38/0x60
> device_remove+0x54/0x90
> device_release_driver_internal+0x1d4/0x230
> device_driver_detach+0x20/0x38
> unbind_store+0xbc/0xc8
> ---[ end trace 0000000000000000 ]---
> 
> which requires an explanation.
> 
> When a port offloads a bridge, the switch must be reset to change
> the VLAN awareness state (the SJA1105_VLAN_FILTERING reason for
> sja1105_static_config_reload()). When the port leaves a VLAN-aware
> bridge, it must also be reset for the same reason: it is returning
> to operation as a VLAN-unaware standalone port.
> 
> sja1105_static_config_reload() triggers the phylink link replay helpers.
> 
> Because sja1105 is a switch, it has multiple user ports. During unbind,
> ports are torn down one by one in dsa_switch_teardown_ports() ->
> dsa_port_teardown() -> dsa_user_destroy().
> 
> The crash happens when the numerically first user port is not part of
> the VLAN-aware bridge, but any other user port is.
> 
> Tearing down the first user port causes phylink_destroy() to be called
> on dp->pl, and this pointer to be set to NULL. Then, when the second
> user port is torn down, this was offloading a VLAN-aware bridge port, so
> indirectly it will trigger sja1105_static_config_reload().
> 
> The latter function iterates using dsa_switch_for_each_available_port(),
> and unconditionally dereferences dp->pl, including for the
> aforementioned torn down previous port, and passes that to phylink.
> This is where the NULL pointer is coming from.
> 
> There are multiple levels at which this could be avoided:
> - add an "if (dp->pl)" in sja1105_static_config_reload()
> - make the phylink replay helpers NULL-tolerant
> - mark ports as DSA_PORT_TYPE_UNUSED after dsa_port_phylink_destroy()
>   has run, such that subsequent dsa_switch_for_each_available_port()
>   iterations skip them
> - disconnect the entire switch at once from switchdev and
>   NETDEV_CHANGEUPPER events while unbinding, not just port by port,
>   likely using a "ds->unbinding = true" mechanism or similar
> 
> however options 3 and 4 are quite heavy and might have side effects,
> option 1 is very unassuming and option 2 seems a more elegant variant
> of 1, given the fact that sja1105 is the only user of these phylink
> replay helpers. It allows to keep the driver simple and is the option
> I went with.
> 
> Functionally speaking, transforming the replay helpers into no-ops for
> ports without a phylink instance is fine, because that only happens
> during driver removal (an operation which cannot be cancelled). The
> ports are not required to work.
> 
> Fixes: 0b2edc531e0b ("net: dsa: sja1105: let phylink help with the replay of link callbacks")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

I think this patch could land on current net, but it would be nice an
ack from phylib SMEs.

Thanks,

Paolo


