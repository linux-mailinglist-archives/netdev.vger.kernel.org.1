Return-Path: <netdev+bounces-295097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DZFQCCs4IWoqBQEAu9opvQ
	(envelope-from <netdev+bounces-295097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:32:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1D63E03F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:32:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZGZOOc+M;
	dkim=pass header.d=redhat.com header.s=google header.b=aV+QRnNi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295097-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295097-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52E13091F31
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEE93E0088;
	Thu,  4 Jun 2026 08:24:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61E30F54B
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:24:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561459; cv=none; b=D91NDXKV/3AkBRHLP5NPiSN/kG6W/ZI7NA4z42xKOYcf+GttjE71rcNz3M8lSZ3ikx2lUQ/zzPrRnVJ/rPO3DwhEwQuJHyybwKDWuWwjDIqd/1R+ZXYHsXm6FAEYTHvPkwbXJA9l1m/9SjYU54QI8TShUIKF82bFJvw2Dlw3OCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561459; c=relaxed/simple;
	bh=P0ptasRrHsOq1GbyRRWE4UK1KFj1lLae8zDQDtaOHxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEBnIQI/sTXHWv/HkLPNjly4rUVBdxFoGxh0PGNG6eYNS0pcEn0hNG2Yghb2IhdZli6r1iILQs2907HWdWZn5StPS5OMV4eSgrqnPehjk5YCAgGfju/xWvmCJccvYRku+fxvZ6HVwyem7gSxOztcax6PlYFEsXu9paVbjzdkFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGZOOc+M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aV+QRnNi; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780561456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6ANPjdusuIst0nSmuvnn+083ZoJCUj2jh5LtAj6Enc=;
	b=ZGZOOc+Mwi1jalgAdLhsS+KBIhXBqzKfXhWZ+wA9NWaRX2kVxxPoJGzsKubCO06LyNOohn
	YGQzIe6I+OEfRVdJ2IIOaLAbRVJYf8ve9zrUpqKhw5y2SI5fxfFwFVl9CP+eqeiPm344sT
	DjgulanRXrD1Bnd1XiMa5NOgzQ6nyek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-ugqqIEPFPZmcjHsZZlUyqA-1; Thu, 04 Jun 2026 04:24:15 -0400
X-MC-Unique: ugqqIEPFPZmcjHsZZlUyqA-1
X-Mimecast-MFC-AGG-ID: ugqqIEPFPZmcjHsZZlUyqA_1780561454
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efb6e60e4so361076f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780561454; x=1781166254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6ANPjdusuIst0nSmuvnn+083ZoJCUj2jh5LtAj6Enc=;
        b=aV+QRnNiiC7v+cOBVMhxKUhHRfkJR3JwrJ3vpOVfKLwnB9Qp0NfHjjsettc4/UCPTr
         AiBL2yFYthAFO9h99YznCkYEYmKWaP+ue0ztYR1Ayv9IqELSY60JF3Zh866WFf0QLQyO
         GOTMxBany8Yi6PBvKQoMUekdJNpaX5cCMvWH6G3o2Tcl0s9McsWZ5DHQXsCYtrNP/Fh/
         kb0ne4yL6r/0VNjCbuO5m6I6OL64rG8QmxXXHRjJYJ4FI2dkCmr+mDeq+VWDlrLXLdz4
         kLkOrA9IczoUvbWVE7A/dZsxfqbjbuWVOtlICO5OKCYues+pxAXBGe0A1uvu0kB37Wb8
         TLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780561454; x=1781166254;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6ANPjdusuIst0nSmuvnn+083ZoJCUj2jh5LtAj6Enc=;
        b=HnVVNFQcCrvep6lcnCUdFqRGYi+Cyy8aS6aZtlq9mM3icAohYaEpDWiIfY0LXr4c0h
         f1mB3a3to/m7V6I9bNMUYW4wPbor0IWwD8SsJ3e0tPuQheFPC1Glr8TqwVsEWblDoM5l
         SrJa143mt0J4ro9e1QAhQvpmcC8Ck4mNhyTjstVaTO95MSg6Pzmz2ZDgbjW3U/PR8jkr
         oKy35isbN29NMPLVmlcJTXwwj6pf/OovT4T2oJR5ijIfZcsbxDk3chYPquo0veNWgELM
         v0BlPUHih8lcurhnB07b+WWADC2TSSVrMLunmlzLg7pTkh8/uj+dF65QvgFfeq3KqnJh
         2Nvw==
X-Forwarded-Encrypted: i=1; AFNElJ+rHsgGpyAxH4eKZwTNHs85uDv0MdUpJZQLRoIlv87uNZCsFlQ6pZN+Xomo9swIneoC/V9UFC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzARhlgNKi/a5Jr6lUuvhGIoqA5HgrO9v76VEeG8UHaNjNMmD5K
	bOo4QjUNm5Kd10CMIOxxpt7rAgzf8u0QBg0KSVMfBEiHMV25O9+H7rthhVDBIYPJNG514ZjR8RF
	aljoQFNpSZKDAlXUCrcQNlgDKP3206kEU40rYYDM0E6X/8aHWcTzqpwYYFQ==
X-Gm-Gg: Acq92OGrgsPpyy+JYVRrIhAv78DYfUr0tVmcYrRHjvCjS7BPc5AVU9ZPnlWW3+0BcLC
	2fB9gkheQtFDvv20h89EITIPEWTS7THwnTwIy472pUsyLxyG0RFAWmM/m5RVZHiwozeJl9LM7wr
	gEOmm1sVsbSEhxnu2uguEGLiAVLTQ0C5thu8p8lzr9HuW1Afdfe4X+8+QD2EDM0Wq0aYFRGO8uI
	ZH7yZTSfTQJDB4BgBkfIWam77/1bXkcvWKOJJn7aVuQCVJVRGtxoQsKOdV/90rz3DRqygvLtANw
	vBtciEg4R2oHJ38M8f4KS/nYu1K/XI7NwmLxNCFlo0aFVUQxHSqePZA/a5I5tAQyPeH2JROuyJx
	fGe/B+p9CskmedjPyIohKv3me+wAB8/X2R0ENCOc5No4kmG+7gQ7MP+G+pPe5WhcpcDc=
X-Received: by 2002:a05:600c:3552:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-490b5e73ef3mr99664605e9.3.1780561453988;
        Thu, 04 Jun 2026 01:24:13 -0700 (PDT)
X-Received: by 2002:a05:600c:3552:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-490b5e73ef3mr99663985e9.3.1780561453504;
        Thu, 04 Jun 2026 01:24:13 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm59428225e9.10.2026.06.04.01.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:24:13 -0700 (PDT)
Message-ID: <60c82009-790e-4be9-8651-309b14a6f55d@redhat.com>
Date: Thu, 4 Jun 2026 10:24:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/5] veth: add tx_timeout watchdog as BQL
 safety net
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-4-hawk@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260527135418.1166665-4-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295097-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hawk@kernel.org,m:netdev@vger.kernel.org,m:j.koeppeler@tu-berlin.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75E1D63E03F

On 5/27/26 3:54 PM, hawk@kernel.org wrote:
> @@ -1819,6 +1836,7 @@ static void veth_setup(struct net_device *dev)
>  	dev->priv_destructor = veth_dev_free;
>  	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
>  	dev->max_mtu = ETH_MAX_MTU;
> +	dev->watchdog_timeo = msecs_to_jiffies(16000);

Since a repost is neede it could be possibly usedfull using a macro for
the above constant and expanding the math leading to the actual value.
Also possibly an additional + 1 to avoid a very unlikely false positive
on exactly the maximum possible interval timer?

/P


