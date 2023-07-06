Return-Path: <netdev+bounces-15773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFF9749B19
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 13:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8A01C20CAB
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8148C0F;
	Thu,  6 Jul 2023 11:46:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35198C04
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 11:46:49 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E6519A0;
	Thu,  6 Jul 2023 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688643981; x=1689248781; i=markus.elfring@web.de;
 bh=gOOTa6FzD2bMCZlUgCtKjK+xwMpZyC1TTseIiI/4Wvk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=b7onGs2Q6JZhD6aB3uul7Q7UOPF5eEym4zHS0E94OU4UC85nokrtWNmK52L1E7ksaii/Py7
 npfTZsgrO4iOCekfDnJfPzOWxBCnHVFd4jtelmoYtz2svu9xKlfBRg2bwYfGadz+FrDFWOiHS
 AxpdEinK6vwrksITtp0TDD07+ovmovkrA9/f2PwsTz/dvslJDLz0Qc7Yc5I5NOgcF9hVIAopR
 N4qvWcpGeY/YUl7BUm8mwy6ADkPcog2o9BU4CpuFbGhVCwbovMLASDkIcWMfb5tEeCXbYQz+s
 3ezSHx8M0shKXp9+89JIjpxH5LhiDM9egi2C6ZHPbFPuZKvCj/Ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGWe-1q7zmp1OiY-009UwO; Thu, 06
 Jul 2023 13:46:21 +0200
Message-ID: <61b8ffa3-06e3-ce37-b9ac-0d758b27315d@web.de>
Date: Thu, 6 Jul 2023 13:46:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: net: thunderx: Fix resource leaks in a
 device_for_each_child_node() loop
Content-Language: en-GB
To: =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>,
 opensource.kernel@vivo.com, kernel-janitors@vger.kernel.org
Cc: netdev@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sunil Goutham <sgoutham@marvell.com>, LKML <linux-kernel@vger.kernel.org>
References: <20230705143507.4120-1-machel@vivo.com>
 <5e126b18-1b9a-4224-5e02-9ab349e624d9@web.de>
 <SG2PR06MB374317EA994C668A699A9CB0BD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SG2PR06MB374317EA994C668A699A9CB0BD2CA@SG2PR06MB3743.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0AyVT94SQJN4JlWHEICHIqjS3hxQKsRCXk613aWXVVTwVaiTdMb
 Q3vA7w8OJ+uDO9Fp7UfM3cSD0K5S8ciC3ELGTARmVHz4irXIhW21rhBLoqhEjur4QVudhLb
 Wadcwo5u03kBTJdk2pdRspUoSTNxU0WYniV+3cRrISiESPvqyQCK7kd0+qULwmg4RPmhcUu
 o/C8JmR3dEGiGgnDsHCqQ==
UI-OutboundReport: notjunk:1;M01:P0:tPd5yCf4ApI=;T5KL6fchcbfkwXcDv/9SfsqCYj2
 bkAkxMzz53ZZgleWRCK5nmSrEX1lGUsvzIZB2kKvKwc95uHDI9SdCVSnFg34GSZI6lcJ6Gcop
 nbhShnXsKoL01KvpkVK2mD5mRozpgn8VZuetRvLI9hWuRxNafgRKkoZNwj2mAUtXFNoxoPaCD
 Pdt8VgxRT/kj/Sj6RVQP9v1pfmJzV7SvZX9SdKQa1wf7wTwwIbxN/fsEQAd7aop8zFgyGDKR4
 QpiwSEy1cKNjg3B79fWoXDN++j5K7CN2xNL/49yaLWgE4KKqgMjzFgr/QqdZ8/zNXLZ6I+so3
 VIc/ZVvcJ+7huDpdXaJT9m18iJHneJWjsZurve2pHDtHy7tNlzsTJv5VJPiGBACsRE4fqB8+v
 r6+ErzxgOc2JTziKF6Pp221j2gOX6osKJEWblEYi4qbrTI+4pcYerr3kFxSISzLN4rw0mFeBz
 541GFve7za24gq/xQfQA8Gv7+G1kWA13PHCu0dT6Vc2DK7zAiU48QU5Hcy893Ry0BY2zMBDii
 nwrqRLo2XV9Bh0OO81s9xtxq5spsXYjItTwq9WjpwZrpCrvz9Sxopvjf67plJIWFgZIcsqV7K
 pjmsytoqlNlM2BfITF/DQjF0B+VKu0Dzt6/0CpwpcSR4MEzdNyuizNdUVdlPzyQlouPm0DFlC
 ObxXRU6luplpPafS/bVUEs/El5AAWcE7j0bnR4WZmo2l7hLgq/RLA/AEVfof2yO+AKzImF1Ke
 /SPvtn6umOo/Sp6HdjikIpuQFnRmHDxA04Uzbnl7gNOlQZPi5VsXTNwrwCk1mwxeUMtwQDsSt
 kwMhiE/84FMkHdNDzGo5I67M9hxdp5n4uKiMw3tyKU0lusHByW37FFk79A2nAtIi4X0P4uq/R
 Uv/N50Q5WdAwXyghSfNk2GogPrI8lrHnnC5DOdinCdiZ6Q53G22ffLbJswQBE+9IIibYRPzuY
 2AN2vg==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Can you help me make a template to improve the wording?

I (and other contributors) are trying for a while.


> I have little experience in this area.

How will your experiences grow according to linked development documentation
and further information from patch reviews?

Regards,
Markus

