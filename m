Return-Path: <netdev+bounces-220695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C2B482B4
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 04:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EAA7A1C95
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 02:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188D1D63F0;
	Mon,  8 Sep 2025 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRKLiVxM"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FA7263E
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757300042; cv=none; b=B5SVq2yXA0lixeH85jScqcu4qKdP/neD3cJXUl+OTJrb/uJKnD3pWg3rZL0xvbobTPsntIeojVjxXjWhn8Icya0ciYq2B5vZP8eKvH9RBkGm7vbVTHWQa/prf0/1g/VgPJcGMLnrroTWshH5u/TZakWqu3rCV/A+GBRlxhZ7w8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757300042; c=relaxed/simple;
	bh=P+rDiVO50O0r1hQrLeacuODVxeTPnln6GT1i7li1t4I=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rNQuGAnbwi5IYyR2FI/EnA0eDesszvkjOW0n8f+X9FW1maRW/OVq6doD9Ax6OUMyJA9vvDOU9Pv9svSwze5j4t0Ljoxs2Gk3QrLJ7X0mwL6v82J4MD6JHppTVLqmIVn+Kh105ftRdGnvyYVxqbkcl46kydAgsPGTXOCaDmSMZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRKLiVxM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb45191c-7198-4ce8-9f35-72a784351836@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757300037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xXFvyrL20K1Mw4r7gL5zjY/c43Vwh4f2zoX6V27jYQA=;
	b=JRKLiVxMkcTD3I6VvSuXDIGqa+9L4f0cutPtDcQjjjdoH75v3eazX7ihP8SKHRKpgFaflH
	6ZdjNE6Kr1uM4Aacc6623TqP+46xZfCXW1zcwhNIAiMoawdQoUwqrXOsp56dojaZHRIH+V
	VkYPGp/sbX5hR82OZmT4D1rQmvAO99Q=
Date: Mon, 8 Sep 2025 10:53:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Igor Russkikh <irusskikh@marvell.com>, netdev@vger.kernel.org,
 Egor Pomozov <epomozov@marvell.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
Subject: [QUESTOIN] Atlantic NIC ntuple feature support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi maintainers,

I use kernel 4.18 and backport the feature of ntuple on Atlantic from
https://github.com/Aquantia/AQtion, and recompile the driver, but it 
seems not working. And the NIC on my machine is Aquantia Corp. AQC107 
NBase-T/IEEE 802.3bz Ethernet Controller [AQtion] (rev 02). The 
corresponding IC chip manual is Marvell AQVC107 Link Status Register.

I also created an issue on Aquantia github repo
https://github.com/Aquantia/AQtion/issues/71

So does it supports ntuple feature on hardware. Thanks!

-- 
Best Regards
Tao Chen


