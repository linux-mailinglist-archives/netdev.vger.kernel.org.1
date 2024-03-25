Return-Path: <netdev+bounces-81654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 903AF88AB55
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B8EB671ED
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A159E1292E8;
	Mon, 25 Mar 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZL1W31SA"
X-Original-To: netdev@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799E38DD1
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378891; cv=none; b=axOBFZZala8TsFCLBY9GHOFtWo95c5w2S2VTnLt/0q4kWuUMZQgTf3imiqNRfII45blMw5fUA9SbmosaDstghylS+6reQ/llRqw0RCpy1qFu7ARAy68AKHMXRrpAOV7727qtjVd5JZezR5EtPV0IBbblsIKtGYGxj5zNGX6bU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378891; c=relaxed/simple;
	bh=3hCKeKu+RySsWj6xJeXihClyH+s/PnBpp0lvFdlVjyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jfmIuyo952VYr5Cf5+hpRglRf1YTbeNv1vToDekHWOahGFI9Qnkk6y1LPf0OXdqQQRq91fEsWRbuAChluyRMuYJJQYWFgSVjsgKuMpSkrXwZ6r5nWB7bCIThFaj7V/06u+C2vq01elkqLTPidNBzjrAilWM4Jd7lBTpydUWoWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ZL1W31SA; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BcOyNqzTX40LbbtWCeDQnZaxtmXtLEyJPCaeK5Tfjqo=; b=ZL1W31SAL8jfaedie6cxH4G4rO
	Oh6ZuceUYbxZWIBhqSe7+1rOcm6cfglNg/yz6c0kVSgYmPtGu+8izsKuZ9ltGmt81tuHB4P6VCEbm
	udEF3/8vuxq/CJp2JWOZnsOb0Sf5o47fUqwForqIsaCSmfnXjOaHSiwjzh8hMpP/iC1wyGgHZuJSn
	Dp5hywovW+RC4/zGnz+3fpLpTDn+bK2MrF2mUTYdEFT9a+u5PUYyzU2Jl8Mok51/Poi3/Kl5NRdmb
	tlUF1tXwdRKF9G7CywT2hy+oLm/cc2xSDRoLSeISvU7wKIJ5Mw+l7Y21L8zt6euLfvUvsGTXBCBpT
	fMq7mu+g==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rolp1-00067X-2K; Mon, 25 Mar 2024 16:01:11 +0100
Received: from [87.49.146.11] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rolp0-0002pD-1r;
	Mon, 25 Mar 2024 16:01:10 +0100
From: Esben Haabendal <esben@geanix.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  Sergey
 Ryazanov <ryazanov.s.a@gmail.com>,  Paolo Abeni <pabeni@redhat.com>,  Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 05/22] ovpn: implement interface
 creation/destruction via netlink
In-Reply-To: <20240304150914.11444-6-antonio@openvpn.net> (Antonio Quartulli's
	message of "Mon, 4 Mar 2024 16:08:56 +0100")
References: <20240304150914.11444-1-antonio@openvpn.net>
	<20240304150914.11444-6-antonio@openvpn.net>
Date: Mon, 25 Mar 2024 16:01:10 +0100
Message-ID: <871q7yz77t.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27225/Mon Mar 25 09:30:27 2024)

Antonio Quartulli <antonio@openvpn.net> writes:

> Allow userspace to create and destroy an interface using netlink
> commands.
>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/netlink.c | 50 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 2e855ce145e7..02b41034f615 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -154,7 +154,57 @@ static void ovpn_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb
>  		dev_put(ovpn->dev);
>  }
>  
> +static int ovpn_nl_new_iface(struct sk_buff *skb, struct genl_info *info)
> +{
> +	enum ovpn_mode mode = OVPN_MODE_P2P;
> +	struct net_device *dev;
> +	char *ifname;
> +	int ret;
> +
> +	if (!info->attrs[OVPN_A_IFNAME])
> +		return -EINVAL;
> +
> +	ifname = nla_data(info->attrs[OVPN_A_IFNAME]);
> +
> +	if (info->attrs[OVPN_A_MODE]) {
> +		mode = nla_get_u8(info->attrs[OVPN_A_MODE]);
> +		netdev_dbg(dev, "%s: setting device (%s) mode: %u\n", __func__, ifname,
> +			   mode);

Maybe print out the message even if the default mode is used, as the
mode is applied in ovpn_iface_create anyways.

/Esben

