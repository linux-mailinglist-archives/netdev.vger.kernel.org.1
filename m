Return-Path: <netdev+bounces-155699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D21A035A0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 04:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63903A28E5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF471802AB;
	Tue,  7 Jan 2025 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="XBAsaU1f"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094C156225
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218821; cv=none; b=RS9B10FSqexTeA82tZirA5Ae6vXjRqHZhGKsRT76WHaNlY0pglYMkaP6oALyi78r4ivX/74P0p4vZ8UmxuM3t59LgFjYUXrUGeYw5Y0QZ+Y1Lw+7paZM5SMtW1Vs8IJ+jRtS4TN4DaeSpFDzfwLaqEkcQ7vtqqJDEKVsDgwlg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218821; c=relaxed/simple;
	bh=uuVpJZ+2tBW/mJyBXwU0t3/alPpFKO2qt6t+rfECzh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ua2anbLYnCj8l4uAFtKeGfN9ZLeWMlnJAnp02lLwb1TXBQxDiuUOpeE9TFTS1FYJcdBluWxhHAmJF/KLAiOQTQTFrW0oOwQ1y/cNFzC7ntBs9omydRzy5CzMhvMqOAcuIBYOgX5zEMoA83iqe+4rxfXVJboJiej3H9Z+/37EFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=XBAsaU1f; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1562; q=dns/txt; s=iport;
  t=1736218818; x=1737428418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DDT5k+1VqMANSCnZT0Db9eXEyAFhm6VHx9Kwvr5ec5k=;
  b=XBAsaU1f1NUvKN9MRPu4RueyfulTPpje4+CyRSVBRu5AdpD5BhQDnuMy
   sMUMNVf1mEtMSJgGA7NFmsUK22KxAE51eOjy0IafH5RI7xuM306N8XNBn
   rVY/mF3dAaADFQUkSZuou+hydHwmeBCZmR2iBtgE/Txty5iCHofSGAOCt
   8=;
X-CSE-ConnectionGUID: IpG6m+KwQIabKv1umUpxTg==
X-CSE-MsgGUID: FbnN1p06TwmjCF18Jq7T6w==
X-IPAS-Result: =?us-ascii?q?A0BbAABVl3xnj40QJK1aHQEBAQEJARIBBQUBggIFAQsBh?=
 =?us-ascii?q?BlDjhmIcqAZDwEBAQ9EBAEBhQcCinQCJjcGDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQUBAQECAQcFFAEBAQEBATkFSYYIhlsCAQMnCwFGEAtGKyuDGoJlA?=
 =?us-ascii?q?7BAgXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEhA4xPoUQhXcEh2yddEgKgRcDW?=
 =?us-ascii?q?SwBVRMNCgsHBYEpHysDOAwLMBUmD4EmBTUKOTqCDGlJNwINAjWCHnyCK4Ihg?=
 =?us-ascii?q?juER4RWhWaCF4FoAwMWEgGCbUADCxgNSBEsNxQbBj5uB58JHYEUPx4ub6Yao?=
 =?us-ascii?q?QOEJYFjn2MaM6pTmHykR4RmgX0kgVszGggbFYMjURkPjjoft3IlbgIHCwEBA?=
 =?us-ascii?q?wmRdAEB?=
IronPort-Data: A9a23:KTWmr6oVxdDfaAeOToD8XjMdUo1eBmL9ZRIvgKrLsJaIsI4StFCzt
 garIBnXOv3ZMTb1Kdp0bYS/9k9X7JLTm4VjGQZuqyo2RHsa8uPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQXNNwJcaDpOtvra8E0355wehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0sdvLj9Lt
 t8HEREEZDOd3v+z/aqrduY506zPLOGzVG8eknhkyTecCbMtRorOBv2Wo9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwtOYH49tL/Aan3XcTpYrl6coacf6GnIxws327/oWDbQUoDSFZkFwxjJ/
 goq+UzXCBc8bcTHlwaa93CHqLafvzqkZNwNQejQGvlC2wDLmTdJV3X6T2CTrfCnh0uWV9tBJ
 kkQ/SQy664/6CSDQ9XgWhSqrWKssRkbVN5dVeY97Wmlybfe6i6aC3ICQzoHb8Yp3Oc/QzAw2
 0DKmd71CTFxmLmIT3Tb/bf8hSu7MyUTLEcYaCMERBdD6N7myKk1gw7DQ8hLDqG4lJv2FCv2z
 jTMqzIx74j/luYC06G9uFSCiDW2q92REkg+5x7cWSSu6QYRiJOZi5KAyED0s/MDD5mgb1CLn
 2Zdhs2j9PAyAsTY/MCSe9klELas7veDFTTTh19zApUsnwhBHVb9JOi8BxkgeC9U3tY4RNP/X
 KPEVepsCH5v0JmCMPYfj2GZUphCIU3c+TLNDai8gj1mOcMZSeN/1HsyDXN8Jki0+KTWrYkxO
 I2AbeGnBmsABKJswVKeHrhGj+Z7lntmnTyDGfgXKihLN5LDOhZ5rp9YYTOzghwRtvjsTPj9q
 owGbpXWm32zrsWhMnGLq+b/0mzm3VBgWMip8JYIHgJyCgFnA2omQ+TA2q8sfpctnqJe0I/1E
 oKVBCdlJK7ErSSfc22iMyk7AJu2BMYXhSxgZ0QEYw33s0XPlK7zt8/zgbNrJuF/rISODJdcE
 5E4Ril3Kq4WEW6domlDMceVQU4LXE3DuD9i9hGNOFAXF6OMjSSTkjM4VmMDLBUzMxc=
IronPort-HdrOrdr: A9a23:/BClb6w2zOZshP9IWPjcKrPwK71zdoMgy1knxilNoNJuHfBw8P
 re+8jzuiWUtN98YhwdcJW7Scu9qBDnhPpICPcqXYtKNTOO0ADDEGgh1/qG/9SKIUPDH4BmuZ
 uIC5IOa+EZyTNB/L/HCM7SKadH/OW6
X-Talos-CUID: =?us-ascii?q?9a23=3AEv/RKmm3yhqJrrfkdLvTI9TPy0rXOVzF4ynVYGy?=
 =?us-ascii?q?nMEdgQp6LEEKVxbt0r8U7zg=3D=3D?=
X-Talos-MUID: 9a23:BKwZuwn/EPqOwLcO7xordnpMPsFOurz2VnwSlJctlZDUFzUvB2mC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,294,1728950400"; 
   d="scan'208";a="408485690"
Received: from alln-l-core-04.cisco.com ([173.36.16.141])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 03:00:17 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-04.cisco.com (Postfix) with ESMTP id 167F9180001A2;
	Tue,  7 Jan 2025 03:00:17 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id DF4E83FAB9CC; Mon,  6 Jan 2025 19:00:16 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	benve@cisco.com,
	davem@davemloft.net,
	edumazet@google.com,
	johndale@cisco.com,
	neescoba@cisco.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v4 4/6] enic: Use the Page Pool API for RX when MTU is less than page size
Date: Mon,  6 Jan 2025 19:00:16 -0800
Message-Id: <20250107030016.24407-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250106161953.019083b3@kernel.org>
References: <20250106161953.019083b3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-04.cisco.com

>> >> The Page Pool API improves bandwidth and CPU overhead by recycling
>> >> pages instead of allocating new buffers in the driver. Make use of
>> >> page pool fragment allocation for smaller MTUs so that multiple
>> >> packets can share a page.  
>> >
>> >Why the MTU limitation? You can set page_pool_params.order
>> >to appropriate value always use the page pool.  
>> 
>> I thought it might waste memory, e.g. allocating 16K for 9000 mtu.
>> But now that you mention it, I see that the added code complexity is
>> probably not worth it. I am unclear on what to set pp_params.max_len
>> to when MTU > PAGE_SIZE. Order * PAGE_SIZE or MTU size? In this case
>> the pages won't be fragmented so isn't only necessary for the MTU sized
>> area to be DMA SYNC'ed?
>
>Good point, once fragmentation is no longer possible you can
>set .max_len to the size of the fragment HW may clobber,
>and .offset to the reserved headroom.

Ok, testing going good so far, but need another day.
>
>> >  
>> >> +    page_pool_destroy(rq->pool);
>> >> +}  
>> 
>> I will make a v5 shortly. Would you recommend I split the patchset into 2 parts
>> as I think @andrew+netdev was suggesting? The last 2 patches are kind of unrelated
>> to the first 4.
>
>Yes, seems like a good idea, patches 5 and 6 would probably have been
>merged a while back if they were separate.

Ok, I submitted patches 5 and 6 as separate trivial patchset. Hopefully it will be
merged by the time my testing for the page_pool changes are complete so I can submit
on top of them. thanks!

