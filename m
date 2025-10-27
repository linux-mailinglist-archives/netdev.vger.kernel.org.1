Return-Path: <netdev+bounces-233171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D1C0D7EF
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C1119A18DC
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65012FF67C;
	Mon, 27 Oct 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQQFjcNu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3502FA0ED
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567769; cv=none; b=AoYbV0Gsb2U6dVEDcFP68wzdzj/aF+xnSrQdzWfQZG+gSshC16CfV3CSMzSVWjaWDR8bZ0wwF9yXPjVIY9d51XVWtp3B4PNINOv/90/sabhDmwx5gvZSUzSrtt+TX6zw4wu01tPvKz3gSgQoPvc6UcqyIAcjogP9iqQHQVoOZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567769; c=relaxed/simple;
	bh=3muxG6MPxyrW/HfGoVTrDpf0zTKrmjAvX4xRLEsxaLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEGdSnwm47aDAjbe8oLO7nqHctwVKfMzkRn9bPw4qJJk7lpJ7CdmkazCyBh6J3NbI1uwJDEK4UMRPAvhoTZ2Z4YaNq3QceV/ztj4lJHzkdTx5mXmuaft57jb1Olld7dte/TFn3lde8HLcD0FILWdXU2bgAZyzUZWYY/vcE4boRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQQFjcNu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RBK0J52546933
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 12:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JncXzot9W1gow8/tUDBTV3mA
	gpfqF8x82foGvNCR8u8=; b=hQQFjcNu2DH5Lw59o1W3SMNAFQY0QXjO/ktVuC40
	hzC7YzQhGKGkCh1lCcdb/C/niKl0YCCv4pxGe/CTro0PzN3sR8SCaf+bRb1G1SzN
	q+VuVqXq66xW1wvCMEun5HJ81BTKuCA3TxV612EXGGbQdvrskchdpi2h51F/OUc0
	NSqKEbYWk4av6IrCCZHgQNu/VoFWqFXK3rMMy9vmJNTSf4zHBpVxvjY5YwkyfErW
	3Ps46xiotXAIzJnryRT7QeUNOyGxvZKYB+by7tQ7mfvn5y+2l69ZVBj3vtenKmSR
	dxdsKS6jQdPufQELxCcW3VKJ+HXMXz8y5LsPIIwe11cxCQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2g50t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 12:22:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf4540bb6so29465871cf.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 05:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567766; x=1762172566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JncXzot9W1gow8/tUDBTV3mAgpfqF8x82foGvNCR8u8=;
        b=W0v2EFwZger5r1L/EMaaSKDg0pWNt+UKlOWTKWiOOW8NAyIbg4LTHpFWweN2L5qx9u
         zlFh9lYy/RmIDxgVXNsuxm6yi3WXniXYML0gQRdEvsaI+wlTx4PDmMxBgtqKFHTfHR86
         Jt+rjBwzJCUlaX6gsvS8TRsRHiBlGU4tPKHZMi8kqrs1SKJX6AxLjSl+9QOLfw+QULI9
         j58SH2axzYJXfWhRdgl0hZ8Jm1jSBdFcpr1fJon+0HrUCJcdOjwtXyDmSqi0JrBPsXQ0
         Pd5DYkSXE+W6kyM8ALJGAGQbigd7tFQt9zKAYTV6BS3bx0bWyyzRGgAJw87MUGIFhD1u
         sYaw==
X-Gm-Message-State: AOJu0Yx4beEDD2CNvEaMhemt0kv2+Aq7NbrZITInVhR+2YtH8QISrkQw
	KEtC9g1DrscdXZGh8Ua+3UWss7ujrR5R9pzfxOU6DzPrAjwHo68ras6DAtgNZAgAF9dnVASa1ff
	JBXFFxY+FXEOxFdPD2S/X5GtTaMJToSyqVoTzI/TBeg/+ehBNJPsapETbTlY=
X-Gm-Gg: ASbGncuzWRbIqpQjj2qPAqFh8oegZ2vGOmYpcJu3M2fCm+2/OvMjyFpPcXmdMS/c83A
	NLvhEwo3OWZLcbq1MPYrY7gk8fDKLz0fzIuXjEWpT0I/2y8Z8e4tWonz/yL0aN9Xdd5miu+kxOC
	SuacKI0PRaSZYgdYkSsfBSdwPX6wdjCkcSt3DaUzFDGoA1hZpDJDrCc/eZ59oPW7pbUr71ZYmtH
	uoXRC5NijY/fMunTlnkYihWXyunDv4ExfVBpSEIufCyOTn/LsaagRL77nl8mejv00P9pb+w/Sw8
	bmwGblBdOI03saATA5shsBHqpE6lq3UAxXHK7ptXNSeajJhtZrcp0pFnrkqjtCNw5ussK/+nNOQ
	D9vxePvOux8OkVzocqVtf8nm5MYv/kv0NFgsyJOS8rX4/L+SGlOxj19qw6clOZmIwJ+TBgQec0j
	CjdDkpKpp7jFEv
X-Received: by 2002:a05:622a:353:b0:4e8:9f87:1f42 with SMTP id d75a77b69052e-4eb94922adcmr152955711cf.69.1761567766273;
        Mon, 27 Oct 2025 05:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH79d7Do90KoVZ1tYBoBY55fSIjzc3SaetN68K8JqBrkVyDzQwzXI4DnjU4YyJIchWS9APnNA==
X-Received: by 2002:a05:622a:353:b0:4e8:9f87:1f42 with SMTP id d75a77b69052e-4eb94922adcmr152954761cf.69.1761567765265;
        Mon, 27 Oct 2025 05:22:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0e0246sm19655221fa.49.2025.10.27.05.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:22:44 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:22:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Paul Barker <paul@pbarker.dev>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Alex Elder <elder@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Michael Nemanov <michael.nemanov@ti.com>,
        Kalle Valo <kvalo@kernel.org>, Andreas Kemnade <andreas@kemnade.info>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] net: ipa: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <g4ryfonkdpnsgqo4brx2dymo7o35jkndc5kkhdybhyvwo5rust@jwsivdbievvi>
References: <20251027115022.390997-1-sakari.ailus@linux.intel.com>
 <20251027115022.390997-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027115022.390997-2-sakari.ailus@linux.intel.com>
X-Proofpoint-ORIG-GUID: 7PylCJA0LareQf2HUMoe_9geYZgLYdzh
X-Proofpoint-GUID: 7PylCJA0LareQf2HUMoe_9geYZgLYdzh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNSBTYWx0ZWRfXx4OQuch8AzqQ
 KS+SetKFer7tAGbckhStdqBWV/WohfXTxn3p01E3q75G0IXyyf3f1oRMnDjjpcOEQ5Cp2q70osF
 0G2sUSWvi0QRBV37kdgWNnDUxQGR270RsHhpm12Io847m4n41bUF5TuGvQjMVEPHN8su3QfxsXF
 9r93G+C6RMFho25D7lgJln04OgWj+fgW2PHaaMTSW2nDD+B4bbtJ0qoDBlYFG+9o5wThIJsnGzz
 ozftaC+WIX6C3v8cjP1TXfcYTXIlvZarisl0F43ju5KndaRlDIlDeoOmiuFlN984hoaRYcvCu9o
 g/qgWVGeMKMpMV8t8lKcYMs3uBtLFnaqkxNsxSJ2XRbxgSvi78XaMyHbZry05vmvfy4NTA40SGQ
 HbW1lQ443gQBGK/+BAfgZWRB1ZLTRQ==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=68ff6417 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=QXDDecBx9f-8Df5VMo8A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270115

On Mon, Oct 27, 2025 at 01:50:20PM +0200, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/net/ipa/ipa_interrupt.c | 1 -
>  drivers/net/ipa/ipa_main.c      | 1 -
>  drivers/net/ipa/ipa_modem.c     | 4 ----
>  drivers/net/ipa/ipa_smp2p.c     | 2 --
>  drivers/net/ipa/ipa_uc.c        | 2 --
>  5 files changed, 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

