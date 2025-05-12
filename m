Return-Path: <netdev+bounces-189634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4CAB2E56
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 06:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B2C3ACEA3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 04:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730B9253335;
	Mon, 12 May 2025 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQkJJN4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE022576
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747023635; cv=none; b=DJxMYHInHO8y3ygmcfBctjK/FFZQj66UKqdIQCoj3qjoV3KF3o34WL47dxnrLozuGeJmNVVINOw5d7hZ6PRPEY1u62SBH0dR3cUTOgiJVeWQ1QEGLAQYR8XKLDFsFMvCznBGjnDnVn13112TyYnstzPcSgMXOoVYYp6mMebVFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747023635; c=relaxed/simple;
	bh=xFjFTe+NtnU298S9gk2TZTUsymEsY0NLdDhk4WVglVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jioyv2A8xKDioNVsMtd80bgUE5FbefruQurn3fAFrlRQ9/ykVjarkAa3gvBouzzCWmpFPp5YVQH0IbGZEwkGKRLRn8RZjXbjryt8jHkUpcntXu1jz2jNZBS7QP4RPZ2rcwtB+6qHIHLLOaRZyc6eKro6NNjgmEs3i1QDRpkIjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQkJJN4g; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30c5478017dso1856051a91.2
        for <netdev@vger.kernel.org>; Sun, 11 May 2025 21:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747023631; x=1747628431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cu5VoM4CpXrNo117/xEcKxA3/BgVAdhTf6jBYHi4y+M=;
        b=GQkJJN4gl7LFn5/bPwgeBE5mG7zlWhcr4aLZzJnsNGmNYHyTHtAFN/MQNYed2YQtN9
         Pw1y6TEoKvpqmwBD3jS8lHRCPFHRf2L0BgAptqek/OFKroaXNxt+p68f9p3t803GB1Lt
         elT5Zq5LRQbeu34LHh0dReRrPS9aUiEeI27lkbDDuSG1M12h7ha7t+ez0vFkQ1vitH6k
         di3zmMpHZZI0mnTyp9m7bBZZh8MrPKntUKbxnWWsLnZBigqvNtguzF+fNyvgzw9uIhYQ
         nxylhaxLe9IjQGZ6QxcJRlw5Myi6Vil8kuxIwzZnJUXsu98CmhQN/YDaQEwS5h9pvQJP
         Ju0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747023631; x=1747628431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu5VoM4CpXrNo117/xEcKxA3/BgVAdhTf6jBYHi4y+M=;
        b=NlyynoB3yzc8rYl2JnP4fq/ruom1ejGM2dIaqve8Smi1U45GE4CUek54qlKh90pIOA
         K6/6cxCvRpErNr5EJGYCrpQ5Px7WlTxpdteJmIpipUVVHZyLVe3ibk0ydaoQM2EbQNaO
         PAtGCNMuXVwsYg384yqCfoCOnA1F9sn3bonwAFUjU/rQP4VybGpYNJlW3WW9EaLBi2EC
         Y/UgtYRrReW9AWqxWRBxq8Imy7YRtrWaGz73w7loVKTYdOyyUsBq3HImqXTmYOxLJd9E
         3WUt79LTQ452tQeG5AdI4u5XTlLAsjVTVgujykT0g4NF8UQtl1rmtrc3uEskpp0BdVxE
         8OlA==
X-Gm-Message-State: AOJu0Yz2xg0m9febSTCjayI5SgtfxY8vsWsaF8P5mbjUxlOx9NsjwMJb
	64aIurOFpLSZ4VAHvQl3fxtZT2Jh8TmhEyLjgvvwB1rfqFYfFQkHa8LnyB8ZgMs=
X-Gm-Gg: ASbGncuVU5/ek4MhfVZgvEhMD+M9VVAj+V4qzh54Tgi61U7IsfkNNaTvKYhjL/dxyX4
	i4b3lzs+nanxCexeJhV4aj6pXV42oFRwk4ybS+vKTHkHwX3GMqmK8yLBRx18dnO42cFe/y6inXX
	1Os61+0QyBqMSGJRojQK5wSd0e+7ja9yL/pNFADVL5H4JUNv8w1bIFnTwJTY1yhE1832PhlRGuG
	gr0tjiU0w/YJOP8pHN1b4AYmc9w2sAmquxVPJx2hfN8nhxeR+9P5nqUzGU3JCIngp6a4a1lidIo
	A4hO6QlI/YP4HTN1M1wL3MNFr2yiQcawXS01Nv3IGaTavltMhEEkr9Ts
X-Google-Smtp-Source: AGHT+IFUWhzNuNJxCypezGQm83zycXSpkjNfDLWGSXjLdmV+azcLJsApWC+dOQ424+1SFQFakJZ10A==
X-Received: by 2002:a17:90b:224d:b0:2ff:5714:6a with SMTP id 98e67ed59e1d1-30c3d3e8f96mr17076255a91.19.1747023631451;
        Sun, 11 May 2025 21:20:31 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8aeasm5659205a91.2.2025.05.11.21.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 21:20:30 -0700 (PDT)
Date: Mon, 12 May 2025 04:20:24 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: David J Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
	pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
	haliu@redhat.com
Subject: Re: [PATCH net-next v1 0/2] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <aCF3CBlFg3G7LDGK@fedora>
References: <20250508183014.2554525-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508183014.2554525-1-wilder@us.ibm.com>

Hi David,
On Thu, May 08, 2025 at 11:29:27AM -0700, David J Wilder wrote:
> This is a followup to this discussion:
>   https://www.spinics.net/lists/netdev/msg1085428.html
> 
> The current implementation of the arp monitor builds a list of vlan-tags by
> following the chain of net_devices above the bond. See: bond_verify_device_path().
> Unfortunately with some configurations this is not possible. One example is
> when an ovs switch is configured above the bond.
> 
> This change extends the "arp_ip_target" parameter format to allow for a list of
> vlan tags to be included for each arp target. This new list of tags is optional
> and may be omitted to preserve the current format and process of gathering tags.
> When provided the list of tags circumvents the process of gathering tags by
> using the supplied list. An empty list can be provided to simply skip the the
> process of gathering tags.
> 
> The purposed new format for arp_ip_target is:
> arp_ip_target=ipv4-address[vlan-tag\...],...
> 
> Examples:
> arp_ip_target=10.0.0.1,10.0.0.2 (Determine tags automatically for both targets)
> arp_ip_target=10.0.0.1[]        (Don't add any tags, don't gather tags)
> arp_ip_target=10.0.0.1[100/200] (Don't gather tags, use supplied list of tags)
> arp_ip_target=10.0.0.1,10.0.0.2[100] (add vlan 100 tag for 10.0.0.2.
>                                       Gather tags for 10.0.0.1.)

Thanks for the update. What about the IPv6 NS targets? Will you support it
or only the arp targets?

BTW, when add or update the parameter, please also update the bond documents
and iproute2 cmd.

Thanks
Hangbin
> 
> This is a work in process. I am requesting feedback on my approach.
> This patch allows the extended format only when setting arp_ip_target values with
> modules parameters.
> 
> TBD: Add support for sysfs, netlink and procfs.
> TBD: Kernel self tests.
> TBD: Documentation.
> 
> David J Wilder (2):
>   bonding: Adding struct arp_target
>   bonding: Extend arp_ip_target format to allow for a list of vlan tags.
> 
>  drivers/net/bonding/bond_main.c    | 163 ++++++++++++++++++++++++-----
>  drivers/net/bonding/bond_netlink.c |   4 +-
>  drivers/net/bonding/bond_options.c |  18 ++--
>  drivers/net/bonding/bond_procfs.c  |   4 +-
>  drivers/net/bonding/bond_sysfs.c   |   4 +-
>  include/net/bonding.h              |  15 ++-
>  6 files changed, 161 insertions(+), 47 deletions(-)
> 
> -- 
> 2.43.5
> 

