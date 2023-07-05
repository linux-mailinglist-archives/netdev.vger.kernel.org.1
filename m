Return-Path: <netdev+bounces-15633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA40748DEE
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE39D2810F8
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030561549C;
	Wed,  5 Jul 2023 19:34:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ACCDF43
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 19:34:01 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351211737;
	Wed,  5 Jul 2023 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688585579; x=1689190379; i=markus.elfring@web.de;
 bh=k3bEGlJrK3mjEjmZkq0V3z4FQUWYbOJo7qMvrr3hRsc=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=V5XwwkdwBasU6vINzGJ18otyce5FJXUSnPUVi4fT08dWaBNiSwrprWyzJWNWXT83InGndSs
 gA4oGywwOGlJKtHiLHkKcFuh8ClXeqTPyU4Hf5MExYhj0pAcAlqaHjPGcW4LDsF/mtxm5WkPE
 ut9NfHgsadz63cEIi7wsDHiuKeLIfmKBeBEPj4oqrrYWYfvhzo3oCaBFc9ANTCLkrarwTtX6h
 gXyRZn9G3LGwhSzrQ/e109FZrXuqsap3X+Wm1jgzNXlfm8s2CUHxAb3xMqK6hyo/maCoTjJHI
 zeXps7HARIzUxAxqvkiu3573sTau1WJPj+NLAR9tTe3YsWZaP2Gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOha-1qR07D2gJw-00U8zB; Wed, 05
 Jul 2023 21:32:59 +0200
Message-ID: <5e126b18-1b9a-4224-5e02-9ab349e624d9@web.de>
Date: Wed, 5 Jul 2023 21:32:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Wang Ming <machel@vivo.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sunil Goutham <sgoutham@marvell.com>
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>
References: <20230705143507.4120-1-machel@vivo.com>
Subject: Re: [PATCH net v2] net: thunderx: Fix resource leaks in a
 device_for_each_child_node() loop
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230705143507.4120-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gjIYDNaYeYt3NljkaaTd6rOJV1eu4OJwbvypFFA9sjIOYtUzhgh
 utrBGK6zMyAR0VOpMMyAlIXw+oDh7O5k6xzVWyrRbnboKvo3TSXf9Zg2OMMta9WgyIO6amL
 eUO3O/Jl2Ea2tO+D9738YrkaF/onnTF6/SGbYlWm22RZ4qJRz6UDnsZVEP9mPaMhPTGNAp6
 aUL7DwpNOVcMboVOopuCg==
UI-OutboundReport: notjunk:1;M01:P0:T27z7aVsA1U=;ORyrSFDx63jqIWC8vssXUdlA8Lm
 JMlXj7gP9irhWCBlGJ4pJEz4QTNAgzn4c3/vRUbtUsdAbZd7IUWWlADlCruo4iNqynLfpEc6N
 2bu7TWIcUZAcIGn6KBNK4NlZyKnSz+ad0HiJBGxJzMAxrcupYfOzq3x35M7ZXHyQ+ARc7t2G0
 7tZYPxhXbfJkOlq3ljF+dTHGL/1CAqUk9mvQCKRVaCmJZVsYLiQupdkdne2S0DZe3rkuF+cd1
 W9LhlfEd+HQp6HCXfnWuWVmyCqZY3VXJPoFvrzJyttMwgO1dNAO0GDB+13NY7Jmxyrk7sBmYy
 OCwPwhJYStV9ZOQ8ppfVXg4e+2/D+eJ9amWFRJMwdjrf/fwbiKNVrS1y1UE+mg7S/751yDr1z
 fX42+q6w7EhA/FYtmhowM2zPPm+XnENFBHO2OCDZt8mdBD5Gl4hLvds9u82X5nWR8UGOvKgrY
 DLFpE+hNIYRibzs+526oBXNieTmQ3ERbrL6lBoDnunieB8GglWDxOZ5y6jevdo7wt5gQeO8Ga
 wDnXMRD+CfVaYSxtKYiMzicePUhQR85hvcUsK3+InJAz/+H6I9X0uJBryARC9mQaiuuoAvWwO
 1+MmvYwTvpUi9fyGCR69dgTz6WII3xugaiP51PJXKVjY8lEQFtSH6z46yB0bKYolSc2t4x1fV
 gUuHmliBGwGD4GzjcoCkMIBsbUqbSwkWqpZCPuHJPSOkTkCRA3RuwHwma7t1/LP2uGnwYzQQK
 LLG7gz4von76n+Ti1KOE6a3SA93oAypmdxt99bzdt64+cxnz0fzO1ptXLkgRHTh7W/9VHSGq3
 yXJH7UvMUqNKkuFjEYEHjsG9jO2Ugl9EA/X+eE9q7dm6mbgshaVUu9jegQxPbHs4I2lWz4Rqf
 PUcYP4CCtSg6hb6EbwAVtUBqZPwELWdK5BAq4unWVwFrynxen9npMtTVOU90mTUp7pAGMDrQ/
 4BzMdQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The device_for_each_child_node() loop in
> bgx_init_of_phy() function should have
> wnode_handle_put() before break
> which could avoid resource leaks.
> This patch could fix this bug.

Please choose a better imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4#n94


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus

