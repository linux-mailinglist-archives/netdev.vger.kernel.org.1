Return-Path: <netdev+bounces-117916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DC194FC91
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 06:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5494C1F2254A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 04:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102FC1C286;
	Tue, 13 Aug 2024 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="d7tPA2ao"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337D1B815;
	Tue, 13 Aug 2024 04:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723522421; cv=none; b=VeEEOWy+P8yE8bHBHv+fH9qBSeu9JIrosyxw4SsikLv/NG9L4MqAVGeXVW1xD6RjIuCstFmrQ0FFfwoJdK80jq4KKIUFqYU5QPx5EqrdYbsXcxWPfDfuNVqjMfAwi1cLZOFSBA2Fj0+hT9EvHLNcm7I4yx320A5RdQdSyD4UK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723522421; c=relaxed/simple;
	bh=LYIvitUcELWVGkRg3HU1QSfzzWLY1Z1lMk+SgxZaWv4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSEJshfmIfaKrK0rUJ5wIxYHQB9M+W+BecQltFMqHaSTdH6Ryqgcz6zUt5qQQ9//uAjhYq3PWPwpe+9fcF9hVLhkrJ908vhL3z9GQJ1cgPKVgXctwA2RLdNxKxkD/jcRjZs2as70HjGxrNqpCnXwnBdC8ThwPjldY26PLYNUKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d7tPA2ao; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CN03IS028173;
	Mon, 12 Aug 2024 21:13:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=SEp3qwk4GT0xlQatDRuLHX4RJ
	Hy/o8pdyqFPySWqAS4=; b=d7tPA2ao/7cLfAGdMrLQweuu0v3Y4xuVCcHniImw4
	VY5q4IR9Nl9F9f4bBPG5f5eDhRxk8LTwWe7FevuqYo9/cmLJHLVzyJQnubX2X41N
	i6r09TCNozL/4GQmCfpmz46cPZwkAuvXd+4FS4EtORaPGI6D+l9X3131Wanbl3X3
	MZtN8jf3gszCf9NTNcGhobsFZibQJhieaDZnDBq+TXzKnjIQicswh5dgQYvQVIcT
	vvAFlZFtOdhPBJtOHDMdN/SpoAyXr/r0JdbyouHPK0Jhd1le45N3x4tUtCyYrViu
	moAJOaZM4kPNA+CFJ0yyj9S714uro+fxsqWcAa2WBDyCg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40yup38vta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 21:13:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 Aug 2024 21:12:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 Aug 2024 21:12:59 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id EF7D43F704B;
	Mon, 12 Aug 2024 21:12:54 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:42:53 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <daiweili@gmail.com>,
        <sasha.neftin@intel.com>, <richardcochran@gmail.com>,
        <kurt@linutronix.de>, <anthony.l.nguyen@intel.com>,
        <netdev@vger.kernel.org>,
        Przemek Kitszel
	<przemyslaw.kitszel@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net v1] igb: Fix not clearing TimeSync interrupts for
 82580
Message-ID: <20240813041253.GA3072284@maili.marvell.com>
References: <20240810002302.2054816-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240810002302.2054816-1-vinicius.gomes@intel.com>
X-Proofpoint-ORIG-GUID: 8SkyDvNSPllJkWS5yqlAv2-2pAbWRIVY
X-Proofpoint-GUID: 8SkyDvNSPllJkWS5yqlAv2-2pAbWRIVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01

On 2024-08-10 at 05:53:02, Vinicius Costa Gomes (vinicius.gomes@intel.com) wrote:
> @@ -6960,31 +6960,48 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
>  static void igb_tsync_interrupt(struct igb_adapter *adapter)
>  {
>  	struct e1000_hw *hw = &adapter->hw;
> -	u32 tsicr = rd32(E1000_TSICR);
> +	u32 ack = 0, tsicr = rd32(E1000_TSICR);
nit: reverse xmas tree.

