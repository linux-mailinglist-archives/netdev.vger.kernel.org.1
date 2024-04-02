Return-Path: <netdev+bounces-83901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB6894BC2
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 08:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47601B224CC
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB642BD00;
	Tue,  2 Apr 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="CYEdOCNC"
X-Original-To: netdev@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAFC1D6AA
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040512; cv=none; b=GuryefxyoPiNpRrUGSWXbd3oO9hvUsviSwBeFOj2P2wtc+GEV+cbMBsXL3ovx5PjGHsn/sD1EfHmdkCnfa1Z2BNPtG0Tm3emNOLU3DErOFZtu9Ziyx4V9+eS0BG7QDp5Rnz8uwdqZrUczMvptY0WzoFUqqKWwFNhziFi87tmFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040512; c=relaxed/simple;
	bh=BLYZIYrI3eP9TkCtA5Q+0oc9w6kwxCFrP22vfC4tzxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJ17JwIUJKzoDyQyr+8xLuUKOIqJhhYIRC+qGa/BCjn4bvfcMZJL0stum2Ek4FygovBm0YO4ncGuGgPs7djIBybywcxh+kxb7L4r4E1OLEOWMvZi3YteuVJroz/HX+mx4B5QcgmtQn8yQmSWK3ybSzNuZXGZI/SilDo9lzUfayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=CYEdOCNC; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=eToL6K57tsD3Qp3xjDv4huV4667uj1xTWdGaNrEayy4=; b=CYEdOCNCa05eWtA4vN53d/X+D4
	PD+tV/LN3PMFUqcsQIvif8pTTal9sfHDqrNQn/rFpkfILl8sZ5m112eRAEh/hfh6nFAwc/iZWZ45j
	SUaXDaaR1u2MEZz1a/xU9lSEX5B561ATtoSwDsEJJHGeDkV+8FDCjb9xlnAsq8QFwaaxS7Ddnr7Sz
	zTCoy1L8nParCyur6U97LWHcG+nfVlyRQRfLt7HU31IulzwSFAaJKSdlWTZ0QzK8Zqbhn0LPh+AzK
	63q9w50z9MaDDcup9YfwOM78Fth7RZqG3CO+mEn3Ti4pyodJeBg2kw+SlCx/nzqkkQ9Oesl1vcJRO
	5L3aZVAw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rrXwP-0002j0-HW; Tue, 02 Apr 2024 08:48:17 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rrXwP-00EbSs-00;
	Tue, 02 Apr 2024 08:48:17 +0200
From: Esben Haabendal <esben@geanix.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  Sergey
 Ryazanov <ryazanov.s.a@gmail.com>,  Paolo Abeni <pabeni@redhat.com>,  Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 05/22] ovpn: implement interface
 creation/destruction via netlink
In-Reply-To: <57a773fc-dc1e-4f8b-b60b-13582e6d057c@openvpn.net> (Antonio
	Quartulli's message of "Tue, 26 Mar 2024 22:44:01 +0100")
References: <20240304150914.11444-1-antonio@openvpn.net>
	<20240304150914.11444-6-antonio@openvpn.net>
	<871q7yz77t.fsf@geanix.com>
	<57a773fc-dc1e-4f8b-b60b-13582e6d057c@openvpn.net>
Date: Tue, 02 Apr 2024 08:48:16 +0200
Message-ID: <871q7ogszz.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27232/Mon Apr  1 10:23:51 2024)

Antonio Quartulli <antonio@openvpn.net> writes:

> On 25/03/2024 16:01, Esben Haabendal wrote:
>> Antonio Quartulli <antonio@openvpn.net> writes:
>> 
>>> Allow userspace to create and destroy an interface using netlink
>>> commands.
>>>
>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>> ---
>>>   drivers/net/ovpn/netlink.c | 50 ++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>>> index 2e855ce145e7..02b41034f615 100644
>>> --- a/drivers/net/ovpn/netlink.c
>>> +++ b/drivers/net/ovpn/netlink.c
>>> @@ -154,7 +154,57 @@ static void ovpn_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb
>>>   		dev_put(ovpn->dev);
>>>   }
>>>   +static int ovpn_nl_new_iface(struct sk_buff *skb, struct genl_info *info)
>>> +{
>>> +	enum ovpn_mode mode = OVPN_MODE_P2P;
>>> +	struct net_device *dev;
>>> +	char *ifname;
>>> +	int ret;
>>> +
>>> +	if (!info->attrs[OVPN_A_IFNAME])
>>> +		return -EINVAL;
>>> +
>>> +	ifname = nla_data(info->attrs[OVPN_A_IFNAME]);
>>> +
>>> +	if (info->attrs[OVPN_A_MODE]) {
>>> +		mode = nla_get_u8(info->attrs[OVPN_A_MODE]);
>>> +		netdev_dbg(dev, "%s: setting device (%s) mode: %u\n", __func__, ifname,
>>> +			   mode);
>> Maybe print out the message even if the default mode is used, as the
>> mode is applied in ovpn_iface_create anyways.
>
> Being this a debug message, my reasoning was "let's print what we got via
> netlink" (if nothing is printed, we know we are applying the default).
>
> Otherwise, when printing "P2P" we wouldn't be able to understand if it was set
> by default or received via netlink.
>
> Does it make sense?

Yes, reasoning is sane. And the prefixing with __func__ should help
making it clear.

/Esben

