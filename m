Return-Path: <netdev+bounces-296975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aE0wLl/QJ2r32gIAu9opvQ
	(envelope-from <netdev+bounces-296975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:35:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDCA65DD66
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:35:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=V5xBTqF4;
	dkim=pass header.d=redhat.com header.s=google header.b=NHK4D8NX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296975-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296975-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE73430DEB37
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D207C3DA7E4;
	Tue,  9 Jun 2026 08:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91365382395
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:33:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993986; cv=none; b=OX/Otr6zNKHomjd48L/kScSB/kZTGMF39iYpeO+g4OGIykgjCGXxuVVSd6n5zEurokHYtu3LSsAd1qBqC8pWJPIv0Dc7sgkqoHCtBwZdWVgI3mNUkZMcDBVCdGDwJCBd1pn57Ctd7jwIhJYvfXoMlqj1W+IEoFXsNIwla05xotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993986; c=relaxed/simple;
	bh=pgNY/0aBPhcdbikgS69PJmRdB6mG/gKfWPbeDpDukR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JY/Nur6kvutj4+SUByP+T0GnwBpMsN3nO9JI3VFmP2TuI17VRKYAIpj9CXbakCegoqPnmgw85JTmlpUo6fd4RS7ORH/cPuNuVJIDbUDreHAk1+BnAF1Ab+Y9bYbBgayBss4FQLnNZkqPgvBRtLoCw0seWlz9jkOpwMcluDts4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5xBTqF4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHK4D8NX; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780993984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC/+VIPa5C4leHYPlSx2TTnysQUQONSxhzEcxjr3+ms=;
	b=V5xBTqF4KRL12iwNwpmVPfL3MlKWMFPfILoRyiRcOjnCk/TVhvComlgo4eYPtVDwtNjBFk
	B661qNAGDCrb8InnFh1i9AWwBZJqOVexE0tzIqef/Hc87UzdQYYtWxuL8pmuEhmQyt70VQ
	XAjnEc9xvuHps/VZPXbYqcBD2lKO7xM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-L9fEJqAmNyqbJAjUBgRyeQ-1; Tue, 09 Jun 2026 04:33:02 -0400
X-MC-Unique: L9fEJqAmNyqbJAjUBgRyeQ-1
X-Mimecast-MFC-AGG-ID: L9fEJqAmNyqbJAjUBgRyeQ_1780993981
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso24136755e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780993981; x=1781598781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rC/+VIPa5C4leHYPlSx2TTnysQUQONSxhzEcxjr3+ms=;
        b=NHK4D8NXr1zHi4xy0ownj0UKOMhvmEdwvL1QFi2Q1zEIWs9tmLqtpm4s+lmHpeL2SK
         PUewl9jXz1Ab3kVUE3wDeGVnAA31SrTn1ttXu6Hon79CURwNSP9NLnYkLxZI7cCanLG7
         Cesp7SpDxcElRPnlSuazbdkCJM+Z5w9ZdqqNI19wjpn6/fX+a0mBBAiuYylSPMSCYczK
         y8H3NJR/0HjBFUK8rnLSTvkf5Y+AWerW99LJ91R6Z+V/8Kuf3mODWe3WD9GgPqkXV6wi
         6vyfOyho+ZR2aqzsgkTomU0rM21+S/81/8B8NVTccNaj3FIOAjp75oEslKUiGsies183
         wbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993981; x=1781598781;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rC/+VIPa5C4leHYPlSx2TTnysQUQONSxhzEcxjr3+ms=;
        b=HwBR34Wk+y1eRqQBJILcytv8xnEFa+c2G8vffVpwohhLePm6FYjWDzgaNbm8XzTDMp
         dUXEC4v5+ixYvUrQPxdfOZWWGbmkqXm/VovR7qs+dUasdpCcF8zHbp7odmpkNA6B2QhC
         snsZMhYdIGpXsJwARqsuigzKlm2kUZxc2fRtakcl/2/qbDXX+7yWvhYc+4X/4x6OajVt
         YCXUT0OqnKEbA2iUtond7HgM76XnGMW4c6dkLHZ9RbuUG52DeK73uLyhX9cAupq4I0SQ
         1Hf0hCyv/YZ9WkLhOgvbBdcpRryHAH5gahUVWlgnWeC76R85woKBVOFuhUF0ie9alRMo
         0AuA==
X-Forwarded-Encrypted: i=1; AFNElJ8zDk9TpvtZN1XvHsVqTi1UFY5ssnCXeySwWDRMzu63tVulvRwp4nRii4Zf6BKt7nF4pTClf2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79fOGFhXx03uHATyDXloXjkLg3Kpo48a8KYY+qjEwCzYauTVn
	kSM1iXFu9sehLRDXRyypO6JZ9hyw5/hx9nrsHg517wKBwwfE0Vky460gcpFd+BeCOXE6P1kse9v
	uFuC+8DnQWzFRykDy0IE8whdk3nM68iX2fBOdRjIIzrv3pNffIE6lEXuMsw==
X-Gm-Gg: Acq92OEP4i1iiptAXIERas+vpS30yZvdTmjetAsNNAJpj1zIKwzA+opXXRUlIzjP0Tw
	EtXuU1UXqUY58OCREtIWcCqGwpBWiOpCS1eyESEu3VvrRJcfF6RMseIJx1k6pWpi9sllz/bF/6t
	ybtnTxvSVjzq2+envOMuWsWXbDko6j9tJBxPqCnhADBWhqWU7SogEF3fSxxS8NCmJYuBNLVjZ3F
	PYXx0ku5ZZyBfTh3uHEE3OFL+zIyUdcYrBZNbrlpEuDrpHycKrTqxTBKmBk/kHFODC/mj5ww9TY
	FeMvBMzNrngn+8LKWqZeNhTn9vB1MrifetJbIpVuIek8barurRQl2IzgtpgvIrHQz6Ddv6H6+Jp
	hJzvSYAj41bE2MxwnmHSpmfs31+GVxBUwvmM5KH90Wwx0EzyB8kx1PPuGxyrYqGbQLQ==
X-Received: by 2002:a05:600c:3e87:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-490c251d8e4mr330657705e9.0.1780993981383;
        Tue, 09 Jun 2026 01:33:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3e87:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-490c251d8e4mr330657135e9.0.1780993980940;
        Tue, 09 Jun 2026 01:33:00 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c183asm466160405e9.6.2026.06.09.01.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 01:33:00 -0700 (PDT)
Message-ID: <ea5ed9f7-daf5-4996-8c0d-84c2bb946be5@redhat.com>
Date: Tue, 9 Jun 2026 10:32:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 05/11] udp: Support gro_ipv4_max_size > 65536
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
 <20260602093931.516281-6-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260602093931.516281-6-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296975-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CDCA65DD66

Hi,

On 6/2/26 11:39 AM, Alice Mikityanska wrote:
> @@ -2605,6 +2605,9 @@ int udp_rcv(struct sk_buff *skb)
>  	if (ulen > skb->len)
>  		goto short_packet;
>  
> +	if (!ulen)
> +		ulen = skb->len;

Sashiko noted the above is a bit fragile, as malformed udp skb will
unconditionally use the skb len.

What about introducing/using an additional helper alike:

int udp_get_len(const struct sk_buff *skb, const struct udphdr *uh)
{
	if (uh->len)
		return htons(uh->len);
	if (skb_is_gso(skb))
		return skb->len;
	return 0;
}

and use it here and in the next patch?

/P


