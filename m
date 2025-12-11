Return-Path: <netdev+bounces-244399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B292ACB644B
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 16:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7AD2301894F
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339FB288C08;
	Thu, 11 Dec 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="P374qeqj"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3123D2B4
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765465473; cv=none; b=fzv8RXuVDYlqwQrbtHyFVxdkdx0Hy6eYfBrmuGZk/X5waFx87gXU61ORKUGKNPfG6xkh17fUmDeFaRiQduaIac1Tiep75GlStrTmrkGUD+1ndQX5WwjV898tCbkCHR/oSKkST5Bm9F9tAItU/G9DYzK7l0+le5dVrdKKuslRUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765465473; c=relaxed/simple;
	bh=ELjRw4qKwSoMZylan+i8w8bmVrzrbWCP4Nh2bNeBerU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJpLHHVB+vpiDiD7oXONxo9H+4OWz5pDmzdyLaYTOBLwfd3mIX/jY52+9QWSVxGifubC5lJ80YwsCFqfR6am7J0jSgk/YVkkNj6DfFtooLPMBtazoKgFf5H+L1gyf1ppee0P7unKqIBHumueHkXdboUZiIvW3gqz/2r+nJ9pOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=P374qeqj; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765465471; x=1797001471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cwCs81f0vNPkN78ID9FHsqJBuMhnxPNmOIYW60KiI4Q=;
  b=P374qeqjcikgcH+MnaF+p4MpZ4gtzX0KeN3Mi5+pd9GQ1AVRECMrmUJT
   rF/OXV8IS7lipT4sLOYQmSVR5np7NsqxD5ncleFQI/uQpYTI3upJCRolr
   TPzgllk1YcKBKSsp2Tqz7aWOE6kpocttOkXvRCPLlaLQqH2n+/FawkJUy
   bVbh3JOGe7/ljfTj0/JGyifkMu5fKoUjmZ0nOX6dFhvFkAvGfREIR1j7T
   +Ayzca/N8KfKGDByP4uOWn1wYoIxD+Gi24gw5QhCgHFAKAUPVOnm8aeSu
   VE0zfDDmLGnNq7GBf40jDZtISTXgJ5w8B+mYQyAEE+QoAmoTS3ZkBVkHZ
   w==;
X-CSE-ConnectionGUID: eIzLcVBQSLClYiulwhaZ2g==
X-CSE-MsgGUID: Z2L+z05sR1qArPePkkQpTw==
X-IronPort-AV: E=Sophos;i="6.21,141,1763424000"; 
   d="scan'208";a="8903553"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 15:04:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:21079]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.145:2525] with esmtp (Farcaster)
 id d8c1259c-a35c-4f31-99db-6ab443e229f5; Thu, 11 Dec 2025 15:04:28 +0000 (UTC)
X-Farcaster-Flow-ID: d8c1259c-a35c-4f31-99db-6ab443e229f5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 15:04:28 +0000
Received: from b0be8375a521.amazon.com (10.37.244.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 15:04:24 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<horms@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<jacob.e.keller@intel.com>, <jedrzej.jagielski@intel.com>, <kohei@enjuk.org>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <stefan.wegrzyn@intel.com>
Subject: Re: RE: [Intel-wired-lan] [PATCH iwl-net v2 1/2] ixgbe: fix memory leaks in the ixgbe_recovery_probe() path
Date: Fri, 12 Dec 2025 00:03:10 +0900
Message-ID: <20251211150416.88637-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <IA3PR11MB8986CAD67FDC2D778567A046E5A1A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986CAD67FDC2D778567A046E5A1A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, 11 Dec 2025 10:13:09 +0000, Loktionov, Aleksandr wrote:

>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 4af3b3e71ff1..85023bb4e5a5 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -11468,14 +11468,12 @@ static void ixgbe_set_fw_version(struct
>> ixgbe_adapter *adapter)
>>   */
>>  static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)  {
>> -	struct net_device *netdev = adapter->netdev;
>>  	struct pci_dev *pdev = adapter->pdev;
>>  	struct ixgbe_hw *hw = &adapter->hw;
>> -	bool disable_dev;
>>  	int err = -EIO;
>> 
>>  	if (hw->mac.type != ixgbe_mac_e610)
>> -		goto clean_up_probe;
>> +		return err;
>You've removed the clean_up_probe: label and its cleanup code (free_netdev, devlink_free, pci_release_mem_regions, pci_disable_device) without providing a proof that ixgbe_probe()'s error path correctly handles all these resources.
>I'm afraid this patch may trade one leak for another, or cause double-free issues.

Hi Alex, thank you for taking a look.

First, ixgbe_recovery_probe() is a static function and is only called
from ixgbe_probe(), so potential affected scope is limited to the
ixgbe_probe() function (at least for now). Also I don't think
ixgbe_recovery_probe() is a common util function which would be used in
other functions than ixgbe_probe().

Also I changed ixgbe_probe() to cleanup those resources when
ixgbe_recovery_probe() fails to keep consistency, just because those
resources are allocated by ixgbe_probe(), not by ixgbe_recovery_probe().

Considering the conversation I had in v1 patch [1], I think this change
would be acceptable, and rather preferable to reduce the possibility of
future regression.

[1] https://lore.kernel.org/all/b5787c94-2ad0-4519-9cdb-5e82acfebe05@intel.com/

>> @@ -11655,8 +11646,13 @@ static int ixgbe_probe(struct pci_dev *pdev,
>> const struct pci_device_id *ent)
>>  	if (err)
>>  		goto err_sw_init;
>> 
>> -	if (ixgbe_check_fw_error(adapter))
>> -		return ixgbe_recovery_probe(adapter);
>> +	if (ixgbe_check_fw_error(adapter)) {
>> +		err = ixgbe_recovery_probe(adapter);
>> +		if (err)
>> +			goto err_sw_init;
>The early return 0; on successful ixgbe_recovery_probe() bypasses the remainder of ixgbe_probe().
>The commit message doesn't explain what subsequent initialization steps (if any) are intentionally skipped in recovery mode, or whether this is correct behavior.

On successful path, ixgbe_probe() just returns ixgbe_recovery_probe()
and don't execute following codes, so there's no change of behavior.

