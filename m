Return-Path: <netdev+bounces-281753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNNyCGuB8Gn6UAEAu9opvQ
	(envelope-from <netdev+bounces-281753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:44:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E740481BDC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03A1130C30CE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4463A9D9F;
	Tue, 28 Apr 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unstable.cc header.i=@unstable.cc header.b="Q855GIKM"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C10E3A9615
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369001; cv=none; b=LbSe60BH5OhKUu/9IVJHJCOss9DOdpmuFkD8Jp6+HeCGc7Pdll7x7QsUgdjPzIqFn4Dq84iSAdFw3qvTwmKLlA3+iLEOWuXRmjz0TtdLMReWaefv2ryvPf0uaE3WpTkVK6RLViDtzLLm5oZ7oAXzSJfIfg6ZY6LT8uVpBemzzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369001; c=relaxed/simple;
	bh=VdTq7BMhAxvRxFJvh+UKpS1siHUnJe1p6mcoI/3iKGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAy+EjCHwtz7k+o9v8/XkFyvO5OLmyNu2bxc0KE4AqZ7WzhZkfucfoWj8NDGLm7IfjDUwK8yG2tA5SUao5dLgyjMlpEfQIUABQhzbuckBALU8aIhM369RRaWJ/fqarxpGDArE7S4q3nRWJgIV5qiYA5H9TxGxDnR5YViJTV9bJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc; spf=pass smtp.mailfrom=unstable.cc; dkim=pass (2048-bit key) header.d=unstable.cc header.i=@unstable.cc header.b=Q855GIKM; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unstable.cc
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g4b0q3jFyz9vRT;
	Tue, 28 Apr 2026 11:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
	t=1777368987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23/XY4dp+qH/wtxbXh6d/rrGCv8XMFb6m9syD0CClM8=;
	b=Q855GIKMVKCMWJsVY57lTQN1nbuLC0TV6YmthbcEVk0mWnjGfyc4lLn2cNjWp/pO7sFAaB
	PY8h4KQO4mMzZPqxutxCfSmdCGoqFGZZ7rTPSxsvERu4Ito7sUehsVX7cLxXKk6y2Rt1v/
	351mBl1vKV9yyxkAQnPFj4Ne1XICoDJSEoTO4658G8AusmYIFJfJbe3xb+cw6Cq4TnpoV2
	bgawd62fAJOXppvokIR2zTqEyQcSyYrcTotIvVC9gELzAbAVEZEWB/UL6CxsNrxjPL8jSZ
	i4bqa11r3ccTMYehRnEbuLd9eJF7L2orxCtZTGzCeHaEzaEkM3NiV978A4Sefg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <d2074fd5-9e15-461a-8c1b-61c60879854d@unstable.cc>
Date: Tue, 28 Apr 2026 11:36:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: reset MAC header
 before passing skb up
To: Qingfang Deng <qingfang.deng@linux.dev>,
 openvpn-devel@lists.sourceforge.net
Cc: Minqiang Chen <ptpt52@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, antonio@openvpn.net
References: <20260427040011.2107748-1-qingfang.deng@linux.dev>
 <101221c8-8e47-4fc1-9791-2ef3a0ae8312@unstable.cc>
 <501fb5d6-3247-40aa-aaa5-ce9dacb17255@linux.dev>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <501fb5d6-3247-40aa-aaa5-ce9dacb17255@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E740481BDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[unstable.cc:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[unstable.cc];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281753-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,vger.kernel.org,openvpn.net];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a@unstable.cc,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[unstable.cc:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,

On 28/04/2026 04:08, Qingfang Deng wrote:
> Hi,
> 
> On 2026/4/27 17:45, Antonio Quartulli wrote:
>> Hi Qingfang,
>>
>> thanks for the patch!
>>
>> On 27/04/2026 06:00, Qingfang Deng wrote:
>>> After decapsulating a packet, the skb->mac_header still points to the
>>> outer transport header. Call skb_reset_mac_header() in
>>> ovpn_netdev_write() to ensure the MAC header points to the beginning of
>>> the inner IP packet.
>>
>> May you elaborate on what this is exactly fixing?
>> Did you encounter a bug triggered by this missing line?
>>
>> I am asking because I wonder what is "expected" as MAC header for a 
>> packet not having one at all (packets delivered to the ovpn interface 
>> are L3 only, as per the interface type itself).
> 
> For L3-only devices, the net core expects skb->mac_header == skb- 
>  >network_header.
> 
> For example, in __netif_receive_skb_core(), skb_reset_mac_len() sets 
> skb->mac_len to (skb->network_header - skb->mac_header).
> If skb->mac_header still has a stale value, this will incorrectly assign 
> a non-zero value to skb->mac_len.
> 
> Also, if generic XDP or SOCK_PACKET is used, either will do
>    skb_push(skb, skb->data - skb_mac_header(skb));

Thanks a lot! This makes sense!

I'm applying the patch to my tree.

Regards,


-- 
Antonio Quartulli


