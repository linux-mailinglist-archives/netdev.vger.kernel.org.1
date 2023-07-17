Return-Path: <netdev+bounces-18265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6651756199
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CAE2812E7
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2810AD2E;
	Mon, 17 Jul 2023 11:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B8AD2D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:30:19 +0000 (UTC)
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 04:30:18 PDT
Received: from mail.aperture-lab.de (mail.aperture-lab.de [IPv6:2a01:4f8:c2c:665b::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A4AE4E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 04:30:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E19084199E;
	Mon, 17 Jul 2023 13:22:03 +0200 (CEST)
Date: Mon, 17 Jul 2023 13:22:03 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, netfilter@vger.kernel.org
Subject: skb->mark not cleared for MLDv2 Reports? (skb->mark == 212 / 0xd4)
Message-ID: <ZLUkWyFiwEqi721V@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I noticed that MLDv2 Reports don't seem to have a default
skb->mark of 0. Instead it is 212 / 0xd4 for me:

```
$ ip link add dummy0 type dummy
$ ip link set up dummy0 arp on
$ ip6tables -I INPUT -i dummy0 -j LOG --log-ip-options
[ send an MLDv2 Query, for instance via the ipv6toolkit
  https://github.com/T-X/ipv6toolkit/tree/pr-mldq6-mldv2
]
$ dmesg
...
[38336.524879] IN= OUT=dummy0 SRC=fe80:0000:0000:0000:1c01:1cff:fec1:5669 DST=ff02:0000:0000:0000:0000:0000:0000:0016 LEN=76 TC=0 HOPLIMIT=1 FLOWLBL=0 OPT ( ) PROTO=ICMPv6 TYPE=143 CODE=0 MARK=0xd4
...
```

For MLDv1 Reports I don't see this issue, there it's always
0 by default.

I'm wondering if this 212 value comes from the
skb->reserved_tailroom (formerly avail_size) which the skb->mark
is unioned with? Am I reading
a21d45726a ("tcp: avoid order-1 allocations on wifi and tx path")
correctly that the IPv6 stack should have reset skb->mark to 0
before transmission?

Initially observed on a Linux 5.10.184. But I can reproduce
this on a Linux 6.3.7, too.

Regards, Linus

