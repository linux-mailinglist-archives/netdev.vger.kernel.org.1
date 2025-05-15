Return-Path: <netdev+bounces-190628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F4BAB7E13
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE13B09C9
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B5296FD7;
	Thu, 15 May 2025 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AJuuJZmo"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8D8F6B;
	Thu, 15 May 2025 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290857; cv=none; b=dV75Hz9BHikCQRU1ujpwbbrsQkHplCyqjwd70ml0TtQuMkz96gxyZVOIvpHGuneIEuOyphzFeKRuXLxUIHYmeqofy5aZXgIZfuUgSFTplvrvFcQGIcIOuO8M4W7NQqUWHryNAdXaWh5Esn4N2Ct6qgZoD+dwdNkbZ8ybmp760a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290857; c=relaxed/simple;
	bh=BxTqQTJFamKTMFyyfIqu51/R9NqX8JtDWlXABY8KO5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m7cConfuJGIRCRE11UvChCUS0irdWwRpVLF9DCZ5CG2NxcpgES3obFyoqc+cv3pRcnzSoxGkUg9NZqYN5bQvR9UH85dluUrsrUZ1rM068Lokk2kQi1TOCaSuQG/ndO17eIgamMEkIUgcEvNxTGeC0vUvk6heVf0EuWokEYMn27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AJuuJZmo; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54F6XcsB2840777
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 01:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747290818;
	bh=vsFmIkwdH9OoXCMppMf8wUNa7gtRjrtDKlbCp4u90l4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AJuuJZmoSy+db7mgObmuNpYkkrQ0tFEJr8H+XgANp8lEmD5mFbnpK3VkuKC3KUp1C
	 VNmn4/ashv7iKQSj7ChApECaXKrNf6xFMq/v2rtez45sqUR9OJqjQW0awtb6U7NP0J
	 b19oC07uC/B+xhPyZiWdW4PqPy/Eup1QcZJsUc5s=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54F6XcZR129050
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 May 2025 01:33:38 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 May 2025 01:33:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 May 2025 01:33:37 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54F6XWVx116598;
	Thu, 15 May 2025 01:33:33 -0500
Message-ID: <4373351e-6dfe-428f-8253-dcc6a1374335@ti.com>
Date: Thu, 15 May 2025 12:03:31 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Meghana Malladi <m-malladi@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Roger
 Quadros <rogerq@ti.com>
References: <20250502104235.492896-1-danishanwar@ti.com>
 <20250506141709.rnhvtoghn2tc47rw@skbuf>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250506141709.rnhvtoghn2tc47rw@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vladimir

On 06/05/25 7:47 pm, Vladimir Oltean wrote:
> On Fri, May 02, 2025 at 04:12:35PM +0530, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> The Time-Aware Shaper (TAS) is a key feature of the Enhanced Scheduled
>> Traffic (EST) mechanism defined in IEEE 802.1Q-2018. This patch adds TAS
>> support for the ICSSG driver by interacting with the ICSSG firmware to
>> manage gate control lists, cycle times, and other TAS parameters.
>>
>> The firmware maintains active and shadow lists. The driver updates the
>> operating list using API `tas_update_oper_list()` which,
>> - Updates firmware list pointers via `tas_update_fw_list_pointers`.
>> - Writes gate masks, window end times, and clears unused entries in the
>>   shadow list.
>> - Updates gate close times and Max SDU values for each queue.
>> - Triggers list changes using `tas_set_trigger_list_change`, which
>>   - Computes cycle count (base-time % cycle-time) and extend (base-time %
>>     cycle-time)
>>   - Writes cycle time, cycle count, and extend values to firmware memory.
>>   - base-time being in past or base-time not being a multiple of
>>     cycle-time is taken care by the firmware. Driver just writes these
>>     variable for firmware and firmware takes care of the scheduling.
>>   - If base-time is not a multiple of cycle-time, the value of extend
>>     (base-time % cycle-time) is used by the firmware to extend the last
>>     cycle.
>>   - Sets `config_change` and `config_pending` flags to notify firmware of
>>     the new shadow list and its readiness for activation.
>>   - Sends the `ICSSG_EMAC_PORT_TAS_TRIGGER` r30 command to ask firmware to
>>     swap active and shadow lists.
>> - Waits for the firmware to clear the `config_change` flag before
>>   completing the update and returning successfully.
>>
>> This implementation ensures seamless TAS functionality by offloading
>> scheduling complexities to the firmware.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
> 
> This is not a review comment - just wanted to mention that a week ago,
> I've added a selftest for this feature at
> tools/testing/selftests/net/forwarding/tc_taprio.sh, and I'm wondering
> whether you have the necessary setup to give that a run. That would give
> maintainers a bit more confidence when merging, that things work as
> expected.

I wasn't aware of this. I will check if I have the setup and try to test
it before posting future revisions.

-- 
Thanks and Regards,
Danish

