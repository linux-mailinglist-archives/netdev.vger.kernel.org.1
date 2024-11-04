Return-Path: <netdev+bounces-141477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EADA9BB12D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2871F21EF4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A91B0F3F;
	Mon,  4 Nov 2024 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fiOh2zK+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CAC1AF4EE;
	Mon,  4 Nov 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716398; cv=none; b=NoDkSKRb75BmGSd9/x7x2vdBllM2RkKRnjfzCmolpwyHEsOm1D2M42iMYrP3yy1F+LmNjwmgfOKJxLt9tbklvO9S5FBz4SMmONf2VnWGRgp1aTnPBASJ5gta94Zx31bKOez5icKTQ1dtZ9pvAbp08ASuxQGH12jcQV5v4s9PuNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716398; c=relaxed/simple;
	bh=svst8OGUMlZylRccdJu4iOgYQQUzQhgRSd9Xv0HrwUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3OTjK+KwwuRLpgNC5qly8rJPhp2bOn5A5tDvg+CLawO+kOTirJU79gtOcTqHn0ObJLloZdxBY7Zbx9G561CsS06G3qnh7egyLJCaH/tyoWY5wv53uRCQHewJyIAJX/3GlvsiLfUuj0SIsVZY39c8Z9wrsdMb7zue6JtRJJhJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fiOh2zK+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3NtIdS005897;
	Mon, 4 Nov 2024 02:33:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=i8GqAegxWCT+zI39+/QY9Nu9Q
	lsIexIY5JgeQZhdrOk=; b=fiOh2zK+kUviQvKXmdnn91MhBL6HyF5+b0GudJEkx
	3mQFId8Wr/dLEtvE3QFz4UWisTLdLAcjMReOzS7wJBOto/nrjFDiB7i7EmZ4RgSL
	VAwDvAWTdcx2jDR3rRUlyxnPCbG0zt29+V8i9gmRVljrNeQMq5mW5PBz+d5ACxwk
	VNIT+L8EfvuJg+a4JSouAXKb5eyYRqNjTxiVS5Yh9y/GyBFBefKokvPN7nudmB1k
	pX2TYd31vd1GbG6pz8EKWqHPgOhIfNMMKpBHRMy/Fmx56SpCBXaeNYWSVklz/Buq
	DD8GFE8zTZ/XQsWUIqJfevCFrKGfmlUDvsPH45TG0LrKw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42p4u69k4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 02:33:10 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 4 Nov 2024 02:33:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 4 Nov 2024 02:33:09 -0800
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 0E90E3F706D;
	Mon,  4 Nov 2024 02:33:04 -0800 (PST)
Date: Mon, 4 Nov 2024 16:03:03 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <jerinj@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.comi>, <jiri@resnulli.us>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 3/3] devlink: Add documenation for OcteonTx2
 AF
Message-ID: <20241104103303.GB1011185@hyd1403.caveonetworks.com>
References: <20241029035739.1981839-1-lcherian@marvell.com>
 <20241029035739.1981839-4-lcherian@marvell.com>
 <20241103115548.35d0cbdf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241103115548.35d0cbdf@kernel.org>
X-Proofpoint-ORIG-GUID: dlGh943-7gwfqiF9_bm9YyhlSXx2EEg4
X-Proofpoint-GUID: dlGh943-7gwfqiF9_bm9YyhlSXx2EEg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Hi Jakub,

On 2024-11-04 at 01:25:48, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 29 Oct 2024 09:27:39 +0530 Linu Cherian wrote:
> > +   * - ``npc_def_rule_cntr``
> > +     - bool
> > +     - runtime
> > +     - Use to enable or disable hit counters for the default rules in NPC MCAM.
> 
> How are those counters accessible? ethtool -S? debugfs ? it should be
> documented here. Plus please add examples of what such rules cover.
> "default rules in NPC MCAM" requires too much familiarity with the
> device.

Ack. Will address this.



