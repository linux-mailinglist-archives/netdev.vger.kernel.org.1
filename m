Return-Path: <netdev+bounces-100826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9798FC2D2
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 06:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19721C22606
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CFB7347B;
	Wed,  5 Jun 2024 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kwrZnMqW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98861FC6;
	Wed,  5 Jun 2024 04:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717563071; cv=none; b=HxqK/jhO5IUyOR4j3xLM8+KNh94PKRpex8KTVVC/dm8mqfFIeYhim1BYS6N/SefcDh/DIimSAiS11ysKjsahwaHu9U90Z5ksVqUjpU483+IusFfATyGepjQ0XKRhG/7EkHOMS5a6Fiq9kaIf5dZIimIn6c0KNLSs+N3FYHXEOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717563071; c=relaxed/simple;
	bh=IDc6ujVuOTHOaHdN/xtBa1iDkOFL97kXwy4RC0H8QRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHui0dFnMVP2moD1ATOFIqM3yax95kI/zFN8lrkDx9AQRQSnf/tabPQvwvHVGE5J4wiRlmc5bPSoKNee5Fgjte/4r+8tu7XW2cTbLFxPMaCOJAkaRJe7PTpT7SwXImLe3GFuUpLWqtrW2Hv/Abh1b0+IXTOl9zbhJZYBOOZcXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kwrZnMqW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454KXfJ9003930;
	Tue, 4 Jun 2024 21:44:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=OKNIK6PQn1SUEDYPQ/4MC5ygM
	mYXQNZukQIA+FsOkDc=; b=kwrZnMqWrvwVKrucKc6RKSWiZfEU9gx4dyqkPN9rJ
	5aXlgh7Ub43U16sepdDCYwm7WiaQyLgNvlludMmNgSReH27HtRp8pv6Fvj47WDu5
	N/xy8R5CymSRAK4DdRm/6C+FO10qgU9mL45YaWfuHmc8AgbFrUYsBaFMiel3y5i5
	v8OcaH4Vwg6egSl/QEAY5o5S26+hGDMmGHHfDY60kIkLAYRyUedV635AT97LLymZ
	QuRyM0uHZD/uo6OcA5Qzt434M0paVA7az1h0R/i3KgEUsIOCQCqtBBJYWdSlVxmZ
	dAqSob5466SHHAh/xL51oqOz+KSlvV0PMgpN19lxMrajQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yj167bw8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 21:44:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 4 Jun 2024 21:44:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 4 Jun 2024 21:44:47 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id EE0DB3F7040;
	Tue,  4 Jun 2024 21:44:42 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:14:41 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <0x7f454c46@gmail.com>
CC: Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Steven Rostedt
	<rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/6] net/tcp: Use static_branch_tcp_{md5,ao}
 to drop ifdefs
Message-ID: <20240605044441.GA3452034@maili.marvell.com>
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
 <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-1-e91e161282ef@gmail.com>
X-Proofpoint-ORIG-GUID: gFkNoHKrv-1PWaojsDgW1P09mPHzPUGV
X-Proofpoint-GUID: gFkNoHKrv-1PWaojsDgW1P09mPHzPUGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01

On 2024-06-05 at 07:50:02, Dmitry Safonov via B4 Relay (devnull+0x7f454c46.gmail.com@kernel.org) wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> It's possible to clean-up some ifdefs by hiding that
> tcp_{md5,ao}_needed static branch is defined and compiled only
> under related configs, since commit 4c8530dc7d7d ("net/tcp: Only produce
> AO/MD5 logs if there are any keys").
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> ---
>  include/net/tcp.h   | 14 ++++----------
>  net/ipv4/tcp_ipv4.c |  8 ++------
>  2 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 08c3b99501cf..f6dd035e0fa9 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2386,21 +2386,15 @@ static inline void tcp_get_current_key(const struct sock *sk,
>
>  static inline bool tcp_key_is_md5(const struct tcp_key *key)
>  {
> -#ifdef CONFIG_TCP_MD5SIG
> -	if (static_branch_unlikely(&tcp_md5_needed.key) &&
> -	    key->type == TCP_KEY_MD5)
> -		return true;
> -#endif
> +	if (static_branch_tcp_md5())
Seems that we lost unlikely hint. Dont we add that as well-> unlikely()
> +		return key->type == TCP_KEY_MD5;
>  	return false;
>  }
>
>
>

