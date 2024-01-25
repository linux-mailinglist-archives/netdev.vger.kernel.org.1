Return-Path: <netdev+bounces-65912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E433383C5F5
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 16:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0801F26962
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E385633F0;
	Thu, 25 Jan 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QSH+IOcz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBE3A1B6
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194716; cv=none; b=mXYuwTNBpW24xy/NBon4YShAcwAFtdJCEz9LD25ZNKxf/7pn5STeoaSoIEYsXWs5kJch9LouRhDemYNrQOhfFXhmdPMt/GZWQiv212Ca5/H0HhLT94Yp0ZE2/5O3j1VFtHgXl/4qb0qCuLucPRLMywnx5gp8L1SSoCK1QqO7khg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194716; c=relaxed/simple;
	bh=rd6oVQa+k79eRxijjYNuA9nITD36Vt//Tdbgl8Y9V0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SSsdhIw0u2otY75xdcDoGmhEjcxlBX/tG53LVx34C7+q/GJASjCnin7LWayY98RJITE8VTC6gEao89U/GErz9mOnogHjPrnMaN6F+3l7VbJ2xEe4RQm/OBtxHxsJ6qL2gPCzKysOB8DyHE7gCcdPip+VODY0NNzErCTv1K5CKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QSH+IOcz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5MMgO001493;
	Thu, 25 Jan 2024 06:58:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pfpt0220;
	 bh=1AI9tTIT4DZn/0HfsAZ6EULmpHvXVdOqQb84r6NaMZY=; b=QSH+IOczlpcN
	Nd6ZjX/zTtmBzBljCqZGX0fgLIHrfyLWYdTY53ixdTdmV3ywc590HbGWWUuBYiVs
	h1NBoK7ucOQJeFh4I0Pmwv1elPGlFhnuBWQR8gjth26+BsUkXeiuucjhYw3cfSOU
	9lTW3E28GYGYs9AVuPrwxQ044eCHCHNq3tDpMT8l5xdJJDm5ec2EmC52iaej1/xW
	vffGM0xOFRIxjcx0I0mWrOHPs39JuE6F+jR05mCs87DPAJ1USsR0Sdlk5HLSLw4U
	ZxeMGZUzmYx4x9D1qMyTT5F1Adl7SgsM+j2VToQVq6lOkNziXp6HuynDfBBROaSs
	Z01k6datlQ==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vuhehswh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 06:58:19 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 25 Jan
 2024 06:58:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 25 Jan 2024 06:58:18 -0800
Received: from [10.9.8.28] (unknown [10.9.8.28])
	by maili.marvell.com (Postfix) with ESMTP id AA6243F7044;
	Thu, 25 Jan 2024 06:58:12 -0800 (PST)
Message-ID: <02c93063-a6a3-8992-38dc-b978529736c4@marvell.com>
Date: Thu, 25 Jan 2024 15:58:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
To: Peter Waller <p@pwaller.net>
CC: Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>,
        Netdev <netdev@vger.kernel.org>
References: <3b607ba8-ef5a-56b3-c907-694c0bde437c@marvell.com>
 <E8060D65-F6C2-4AF5-AE3F-8ED8A30F95EF@pwaller.net>
 <32a0ccb2-9570-4099-961c-6a53e1a553d7@pwaller.net>
Content-Language: en-US
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <32a0ccb2-9570-4099-961c-6a53e1a553d7@pwaller.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VgzmYXV5kxHpWpjVPFqiFXNXTWAGUUrT
X-Proofpoint-GUID: VgzmYXV5kxHpWpjVPFqiFXNXTWAGUUrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02



On 1/23/2024 10:02 PM, Peter Waller wrote:
> Here's part of the log, I can provide more off list if it helps. - Peter
> 
> <n>.678900 atlantic 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0014 address=0xfc80b000 flags=0x0020]
> <n>.679124 atlantic 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0014 address=0xffeae520 flags=0x0020]
> <n>.679270 atlantic 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0014 address=0xfc80c000 flags=0x0020]
> <n>.679411 atlantic 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0014 address=0xffeae530 flags=0x0020]

Thanks, these looks like descriptor prefetch accesses (those aligned by 0x10), and packet page accesses (aligned by 0x1000).
Overall strange, because driver normally deinit all the device activities, not to access host memory after unmapping.

I will check if there any potential flaws exist.

Regards,
  Igor

