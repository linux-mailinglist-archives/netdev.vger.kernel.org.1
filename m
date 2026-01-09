Return-Path: <netdev+bounces-248398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25327D08060
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 09:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF075305F302
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A303557EA;
	Fri,  9 Jan 2026 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bcD/i2n7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MkXzc7R0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8B355814
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949017; cv=none; b=K+PviHZlwJNefzpqXb36TKO3liDGFJkkOc3DSrHNaBVaj0YBfXKQB0Vv0n13SrFDi6a/hvhdLi/Ez3EQlwOxkpgnnguJdZVY8l/GY+9/vuQaVna2Zg3wKHZa59QkR4euiQJfbGHnLAZMGgWkWnijD5uZaQbicN995VOsRY5qCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949017; c=relaxed/simple;
	bh=pcoRBv9aAvLKg8gHyqOfP6KGUTQosgpLqdecxLd+dO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhR7Nr6BdPnCUuVqewSCmbhRaNhSRBcV14lctQHyagan1K+1tdmx/U03NF9MpJQjQjXsRXFPnrhIDCXZHg+H+UbndTGEeT9H7IjJVgbm2lwKdOvC11N198j7hsGOWlBbEeSTjdn3WoR4/EwBSgiG4gsks0Zi/S379g0qJHWG1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bcD/i2n7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MkXzc7R0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6095OBQk1701777
	for <netdev@vger.kernel.org>; Fri, 9 Jan 2026 08:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QrHW9Tr+HVElYCG47HB2QSBaKxHUlz7BdKotJU7upNk=; b=bcD/i2n7oNs5Riht
	mFjbZaX3zcoGHroCczsth+Pgdr+k21Wm4Diy+TvLbp3UmmSrDL2OY8JVUS5ItEWB
	EtLcEZ6KjvtCk2y9gpXQonoIrIEc5TxfBxhAsj4YIKbQz6HJxgIMN6zk5q9FWqbq
	8V6w5MU+uGMa7Kl8QFTnlBZX33Xmm3NNwaqMyDbxl/KnWfmEfXdPv6ndvqG2uLrq
	kanS6ONqgxUWama7z8UlIA0w2JgMJhnMjagBdBmbJaviy+BsI7Ckfs2TU+QfrFF3
	rOP9lsOLgJ0TemP1ZDMQa1mNXXj8bfPdvc+Ap6yKh1SA5GFCvJyArRDTnaolKIPy
	mrrFNQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjfdaapfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 08:56:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8804b991a54so150483356d6.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 00:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949008; x=1768553808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrHW9Tr+HVElYCG47HB2QSBaKxHUlz7BdKotJU7upNk=;
        b=MkXzc7R0Muv54UI+bzqxcNNLtgHG1PhrvtUXdamxMAJWZ2v6DRkSibYqqPqCmJTepQ
         7I3lnRPi7P/c8KQ8+uqdTwdrWQ4p79tgGcTreghZNcZ2urMWbQNP3VH7hC6i/laowYJg
         dBmGitmAw9C/iKFepLQb7WCbHQyWmdhyuGXOlvsp8gnqdP0SlU6GYoVy5BT+jj3TigHz
         ZOGZQwWyAQ6iq5Hsjn5NpmIiT/9fsVXuHCxRadGfUQ9sEnRtxNFx+1bdoEXOe8BrSnMy
         SbvRL4gru3ZRUNeZi0OM2JKdn5Csff4BkuYYB8tsPJpOLqDmjLyS8e4pIU/B5Hrmf1vL
         GTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949008; x=1768553808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QrHW9Tr+HVElYCG47HB2QSBaKxHUlz7BdKotJU7upNk=;
        b=ZRoeOEUqztgP2n4B9DKvIjW8iDb+MynVaIG0r+qAySnnFydrboEjW2ds2NXnCQPAkR
         x+IiR5bPFT+wE8hWh/RmI6xKW8xm4hqPzMncpHHecyrdjI7Fcv8j+tzBRWWhVq/cC/Xo
         bB3tAuywrOVcoo8+j45a3EWjk+Pi3wa+wyFIe7OiNzXX/8JWVxh/xcBfssKuE+t9fQAB
         Q0OXwC8ezlNa8yXKVtQ5LRpM9XtEXZnhH/etAEq9+H7WC2sdihJhAZs7ihyryN8TYVPy
         VRiT4brCI8hmF8XKMc/9IIoQ40LW7PvWlblSuo/6y1TadA2g0YdHJYA9rXLaDbKmLqRd
         qu5A==
X-Forwarded-Encrypted: i=1; AJvYcCWBUH9k2FqyCD2HWjHT+Fjfv2DqRQAIrP/LwLKHWj4dNl8CJxlTz3Xzvj8dJmQVgxyNQzKFwAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8yFrOuHGu5EAxzuUZyYtpZwXpEOcQOSl6xEs0HeZ0yAYtkVn
	7errVMYM+5luhuEx0Ry9aMjcpcsxJAMNXZqB+Iq+ONDP7SM/nirB58Z4Pz0P5ZZCtqOUUe8j1UP
	+RbmkxRhnmKEAEaop70+JJcmned+Bctli5hc3hXtnyiKrlAB97bQzU+5b9Sa1cbzfNv97M14C+Z
	gZkErFwYKzE01LdMvEjX9PUse05Azqf4H75g==
X-Gm-Gg: AY/fxX5ltsVKmY2VmnxEo86HR+jMCPwDxCeNxQ9n8alYYYMzK5nMqcxaH1okRgOoR1f
	d8t2XROerXcmraARyzV41PGfmDvmUn1J49aoqbuBoWHwatAHnJsYFgNBWEjLsyHJPkO1O70xNfp
	iXHCKe63oXCWH6HuROcuMfyNv+hDAeXTBYw06RQHewLoK7dB/4AOVRg8plRx2YakRE89wQafjTG
	B6W0NplLcuCwoScAc+FWRybPbg=
X-Received: by 2002:a05:6214:5245:b0:88a:2b60:e33 with SMTP id 6a1803df08f44-8908419f702mr125742816d6.20.1767949007765;
        Fri, 09 Jan 2026 00:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXUO1drM0rMTwkFGPwZtrl9CsqBZkpMwUTSKhDcVj62wXLF1pvOCjzXTGX/DzeTfjAmCE/GlQ2X+OJ5b6l0EY=
X-Received: by 2002:a05:6214:5245:b0:88a:2b60:e33 with SMTP id
 6a1803df08f44-8908419f702mr125742626d6.20.1767949007394; Fri, 09 Jan 2026
 00:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108125207.690657-1-zwq2226404116@163.com>
In-Reply-To: <20260108125207.690657-1-zwq2226404116@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 09:56:36 +0100
X-Gm-Features: AQt7F2pEqi9e8AXeBxkAsoK07w4esu4yMUM80Kv4BgBB-omZHGrI9czmPVX93jM
Message-ID: <CAFEp6-3qMwN8rN0Muk4uB5cOu-1J68kXsPDxrJUA33kO+tM70A@mail.gmail.com>
Subject: Re: [PATCH] wwan: t7xx: Add CONFIG_WWAN_DEBUG_PORTS to control ADB
 debug port
To: "wanquan.zhong" <zwq2226404116@163.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
        haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com,
        netdev@vger.kernel.org, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, davem@davemloft.net, andrew+netdev@lunn.ch,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        "wanquan.zhong" <wanquan.zhong@fibocom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Ue1ciaSN c=1 sm=1 tr=0 ts=6960c2d0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8 a=6GUwiT5CAAAA:8
 a=zqlJmw5VrwqpryruzHUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=tp1klI1xYmtLYojU9LVd:22
X-Proofpoint-ORIG-GUID: onqijJSzr_BYCcKOJlGZNdZIVTH6OG8e
X-Proofpoint-GUID: onqijJSzr_BYCcKOJlGZNdZIVTH6OG8e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2MyBTYWx0ZWRfX4ckI7hTnRwcd
 4Z3qajW1tRXEgavSAbe4DM12Z+L0nqcZqG5DId/MfxlvIiy3GrT1wLAEkrGVifltaLTRNiPr51s
 m279jf7t41vHW5weFO0RH/uGDmr0NhGNPeE5+3lflRSQvdD0n4pzPS3INxuK3O8AABehbQKwAgY
 jKK0XpeXcCmmRowVYI/Gb02ZRJUz6alz4Ml3hV6G1YpNlJ6t2UaFtTT34Ao4YeYJ9nv5MKUVnb4
 Pupzrp0BwJ89WoRnzrlgYS8ZkaFmz84TkTU4wHKpWDWm7Zpiutw+ZmTsZqSDprNfqvBtLcYkmlB
 O5We6zWyeDzLsCxCCWBMp2dxs+QTxaOAK4Wpqe8R1gtlVYaCOQ2nWTYmgrClE/whTVgAXunsb5p
 1u086o1BEXmqyC2s3nYxyfseorv7VkDJnHlapHG4A3TjeXrgsO6MFneY1po94xPOmvD3oxLnU9l
 u8niFPMdwxjEwXx8xKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090063

On Thu, Jan 8, 2026 at 1:53=E2=80=AFPM wanquan.zhong <zwq2226404116@163.com=
> wrote:
>
> From: "wanquan.zhong" <wanquan.zhong@fibocom.com>
>
> Add a new Kconfig option CONFIG_WWAN_DEBUG_PORTS for WWAN devices,
> to conditionally enable the ADB debug port functionality. This option:
> - Depends on DEBUG_FS (aligning with existing debug-related WWAN configs)
> - Defaults to 'y',If default to n, it may cause difficulties for t7xx
> debugging
> - Requires EXPERT to be visible (to avoid accidental enablement)
>
> In t7xx_port_proxy.c, wrap the ADB port configuration struct with
> CONFIG_WWAN_DEBUG_PORTS, so the port is only exposed when
> the config is explicitly enabled (e.g. for lab debugging scenarios).
>
> This aligns with security best practices of restricting debug interfaces
> on production user devices, while retaining access for development.
>
> Signed-off-by: wanquan.zhong <wanquan.zhong@fibocom.com>
> ---
>  drivers/net/wwan/Kconfig                | 11 +++++++++++
>  drivers/net/wwan/t7xx/t7xx_port_proxy.c |  2 ++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> index 410b0245114e..0ab8122efd76 100644
> --- a/drivers/net/wwan/Kconfig
> +++ b/drivers/net/wwan/Kconfig
> @@ -27,6 +27,17 @@ config WWAN_DEBUGFS
>           elements for each WWAN device in a directory that is correspond=
ing to
>           the device name: debugfs/wwan/wwanX.
>
> +config WWAN_DEBUG_PORTS
> +       bool "WWAN devices ADB debug port" if EXPERT
> +       depends on DEBUG_FS
> +       default y
> +       help
> +         Enables ADB (Android Debug Bridge) debug port support for WWAN =
devices.
> +
> +         If this option is selected, then the ADB debug port functionali=
ty in
> +         WWAN device drivers is enabled, allowing for Android Debug Brid=
ge
> +         connections through WWAN modems that support this feature.
> +

So, ultimately, this port will depend on debugfs being enabled, so it
might be simpler to move the `port_conf/debug` attribute from sysfs
to debugfs? Additionally, the symbol config name is quite generic,
while its description is specific to ADB.

Regards,
Loic

