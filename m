Return-Path: <netdev+bounces-257910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMSMO0yWiWlj/AQAu9opvQ
	(envelope-from <netdev+bounces-257910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 09:09:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 909BB10CC79
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 09:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE50030010EB
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E203133ADB7;
	Mon,  9 Feb 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BD09N3yK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2D29B8E8
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624586; cv=none; b=Z/9D5Mk1+B39f22G3vydrdIBmNEO3idXGfN9PA2Erimv06+Big+YUyzZD4DnwVJmHu2uXX6wO59ZXOBVj2hdrslIoQibyvqP12Rac9O0qmH4eTBOhN2cye4elpX9rK0fdKwmGk6qughFOEHxs5CgJzOiHo7lyGSKPReQULn3u0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624586; c=relaxed/simple;
	bh=3GyMKAjFPEmKExP2e0mPiF5qwz1gyk7HNUJvWsvBmPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsvPnr6nvruAyG/hpayo1ClSar1BDoMU5F/azOvU6+ekqP913SCYBBaXpS3LOXFdaQmpQveEw/09RwA4wKPfAxwoOE9Ud3bboekIiGhg8nwva91Zr3n7NuQl7LUNA3dRMXCKkeYUqzCUhEqUlYONy+Ch4OpjlL0m1Kl7RYkqLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BD09N3yK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D58E81A2CAC
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 08:09:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4D1E6074B;
	Mon,  9 Feb 2026 08:09:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB0AF119D1B15;
	Mon,  9 Feb 2026 09:09:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770624576; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Tpp5m9sUBKbWS+MPQ5BGBO3JfSWbEXySTKg9Ds4pHlw=;
	b=BD09N3yK1WnSF+8wPEQXMfDrJ3oGlhOxY/o5pKLQT+mzOAxwKlBQgvEXaSLNu7FsOZF+Nt
	gEsQ1GrtXd1v76O9lnIpBv7oYJdtc+vrlF9xzYlPsWfotzcFMSo9ZK9xDm601KCX+K19Z+
	wQQttToZqtqBRshCzFjFlzscy5FuaRZeNokxn7BtJRgIxJFuBW4y+Ix+HFWYaNdmyuyzuH
	fVrLDjRWwZYuehVZV6jz58/LxkyM+sWXHJ/AHyZZojMVxLpcb7Lx0V1HryKbzpmkiABtKq
	bUfaGcRj8Njbv/BWgoKLIEwPJpfIl4/286bYGtWFIri/WvyGi1R0qpgSkk3ssg==
Message-ID: <e5f1688f-cb13-4d43-bf20-644cda6ab494@bootlin.com>
Date: Mon, 9 Feb 2026 09:09:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net: ethtool: Introduce per-PHY DUMP operations
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <aYXu0esD_wSjGTZm@stanley.mountain>
 <c9c6378a-14a3-440a-80b7-f48cdb06623b@bootlin.com>
 <aYmID1BOGmwb2rUD@stanley.mountain>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aYmID1BOGmwb2rUD@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:url,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 909BB10CC79
X-Rspamd-Action: no action

Hi Dan,

On 09/02/2026 08:09, Dan Carpenter wrote:
> On Fri, Feb 06, 2026 at 06:04:36PM +0100, Maxime Chevallier wrote:
>>> net/ethtool/netlink.c
>>>     700 static int ethnl_perphy_start(struct netlink_callback *cb)
>>>     701 {
>>>     702         struct ethnl_perphy_dump_ctx *phy_ctx = ethnl_perphy_dump_context(cb);
>>>     703         const struct genl_dumpit_info *info = genl_dumpit_info(cb);
>>>     704         struct ethnl_dump_ctx *ctx = &phy_ctx->ethnl_ctx;
>>>     705         struct ethnl_reply_data *reply_data;
>>>     706         const struct ethnl_request_ops *ops;
>>>     707         struct ethnl_req_info *req_info;
>>>     708         struct genlmsghdr *ghdr;
>>>     709         int ret;
>>>     710 
>>>     711         BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
>>>     712 
>>>     713         ghdr = nlmsg_data(cb->nlh);
>>> --> 714         ops = ethnl_default_requests[ghdr->cmd];
>>>
>>> Smatch thinks nlmsg_data() is untrusted data, so it could be out of bounds.
>>> It's a u8, but there are only 52 elements in the ethnl_default_requests[]
>>> array.
>>
>> I see, then we also have the same problem in ethnl_default_start().
>>
>> I'd expect the genl part to validate cmd (I haven't checked yet), but we
>> do have a WARN_ONCE just below for the case 'cmd' is wrong, so we could
>> definitely add some more sanity checks before accessing
>> ethnl_default_requests[].
> 
> The WARN_ONCE() doesn't doesn't work as bounds checking since there is
> no guarantee that the array will be followed by NULL pointers.  I didn't
> see a bounds check for this, but I'm not an expert.
> 
> netlink_rcv_skb() <- receives untrusted data nlh = nlmsg_hdr(skb);
> -> nfnetlink_rcv_msg() <- calls nc->call()
>    -> ip_set_dump()
>       -> netlink_dump_start()
>          -> __netlink_dump_start() <- calls control->start(cb);
>             -> genl_start() <- this is where the validation would be
>                                when we call
>                                genl_family_rcv_msg_attrs_parse()
>                -> ethnl_perphy_start()
> 
> Also the WARN_ONCE() warns if we try to do a cmd which doesn't have a
> matching operation in ethnl_default_requests[].  Every time we check
> for missing commands it triggers a WARN_ONCE().  There are quite a few
> which don't have a handler so I'm surprised that syzbot doesn't trigger
> the warning and complain.  Here is a list of commands without a
> handler:
> 
> ETHTOOL_MSG_USER_NONE, 
> ETHTOOL_MSG_FEATURES_SET,
> ETHTOOL_MSG_CABLE_TEST_ACT,
> ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
> ETHTOOL_MSG_TUNNEL_INFO_GET,
> ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
> ETHTOOL_MSG_RSS_CREATE_ACT,
> ETHTOOL_MSG_RSS_DELETE_ACT,

While these commands don't have ethnl_request_ops handlers, they still
have a genetlink handler, see the ethtool_genl_ops array [1]

The ethnl_request_ops are there to provide a framework for ethtool
netlink commands, as most of them have roughly the same behaviour of
needing to grab some info from the netdev/phy_device under rtnl, then
populate a netlink message based on that outside rtnl.

It's expected that not all ethnl commands use that ethnl framework as
some behave in a manner that don't fit the ethnl scaffholding. In the
end, the "cmd" validation is done by the generic netlink infrastructure,
that's why we don't see reports from fuzzing bots.

The WARN_ONCE we see in ethnl_default_start() and ethnl_perphy_start()
is there in case a programmer tries to use the ethnl framework without
having the ethnl ops populated.

[1] :
https://elixir.bootlin.com/linux/v6.18.6/source/net/ethtool/netlink.c#L1132

In reality, we should never end-up with an out of bounds cmd as the
validation will occur higher-up, in the genetlink part.

However, I'm OK with adding a check, or a least a comment :)

Maxime

