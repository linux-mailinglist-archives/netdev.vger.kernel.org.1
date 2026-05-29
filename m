Return-Path: <netdev+bounces-293100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mua8IvV7GWpXxAgAu9opvQ
	(envelope-from <netdev+bounces-293100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:43:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D072601C7C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 530F9301D12C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB8F3DA7FC;
	Fri, 29 May 2026 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fu2xW87Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HuH+CX1G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AA3CE49E
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055024; cv=pass; b=OBbcezikFwoN1Reya3mKEo7bCHHE2iWayIBljMblc6ogPNjQPmJERdsxz6Git5fp1GjCbRe+9l5pn6gsSbXvYT1Py7P0QQ3REyHjn8VMC1H4dfLmE+OyA7meT41uGwvFJpCxePb3mjcQhZIlY8PTRAt+vSmp0voQFWfzPKYYJlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055024; c=relaxed/simple;
	bh=r7r0VCZ3BbHVlEYX/S4Fb3KdGS6LX7XAVFmaM7m95Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAYGBf6e+dMdEewzivZ4OKF9+3sJ5OMAdF7t4Zl527mzzXoSVnTs5KS59xrpal4JxZ4T7XM26bGGeWPtOstKNpqjZIN60tNNgxqzmMN803a4kL1gyaDoxkVMC+JaRkLALeZx7WP9OF4F221zdhqsOpP4WyIAgbwr6hPAnolx5js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fu2xW87Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HuH+CX1G; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6eTZS2117666
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fyuHx5/5ZvH1qgXlQ0SO3dmToxgjn2GMPokfTYgcJgE=; b=Fu2xW87YYyD+4yeW
	KDg4YEwTK1yKM6c34f+6/pxqjBETi2zXuZLZ7Vbd7nCqyIHkTWdzz2S6U8JNvFzR
	V79yctXtNO8+RiYESsy1Am1J+AoaBWVTaYEqPoF7/EELwXQsMHuYPvopds/Gwzkm
	ffpF6F1n/2wtxTER/MqlSN6zm7uTPXijiZqKhEG0hkEhowZgcgQ3/guY+t/QBfo6
	63Yj1qtmZuv+8dXufp919UlzBbfWBj98E05nf43soX/b3MmLCT89LRbCs2X7MoR+
	2gICN3w3XG7przi1xNh2UA4rl0Su45BZ8XWmK3hVP5x4PEHy+8suox0IzvSj/Vrk
	S/Inow==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eeuy5bj40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:43:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914f037b7dfso782777285a.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780055021; cv=none;
        d=google.com; s=arc-20240605;
        b=lEykws4zglBw5//HpuIvwsz5uaPEvqDjWW8UMHULewmddJfk1UMzDdePt+JdLjIugM
         /jAr3TwwJAoi7sdhESNqh/k5zXH7lGx1Q8ag0w7tic/p29ARiPywua/enwHXj0plmP+n
         39056uf5MSC2mXuiE6djCi8+azOMIQWQ++nVhP7VxiHa7YdLGAcXI5iknlXeYxa9Iugg
         K4KeC5OkxKG4EUXcwS6ApRIQrT4ClrjkxQNBH9rWopyVQXXa43rQpcqhvYXXGX+Ahtfw
         Kl+YhpdhMSlEftkAuB0KWJ+Dk2zdI2QkDFTS4w13xpWqxXh1y7E1aWsVWWYKkPaSq5YW
         S7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fyuHx5/5ZvH1qgXlQ0SO3dmToxgjn2GMPokfTYgcJgE=;
        fh=VRwWmtz6n4NBjC+36URR1u53JDC74j7Hy2kOGwavgoU=;
        b=Bvwb4yuwJwsLGCM1D5s4iuwv+BJhajUiP2KZp5t3EfAvu2I7N9EDE7NBNhlbwuxvk9
         wb34DssYMMkKloi3KwDcUA6HY3Q2y5gYRj23S8wYiw2nbEd2kHxfdE7+puT+8JDde6wr
         kO0RPuRJdDDgCDj9G7ORRlwf6dJzAeAgnx0v9G0dPU/QtWI1+QHCA1hUkcxnlLjwwLGC
         tqian/lBghIle31gS6BQqZCuhHNi/k5L1LsmubaYcfDMSP4JlGDFgSkaASt9jJgrrgVy
         Gkf5tlRDMB/4JxKleo6WtpBECpkICfJbXjgpjDeWHcL9NziituUJa5YkEhy/yuaWHejp
         6gbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780055021; x=1780659821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyuHx5/5ZvH1qgXlQ0SO3dmToxgjn2GMPokfTYgcJgE=;
        b=HuH+CX1GdQb8EmQoRMKwUGGI8OSpPk14BLhQjgP3nk9PuBCLmLpw5YKddOw9h79RUQ
         6c3n3cAfdkiCZs6A9U5cERBKwpitSD6upHOdflo0AF19crgbCjLzeSRddjFZwEzeaLO0
         kLkkEUs0EMeGtYrZucu5QEj7vSuDHARpCEwQI6psx7daq7KPIQwIrd57n7J3uto36RHn
         qZfUT5Kr0xLaN8yFb4ayMmbqdYgAa+2rZnUXPGs48oGyr5zGv1lwfEqHEEFL6Y9PCQeP
         FX44AexA4yezEr2V8KNrSv16pZn5ft9HxGQCoN7FdEMjEO+VsLpJdRnH4Fe+llc7ZP9H
         ALOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780055021; x=1780659821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fyuHx5/5ZvH1qgXlQ0SO3dmToxgjn2GMPokfTYgcJgE=;
        b=n+bUwQzXfK9JO4vd/HcC/eUJR16/hfV1MEANVYJOBK76Z7946+4gZjz/lLzdsITiat
         IZ1OMaKZRHbGfMSFFPybn3ftNRSHVbf157VMxzsfdDg6Qklpd+XbY0cFNJr0VnifKirs
         yPuBk8To0bFzR/VB4Ql+sKib/BX/MvQ9n33tzEIuUhcD0Bvdx+M3fVKKEKgLdR3/YXpr
         6B0PYXsTNk3zxfRX1Z8fi2OIGrT9CydHivFgwYTcjdOCDH5BWFWnBtCyxXsBJe+ui9Fq
         xsru0kka4Zvo4rHmTwY3S0pI92GhbZe54Tc0fy1TgRmkGVQ+kD342c+x71tRhZMD7hCf
         X+/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/vMFpGYwfyi0f/0YfYkRqC5xBIsTBx7VFQc/C3TM6nZpbchSxxhtM9X4j4npbmk4XFAFVsGU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5IEzTjOQ17xyl3wbpyun91l7vJpCMlrgWCGBbQCI7abEBbcLc
	XEFPjHYHfxVPS05bUn5deMJeySph71f8ibuzj3RQAwqX0ruSBVfoPc0o4ZreEqEvMmwuHQ9fpTm
	qxFinfCLCLfD4LIc9gyfdRLDSi43L7Tm0y6IcTO4S1Po3mlNngDniB9jd41nnzHPdB2IJjXHjdS
	5NsqzlPotYcQFs5HlTUKfy0JLJ0OjV9zNyDw==
X-Gm-Gg: Acq92OEA/POl9fyzrgOPA7///fPiHmtzJBti/U7lZHuUFKZzMKqKO1ICFCVjswNL2Eu
	2OAE/Vy2g1V1NarMOBWRVnrXu3CUrwpgQpSr5YWeGvxjQHmquZ+X8sK3YO9fo8foTynXEXkkHcz
	PvljZPQ8KFydCbBOe5wrV9wHaKwvD9kAb8XKIL4sXQbR4dpkF6UA5vAIZZg6BRPejPxR6tNV3P6
	5EGVilE+OsTgG5TKxDV6VLfmPVkkuSO3r80xsXmkEt0xArIOT4=
X-Received: by 2002:a05:620a:46ab:b0:8cb:9975:cba8 with SMTP id af79cd13be357-915300d1513mr314025285a.62.1780055021087;
        Fri, 29 May 2026 04:43:41 -0700 (PDT)
X-Received: by 2002:a05:620a:46ab:b0:8cb:9975:cba8 with SMTP id
 af79cd13be357-915300d1513mr314021885a.62.1780055020581; Fri, 29 May 2026
 04:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
In-Reply-To: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 29 May 2026 13:43:29 +0200
X-Gm-Features: AVHnY4IbpeWPy4_nKNjQp3G-zFolj0rVyObyJjw9IsO8YU5DydMGzXKXSO_M7DM
Message-ID: <CAFEp6-0ntknHnpsj99YUHpD8R5SMDHf8Upn+yaED-A-sxonscw@mail.gmail.com>
Subject: Re: [PATCH 00/11] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
To: jackbb_wu@compal.com
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
        Shi-Wei Yeh <shi-wei.yeh@mediatek.com>,
        Minano Tseng <Minano.tseng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SPtykuvH c=1 sm=1 tr=0 ts=6a197bee cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=3D83DlupAAAA:8
 a=GQ8KfrVOiNvgsdg8hPQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=LLo2LcjZcqwTTUQ_I4Ao:22
X-Proofpoint-GUID: ehOxgYV0JXWCDcFGlx9RbOURGYz82u_R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExNiBTYWx0ZWRfX4scrdqy3et3z
 azSzV439al6wLWvOBd0JVaRcMPmT48aQyXbihaLXTarf8czFaMLcOO9A8F/wfqAgKqCqjYY+4Fd
 rd+ot3Kikq3cTWPvBuDH4B01bWT83dE62YMIO4Q4rHuaidFM3vaiDF4qeUoCtfRQVBp8yzdS9fS
 yGPz9YelJUnmjEULZpRIrPocKydX5EacDo/KfKFWUhTMLd/9wOWA+2f+ubwXavlYRDISh8M2fh+
 h7aEhJBH6g0Zj5p9pMrp6CwLCKNSuIlDsa4dIJCJYPp+JmKRlr40Smg+sPtfXbTWanqc2Cn8+Wh
 FKXISFuGPBty+GCqAO96Uk0TBJcqbkQNNksWqHJSj+eAGRYcavh3mqf4jkFisFlZtPrCBZAdfh3
 C2cKMDFxsjDAQRXfHNLa9CAxKu03DmBtqLPaSxGuivGX8u5JJrjdSMvX/Y6SMB5x7i4StaPo+2G
 zlgCy2At+zOnvCh9cMg==
X-Proofpoint-ORIG-GUID: ehOxgYV0JXWCDcFGlx9RbOURGYz82u_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290116
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293100-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7D072601C7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jack,

On Fri, May 29, 2026 at 12:31=E2=80=AFPM Jack Wu via B4 Relay
<devnull+jackbb_wu.compal.com@kernel.org> wrote:
>
> T9XX is the PCIe host device driver for MediaTek's
> t900 modem. The driver uses the WWAN framework
> infrastructure to create the following control ports
> and network interfaces for data transactions.
> * /dev/wwan0at0 - Interface that supports AT commands.
> * /dev/wwan0mbim0 - Interface conforming to the MBIM
>   protocol.
> * wwan0-X - Primary network interface for IP traffic.
>
> The main blocks in the T9XX driver are:
> * HW layer - Abstracts the hardware bus operations for
>    the device, and provides generic interfaces for the
>    transaction layer to get the device's information and
>    control the device's behavior. It includes:
>
>    * PCIe - Implements probe, removal and interrupt
>      handling.
>    * MHCCIF (Modem Host Cross-Core Interface) - Provides
>      interrupt channels for bidirectional event
>      notification such as handshake and port enumeration.
>
> * Transaction layer - Implements data transactions for
>    the control plane and the data plane. It includes:
>
>    * DPMAIF (Data Plane Modem AP Interface) - Controls
>      the hardware that provides uplink and downlink
>      queues for the data path. The data exchange takes
>      place using circular buffers to share data buffer
>      addresses and metadata to describe the packets.
>    * CLDMA (Cross Layer DMA) - Manages the hardware
>      used by the port layer to send control messages to
>      the device using MediaTek's CCCI (Cross-Core
>      Communication Interface) protocol.
>    * TX Services - Dispatch packets from the port layer
>      to the device.
>    * RX Services - Dispatch packets to the port layer
>      when receiving packets from the device.
>
> * Port layer - Provides control plane and data plane
>    interfaces to userspace. It includes:
>
>    * Control Plane - Provides device node interfaces
>      for controlling data transactions.
>    * Data Plane - Provides network link interfaces
>      wwanX (0, 1, 2...) for IP data transactions.
>
> * Core logic - Contains the core logic to keep the
>    device working. It includes:
>
>    * FSM (Finite State Machine) - Monitors the state
>      of the device, and notifies each module when the
>      state changes.
>
> The compilation of the T9XX driver is enabled by the
> CONFIG_MTK_T9XX and CONFIG_MTK_T9XX_PCI config option
> which depends on CONFIG_WWAN.

Can you specify which userspace counterpart you need (e.g., a
ModemManager version or a link to the relevant patch series)?


>
> ---
> Jack Wu (11):
>       net: wwan: t9xx: Add PCIe core
>       net: wwan: t9xx: Add control plane transaction layer
>       net: wwan: t9xx: Add control DMA interface
>       net: wwan: t9xx: Add control port
>       net: wwan: t9xx: Add FSM thread
>       net: wwan: t9xx: Add AT & MBIM WWAN ports
>       net: wwan: t9xx: Introduce data plane hardware
>       net: wwan: t9xx: Add data plane transaction layer
>       net: wwan: t9xx: Introduce WWAN interface
>       net: wwan: t9xx: Add power management support
>       net: wwan: t9xx: Add maintainers and documentation
>
>  .../networking/device_drivers/wwan/t9xx.rst        |   48 +
>  MAINTAINERS                                        |   10 +
>  drivers/net/wwan/Kconfig                           |   17 +
>  drivers/net/wwan/Makefile                          |    1 +
>  drivers/net/wwan/t9xx/Makefile                     |   16 +
>  drivers/net/wwan/t9xx/mtk_ctrl_plane.c             |   95 +
>  drivers/net/wwan/t9xx/mtk_ctrl_plane.h             |   88 +
>  drivers/net/wwan/t9xx/mtk_data_plane.c             |  104 +
>  drivers/net/wwan/t9xx/mtk_data_plane.h             |  105 +
>  drivers/net/wwan/t9xx/mtk_dev.c                    |   55 +
>  drivers/net/wwan/t9xx/mtk_dev.h                    |  114 +
>  drivers/net/wwan/t9xx/mtk_fsm.c                    |  931 +++++++
>  drivers/net/wwan/t9xx/mtk_fsm.h                    |  140 +
>  drivers/net/wwan/t9xx/mtk_port.c                   |  967 +++++++
>  drivers/net/wwan/t9xx/mtk_port.h                   |  176 ++
>  drivers/net/wwan/t9xx/mtk_port_io.c                |  576 +++++
>  drivers/net/wwan/t9xx/mtk_port_io.h                |   41 +
>  drivers/net/wwan/t9xx/mtk_utility.h                |   33 +
>  drivers/net/wwan/t9xx/mtk_wwan.c                   |  475 ++++
>  drivers/net/wwan/t9xx/mtk_wwan.h                   |   17 +
>  drivers/net/wwan/t9xx/pcie/Makefile                |   19 +
>  drivers/net/wwan/t9xx/pcie/mtk_cldma.c             | 1527 +++++++++++
>  drivers/net/wwan/t9xx/pcie/mtk_cldma.h             |  176 ++
>  drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.c         |  373 +++
>  drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.h         |  174 ++
>  drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.c    |  177 ++
>  drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.h    |  101 +
>  drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c     |   55 +
>  drivers/net/wwan/t9xx/pcie/mtk_dpmaif.c            | 2714 ++++++++++++++=
++++++
>  drivers/net/wwan/t9xx/pcie/mtk_dpmaif.h            |   16 +
>  drivers/net/wwan/t9xx/pcie/mtk_dpmaif_drv.c        | 1586 ++++++++++++
>  drivers/net/wwan/t9xx/pcie/mtk_dpmaif_drv.h        |  268 ++
>  drivers/net/wwan/t9xx/pcie/mtk_dpmaif_drv_m9xx.c   |  687 +++++
>  drivers/net/wwan/t9xx/pcie/mtk_dpmaif_reg.h        |  387 +++
>  drivers/net/wwan/t9xx/pcie/mtk_dpmaif_reg_m9xx.h   |   37 +
>  drivers/net/wwan/t9xx/pcie/mtk_dpmaif_ring.c       |  168 ++
>  drivers/net/wwan/t9xx/pcie/mtk_dpmaif_ring.h       |  161 ++
>  drivers/net/wwan/t9xx/pcie/mtk_pci.c               | 1067 ++++++++
>  drivers/net/wwan/t9xx/pcie/mtk_pci.h               |  219 ++
>  drivers/net/wwan/t9xx/pcie/mtk_pci_drv_m9xx.c      |   70 +
>  drivers/net/wwan/t9xx/pcie/mtk_pci_reg.h           |   72 +
>  drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c        |  593 +++++
>  drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h        |  105 +
>  43 files changed, 14761 insertions(+)
> ---
> base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
> change-id: 20260529-t9xx_driver_v1-1744f8af7739
>
> Best regards,
> --
> Jack Wu <jackbb_wu@compal.com>
>
>

