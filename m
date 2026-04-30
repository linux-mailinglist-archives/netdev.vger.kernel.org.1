Return-Path: <netdev+bounces-282924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C3xKgt582mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:45:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C8F4A50CF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33E1F30312CB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6143901B;
	Thu, 30 Apr 2026 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="kIVovgty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D9438FFA
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563900; cv=none; b=ht5SwvyuJ9b5zctYZHSy+a9vPyejbAEPzbQqaMW3BHs+2HwBFjpH9qPdaP2uK9SnYiBKTI/QlWBWiaVNhqmlALlnwtS+B3dTXFE5rTpEELughCDfT5PBjbuBcOPNgIEQp2JvH5K+ur5sNY/1aSXoRz1pS9YbVtrDPVo9rhA1Yno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563900; c=relaxed/simple;
	bh=RUE0wRnDSulogZaSv/Phdq6tG4EVlY/e2/sK/FRA2lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+5ko7KOjT7X2k7b7BmMnAefHsnqfUVVTNVvJRCqh9A8Mh5x/VWhZU/B4I4e9HJ2CG1ID5OHBls68IGNNG5oKNge3Gzs50EcQu9Nl0y4OTm/0a/v4EBp86TjS+0Tc+BmXuN797u1Wrd7sFEk5KzdwiQLcbXvVqCbRf/IE1u59v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=kIVovgty; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7828221bso53082f8f.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1777563895; x=1778168695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nVdkXGvjipVBSYbCT/dFGYanP9qbDtxjNRTDheTpI08=;
        b=kIVovgty868XFtEfPeoHV5DB5ZZXqPyEvjft08k376aiPD3ETBi0iiahiRcDAmGjQE
         07nsaK+WoWWxpfYJgOUZ2BPC+VlYMk3DLAyrfqeVAqFVWbAKcFadIEDqNTjq8iAO3kl7
         6Wb/uKRGSvGzwnTigQRGQ69RO3oeJavhGaTN/wSrW0ic7t8Dd+W+cqVM28+KDqtOTMez
         Qj1r39hVVgI1wqPz3Gc4a8Ldq8zkUcsx+6fcfg2nZSC0vTWli3r2tD3amDLZ/pUVEczp
         /qD/5BLRwNAV/dYiec+0oWCNVfnXmGSMQ7V6tM1yIF7mjvBfFWnbJI3MzZ5/AjC4Mp2G
         duuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563895; x=1778168695;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVdkXGvjipVBSYbCT/dFGYanP9qbDtxjNRTDheTpI08=;
        b=lm3yQNQf9+Qmfi6a4RDX+2PW5IluJ9mwnc3d+HL+dquKIMumaN85yn2o+DELuIqzwc
         msEK5d+TXId5lIOXqZwTtwd1JHZQGdt4qNFfX3AA+ijgOD2tDBU9go8SOGOYwpN3Auet
         XfYkDtTmoOOBbB5dJrgnl/kkTpWitjQGIua5/CZVGvGUFmz0+OxH/Xack6GrtJzJKJ7S
         EQDModbPd9cetXpxDQs3FQEoLd4IlwIp9aSdg6oIWbS3D3ogC6VWsxbek/wX3jjVlcUc
         6wzZ5xcJ04VxRHgBK7096P2d/2/87EwicbnluYN0+5NdIcAgCDj+yv8t/gWkqWxIFz0L
         ZEVA==
X-Forwarded-Encrypted: i=1; AFNElJ+xwTDT1uT9j1aVcVVpvWJJeKXPVhdc66m9kJ4RavCVmFglc+vaIAElDTVFV8cS0XJz5cXuWDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXoLed3x13D3xqXRco65B7EK9CNWkDz/1kH8/oCXZxLOWfTznU
	5oZuTGOFED7jFQbXa+FhAfwEzpVzzALP9XVgO3AodPIP9UnpSEURK8q34bcqY+wE+Bc=
X-Gm-Gg: AeBDieuKv7FF9GHFzIvyxFCVS8r2VvO24OxLTzeWcND0QnNoeGwXaeg205IrUkTkx0H
	V5tAYeJNd33SRgu0k1K710nUOsmSp5iGaATZs2rvcd78ys4rICoc+wOfBfpFrzz6YB8o1qWUsw1
	Qa4xjLTfkALYIjmabWbcSjjHS0y+vRMBhlrRt3xv5wkJ1sCGOS6q4iTWbPzJyjDrl/g/P9rsRt6
	zw1Fi7wR+WOyBp9mSNCxDF0w9UmXdmhFQ+ilPxL9ml66ApmUFqvTXAIbJ1XkHVAR60wGQJKTWht
	Y0YtA/yDuWvXBRdHwDxjk2erfCqYARV4sjakgqvBMUY6hsjjqYE5EVZT+tHS/nJWsmXxMXEyplg
	7TMVCpja8DzEZdCyTSR+bzqvzuZXcYPdnBJxw+grrpu0br2CXn54VYGNxksYRTF+mTavWap/o8i
	FaRgzvJcneslRq5AbVch0TQAXtsIUrb1GIzQdK2OS6BfJIhWqVzGEvdawWbrjo9z89RhKisFZRl
	iCFfG48VzAlNFc=
X-Received: by 2002:a05:6000:2995:20b0:43d:1d3a:b60a with SMTP id ffacd0b85a97d-449403aa04bmr1985624f8f.7.1777563894613;
        Thu, 30 Apr 2026 08:44:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-449c576d0a2sm3615047f8f.31.2026.04.30.08.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:44:54 -0700 (PDT)
Message-ID: <3f8d63a3-e39e-48f9-a0d0-517be7c05498@6wind.com>
Date: Thu, 30 Apr 2026 17:44:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC PATCH net-next 0/3] netns: optionally inherit IPv4 TCP
 sysctls from old net
To: nmreadelf <kong414@outlook.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 dsahern@kernel.org
Cc: horms@kernel.org, chia-yu.chang@nokia-bell-labs.com, idosch@nvidia.com,
 ij@kernel.org, brauner@kernel.org, jack@suse.cz, kuniyu@google.com,
 jlayton@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, lance.yang@linux.dev, leon.hwang@linux.dev
References: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <TY7PR01MB172057C053E8D550485A29A08E0352@TY7PR01MB17205.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 67C8F4A50CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-282924-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,davemloft.net,google.com,kernel.org,redhat.com,lwn.net];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Le 30/04/2026 à 03:30, nmreadelf a écrit :
> a new network namespace starts with built-in TCP defaults.
> In container-heavy setups, operators often tune TCP sysctls in init_net and then
> need to re-apply the same values for each new netns.
> 
> This series adds an opt-in mechanism to initialize per-netns IPv4 TCP sysctl
> settings from init_net at netns creation time.
> 
> Behavior:
> 
> Default is unchanged.
> When net.ipv4.netns_inherit_tcp_sysctls=1, new netns inherit
> TCP sysctl from old_net.

There is the same kind of sysctl for net.{ipv4,ipv6}.conf.{all,default}.*:
net.core.devconf_inherit_init_net.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/sysctl/net.rst#n401

I'm not sure if it's acceptable to use this existing entry to control the TCP
sysctl.
At least, putting the new one in the same place + using the same template for
the name + the same values would be nice. Something like
net.core.tcp_inherit_init_net.

Regards,
Nicolas

