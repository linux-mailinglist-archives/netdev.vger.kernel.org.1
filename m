Return-Path: <netdev+bounces-291700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDNjFhCjFWprWwcAu9opvQ
	(envelope-from <netdev+bounces-291700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:41:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF405D6B4D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7653230855CB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44F73FE64D;
	Tue, 26 May 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c23KoPgu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jkJ3tsNw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429183F86FE
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802398; cv=none; b=ivDQvlIo9cLhgs93WtVZJwn8zk31ljb6PP0XycJ0ZkvR7s0Voi+kdiCUbUNL69oEz9JzZ2i5xYBYzAi1LQAj3S9txaSKpJ3x82qcfHpZst+AG8OSKF03p9x3aEh5GAWD1OIWOfulUtW/zKIO5CgMPS8Z8bViWV/TMfqewMdqA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802398; c=relaxed/simple;
	bh=RwSgfu+aimDDshn4/Mvmy5847N692TWKcIF/53HFfsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quwA37EMRuvkjvyWP9mAETocmw5ZqFsIqqiVxSPKvQkL3jkBaTNTU1tvmuVh212EW/BtqeG1wZV55tjNJqIWYjikNyk/SkFvqbGaFv2iRuVh9FBpRnsycxZaQyiDVI5j30JmDLaztY7WCrDsSxLnBVgXd3pLRCOqURSZsWxapA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c23KoPgu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jkJ3tsNw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779802396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LySWU6z4ou6sFqqDsgWsKWCcfiqiidI/mEwHVACYugw=;
	b=c23KoPguu2WrhzXj0q9PDo/lq2yGKs9cXpNlrZGI7bGVkquCYY/sD7Wh4k2+YoZGqtKmwu
	S69yjzESB7vzduilVnTlfjQd1Lbkq7OFxkPkvzyqGMCeg28QtUBiWkKoD5bLzxRBXE1dag
	V2Fu4zMaF9C8rYCJ01T1NUx1Xt/uX3A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-zVrpBIPjORqPNHUHkfUsHQ-1; Tue, 26 May 2026 09:33:11 -0400
X-MC-Unique: zVrpBIPjORqPNHUHkfUsHQ-1
X-Mimecast-MFC-AGG-ID: zVrpBIPjORqPNHUHkfUsHQ_1779802390
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49050c44bcdso41593965e9.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779802390; x=1780407190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LySWU6z4ou6sFqqDsgWsKWCcfiqiidI/mEwHVACYugw=;
        b=jkJ3tsNwwKQekizCCJOgHjw7qdCMFFd8XrhancNI1TKv21I8fEGwllmMGeIZMZ9TpH
         I8YNXFp00seBEO3wSVWd37UXuKM7JMzb5sR8sw6rO2F9/Egx1NR0g9kq5kS9Ib5wUHdS
         eFnKsuy7nJ/3PaD1jFVfKXXZMRnjsc13XSiD3boFz/v2Pc3biIDnAKsnTMEahmwh0OVH
         n7fkSvuuwaBxumRf7fe9eGogv6+6JL7iHzjEVmCmAjs+ZW2SF1S2AKfVTjXh+VV8J5xT
         O1xfM2z3EvsWVw+9napwBaJpPmgyABOhdf3gP7LxMt+6jxUPbV4pfj78EsdJ82OsY9MN
         6zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802390; x=1780407190;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LySWU6z4ou6sFqqDsgWsKWCcfiqiidI/mEwHVACYugw=;
        b=oFWEpGx/0egSBIdRPwQkfBSclsvzK5rQUPd/LH4PsBaulrVwqfkyGB/jLXrJsiZ5XT
         24EKF4guEhXoufkpkAJ2OhiCVEMyyERfRpvv3XhO5/palLXYaPuK/3oRgoZsfTwkYmGx
         PrelK8EpdOqpQmT1EJySPXGWHgg12S1UR7vzEOzeF6y1Ycp830sud673R9s/J4el07oK
         tZlWby2UQBB/3e2qu9uaVhrJ592HX9pLHNTkot6VN7pnhj8hb47goiuQ1/qWejdHYHpq
         A0mjdr1FXp1T67E8tc7e1hv+paUqqTt2CbPpfHqKg+grEuIC8XvAKR0mhjbueR+3Psbg
         UVlg==
X-Gm-Message-State: AOJu0YxCBW/O6uqyEoPGNQRCOrCdAxCZx3tyApwLLaOPz60inE1QsPQ5
	o8DE71PwQWkve0AjSl/9xtDdmeoBedUHjXasXTS1MO00v7w0uLj04uGywEnQ2aUrMU0rQMsyT2b
	uSGbJPoTELp4vK++o3AjkenuajJb74rHclzT/FDx8RnKoVkuWBD61ejmEyg==
X-Gm-Gg: Acq92OENVVYfcw4a1dYkYz/NhEN5Q49SjeJT3xwHd1puhvhHShACXHyO2/Y8XTmlg9q
	+Yrhhg0xDhjE+gjNW3gmtiSrZm/rdquOHPvR1u2Cp+PmocQKVyWipLV1O/jsTBckqpD4kPGr5P9
	WIW0cZAaCuL7Uhz2Ka4BHvPxJMvdZJoJpC9azfui0srykSlPLXdPLFxyNsfuMf4k+pMnfkPQ7MU
	00l/XAKmw2OoI3rTM5uHnAgzFh5xAL6QSy4BYJgSDsntKuhPwvPnCtvvgfzCj70b0l8eeijQofK
	q5mrGyBYKnE2tjC2/zx7CGSlKzfvDNw+irdW2k2QbsfsPcshvPuvwgtk6A2SkYzckY6u/nlhiHZ
	nKpbwHbvLrct5OGOYfnaZI90WlsQhJeLGsLPy3lBcjqVbIhPp0ksql8JMDw==
X-Received: by 2002:a05:600c:3b0a:b0:490:60cb:560b with SMTP id 5b1f17b1804b1-49060cb57b1mr182636305e9.28.1779802390046;
        Tue, 26 May 2026 06:33:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0a:b0:490:60cb:560b with SMTP id 5b1f17b1804b1-49060cb57b1mr182635215e9.28.1779802389499;
        Tue, 26 May 2026 06:33:09 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428e6d68sm112189255e9.22.2026.05.26.06.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:33:08 -0700 (PDT)
Message-ID: <a387630f-6954-4d21-bde1-68773d1228e7@redhat.com>
Date: Tue, 26 May 2026 15:33:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
To: Linus Walleij <linusw@kernel.org>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org>
 <20260522-ks8995-to-ksz8-v2-3-5712c0dc9e75@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260522-ks8995-to-ksz8-v2-3-5712c0dc9e75@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291700-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,denx.de,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ECF405D6B4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 3:21 PM, Linus Walleij wrote:
> The KS8995 100Mbit switch can do proper DSA per-port tagging
> with the proper set-up. This adds the code to handle ingress
> and egress KS8995 tags.
> 
> The tag is a modified 0x8100 ethertype tag where a bit in the
> last nybble is set for each target port.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Does not apply cleanly to net-next, please rebase and resend.

> +static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	int portmask;
> +	u16 etype;
> +
> +	/* We are expecting all received packets to have a mangled VLAN
> +	 * TPID, so drop anything else. Because of the non-standard TPID,
> +	 * don't even bother looking for a tag in the hwaccel area.
> +	 *
> +	 * We have to inspect the ethertype directly because skb->protocol
> +	 * will contain garbage.
> +	 */
> +	etype = ntohs(*(__be16 *)dsa_etype_header_pos_rx(skb));
> +	if ((etype & KS8995M_STPID_STD) != ETH_P_8021Q) {
> +		netdev_info(dev, "%s: dropped ethertype 0x%04x\n",
> +			    __func__, etype);

While at it, please avoid printk that could be triggered on each
incoming packet.

/P


