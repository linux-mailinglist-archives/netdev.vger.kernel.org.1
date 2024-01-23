Return-Path: <netdev+bounces-65073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026988391D8
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 15:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344551C212F6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5195C5FB;
	Tue, 23 Jan 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a7mxkQ6B"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762E5F542
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706021974; cv=none; b=TdWFOGryeCYnBJ6DcbSP54o+R7Je6u2BrihALwnDKo4FTUGFwQolErJd/lOAmAvcroiUPTdPfs9FWMkbOExTSwLttvFsWK1By9JGL1SaPBSVsSqbzOC4W3yQRNEPbB9kIgV/zxjMecLqEByu2zEv3kZEu9NEBIYGDwKTvVz+3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706021974; c=relaxed/simple;
	bh=hbq2Ip+l0s9cdTzMELIa2Ow3WQyhT3Z+nwiNab8iUNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q1ljrnUNRrPYWA8TuoqeUIcLy5k++fQJAZxVyuIaPFLMsSZUOIoucwxk4NY6kyjbxkmCwF3cc20hSthpg8EWw8ckOeaRsfuquhMU2Ahg+CKj79i9o6ZWohA2B196TkWdyI6wjkbqa9eNw1VUgxqBf1jaXJ21H6v6eqQ4Jde1pYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=a7mxkQ6B; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N3rlqJ021252;
	Tue, 23 Jan 2024 06:59:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pfpt0220;
	 bh=9U5mv0O76n2Y2llr4uw8VMXS2WnWlAODU+rtqRjMnI4=; b=a7mxkQ6BrHix
	Zqkp8VokCtvE+3xJClzAtI+qmXYnh3uTOUDVLg4ZAd4M1nXjK1R6O4JAmg5szgd9
	s0xEumnn0Em0AOV+QEZ5RDnoDPmvAgxFm/5KUkorpNn9mWxvjjhkUY/vbvA/XBMH
	k5+xoHQuqnECm8vuJb/4RGRp+ILCi4O+c6yTWo9Y8sWy1okJV1i7ywSaDRbOSYMe
	85Ww3Rf8uW2p/zn8maeos5m6RjdiR82ehaB94de07LQdFC3bKABrNp2UM0PTNaHg
	ZfCC+fYZxZMvJD0xp3IlTyJynurloOsTHlislT6j7G/n/6RNShlDr4SR1BGnrgis
	oqM+zxaJIQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vt5y21x0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 06:59:05 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 Jan
 2024 06:59:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 23 Jan 2024 06:59:03 -0800
Received: from [10.9.8.28] (unknown [10.9.8.28])
	by maili.marvell.com (Postfix) with ESMTP id C3C8D3F7067;
	Tue, 23 Jan 2024 06:59:00 -0800 (PST)
Message-ID: <3b607ba8-ef5a-56b3-c907-694c0bde437c@marvell.com>
Date: Tue, 23 Jan 2024 15:58:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
To: Peter Waller <p@pwaller.net>, Jakub Kicinski <kuba@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Netdev
	<netdev@vger.kernel.org>
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
 <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
 <20231127145945.0d8120fb@kernel.org>
 <9852ab3e-52ce-d55a-8227-c22f6294c61a@marvell.com>
 <20231128130951.577af80b@kernel.org>
 <262161b7-9ba9-a68c-845e-2373f58293be@marvell.com>
 <e98f7617-b0fe-4d2a-be68-f41fb371ba36@pwaller.net>
Content-Language: en-US
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <e98f7617-b0fe-4d2a-be68-f41fb371ba36@pwaller.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sdQPBL8xygoux38Eg6clEH_qz_VJ8l90
X-Proofpoint-ORIG-GUID: sdQPBL8xygoux38Eg6clEH_qz_VJ8l90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_08,2024-01-23_01,2023-05-22_02


On 1/21/2024 10:05 PM, Peter Waller wrote:
> I see a fix for double free [0] landed in 6.7; I've been running that
> for a few days and have hit a resume from suspend issue twice. Stack
> trace looks a little different (via __iommu_dma_map instead of
> __iommu_dma_free), provided below.
> 
> I've had resume issues with the atlantic driver since I've had this
> hardware, but it went away for a while and seems as though it may have
> come back with 6.7. (No crashes since logs begin on Dec 15 till Jan 12,
> Upgrade to 6.7; crashes 20th and 21st, though my usage style of the
> system has also varied, maybe crashes are associated with higher memory
> usage?).

Hi Peter,

Are these hard crashes, or just warnings in dmesg you see?
From the log you provided it looks like a warning, meaning system is usable
and driver can be restored with `if down/up` sequence.

If so, then this is somewhat expected, because I'm still looking into
how to refactor this suspend/resume cycle to reduce mem usage.
Permanent workaround would be to reduce rx/tx ring sizes with something like

    ethtool -G rx 1024 tx 1024

If its a hard panic, we should look deeper into it.

> Possibly unrelated but I also see fairly frequent (1 to ten times per
> boot, since logs begin?) messages in my logs of the form "atlantic
> 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0014
> address=0xffce8000 flags=0x0020]".

Seems to be unrelated, but basically indicates HW or FW tries to access unmapped
memory addresses, and iommu catches that.
Full dmesg may help analyze this.

Regards
  Igor

