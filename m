Return-Path: <netdev+bounces-60180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A46381DF91
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6CA1C217A3
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325E615EBB;
	Mon, 25 Dec 2023 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxBqeFk9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07250171B4
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703497640; x=1735033640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rlpd3UlQEWJrxpTZBvVC4ryivn0KgIhOOqKJ7HEBPMM=;
  b=TxBqeFk9PcqZJEv7jPRYzJCZDRLQEDm/QKmFPu/FxotvfuZHvV49T0KK
   a40GD716QYw7aTyPSw0Qp73EmrolDudT5adVKUeKmRtwrGwzyo7tNNQD7
   zAP34yKu/QGQBCVgaLCpbAPmoRmKJnA6QJVLsfe4RinMA1byoV4HQJFxR
   x1rYeN2tSrsWJC5qycF8yppUIjZb1s98oi6p3t7FpEyrrKW0PiD20QKzo
   OJKzDY4OUlqEauQwWfysjqgx9FIN6gHFn4RqeEwJ4w+gKEbp6hHZ7hijr
   5TYfl714pUXuFAI4i/+6z2KSwwcpecJGtsz6HHTAm33+z09idxiuIvjIi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="400101374"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="400101374"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 01:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="777693071"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="777693071"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.245.129.131]) ([10.245.129.131])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 01:47:16 -0800
Message-ID: <c3f3e361-e875-41fb-929c-ea3f0773c8d3@linux.intel.com>
Date: Mon, 25 Dec 2023 11:47:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/2] igc: Report VLAN
 EtherType matching back to user
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20231201075043.7822-1-kurt@linutronix.de>
 <20231201075043.7822-2-kurt@linutronix.de>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231201075043.7822-2-kurt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/2023 09:50, Kurt Kanzenbach wrote:
> Currently the driver allows to configure matching by VLAN EtherType.
> However, the retrieval function does not report it back to the user. Add
> it.
> 
> Before:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 action 0
> |Added rule with ID 63
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 63
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        Action: Direct to queue 0
> 
> After:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 action 0
> |Added rule with ID 63
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 63
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        VLAN EtherType: 0x8100 mask: 0x0
> |        VLAN: 0x0 mask: 0xffff
> |        User-defined: 0x0 mask: 0xffffffffffffffff
> |        Action: Direct to queue 0
> 
> Fixes: 2b477d057e33 ("igc: Integrate flex filter into ethtool ops")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

