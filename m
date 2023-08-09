Return-Path: <netdev+bounces-25819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F82F775E86
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB81C21009
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFF11800C;
	Wed,  9 Aug 2023 12:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DA11C98
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:10:28 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138E11BDA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:10:26 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-iGeVhJ_INwOx6wUxFJOhlQ-1; Wed, 09 Aug 2023 08:10:24 -0400
X-MC-Unique: iGeVhJ_INwOx6wUxFJOhlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F5873811F40;
	Wed,  9 Aug 2023 12:10:24 +0000 (UTC)
Received: from hog (unknown [10.45.224.100])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA9105CC01;
	Wed,  9 Aug 2023 12:10:22 +0000 (UTC)
Date: Wed, 9 Aug 2023 14:10:21 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macsec: use TX SCI as MAC address
Message-ID: <ZNOCLV6NZvzuPeWB@hog>
References: <20230808141429.220830-1-radu-nicolae.pirea@oss.nxp.com>
 <ZNJdo6bow7uK8bTn@hog>
 <b33195b3-aa6d-defa-97c4-280da7e5e6d6@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b33195b3-aa6d-defa-97c4-280da7e5e6d6@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-08-09, 09:37:40 +0300, Radu Pirea (OSS) wrote:
> 
> 
> On 08.08.2023 18:22, Sabrina Dubroca wrote:
> > 2023-08-08, 17:14:29 +0300, Radu Pirea (NXP OSS) wrote:
> > > According to IEEE 802.1AE the SCI comprises the MAC address and the port
> > > identifier.
> > 
> > I don't think the SCI needs to be composed of the actual device's MAC
> > address. 8.2.1 says that the MAC address *can* be used to compose the
> > SCI, but doesn't mandate it.
> I used IEEE 802.1AE-2018 as documentation and the text is slightly
> different. However, the purpose of this patch is not to force this match
> between the MAC address and the SCI, is just to have different MAC addresses
> when the interfaces are created with an specific SCI.
> 
> For example, the following command will not set 00:01:be:be:ef:17 as MAC
> address for the new interface. Would you expect that?
> ip link add link enet_p2 macsec0 type macsec address 00:01:be:be:ef:17 port
> 1 encrypt on

Yes, because "address XXX" comes after "type macsec", so it's an
argument of "type macsec", not of "ip link". IMO the manpage is pretty
clear about this.

The command you want is:

ip link add link enet_p2 macsec0 addr 00:01:be:be:ef:17 type macsec port 1 encrypt on

And with this, I don't think your patch is needed at all. It would
even introduce an undesireable behavior, in case an explicit address
is provided (as in my command example) alongside a full SCI (instead
of just the port).

-- 
Sabrina


