Return-Path: <netdev+bounces-226629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138EDBA3332
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B165F1707B5
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D02C279912;
	Fri, 26 Sep 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BROowLmg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35226C391
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879657; cv=none; b=NjaydJ/fvSldECOvFCpT6bjZcw2I/I4e8z5b6v4X4J/NPO1YNqqERM5aOmmHUGXR+peuy6+YnXcFjDW/Ga7ZHQCYJVEK+04JdAFz6frMH4coyhjrc0N0Q6fE9v7q3FEgq3QgLNbgfA1GsI6bvM000GjRPE4p2nJw95lAZ4f1agg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879657; c=relaxed/simple;
	bh=hdjeidLy/DTrwYPbRgReEbCf5/OAikiJ4kB5bloN8qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vAQ8ST5W03FJOXs8ishdYZY0dtQYXvPggOs36GKfXCaJy56KkinG4WBYpxOAgQ8fqeKKUqDVBO9uovI11IobkKRLEoAkJTMaSj+SCHnpQivrdFAKvK3nprlKuTEdkUHhRfWvWmT1RIjwii/P2JtkMCb86+f2S/xV9ygFRTOBiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BROowLmg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3164978f11so358717966b.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758879654; x=1759484454; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bfnGggrEWUuSTcwCWFUw26kUzRfzuZNMtwAcFeMvGfk=;
        b=BROowLmgTfCcQJHxOizONg6zOnEhIdQVO+xyKtbf8C7tJNdZ5IjIOsvkhy/LkgpED0
         NxGiz69OP3KNRTwAdcVIciCylWcx1TmF97gFyGjYf9iB1UKRDGuz2BFOLx+98iS8YNa0
         vnNKEa0L/bNfOTM4GMZSGsKcJ7BWyQNQ0ioep6vX/qhPmqPcD4ikkw8sg5nc1f1X3Vyd
         7iEYKaaoBtvMbh+tTGVzGF10APHArdWyTCb09eV0w4huxdyg5wuH1FC9jzDKHj59A5sl
         bZ+vFBdTH6rhqSKEZZLIpK32WH8M4Ae0qLgEn8rZrwNcKtzYljDe20qkS89BoFCJ2IuV
         envw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879654; x=1759484454;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfnGggrEWUuSTcwCWFUw26kUzRfzuZNMtwAcFeMvGfk=;
        b=LRkcGaxgqRpa3mJhIQlzLjGZcrpIEPQtp+Ff1XbAO7TEVvTnRzzYivUJBAcfxNbVYq
         mJdNzqKjUcz4NW/ea8Y5phOrMw44Y425pQFlhZrxmeEGTA5Cusw4yokZkgWCy3yPgMEr
         y9/UeKkpqw6zJ2A9HU+LZYIfnPM2ANfK092Hp5ODWeWms0IjL83emKt1NnRSZX7r3+Sh
         SQS5/suJXtd3Mq+nsaGr5eXonaczuw+9U+TRd2eP3OpzVEtXuytKYNWgtFwJpKRNG/a8
         WXh4NJS+sp/CqIYQARWuW/rAz0/4kHOp6hau9lQJAJv3/Wo452qbqURy+MSxYG+HAtV7
         RO8A==
X-Forwarded-Encrypted: i=1; AJvYcCXSUucdVV8PfExFrRG3HJ41YBB6qthfs+MK/qyefcg1TV51xWeI93XNXLYD86Z/7kHnXTweiKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4p6Y0AFovCa2N/dJLzvkGvKKmLPm0lT0fLWeRzJHq/E71eO9
	1+Q7TRpsVocUrYw0wwF7wZ9E2O0RrdzKPgCgvRB058kTSkgAxHhX1Fd8+XA6tZ/UfTA=
X-Gm-Gg: ASbGnctx53BKQ+8MqmxNEcjj6NsIU2sZaLe4SP2lTLE3LsdbLGz3tu/vurdW6mQOi6d
	eQOVIr5TdN2abtij3WXnqo8TwAkFIk32kB/QC6BckjQYz2pXbhpLgZAwY7+2KiKVvdOOprAPOhy
	HjOFHey3pqq0epK6tWERtUgNIZgS7TbArV2r887Kt8soV25QiWBDdcE3fjwFkMo85TuyUvZwn1W
	CJteezxEn5Tm+wZKc2IDUlenW45J16fIVMTPFtKTXnc5CVTOj3eeBDcB4G1yJlHDEgsNStVw29R
	C0VjHa11csRflmCPo0VC+s4P9pvJBgUUqTstKeAXQohrBM66W3NYDZjvLLgNIfBVdFXv4PlsTCA
	5WXvad+ryC588i4A=
X-Google-Smtp-Source: AGHT+IEx87dvLbs8zYXX1kmFHzSkQDWXCcEaHIBwECYQqOzBzrboZ8xaGC921BePUzyI0T1ED/vkEQ==
X-Received: by 2002:a17:907:3e21:b0:b34:99e3:3a88 with SMTP id a640c23a62f3a-b34bbccf844mr658946166b.58.1758879653689;
        Fri, 26 Sep 2025 02:40:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:a2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b37b3b46ba0sm131571766b.2.2025.09.26.02.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:40:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Michal Kubiak <michal.kubiak@intel.com>,
  <intel-wired-lan@lists.osuosl.org>,  <maciej.fijalkowski@intel.com>,
  <aleksander.lobakin@intel.com>,  <larysa.zaremba@intel.com>,
  <netdev@vger.kernel.org>,  <przemyslaw.kitszel@intel.com>,
  <pmenzel@molgen.mpg.de>,  <anthony.l.nguyen@intel.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH iwl-next v3 0/3] ice: convert Rx path to Page Pool
In-Reply-To: <182d8f19-aca7-482e-8983-3806ebb837ba@intel.com> (Jacob Keller's
	message of "Thu, 25 Sep 2025 10:22:16 -0700")
References: <20250925092253.1306476-1-michal.kubiak@intel.com>
	<877bxm4zzk.fsf@cloudflare.com>
	<182d8f19-aca7-482e-8983-3806ebb837ba@intel.com>
Date: Fri, 26 Sep 2025 11:40:51 +0200
Message-ID: <87plbd361o.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 10:22 AM -07, Jacob Keller wrote:
> On 9/25/2025 2:56 AM, Jakub Sitnicki wrote:
>> On Thu, Sep 25, 2025 at 11:22 AM +02, Michal Kubiak wrote:
>>> This series modernizes the Rx path in the ice driver by removing legacy
>>> code and switching to the Page Pool API. The changes follow the same
>>> direction as previously done for the iavf driver, and aim to simplify
>>> buffer management, improve maintainability, and prepare for future
>>> infrastructure reuse.
>>>
>>> An important motivation for this work was addressing reports of poor
>>> performance in XDP_TX mode when IOMMU is enabled. The legacy Rx model
>>> incurred significant overhead due to per-frame DMA mapping, which
>>> limited throughput in virtualized environments. This series eliminates
>>> those bottlenecks by adopting Page Pool and bi-directional DMA mapping.
>>>
>>> The first patch removes the legacy Rx path, which relied on manual skb
>>> allocation and header copying. This path has become obsolete due to the
>>> availability of build_skb() and the increasing complexity of supporting
>>> features like XDP and multi-buffer.
>>>
>>> The second patch drops the page splitting and recycling logic. While
>>> once used to optimize memory usage, this logic introduced significant
>>> complexity and hotpath overhead. Removing it simplifies the Rx flow and
>>> sets the stage for Page Pool adoption.
>>>
>>> The final patch switches the driver to use the Page Pool and libeth
>>> APIs. It also updates the XDP implementation to use libeth_xdp helpers
>>> and optimizes XDP_TX by avoiding per-frame DMA mapping. This results in
>>> a significant performance improvement in virtualized environments with
>>> IOMMU enabled (over 5x gain in XDP_TX throughput). In other scenarios,
>>> performance remains on par with the previous implementation.
>>>
>>> This conversion also aligns with the broader effort to modularize and
>>> unify XDP support across Intel Ethernet drivers.
>>>
>>> Tested on various workloads including netperf and XDP modes (PASS, DROP,
>>> TX) with and without IOMMU. No regressions observed.
>> 
>> Will we be able to have 256 B of XDP headroom after this conversion?
>> 
>> Thanks,
>> -jkbs
>
> We should. The queues are configured through libeth, and set the xdp
> field if its enabled on that ring:
>
>> @@ -622,8 +589,14 @@ static unsigned int ice_get_frame_sz(struct ice_rx_ring *rx_ring)
>>   */
>>  static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>>  {
>> +	struct libeth_fq fq = {
>> +		.count		= ring->count,
>> +		.nid		= NUMA_NO_NODE,
>> +		.xdp		= ice_is_xdp_ena_vsi(ring->vsi),
>> +		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
>> +	};
>
>
> If .xdp is set, then the libeth Rx configuration reserves
> LIBETH_XDP_HEADROOM, which is XDP_PACKET_HEADROOM aligned to
> NET_SKB_PAD, + an extra NET_IP_ALIGN, which results in 258 bytes of
> headroom reserved.

That's great news. We've been observing a growing adoption of custom XDP
metadata ([1], [2]) at Cloudflare, so the current 192B of headroom in
ICE was limiting.

[1] https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
[2] https://docs.kernel.org/networking/xdp-rx-metadata.html#af-xdp

