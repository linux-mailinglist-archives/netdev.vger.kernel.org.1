Return-Path: <netdev+bounces-141806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A29BC4B0
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 06:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CAC1C213BC
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A01B4F1E;
	Tue,  5 Nov 2024 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="h3z4zxO1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C5383
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784403; cv=none; b=RmVRExqOiy4/SmmNhGYogIHuE2aJKHiLRxRMQsie6nP7K2wtYGdC7yIdNS3Qmk1UqjlijNd+vJm6OTe5lHIN0mB21jx3zrhgvQfl3Dnyo0x+9wpENiQC7Bd5jKB/0zFp2mGTg8oSNHaxI9ETwwS1aZddXKsEvDlXegGFVb0yNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784403; c=relaxed/simple;
	bh=KEMbNZ7uAVR+QqCJJJo4jU+gZDF2ubUZIdx1oJThLVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKTUFrez8GYxh7mAquRDK1PEHLV1tH+6YTvIjsDJYUPaJZkWTd1cdIPGTl/HE0yqiaT+AP5pFgX5uy4LJUExyPEmIgsOtScPYcLG2wxyJ6VELbiR0NGP5NxYN8rWisLYgQTk5gLcBwd70sGhDLeXO3STmD6lGzQtHBb7wm7R4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=h3z4zxO1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GxaT0018003;
	Mon, 4 Nov 2024 21:26:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=UVm9e2rzzPVDQWjLYEoBlH19i
	TjAYCVk2t8F1FvXufU=; b=h3z4zxO12QbbpQjDRC9/lcgIf6KJcjMmq99gp1eLW
	U6mnF69djORQl4n/iBs/EphGW3JK6e2kfyapLbOeU1qqEhZu7USavsamOszbBAi2
	4Fp/Kqv+qVmS0WIsLFvdUUUG3NaGEm0ON8Y087oxKUOFusLN645RpZScdSG3gShQ
	KDVWmohViywpfh0nn1Wde2xPXI/3x+8VUsjj4KEBGy8Eaap8tuePh1OP3FNBpjN7
	wfxjd9diFsXhx4o6Dqva4O2wzz48Gijgh1n337xUzZA/M15eEL00dxkqzoAu/Q2P
	3OemlTDudGoHxG4/tyRiLIZnmh07UIgMimpr2ARyd/aww==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42nkkjvrr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 21:26:29 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 4 Nov 2024 21:26:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 4 Nov 2024 21:26:27 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 4784B5C68E3;
	Mon,  4 Nov 2024 21:26:24 -0800 (PST)
Date: Tue, 5 Nov 2024 10:56:23 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <andrew+netdev@lunn.ch>,
        <netdev@vger.kernel.org>,
        Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
        Przemek Kitszel
	<przemyslaw.kitszel@intel.com>,
        Simon Horman <horms@kernel.org>,
        Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net 2/6] ice: change q_index variable type to s16 to
 store -1 value
Message-ID: <Zymsf2A9KMxROZkh@test-OptiPlex-Tower-Plus-7010>
References: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
 <20241104223639.2801097-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241104223639.2801097-3-anthony.l.nguyen@intel.com>
X-Proofpoint-ORIG-GUID: wr44Q_08cla3jSGg7XHxZ6GBaf6zdS_c
X-Proofpoint-GUID: wr44Q_08cla3jSGg7XHxZ6GBaf6zdS_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 2024-11-05 at 04:06:30, Tony Nguyen (anthony.l.nguyen@intel.com) wrote:
> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> Fix Flow Director not allowing to re-map traffic to 0th queue when action
> is configured to drop (and vice versa).
> 
> The current implementation of ethtool callback in the ice driver forbids
> change Flow Director action from 0 to -1 and from -1 to 0 with an error,
> e.g:
> 
>  # ethtool -U eth2 flow-type tcp4 src-ip 1.1.1.1 loc 1 action 0
>  # ethtool -U eth2 flow-type tcp4 src-ip 1.1.1.1 loc 1 action -1
>  rmgr: Cannot insert RX class rule: Invalid argument
> 
> We set the value of `u16 q_index = 0` at the beginning of the function
> ice_set_fdir_input_set(). In case of "drop traffic" action (which is
> equal to -1 in ethtool) we store the 0 value. Later, when want to change
> traffic rule to redirect to queue with index 0 it returns an error
> caused by duplicate found.
> 
> Fix this behaviour by change of the type of field `q_index` from u16 to s16
> in `struct ice_fdir_fltr`. This allows to store -1 in the field in case
> of "drop traffic" action. What is more, change the variable type in the
> function ice_set_fdir_input_set() and assign at the beginning the new
> `#define ICE_FDIR_NO_QUEUE_IDX` which is -1. Later, if the action is set
> to another value (point specific queue index) the variable value is
> overwritten in the function.
> 
> Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---

Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

