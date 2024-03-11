Return-Path: <netdev+bounces-79052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C90D8779FC
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 04:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B741C20399
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 03:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4999B1388;
	Mon, 11 Mar 2024 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EPoHKm/0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECC17D2;
	Mon, 11 Mar 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710127462; cv=none; b=L1f/yJKgUmmRNupvODnCOIS6sevrcbk2bs80Mwri0vjNkbTqv2BP+1v6barfdPqfamXzbAMmJ3hQ2zhdhBCWO6wJsSBEczwSOSOJ7fqTxJwQ8LGwWOZiiX58fNqwWyKUnNWGYjv8nNPDry1W84fTU4IL4pfzLvPznwDSYhMssXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710127462; c=relaxed/simple;
	bh=+21YVfBj2HYXgkX6vU5DLdMJCm3T1Pu+FF6DOoQSHqk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeY+wvkSzr1RT7qmeAp4ArjwrJou28Dy5TOJAFgEnf+tCQO147yPM58wepjqjXDiSlYrkDnamc6dm/n59jmxVkUx7p0KvGpvrdDV610GrGwQWGKHkVKmYv9ibr6MEN8JEgH/46ZO8DUW/f91CCDG4BXWrWDp2jiSKBqzWs3QqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EPoHKm/0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42AN0Sif023878;
	Sun, 10 Mar 2024 20:23:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=inpipj2OHX55A7537QcIVF
	GnFbrxLSQKw1p3RYi9n9g=; b=EPoHKm/0wTT2ODWpa0ETrs3TjebYen6GYIcVX2
	3wzLGWZp5/um5V9EQ5Uo7yzR+cl6LhJJTvL6poOrE70qheqN6GegoIZAr8Px1LAm
	NBHF6W9qnY5kul68T3fX97FQmuwGkO4ZjMumms559hUa0of9nOsxxn7k/qL/iPhd
	H3RjnI2gEa1/wP7toAXWV5zJ/B1HBqzM26RS97+3r+L3f+ZEhNTTv9uYk78Kz29s
	Ri9G5wk9lz1mSF7XukwIksSSNu3XT+T1ME8OMT/ED4qVQZV4Uu1aLFrsgbaBENFq
	5yqvS1eTg25HfYMLxMUPTIeF7U2dTBh6nlVZB/aZSvoAHVEQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wrp0p3qpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 20:23:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 10 Mar 2024 20:23:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 10 Mar 2024 20:23:46 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 998D13F705E;
	Sun, 10 Mar 2024 20:23:42 -0700 (PDT)
Date: Mon, 11 Mar 2024 08:53:41 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <edumazet@google.com>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <rostedt@goodmis.org>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 1/2] trace: adjust TP_STORE_ADDR_PORTS_SKB()
 parameters
Message-ID: <20240311032341.GA1241282@maili.marvell.com>
References: <20240311024104.67522-1-kerneljasonxing@gmail.com>
 <20240311024104.67522-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311024104.67522-2-kerneljasonxing@gmail.com>
X-Proofpoint-GUID: FVOMPelAjMetom0hE21ZWSo0rkcr7zlh
X-Proofpoint-ORIG-GUID: FVOMPelAjMetom0hE21ZWSo0rkcr7zlh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_16,2024-03-06_01,2023-05-22_02

On 2024-03-11 at 08:11:03, Jason Xing (kerneljasonxing@gmail.com) wrote:
> From: Jason Xing <kernelxing@tencent.com>
>
> Introducing entry_saddr and entry_daddr parameters in this macro
> for later use can help us record the reverse 4-turple by analyzing
Did you mean tuple ? what is turple ?

> the 4-turple of the incoming skb when receiving.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/trace/events/tcp.h | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 699dafd204ea..2495a1d579be 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -302,15 +302,15 @@ TRACE_EVENT(tcp_probe,
>  		  __entry->skbaddr, __entry->skaddr)
>  );

