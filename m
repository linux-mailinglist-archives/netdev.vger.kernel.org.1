Return-Path: <netdev+bounces-116007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F1948C47
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9491C23031
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A51BDA99;
	Tue,  6 Aug 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fvzfpPGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF821BDA84;
	Tue,  6 Aug 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937392; cv=none; b=dMJPIdV4kTyWFa2uZe90s9r9BbqbTw94Fi6Un481deRJUniutvO23LB45fIQngUYbKJoalAU4Q+Enqqz3P06bQxC4URvAW358Yz0dUj0yTOsIe8VnkSWda91kXo8Jt0qYAueECi3c686TZe9Yryw0NzzaISg3nog5md4Q5/7c8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937392; c=relaxed/simple;
	bh=omalze2Bu4iTxukzVIDOxtrfHbB5LbPErAxWcpq9vdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FhxODzyidkJ3zi1ms5LQYavs+zmpW+PPw76X2Uv1U7RMWwgfm2oh6MtyaSeUvHF4+Sa6GdvnWtVvfre48Y72GEOwGr1ZC1vrNHY6c1GX3S2Egu4eoSs0e8vbFluDgofek8++uU2beC6KPvpNr7ilFtl3Ri3rOJ14gSXrnhZ40Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fvzfpPGJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4769BwND012988;
	Tue, 6 Aug 2024 02:43:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
	Agl40LLFB+MRtquRidYE5l/zqA/1VfO5ifHr76CpR4=; b=fvzfpPGJnSj/IQLYN
	GP/53Ny7+r8jKL+F7kYNyZvaakWD0zYhEchiU/rzxGIr2+tZI/gjYf6NIJGy7r4g
	3kpsxMUOlS05kqEmazgtEHRDAsou+iGc1Q+LZX+HsG6LA53DBknRmszgjyBn9uNz
	kA6OXWKIKu0a/wmheZRC1ilpddWdyI1T4HfvKq63h0BdBpLi6EKc6VLniBN4rSBD
	T0AdX2loxYDQnU+vJji/Ya90VZvZqOGGzJb2gz3a4FhMaV/1cYQOI5sKJw59ynFt
	I7+rvKcgUcuFgT4zNLV24CsmVwGD2RsdUx3ppCNju4sBvgZaQ9oRkGHfqZVNYTV+
	9nizQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40uh0603vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 02:43:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 02:43:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 02:43:00 -0700
Received: from [10.9.8.37] (EL-LT0043.marvell.com [10.9.8.37])
	by maili.marvell.com (Postfix) with ESMTP id 25D203F70BD;
	Tue,  6 Aug 2024 02:42:57 -0700 (PDT)
Message-ID: <0d0a030c-b1ba-77a7-71f5-55448f6797f6@marvell.com>
Date: Tue, 6 Aug 2024 11:42:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH][next] net: atlantic: Aavoid
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <ZrDwoVKH8d6TdVxn@cute>
Content-Language: en-US
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <ZrDwoVKH8d6TdVxn@cute>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oe-13ZfwP1zmYsCuprxFON-PezLvGPkZ
X-Proofpoint-GUID: oe-13ZfwP1zmYsCuprxFON-PezLvGPkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_07,2024-08-02_01,2024-05-17_01



On 8/5/2024 5:32 PM, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally. Move the conflicting declaration to
> the end of the structure. Notice that `struct hw_atl_utils_fw_rpc` ends in
> a flexible-array member
> 
> Fix the following warnings:
> 
> drivers/net/ethernet/aquantia/atlantic/aq_hw.h:197:36: warning: structure
> containing a flexible array member is not at the end of another structure
> [-Wflex-array-member-not-at-end]
> 
> drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:197:36: warning:
> structure containing a flexible array member is not at the end of another
> structure [-Wflex-array-member-not-at-end]

Hi Gustavo!

I was abit curious about this variable length structure, because it looks strange and not actually used by driver.

I've cross checked, and its really some outdated declaration. The structure is never used as as a flex sized struct.

So better would be to do just this:

--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
@@ -226,7 +226,6 @@ struct __packed offload_info {
        struct offload_port_info ports;
        struct offload_ka_info kas;
        struct offload_rr_info rrs;
-       u8 buf[];
 };

Let me know if you want to submit this, or I can do this as well.

Regards,
  Igor

