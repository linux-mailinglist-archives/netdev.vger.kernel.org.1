Return-Path: <netdev+bounces-118432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09B95193F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2211F262F9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC713D298;
	Wed, 14 Aug 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awt0IobI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F831AE043
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632307; cv=none; b=bx6nnok/Nu5IdGg8gx9YTVdZ/bkZ8qudcrIn3BPt0o0Jai18Nh7qNud/NEH04GNQSyfRkWyr4WrY+UaLeUl6Ojx55kaQZKMi7lTtB9SgpZJrSSV2fhvwKSsG/IBZu/kSlfXcsHclkE+beaA8578wwu1tfC44rmTdS5pfqJhv+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632307; c=relaxed/simple;
	bh=a5KrdtRLOgpr8DwJFZLF1WHA9kk/i1MzhU2jglxWUG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNCFwPaLdd5qZuC01Vg6OdcVdnKHugA8Y9VbVD7+0Tq+L3wsjGc57c+6kFfT2yPQOnqKbOdAtZFyIBaxFxjcLJ4WWVkF5KCoP8JtrQ9o2Ogv7icc//hGoEJqjJoOrFAy1mNjPVftCiWBVMjMLss0y/VNjnyo0DAFkQj87bo6pIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awt0IobI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723632305; x=1755168305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a5KrdtRLOgpr8DwJFZLF1WHA9kk/i1MzhU2jglxWUG8=;
  b=awt0IobIe07XFV02y4FHz4F9gxH2N6FYYSJy4ie5Vr3ZMqs9zwwhPDJu
   askzufJHm6lz6HdsgMDj2jhsenhiMQ0mIXm3Tfr1uItN8y4uYxUK1TgeF
   r4sWathxWlIfsUb6MCtnrzvACRhpY+hLIxlZCaAHaNWKqiI8kheDk3B+n
   uULDqUjgxVU+GAuY6CB3zZRX04rWts5dEgkvPxqzq8He5S7yv3d59aNdE
   5swmS/Tl70107Hg583gREi+YpnXkTprcYLka2nTcNM7c4YA/K4VwtBoPH
   niUA0oRav44QMlCEcLHhXZ/zTsSJkqeOroOUstHS9n66BLAcq3MuEGN+6
   Q==;
X-CSE-ConnectionGUID: YdJxscb5QoSfdjNs4JsPJA==
X-CSE-MsgGUID: jbncllqERbO48LslSSHsww==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21651978"
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="21651978"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 03:45:04 -0700
X-CSE-ConnectionGUID: FXDONt9bRzKKKWKeerycnA==
X-CSE-MsgGUID: R6hydafiSUCzC5YE6Bp2tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="58933088"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.245.130.66]) ([10.245.130.66])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 03:45:00 -0700
Message-ID: <40210c88-1e3a-44d2-8907-1530500eab91@linux.intel.com>
Date: Wed, 14 Aug 2024 12:44:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: Add netif_device_attach/detach into PF reset
 flow
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Igor Bagnucki <igor.bagnucki@intel.com>
References: <20240812102210.61548-1-dawid.osuchowski@linux.intel.com>
 <CAH-L+nOFqs-K5YzfrfmpRHbhDGM-+1ahhWh4NXATX1FqZiPVLQ@mail.gmail.com>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <CAH-L+nOFqs-K5YzfrfmpRHbhDGM-+1ahhWh4NXATX1FqZiPVLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.08.2024 05:19, Kalesh Anakkur Purayil wrote:
> On Mon, Aug 12, 2024 at 3:52 PM Dawid Osuchowski
> <dawid.osuchowski@linux.intel.com> wrote:
>> @@ -7568,11 +7570,13 @@ static void ice_update_pf_netdev_link(struct ice_pf *pf)
>>
>>                  ice_get_link_status(pf->vsi[i]->port_info, &link_up);
>>                  if (link_up) {
>> +                       netif_device_attach(pf->vsi[i]->netdev);
>>                          netif_carrier_on(pf->vsi[i]->netdev);
>>                          netif_tx_wake_all_queues(pf->vsi[i]->netdev);
>>                  } else {
>>                          netif_carrier_off(pf->vsi[i]->netdev);
>>                          netif_tx_stop_all_queues(pf->vsi[i]->netdev);
>> +                       netif_device_detach(pf->vsi[i]->netdev);
> [Kalesh] Is there any reason to attach back the netdev only if link is
> up? IMO, you should attach the device back irrespective of physical
> link status. In ice_prepare_for_reset(), you are detaching the device
> unconditionally.
> 
> I may be missing something here.

Hey Kalesh,

I think you are right, it is a mistake on my end. I have already sent a 
v2 but without this change. I just tested if this works with the attach 
irrespective of link status and it also resolves the reported issue that 
the patch is supposed to fix and doesn't introduce any regression that I 
am aware of. I will forward your concern to the v2 thread and will post 
a v3 with the change.

--Dawid

>>                  }
>>          }
>>   }
> 
>> --
>> 2.44.0
>>
>>
> 
> 
> --
> Regards,
> Kalesh A P


