Return-Path: <netdev+bounces-156016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE776A04A8E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AE23A67CC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 19:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6EE1F707B;
	Tue,  7 Jan 2025 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cyQnqzff"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD618BC2F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736279595; cv=none; b=rn6M0VsfmHtl7oW2a99xSFpEgwH/Dgah6W6VE+txwlsUnI0w6d9iIk26TXQZfMJHdbOiKbUhGUl4tH4GXUWejgtYLgFLzFjuL3LV+r3IvGuoKER3OutgNZngxICDkSgTXXgyDaYVahM8y5g6+2SX1ChvOe1YUFTi8fRHlch5N6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736279595; c=relaxed/simple;
	bh=CwEEiQJnpaNgvThRH/g+lUzyHqm8okoXYjh3DTYZE1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JW0fElr0o/kWvh4VYzwjlwz0VZ2nHXO48b9OL5x+DhNI5ij4auyW5tSFsSFNxzEGzkEnGDS09vXeM+31L9BEediilhOSkR2nLQqkEpZXLs2SAuTTNHFZXJj3qHqaTq9dkZo7fM5DMFxvQB8jdWsIhjPPBNBY8CJ6hvHdR9BnmQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=cyQnqzff; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=916; q=dns/txt; s=iport;
  t=1736279592; x=1737489192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Lvq9sOjR8osjo1oozSms56lcmTvgjCKYOD2x7ofEhY=;
  b=cyQnqzffoei5DvC3W+fI+iOzeV9oViy4sSO0O1bUjI85z0WVPdotr5Yg
   vYqHL2EMTvQiqQrRG0UGruGqFHcPnqvzWqSpE5aL4HV6Jme3AzhJkmWnc
   ZQgQDbNj6HJ0+RYiRV0a4ENL/ArbhGHJYdX5wdkDbrjyU8m039jYW1064
   M=;
X-CSE-ConnectionGUID: 2r0/UFkjTvSbeRHnQX66aQ==
X-CSE-MsgGUID: jq4Yf+nsSBK+4IdfAPDTpQ==
X-IPAS-Result: =?us-ascii?q?A0AlAQCyhH1nj47/Ja1aHgEBCxIMgggLhBpDSI1RiHWeG?=
 =?us-ascii?q?IF+DwEBAQ9EBAEBhQcCinQCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFFAEBAQEBATkFDjuGCIZbAQEBAgEyAUYQC0YrKxmDAYJCIwOxc?=
 =?us-ascii?q?IIsgQHeM4FtgUiFa4dfcIR3JxuBSUSCUIE+MT6FEIV3BIJ+hGudeUgKgRcDW?=
 =?us-ascii?q?SwBVRMNCgsHBYEpHysDOAwLMBUmD4EcBTUKNzqCDGlLNwINAjWCHnyCK4Ihg?=
 =?us-ascii?q?juER4RYhWiCF4FrAwMWEgGCdUADCxgNSBEsNxQbBj5uB5plPINuAYIKgUSlc?=
 =?us-ascii?q?KEDhCWBY59jGjOqU5h8pEeEZoFnOoFbMxoIGxWDIlIZD446H7kAJTICOgIHC?=
 =?us-ascii?q?wEBAwmRVQEB?=
IronPort-Data: A9a23:zxbGcKOitFUntWDvrR0kl8FynXyQoLVcMsEvi/4bfWQNrUpzhTAEz
 2sdWDqHOf3fZWv0Ltl+aIi29UhT6JDcmIJrHnM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlnlV
 e/a+ZWFZQf8g2EsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6690VAYLE44axvhMC2x01
 fohGG5TZynW0opawJrjIgVtrt4oIM+uOMYUvWttiGmES/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzNnwsYDUXUrsTIJA5nOGkj33yWzZZs1mS46Ew5gA/ySQtiOi8aoSIJ4XiqcN9nF/El
 2yF+X/CKDJZaP2TxxO93k60v7qa9c/8cNlPTOLjrKECbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsSz9KaNUi8tQpRDU21
 ViWhNDoLThutqCFD3Ob6rqQ6zi1PEA9JGkOfyIbDg0I/9Xuvqk3kxTJCN1jeIath9f4HzDY2
 T2GrCEiwb4UiKYj0ain8V3Zqyyjq4KPTQMv4AjTGGW/4WtEiJWNfYek7x3fqP1HNovcFgTHt
 3kfkM/Y5+cLZX2QqMCTaL8XRPaUyfWHDCPni1NVP58Yx2rz8kf2KOi8/wpCDEtuN88Ffxrgb
 0nSpR5d6fdv0J2CM/Yfj2WZVZhC8ETwKekJQMw4eTanX3SQSONl1Hw1DaJz9zmx+KTJrU3ZE
 czBGSpLJS1FYZmLNBLsG48gPUYDn0jSP1/7S5Hh1AiA2rGDfnOTQrptGALRNb5gvPPf+F2Ko
 4o32y62J/N3DbOWjs7/rN97ELz2BSJgbXwLg5UNL7fdfloO9J8JVK+JnelJl3NZc1R9zbqQo
 SrnBSe0OXL0hGbMLk2Re2t/Zbb0FZd5pjRTAMDfFQjA5pTXWq72tP13X8JuJdEPrbU/pdYqF
 KNtU5vbXZxypsHvp291gW/V8Nc6LEzDaMPnF3bNXQXTiLY5HlOXooG4L1WHGetnJnPfiPbSa
 oaIjmvzKafvjSw5ZCoKQJpDF2+MgEU=
IronPort-HdrOrdr: A9a23:OqZTPqoYjXECuR918acaBbsaV5oseYIsimQD101hICG9vPb2qy
 nIpoV96faaslcssR0b9OxofZPwI080lqQFhbX5Q43DYOCOggLBR+tfBMnZsljd8kbFmNK1u5
 0NT0EHMqySMbC/5vyKmTVR1L0bsb+6zJw=
X-Talos-CUID: 9a23:z2ytsGGPnTJB0M3pqmI97hZTJ+4mcEHD933dGW++MFY3FrSsHAo=
X-Talos-MUID: 9a23:GWaeNAsluIOH4jLa082nhig+Bckr5b+VImNOzbQKteC8GRBoAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,296,1728950400"; 
   d="scan'208";a="408926551"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 19:53:05 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTP id 248481800022E;
	Tue,  7 Jan 2025 19:53:05 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id D0A7B20F2003; Tue,  7 Jan 2025 11:53:04 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: michal.swiatkowski@linux.intel.com
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
Date: Tue,  7 Jan 2025 11:53:04 -0800
Message-Id: <20250107195304.2671-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <Z3zCfiwPl2Xu/Zvi@mev-dev.igk.intel.com>
References: <Z3zCfiwPl2Xu/Zvi@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

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
>
>Is this on purpose? You didn't mention anything about speed range in
>commit message. Just wondering, patch looks fine, thanks.

I changed the comment on purpose since it applies to adapters way past
40 Gbps nowdays. I should have mentioned the change. Thanks for the
reveiw.
>
>Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

