Return-Path: <netdev+bounces-31574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A472B78ED9E
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 14:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7FA281566
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABBA11706;
	Thu, 31 Aug 2023 12:50:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226429A0
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 12:50:53 +0000 (UTC)
Received: from out-247.mta1.migadu.com (out-247.mta1.migadu.com [IPv6:2001:41d0:203:375::f7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A75CF2
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 05:50:49 -0700 (PDT)
Message-ID: <f7c7aeb7-c43a-23c0-1c93-2bcb79d4d689@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693486247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBzsFF9Aekog2IqwVNJElwdWwC36Gc+4PxmW8O3uWXA=;
	b=Qel81u6H0iUgB/UTe9FW3bsMg+TNKvOTmwI48o2fEjQKmJEqgM9WLUXzL5iWMEoMrxPzsF
	A3XwLPIi/vfYUGuqka6ALU6HUEh+cgi5+aFY7li9i72ZnXjVlxU8rFWRmshCXCd4r0hKax
	g9gDSyHsL/81OkrezYOTFXVaovJnEUM=
Date: Thu, 31 Aug 2023 08:50:42 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: fix timestamp configuration
 code
Content-Language: en-US
To: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>,
 "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, "Rustad, Mark D" <mark.d.rustad@intel.com>,
 Darin Miller <darin.j.miller@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20230823221537.816541-1-vadim.fedorenko@linux.dev>
 <BL0PR11MB3122FF925838E8F850787467BDE5A@BL0PR11MB3122.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <BL0PR11MB3122FF925838E8F850787467BDE5A@BL0PR11MB3122.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 31/08/2023 06:18, Pucha, HimasekharX Reddy wrote:
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Vadim Fedorenko
>> Sent: Thursday, August 24, 2023 3:46 AM
>> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Jakub Kicinski <kuba@kernel.org>; Alexander Duyck <alexander.duyck@gmail.com>; Rustad, Mark D <mark.d.rustad@intel.com>; Darin Miller <darin.j.miller@intel.com>; Jeff Kirsher <jeffrey.t.kirsher@intel.com>; Richard Cochran <richardcochran@gmail.com>
>> Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix timestamp configuration code
>>
>> The commit in fixes introduced flags to control the status of hardware
>> configuration while processing packets. At the same time another structure
>> is used to provide configuration of timestamper to user-space applications.
>> The way it was coded makes this structures go out of sync easily. The
>> repro is easy for 82599 chips:
>>
>> [root@hostname ~]# hwstamp_ctl -i eth0 -r 12 -t 1
>> current settings:
>> tx_type 0
>> rx_filter 0
>> new settings:
>> tx_type 1
>> rx_filter 12
>>
>> The eth0 device is properly configured to timestamp any PTPv2 events.
>>
>> [root@hostname ~]# hwstamp_ctl -i eth0 -r 1 -t 1
>> current settings:
>> tx_type 1
>> rx_filter 12
>> SIOCSHWTSTAMP failed: Numerical result out of range
>> The requested time stamping mode is not supported by the hardware.
>>
>> The error is properly returned because HW doesn't support all packets
>> timestamping. But the adapter->flags is cleared of timestamp flags
>> even though no HW configuration was done. From that point no RX timestamps
>> are received by user-space application. But configuration shows good
>> values:
>>
>> [root@hostname ~]# hwstamp_ctl -i eth0
>> current settings:
>> tx_type 1
>> rx_filter 12
>>
>> Fix the issue by applying new flags only when the HW was actually
>> configured.
>>
>> Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices")
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 28 +++++++++++---------
>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>
> 
> Hi,
> With patch also we are observing same issue.

Hi,

What kind of issue do you observe? The hardware doesn't support
timestamping of all packets. The issue this patch fixes is that
after failed attempt to setup the timestamping of all RX packets,
the driver stops reading timestamps at all even though it reports
that timestamping of PTP RX packets is enabled.

> 
> # ./hwstamp_ctl -i eth10
> current settings:
> tx_type 1
> rx_filter 12
> # ./hwstamp_ctl -i eth10 -r 1 -t 1
> current settings:
> tx_type 1
> rx_filter 12
> SIOCSHWTSTAMP failed: Numerical result out of range
> The requested time stamping mode is not supported by the hardware.
> 
> Adapter details: Niantic (Spring Fountain)
> 
> SUT info:
> H/W:
>    Manufacturer: Intel Corporation
>    Product Name: S2600STQ
>    RAM: [62G/8G/49G]
>    CPU: Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz [112/112]
>    PF bus-info: 0000:d8:00.1 0x8086:0x10fb 0x8086 0x000c (0x01)
> S/W:
>    OS: "Red Hat Enterprise Linux 8.6 (Ootpa)" 6.5.0-rc7_next-queue_28-Aug-2023-01755-g938672aefaeb
>    CMD: BOOT_IMAGE=(hd0,msdos2)/vmlinuz-6.5.0-rc7_next-queue_28-Aug-2023-01755-g938672aefaeb root=/dev/mapper/rhel_os--delivery-root ro crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M resume=/dev/mapper/rhel_os--delivery-swap rd.lvm.lv=rhel_os-delivery/root rd.lvm.lv=rhel_os-delivery/swap selinux=0 biosdevname=0 net.ifnames=0 rhgb quiet
>    FW firmware-version: 0x000161bf
>    PF version: 6.5.0-rc7_next-queue_28-Aug-202
> 
> 


