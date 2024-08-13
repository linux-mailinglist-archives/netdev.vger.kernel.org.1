Return-Path: <netdev+bounces-117986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC529502C4
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABD91F23760
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF96E1991DC;
	Tue, 13 Aug 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lQEtOPgk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028E19A288
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545945; cv=none; b=BIxv2pd13NhQ6hENz56cRovtfpG4cRX/g289toG0roIU50NdaUfNfduLPaKWhbhxFIm5b+mQxe31E/b7fmGvPJgDGRek7EKiKaZv+TfYBJYukNhhuR27ebdwF7mTh5jk/RBRoXdIf76dX/uBC00h6FmN53JFmfBEQ/InMVu2rUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545945; c=relaxed/simple;
	bh=dSSrvIrzaSFBD6AM5pRevzia/lDzCE40W+TUXd90I1g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2U6usiICVHarLBlBjSA/Jykjmmpm0Cj+mWpj+mrC4mK+JIcFPOrxrHcHSWplGi4VQoxy5YZQbnGR+1zmLArEXwL6Kv0N1VKiBf7m9xmjOOagJtpr+w4WRe37N1STI1pugtEsxmtcooCWyaAGQakU1P4E0lMbseP6+q2rCy0P1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lQEtOPgk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D9TGP6013756;
	Tue, 13 Aug 2024 03:45:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=upz99kQhapywIbZ7C5DtFIt9y
	u0TUW14BfQwSPm5riY=; b=lQEtOPgkGkI6jI/WWFkV1RllFqG/UtMvu22PnJS8p
	YG/CSKL3hy083z/F3yF4EdY/9k1PrqUzWLXCqlOVd5px6Op3AR5Y7BYZc244aEJw
	s9Gp3MoEfSQX1WXxTFfvKWSgH4VwVpTkIE1lAnviWzCO1bOQxix47Rr+3o6F5Hz1
	9/6S6ALUnnvpQBX28/Frm7PVr3f/DBRNczr7UV2mvKGX3MTWHsRjwc5YY7jeBPR8
	oHLVfQyuL4YPj6RSNTUuLYchdc9CkQYzx+pH/uJDRo/po6hG/LNq+4vsuCeLBJds
	nweiYhqbJZsvWbHb+6+NJgopQM2LHxXvyPU/xvO5r2nAw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4104w6g6gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 03:45:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 Aug 2024 03:45:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 Aug 2024 03:45:35 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 6BA933F7060;
	Tue, 13 Aug 2024 03:45:31 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:15:30 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <willemb@google.com>,
        <jeroendb@google.com>, <shailend@google.com>, <hramamurthy@google.com>,
        <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [PATCH net-next v3 2/2] gve: Add RSS adminq commands and ethtool
 support
Message-ID: <Zrs5SspHV06zP4cK@test-OptiPlex-Tower-Plus-7010>
References: <20240812222013.1503584-1-pkaligineedi@google.com>
 <20240812222013.1503584-3-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240812222013.1503584-3-pkaligineedi@google.com>
X-Proofpoint-GUID: LN4cTF62J6RcpIjqBIUyN4HmJsgbZKOT
X-Proofpoint-ORIG-GUID: LN4cTF62J6RcpIjqBIUyN4HmJsgbZKOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01

On 2024-08-13 at 03:50:13, Praveen Kaligineedi (pkaligineedi@google.com) wrote:
> From: Jeroen de Borst <jeroendb@google.com>
> 
> Introduce adminq commands to configure and retrieve RSS settings from
> the device. Implement corresponding ethtool ops for user-level
> management.
> 
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
> Changes in v2:
> 	- Update the GVE's get/set_rxfh functions to send the
> 	  ethtool_rxfh_param directly to related adminq functions so
> 	  that it can avoid the extra copy between ethtool and the
> 	  local gve_rss_config struct(Jakub Kicinski)
> 	- Remove the struct gve_rss_config that becomes unused
> 	- Add a comment in the gve_adminq_configure_rss function to
> 	  describe the device expections for the configure_rss adminq
> 	  command
> 
>  drivers/net/ethernet/google/gve/gve.h         |   2 +
>  drivers/net/ethernet/google/gve/gve_adminq.c  | 146 ++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_adminq.h  |  44 ++++++
>  drivers/net/ethernet/google/gve/gve_ethtool.c |  44 +++++-
>  4 files changed, 235 insertions(+), 1 deletion(-)
>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

