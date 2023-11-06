Return-Path: <netdev+bounces-46206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA157E2627
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 14:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE692812F2
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664F9250FA;
	Mon,  6 Nov 2023 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LT1HSDfC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC71156F4;
	Mon,  6 Nov 2023 13:56:28 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BD107;
	Mon,  6 Nov 2023 05:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699278958; x=1699883758; i=markus.elfring@web.de;
	bh=kFbPt8wA64kH1Fx+nFwGspfN/LdLAlP11MwnD3aQQcg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LT1HSDfC+siCRj0fPno9lnEdbeY3g15jtam75z2TTATroGvQQs26L84a0IoghbGE
	 zhg9j5MpMvWLZOQW2ZIz2bY5tjvh14dg6zE3XiXNrPx1xCW2dcZEtXM+VvSJ9Gxvl
	 /smpfNPO5qF4VTXVRZf3n2Sr1cbuwFSjnW4CbHljltcBEnMa76q6w7R7EtG/uCQx3
	 a6NGzTHiXfKT+lJVy/4W0kKvuaI67Yi6jC7BOizlEGyESaUNzG2t0o4Ngn88ttdIA
	 29nV6EZeKkRryDKw9/USC1DG0Wk0pNYzBAs1hRpLI/5TDysQFAcLDLMQnjZBr4JwT
	 gnoC3ekNLTN2qcJTmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6FV-1qjiFX18sP-00IlI9; Mon, 06
 Nov 2023 14:55:58 +0100
Message-ID: <2b5e219a-85dc-4347-b5d0-86059181be93@web.de>
Date: Mon, 6 Nov 2023 14:55:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bcmasp: Use common error handling code in
 bcmasp_probe()
To: Wojciech Drewek <wojciech.drewek@intel.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Justin Chen <justin.chen@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Simon Horman <horms@kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
 <83b0921a-5718-4dbf-b9bd-5662e47e3807@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <83b0921a-5718-4dbf-b9bd-5662e47e3807@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:riWI2eTVON9/gUCdlSdU9CMhZwjp9iBExERQ7Vjhov4cPka+wJx
 Mi/lN2Ae8p/Ld36Ez66yoV64Z9Xo5TAGX3n6zWU9ZC8Snn3YxWOScMjLO8o+WRg6+z/B6Wl
 XvuIxg6QQLbUmQ3vpdZ4mPDIyVSaFcGoPuA4HNLVOES01ERF3XPYY4BbBxTx4us5EiH7SyL
 wTjHaUAaqUGSG6ht7iqew==
UI-OutboundReport: notjunk:1;M01:P0:eGt8JrO+jKc=;urrTiZOBRUrqOaf6hiur9o6Fyga
 rBpnMBo5jTt+a0qjCJvPOxg+PO1IKxuaozLAZDyNO+htCohCk6Gstb2wBppVw20lYN+rmCyvo
 U7FejUGYpYMWp8dFuxGqUPQEvOwyeZZAUwzHFyVjCiI6PMS5plIEr8sWJFZ1bOrM8FS8dTlrm
 Eg75yA7RMLsJTTwVMluPutplelRFJmvrYLBCpb4PvShchNQnQuX2hlsy5j0vS3KeZYpEI//l/
 RYHZNrvlYripwv6PwW0x68677optoy9xhWPVeKaE3bqKQUduFc8qFl7I1ALYsA9WyzVwQ5gHP
 ze9JfvPK/3QkCwsJUXpRZS2Jggx2WqzISXh2HodAobVj0i8F30nblRt4q06VSkcevBdTDQf54
 /VDucCb1g1BTHBlVWBcjvMkBEE9PKH4kmWZceI51nuNXrWO/D4NZpV1OT+GIEeNVi5LTH2z7l
 l5qMPYi+Ou50lPIHyVviM7ymYTdLieAhbT8Gyp4iqv4UG3pUQMOZoabuoLEqZ+OoMFrg0uJCt
 Sj7ykqKRS5vV/jtcIalZzdGt31gRHF+Xrh7yBbEfzYRHiyC4jYRCq2Rd9upvvw/SSjX2pjq4m
 BP/Wvk6mN13xmhN2alHakKqoWC7a6vji5CneyUms+ZjUkvetM9ol01hpGb/VUN5MyWebs9/Kt
 d6dypakyRL3/vcEMjs/AUMz6VKFulA2zHFZoVYsOvSZ7TvcTqmzoec44odUtGj3oicwhw7C1e
 Dhw8JjZaWv7wvtxcQaRYrTSY5O3MX4gay2IHTNXRhVtzUi94En2yVC6CwkqLavatMAU3G9alD
 i9fFT476ukx5K/ERWGPoPsFEbnbdPU0j7L3Gtgn3Uj5BJSHrdjSc3dzpQVTHN6eXHZ4zRPAB0
 fN7QIzuuI2Wp8qFmwmIfE7hqKKTvOo7TXNPi5gHIZVTJF/4A91wcDWt1IwWwZwwY1gvVsS9fN
 nz44ng==

=E2=80=A6
>> Add a jump target so that a bit of exception handling can be better
>> reused at the end of this function.
=E2=80=A6
>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
>> @@ -1304,9 +1304,8 @@ static int bcmasp_probe(struct platform_device *p=
dev)
>>  		intf =3D bcmasp_interface_create(priv, intf_node, i);
>>  		if (!intf) {
>>  			dev_err(dev, "Cannot create eth interface %d\n", i);
>> -			bcmasp_remove_intfs(priv);
>>  			of_node_put(intf_node);
>> -			goto of_put_exit;
>> +			goto remove_intfs;
>>  		}
>>  		list_add_tail(&intf->list, &priv->intfs);
>>  		i++;
>> @@ -1331,8 +1330,7 @@ static int bcmasp_probe(struct platform_device *p=
dev)
>>  			netdev_err(intf->ndev,
>>  				   "failed to register net_device: %d\n", ret);
>>  			priv->destroy_wol(priv);
>> -			bcmasp_remove_intfs(priv);
>> -			goto of_put_exit;
>> +			goto remove_intfs;
>>  		}
>>  		count++;
>>  	}
>> @@ -1342,6 +1340,10 @@ static int bcmasp_probe(struct platform_device *=
pdev)
>>  of_put_exit:
>>  	of_node_put(ports_node);
>>  	return ret;
>> +
>> +remove_intfs:
>> +	bcmasp_remove_intfs(priv);
>> +	goto of_put_exit;
>
> Why is it at the end of the function? Just move it above of_put_exit and=
 it will naturally
> go to the of_node_put call. No need for "goto of_put_exit".

I got the impression that the call of the function =E2=80=9Cbcmasp_remove_=
intfs=E2=80=9D belongs only
to exceptional cases in the shown control flow.

Regards,
Markus

