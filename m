Return-Path: <netdev+bounces-157320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4DA09EDB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907577A02DB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62937222565;
	Fri, 10 Jan 2025 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="XkbH2s0J"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0721A952
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736553127; cv=none; b=Odr+aTV9pQ32EALnw+Op+wJgHcCW1q+TRZuqivmLZxuDFe2PWYX4N3BZf4xX0rSUHk6Wc9ieVnOqNmoovvE2GEWv7DhfFqphhjZbbZy7NdkJ2vYSw/oeJBYQXTboXtTFw0T8PA4D9kpY4fgFZ4wewjzqTG7gCnU36G4gMbKRbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736553127; c=relaxed/simple;
	bh=G8kYBQWOCBbdkQMMP6AT+pzzzpPL5jZT+ikc3R6HD7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZadvk582ffkcz+v8CfqhrCYTKQL9gnjmZ0yRxG1glqMog9/2lY2C6u62SCgBC/Z+z7XsgkGm+AHfedyw0KC0/9qu7vEItiLHk6gnWVJoA9sS655vMsnvoll0Z3wqkERSLwzkXcpGuvlC3peizFybLKIiFKnIaT1dBs+pOyo78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=XkbH2s0J; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1505; q=dns/txt; s=iport;
  t=1736553125; x=1737762725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l4Ny71q6SywhZWGkcrse9Y/cnP1u2sqaD5XJ0/WBlm0=;
  b=XkbH2s0JUmZ3YrlOvtn/PtZL2QBOXsUVB5KM3y/ru5HBYQk2qR6EKiq0
   Rq2dw080aUUCLfwo58AVdjLgcKqvzf2Xvo2rAKb0DMCf7XSVPTsvycqwE
   CqRQ91rJK1lJiHC6ezaGq9eW4suNkKL5AFmbjM8oY6ahaf40N6la2BvtJ
   E=;
X-CSE-ConnectionGUID: LvrCcY4LQC+ShBOrMENJQA==
X-CSE-MsgGUID: rCDsOU6wQT+3XR7PH/7nKA==
X-IPAS-Result: =?us-ascii?q?A0BuBACAsYFn/47/Ja1aHgEBCxIMgggLgkuBT0NIjVGId?=
 =?us-ascii?q?Z4YgX4PAQEBD0QEAQGFBwKKdAImNgcOAQIEAQEBAQMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBBQEBAQIBBwWBDhOGCIZbAQEBAycLAUYQCxguKysZgwGCZQO0XoF5M4EB3?=
 =?us-ascii?q?jOBbYFIhWuHX3CEdycbgUlEhA4xPoUQhXcEhCeDQJ5XSAqBFwNZLAFVEw0KC?=
 =?us-ascii?q?wcFgSgfKwM4DAswFSYPgRkFNQo3OoIMaUs6Ag0CNYIefIIrgiGCO4RHhFSFZ?=
 =?us-ascii?q?4IUgWUDAxYSAYMyVEADCxgNSBEsNxQbBj5uB5spPINvfIEMLqcJoQOEJYFjn?=
 =?us-ascii?q?2MaM4QEjQaZSZh8pEeEZoFuAjOBWTMaCBsVgyJSGQ+OWbxIJTI8AgcLAQEDC?=
 =?us-ascii?q?ZEeAQE?=
IronPort-Data: A9a23:B8bWZqkRRZdA/9BgmcYDwL7o5gyjJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIeUG+AMqzeM2WjfI12OYS3oUgBv5LTxoIyQAZkqy41EVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pe31GONgWYubzpNsvrb83uDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FakG4M18MD1qz
 NdbEzAnSQqmqsSU+ZvuH4GAhux7RCXqFJkUtnclyXTSCuwrBMieBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTYD/7C7pm9Ausrnv4cztUoVaYjaE2+GPUigd21dABNfKJIILVFJQJwRnwS
 mTu5U/VGTYnasOm9Xnewkjzvs+IwiXYcddHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhDI1i7NWiYsA0L+2uAiaxTmtvZPOCAUy4207Q16Y0++wX6b9D6TA1LQRxa8owFqxJrVZg
 EU5pg==
IronPort-HdrOrdr: A9a23:OwugkKyyPI+6D6U7+NnuKrPwK71zdoMgy1knxilNoNJuHfBw8P
 re+8jzuiWUtN98YhwdcJW7Scu9qBDnhPpICPcqXYtKNTOO0ADDEGgh1/qG/9SKIUPDH4BmuZ
 uIC5IOa+EZyTNB/L/HCM7SKadH/OW6
X-Talos-CUID: =?us-ascii?q?9a23=3AqKFhnGvfVwgulh8gQYGS8fgj6IsBbGf2x0aMB3a?=
 =?us-ascii?q?TSl1pYpqPbHK22ppNxp8=3D?=
X-Talos-MUID: 9a23:/tNrWQZzt4xLOOBTrRTAnxZfathR3+f1OHpSqbVB5M+nHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,305,1728950400"; 
   d="scan'208";a="426799477"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 10 Jan 2025 23:52:04 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTP id 92CAA1800022D;
	Fri, 10 Jan 2025 23:52:04 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 67AB120F2003; Fri, 10 Jan 2025 15:52:04 -0800 (PST)
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
Date: Fri, 10 Jan 2025 15:52:04 -0800
Message-Id: <20250110235204.8536-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250104174152.67e3f687@kernel.org>
References: <20250104174152.67e3f687@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

On 1/4/25, 5:42 PM, "Jakub Kicinski" kuba@kernel.org wrote:

>On Thu,  2 Jan 2025 14:24:25 -0800 John Daley wrote:
>> The Page Pool API improves bandwidth and CPU overhead by recycling
>> pages instead of allocating new buffers in the driver. Make use of
>> page pool fragment allocation for smaller MTUs so that multiple
>> packets can share a page.
>
>Why the MTU limitation? You can set page_pool_params.order 
>to appropriate value always use the page pool.
>
>> Added 'pp_alloc_error' per RQ ethtool statistic to count
>> page_pool_dev_alloc() failures.
>
>SG, but please don't report it via ethtool. Add it in 
>enic_get_queue_stats_rx() as alloc_fail (and enic_get_base_stats()).
>As one of the benefits you'll be able to use
>tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
>to test this stat and error handling in the driver.

Fyi, after making suggested change I used pp_alloc_fail.py but no
errors were injected. I think the path from page_pool_dev_alloc()
does not call page_pool_alloc_pages()?

Here is what I beleive the call path is:
page_pool_dev_alloc(rq->pool, &offset, &truesize)
  page_pool_alloc(pool, offset, size, gfp)
    netmem_to_page(page_pool_alloc_netmem(pool, offset, size, gfp));
      page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
        page_pool_alloc_netmems(pool, gfp);
          __page_pool_alloc_pages_slow(pool, gfp);

If I change the call from page_pool_dev_alloc() to
page_pool_dev_alloc_pages() in the driver I do see the errors injected.

