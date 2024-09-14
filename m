Return-Path: <netdev+bounces-128331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A3B978FCD
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 12:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8831F20ECB
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058983032A;
	Sat, 14 Sep 2024 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4nK8NlM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896712BB09
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308127; cv=none; b=UAtSHCSH9B3Bplox+IpOuco0t63Fqfh1cBxE0SahtXL5yOx+LeG1hpzI2Wt2rlY/fvyQb/ymemaP8bk+WeYF+dfi47jD4ehe2KGspYn5baS6S+sMZqHjH+FEPnDAjsqn0tGFB3/jpOR8Vx5lo9gAFaqRsvW6zlWWTuYHJALVQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308127; c=relaxed/simple;
	bh=R8xOgR5VsugEe+y8yoOqZqzMHADQaOvJIWjkuqS4BfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiute3bJiPFvyUtP2ruBYpy4JoCmyicXm6R30P3aRlwYMI+3s+KZdIQGj81V3UDxZqHWCepsUpTCssIJtydYMLWvJf/ssK1yx+EU3NbErQrPsn/W/m1wYWZitciKJBHfrdiTtH7T4bbA2jpoC7wUimrwMOrjCD2Vs58uUWwLWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4nK8NlM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20551e2f1f8so19253745ad.2
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726308126; x=1726912926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zmwLZDktvjILrPQJbKMJaQkPt6Y8bnfMAolJBb47Gg=;
        b=I4nK8NlM1TXdxbPzl1s8cwcxUqyc7eJfc2ER3gEqZHWR7/8080QPykWn8EvWgUVNJM
         IWLXImNyHnWAy/3MilLPmdMvcMum5KqrT4dzNkgf5bsT3U0/Z8CcC3Aou37qewwKqiGu
         fuNv2LvpA5HFZyua+V4LRuAjRD687xm0n9l7N8Fck3+LFzSWursEnwNLTHBsNboH40Kj
         2zIiMu0kND9OOnBiZVzxS6LThjl54jgh648qHl+hevCJg8Ewqd4DpyHrvqlwOcOc6jpc
         gv049v7HMphnUxop5vghx4qqitNIkD+3WjXRsGAid10YND+K0Ipf8IK8MV/8DuJYUEb9
         vQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726308126; x=1726912926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zmwLZDktvjILrPQJbKMJaQkPt6Y8bnfMAolJBb47Gg=;
        b=nqX8UohwTKGiu7X83iFLzP/fd2tY9hnVwuoP4Y8rCgaE50AIR/g8djo0ig3YLyTuvQ
         mPyTTzDk4ZmNF7QUvhftHlTUtlOlcOOR5GmaZOPzppw72WAipfQWit234eApvgSCLVq9
         EUbQUb5hs1izWRahvC8lTcZBJVuv5QcnoPoCJN3eNs7L/ZMAB/hiihUQkBmfm54CKQdf
         +NTY9JpFgsfqrjS3vwt0Tf8ADPVq21aQh37V3i/Bwxf0cp+FLEQXzT7cJDUWVfbcS/5+
         xSu17c0kfoMHuWdI3WScXmNQ4DpBlbxLDW2Zq94dM6e4sSyaYDg7pFJRS6l38VdpXDNr
         HmsQ==
X-Gm-Message-State: AOJu0Yxc+sy9cklUn7MmWBpvZKuitoGAlsicmRuV14PlySryC0EH3C3u
	SrvJk7gX5gi3VMXSGpIwZySxFln0qT9K8aj8DS9xToLYrvbFwU4r40/LccI1seYfMQ==
X-Google-Smtp-Source: AGHT+IFYppUDLuVu/TE3driSmTQodwGxdURw29E4EibV/yHcKj8N/DPTz1uwppiHdKbgdecrxXY9Rw==
X-Received: by 2002:a17:902:d481:b0:1f7:1b08:dda9 with SMTP id d9443c01a7336-20781b46d72mr85058665ad.8.1726308125483;
        Sat, 14 Sep 2024 03:02:05 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945dc51esm7267155ad.52.2024.09.14.03.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 03:02:04 -0700 (PDT)
Date: Sat, 14 Sep 2024 10:01:57 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Stanislas Faye <sfaye@redhat.com>
Subject: Re: [Discuss] ARP monitor for OVS bridge over bonding
Message-ID: <ZuVfFfCYK0NLPSFH@fedora>
References: <ZuAcpIqvJYmCTFFK@fedora>
 <385751.1726158973@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385751.1726158973@famine>

On Thu, Sep 12, 2024 at 09:36:13AM -0700, Jay Vosburgh wrote:
> >
> >The br-ex is not upper link of bond0. ovs-system, instead, is the master
> >of bond0. This make us unable to make sure the br-ex and bond0 is in the
> >same datapath.
> 
> 	I'm guessing that this is in the context of an openstack
> deployment, as "br-ex" and "br-int" are names commonly chosen for the
> OVS bridges in openstack.

It's on a OCP (OpenShift Container Platform) that build with OVN Kubernetes.
> 
> 	But, yes, OVS bridge configuration is very different from the
> linux bridge, and the ARP monitor was not designed with OVS in mind.
> 
> 	I'll also point out that OVS has its own bonding, although it
> does not implement functionality equivalent to the ARP monitor.
> 
> 	However, OVS does provide an implementation of RFC 5880 BFD
> (Bidirectional Forwarding Detection).  The openstack deployments that
> I'm familiar with typically use the kernel bonding in LACP mode along
> with BFD.  Is there a reason that OVS + BFD is unsuitable for your
> purposes?

LACP need switch config. While arp monitor doesn't need any switch config.

> 	A single "arp_src_iface" parameter won't scale if there are
> multiple ARP targets, as each target might need a different
> "arp_src_iface."
> 
> 	Also, the original purpose of bond_verify_device_path() is to
> return VLAN tags in the device stack so that the ARP will be properly
> tagged.

Ah, yes, makes sense.

> 
> 	I think what you're really asking for is a "I know what I'm
> doing" option to bypass the checks in bond_arp_send_all().  That would
> also skip the VLAN tag search, so it's not necessarily a perfect
> solution.

Yes.
 
> 	Before considering such a change, I'd like to know why OVS + BFD
> over a kernel bond attached to the OVS bridge is unsuitable for your use
> case, as that's a common configuration I've seen with OVS.

As upper comment, this need switch config.

Thanks
Hangbin

