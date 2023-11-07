Return-Path: <netdev+bounces-46355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB27E354D
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 07:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99E2280EE2
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D539447;
	Tue,  7 Nov 2023 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OwHtopZi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0717F0;
	Tue,  7 Nov 2023 06:39:01 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640E11A;
	Mon,  6 Nov 2023 22:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699339113; x=1699943913; i=markus.elfring@web.de;
	bh=dyrvO4jp+FcnYndOBXe6vRqDh6iKvs3/XCz5EqIvItE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=OwHtopZiF6X55Q63yRs639L8Y+J+DxrviktF7rRXrWEX1OIZhHBeZFuSmNBcTY8/
	 GMNc78Oy7BFQ7kih8XRZdvrpGahV4YpO2WEdKgFfQpNCDyuuMo2R3PLuv18qRK89j
	 BcEaXSGIaGQv5ISPA25J8kI0SRVxW/fBh0Hhk7v6e/98xE9dH41jSi8OtyT+g/6x6
	 1kETCALiGjKCcwXl8CAKd9eP0TP+C2QpOkKoyUe/SzzXDMjS7O6wU1t8Dc7IHJplG
	 JQeuQ7UzaTYINn29hujX72prCyo0y7iFZLFDnriuIJXMVSLanNcB7uVBb7ME2+6mr
	 78x+dYLiZQYpVUR/5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1rmWuO3viy-00mRhT; Tue, 07
 Nov 2023 07:38:33 +0100
Message-ID: <dce77105-47ab-4ec7-8d46-b983c630dad8@web.de>
Date: Tue, 7 Nov 2023 07:38:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: bcmasp: Use common error handling code in bcmasp_probe()
To: Jakub Kicinski <kuba@kernel.org>,
 Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Justin Chen <justin.chen@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
 <20231106145806.669875f4@kernel.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231106145806.669875f4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pdIZHKFQErHqx0NbYleSCo5hE4ZCvSBGK+/n/+5T+uMOLQIVel1
 a02M8DQPWIYN1zFE7Z3KitYHOrD1ancHzD+Qlj2Mb6wxElhUBd0aKfCFqlPiJbtID7kARj0
 8cX0xGT8LF549KqsHUFj4BYkP1OrlRVEuVEcAypApUXTdL1PdgjB56UYqnSL9gv3psXcADi
 lEF38jpyEsA9zNXIzHGgA==
UI-OutboundReport: notjunk:1;M01:P0:rp6EM0Fli/k=;/BHlwusWqvK0jm7hl8YNXaOjWRx
 gXKzhT1RKvAjOL7NbCp8Zcw29fllzLXzXQNE02FSNP7gmh72wZ9DfcaF4Rbgsxqo3kVKkdYAC
 WKOhDHtmsX4v1Fro8/T7DIzXnF7NJyP/cF21WLHvpWVFuEMVC251d/iUFKn52DgIRSq1L9vio
 xnKZT/4gkMcKOVyJ5AaSYyAzgqfqtfyK3ArrDBTx4nPSPnRRoS0xq5+H1nq9Z6jXg6jFfu9zh
 eW34Toi7hUZj3MznlgcbZ+FDwgzguE21i6Ru389mS7idJSpHjqasZIqvuDC96MU3FV4qD3GFM
 YyiqgEceeFGOxKg7RQihU1s9mlsWYxlwwdhRWrGBNS8l5oRgP009aUownRZAJAekXU+0dwfJJ
 y20tDGmnPusQYLPKs2vHP7ksksnWFaXD9mMpuE7Hw/hEb0ffPwMgmWAwVOeRHQDczgxH25dg3
 vTSvOE3X6BgJS8PuUobE9jGt7bKQMlxV3KLHOyVi2HYz+Ux9iuRooMIgHW/CClkibwnVSk85E
 8njooqzR6N6XCIwEbQDFbPDYx6s66JwWxObdcHjjhZb+0W9c+yu+0z3JTFI63rrv3aGWJDgYJ
 bBeq90gACUDPYfpem7ehaiPeO0BBuTe7YS41QoSv+LgDkEPwaJTQs+m/omuNRqLVJTHHKyx3w
 MLtznwq2ijik8lFiGa1QOYNKLv+CAapjZ2SX6Eu7M/cBbgFEKqJm6SNsRO6O8hVL7jHz2f4AO
 GFIFpWPJis/cZqj4feAO6DjXg4wDeKm+FrH0y5v0YgrovD23p/uF+/uZxQbkhoJ8GfI+Gnb0O
 XFs57nKzsvZm0q+Ac4OqOFFFnr5F+rBFGdyOy58athI8B8gggEZoTze4ZqPh/dcd87OiPNuq1
 lE9ZdthiGhRNKy7LzG2Z2dKv4LFmx5sUuGPkykjJjBMnrAmh/PeU0J5oakSL72zdH6XMHKCtw
 fnpwNg==

>> Add a jump target so that a bit of exception handling can be better
>> reused at the end of this function.
=E2=80=A6
>> ---
>>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> The diffstat proves otherwise.
> Please don't send such patches to networking.

How does this feedback fit to a change possibility which was reviewed by
Wojciech Drewek yesterday?

Regards,
Markus

