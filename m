Return-Path: <netdev+bounces-32473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD9797BF2
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E51C1C20C03
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6C12B85;
	Thu,  7 Sep 2023 18:33:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1681400D
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:33:25 +0000 (UTC)
X-Greylist: delayed 1536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 11:33:03 PDT
Received: from rtits2.realtek.com.tw (211-75-126-66.hinet-ip.hinet.net [211.75.126.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56D5F1BE6;
	Thu,  7 Sep 2023 11:33:02 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3877GN1m8002884, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3877GN1m8002884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Sep 2023 15:16:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 7 Sep 2023 15:16:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 7 Sep 2023 15:16:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Thu, 7 Sep 2023 15:16:50 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH net v2] r8152: avoid the driver drops a lot of packets
Thread-Topic: [PATCH net v2] r8152: avoid the driver drops a lot of packets
Thread-Index: AQHZ4G/uLCHLeDMawES5jAj/REiJSrAN/YuAgADpM2A=
Date: Thu, 7 Sep 2023 07:16:50 +0000
Message-ID: <7f8b32a91f5849c99609f78520b23535@realtek.com>
References: <20230906031148.16774-421-nic_swsd@realtek.com>
 <20230906172847.2b3b749a@kernel.org>
In-Reply-To: <20230906172847.2b3b749a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, September 7, 2023 8:29 AM
[...]
> Good to see that you can repro the problem.

I don't reproduce the problem. I just find some information about it.

> Before we tweak the heuristics let's make sure rx_bottom() behaves
> correctly. Could you make sure that
>  - we don't perform _any_ rx processing when budget is 0
>    (see the NAPI documentation under Documentation/networking)

The work_done would be 0, and napi_complete_done() wouldn't be called.
However, skb_queue_len(&tp->rx_queue) may be increased. I think it is
not acceptable, right?

>  - finish the current aggregate even if budget run out, return
>    work_done =3D budget in that case.
>    With this change the rx_queue thing should be gone completely.

Excuse me. I don't understand this part. I know that when the packets are
more than budget, the maximum packets which could be handled is budget.
That is, return work_done =3D budget. However, the extra packets would be q=
ueued
to rx_queue. I don't understand what you mean about " the rx_queue thing
should be gone completely". I think the current driver would return
work_done =3D budget, and queue the other packets. I don't sure what you
want me to change.

>  - instead of copying the head use napi_get_frags() + napi_gro_frags()
>    it gives you an skb, you just attach the page to it as a frag and
>    hand it back to GRO. This makes sure you never pull data into head
>    rather than just headers.

I would study about them. Thanks.

Should I include above changes for this patch?
I think I have to submit another patches for above.

> Please share the performance results with those changes.

I couldn't reproduce the problem, so I couldn't provide the result
with the differences.


Best Regards,
Hayes


