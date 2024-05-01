Return-Path: <netdev+bounces-92696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F618B84CE
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 06:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3594D1C22142
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 04:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7B739AF9;
	Wed,  1 May 2024 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ST8i1l22"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89415EED6
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537186; cv=none; b=pkI5GVDjP1/egZwCrActM2PHgGOnljMKOf7xRyx+K0ZlWbTe71IpF37uvQUExiWFNbTU6vBZnrrsir9G4IPYOCiJmoeO99PdYUfZYq+HXFXb+giZfDTSMNHrtIN/o5/dfJK6Pzt0H73BAL5PPSf8Z4aJ7ukkg8TnGeLiHUmVXD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537186; c=relaxed/simple;
	bh=6qtIv1A/6gzR6+WM+uUnO3TBecuCWN+ng31E+xL6QiQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcpHvHLNgaQ0uAQ7MLdpRCF1RAxjrmkBcW1k3GHxx1PSov9VYp3mLssbC/FUlmRMTgDIdc8kZHAvMpa9qT39/pb5H9u9xjMIF+z6TR1b+06XPMyMjrJjDovimjeqtlzh6ek4BedmkAjun1PchCLxL7t1t+zyGbO0nsiHSllufBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ST8i1l22; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UJWw9H032428;
	Tue, 30 Apr 2024 21:19:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=Udizz/8rt8om3ZHC7850gp
	tfu5s9Mf0Pr7LlK3lq7Y8=; b=ST8i1l22Ec2w+rXLJtFF7YAwaiFcEKbM+fxEev
	sWRMv6H/yXPIVw3MxEOM1/sMZOlp/tdbashLrJdB0DGlMW0yzK8gXogNwQ73Kc+C
	EBuqVTOZxctXqCnjunajIpUDtiGBeilY/zwqOoy61hYrlKoyaILmcrPbhsP85Ibr
	0sAurmy0SpJrHqhvDLRlufoKdBojucPtyaR6y6NUy341JossKGRWfFyviK8ipRQy
	V63ik3sVM6NcX9MwpDh70E97OV9+k9OENCJOdPw0Wy+MmfAmnSjwsh8RiISxDSaX
	erFZdZFT+7b1b4xfc6mCS+i6Y3mI1npa39EOCSsKK/tv1zHQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xtwuwkwsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 21:19:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 30 Apr 2024 21:19:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 21:19:35 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 0D5AD3F704A;
	Tue, 30 Apr 2024 21:19:31 -0700 (PDT)
Date: Wed, 1 May 2024 09:49:30 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Shailend Chand <shailend@google.com>
CC: <netdev@vger.kernel.org>, <almasrymina@google.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <hramamurthy@google.com>, <jeroendb@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <pkaligineedi@google.com>,
        <willemb@google.com>
Subject: Re: [PATCH net-next 03/10] gve: Add adminq funcs to add/remove a
 single Rx queue
Message-ID: <20240501041930.GA72628@maili.marvell.com>
References: <20240430231420.699177-1-shailend@google.com>
 <20240430231420.699177-4-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430231420.699177-4-shailend@google.com>
X-Proofpoint-ORIG-GUID: _OOaWoAY1E5_qU_6FuxwKk9kyAdXoHDn
X-Proofpoint-GUID: _OOaWoAY1E5_qU_6FuxwKk9kyAdXoHDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_03,2024-04-30_01,2023-05-22_02

On 2024-05-01 at 04:44:12, Shailend Chand (shailend@google.com) wrote:
> +int gve_adminq_destroy_single_rx_queue(struct gve_priv *priv, u32 queue_index)
> +{
> +	union gve_adminq_command cmd;
> +	int err;
> +
> +	gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
> +	err = gve_adminq_execute_cmd(priv, &cmd);
> +	if (err)
why can't you return err directly ? no need of if statement.
> +		return err;

> +
> +	return 0;
>

