Return-Path: <netdev+bounces-282311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGVxBwnK8Wn+kQEAu9opvQ
	(envelope-from <netdev+bounces-282311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:06:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BDE49189F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7EA53004626
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED43BA254;
	Wed, 29 Apr 2026 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ilTfElJi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319C3A9015
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453451; cv=none; b=Ow119d43iC3lWMVXi6dAbjMaVCVrmdnL/PrBQAtIaOuBU6Llmp5S6uKxDeSrqC5ZWrhKiqwBgAYaEGDLT61V9jP+TJRpERoizAPChRC6axTCFfWV3jqQpNpKRC1BuelI7ccmgasNC5zsswJqcP0u3BVEmqFR4k7r1RKAJYNCWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453451; c=relaxed/simple;
	bh=LJ5MyJOBQxjnHJBZCuWhdVRGlvLTXvOSKs7GWnM7aFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAriIWrubw3ROD4SvZ3Ut0gzkYBUOh+FFAkHrJzifCq+tNmx2eUjdBDHuYbTNBa9mNjZ91Im8G4xK6XJBjbiYJxvprXKSGW4lf8Yiz6eYFyyFIYiLIPZN6O5FreX/Xv3fVDRsCiDFxQVpzULQxOui6buQji5eQMWNaQPR+7rPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ilTfElJi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso107389735e9.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777453448; x=1778058248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmuOh+kGeDXrP0yx3685UynvWNqrsYu6pdmhoYjK2d0=;
        b=ilTfElJiZmcFR+UvtFpCKcqi3PdXHVPyV0fva+3Sna0e9uYdr7hyN92Fgk0O+qxG3p
         CpXN2U5n/NczFzcKlXCRz2qBT4TeVMOcXR0CrQtQm/IN+r9KScd4ODZWvGoUrBBsqqrM
         p9bOQhYfNrYwQKf9i+XjVOkivL4nbqGp27DrBFLg2jyubBou3t4+d2/EkGtvuLZqPSMh
         4/choMJ3UQUC5A6htKXtSh+v4mIPc2yX+SHaa4BJJMGYs4YdNzkWj93x+4hjRHw/sVpV
         w0soxLJQpHcQn+tnp9tpok1Fr9sirYOo3Ut6smGcccEB01trqG9p2K5cIAGXmJVRMfch
         kwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777453448; x=1778058248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmuOh+kGeDXrP0yx3685UynvWNqrsYu6pdmhoYjK2d0=;
        b=iUrnPjkD/HvcxloC4dSWpmT9CjkZLQ9UKxvmuwMTbHBmbtO2dscjd7shnl5OaNXKeW
         EMzmz0tznGLv4EpCNoAJx+steFbMKJe8YUcTT1458EBX+yYApblW3to28gYqsP4d+Eis
         Qildk/ywgKAMcxSC2N5Tyg9atKvXronecPRVhHKlkJ94VcQN3nffT30Kr5wF1SfboQ4J
         IeFhgDFMao6r3A5k6cDt8grs/m1LehqXzq8B9M6eET2I9zPfFU7N00/QB5TEZ/mKaL3E
         IE1hjBr0I2c5/tHK7fy3dnGTWPYjhvRTvhu8IfczT3W9rMAo2bUlKJtRt4MkbQby6WpL
         hSKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/A2r2FE7qrKmQZJ8ZpPkr0jt8tonRLQxw7F0CcXSvYhIdquCPd1c4wnp+9nh9xC3YLxG7WenU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQUukwSxjfTr7/lVM0Jt9wT1/XYRoPyHafy+Gun/s4biLqd09
	3LC19eAgY2OCdcTO37Ie6AKKVcvQzy9Le2lHQyhaIXWcB1gHRXWHtbZ3POlbCKyaBEM=
X-Gm-Gg: AeBDietfAqxQZXc1pE6VNspn7rCyHf3J/WJPnUonHQUDXgE1CXNkERLTvch/w3Qdpth
	KF7GXwanJpbaoeb1p8BpsayuDxl++j92VCakSC4MHm4aIyThYi/gb3GUzkA1uIAr4WunSh6813F
	NE1DVuRwVOhJId847ChR1s5S9Per5LH7E5Io/OFPd/+TagVD3vnQLHCxKmTwVhlsN319Jkek6Xy
	o4q/Qhyk5Lj9eZx+y1PmUozHfPfaos9JhwlHsnuY1A4qiCjXWXOrXqvfSahA7PZ9KzeDM/YjyTr
	XaDcXQtR2KW6sCHCqfdK+I/8YjAxfMCbSfd7w214mk6a/FCi+z8+f8Tq6w2++TCiEIB551yQkvG
	gJG4hCmPmfRb1MLqSUXGfcNsaRbjilh9Xx0lqxcCARCEzOTO62ZFQvOi7Ef47TCKVUvxbxfEsci
	2HsulRtXE6ZKH8Lxmo3pft3zjZof9PL55ZE7Ls+GmlsOyLmRnlxLqjXiUvcCVMftdK
X-Received: by 2002:a05:600c:3505:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-48a77b12983mr102721605e9.19.1777453448112;
        Wed, 29 Apr 2026 02:04:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c30f856sm13683255e9.21.2026.04.29.02.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:04:07 -0700 (PDT)
Message-ID: <f30f3eae-ef39-4b95-b39a-b68aaad608d2@blackwall.org>
Date: Wed, 29 Apr 2026 12:04:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] bridge: Do not suppress ARP probes and DAD
 NS unconditionally
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260429062405.1386417-1-danieller@nvidia.com>
 <20260429062405.1386417-2-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260429062405.1386417-2-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 65BDE49189F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-282311-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid]

On 29/04/2026 09:24, Danielle Ratson wrote:
> When neighbor suppression is enabled on a VXLAN port, the bridge is
> expected to reply to ARP/NS messages on behalf of remote hosts when both
> FDB and neighbor entries exist. This allows the bridge to suppress
> flooding of these messages to the VXLAN overlay.
> 
> According to RFC 9161 ("Operational Aspects of Proxy ARP/ND in Ethernet
> Virtual Private Networks"):
> "A PE SHOULD reply to broadcast/multicast address resolution messages,
> i.e., ARP Requests, ARP probes, NS messages, as well as DAD NS messages.
> An ARP probe is an ARP Request constructed with an all-zero sender IP
> address that may be used by hosts for IPv4 Address Conflict Detection as
> specified in [RFC5227]".
> 
> However, the current implementation unconditionally suppresses ARP probes
> and DAD Neighbor Solicitations, which breaks Duplicate Address Detection
> (DAD) over EVPN.
> 
> For DAD to work correctly over the VXLAN fabric:
> - When the bridge does not know the answer:
>    flood the probe/DAD packet to allow remote VTEPs to respond.
> - When the bridge knows the answer:
>    reply to indicate the address is in use.
> 
> Fix by adjusting the early suppression checks to exclude ARP probes and
> DAD NS from unconditional suppression.
> 
> When replying to a DAD NS, br_nd_send() is adjusted to set the NA
> destination to the all-nodes multicast address (ff02::1) and clear the
> Solicited flag, in accordance with RFC 4861 section 7.2.4.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


