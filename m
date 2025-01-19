Return-Path: <netdev+bounces-159650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5B3A163BB
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 20:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE883A4BB1
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 19:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374DF18BC3F;
	Sun, 19 Jan 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Mj5d6dKl"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F9187872
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737314900; cv=none; b=VEyrsSVDk6azecWmkzZJ2iUfMGAuyHvkAJCxQQ2sN9jEiWbtXPhwB6hkvuYBA95S7lOc24c4OhkeXuEBJoL+GfYzaDmoi4qVDs37dPMVx7vjNErzpxKVkKqaPvPypYaDUWEamM37oquS8zEKDKtA27JnkcP1D4I8QZLo9b5ZYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737314900; c=relaxed/simple;
	bh=vjwM+TDeObmiixchDBhnjcgiGjeX9dZZhWEtEjMl2hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0NAOZahBob7EGDl/cXAJxsb4xuWjJnSZqYDZn9VVkxOsFVNmi9H9UNHaCMCQG+KZY85PyDWXShQ0M+8jF/jSIec3I9m8VpJkQYnmHHtXTiUloKAFYpnPxyijYbTb0sBj6DZ9e1QFKKU9/++XZsuMT26bikGSmHi8Qj8u+ul35M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Mj5d6dKl; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=629; q=dns/txt; s=iport;
  t=1737314898; x=1738524498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kMHkm0fNyOwbnd7Jgg9xbqbBA7JMRJO0W2PfGa0uQLw=;
  b=Mj5d6dKlxb/aSdjaNlugRMVCMpn+2ilYoJQSE6C5eySm0psHo2jb0bDS
   Ap+N+EMQmEZ1BpHKPzDjLuGBPYyNSlGCYmQGcssqU3wqFkQCWG06DhP6l
   eUWQmGP61ndptIq6UwBTjaGostt0m2pSBMOQ7upjjxBN1PWmkbIiuvZF9
   E=;
X-CSE-ConnectionGUID: 1HnppS2DR1yNJWc5pEm0NQ==
X-CSE-MsgGUID: nHsPfzymRxS+Znq8fPPDIw==
X-IPAS-Result: =?us-ascii?q?A0BaAADmUY1n/5T/Ja1aHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?QUBAQsBgkqBT0NIjVGIdp4YgX4PAQEBD0QEAQGFBwKKcwImNgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbAQEBAycLAUYQCxguK?=
 =?us-ascii?q?ysZgwGCZQO0WoF5M4EB3jOBbYFIAYVqh19whHcnG4FJRIJQgT4xPoUQhXcEg?=
 =?us-ascii?q?n2BKINAn1JICoEXA1ksAVUTDQoLBwWBKUgDOAwLMBUkgSYFNQo3OoIMaUk3A?=
 =?us-ascii?q?g0CNYIefIIrgh+CO4RFhFOFXIIUgWgDAxYSAYMoex9NQAMLGA1IESw3FBsGP?=
 =?us-ascii?q?m4Hm2U8g3d6gn6XTY14oQOEJYFjn2MaM4NxpmKYfKNqXYRmgW4DMoFZMxoIG?=
 =?us-ascii?q?xWDIlIZD9EfJTI8AgcLAQEDCZFlAQE?=
IronPort-Data: A9a23:OvbGgKPZf4P+ZDjvrR2HlsFynXyQoLVcMsEvi/4bfWQNrUp2gzYGx
 mQfW22DP6veYmr2etwgPYjg/EJSuZPSz4I3SnM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WljlV
 e/a+ZWFZQf8gm8saAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj66xOClkuBtc0wL9mJ0Nx/
 qEABTVVSCnW0opawJrjIgVtrt4oIM+uOMYUvWttiGiAS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzPHwsYDUXUrsTIJA5nOGkj33yWzZZs1mS46Ew5gA/ySQqiOeyb4eEIYPiqcN9mGaDn
 mzU7mHDEipZBtqGmTS9yl6Nmbqa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYA980ukStS7VBq9yFaHoxQVc9ldCes37EeK0KW8yw+fCnIJUX1HZcAqudEeQSEs0
 BmCn7vBHTVlvbuUYWiQ+redsXW5Pi19BWkPeSMJUyMb7NT55oI+lBTCSpBkCqHdszHuMSv7z
 zbPqG01gK8eyJdSka665lvAxTmro/AlUzII2+keZUr9hisRWWJvT9XABYTzhRqYELukcw==
IronPort-HdrOrdr: A9a23:JiSzAa7EyxYH8DW6DAPXwM/XdLJyesId70hD6qm+c3Nom6uj5q
 eTdZsgtCMc5Ax9ZJhko6HjBEDiewK5yXcK2+ks1N6ZNWGM0ldAbrsSiLcKqAePJ8SRzIJgPN
 9bAstD4BmaNykCsS48izPIdeod/A==
X-Talos-CUID: 9a23:b+sDomyboCH4lo5buXhBBgVNOsY9akaH4E2JMmmaNm00UJCQEXmprfY=
X-Talos-MUID: 9a23:VXOWrQT8Moiat4w3RXTqpCpaOtV55p6+MwM/l4xWtfG8GQ1vbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,218,1732579200"; 
   d="scan'208";a="307775937"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jan 2025 19:27:54 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTP id 901FE1800025C;
	Sun, 19 Jan 2025 19:27:54 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 5AEA120F2003; Sun, 19 Jan 2025 11:27:54 -0800 (PST)
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
Subject: Re: [PATCH net-next v6 3/3] enic: Use the Page Pool API for RX
Date: Sun, 19 Jan 2025 11:27:54 -0800
Message-Id: <20250119192754.5203-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250118172420.48d3a914@kernel.org>
References: <20250118172420.48d3a914@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-11.cisco.com

On 1/18/25, 5:24 PM, "Jakub Kicinski" kuba@kernel.org wrote:

>On Fri, 17 Jan 2025 00:01:39 -0800 John Daley wrote:
>> @@ -1752,6 +1763,11 @@ static int enic_open(struct net_device *netdev)
>>        }
>>  
>>        for (i = 0; i < enic->rq_count; i++) {
>> +             /* create a page pool for each RQ */
>> +             pp_params.napi = &enic->napi[i];
>> +             pp_params.queue_idx = i;
>> +             enic->rq[i].pool = page_pool_create(&pp_params);
>
>Aren't you missing an error check here?

Yes, v7 coming. Thanks.

>
>>                /* enable rq before updating rq desc */
>>                vnic_rq_enable(&enic->rq[i].vrq);
>>                vnic_rq_fill(&enic->rq[i].vrq, enic_rq_alloc_buf);

