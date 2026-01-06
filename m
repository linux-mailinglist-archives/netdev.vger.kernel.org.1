Return-Path: <netdev+bounces-247469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF7CFAFE4
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2155307CA4B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B963342CB3;
	Tue,  6 Jan 2026 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iafqWunO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gwb6FEJT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179D342535
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731805; cv=none; b=CVznuD3U7a3cms5ONQCPb69RsHfbLIjXGsah/kWU+UiS0yHn483/jGyfC3Z59j5CTZOQdVnFKMC7Ckn6pcyKLa2PX/boXJb+OcxDwB7GMumBn8NahZvPEkZEEaBsRKKZbquAsRvHQQ+AvGrX82cQRpx/AO4rsslnarCvseDHXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731805; c=relaxed/simple;
	bh=sWdnIEy0tD61F09zkbvBqUFwpa2ywtnLtDE+e8IOh7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFDebSNKTE6P9NtEMWTqxm/qlirgxhOVH9yvVu3Od000p/2sWJ5yR415huCCLNC3aYtMsQzrLHNK1B9N7bFt8TtL9h7fBiAwA+NGTaAhQyhdLTdnndpCWxeY1/AX1klL8f7zTSCumiwNvGmg1qEGnlYpcPm9hFxRa/N2aTeudvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iafqWunO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gwb6FEJT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606GinSB4137698
	for <netdev@vger.kernel.org>; Tue, 6 Jan 2026 20:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DiEY6DTeWFcdDdLJobSg3rOGiWu9PoyQJVKqA3fUAbc=; b=iafqWunO/4g8rC/j
	5prtNub1msQzI+h5PJmgnDWEbEBbNMW40vEN9YBjzoobH0n1oJL8J01COhXpSuss
	nzek8kfFZ4auJJN5IY6oEZuKm2M38qsRgyvKZflI4+oN9aYwMzeDGYpmvZRBxVPt
	XNuTbEzQoT8r2hwL8jpsvEWsManHbLya6c5TWSz6tyg3Ui1wXIskhFYaVCNSqAcl
	5Ca0LBN8ea4mUGnhfLZSjAKASdSgE49rIPW+zbKnAPY0SwRqkLyQABW0cSbWLtIU
	RBpbLT7XIjubWiBRz5n8Ix4s/H3eyzMFDFe+Nj2C4X5VisNV/vqFnDc3ydlFwb9m
	UvuLnQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh66e0pdm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 20:36:42 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a2cff375bso33910466d6.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 12:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767731801; x=1768336601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiEY6DTeWFcdDdLJobSg3rOGiWu9PoyQJVKqA3fUAbc=;
        b=gwb6FEJTE4NIMwfzXakj8dCQBFjT/F/Hez7iEnCZ6yov9UWxTlEURbar2VVpHsP9py
         ZEgRRzvBqDvgOs35QojaOTGfuT4ImaZY2Gh0LSTzvN+eEXGF+FvnyFwhloUmNRYly7q6
         ven+D4xNCJQ4vxOgE636nmkX32eFO0dm8QXxvTcKvDdvX3bXdWo4wo8/9fSsDkERrvvK
         CvwPMINdGWfQoMuOzTfR4lhov8+y6oq4PAjFuGvqN8YeSWrQ7A/brNPCjMM5SkPQMjjE
         akxA6IdSwl6+ciq3gMYzzCXNvMqEa+vP4o7wyerILE11s1DUCF0b0+GBDI2kwQ3vZIdC
         y30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767731801; x=1768336601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DiEY6DTeWFcdDdLJobSg3rOGiWu9PoyQJVKqA3fUAbc=;
        b=oDSnf0DAspJNkfzRWCFTY2Mo4i7ycj49TPHfQJ9sBp+7D/hXAsZykQCbt/cAYjdNu1
         vuYA4bw9u0JhiRcF2uNcdSyB+wr7Bv8wYOHREKHZgW4kpBLa+2IgcBNH7gxbG49nh71N
         JViVTE6Hf5AoDboupyivWk2XxXWTrZqjq1cAr+Y4GiD7858qz8Bfv+2o1TKd0r0YIy/Y
         LeMTH6OYe36yFt5Q9rgjAL5dkxPdK8zpNhmT4hymlJP7ZoxBbtspbxk9nOiZTx0Id5sq
         WdcLHovUfLXVbNbM8cV5pfqdTKY4F7L2PVmnCKg43vW68wkrDn1T8FaHl9E2Iuxe4G0y
         OasQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlonCvJJOaumWQ240CKfqIeEGzao5fWp41QF2VbkmEOZJTV/ZfIHr/XOGunLNQj1+b9564Pfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjN0yk4PA+cfiG7LEKStUO+Z66fpHIwFAo0Vs4BeUMPBFzrpxb
	rkNXC70reR3SNKksn2oIFVrpQmCb9TzDsCz0LYJW95il2iStmD9KJZtP7GVtRO4bmwPeG/ZbZWS
	ai3tSSYUzuuV9r18kmOXzjsu0vUSd1ssjK0oqqpIxP6XtfVMHkIsG5RL6Ht5IewIVoVeciIL88y
	RlPkZq/izQVQLgL4qc1Tp0rM3oGa94FWdGSQ==
X-Gm-Gg: AY/fxX4ugkP3/MUHoAURIKBmgxyW5e8qw86yyo9Pdd55l0IbWkK+15kYXkHbdGPmAHm
	NUtWyVFlx8QXOmtlqIE0he9vA0S5LKUW1trvxZKZRA14FmuivC3hlzdqYq/PWFLKqh5ITC7tV9o
	82NZEZuRVRNN/zfXJpgCaEvEcBNh+535YoSd67wa9sAVl8s+Ccp+mhuE0lUZUqbnofQ1pmOM5NG
	ntQN9eOfWyXAs+JwLrcJDdxRS8=
X-Received: by 2002:a05:6214:3110:b0:88a:246a:53be with SMTP id 6a1803df08f44-890842dc0bbmr3155816d6.36.1767731801531;
        Tue, 06 Jan 2026 12:36:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAUimtQwBLqRDJ6yQLD4PL4AFY2H0liT3MZCQbEmxwhy6AqxY+sMntEeT184eI4eQH57iCvAcW7Or917IHzd4=
X-Received: by 2002:a05:6214:3110:b0:88a:246a:53be with SMTP id
 6a1803df08f44-890842dc0bbmr3155426d6.36.1767731800963; Tue, 06 Jan 2026
 12:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105102018.62731-1-slark_xiao@163.com> <20260105102018.62731-5-slark_xiao@163.com>
In-Reply-To: <20260105102018.62731-5-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 21:36:30 +0100
X-Gm-Features: AQt7F2oVPpd0Ee1hEnzRdGOx0_9FTtJsztOraxNS5WwzDuC_wPG4G3ixQmYt-Z0
Message-ID: <CAFEp6-1Kk1QyT-akDXXqxgJRjvL+-On2x0zmafHETJYQ0UkVqg@mail.gmail.com>
Subject: Re: [net-next v4 4/8] net: wwan: add NMEA port support
To: Slark Xiao <slark_xiao@163.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Muhammad Nuzaihan <zaihan@unrealasia.net>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE3OCBTYWx0ZWRfX/11x2oPDlIG+
 Yw62l1nZZX4l6YRQoTIntDwh/kgAF1oSNM20ty/YIRHQ0uxRCMQeuB6bg3U8c6+AAgEW0nwSp9p
 WdI/pPgy5JoSY5aJor+w024w3Se1cRozHsAOop0iijfDQNNVMQoOdP/0uDFHmjptKG5AUCdAN7P
 6W/RGT3u1cGtPAFfkWt3xlQ1HBiOq7o9qnQP/+UHGdpNAGtOis6JFqBrqaf8ohs5/Q3VLwKdDJu
 l3YsoVELQP0OTltwKrv0YlKhZhzXZA3Qvyo7wvHgerHoaWxztv5Zp53+3P6BNCHrei/5T2bpsaf
 Br/QNzscL7c/3pO6wOKPqoRlGAXL/HH5EoBgk2mzzR9Y3CaE90mETUZkNECa4L5/sjK+O6hf3D7
 8XaSZlppZIxBO38uHBpAY/0KBSrMrdcahp/dB/wkIHNworQJiPI7+17ta0eiXbUxxc+UU9pz0l0
 V9ccR4tzubgGQvNV9yg==
X-Proofpoint-GUID: oZou-mfyhtENE92YQb1T32Crul1RUlDf
X-Proofpoint-ORIG-GUID: oZou-mfyhtENE92YQb1T32Crul1RUlDf
X-Authority-Analysis: v=2.4 cv=evHSD4pX c=1 sm=1 tr=0 ts=695d725a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8 a=mThdVl9iAAAA:8 a=COk6AnOGAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pLixMtEyMYaIPpH4tucA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=GbkGdI2Iuv6_No-W-q0B:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060178

On Mon, Jan 5, 2026 at 11:21=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>
> Many WWAN modems come with embedded GNSS receiver inside and have a
> dedicated port to output geopositioning data. On the one hand, the
> GNSS receiver has little in common with WWAN modem and just shares a
> host interface and should be exported using the GNSS subsystem. On the
> other hand, GNSS receiver is not automatically activated and needs a
> generic WWAN control port (AT, MBIM, etc.) to be turned on. And a user
> space software needs extra information to find the control port.
>
> Introduce the new type of WWAN port - NMEA. When driver asks to register
> a NMEA port, the core allocates common parent WWAN device as usual, but
> exports the NMEA port via the GNSS subsystem and acts as a proxy between
> the device driver and the GNSS subsystem.
>
> From the WWAN device driver perspective, a NMEA port is registered as a
> regular WWAN port without any difference. And the driver interacts only
> with the WWAN core. From the user space perspective, the NMEA port is a
> GNSS device which parent can be used to enumerate and select the proper
> control port for the GNSS receiver management.
>
> Add the description for structure member gnss in wwan_port.
>
> CC: Slark Xiao <slark_xiao@163.com>
> CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
> CC: Qiang Yu <quic_qianyu@quicinc.com>
> CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> CC: Johan Hovold <johan@kernel.org>
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512312143.W82zclxI-lkp@i=
ntel.com/
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/Kconfig     |   1 +
>  drivers/net/wwan/wwan_core.c | 156 +++++++++++++++++++++++++++++++++--
>  include/linux/wwan.h         |   2 +
>  3 files changed, 154 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> index 410b0245114e..88df55d78d90 100644
> --- a/drivers/net/wwan/Kconfig
> +++ b/drivers/net/wwan/Kconfig
> @@ -7,6 +7,7 @@ menu "Wireless WAN"
>
>  config WWAN
>         tristate "WWAN Driver Core"
> +       depends on GNSS || GNSS =3D n
>         help
>           Say Y here if you want to use the WWAN driver core. This driver
>           provides a common framework for WWAN drivers.
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index c735b9830e6e..453ff259809c 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -1,5 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
> +/* WWAN Driver Core
> + *
> + * Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org>
> + * Copyright (c) 2025, Sergey Ryazanov <ryazanov.s.a@gmail.com>
> + */
>
>  #include <linux/bitmap.h>
>  #include <linux/err.h>
> @@ -16,6 +20,7 @@
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/termios.h>
> +#include <linux/gnss.h>
>  #include <linux/wwan.h>
>  #include <net/rtnetlink.h>
>  #include <uapi/linux/wwan.h>
> @@ -71,6 +76,7 @@ struct wwan_device {
>   * @headroom_len: SKB reserved headroom size
>   * @frag_len: Length to fragment packet
>   * @at_data: AT port specific data
> + * @gnss: Pointer to GNSS device associated with this port
>   */
>  struct wwan_port {
>         enum wwan_port_type type;
> @@ -89,9 +95,16 @@ struct wwan_port {
>                         struct ktermios termios;
>                         int mdmbits;
>                 } at_data;
> +               struct gnss_device *gnss;
>         };
>  };
>
> +static int wwan_port_op_start(struct wwan_port *port);
> +static void wwan_port_op_stop(struct wwan_port *port);
> +static int wwan_port_op_tx(struct wwan_port *port, struct sk_buff *skb,
> +                          bool nonblock);
> +static int wwan_wait_tx(struct wwan_port *port, bool nonblock);
> +
>  static ssize_t index_show(struct device *dev, struct device_attribute *a=
ttr, char *buf)
>  {
>         struct wwan_device *wwan =3D to_wwan_dev(dev);
> @@ -340,6 +353,7 @@ static const struct {
>                 .name =3D "MIPC",
>                 .devsuf =3D "mipc",
>         },
> +       /* WWAN_PORT_NMEA is exported via the GNSS subsystem */
>  };
>
>  static ssize_t type_show(struct device *dev, struct device_attribute *at=
tr,
> @@ -488,6 +502,124 @@ static void wwan_port_unregister_wwan(struct wwan_p=
ort *port)
>         device_del(&port->dev);
>  }
>
> +#if IS_ENABLED(CONFIG_GNSS)
> +static int wwan_gnss_open(struct gnss_device *gdev)
> +{
> +       return wwan_port_op_start(gnss_get_drvdata(gdev));
> +}
> +
> +static void wwan_gnss_close(struct gnss_device *gdev)
> +{
> +       wwan_port_op_stop(gnss_get_drvdata(gdev));
> +}
> +
> +static int wwan_gnss_write(struct gnss_device *gdev, const unsigned char=
 *buf,
> +                          size_t count)
> +{
> +       struct wwan_port *port =3D gnss_get_drvdata(gdev);
> +       struct sk_buff *skb, *head =3D NULL, *tail =3D NULL;
> +       size_t frag_len, remain =3D count;
> +       int ret;
> +
> +       ret =3D wwan_wait_tx(port, false);
> +       if (ret)
> +               return ret;
> +
> +       do {
> +               frag_len =3D min(remain, port->frag_len);
> +               skb =3D alloc_skb(frag_len + port->headroom_len, GFP_KERN=
EL);
> +               if (!skb) {
> +                       ret =3D -ENOMEM;
> +                       goto freeskb;
> +               }
> +               skb_reserve(skb, port->headroom_len);
> +               memcpy(skb_put(skb, frag_len), buf + count - remain, frag=
_len);
> +
> +               if (!head) {
> +                       head =3D skb;
> +               } else {
> +                       if (!tail)
> +                               skb_shinfo(head)->frag_list =3D skb;
> +                       else
> +                               tail->next =3D skb;
> +
> +                       tail =3D skb;
> +                       head->data_len +=3D skb->len;
> +                       head->len +=3D skb->len;
> +                       head->truesize +=3D skb->truesize;
> +               }
> +       } while (remain -=3D frag_len);
> +
> +       ret =3D wwan_port_op_tx(port, head, false);
> +       if (!ret)
> +               return count;
> +
> +freeskb:
> +       kfree_skb(head);
> +       return ret;
> +}
> +
> +static struct gnss_operations wwan_gnss_ops =3D {
> +       .open =3D wwan_gnss_open,
> +       .close =3D wwan_gnss_close,
> +       .write_raw =3D wwan_gnss_write,
> +};
> +
> +/* GNSS port specific device registration */
> +static int wwan_port_register_gnss(struct wwan_port *port)
> +{
> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> +       struct gnss_device *gdev;
> +       int err;
> +
> +       gdev =3D gnss_allocate_device(&wwandev->dev);
> +       if (!gdev)
> +               return -ENOMEM;
> +
> +       /* NB: for now we support only NMEA WWAN port type, so hardcode
> +        * the GNSS port type. If more GNSS WWAN port types will be added=
,
> +        * then we should dynamically mapt WWAN port type to GNSS type.
> +        */
> +       gdev->type =3D GNSS_TYPE_NMEA;
> +       gdev->ops =3D &wwan_gnss_ops;
> +       gnss_set_drvdata(gdev, port);
> +
> +       port->gnss =3D gdev;
> +
> +       err =3D gnss_register_device(gdev);
> +       if (err) {
> +               gnss_put_device(gdev);
> +               return err;
> +       }
> +
> +       dev_info(&wwandev->dev, "port %s attached\n", dev_name(&gdev->dev=
));
> +
> +       return 0;
> +}
> +
> +/* GNSS port specific device unregistration */
> +static void wwan_port_unregister_gnss(struct wwan_port *port)
> +{
> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> +       struct gnss_device *gdev =3D port->gnss;
> +
> +       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&gdev-=
>dev));
> +
> +       gnss_deregister_device(gdev);
> +       gnss_put_device(gdev);
> +}
> +#else
> +static inline int wwan_port_register_gnss(struct wwan_port *port)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void wwan_port_unregister_gnss(struct wwan_port *port)
> +{
> +       WARN_ON(1);     /* This handler cannot be called */
> +}
> +#endif
> +
>  struct wwan_port *wwan_create_port(struct device *parent,
>                                    enum wwan_port_type type,
>                                    const struct wwan_port_ops *ops,
> @@ -528,7 +660,11 @@ struct wwan_port *wwan_create_port(struct device *pa=
rent,
>         dev_set_drvdata(&port->dev, drvdata);
>         device_initialize(&port->dev);
>
> -       err =3D wwan_port_register_wwan(port);
> +       if (port->type =3D=3D WWAN_PORT_NMEA)
> +               err =3D wwan_port_register_gnss(port);
> +       else
> +               err =3D wwan_port_register_wwan(port);
> +
>         if (err)
>                 goto error_put_device;
>
> @@ -558,7 +694,10 @@ void wwan_remove_port(struct wwan_port *port)
>         wake_up_interruptible(&port->waitqueue);
>         skb_queue_purge(&port->rxq);
>
> -       wwan_port_unregister_wwan(port);
> +       if (port->type =3D=3D WWAN_PORT_NMEA)
> +               wwan_port_unregister_gnss(port);
> +       else
> +               wwan_port_unregister_wwan(port);
>
>         put_device(&port->dev);
>
> @@ -569,8 +708,15 @@ EXPORT_SYMBOL_GPL(wwan_remove_port);
>
>  void wwan_port_rx(struct wwan_port *port, struct sk_buff *skb)
>  {
> -       skb_queue_tail(&port->rxq, skb);
> -       wake_up_interruptible(&port->waitqueue);
> +       if (port->type =3D=3D WWAN_PORT_NMEA) {
> +#if IS_ENABLED(CONFIG_GNSS)
> +               gnss_insert_raw(port->gnss, skb->data, skb->len);
> +#endif
> +               consume_skb(skb);
> +       } else {
> +               skb_queue_tail(&port->rxq, skb);
> +               wake_up_interruptible(&port->waitqueue);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(wwan_port_rx);
>
> diff --git a/include/linux/wwan.h b/include/linux/wwan.h
> index a4d6cc0c9f68..1e0e2cb53579 100644
> --- a/include/linux/wwan.h
> +++ b/include/linux/wwan.h
> @@ -19,6 +19,7 @@
>   * @WWAN_PORT_FASTBOOT: Fastboot protocol control
>   * @WWAN_PORT_ADB: ADB protocol control
>   * @WWAN_PORT_MIPC: MTK MIPC diagnostic interface
> + * @WWAN_PORT_NMEA: embedded GNSS receiver with NMEA output
>   *
>   * @WWAN_PORT_MAX: Highest supported port types
>   * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
> @@ -34,6 +35,7 @@ enum wwan_port_type {
>         WWAN_PORT_FASTBOOT,
>         WWAN_PORT_ADB,
>         WWAN_PORT_MIPC,
> +       WWAN_PORT_NMEA,
>
>         /* Add new port types above this line */
>
> --
> 2.25.1
>

