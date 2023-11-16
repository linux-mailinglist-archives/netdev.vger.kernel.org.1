Return-Path: <netdev+bounces-48478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A767EE846
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B264281022
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 20:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDEB4644E;
	Thu, 16 Nov 2023 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Tf25lBEF"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0932126;
	Thu, 16 Nov 2023 12:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700166287; x=1700771087; i=markus.elfring@web.de;
	bh=bMIHg3ng5KpBsFUPYXabL+iRStRao71P9CiqdQ1Rh04=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Tf25lBEF3cfVAGakvgsCXjsaRCNAGPbuTpwCN/7hXT3kDMm3PVKzUjRVkS7IhS8J
	 2nxl2ugHjXXtNB/rsOxhBdoXZ5FNwS0I5hgC/ss2ydSfquWJI5wLZqfHRJULeceH8
	 aOjGcRXQse9opN4SSCDGsgEtsf6i/BQfQcEsmFRjVj4GfEsmhYDPmV5W2ARx8TBou
	 A9KSqWchYUBwi6X0JWDysSs9FsDv/xQbjthCFOWmu+rrwywy9rIHGElcyhpOn6b15
	 xafyG0aVx4tLN43/wxXZv4TUQ1U+1SsHxa4n5JZsN7HD8/y5OpBAkLCf/UcrF06fs
	 2QTrGt+/VPsT00061A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTvvy-1quGkf27cY-00R9fk; Thu, 16
 Nov 2023 21:24:47 +0100
Message-ID: <35a52379-5b97-46d4-be0f-1eca6d780a40@web.de>
Date: Thu, 16 Nov 2023 21:24:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: bcmasp: Use common error handling code in
 bcmasp_probe()
Content-Language: en-GB
To: Justin Chen <justin.chen@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Wojciech Drewek
 <wojciech.drewek@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr, Simon Horman <horms@kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
 <20231106145806.669875f4@kernel.org>
 <dce77105-47ab-4ec7-8d46-b983c630dad8@web.de>
 <CALSSxFYRgPwEq+QhCOYPqrtae8RvL=jTOcz4mk3vbe+Fc0QwbQ@mail.gmail.com>
 <4053e838-e5cf-4450-8067-21bdec989d1b@broadcom.com>
 <38279cb8-ff60-427e-ae9f-5f973955ffa6@web.de>
 <CALSSxFYBhv==pJTme0FThxP9JBJszsj1v4G2s-HGzkaevbyvBA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CALSSxFYBhv==pJTme0FThxP9JBJszsj1v4G2s-HGzkaevbyvBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OIrOzr2zLfCRBOWIhQDkoUbk+8mTHFjp4JI5w2O+y8lMchJi4zR
 B87iRZrxV12DjNwGuQclyM0vTDc3Zru04L/rLTyiXZbYfVdaHUydVKTqvT5BFtO3DJn+tkU
 nskTWsmgVIbdmu3BSqPbKLWRdklp5cg03fmcQcJ/0YursqXGt3+Xx9ASV0eppbCRIhMGhqQ
 0S+rgQwV75GIT7OBWmTUA==
UI-OutboundReport: notjunk:1;M01:P0:D3poQ9YnxXs=;p0nk9N6WT8E78LvSQ+rgoMR7w7t
 iSzHmeCenjnd935HxWsY4EqFNWT5SGOjfGtTenGc4De/30U+HbKtpBpFE5wrGpAb1RxugEqOM
 9D5utGHxkvXQxZMw6tMcfRxbbJRgOpom7FIbunoYUgpESgyw7fYUud0x/kz4Yr8qtpfilazp6
 QgCygDjMnI+IuxILUJbS7BZahWZsarylf3W7lJOT1NOHcKiymm9xXtJs7WCvh5c0c5hX02ikO
 4oXVKv9jKX90FUsXpJdGJyBYl0vjgjCOUSf20/SttdZYSxeVOgRNONByVBXGKDEqo98VXAP49
 0d+ykKMLsXTVE/0rrAWPOkB2xkpF3xUJ3DrT4EcPFqFxhCvobZ6kQiYHk06y1lvsai5l18kKE
 jNOpFC3cXyLrU6LiBEnt1Dz1hAZCD4hP+ExQDbEmb+vR7CK4P6NwTTSSCtCIEfu9tBuNy9TEN
 N56Y2MKySuk9z1U1o9Mz9S2l2rlI1qAeGyI9O2zhS/8lp3G7aMgSyOOjDM1BaRUticEc3GY3q
 RoS/wjePfhTN7P+dsp3hmYy3GsOmmZnEEwxbJ+xo1obhjs2DFk3oEdJiIjcv8KKiLkAw/mYi5
 wzfoXcZeq5pkqPJTnQiUxTOnOex9iykLov7kYM/fX+uXVUL+nlSJd37Y4t9NJ9dUKofrNtGxd
 snoPnJgDMq6OjpiMEK8MZcTCK7k7gx4xl/xZL9pJhYLcaziSk5AJZ3SxJQ5j6D0u9tN8e5T2Z
 vHiqncujIB2v0ziQryInspjNIKjndVKd/eIGB1XkNyNtR2ubw12ejyyD6vDK15e056MUP3UfI
 l9fFH1mt04V4XupBFXDYrKwpFmAZ7uFr6hcJjMP4ji6SZJicrEtqubHs/4YPs9RrS2G7oLEvQ
 9VQiS04pqjlNr+SsOtdyqOd/Jnu38FJOcgmhGRiSHpIAxLbBJRlA8AtEMPu3U7bXQoMbcFTJE
 8WIOKQ==

>> Add a jump target so that a bit of exception handling can be better reu=
sed
>> in this function implementation.
=E2=80=A6
>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
>> @@ -1304,9 +1304,8 @@ static int bcmasp_probe(struct platform_device *p=
dev)
>>                 intf =3D bcmasp_interface_create(priv, intf_node, i);
>>                 if (!intf) {
>>                         dev_err(dev, "Cannot create eth interface %d\n"=
, i);
>> -                       bcmasp_remove_intfs(priv);
>>                         of_node_put(intf_node);
>> -                       goto of_put_exit;
>> +                       goto remove_intfs;
>>                 }
>>                 list_add_tail(&intf->list, &priv->intfs);
>>                 i++;
>> @@ -1331,6 +1330,7 @@ static int bcmasp_probe(struct platform_device *p=
dev)
>>                         netdev_err(intf->ndev,
>>                                    "failed to register net_device: %d\n=
", ret);
>>                         priv->destroy_wol(priv);
>> +remove_intfs:
>>                         bcmasp_remove_intfs(priv);
>>                         goto of_put_exit;
>>                 }
>> --
>> 2.42.1
>>
> nak. Doesn't save any lines of code.

Would you get into the mood to take also another look at consequences for =
executable code?


> Doesn't make things clearer or easier to follow.

Maybe.


> This doesn't seem like an improvement to me.

Can this software implementation benefit from one function call less?

Regards,
Markus

