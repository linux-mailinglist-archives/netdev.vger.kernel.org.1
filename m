Return-Path: <netdev+bounces-156048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576D7A04BEB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D641886E1E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EAC1F2361;
	Tue,  7 Jan 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="g5GrPZE2"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD019C558
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286523; cv=none; b=lIYBawrIgQOlG7wGJ4bd+feStjKujjyeem4lVPeuo+1k9s5hy1nDTD0vULALC+TishDahrGSRQSXj3Y4HVMJfggYKxIAYw/CzFhtU2ItQNpjnWwa/eJpo75xURzT5x05v/vOZR1aFjGsKsVv2Ss5CW6Piux83WNbv7zAuhZc94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286523; c=relaxed/simple;
	bh=LBdGqL5qjc7FwmNxMKcB9cw6Z7n6Bk5vpIgFd3OvrW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7WAsIkGwWPbMmj0lO1h02bflHd8e/ZaChijtlxYBC3YzVhwE1oIhHUmWfLithcxkuiqwzgY6OVGymXxpvmcK1LtD45uDukDpdfTv/xBZuKYVLN3kJqcxAAhXVkhP5O4C/nY0nxNOSmZns6DkR5hiQvXY8sTN2fep/OjY3mVVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=g5GrPZE2; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1604; q=dns/txt; s=iport;
  t=1736286522; x=1737496122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymrCw1QVofjCy9hb3/GYIIvTuwzebNc+kY6ysbXSovk=;
  b=g5GrPZE2q1RRUa3KKJ6nKjrvq9IcGVqBiooGsPz8D6SBz8o+Wo+qSwYP
   hYqnP6WDKuA/+g9r969sNObw30bL1AWCkRRMKT3et3oZJVfHoFihUkc3l
   MT5y0+e6/+fKWGe/MLhTzOc6cEk+eATibVj7FY+DMFZ6T3+2LkA1aF/OD
   c=;
X-CSE-ConnectionGUID: 8jnK2OJHSUK+gJ+DocVFBw==
X-CSE-MsgGUID: dqitX1fKRDKmM5IMahdcfw==
X-IPAS-Result: =?us-ascii?q?A0AlAQCIoH1nj5AQJK1aHgEBCxIMgggLhBpDSI1RiHWeG?=
 =?us-ascii?q?IElA1YPAQEBD0QEAQGFBwKKdAImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBBQEBAQIBBwUUAQEBAQEBOQVJhgiGWwEBAQIBMgFGEAtGKysZgwGCQiMDs?=
 =?us-ascii?q?UeCLIEB3jOBbYFIhWuHX3CEdycbgUlEglCBPjE+hRCFdwSCfoRrnglICoEXA?=
 =?us-ascii?q?1ksAVUTDQoLBwWBKR8rAzgMCzAVJg+BHAU1Cjc6ggxpSzcCDQI1gh58giuCI?=
 =?us-ascii?q?YI7hEeEWIVogheBawMDFhIBgxVAAwsYDUgRLDcUGwY+bgeadTyDbgGBDjVHN?=
 =?us-ascii?q?aZ/oQOEJYFjn2MaM6pTmHykR4RmgWc6gVszGggbFYMiUhkPji0NCRa5FiUyP?=
 =?us-ascii?q?AIHCwEBAwmRVQEB?=
IronPort-Data: A9a23:ZnyYwKur2e3TKkLQTB/4E2Y8EOfnVLxeMUV32f8akzHdYApBsoF/q
 tZmKWHVa/fcYzT2eY0kPtm380MDu8LWy4RnHVBt/C8zFSNHgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGYjdJ5xYuajhJs/vb90s11BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIwquRxIjtp1
 9wjFRNOYTLAq+W9/pyRVbw57igjBJGD0II3s3Vky3TdSP0hW52GG/qM7t5D1zB2jcdLdRrcT
 5NGMnw0MlKZPVsWZgt/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9JoXSHJQMxRbCz
 o7A12jgAw0qbdK88xam91fxp8rGnS/wVp1HQdVU8dYx3QXMnTZMYPEMbnO3qOe0j2ayUsxSL
 kgT9DZoq6UunGSmQsT4Vg+1vFaLuRkTX9cWGOo/gCmO16DdywWUHG4JSnhGctNOnMYwSSYny
 RyPks/lCCJHtKCTTzSW9t+8pDW+IyUKBWsfYylCRgtty8Hqqow1jzrVQ9pjGbLzhdrwcRn2z
 iyGoTYWmboel4gI2r+98FSBhCijzqUlVSY84gHRG2bg5QRjacv9OMqj6EPQ6rBLK4PxokS9U
 GYsy8qYz7opL7G2qQ/OT8dOMLai2divL2iJ6bJwJKUJ+zOo8n+lWIlf5jBiOUtkWvronxe3O
 Sc/XisPuPdu0GuWUENhX26m5y0XIUnc+TbNC6i8gjlmO8QZmOq7EMdGPhf4M4fFyxNErE3HE
 c3HGftA9F5DYUid8BK4Rv0GzZggzT0kyGXYSPjTlkv8j+PONCXNEehVbDNii9zVCovZ/m05F
 P4CZqO3J+l3CraWjtT/qNRKdA5WfRDX+7ip+5QLLIZv3TaK6El6VqeOmul+E2CUt69UjezPt
 mqsQVNVzUG3hHvMb223hoNLNtvSsWJEhStjZ0QEZA/ws1B6ONbHxPlELfMfI+J4nNGPONYoF
 JHpje3cWawXElwqOl01MfHAkWCVXE3y2lzWYXb0PlDSvfdIHmT0xzMtRSO3nAFmM8Z9nZJWT
 2GIvu8Dfac+eg==
IronPort-HdrOrdr: A9a23:1KImFKjvLJufbC3AFEVTTYpvCnBQXt0ji2hC6mlwRA09TyVXra
 +TdZMgpHjJYVkqOU3I9ersBEDEewK/yXcX2/h0AV7dZmnbUQKTRekIh7cKgQeQfhEWndQy6U
 4PScRD4aXLfDtHZQKQ2njALz7mq+P3lpyVuQ==
X-Talos-CUID: 9a23:UQ9EwmF1v/EWvVyHqmI39kg3QOcHUkbg7zTfAQyUDm1XZpeKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AC3eKKA8Hj3QXu1fQha4rO6qQf8tx4rieUU4uq7k?=
 =?us-ascii?q?lvuzZFAl5OzuWgiviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,296,1728950400"; 
   d="scan'208";a="410191382"
Received: from alln-l-core-07.cisco.com ([173.36.16.144])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 21:48:35 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-07.cisco.com (Postfix) with ESMTP id 6075D180001D1;
	Tue,  7 Jan 2025 21:48:35 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 34C0820F2003; Tue,  7 Jan 2025 13:48:35 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	benve@cisco.com,
	davem@davemloft.net,
	edumazet@google.com,
	johndale@cisco.com,
	kuba@kernel.org,
	neescoba@cisco.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next 2/2] enic: Obtain the Link speed only after the link comes up
Date: Tue,  7 Jan 2025 13:48:35 -0800
Message-Id: <20250107214835.25987-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <5f143188-57e1-44ce-a70d-d8339af4f159@lunn.ch>
References: <5f143188-57e1-44ce-a70d-d8339af4f159@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-07.cisco.com

>> The link speed is obtained in the RX adaptive coalescing function. It
>> was being called at probe time when the link may not be up. Change the
>> call to run after the Link comes up.
>> 
>> The impact of not getting the correct link speed was that the low end of
>> the adaptive interrupt range was always being set to 0 which could have
>> caused a slight increase in the number of RX interrupts.
>> 
>> Co-developed-by: Nelson Escobar <neescoba@cisco.com>
>> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
>> Co-developed-by: Satish Kharat <satishkh@cisco.com>
>> Signed-off-by: Satish Kharat <satishkh@cisco.com>
>> Signed-off-by: John Daley <johndale@cisco.com>
>> ---
>>  drivers/net/ethernet/cisco/enic/enic_main.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
>> index 957efe73e41a..49f6cab01ed5 100644
>> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
>> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
>> @@ -109,7 +109,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
>>  static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
>>  	{0,  0}, /* 0  - 4  Gbps */
>>  	{0,  3}, /* 4  - 10 Gbps */
>> -	{3,  6}, /* 10 - 40 Gbps */
>> +	{3,  6}, /* 10+ Gbps */
>>  };
>
>So we still have this second change, which is not explained in the
>commit message, and probably should be in a patch of its own.

OK, I did a v2 with the typo fix as its own patch in this set of link related
patches. Thanks.

