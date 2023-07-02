Return-Path: <netdev+bounces-15005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DDB744EBD
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE31C2083F
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1303C20;
	Sun,  2 Jul 2023 17:24:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037F210B
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 17:24:45 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2CDC;
	Sun,  2 Jul 2023 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688318654; x=1688923454; i=markus.elfring@web.de;
 bh=3VZC/lv0zKGCoTmPiEW1r77DIODGvRNRvTVWKJx55CM=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=lcWhT4Oo8i8VAyJnHr1GoBD9s9cdFBcv/FnEwYKhHtsgSyH1vtanSDwJy76GOFgkdnjFcKK
 B4yetPnH/VyUm6G1tuNDVIogD2Opq/QbrhG/rBU++ZgK2TM/qn1rAHkzGEiPexl9HvkDPe8qS
 3bdxXkRlv+NklNT2o/p51DKqNRPmiCS77f8dCv6ItMZZ6FHBhMEuh45yd/kxxgB1cCI/RmF+I
 3qLGHZ9DVbqFOSPtwaajVWOzyzZ1UJnwXYXbwkyfw1BgN44B+T3QIB+jdwOFeQHckZPRKnr5j
 34va/DjCRFhYaXMKBvcE27WKcdspOoVkemsmjTRwJobOD5PFWkfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElVH-1qE2ib2zYR-00GMvE; Sun, 02
 Jul 2023 19:24:14 +0200
Message-ID: <e1ff4ee2-01a6-8ed6-325e-1aa2d289faf6@web.de>
Date: Sun, 2 Jul 2023 19:24:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Florian Kauer <florian.kauer@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>,
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Tan Tee Min <tee.min.tan@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230619100858.116286-7-florian.kauer@linutronix.de>
Subject: Re: [PATCH net v2 6/6] igc: Fix inserting of empty frame for
 launchtime
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230619100858.116286-7-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+SN9Tr9ojAOvi05wXOQTAWeCqM6uOpXlnGUZ+GTDH+jFpDKH23z
 VpZdfUHiplOjpApxo3G+X7uTJZoNw5xqv81rmipcjYop40m+JR42n89pIF+yComHX48O/li
 bsA5c2/yKyo50PHiFdiFS0SUMQHvJK/FRo99Wxw9mSJKKe893Kl1AyQXJOCDuKdo6VB64XK
 TdqaGf47lKk23mfY6msFA==
UI-OutboundReport: notjunk:1;M01:P0:FLexxRKUzNA=;s6AwRy9e8hIJdm4ItsjxqApm8d3
 W2HpRqoqO1CrOxTU6KT/M3FjM2UfZ8+ze7NaBxPGKHDiFA/aaRBlosz6WrmSI2aOdNuIPw9Vj
 dxFHYXD4O+ssCVxrbZeWC8q7gg2/FaIK/bvkeBSAGCXFboMTiYoUsyT5hmK9mi+IkkQFiVA5S
 B7ewgTAyhLgnH9LH7C+vp08SQp7Xf5YgqTRyPIwNVTa9gPoLXz9IyDtKFWzj1YeWmkx1edmV2
 1wHBRvu4OP59Td7qisf7XmCE3rECzCzc5XjBIIzuaYx2v6IEtoV1vzzShvc8CyLDr3jjxSMEU
 eivUb52p+EaNj/QLcXHpcW+I/iqNphUlm9F9/cZzGF1oDaNKY/A1finasosA75aEl3GRnon6S
 DCRYLg0kI+UDrEE9p+MEPGGOsaxBgLTa6J6u+j1kNQkEl4iEcon0oF5LRp6zmTNiCgiZUes63
 wmnvgUbGO6rz3/OFvpITEPRUIlCM060JwqqSkgdk7yKSYVL2KXXT+rfhBvBpvptjafW1iLWhw
 HeiMq+IzOu8+FHkXcN36DJSgTpzIry2umkZaLB3asb2DGS3mMuDb5t3sJdDkTgjsDn9GeyuSc
 dKfA83lxoZgNz0VYqpGpv1n7NCznQNRbHYLQ8cfa5d80b/Un9NFKz84Z6UmgAFn6j6nBR5Nyq
 RLPoxnOqJUoxIeotAXDiYFO5NIpTO+C3aU97wEMI2KH9Hp+usQNYgL9abCRh+IVGSPHDR0qHj
 1izcF+4qSawoE8Z+PJf9+78T33rfHdPdidTFuQDe2jkAAhnX9BRDIW4lzpuJ0fVgD4Y3zpiVi
 ZnOwrlIaoKZBeH6cuan3tdV1xOg5spdRh83SAH/JD30nT1OHSnrDxSICa/KcbozqWViDQD8IB
 IPFMgAma2lPaPnvTPtQ5ipqxPIRe4xRn+tVJie4XFmOSaXsPqNqKABq/lV+1LLSx/92LQz5BN
 cNgMmg==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

=E2=80=A6
> This patch does not only avoid an unnecessary insertion, =E2=80=A6

Would another imperative change suggestion become more desirable here?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4#n94

Regards,
Markus

