Return-Path: <netdev+bounces-57965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B46814990
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40911F20FDA
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349B12DB8B;
	Fri, 15 Dec 2023 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yduuj1Pm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B202F867
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-552231d9c1dso933700a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 05:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702647951; x=1703252751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82+m4KyiroxK/g2Gn+mB4vVVhqv+6JG06IJNpqJ+0Bc=;
        b=Yduuj1PmQFF0PQOo1JGmfgT0Gyh0KCJbAFUUm/US1rDXtqTD+HDbVwMvaHc5mu51r6
         QWmXMAKaImN/lLhn/Pic8zbcmLMYQCO16IvjGAs/i16VIlbzsJZLp42irV7JOYAsxMIJ
         nTZa7C0ncXkQ+H70GtpOMrhDkhQsDldA8MDODJueteE5V0sslUCET2Mcg002IcF/UHvx
         g0EU2QjA9sdC72BdtROpAdRy752K4vrgduQdzjCnhVhpG349tneb4At7dCWNrbTgY69T
         AGeswrCrjjNO8C1eCvVrPofojEx2+UV16FihutwIzspW5b+2tjnOhMHh2zy7t6bPG7k6
         WwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702647951; x=1703252751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82+m4KyiroxK/g2Gn+mB4vVVhqv+6JG06IJNpqJ+0Bc=;
        b=urVYq9DgfiwVyJ9iaS0hYydVuEzw0Z51TIeJjHTavyRoN8g3RyOY9t0jvdeZdk/XJS
         JzZWTq2DLOfyBWKWOWh8Z0O9rKxj5uIVGfUujSgejjHxj0COi4XEc6mzJCE7E7PGJcN8
         CwSoSp4GJRhKb3I9RkRs7hOK9hT3k57Jh/k77m6g/U2jelJSyKyQkHbNj7vZHjdj/rUm
         yk/ZYPRbWSPDyx45nsYA4Us3yvYmgg/LwYsGQgKHdcmPQ9Vc3hKDulcXoqnyWExz0321
         nmkfWvLfAFc1ZLMsMfglTuUxpJHyXI/6TESQN0urDCaAiE04+uUsOI84MSlohInMqb/j
         3ITg==
X-Gm-Message-State: AOJu0Yw8hAH0EOHpGDkrDSH5D+rGuK1kr0w0j41es5sOMW15lsfTR1ge
	bevajAdqTBqj1NBM3ekGZJU=
X-Google-Smtp-Source: AGHT+IEqrjFdsdoMGbY4ZaQ4MBcclNtHN9Uy0OYKCfRO+6TxN2qDuqnl2LbhDaax5IdNz5VPTjxt3A==
X-Received: by 2002:a50:d6d3:0:b0:552:23c6:41ec with SMTP id l19-20020a50d6d3000000b0055223c641ecmr2281158edj.70.1702647950563;
        Fri, 15 Dec 2023 05:45:50 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id v19-20020a50d093000000b00551f0189764sm3019853edd.58.2023.12.15.05.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:45:50 -0800 (PST)
Date: Fri, 15 Dec 2023 15:45:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Corinna Vinschen <vinschen@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: DSA tags seem to break checksum offloading on DWMAC100
Message-ID: <20231215134547.2f5jjdlwzrz3p4z5@skbuf>
References: <c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com>
 <e431c74f-5f83-4fb8-8246-a0f447a24596@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e431c74f-5f83-4fb8-8246-a0f447a24596@lunn.ch>

On Fri, Dec 15, 2023 at 11:30:47AM +0100, Andrew Lunn wrote:
> > So it seems like a solution is needed to prevent checksum offloading by Ethernet
> > drivers when DSA tags are in used. I'm not sure how this would be done, since
> > DSA is purposefully kept quite separate from CPU port drivers. What are your
> > thoughts on this?
> 
> It is not as simple as that, because some Ethernet drivers do know how
> to correctly calculate checksums when there is a DSA
> header. e.g. Marvell and Broadcom devices can do this, when combined
> with Marvell/Broadcom switches. I don't know how the Broadcom driver
> does this, but on the Marvell Ethernet drivers, there is a value you
> set in the transmit descriptor to indicate how big the headers are
> before the IP header. Its normally used to skip over the VLAN tag, but
> it can also be used to skip over the DSA header.
> 
> So i would suggest you look at the data sheet and see if there is
> anything similar, a way to tell the hardware where the IP header
> actually is in the frame. If you can do that, you can then actually
> make use of the hardware checksum, rather than disable it.
> 
>      Andrew

There's a chance that the DWMAC cannot be told what is the offset of the
IP header - it finds it by itself. Looking at DWMAC documentation for
the TDES3_CHECKSUM_INSERTION_SHIFT bit, it seems to me that this is the
case. Table "Transmit Checksum Offload Engine Functions for Different
Packet Types" also describes for which packet types this will work, and
for which it won't. My guess is that the DWMAC would classify DSA-tagged
packets as "Non-IPv4 or IPv6 packet", but they need checksums for the
inner transport layer nonetheless. I think that transport checksumming
of IP over IP tunnels is also broken, because stmmac says to the stack
it will checksum them, but this table says it won't.

We say this in Documentation/networking/dsa/dsa.rst:

  If the DSA conduit driver still uses the legacy NETIF_F_IP_CSUM or
  NETIF_F_IPV6_CSUM in vlan_features, the offload might only work if the
  offload hardware already expects that specific tag (perhaps due to
  matching vendors). DSA user ports inherit those flags from the
  conduit, and it is up to the driver to correctly fall back to software
  checksum when the IP header is not where the hardware expects. If that
  check is ineffective, the packets might go to the network without a
  proper checksum (the checksum field will have the pseudo IP header
  sum).

TL;DR: the simplest fix would be to revert commit 6b2c6e4a938f ("net:
stmmac: propagate feature flags to vlan") in 'net', and rework
stmmac_xmit() in 'net-next' to only use csum_insertion for those packets
where it will work, and fall back to skb_checksum_help() otherwise.
The existing check with coe_unsupported per TX queue is insufficient.

