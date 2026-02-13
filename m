Return-Path: <netdev+bounces-258589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJqcMuz0jmnDGAEAu9opvQ
	(envelope-from <netdev+bounces-258589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:54:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E58134BB4
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD345300CCB8
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC3A34F24A;
	Fri, 13 Feb 2026 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gVxRVyVB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D32DF146
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976485; cv=none; b=JerLjGt8tTejvucWjhm8ivoZg2PKRypVobrBF3OiXahkAz21757iP1alNwewZaaqYTPb7WC2UjjPcKMZ1Ms48WPOSHdd2H6wtjiAh35U/tMLzbrLa0iyuRXQmWFf7knzBYCVl1enk6+W5Qp9p0jL9TvNl7vXGAfBy9YNoSWR1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976485; c=relaxed/simple;
	bh=vHFx/hSJywUMMLlBtwaeUgAP6h6QwaSX1+ADj/wpOLE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S65eQnJk4vBIv+Im8CNTv1RPz/u/QfpSEVCcYXaiRhFpx9cqWpJLTF6PqBdmUV1fOR1hSmBksGkdSC/B7p6KBvB+wNnqNyRARcFVpHtYtd+2ADQLF/PsLu08CQ7DP+j2EzZTSNDvd4cNJS8I3upx3DFQ61D51B3RoeSjRXuZ500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gVxRVyVB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4377174e1ebso507392f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 01:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770976483; x=1771581283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G1I8HNjaFi6YM8hvH2Jx/PnxV6b2wStAcZKbfqk/0E=;
        b=gVxRVyVB1cb3ZLSsrptmpkO6NOCddF7inPGWbEOjvE2pADlyE6qosli5ocugRfZers
         9MfdUHF+sv4J6gfy1kzu/qUjCTn6TeiUFBdPsSgTOfLII7DHNfIYtlcRbDsyfYlnuhuU
         I74kcQeReJ3/IB9U3Qn48XVE/EnmrUKwJ+uqwdhdhbKEIf4D0/fygzF3elDcI56A1FV6
         Pd0rUaKEq/xdKRO6C4EfDPO0lgJRBXy1pevv486nSIuHal9h2WH9VH9sSI2UJgWHqxrs
         8yAF9ZrBDxt1z30xYxAa1I7sbLLVRinmK4Z1P8aqWFn4RlkyEQmhOPoz/BAlS/mXKq++
         IsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770976483; x=1771581283;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G1I8HNjaFi6YM8hvH2Jx/PnxV6b2wStAcZKbfqk/0E=;
        b=L53eNwUYoQpQT7PzJw4HBcRdpOQwP72JSdXaqmFO50mBNYQADY+phfQLrX/Z/VP+uJ
         RX76+tsMyzjYeHnXS6g7xzCl8Rujlfi3oZJaM9diYpuMOKky/0OcMK0mVz0V0F0oIlx3
         KCP0aEbMmanodX+OWniK4CINg1wGdxUe75vbT/wlVkxSxtttW1+VkMkVD8NKvOn8mWcs
         y+1ocYNMBvH1p2byq0gw81QrwGfVzd7BaXacl/WJzKpo0AbC0qf3ptA5KY2eP2Psdb7Q
         hOXsY6+KR0qx9mV+lcazkMPVDHb3hhwLum2SzzW2ILgTZAAEv+9nXSWKN8FLuSEyx9BA
         52Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUS/9C6txltoLKHeRCD0hw4U9UhkU8REnpOhh4OGz+OXnOPxVoj8SL7IZD/NOp4hES+IsX3b3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjovfmIPEwr2kXQbJDDC28KhmkqW/x0g3sJ5FtdAOi6kXZmaiP
	rHEh7efmN1/oDL0RTl/M0L0LnlGQcxcpPx94gYzf0yAXNbU1FjZ/bMs6Q849H0vEIGJXUMCjGvH
	bdMWPRAg5FLKSe2s5pvnXntxswl0X7gfPRhkz8ZOYpR8J5kSgjo0=
X-Gm-Gg: AZuq6aJLpTXyxkS6Uf9GUwVDn2yUjZRWVU4GAU7ubjJaTvnh5ZPVRuih16S2SPs52zh
	+W2DjRt6Ob+7ZSRbgpYKSAsxDwEhd3Bi2bqe1LceFScGQyB8xjZ+dq/HFyVtV7NHBVi0JkRkRot
	g4Kw/N1Cm2MoUfN9iJyuyPYB95vFLl6+EmyAeN8ip+r8wIsknZbXduQghG3DkILWPDtsneVMtC7
	vWlV9Zd6PVZUuTCwKXCww5zRFRcf2ggKIAmpsagpEeWP+Og7aF/ZyeC+IWqlRdcDdc9J0D3hDWG
	OWXt++9wQFEKUN5tufhHGSBrs0X5tZLIIgki2W8L7W7URSNPyYC/y8ydkHdEXD2KLj48ERzYmSY
	5KgyXISzN037OJnKUEdx5ck+MNqwCm6fJ+4q5RKN/RRGy77JfjsrVcfMrnM3ORAP8ZFz0/4/nSL
	GNvctCkDJEhkSF5g5ynB/YQSfA66RTsWeopayLcUQnxtitCWoUKlmdv5Al
X-Received: by 2002:a05:6000:1a8e:b0:435:a0f5:c271 with SMTP id ffacd0b85a97d-4379790ee4cmr2241965f8f.31.1770976482633;
        Fri, 13 Feb 2026 01:54:42 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:686c:823d:23c:28d? ([2001:67c:2fbc:1:686c:823d:23c:28d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abcda5sm4886336f8f.19.2026.02.13.01.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 01:54:42 -0800 (PST)
Message-ID: <ccd00053-60e6-42f1-a966-73e54805ade5@openvpn.net>
Date: Fri, 13 Feb 2026 10:54:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1126499: linux-image-6.17.13+deb14-amd64: ovpn NULL pointer
 dereference and lockup under heavy load
From: Antonio Quartulli <antonio@openvpn.net>
To: Salvatore Bonaccorso <carnil@debian.org>,
 Jon Penn <jpenn@bentonvillek12.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, 1126499@bugs.debian.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Lici <ralf@mandelbit.com>
References: <4be2e796-77ba-4864-a288-e6edf3b7de12@bentonvillek12.org>
 <176996279620.3109699.15382994681575380467@eldamar.lan>
 <be2d036e-42eb-4d3a-be1d-60c49801b884@openvpn.net>
 <aYYwvGbStTFvof4E@eldamar.lan>
 <9d240ea8-7e55-4be2-b99b-3f2657c5f8c8@openvpn.net>
 <aY43tezcIO5DDE2B@eldamar.lan>
 <bfae563e-d2c0-41a1-b967-e9ac2c940d21@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <bfae563e-d2c0-41a1-b967-e9ac2c940d21@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openvpn.net:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-258589-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 47E58134BB4
X-Rspamd-Action: no action

On 12/02/2026 21:38, Antonio Quartulli wrote:
> Will report it here as soon as it's submitted.

https://patchwork.kernel.org/project/netdevbpf/patch/20260212213130.11497-1-antonio@openvpn.net/

Feel free to reply with a Tested-by.
Thanks.


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


