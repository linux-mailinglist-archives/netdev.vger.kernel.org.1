Return-Path: <netdev+bounces-257115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKJsLNJ3hGkX3AMAu9opvQ
	(envelope-from <netdev+bounces-257115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:58:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B12F18E5
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D37A304AD9F
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42863A9D82;
	Thu,  5 Feb 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJRky7lm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eU3B/b4B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A683A9628
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288864; cv=none; b=W2qp2Kmg8xkSTe9rxajMRUw1Put1QOMKZy/vH+RnFWoHYn+Yz1q7rXlvRq3uNecTf0HarWNdrqr0S13eOFw+d0UZvU0ZbRerkPqznIREOvD/0a0f2JIA4HntTRS7E7ij9nruJDoZ71aNQ2Ab2BMsAgP4BYDkdOGkRaC+W7V3ccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288864; c=relaxed/simple;
	bh=k+pTK1Q/uGh4cj7VMlNWwrmjpCjS8qk/jUC6mnPt9wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzE0gBcNFtVbdKNU2FSMS3xjO/x1mbdCZybF2n0W3IR8ZHYXdPWAzCHhYHSHtOSpQ2M1xtk2twcm12opiCpuul1SMGn+0jE76JPAYbIqt0c9F9d+fsYqJTH+QMzM5EOyNbK+ox9XEms3pxkR01Jl3wjii751Vvf2oT0+uZVG6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJRky7lm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eU3B/b4B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770288863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2GhoRMtY21T7Hae8QgeRuxP2YQ8+rtPygT7RO80dys=;
	b=WJRky7lm3yHrcG0tc8XzbkasUenzdJK8tGrtYkV/DTNpOg9375K+wP6oePP3jBgIFgwkBx
	+qNXpP7VNFO/AlebGv6f7uUepMWIP+sntPbn6E+QVyOKkuUyuNeEiHSW35Tr4/trdfel0B
	ZznxU9QGm37LvQLCurrTj05SBN6WYag=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-t9unS8wgOf6atq4tkUBtcg-1; Thu, 05 Feb 2026 05:54:22 -0500
X-MC-Unique: t9unS8wgOf6atq4tkUBtcg-1
X-Mimecast-MFC-AGG-ID: t9unS8wgOf6atq4tkUBtcg_1770288861
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-480717a8ef9so7839385e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 02:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770288861; x=1770893661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2GhoRMtY21T7Hae8QgeRuxP2YQ8+rtPygT7RO80dys=;
        b=eU3B/b4B42IUxOLl8dOAQ/ViCcWHSnApjkoND1PEYIv/GIzB1Nnu5Cyx4l/iFbTKlg
         LRm2fJVkkLdNDel2RGWSAlKBW29b1a+9wToQ+ovgVEPa/aEQmAAvBqxOrJa9VLxoWp+i
         B0YRapXK4vnyqMcNYlV+xIJnP67Bo6JxzoiH3aAnNTE9/vQ05pmIhsKuW5aiCLBAerrU
         sgeNqOQ8+eQm/K1yL9s6PqBu/rd1tGvLzQIgRFJsD/eKw49mCgUyYZMN0gMaoks1wIH9
         Aoel0I7/FHhn+xDEE22+pqD8cOQw14wSzOmQRJDEtHTOT3prQLVNmTqgtniDkGJmIkXI
         XK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288861; x=1770893661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2GhoRMtY21T7Hae8QgeRuxP2YQ8+rtPygT7RO80dys=;
        b=iSos/Dp4NatnxCo57BcMyhRzQ0B/dKAyZOrtYYQH3hQNENT31WGdDKeNQbtjNfHWCY
         SEMqiiW6/HpLvyitfNyQsXLBSgWeiMJVT2cNW9PA1AnI/czqNAH3Qp4cMNTde6cOg/Z0
         yDsy0X0pzK42W67AgoGnxct6Go/JnwvA306yQpD2RDGbv1NEJ3inDTBICbR3zw9H84Ww
         pNF/eU4dJ6g6Q2WVpCs/wMGh3LCIHhLriNQfoPoD9VK29y3wCD8CSdtt89ZPgVfLGO9w
         hxeeXcJMsJbdoGuflNRM0VqhccJWM/vZANFmMFHkdUPQ7Aphtd2xOgM5mHJ0zqr0B/+P
         GrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDJvNvy7uQMaeXCwOvd05jKXNhZsR952+Vk4uv4bzSKEv7pL61kiJFFYll9Q+8kK7jGieeiiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqjK2EZJk61JXuzq7Ka2lVL7prZaNmWiTd9fESAXw/TpjdBKT
	ZPeNu4NwbBY0Ug++XQS2pm7B0L9y88pbtTg5maj8XiGBYkdTT2E6z9xn/Ix/HNTJoz3xWo0zb14
	x/N1PC4xYO1hfGKkgDlKw6eC/tqxu5QyVhTFD+YLZ0C2TnaEaSpD8HhSLqg==
X-Gm-Gg: AZuq6aJSBru4FLCJJlB88s9BtTSkTFCI1DOy55fRgCSMIhGMUMfZ0SgFMtkN4MmWvyS
	3zRAcwk9Tqpoyv7CECWOxlC8B8gxxGbMxDwLQTmuX1l0FQ3jG4izltZ4Ij8/z6cKxjdgH2oLwJB
	38t/iOdoK7kDjXBr2kW1ekhyBC2dIa4inOK7Hhyrgttt03EtHw9fkRaOXP91aZg/K1h83TJuTnp
	vuoSeLMX28LDosuj/hVbitDMUCc9QD/ULslRu3wBG8SW64oFfidf40nMWRlfYo55TZvi653dTrG
	5meG4dyUz74U+02/wUDtnxx/AGQiXMt5Kbc0AXwXNjhFKSXGAmSi8UsSID9imuvGblmt16dOWxh
	Sy6yCV3m6BzsO
X-Received: by 2002:a05:600c:3041:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-483178ebf68mr21654045e9.8.1770288861095;
        Thu, 05 Feb 2026 02:54:21 -0800 (PST)
X-Received: by 2002:a05:600c:3041:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-483178ebf68mr21653855e9.8.1770288860697;
        Thu, 05 Feb 2026 02:54:20 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831d0b5b31sm21336375e9.4.2026.02.05.02.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 02:54:20 -0800 (PST)
Message-ID: <c880cc98-7246-4a27-96ca-9c1b9cab9596@redhat.com>
Date: Thu, 5 Feb 2026 11:54:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/6] move CAN skb headroom content to skb
 extensions
To: Oliver Hartkopp <socketcan@hartkopp.net>, Florian Westphal
 <fw@strlen.de>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
 <7d544645-8699-409f-89c0-6fc606113627@redhat.com>
 <c5929461-8da5-4c77-bf3d-796c7645d7f9@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c5929461-8da5-4c77-bf3d-796c7645d7f9@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-257115-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10B12F18E5
X-Rspamd-Action: no action

On 2/3/26 8:19 PM, Oliver Hartkopp wrote:
> On 03.02.26 15:40, Paolo Abeni wrote:
>> On 2/1/26 3:33 PM, Oliver Hartkopp via B4 Relay wrote:
>>> CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply contain
>>> CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data. Those
>>> CAN skbs do not have network/mac/transport headers nor other such
>>> references for encapsulated protocols like ethernet/IP protocols.
>>>
>>> To store data for CAN specific use-cases all CAN bus related skbuffs are
>>> created with a 16 byte private skb headroom (struct can_skb_priv). Using
>>> the skb headroom and accessing skb->head for this private data led to
>>> several problems in the past likely due to "The struct can_skb_priv
>>> business is highly unconventional for the networking stack." [1]
>>>
>>> This patch set aims to remove the unconventional skb headroom usage for CAN
>>> bus related skbuffs and use the common skb extensions instead.
>>>
>>> [1] https://lore.kernel.org/linux-can/20260104074222.29e660ac@kernel.org/
>>
>> Could you please share how skb_ext size change with this series?
>> (possibly breaking down the actual size to each separate extension).
>>
>> Ideally/hopefully the  skbuff_ext_cache size is not going to change, and
>> that would ensure that this change will not cause any indirect regressions.
>>
>> /P
> 
> I'm not really sure what your question is about and how I could actively 
> change the impact of this series.
> 
> When CONFIG_CAN is enabled the skbuff_ext_cache element would increase 
> in size by 8 bytes (sizeof(struct can_skb_ext)) on my machine (see 
> pahole output below).
> 
> So when everything is enabled it would be
> 
> CONFIG_SKB_EXTENSIONS
> 8  bytes sizeof(struct skb_ext)
> CONFIG_BRIDGE_NETFILTER
> 32 bytes sizeof(struct nf_bridge_info)
> CONFIG_XFRM
> 88 bytes sizeof(struct sec_path)
> CONFIG_NET_TC_SKB_EXT
> 16 bytes sizeof(struct tc_skb_ext)
> CONFIG_MPTCP
> 32 bytes sizeof(struct mptcp_ext)
> CONFIG_MCTP_FLOWS
> 8  bytes sizeof(struct mctp_flow)
> CONFIG_INET_PSP
> 8  bytes sizeof(struct psp_skb_ext)
> CONFIG_CAN
> 8  bytes sizeof(struct can_skb_ext)
> ---------
> 200 bytes total skbuff_ext_cache element size
> (255 * 8 = 2040 bytes max space for skb extension users).
> 
> Does this answer your question?

Yes, thank you for the collaboration!

I think there is mistake above: sizeof(struct skb_ext) should be 16 when
more than 3 skb extensions are enabled.

that means that the total extension size already exceeds the 3
cachelines (192 bytes) boundary when all extensions are enabled and
adding the CAN one should not cause any regressions is such scenario.

Note that the "all skb extensions enabled" is possibly/likely NOT the
most common/relevant one, but I think there is some space we can squeeze
elsewhere if needed.

TL:DR; LGTM!

Thanks,

Paolo


