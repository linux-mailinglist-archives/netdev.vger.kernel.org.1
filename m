Return-Path: <netdev+bounces-286882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAG5NY9zAmqAtAEAu9opvQ
	(envelope-from <netdev+bounces-286882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:25:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CF8517D86
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49C343023E21
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302F20299B;
	Tue, 12 May 2026 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P59+1gkp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0EB1E5207
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545549; cv=none; b=rrh2JQ9VWG0pNA0s/X+lntq6Sl8FcL+xDJhA16mvqxVagvh8azNODsYqbFZehavEXkhEfcVB5kCZmjW5bmk8nyTOakg5ygb75kuFGGWv6sxb8qt2ZMTZ+0UuEgIbByoPw+VtsIYFmzygZ7Yz1PiDwVqbBPbZz2R1QVFRd/8a+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545549; c=relaxed/simple;
	bh=b4skspkKKTQIX++fmWMFle7wB2PRvfsctqBNoBPSajs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX4hrnuNPHicjJeQ0iRvE8gFbiHp/L0srZ3fD54psabR47pDL+Gs+VLKqoJWSMWnneuRLCzSszRlHhgjDdaHLum0PBp4reScKwcLa9AhSypFGo4iA8w8heg1n0PZqPOU2gjIO0dmY/0mGufoU6PpFyqM4cAQsbuRhQJvlmLA/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P59+1gkp; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50fc496c8baso47350371cf.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778545546; x=1779150346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYweTmMqrk2Rteck6hihBJf+aeEAyEgXbVoomeow8eg=;
        b=P59+1gkpjhrxhVdWL/B61v+6dlSiSXupkry30OF+9IXCxAMOfW9PAD3n8Fscb4mHyk
         89ksnoyKrywORNO+Z3Fti4wv7cTAa2rhPA65qSCIWL/q4Fd6fFHxMQiHJJx9dv/ebO4C
         EJwGmOS1rqTnBFMskh1UVuyXkWJgQErDU2+ViTUGSNm+Fz0adKQActV7mAGRQmeVmh8v
         73eB/w5lMVXMreMc/mcke34dJbJaBEtvf2DKIpUwXG3wLxBX5iZJK5o7HFhD/6Q7gGI4
         kz9MptG7urLssu9PcoLYxHGlMghtaJAdFLDGkH2Xf+NnE/1Ucqaei9W8qjvmAZqp3Xiw
         2EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778545546; x=1779150346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYweTmMqrk2Rteck6hihBJf+aeEAyEgXbVoomeow8eg=;
        b=QDkGuMaVYS9Vg0T6FrOg3paoP6hg9ki5eLpg1GlN9r4XF5Bj0afE/P9R9H8paKqJOi
         dlrXgLWAWMp1/8N8anN5kC3ZtK/UGUMGU5VR56eWSAKsZpb0xTaSa6RVKCPo7TfyZIBA
         Ejf+Nr5jDSQll2nwjxVs5ki47MzAvWHEbfXHTSRj+zj/ovt5+N8g9l3+pda3dNiRoLKb
         8pHaPdWYEVgUD3+b4f4gVOv+KMPxnZjl2v3DcKbCRFjXR6JpIShHgjkSh9LsAIb15y4P
         zWeypAvoS4f7EVaD26TYY6kkDLnd2B1XX03j7VNqMWBKg9OJewu/yVQlVO6n/ec6qghN
         CjMg==
X-Gm-Message-State: AOJu0Yza0EAaF2lRlu0DopUHIM5EWbIOw1GYe50icbC1lhvKfzEenfkP
	E8DR07wSc+wUdGjgP0FPM03z2I51+jaXqjAF0KUgP3jWLD8y+U7oHhAr
X-Gm-Gg: Acq92OEvfCkh0Nd2TOrgxoWotviZY+jZiFc4uJ5SrDbRcowRQBR71MOovjuqA8bBq7U
	Ql5JFOfvtv2PIv2pPDNXzmDTD7sBRZBB21qBBCgGe+nlPwp8WAd45ezyuawcNQxc27z1V3mG7I8
	kIxkBSbDuX944QLsfkv4XcGZHoqju9YtFf8Tkv8JUKZ/uhgTTHIDgVumcDu5aShU90nB2rQX9NJ
	ObjjKHFQ00xFtzEyyxYFx7rQVdMGCQStpEiiI+zmWmkuTxYTjYMLusIgEJmnqz9NuM2UF01pIiC
	hfnTrEwzq5j24JFUxs4rFCm+JNBsRZ/NGrgfU9wmgdklQCnAaV1O/iLibgJil2zH8oeCQyS9KL5
	5M2s8e2DFJs/UqvBulf7xBtKQCnhJljnvtnw+9DOzVbsR8zPcCR4eSCxiK5nm476vnojolJ8fJt
	x9kAiOPa0QvFg0WZHmgQZrJRE1Z/6KpTeKTxt4UYN5VrupKTqalNCTVB15HaRzFKjyncBg4WV+B
	ccFe0aW
X-Received: by 2002:ac8:5fc2:0:b0:50f:dd9f:1223 with SMTP id d75a77b69052e-514d2237cf5mr13871101cf.44.1778545546582;
        Mon, 11 May 2026 17:25:46 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11d1::1011? ([2620:10d:c091:400::5:9448])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7e3f4fsm102040911cf.21.2026.05.11.17.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 17:25:45 -0700 (PDT)
Message-ID: <a3aff385-4c40-46e7-9ad9-d64f399750f6@gmail.com>
Date: Mon, 11 May 2026 20:25:44 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] netdevsim: psp: move rx processing into
 nsim_poll()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-3-4b50ed09b794@gmail.com>
 <willemdebruijn.kernel.255240af45e5d@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <willemdebruijn.kernel.255240af45e5d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 48CF8517D86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286882-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action


On 5/11/26 4:03 PM, Willem de Bruijn wrote:
> Daniel Zahka wrote:
>> nsim_do_psp() does PSP decap and skb extension creation in the tx
>> path. This has the slightly undesirable property of not allowing the
>> psp rx code to run on PSP packets cooked up in userspace and
>> transmitted on a packet socket from the peer dev (e.g. packetdrill).
> Whether this happens in the nsim_start_xmit tx side handler directly
> or is deferred to nsim_napi_rx is irrelevant, isn't it?


You're right. The way netdevsim works, it is entirely immaterial. I'll 
correct the erroneous commit message, but I still think having the decap 
code in the napi_poll side makes a little bit more logical sense here.


>> +/* Returns true if skb was consumed, false otherwise. */
>> +bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb)
>> +{
>> +	struct psp_dev *psd;
>> +	struct psphdr *psph;
>> +	struct udphdr *uh;
>> +	int payload_len;
>> +	u32 versions;
>> +	int psp_off;
>> +	bool is_udp;
>> +	int l3_hlen;
>> +	u8 version;
>> +	u32 psd_id;
>> +	int err;
>> +
>> +	if (skb->protocol == htons(ETH_P_IP)) {
>> +		struct iphdr *iph;
>> +
>> +		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
>> +			return false;
>> +
>> +		iph = (struct iphdr *)skb->data;
>> +		if (iph->ihl < 5)
>> +			return false;
>> +
>> +		is_udp = iph->protocol == IPPROTO_UDP;
>> +		l3_hlen = iph->ihl * 4;
>> +	} else if (skb->protocol == htons(ETH_P_IPV6)) {
>> +		struct ipv6hdr *ip6h;
>> +
>> +		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
>> +			return false;
>> +		ip6h = (struct ipv6hdr *)skb->data;
>> +		is_udp = ip6h->nexthdr == IPPROTO_UDP;
>> +		l3_hlen = sizeof(struct ipv6hdr);
>> +	} else {
>> +		return false;
>> +	}
>> +
>> +	if (!is_udp)
>> +		return false;
>> +
>> +	if (!pskb_may_pull(skb, l3_hlen + sizeof(struct udphdr) + PSP_HDR_SIZE))
>> +		return false;
>> +
>> +	uh = (struct udphdr *)(skb->data + l3_hlen);
>> +	if (uh->dest != htons(PSP_DEFAULT_UDP_PORT))
>> +		return false;
>> +
>> +	psph = (struct psphdr *)(uh + 1);
>> +	version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
> This seems to reimplement a lot of psp_dev_rcv. Is that needed?
>
> Is it a hint that this psp driver API needs some work?


It could be. I'd have to split the parsing from the decap logic in 
psp_dev_rcv(). I just wonder if another user of the two separate halves 
other than netdevsim will come along.


>> +	rcu_read_lock();
>> +	psd = rcu_dereference(ns->psp.dev);
>> +	if (psd) {
>> +		versions = READ_ONCE(psd->config.versions);
>> +		psd_id = psd->id;
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	if (!psd || !(versions & (1 << version))) {
>> +		skb->ip_summed = CHECKSUM_NONE;
>> +		return false;
>> +	}
>> +
>> +	psp_off = l3_hlen + sizeof(struct udphdr);
>> +	payload_len = skb->len - psp_off - PSP_HDR_SIZE - PSP_TRL_SIZE;
>> +	if (payload_len < 0)
>> +		goto drop;
>> +
>> +	skb_push(skb, ETH_HLEN);
>> +	skb->mac_len = ETH_HLEN;
>> +	err = psp_dev_rcv(skb, psd_id, 0, false);
>> +	if (err)
>> +		goto drop;
>> +
>> +	skb_reset_mac_header(skb);
>> +	skb_pull(skb, ETH_HLEN);
> Similarly this is a bit of a hack, pushing and pulling a fake Ethernet
> offset.
>
> And is this skb_reset_mac_header needed?


skb_reset_mac_header() is needed because psp_dev_rcv() shifts the l2 and l3 headers forward, and the mac header has already been set. psp_dev_rcv() expects the mac header to be there. I hear what you're saying though. The driver api could probably handle these for us, but I also didn't want to overfit to netdevsim without another user. I'll explore some options before I post this again.


