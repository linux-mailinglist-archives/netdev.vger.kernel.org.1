Return-Path: <netdev+bounces-223325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E45B58B93
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0FA7A256C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978D221544;
	Tue, 16 Sep 2025 01:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E271F03FB
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987762; cv=none; b=Vcom6F/mJ2V7LGce1ByJqYTvxQKgWr8koxC19z9+Mb2b0Qk54ES+8bMKOS+OWfbJ12W5FEP3mU9oiLS3j3lVauRFPWzpaV5iruX/A/2DLpcbPF2PtbAuEWSmpNdKjmrUVM+ZVpkLaTUqSevHJU4lOzGbrd3yf6lXhTwGjA38FbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987762; c=relaxed/simple;
	bh=+9ijxWvghtikeNN6h3dm5VQGQS9lq/Yd0JBbG9r3Yps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4oImIhUAuxRcCwmMMpyCE2YCpoSVcDYfYbGmqkYJ57RTImTqaHB3mtjv85ely5RQN7yKyAqrK+9G/U3YoQpqvDASpAGk+0kukIXTYMUN6AXXGxI5IFRQneU7f3EZL/1VYyTZuo8+RVyR93k0ehWJS9ANcl8gChLJY+6KprhyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uyKbj-0003Uz-Ff; Tue, 16 Sep 2025 01:35:47 +0000
Message-ID: <1f99551f-5037-4670-9c2d-a4ce4d5c017e@trager.us>
Date: Mon, 15 Sep 2025 18:35:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/9] eth: fbnic: report FW uptime in health
 diagnose
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, alexanderduyck@fb.com,
 jacob.e.keller@intel.com
References: <20250915155312.1083292-1-kuba@kernel.org>
 <20250915155312.1083292-9-kuba@kernel.org>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20250915155312.1083292-9-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 8:53 AM, Jakub Kicinski wrote:

> FW crashes are detected based on uptime going back, expose the uptime
> via devlink health diagnose.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   .../device_drivers/ethernet/meta/fbnic.rst          |  4 +++-
>   drivers/net/ethernet/meta/fbnic/fbnic_devlink.c     | 13 +++++++++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> index 62693566ff1f..3c81b58d8292 100644
> --- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> +++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> @@ -77,7 +77,9 @@ fw reporter
>   
>   The ``fw`` health reporter tracks FW crashes. Dumping the reporter will
>   show the core dump of the most recent FW crash, and if no FW crash has
> -happened since power cycle - a snapshot of the FW memory.
> +happened since power cycle - a snapshot of the FW memory. Diagnose callback
> +shows current FW uptime (the crashes are detected by checking if uptime
> +goes down).
I was a little surprised to see this since it didn't go through our 
normal internal review and validation process.
>   
>   Statistics
>   ----------
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> index 0e8920685da6..f3f3585c0aac 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> @@ -487,6 +487,18 @@ static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
>   	return err;
>   }
>   
> +static int
> +fbnic_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
> +			   struct devlink_fmsg *fmsg,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct fbnic_dev *fbd = devlink_health_reporter_priv(reporter);
> +
> +	devlink_fmsg_u32_pair_put(fmsg, "FW uptime", fbd->firmware_time);

I originally added fbd->firmware_time as part of the implementation for 
logging support in D51521853. The original idea was to correlate 
firmware logs to host time. This proved to be difficult. Instead I used 
firmware time to detect firmware crashes in D52065019. Time is to set 0 
when fbnic_fw_log_write() is called in fbnic_devlink_fw_report() because 
we don't know the actual time firmware crashed. fbd->firmware_time is 
only updated with the heartbeat is received. When a crash occurs 
fbd->firmware_time is reset once firmware comes back up. Ignoring the 
crash case this should be something like fbd->firmware_time + (jiffies - 
fbd->last_heartbeat_req) * 1000.

Another issue is your using a u32 for fbd->firmware_time which is u64. 
Firmware returns its time by calling k_uptime_get()[1] which returns an 
s64 as its the firmware uptime in milliseconds.

We also don't use firmware time in its raw integer form anywhere in the 
driver or firmware. Its very hard to read FBNIC_FW_LOG_FMT has the 
format used in the driver which is based on what Zephyr uses[2].

IMO this doesn't really have a use case and I would just drop it.


[1] 
https://elixir.bootlin.com/zephyr/v3.7.1/source/include/zephyr/kernel.h#L1751

[2] 
https://github.com/zephyrproject-rtos/zephyr/blob/main/subsys/logging/log_output.c#L263


