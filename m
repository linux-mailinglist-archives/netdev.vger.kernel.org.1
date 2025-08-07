Return-Path: <netdev+bounces-212005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC7AB1D1A6
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 06:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743601AA124F
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 04:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33C1D79A5;
	Thu,  7 Aug 2025 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfIJFaWp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4215624D
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 04:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541527; cv=none; b=tMAGE4VA9WN5oByRYhA5z50t2YR7WO0ctXUFE6JJd1lHur4alkxvk3JgyPM7a/XdBk18QD0gUWVBByw5C+R2h2hqgGecjWH45tUrkmjaZflp5yOpGm4YkB+I7OTSoYtcU9F1+dHXc2GqRdz/91u6xf7/i91WFrU3VTnuZC65J9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541527; c=relaxed/simple;
	bh=x2ZYGZfH3I7Uqdkhrwul3uUl0KHerF6a/4dG5H5V4Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRtWRsBSr0lZeB4INZknE0/CfzNyG/1wkoO1xmpiTC+hEUvpbvz79ihSBjv396Sc5zcSR9eNS/QrnRgKQLDJB4YrI92ac7ZfqwHZd2g9jmkAw4DiA0gKKiE304laMppAl2snvkQpARVvk8AHUYga2TB/DxQj0KggXffJcYZ9sSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfIJFaWp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b423b13e2c3so390960a12.3
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 21:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754541525; x=1755146325; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OkY8V0c/81hZNNIrda+XGugarw12aAeDJ9CewbXBJTg=;
        b=GfIJFaWpyNppLaBaT9iJECvmQ2egWt923a4MUk3BI4yplI6URlPbi5k+alZF5a760J
         fGDgHHTVA9Ppf2rx6WQ3wuLAzlLY1i7dEwjrmaJPCNtMyx8ZX7ZYcYG8dSAnFLC2c7yU
         I7FE023JrjTGZRFOxCxYqHvBzxW87a1ZNZ0DjS52+loxpVrOinNhHGF6ZSC4wAN79oQ0
         VOzZ1LjFK42e7vUJdPCuvZZXBg24ssQd1z0c3H/IzeItgY0mKl4n/lEM6UJwik/hCRYD
         Xc3JqtsE0gON3QZrH7Irtq4bDK8gigdvatvHPzSvdWzBNtwGpYU0Ip6enlxdHAw5Q+Dr
         GC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754541525; x=1755146325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkY8V0c/81hZNNIrda+XGugarw12aAeDJ9CewbXBJTg=;
        b=cBiWjck1mEOlBmDog3OtVh0v2rC3PuHq2Ho3+gzsbX2ziceDZahYJoriBE66Q7WfTd
         K0X1dA195qP4m2+J7sWFYWvQSLhfj9TEaytYDYvb6NivImh0Xf8qexDygegp4ysa4WG5
         Jxz4y4Kx7TjH1icdVhTgZRckvepJfjOlsdI0CHYgQBaEdDg1SGoPp/Mf8v4Nx8BNK4dF
         xRgIboMH5VBBehHrFBZums71uGb7mSA4Tp1b69NBT4/k0FnEjJR1+P25jQCjJGr8RmPe
         6kVSj1VFKw27iHRh0aSx7V/OeO2GV65KuwqTehRYpX7+wbJ9TjPjjJFidU9dBZvc8WwU
         nhlA==
X-Gm-Message-State: AOJu0YwR7C3Z6w9RkDdoKbY8uTWSGoNyj1/R7OuG+paS4f+TYjrBVLnv
	0N09f1caUCGCZCUKsSULhdvicdtv/rGEglImDFQ546yR3L4hIw3aslHi
X-Gm-Gg: ASbGnct6VFTQC6J5l2f5l3p0DaEF5SQP0/aIH/NB6H+nGH+ay16C6G1TFLgLBaCwCnZ
	JUN0Vf3QsaaN0UnbXZhXbQ2wsXtvmNxc3LOHAY5ax6zgp62n2bGL+W7edDcMY/m8LocqUV9zY9X
	erJ8phrmC0NqOtjd2U819sxBksmuHIQL52YMVCeK5lUEsvYZsrCZz+2szox2qDl46FgCMynpcqH
	UfARDD0XNhwVWtkBa9PO32ITjGTbxSIv+XxuJU9220GOOQNzIS7WEPlpDm+JgpywnN8Y0fBZmBr
	b3k5tOWLsU99lBieggyAbqe+35ynF+L1ficX4Xu6hRfsfuqY6YwCcHe9Rz3OkmaSk8vTwxQELey
	y+FSD+APo6Q1aeFELOXjG2FHqV0I=
X-Google-Smtp-Source: AGHT+IHTBA/dmjC9V5EMfyjPzUpdjTPaVn3ElFrzb/mcWhs/LsD+tSnRsWIFJ1dKmQSk0j2xLXnl3w==
X-Received: by 2002:a17:90a:c2ce:b0:31f:22f:a221 with SMTP id 98e67ed59e1d1-3216757023fmr7581047a91.29.1754541524927;
        Wed, 06 Aug 2025 21:38:44 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b428f4c8639sm784334a12.43.2025.08.06.21.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 21:38:44 -0700 (PDT)
Date: Thu, 7 Aug 2025 04:38:37 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Wilder <wilder@us.ibm.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
	Pradeep Satyanarayana <pradeep@us.ibm.com>,
	"i.maximets@ovn.org" <i.maximets@ovn.org>,
	Adrian Moreno Zapata <amorenoz@redhat.com>
Subject: Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <aJQtzYe0XyFAEKFz@fedora>
References: <20250627201914.1791186-1-wilder@us.ibm.com>
 <aGJkftXFL4Ggin_E@fedora>
 <MW3PR15MB391317D5FD3E0DCE1E592EE0FA46A@MW3PR15MB3913.namprd15.prod.outlook.com>
 <aGOKggdfjv0cApTO@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGOKggdfjv0cApTO@fedora>

Hi David,
On Tue, Jul 01, 2025 at 07:13:06AM +0000, Hangbin Liu wrote:
> > From: Hangbin Liu <liuhangbin@gmail.com>
> > Sent: Monday, June 30, 2025 3:18 AM
> > To: David Wilder
> > Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu
> > Subject: [EXTERNAL] Re: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
> > 
> > > On Fri, Jun 27, 2025 at 01:17:13PM -0700, David Wilder wrote:
> > > I have run into issues with the ns_ip6_target feature.  I am unable to get
> > > the existing code to function with vlans. Therefor I am unable to support
> > > A this change for ns_ip6_target.
> > 
> > > Any reason why this is incompatible with ns_ip6_target?
> > 
> > Hi Hangbin
> > 
> > I am unable to get the existing ns_ip6_target code to function when the target
> > is in a vlan. If the existing code is not working with vlans it makes no
> > sense to specify the vlan tags.
> > 
> > This is what I think is happening:
> > 
> > In ns_send_all() we have this bit of code:
> > 
> > dst = ip6_route_output(dev_net(bond->dev), NULL, &fl6);
> > if (dst->error) {
> >         dst_release(dst);
> >         /* there's no route to target - try to send arp
> >          * probe to generate any traffic (arp_validate=0)
> >          */
> >         if (bond->params.arp_validate)
> >                bond_ns_send(slave, &targets[i], &in6addr_any, tags);
> >                <.......>
> >                continue;
> > }
> > 
> > ip6_route_output() is returning an error as there is no neighbor entry for
> > the target. A ns is then sent with no vlan header. I found that the
> > multicast ns (with no vlan header) is not passed to the vlan siblings
> > with the target address so no reply is sent.
> > 
> > The ipv4 code is simmiler but the arp is sent as a brodcast. The broadcast arp
> > will be propagated to the vlan sibling (in the linux vlan code).
> > 
> > This could be a testing issue,  I am unsure.  Can you help with
> > a test case with the target in a vlan?

I looked into this recently, and you are right — ip6_route_output() returns
an error dst. The root cause is that we cannot get the destination IPv6
address through the bond interface, because the source IPv6 address is
configured on other interfaces, the VLAN sub-interface.

This is a key difference between IPv6 and IPv4:
In IPv4, it's possible to get a destination route via the bond even when the
source IP is configured on a different interface. But in IPv6, the routing
mechanism is stricter in requiring the source address to be valid on the
outgoing interface.

I'm not sure how to fix this yet, as it's fundamentally tied to how IPv6
routing behaves.

Thanks
Hangbin
> 
> I can reproduce this issue. I guess it's because the IPv6 route code is
> different with IPv4. I will check this issue.
> 
> Thanks
> Hangbin
> 

