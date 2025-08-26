Return-Path: <netdev+bounces-216840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F7B35727
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1924B68817C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4D22FB994;
	Tue, 26 Aug 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXUXTdHR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05912FB98A
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197335; cv=none; b=jNL1u1HnjgHXPpu8n4DrFxju2nHmQR0bvbinxFO4rsXd556pAMeFE/Gdoy1turp+JOvfIem9ojYpVmpPNnBi+yzeNeQZbQl8Ofjp1OQFzHWLMfsOiwkFjl6sf6t6XZ3cA0/S2ZQrwiY4PzPa+QCuFJiXfmVhYleaSqmc2gF3R44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197335; c=relaxed/simple;
	bh=ELuQg+ou7xBiKz1KkvymWiic11oJC2+Yk/UNfmBu+XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyB0DHB9k6X6qJDgD1m+NrSAZ/QT65F7hSprbqfUuwwd58bRwmNw7aMiYZfr4JxuS8zdTbAP5a7rQOEq+nONOlcoliGDexmJec7bEZwtz9EvAhzpesnr96JsEhTfNDh1nE4jWKis/uQE7CDMwRvQGE6LIGMdENsmS18199CTd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXUXTdHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663CCC4CEF4;
	Tue, 26 Aug 2025 08:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756197334;
	bh=ELuQg+ou7xBiKz1KkvymWiic11oJC2+Yk/UNfmBu+XI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XXUXTdHRtuhoBfx7d00zeUzkVHX5AMLytU7xc853AwzaweHoqfP7679erW9hA+Cam
	 tfC2Om9SnPE5r44govsoh+aW/SmIZCBdClpao3GfRFNZTJ8A4osKgoA1sdGJ9+EwCh
	 NDgrlQBEhZirqBbsJjulK6fVRUmweeuXDbjEKi9aliCU0+9W9NL1N9ttvzMF+p2Yp9
	 JsbtjJRTJfJ9wJMhsLLICwiOuEX9BgPZxc/MFE4SHECgboSIYfvxdhjmNFZ7E4nMYn
	 LNm1SnseEW2itd5T6oC9xCvDPRMUqLYlD12OBocPZBMA0o2Up2W1JfDbMNRbcdIuSn
	 2d/ptXgZFbadA==
Message-ID: <85c2fea0-686f-435a-a539-81491a316e46@kernel.org>
Date: Tue, 26 Aug 2025 10:35:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: fix Rx page leak on multi-buffer frames
To: Jacob Keller <jacob.e.keller@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Christoph Petrausch <christoph.petrausch@deepl.com>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 kernel-team <kernel-team@cloudflare.com>
References: <20250825-jk-ice-fix-rx-mem-leak-v2-1-5afbb654aebb@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250825-jk-ice-fix-rx-mem-leak-v2-1-5afbb654aebb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/08/2025 01.00, Jacob Keller wrote:
> XDP_DROP performance has been tested for this version, thanks to work from
> Michal Kubiak. The results are quite promising, with 3 versions being
> compared:
> 
> * baseline net-next tree
> * v1 applied
> * v2 applied
> 
> Michal said:
> 
>    I run the XDP_DROP performance comparison tests on my setup in the way I
>    usually do. I didn't have the pktgen configured on my link partner, but I
>    used 6 instances of the xdpsock running in Tx-only mode to generate
>    high-bandwith traffic. Also, I tried to replicate the conditions according
>    to Jesper's description, making sure that all the traffic is directed to a
>    single Rx queue and one CPU is 100% loaded.
> 

Thank you for replicating the test setup.  Using xdpsock as a traffic
generator is fine, as long as we make sure that the generator TX speeds
exceeds the Device Under Test RX XDP_DROP speed.  It is also important
for the test that packets hits a single RX queue and we verify one CPU 
is 100% load, as you describe.

As a reminder the pktgen kernel module comes with ready-to-use sample 
shell-scripts[1].

  [1] https://elixir.bootlin.com/linux/v6.16.3/source/samples/pktgen

> The performance hit from v1 is replicated, and shown to be gone in v2, with
> our results showing even an increase compared to baseline instead of a
> drop. I've included the relative packet per second deltas compared against
> a baseline test with neither v1 or v2.
> 

Thanks for also replicating the performance hit from v1 as I did in [2].

To Michal: What CPU did you use?
  - I used CPU: AMD EPYC 9684X (with SRSO=IBPB)

One of the reasons that I saw a larger percentage drop is that this CPU
doesn't have DDIO/DCA, which deliver the packet to L3 cache (and a L2
cache-miss will obviously take less time than a full main memory cache-
miss). (Details: Newer AMD CPUs will get something called PCIe TLP
Processing Hints (TPH), which resembles DDIO).

Point is that I see some opportunities in driver to move some of the
prefetches earlier. But we want to make sure it benefits both CPU types,
and I can test on the AMD platform. (This CPU is a large part of our
fleet so it makes sense for us to optimize this).

> baseline to v1, no-touch:
>    -8,387,677 packets per second (17%) decrease.
> 
> baseline to v2, no-touch:
>    +4,057,000 packets per second (8%) increase!
> 
> baseline to v1, read data:
>    -411,709 packets per second (1%) decrease.
> 
> baseline to v2, read data:
>    +4,331,857 packets per second (11%) increase!

Thanks for providing these numbers.
I would also like to know the throughput PPS packet numbers before and
after, as this allows me to calculate the nanosec difference. Using
percentages are usually useful, but it can be misleading when dealing
with XDP_DROP speeds, because a small nanosec change will get
"magnified" too much.

> ---
> Changes in v2:
> - Only access shared info for fragmented frames
> - Link to v1: https://lore.kernel.org/netdev/20250815204205.1407768-4-anthony.l.nguyen@intel.com/

[2] 
https://lore.kernel.org/netdev/6e2cbea1-8c70-4bfa-9ce4-1d07b545a705@kernel.org/

> ---
>   drivers/net/ethernet/intel/ice/ice_txrx.h |  1 -
>   drivers/net/ethernet/intel/ice/ice_txrx.c | 80 +++++++++++++------------------
>   2 files changed, 34 insertions(+), 47 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

