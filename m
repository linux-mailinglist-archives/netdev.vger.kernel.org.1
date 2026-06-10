Return-Path: <netdev+bounces-297564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fZt8OvcxKWraSAMAu9opvQ
	(envelope-from <netdev+bounces-297564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9112667F47
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:44:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=AYb6FL2c;
	dkim=pass header.d=redhat.com header.s=google header.b=S9VxEUOI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297564-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297564-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD04630005AF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27237F8B3;
	Wed, 10 Jun 2026 09:31:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3D374A03
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:31:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083879; cv=none; b=Z7DE1oBZKHI4D/4sb4jmU17e9CH4xfkeVBDZXojxtzOidLDQ6yURQ5Cirl6P0wK46EkUp/mphgAE3HYG3RZzuCcnf3rrfn3ZEZEmI+RFnQHnB91xe6nLw3pIWV7bB8pgzTMBncLKR69MR4HDiYUsBMmbDM6m50SRFq41vKqEP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083879; c=relaxed/simple;
	bh=WKDpiUAWn98w2fEup/ygkSwjILTQow+alyUFCHWB3YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GufsI22fz5Ww+c2fXu95bttO1wXvrGgxJQBlNnvdJ7GZ5Izint66vlHX2B4Du+Ydy381Pn5IMOHTx0qjngqBWeJoGk/q5OEV/I+QNJEvYInTqrmdvPnHNSpWTuy9h8tWbPea4pkPM7I0g0UtfEgGmKonU6O86LPWoitlanETomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYb6FL2c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9VxEUOI; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781083876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpmhBCyPyDRGUbBlC7Y/EzMHBCvQF8Q78wV9zm+DY4s=;
	b=AYb6FL2c+/JQ2WB9SNYS1rJhzfH1oTCX1SdPlWKlQuV4UhE77AkKDNGyCgHL8AG4Gb6rID
	EBf8h2A7v5DpQUD9dVUQz/Lubpk9Bunmp1jjbI1ogFKq73pW1lmquBJFtKDJh8do9T4O3F
	3otrnagXrjwNpvg3evgwhG23cC8swJ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-s9kByo1bOzuPU0hJYdC7GQ-1; Wed, 10 Jun 2026 05:31:15 -0400
X-MC-Unique: s9kByo1bOzuPU0hJYdC7GQ-1
X-Mimecast-MFC-AGG-ID: s9kByo1bOzuPU0hJYdC7GQ_1781083874
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490bde3d239so50292825e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781083874; x=1781688674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpmhBCyPyDRGUbBlC7Y/EzMHBCvQF8Q78wV9zm+DY4s=;
        b=S9VxEUOIB+F8QNIvzunplRRdQM22Gmhl+cmbIKnQqQDUIzuHMVzJ4Pgek1OvBLBPvN
         yQpy9VOPoCfmTFinBcc5EirUPZG992ezAWJgsrw60tMqUTgnCf+UBsoTFMEM8JM4/Cu5
         T5CUqHvsIbxPe0EBfVeYIXAsQvTYDEF8zMpTgSE9Yrdric/yYsxGZ8bQoS2w9sMj5E7N
         dFwDkZhIWED8xKpka3WtgaUrQALHWbolHER0fDcrs2hMpo1i7wQTG9RL2vndryYPdrB0
         7cVLGmFZqN9BaWrPJWMDIF8YefLclALb8c95wTO2Iuqa8qzWYPPjwy5HUQNkdaJDc047
         UTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083874; x=1781688674;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpmhBCyPyDRGUbBlC7Y/EzMHBCvQF8Q78wV9zm+DY4s=;
        b=PDG8KjlMjyacZqJqW8ZfO6p75lEei8WG7hdNi1+elNl1ja0Dl/33WDQQfPJvz3B1xL
         IjYSUV2Mi5YVXoS4A0YEeGp3d90Nx7nj9Vr6+QyaxPJt0H9cDZ//2f9irZVH+qTe5Vw1
         fTsBZB5rDYad3/GXoq17iVqd84LQQeN8VACWGM3DKsXSXGDLQoqU8A4GyIOGPu4Sotr7
         enHt11Xq+KXB21ivE3qcGstwNNuiPtH1I1dch+zNARWElJPuhaPfkmCvdpTLZoCT0tKV
         Wh4YozzQfsAUyzGViCKV6K/U1DiQJHnKke1hNm06hIwoyooM/VKZ8cvobm6T/5aFVpk+
         L63Q==
X-Forwarded-Encrypted: i=1; AFNElJ//pbcG+USuR79o7pnrwtM5nd1jTYUGkqc9QorVZ42PSfnKjl40qHKPS6VxJxmsqBrnHJ2WXVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1sjHpjL3t6qEfmwXxksOoHfir+fZjShOIIa4l7WOesHyUz/4/
	hPJe3rFWAOM32NQzF79VfC/vuSFOaUv2yCUZFHY7PSIfdkpMyfju5jfuSZ1Eh9h3fQNWhLN6STO
	BeakRHXrzYDgDX8gl/4PSYsw8dnuMEmq3QLoqY1GrIlPhdSZm3ZF8KgHenw==
X-Gm-Gg: Acq92OGXePu4sndzNdFlECYqCOM6lSEXcML9iv2CYUeD2JAyV55KDNOHiCx91GR0BbG
	wVhtq/rSq8S/2ZH0LagPHi8F8oekFW9KK4jPhur+8SPhkNVC25V92BvISMYSFtascNwU6jwxVpB
	EsKRbf4Xh3RmwehNLaAoaoCFwJYzSd3rpXoByh0gsXX+0d/TrKPlnVqmW1paaiwyVuZUgwteuUl
	VrscxeWrPcCOzpkbDjuDr8MmwPaCRMFcPdaYlY/cvKAiMuxkXXg2TGLcKil+nVk7PtfwN/WzKK9
	o7P86JdykJbioMMTxi+s8nAJ3Z20DSOZZX3mT3RuDDyS6UqmgITrgnnf/YDWJ05LFW/Epx+Q0Oz
	51pKMMAt8V+kdt1D6oNE+aaJe4nGSLZ8MXxbCLiYh6saxNdbFW5awWdQMjGkES9rXJA==
X-Received: by 2002:a05:600d:8494:10b0:490:c2a3:3304 with SMTP id 5b1f17b1804b1-490c2a333c7mr254075615e9.35.1781083874323;
        Wed, 10 Jun 2026 02:31:14 -0700 (PDT)
X-Received: by 2002:a05:600d:8494:10b0:490:c2a3:3304 with SMTP id 5b1f17b1804b1-490c2a333c7mr254075025e9.35.1781083873786;
        Wed, 10 Jun 2026 02:31:13 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm556115855e9.15.2026.06.10.02.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:31:12 -0700 (PDT)
Message-ID: <859702b5-0528-416f-9325-c13757d8463f@redhat.com>
Date: Wed, 10 Jun 2026 11:31:10 +0200
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
 <ea5ed9f7-daf5-4996-8c0d-84c2bb946be5@redhat.com>
 <6bdf5092-d877-4c09-b3a2-07a92b57fd54@app.fastmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <6bdf5092-d877-4c09-b3a2-07a92b57fd54@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9112667F47

On 6/9/26 7:41 PM, Alice Mikityanska wrote:
> On Tue, Jun 9, 2026, at 10:32, Paolo Abeni wrote:
>> Hi,
>>
>> On 6/2/26 11:39 AM, Alice Mikityanska wrote:
>>> @@ -2605,6 +2605,9 @@ int udp_rcv(struct sk_buff *skb)
>>>  	if (ulen > skb->len)
>>>  		goto short_packet;
>>>  
>>> +	if (!ulen)
>>> +		ulen = skb->len;
>>
>> Sashiko noted the above is a bit fragile, as malformed udp skb will
>> unconditionally use the skb len.
> 
> Malformed packets are addressed in patch 7 — it closes the gap, so that
> uh->len = 0 can't come from the wire.
> 
>> What about introducing/using an additional helper alike:
>>
>> int udp_get_len(const struct sk_buff *skb, const struct udphdr *uh)
>> {
>> 	if (uh->len)
>> 		return htons(uh->len);
>> 	if (skb_is_gso(skb))
>> 		return skb->len;
>> 	return 0;
>> }
>>
>> and use it here and in the next patch?
> 
> Since UDP-Lite was removed along with the special case in udp_rcv, the
> helper for udp_get_len makes sense now, yes. The only two places where
> it's going to be used, though, are udp_rcv and udpv6_rcv. AFAIR, only
> these two need to read and decode len=0.

I think also udp_validate_len() in nf_conntrack_proto_udp.c could/should
use the same helper. 

> I'm not sure about the skb_is_gso check, though. Given that malformed
> packets are addressed in patch 7, do we need this check? udpv6_rcv
> already does the following without checking for GSO:
> 
> 	/* Check for jumbo payload */
> 	if (ulen == 0)
> 		ulen = skb->len;

AFAICS, checking in udp_gro_receive() is not enough to protect the whole 
RX path: some NICs still do use NAPI, some other explicitly skips NAPI 
when aggregation is not possible. Also malformed 0 len packets are not
dropped at the GRO engine level, and with eventually reach udp{,v6}_rcv().

I think the GSO check is the more robust among the easily
available ones, and should not impact performances - it touches 2
additional cachelines compared to the current code, but both should be
already hot in all the relevant callers.

> I don't think Linux supports jumbo UDP with HBH coming from the wire
> natively, does it? If it doesn't, and the above is only for BIG TCP, it
> should be safe to check skb_is_gso in udpv6_rcv too, but again, is it
> actually necessary after patch 7?

WRT the need for such check, see the previous point. 

I forgot about jumbograms. The current ipv6 udp RX path currently 
handle them, I think we must preserve such handling. Possibly something 
alike the following?

---
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194ecc..d4d1d85dd7cb 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1085,8 +1085,9 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 	if (ulen > skb->len)
 		goto short_packet;
 
-	/* Check for jumbo payload */
-	if (ulen == 0)
+	/* Check for Big TCP over UDP tunnel and jumbo payload. */
+	ulen = udp_get_len(skb, uh);
+	if (ulen == 0 && inet6_is_jumbogram(skb))
 		ulen = skb->len;
 
 	if (ulen < sizeof(*uh))
---

The above will make the check in the RX path more restrictive, but it will
be also aligned with the existing one in recvmsg().

/P


