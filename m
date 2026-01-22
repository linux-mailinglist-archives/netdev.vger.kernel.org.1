Return-Path: <netdev+bounces-252316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IQGJHUXcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:26:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1153669B2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F399E8C5174
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B13333F8A1;
	Thu, 22 Jan 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N8Vo0a0F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fBedGZu7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE33382F1
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083307; cv=pass; b=C8fUS7Bsoew0ilbg5iydJYJH56+QrCVjzHmfi5X3UTPS11x2WgqUwS5P+eJVlYLLFeZOcg/DrumcKCDn4H94BoB4L9bAF1uzoZb2uhb5clArupFLVpyFBUcaCkRoRlh3KU1YphW7R+J6n/l24j+48U5Eu6LkgxzTaNV5cQ9ShzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083307; c=relaxed/simple;
	bh=A5TqQ0/3YavPHl6K5F5yaLR1Qnl7B60QlOCSeE4x7TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhV8kLjZZNeqygW8BmO1Vt+aA33Ls2Hzc3/jToFjlCMz462M+y3K70UJHWlCiKW652x41WJ4cJ5rqysyJjvS4JnUo9rhBYJwhuOqyfRV1W1W7FpjzuJZl7Ng/DGl2Mc/xHdqQq3Zp8cwzVH3cWexSqT4DMSCxNiAsvQJ5kdqVdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N8Vo0a0F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fBedGZu7; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M74ngQ817535
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8vLrohO8+5wQwAS0qPOwst5/Z4YnHEeLa6tT5Zr8eWY=; b=N8Vo0a0FToU1qWbO
	fbC2EaH26GjEedkH1kn9DXrczfNmJbXOwyY7c4+dsUVe1tEUn4WqCoFly7AtN4g9
	EU4PAjrENFA+6qjl0lBwFidGMpES1eNlZdMqehNBsQI7E1Lf7ashIHoCM/5fbeWR
	hoa3M2WU2HidV8M4+briqqkPuFt0p2bFw57HVRWgSuSBCS/aQrp6WAlSp+hrkq8M
	qZBDGUxNgHdv2BBHLyqfG3OZBKBVrUrE71rZMXADOJqvikQ8zd0wnlR8MRPB5Say
	nndL2aSt2foudVFh4D7TMqUHMgj5S+4DUlEXstu5vWeyzwByJ91CpZMlrOScd1+o
	CV9uQg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu65v2d6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:01:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-894709fbae5so31249556d6.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:01:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769083303; cv=none;
        d=google.com; s=arc-20240605;
        b=W8LPOzzmN/84Le8yQ8EDl9FYKnv/uxzpaIhdOsnZgqoE8ek9I6J33DxIiNBvaAIBdp
         zcetLNz8XGI89A0iJuXzuJXC5i8kUXhgFsk3COkXdKfD0HE9MqTttUy1+WhILxQrhB3v
         lQt9c8CmP/pWm68fEVq1Ytor+wRlFzzL4B0gapNmTEVrvwXDPsL2V9HBaVJsD7aj0qQo
         1cBvjnq1vltATaKg0wgHkZ+OFMCsrr4e7wmiMlljGY4Le4OhfVNkZtUWzC1k8t45fSnK
         K5yzy++n8eAVH5crPQ4hO8nVXTWcl7Zt33AKX0EYzdxYswQ7L5H/XXsN0b2+WfpDdbAC
         GygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8vLrohO8+5wQwAS0qPOwst5/Z4YnHEeLa6tT5Zr8eWY=;
        fh=uttkck2ADphJeZKqYh8caHwAad4Ls430O5/A2AI4KZc=;
        b=Dn2rMPoGdm9WZHISRpfEb8AIKMAbGUCGTfwH+N4VyxcwoIomHYtnp4H9I6Olg28xHT
         Byd74kzKJJ+t68k2L7Ald6YV7ECivpyMYEOp2h8aMZ0QHEZMWRkCdw2Hec+8G4J0ixKi
         tCgmUh6kN3UvU+47tQazEylcV9TrWg2184d64qAjxf53TZO+PxKnn798C9Fx4lybfLzH
         FZUoS8rNcaoZHUSOgh//BYKDSHVr+s8+LZtWXzxLbS2JUomcrwO1/aaP3UrzH5H900GB
         B5BTox9MkFu4ljTkwFeK1RqALF27+J7nVnROFeM2DvZ/Q5NplrW4sJpN0zU+7v99Sy4Y
         BfRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769083303; x=1769688103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vLrohO8+5wQwAS0qPOwst5/Z4YnHEeLa6tT5Zr8eWY=;
        b=fBedGZu7oiNf4aYCxA/ErW9nw+3mIGaagAxEL47lAAIjmdo+bq0kJqWtTukJXHy7qR
         dhmwWsauWiAp02/feSg3M8TEVfQ+dpf1Dz8vgB5Sm7HFuEM/8qYJ9sXaBMIshm5jIrRB
         SqEUSEIbT0OgWbWaaOcHxi93osS9p8XAw5pE3UzO6MrcShXvtqaSzmHRIM2cZ0+94hNN
         A0BAEzlFTbJFFbbuxU2FcjxwIopHAPBu7KqbSE/CPx+S2CujFTFcQELRB2464H4NM2ck
         0OycsEMMf+qRHPraEeKvkEcLx1hUK3kGF0zklUetLHmJptUQP/Gnh2qhEuEUGjHmbSR2
         wTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083303; x=1769688103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vLrohO8+5wQwAS0qPOwst5/Z4YnHEeLa6tT5Zr8eWY=;
        b=KV2iv5Kgp27F32mMH3V3oS3JvJ2DV9e03qPn2cuwtzzt+/KlFLv7UczqZk8hoS+5ON
         TUnq2/mi5lDELofWnH17vps+P4rZYB0MLC4USpFvhTAYeJeyoqMuA6zGMywFG4ey2Rjr
         ey+ZbKvZr7pHoQYRODK+BHrpgohb7RRlrNg6NFPafg6Y//mWApSQWdBJyU6c5lwIdxsU
         pp7IqubsfC78qfEmhT0S3ibk0E4AGtzR6Srp/0GLscME6aWReSJ3vlZ20WKDXnJi/fod
         ujXRhrqeI9VvYYKCwrl9RpkzfIi/YwajI6WEdWYTjm7AoVoWo/uYyhM3EGlNlKtZL7nM
         Xe4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/eKVeFQ+Q/EAN2KpIp+MkQl2+8XDLdbhMjwbm9B8pKIeXZsFWmNZcajfVsbEDEBdtbAQIutI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYnsavGzzt3TsHLqPLneUe6EOnSXZO7jbijZ4+XZSZifPWicd
	mzJAYdKfAyW4k0MxEAp2KF/bZVO2FhiZjqsx0VRumHQ4FTz6rA+rkir93KhOmZoN1/I6NqZGPEd
	ar3qhM6x2nnzdNGTjuaaIZ7O+vg5pIt95irJ+1ISmkFKo0BBdEf8qliTwcEJ8e4ivCwnKczj7Fi
	vLcPZI5KfEojOZJ4QcEuTkFoABcfbchdC84A==
X-Gm-Gg: AZuq6aKPRLXiTH61w89B7Pk+n/ixihb/1Zx/YrQaqmIQoF/n4U3d0YsQ5JG13/DP1L0
	dB8vyAkv+OxKiJ7nRyo2uE2Hm6Wm8NxnT5dP8TNDFGDKuJL7VzyZv8Svc2GYQK/HqH/efSk2ztv
	5tNlGMaezoYaUMXSFq51SiOQsJc0NHZXlQQ+qJA3ekFJs6D6ixr21t3gxs1NNuZ7cgsQwQxWHex
	X/ydhjism0drOYgB+GB3SiKD9a6
X-Received: by 2002:ad4:4bb3:0:b0:894:3015:c2fb with SMTP id 6a1803df08f44-8943015c35cmr208987926d6.34.1769083303204;
        Thu, 22 Jan 2026 04:01:43 -0800 (PST)
X-Received: by 2002:ad4:4bb3:0:b0:894:3015:c2fb with SMTP id
 6a1803df08f44-8943015c35cmr208987536d6.34.1769083302674; Thu, 22 Jan 2026
 04:01:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115114625.46991-4-slark_xiao@163.com> <20260116024435.347774-1-kuba@kernel.org>
 <55195fd2.3367.19bc4d5a71f.Coremail.slark_xiao@163.com> <22e8939e.239f.19be38b4aa0.Coremail.slark_xiao@163.com>
In-Reply-To: <22e8939e.239f.19be38b4aa0.Coremail.slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 13:01:31 +0100
X-Gm-Features: AZwV_Qj4VzKtya3PA6a0V2ss5AwtOkgI2bkQI56qXLa5w8ZEiBxYw_LANExVxuE
Message-ID: <CAFEp6-387oUTN=Xj+xOWYrfVu9CUvD8Tsu9_nnnpigYamMwE8g@mail.gmail.com>
Subject: Re: Re:Re: [net-next,v7,3/8] net: wwan: core: split port creation and registration
To: Slark Xiao <slark_xiao@163.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        quic_qianyu@quicinc.com, davem@davemloft.net,
        johannes@sipsolutions.net, netdev@vger.kernel.org,
        zaihan@unrealasia.net, johan@kernel.org, andrew+netdev@lunn.ch,
        edumazet@google.com, linux-kernel@vger.kernel.org, dnlplm@gmail.com,
        manivannan.sadhasivam@linaro.org, pabeni@redhat.com, mani@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: TRsxH7euiCkOq_PFJd6Qfs0l2ONz0cY2
X-Proofpoint-ORIG-GUID: TRsxH7euiCkOq_PFJd6Qfs0l2ONz0cY2
X-Authority-Analysis: v=2.4 cv=J8qnLQnS c=1 sm=1 tr=0 ts=697211a8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=9R54UkLUAAAA:8 a=Byx-y9mGAAAA:8
 a=VwQbUJbxAAAA:8 a=r85BOXnIEqrSUjCP3scA:9 a=QEXdDO2ut3YA:10 a=16MAPSKLCI0A:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA4OCBTYWx0ZWRfX2IH/XB3DrgrM
 lJF+3kPkJBkOLbJ/3gYMmahAKvXdu4HpBKl6TK/ZR8kNMsHE68U4CI8zkkfL17YDggIh8dDhfG8
 DIS+6tfsRSIimNSyXxoJmAEOpkxi3GIWtBTIJuYUmQ5uSYMSdUAYo0sHz9PYUQIoks6jRb3AS/2
 ZLSU09n8y3yEJ12L4Ccu7Q8+7CDBivdr6DNFHWpJxODIi0PQ1g8t+6SGirtu37DJFdbMwAQlis/
 sEcXOvAiyyh/CQ3hk9xvg8MQAf2fx3dJxlQMN+IoRX9w+4xD74hks3qWQU4EyG11mD+e0Nt439c
 fJWWcmjYA0iIWva9DX5TmRc88ujxp+lvQ6DGSzTcApJdw/vw7iMywcil621wuF9J+vdENAi4gSp
 DElUMX0VEb9MCgWrYUrEUqDb5XelOrESojBHgAsQctVsS/63FMNCEnGIgtDpBQ6Anj0fs1Zq1HK
 BLwRRNnmNx5MXYFjixA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220088
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252316-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,quicinc.com,davemloft.net,sipsolutions.net,vger.kernel.org,unrealasia.net,lunn.ch,google.com,linaro.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,linux.dev:url]
X-Rspamd-Queue-Id: F1153669B2
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 3:32=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
>
>
> At 2026-01-16 11:24:54, "Slark Xiao" <slark_xiao@163.com> wrote:
> >
> >
> >At 2026-01-16 10:44:35, "Jakub Kicinski" <kuba@kernel.org> wrote:
> >>This is an AI-generated review of your patch. The human sending this
> >>email has considered the AI review valid, or at least plausible.
> >>
> >>For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-lo=
cal.html
> >>---
> >>net: wwan: core: split port creation and registration
> >>
> >>This patch splits the port creation function to prepare for upcoming GN=
SS
> >>port type support. It separates device_register() into device_initializ=
e()
> >>and device_add(), and moves minor number allocation into the new
> >>wwan_port_register_wwan() function.
> >>
> >>> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_cor=
e.c
> >>> index 1da935e84008..1a9a77d597e6 100644
> >>> --- a/drivers/net/wwan/wwan_core.c
> >>> +++ b/drivers/net/wwan/wwan_core.c
> >>> @@ -357,7 +357,8 @@ static void wwan_port_destroy(struct device *dev)
> >>>  {
> >>>     struct wwan_port *port =3D to_wwan_port(dev);
> >>>
> >>> -   ida_free(&minors, MINOR(port->dev.devt));
> >>> +   if (dev->class =3D=3D &wwan_class)
> >>> +           ida_free(&minors, MINOR(dev->devt));
> >>>     mutex_destroy(&port->data_lock);
> >>>     mutex_destroy(&port->ops_lock);
> >>>     kfree(port);
> >>
> >>[ ... ]
> >>
> >>> +/* Register a regular WWAN port device (e.g. AT, MBIM, etc.) */
> >>> +static int wwan_port_register_wwan(struct wwan_port *port)
> >>> +{
> >>> +   struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> >>> +   char namefmt[0x20];
> >>> +   int minor, err;
> >>> +
> >>> +   /* A port is exposed as character device, get a minor */
> >>> +   minor =3D ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KE=
RNEL);
> >>> +   if (minor < 0)
> >>> +           return minor;
> >>> +
> >>> +   port->dev.class =3D &wwan_class;
> >>> +   port->dev.devt =3D MKDEV(wwan_major, minor);
> >>
> >>[ ... ]
> >>
> >>> +   err =3D device_add(&port->dev);
> >>> +
> >>> +   mutex_unlock(&wwan_register_lock);
> >>> +
> >>> +   if (err) {
> >>> +           ida_free(&minors, minor);
> >>                ^^^^^^^^^^^^^^^^^^^^^^^^
>
> >>
> Hi Sergey,
> Can we modify it like this?
>
> +       if (err) {
> +               ida_free(&minors, minor);
> +               port->dev.class =3D NULL;
>
> This shall be able to avoid the double free issue.

I would prefer to let wwan_port_destroy() handle this, meaning we
shouldn=E2=80=99t free the IDA here and should simply return the error code=
,
but your approach is also acceptable.

Regards,
Loic

