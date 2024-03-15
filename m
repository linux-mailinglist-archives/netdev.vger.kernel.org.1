Return-Path: <netdev+bounces-80014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A4387C773
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 03:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4EDB220A2
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384446FBD;
	Fri, 15 Mar 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C9zMPgEA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F746FB1
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469438; cv=none; b=m45Dh6bTQBq5xrZOezvKcJP8i7aGZ+hnecjkxrjpkPwCMqp9UC5nLxNyIKyqj9w32KfRe/VAib1bah/CcLTbwLS2Jll8ECCuFjsEQ2VHMPVz9h2KbatELzlQyAA1TW2ulXQRS+euUoRM5MWWY5T3jfxOJYxMmL2qlkGbPVcku9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469438; c=relaxed/simple;
	bh=bMlPUfZLBDrD/vfWCTo2qqSy+Sbz7wL3rnbMSHoInAA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWMYb9C14nG+wp9e91fenMtymaPon/alZCT3fiZXWKUshekxg+SdzY0Ygy8HTLyK2p1LdsakT7C6qZ6jr4CasZo9N3P/F1jPQdYA8vYSf/yEUqbzmzrXQiexjoep/hAZI5sM/8cAetzGvq5cRfwq37e7By7tOwsUTELil6JT7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=C9zMPgEA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EMJhd6001277;
	Thu, 14 Mar 2024 19:23:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=2Bbzjyt37DcT26jHvWcP3O
	0UUXUrzfeukJxzMFdf26M=; b=C9zMPgEA8UNjuD69pYnSUK3DbCI/FBLoLyG32h
	e2tBPublCBEGGmBX6E5CYaKNbZn0lyttO6JSN4bNgAuJ9te8ojJN3bj6nxsAgSO5
	zviaR4cZxdeRadOUABNYhwjCF7zoF/K7Vra45LGXsdO+KuiaHDFG8hKlB4tfcELb
	niYHfhHHjddp2bJLJ4tWmIJDWqOlvhq6nB6+V1NL4cF6uOqbQxkq1O7sgsnJ1GA3
	b8F05U6FHoSYmpxe+L8TtmyhW5yIzN2gj9K0fxianPUyVicW0pr9pdk6FgfX7nhh
	bYRERNcOoEoUJKRhE/LAgucY6h75ozXJpPKUAqfYO7/nWQFQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wv9xa0mdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 19:23:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 14 Mar 2024 19:23:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 14 Mar 2024 19:23:32 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 766333F703F;
	Thu, 14 Mar 2024 19:23:30 -0700 (PDT)
Date: Fri, 15 Mar 2024 07:53:29 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Denis Kirjanov <kirjanov@gmail.com>
CC: <stephen@networkplumber.org>, <dsahern@kernel.org>,
        <netdev@vger.kernel.org>, Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH iproute2] ifstat: handle strdup return value
Message-ID: <20240315022329.GA1295449@maili.marvell.com>
References: <20240314122040.4644-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240314122040.4644-1-dkirjanov@suse.de>
X-Proofpoint-ORIG-GUID: UKqJs2ATk9_IFXZOAn1bUkguYB1Wty4P
X-Proofpoint-GUID: UKqJs2ATk9_IFXZOAn1bUkguYB1Wty4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02

On 2024-03-14 at 17:50:40, Denis Kirjanov (kirjanov@gmail.com) wrote:
> get_nlmsg_extended missing the check as it's done
> in get_nlmsg
>
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  misc/ifstat.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/misc/ifstat.c b/misc/ifstat.c
> index 685e66c9..f94b11bc 100644
> --- a/misc/ifstat.c
> +++ b/misc/ifstat.c
> @@ -140,6 +140,11 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
>
>  	n->ifindex = ifsm->ifindex;
>  	n->name = strdup(ll_index_to_name(ifsm->ifindex));
> +	if (!n->name) {
> +		free(n);
> +		errno = ENOMEM;
strdup() will set the errno right ? why do you need to set it explicitly ?
> +		return -1;
> +	}
>
>  	if (sub_type == NO_SUB_TYPE) {
>  		memcpy(&n->val, RTA_DATA(tb[filter_type]), sizeof(n->val));
> --
> 2.30.2
>

