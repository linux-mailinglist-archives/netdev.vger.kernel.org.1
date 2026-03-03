Return-Path: <netdev+bounces-263305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N3+HJgJp2kDcgAAu9opvQ
	(envelope-from <netdev+bounces-263305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:17:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F71F37C8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDB3C3065163
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A894B8DFC;
	Tue,  3 Mar 2026 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBM61BXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237A4ADDAE
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554316; cv=none; b=buzsKIxKtmt+v1ux18MlEqlen8mNmd1jea76ruX7urd0YiM9uCUYFOqyIGDKamvQkiISldKtQDek7ZlBhs/5jCUVoaMRnblqCu8XAw0mfdkKbEKe4HL10qH2UMpGU9Kkw/j4LRQEQPsFTsmC1Tltj0xRwDkRNCWJtmEx+UHW1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554316; c=relaxed/simple;
	bh=N5wngUdyded7KLhNkbgdzRFgxGMoyVrZJXhVV1uEP6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grAQQNcy2pBuYLQZ1GIk4ol4kj39N22yBr51SGm1qfu483wnGa7uFXhfMxQDCX5JjBgnVIP8sojScKluHfSmO5+gLF4RnELYQ/ti4nMTa/s/kyqjBnm+DBpnt/+vUTf2WhSzEeeIvieRH2F54RA8V2n1Lf+TAZlO1oT+B2mF9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBM61BXf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so5631265e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 08:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772554312; x=1773159112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NDQRso0/6pRmOjXwAwr8jsWZ+364LBr9GQ56Vp8aC/g=;
        b=eBM61BXfnbJy0UckVUXOhCU2cReA5ZyEYx5F5QGZ2cAyVYWVbHrvCfDJmiMczJbf8b
         NyWvVsi4rBQgvwgHpv+e0O09JH0IIexCE84OsL6MzdMn+5YDdFiBI3cdqSOhBx6cRWC3
         OTbkzdvZ8yXQUAjZkyphKXAxGGPidCwqlkcama0rYPC8ggaavExNYgg7u6BMyYE5pPK2
         DP8amZtMEYd2hExifoU8raYbR3AGZOIXBCrRNyuCUYb9QsTWOiUR1jiGhMif22QinGhu
         Awz5C2MqAIScdwaz2T4p4p1dprxkc29ZQFhnZlF7KIAin/5+F245He5ikHsL/LDg/EhV
         ZCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772554312; x=1773159112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDQRso0/6pRmOjXwAwr8jsWZ+364LBr9GQ56Vp8aC/g=;
        b=HE8IwNMZcGxKCmugqOLXFyzJCarsSC7eiO5u1eeQuYeS3kYeu9Al3nU8s1iQSoFlWS
         y7V4ilcjxIc2jXU3efTbFI6QL0bNTDLYEJC4czkP4YwYiSqXeQk7uYXYVt2h2X722fIC
         9ot5UpkCOZnvK4OpY1LnF6LwGft7D7mwvd+NYTycxtjUAcbIwWZjLTF1of346uRrCMDj
         cM0cDhcEvsKPlxVfrXybsqO2dx2xK0DhQ8KzZVbZkyptqfXPf5GJ42AZy7un0N3jz08k
         zagGymH9oKbBr77XNJ2OmW32gSipTXIINiPd8Gue6fTcdKtLiszAFhEHtmWmWlpFjHOE
         ibpw==
X-Forwarded-Encrypted: i=1; AJvYcCX+1a4oDa6AhJTdRPJ4v1ch/9EoHCMdraDDIKvDZPA4igN6qN1UshT4Q95iUQD3f8JxHRAXLEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrYjdDv6k77kASpQv6I8+Juj0mYqoKA6sl+Ic/6+FU9NHpmAS
	/2X1xCSL/jOc7f5Gbx4mmX4HdYtw6ajYvQYhUWnG2BRIqq/iBYYmcPrrmJgB/Q==
X-Gm-Gg: ATEYQzzxSX7eeFjS9bfWFvQeQz8Qj6uZxHy7rJXA7iRvaCalgEmaKKh8IBgAx3CLsvE
	FJ9aCoBYIHW9iQKBmOBvOVA7adfMj/IOJief9EzreU7zTNF1op00QgJQdOzfY36WZcf3t7Y7Ovm
	w+KwG3qdFDVXI/kXJgycLKjHtkwsxGOyZvcXUJQQtDKR8RcOTZbc1eszvmiFA+fm9QPTG1UI9wV
	M12FYGSFA4qWJfo+lXKwjTruyczvX3lIes7krKAEIfwDaNIVJCLMZY+17JZY+CIN9KupGV4PtVs
	pECuDAMmqX8z4DkMuVLib12b4n83HmpUiEtLp/JTgKrZfqGR61nrsjbOtt7uV3XabrKIDUVysvT
	sgoLVfcCwoRzHPj3Z+3LfKjHppIVJvOD6k4gpkdfeZSLBtMgbXdMABPDUBJe29PedwjxA1eT0gc
	PwclcpaOJOL+62bRk=
X-Received: by 2002:a05:600c:34d0:b0:47b:d992:601e with SMTP id 5b1f17b1804b1-483c9ba712emr179672085e9.2.1772554311582;
        Tue, 03 Mar 2026 08:11:51 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:2472:8e4a:cf12:bb30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm23197781f8f.16.2026.03.03.08.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 08:11:50 -0800 (PST)
Date: Tue, 3 Mar 2026 18:11:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] net: dsa: add tag driver for LAN9645X
Message-ID: <20260303161147.bgbltslwrl2gtd7p@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: E24F71F37C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263305-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 01:22:27PM +0100, Jens Emil Schulz Østergaard wrote:
> Use long prefix on extraction (RX) and no prefix on injection (TX). A
> long prefix on extraction helps get through the conduit port on host
> side, since it will see a broadcast MAC.
(...)
> The format can be configured asymmetrically on RX and TX.

Do you foresee a need to configure the prefix length? It would be
possible to do that by changing the tagging protocol. But it implies
that the "lan9645x" string as found in /sys/class/net/.../dsa/tagging
becomes user ABI that is set in stone. It will mean long extraction
prefix and no injection prefix. Otherwise user space will get very
confused (libpcap, XDP, whatever else might get written).

> +static inline u32 lan9645x_ifh_get(const u8 *ifh, size_t pos, size_t length)
> +{
> +	size_t end = (pos + length) - 1;
> +	size_t start_u8 = pos >> 3;
> +	size_t end_u8 = end >> 3;
> +	size_t end_rem = end & 0x7;
> +	size_t pos_rem = pos & 0x7;
> +	u8 end_mask, start_mask;
> +	const u8 *ptr;
> +	u32 val;
> +
> +	end_mask = BTM_MSK(end_rem);
> +	start_mask = TOP_MSK(pos_rem);
> +
> +	ptr = &ifh[LAN9645X_IFH_LEN - 1 - end_u8];
> +
> +	if (end_u8 == start_u8)
> +		return (*ptr & end_mask & start_mask) >> pos_rem;
> +
> +	val = *ptr++ & end_mask;
> +
> +	for (size_t j = 1; j < end_u8 - start_u8; j++)
> +		val = val << 8 | *ptr++;
> +
> +	return val << (8 - pos_rem) | (*ptr & start_mask) >> pos_rem;
> +}

If performance isn't a huge concern, pack() and unpack() certainly seem
simpler than having your own implementation.

> +
> +static inline void lan9645x_xmit_get_vlan_info(struct sk_buff *skb,
> +					       struct net_device *br,
> +					       u32 *vlan_tci, u32 *tag_type)
> +{
> +	struct vlan_ethhdr *hdr;
> +	u16 proto, tci;
> +
> +	if (!br || !br_vlan_enabled(br)) {
> +		*vlan_tci = 0;
> +		*tag_type = LAN9645X_IFH_TAG_TYPE_C;
> +		return;
> +	}
> +
> +	hdr = (struct vlan_ethhdr *)skb_mac_header(skb);
> +	br_vlan_get_proto(br, &proto);
> +
> +	if (ntohs(hdr->h_vlan_proto) == proto) {
> +		vlan_remove_tag(skb, &tci);
> +		*vlan_tci = tci;
> +	} else {
> +		rcu_read_lock();
> +		br_vlan_get_pvid_rcu(br, &tci);
> +		rcu_read_unlock();
> +		*vlan_tci = tci;
> +	}
> +
> +	*tag_type = (proto != ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
> +					     LAN9645X_IFH_TAG_TYPE_C;
> +}
> +
> +#endif /* _NET_DSA_TAG_LAN9645X_H_ */

Why do these need to live in a separate include file? Who else needs
access to them other than the tagger?

> +static const struct dsa_device_ops lan9645x_netdev_ops = {
> +	.name = LAN9645X_NAME,
> +	.proto = DSA_TAG_PROTO_LAN9645X,
> +	.xmit = lan9645x_xmit,
> +	.rcv = lan9645x_rcv,
> +	.needed_headroom = LAN9645X_TOTAL_TAG_LEN,
> +	.promisc_on_conduit = false,

Initializing with false is unnecessary.

> +};
> +
> +MODULE_DESCRIPTION("DSA tag driver for LAN9645x family of switches, using NPI port");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_LAN9645X, LAN9645X_NAME);
> +
> +module_dsa_tag_driver(lan9645x_netdev_ops);
> 
> -- 
> 2.52.0
> 

