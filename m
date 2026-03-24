Return-Path: <netdev+bounces-270974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ArODY9jwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:12:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61853064A0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEA10307CE13
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353B93E0C52;
	Tue, 24 Mar 2026 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FVbYYE+C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hFXREk74"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA03DFC7D
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346758; cv=pass; b=o914d8seF1vHa/Lgps4015yCorsScMxnUeHa5VibOwQJuwgV1sCb8XZOtGFo/pBcWkmPK/PhezaqGYN5Hq7+j+faQbKb2lSVnF9WQFSQGgRthVUd7oKtCQpb6z9WsK0UyAiNpCluKCpkotRiI/kM6odDNUFSCL6Nc12JMnQbV3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346758; c=relaxed/simple;
	bh=4Wzd3BcDplkUm2GpIyQdfqa3+hDkQsFJgnZ9ArVZjiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkTW7Buv8g9WZz6QAt7JehVR702h/3+pV0xti1sg049rVONvYqi5JOH/xXSabTTTFQVaHX5WYp+PxNnSTMe4T6quMEK7nSR4um8y/ejuzN6hpcXKQ0bxAvnFP5hK5D44jfHDOr4SwKPOSlUKm40qBcJTU7zq+TAqik8v6z1lj+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FVbYYE+C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hFXREk74; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9Z2wK3634272
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j54eEmYMpFJdkeYtXTgp6ejXrwXMt0h2HShp4wZvqcI=; b=FVbYYE+CrypzoBZ8
	v69sZx1DAnK6NVxbxnV5jvEtDweqowtMocsj4+clw9Af796wMbTKozD0dvOG7qAT
	cGBpW0UhVwleHvnwrchO2sJKfH/6NSPVmRXb2RSHbGabsOE8RkxIjXO9y7ADU//U
	bl09CUkzwPFK3sO0qvZ1KMp1Z5zgns49CLsMV801rkuOIw2MKdtCopPsmSaWSQzr
	1XJUQ2TDsQnaE22f3+NkR5AF8Ze7C4KoHPiLqDcIsEY+TWeGZEvpFGhCkuz+afln
	vJku74JJKGafAHOZEScnKmBdte7JIDGuffgSD96sf59xRMnzQXIDJzsj2WKbbAgq
	o25kOA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4mgw1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:05:55 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-899fa82ebb9so428662886d6.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 03:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774346755; cv=none;
        d=google.com; s=arc-20240605;
        b=JNTgtGiE3M2Ka4C1mXX+zSXpoI5a+DrMUhgUAEhfdm1ThaZphdimUbM8ViQuFP3ZID
         JpsMYL2vgxxqXf3QQrCuUsTMhdjloCIjx3EwbQ9CC+HoC//phZl1gbgIzDXdmRef2Fy0
         EhEKLrFUntREbnT6xpB/4AYJ4jKoziZ6At3NVognhXE2QJ9awBsfszkzptfp1ZHCAwjC
         K7buVNsPZ6PSss4/7h26AGS8qLLh9/61l5Ah1od1LqvlMRUgpKe8j7RJo25OG19opQP4
         FD5EoaFVRw012uZEKj4MtEFfdv+RKgmLcVbaR35n8Y90gDbjhpbKRAWV+mUYLfPnsloI
         dtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j54eEmYMpFJdkeYtXTgp6ejXrwXMt0h2HShp4wZvqcI=;
        fh=l/JH2p0anvg/z6h6lBcm1HssdWI9VjSnstajTOH4WD8=;
        b=Nrena0qxfTK/+LKe0QscxhEg2QSUAzQlQiR4B/zR/oXGTf/N98J19CURT/UUshUZJI
         Pmb/QeTi3F7oPquOeUme19NQr6aWgZatJ0j7/Osp0ZVVNBgPQvwBwUZFci2Ut/myTamS
         VHdl/xjb1IT2xtHlroiexGWMEMq2GcZ4ZiGuS44Yeg/cgfs/yElFfL8n2K6Y3R115h3q
         6hPK7CttDHF9EjiqNFIC7FLAevQUACMTHnZP3+E4YxAfyP9LUQQCiI5zyRR6Sy/api4Z
         8D21OAJGzizzG4DIvLeLAVCnuvJFGqsviU6hoZgUZsfx22H9sc25cN1Z6bzdQLzlLVGY
         B0Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774346755; x=1774951555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j54eEmYMpFJdkeYtXTgp6ejXrwXMt0h2HShp4wZvqcI=;
        b=hFXREk74iREEEV4EVnZTv4MrE3lkCe2FIwe/vx8nB1SfbAeOV2s+D4zcYT47yCh4O7
         QFZGnaW1q/7CCZOuLm9BwBbfAlil7QYCLI4fBS0UKOv+ra5F40WJzzafPlUtP31LP0js
         mzvJ8lPAW1Xbbr9lwBeSVRgvryfiJY889IoQr7Ocpku1St9m9TCtT7h0DsCSRYPcSB/6
         EvvX3IzgcGJN0hKi295x/uN5O0JjxgGoLUQ1TkTQ1bzAuUc2YzIvFmip4uJPMB+NjR7e
         jp58wnTK1lCs2b9xiB2MahmWqWdDewKWHy0XMjNH44OjQRdTqDbEvRV49aHPBsKtV9Zw
         RFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774346755; x=1774951555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j54eEmYMpFJdkeYtXTgp6ejXrwXMt0h2HShp4wZvqcI=;
        b=rlgdd+kECAb/kpTtsANtp9oH2uZw/TXs5GkV4KpkWDHE2TjQYf+P/xlIIueE4jeF7h
         +Od5ApZ3hUMa9cRxr5JdsHJgokDTFVJ4aHGkmH+C0DzIXqcsCK07ugXo10GgVeJApI1P
         q6W2OW8ISYdsnLhdlkNla0OtoQZ+lee9+L6DTDNA0d14V15CXXEVrdDTg0MuFI54gZxI
         kdzHChvGvzBF/0bAQ77Kucm2ABN5DRBL0QGHMDOcfhkrFrSlvbfdcpB1dsMQfC7pP8/A
         mR5FP5xGpFQ/mwR1ePmWQ43dYd8Tpp/eyVP05ZDcywvoE4C2QkvI//M5TNSGhxZqrLwW
         CB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI0qfm0qwdGC9EtWDNkK133Xqor8zB2hdYrFe21eeP8ht9bI4kOsJefYYRvi3aRIqWyMnckYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQkp4FQ36XoX3ba4Crwnrp4rLFPeUMgtKbmO5q0XDBBrIfvrd
	KlIWzJ57tisiBDzLYw0AALbolc0dn7ntM02C6mj64Tl9Y8B2GKOCXnagAq2FLxHmDxwbrA4Vvnl
	sVMnkrmaGbje2RevY74W9By3QY6TsdcjkI7A+oOX1dlfWbWViGNdXAA/4Kky8EeD8WxTng52KKZ
	S4J5QrY4QQhag3pt/QNwXCqhC0FfyuDa8/2Q==
X-Gm-Gg: ATEYQzzKQo0noOEemDXOsFINYSHbBLNGtDVf/Lz8nXfH4sMfm8u6y/Xo1BG04I+Ni8e
	TlcngKqrhkhjznSHxooy9GeSM96HD+B8c31DKBYDjjV0F45TWTe42Km4Ywz9EnimNj/OM17Vq3u
	ufxY+AaBSQhaFTEoBwsYftRF9/SFJqLNDGDU0+bgD4ho+GmUGyo9G5AAM9XuR9rETNgJ1D7xpbc
	cR9eKWmOYOGsy8AXsiTQmoWUdpybJ0ybgBSP84=
X-Received: by 2002:a05:6214:411a:b0:89c:5557:88ca with SMTP id 6a1803df08f44-89c859e5269mr249177056d6.14.1774346754738;
        Tue, 24 Mar 2026 03:05:54 -0700 (PDT)
X-Received: by 2002:a05:6214:411a:b0:89c:5557:88ca with SMTP id
 6a1803df08f44-89c859e5269mr249176566d6.14.1774346754257; Tue, 24 Mar 2026
 03:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-vdev_eth_next-20260323-v9-0-da6e4e486437@oss.qualcomm.com>
 <20260324-vdev_eth_next-20260323-v9-1-da6e4e486437@oss.qualcomm.com>
In-Reply-To: <20260324-vdev_eth_next-20260323-v9-1-da6e4e486437@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:05:42 +0100
X-Gm-Features: AaiRm52mnwtlwfYbxOKbYXLjTU4Q84Qh1-wZPUkpnA09egVXuuaIduUK6UAfHcM
Message-ID: <CAFEp6-0zgCwJb8yOZD6hM2KDApoisMYMmw57xJ0uwSvtEHxU1w@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] net: mhi: Enable Ethernet interface support
To: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: fp_-Fp_YY-xrTSUycOUgNKgUr9-U3fd8
X-Proofpoint-ORIG-GUID: fp_-Fp_YY-xrTSUycOUgNKgUr9-U3fd8
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c26203 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=2htXjO9KKp4rW3UUCOEA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MSBTYWx0ZWRfX11ElIlqjbyCR
 X6kHe2GZdF/kkV/iwD1+539R0pZrO1ZGGVtg0JJpfuw0NEoXpA1ZgB8HnG4tjYUDtgKXPEmbtdD
 /U/l9+Mk0cf84UyODTjdi05QVw1tBuaFwkW3pAhGv0uXOvpNTTYScXKrjfqKUkLDS3rphdVhs1q
 /sw6uuSJlx+g+15IfaRzXo7zQEiYeelq0TolIDM0oR3N9Q5mzJ6MIvrwPQ+9RQ7+n2OlZu7NdGg
 NV7/6u8O1e0RHWbw+F3F1NshE8YUtM3pJsOtmQoDxfzu/r6w2Pr0MUsu+lA9uBU+6U37AlWWaIZ
 AoQTA6qFR0EweLVAabJAEzJU5wMLgrCk+IUd20tBwGvHh/Ck87/32ULHqOAqjI8GlrZl6gSQj0f
 9Zystjwz/sPhI/2WDY8HPwOGlz40sUE+zdjLyRHtRSBSPxO7eSOeG2plEOr8MOZZfArdc7ZJ7MJ
 8iYW2HbT/k64A+tRtFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240081
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-270974-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,qualcomm.com:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: A61853064A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vivek,

On Tue, Mar 24, 2026 at 10:02=E2=80=AFAM Vivek Pernamitta
<vivek.pernamitta@oss.qualcomm.com> wrote:
>
> Add support to configure a new client as Ethernet type over MHI by
> setting "mhi_device_info.ethernet_if =3D true". Create a new Ethernet
> interface named eth%d. This complements existing NET driver support.
>
> Allocate MHI netdevs using NET_NAME_ENUM to reflect kernel-enumerated
> naming. This updates the reported name_assign_type for MHI net
> interfaces created by this driver, aligning naming semantics across
> existing and new devices. No functional or interface naming changes
> are introduced
>
> Introduce ETH0 and ETH1 network interfaces required for NETCONF
> and S-plane components.
>
> IP_ETH channels represent the Ethernet interface exposed by the
> MHI device. The driver creates a corresponding netdev instance,
> allowing the host to access and operate the device=E2=80=99s Ethernet
> interface.
>
> NETCONF:
> Use NETCONF protocol for configuration operations such as fetching,
> modifying, and deleting network device configurations.
>
> S-plane:
> Support frequency and time synchronization between O-DUs and O-RUs
> using Synchronous Ethernet and IEEE 1588. Assume PTP transport over
> L2 Ethernet (ITU-T G.8275.1) for full timing support; allow PTP over
> UDP/IP (ITU-T G.8275.2) with reduced reliability. as per ORAN spec
> O-RAN.WG4.CUS.0-R003-v12.00.
>
> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> ---
>  drivers/net/mhi_net.c | 65 +++++++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 53 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index ae169929a9d8e449b5a427993abf68e8d032fae2..87d8c61fab983005eaea99603=
d74a557d1483b6e 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
>   */
>
> +#include <linux/etherdevice.h>
>  #include <linux/if_arp.h>
>  #include <linux/mhi.h>
>  #include <linux/mod_devicetable.h>
> @@ -42,6 +43,7 @@ struct mhi_net_dev {
>
>  struct mhi_device_info {
>         const char *netname;
> +       bool ethernet_if;
>  };
>
>  static int mhi_ndo_open(struct net_device *ndev)
> @@ -119,11 +121,29 @@ static void mhi_ndo_get_stats64(struct net_device *=
ndev,
>         } while (u64_stats_fetch_retry(&mhi_netdev->stats.tx_syncp, start=
));
>  }
>
> +static int mhi_mac_address(struct net_device *dev, void *p)
> +{
> +       if (dev->type =3D=3D ARPHRD_ETHER)
> +               return eth_mac_addr(dev, p);
> +
> +       return 0;

return -EOPNOTSUPP ?

> +}
> +
> +static int mhi_validate_address(struct net_device *dev)
> +{
> +       if (dev->type =3D=3D ARPHRD_ETHER)
> +               return eth_validate_addr(dev);
> +
> +       return 0;
> +}
> +
>  static const struct net_device_ops mhi_netdev_ops =3D {
>         .ndo_open               =3D mhi_ndo_open,
>         .ndo_stop               =3D mhi_ndo_stop,
>         .ndo_start_xmit         =3D mhi_ndo_xmit,
>         .ndo_get_stats64        =3D mhi_ndo_get_stats64,
> +       .ndo_set_mac_address    =3D mhi_mac_address,
> +       .ndo_validate_addr      =3D mhi_validate_address,
>  };
>
>  static void mhi_net_setup(struct net_device *ndev)
> @@ -140,6 +160,13 @@ static void mhi_net_setup(struct net_device *ndev)
>         ndev->tx_queue_len =3D 1000;
>  }
>
> +static void mhi_ethernet_setup(struct net_device *ndev)
> +{
> +       ndev->netdev_ops =3D &mhi_netdev_ops;
> +       ether_setup(ndev);
> +       ndev->max_mtu =3D ETH_MAX_MTU;
> +}
> +
>  static struct sk_buff *mhi_net_skb_agg(struct mhi_net_dev *mhi_netdev,
>                                        struct sk_buff *skb)
>  {
> @@ -208,17 +235,20 @@ static void mhi_net_dl_callback(struct mhi_device *=
mhi_dev,
>                         skb =3D mhi_net_skb_agg(mhi_netdev, skb);
>                         mhi_netdev->skbagg_head =3D NULL;
>                 }
> -
> -               switch (skb->data[0] & 0xf0) {
> -               case 0x40:
> -                       skb->protocol =3D htons(ETH_P_IP);
> -                       break;
> -               case 0x60:
> -                       skb->protocol =3D htons(ETH_P_IPV6);
> -                       break;
> -               default:
> -                       skb->protocol =3D htons(ETH_P_MAP);
> -                       break;
> +               if (mhi_netdev->ndev->type =3D=3D ARPHRD_ETHER) {
> +                       skb->protocol =3D eth_type_trans(skb, mhi_netdev-=
>ndev);
> +               } else {
> +                       switch (skb->data[0] & 0xf0) {
> +                       case 0x40:
> +                               skb->protocol =3D htons(ETH_P_IP);
> +                               break;
> +                       case 0x60:
> +                               skb->protocol =3D htons(ETH_P_IPV6);
> +                               break;
> +                       default:
> +                               skb->protocol =3D htons(ETH_P_MAP);
> +                               break;
> +                       }
>                 }
>
>                 u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
> @@ -306,6 +336,9 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev=
, struct net_device *ndev)
>         struct mhi_net_dev *mhi_netdev;
>         int err;
>
> +       if (!!ndev->header_ops)

The double negation does nothing useful here, you don't need it.

> +               eth_hw_addr_random(ndev);
> +
>         mhi_netdev =3D netdev_priv(ndev);
>
>         dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
> @@ -356,7 +389,8 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>         int err;
>
>         ndev =3D alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
> -                           NET_NAME_PREDICTABLE, mhi_net_setup);
> +                           NET_NAME_ENUM, info->ethernet_if ?
> +                           mhi_ethernet_setup : mhi_net_setup);
>         if (!ndev)
>                 return -ENOMEM;
>
> @@ -386,11 +420,18 @@ static const struct mhi_device_info mhi_swip0 =3D {
>         .netname =3D "mhi_swip%d",
>  };
>
> +static const struct mhi_device_info mhi_eth0 =3D {
> +       .netname =3D "eth%d",

We named other interfaces `mhi_hwipX/mhi_swipX`, would it make sense
to have similar naming here as well?

> +       .ethernet_if =3D true,
> +};
> +
>  static const struct mhi_device_id mhi_net_id_table[] =3D {
>         /* Hardware accelerated data PATH (to modem IPA), protocol agnost=
ic */
>         { .chan =3D "IP_HW0", .driver_data =3D (kernel_ulong_t)&mhi_hwip0=
 },
>         /* Software data PATH (to modem CPU) */
>         { .chan =3D "IP_SW0", .driver_data =3D (kernel_ulong_t)&mhi_swip0=
 },
> +       { .chan =3D "IP_ETH0", .driver_data =3D (kernel_ulong_t)&mhi_eth0=
 },
> +       { .chan =3D "IP_ETH1", .driver_data =3D (kernel_ulong_t)&mhi_eth0=
 },
>         {}
>  };
>  MODULE_DEVICE_TABLE(mhi, mhi_net_id_table);
>
> --
> 2.34.1
>
>

