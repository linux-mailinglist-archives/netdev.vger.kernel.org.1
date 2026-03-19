Return-Path: <netdev+bounces-269347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNt3Jduuu2k8mgIAu9opvQ
	(envelope-from <netdev+bounces-269347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:07:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F32072C7A83
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6467301DCC1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B5D3A783C;
	Thu, 19 Mar 2026 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Dnatj6+e"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652C3A7591;
	Thu, 19 Mar 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907485; cv=none; b=BaydH74sj7AZinp+Xes376YFIWxIJYSrZoDJyCtG5MXpS8l2HL9kY2q9TZeO90zIScZgMp3AtJTsd4n8o80KG5dU5LARQMQcHELY1N59UOwS9B+qHgiYiJbNma8tnlNdVSo3VYHpVXkBDcKdwrL3q+dX8zDMKT93Vu/J0jXNlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907485; c=relaxed/simple;
	bh=q5wCcGzaZCVYHVx/yL/c01yk1kZ39vxRS8V5m69TZSw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U3KpLoCMrkYTzeVPj806SQtqkfMErXRWrl0RthT0yvhaiIYxiAMgM7hf/Dp9GP3XHfokJhNp/H2y2sjidwFRQh8ol7Z5pRdEqBnXfrPJNY71EfSR12rmSS6Gz/7NGSGSX8lmgCRGTx8Eed8UXrCNpd0F6Aj+zGsaIzIDvvBGaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Dnatj6+e; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9B26BA12AA;
	Thu, 19 Mar 2026 09:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=mail; bh=Fl2E9rGMlhCBvCHqztZinzXjLFbCx
	Es+Z7hcQwx7u4s=; b=Dnatj6+eRh5Q9bwe3UH2Aj1kFsNSSgC5mZf/mrKqeS3oI
	UcjH+Sr2o0F+JWHE13Sv0QqvhFu4ETerFu8JxU4HkXtaxwfKwl+Nq2TTmRfhstLY
	Y+SjgB+qGTRP+ZeVOWp/CD03Vu7Hw1VRZzkmslDvxmxxRqbNSfwF7a7BR3H+4deG
	4Ju+vFpJnq3G8Br9SLmHO42UtPkbCofpnwDu6C/Vln1eWh9q5gEXVzmxmLZcQcMT
	OgBnCMPFegBDsV7MU7h26G9flxIW0yRp3VY6FuhbB1hbwxLyLWcDrn/aOd2vNsq6
	fEL4LPCrZ/MRaTrkTFGks3kEPgBbNvmQCzjwFbxRylIWXeqsiNVkYqJ7MhVJ+mi2
	4kGkZ+gYuD62qIpHzCSAJ4xekegiMf3IJ+CJrT4pM2ajGiJOV7bJVcVaEF+JiQLo
	uPEHmxnJ54xD3DQB+iZbfijg0bv0x6yxYR2uuIGMQFddDsG2sqKD3HTpjWYCTHhe
	XH6u58Z0Seez0JzqhM2YlYbxExafSotwZSOhnqHKM1Uo9Y99oJBRbYUjRFVCwSCh
	uIUmOH1KPryR2G/qKfp8wXDAGNDiDSX9nQ9xtPst7VkwWV7XNb5N85cfTKE686GC
	VWZuVLtE9FMg3X0UpMerXw+X52Ss4BSNW4prQ1x3AiBpHc0gNyqpPldEz/w4G4=
From: Buday Csaba <Buday.Csaba@prolan.hu>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, =?iso-8859-2?Q?Cs=F3k=E1s_Bence?=
	<Csokas.Bence@prolan.hu>, Frank Li <frank.li@nxp.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Topic: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Index: AQHctu/EnYrCAj+Sc0CtV9sYzw0oyLW1JCUAgABWKQA=
Date: Thu, 19 Mar 2026 08:04:36 +0000
Message-ID: <2894050ee58d428cba909b705b7684a2@prolan.hu>
References: <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
 <PAXPR04MB8510E8145481F667DD769F23884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8510E8145481F667DD769F23884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US, hu-HU
Content-Language: hu-HU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2998FD5150627D66
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[prolan.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[prolan.hu:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269347-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,prolan.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Buday.Csaba@prolan.hu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[prolan.hu:+];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,prolan.hu:dkim,prolan.hu:email,prolan.hu:mid]
X-Rspamd-Queue-Id: F32072C7A83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>> Fixes: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")
>>=20
>> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
>> ---
>>  drivers/net/ethernet/freescale/fec_ptp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
>> b/drivers/net/ethernet/freescale/fec_ptp.c
>> index 7f6b574320716..c1af81002b8fa 100644
>> --- a/drivers/net/ethernet/freescale/fec_ptp.c
>> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
>> @@ -534,7 +534,7 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp=
,
>>  		if (rq->perout.flags)
>>  			return -EOPNOTSUPP;
>>=20
>> -		if (rq->perout.index !=3D fep->pps_channel)
>> +		if (rq->perout.index !=3D 0)
>>  			return -EOPNOTSUPP;
>>=20
>>  		period.tv_sec =3D rq->perout.period.sec;
>> --
>> 2.39.5
>>=20
>=20
> I think the correct fix should update the n_per_out value like below.
>=20
> @@ -756,7 +756,7 @@ void fec_ptp_init(struct platform_device *pdev, int i=
rq_idx)
>         fep->ptp_caps.max_adj =3D 250000000;
>         fep->ptp_caps.n_alarm =3D 0;
>         fep->ptp_caps.n_ext_ts =3D 0;
> -       fep->ptp_caps.n_per_out =3D 1;
> +       fep->ptp_caps.n_per_out =3D 4;
>=20
> The commit 566c2d83887f ("net: fec: make PPS channel configurable") added
> the property "fsl,pps-channel" to indicate which pulse channel is availab=
le.
> So we should not fix the pulse output channel to 0.
>=20

But is it wise to expose four channels, when only one is usable by this=20
driver?

This patch does not affect the channel selection. That can be still made
through the DT. The driver uses `fep->pps_channel` everywhere else, while
rq->perout.index is only checked in this single line, and never used
anywhere else.

So the question is whether userspace is supposed to reference the hardware
channel number directly, or the mapping is meant to be left to the devicetr=
ee
and the driver internally.

I hope the netdev maintainers and/or Richard Cochran can clarify the
intended purpose of `n_per_out` and the expected channel indexing.


