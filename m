Return-Path: <netdev+bounces-79718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA8E87AE83
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0DF2842E5
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBC85FDD3;
	Wed, 13 Mar 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q0e3buYU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999F5FBB2
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348942; cv=none; b=BrUziAy7MFJK0POkm+h9nZTONbXZAYfOT+lZZuUnflgj+JDH9E3YP1p0AYvp0Fp+HWWpcWL48vjzlKR4GNLDubLDlbYmPGp3hc6It5Fp7y7pL4OZe7OTlSFSqgsGsMO5Hd4FlGdLGLHNqnxtpofhPDHvapp/KBceRlrreAVIBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348942; c=relaxed/simple;
	bh=MlWXiaRMWigx1MdFQNkKgANtku/XGiGDtN6A7imVEF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJj1yWfAlldx+yZw5YjVVhW/Jb7mHXkVN6ouvOOS3wCsS4PkmWO7zGMme/UlXDr/L1v2TZV6PhHid6GD3krrAw4Xt5pBuvqBJdFgkoBIqCeu1RF6pC/IJCZotYs8embeZHSfKuzMpNtcyZ1Nvi0kGe+p5t0YDu5IXra8vhKzEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q0e3buYU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6NWazJLCyNkiSvY/Q9EXUVp2PC5hpBofZX6GmWmSYrI=; b=Q0e3buYU+wZFFfJR5S+D3n1HFy
	4VsYeUVe0nWmcAudSw6oP2vkK36wkX0B3GLoIsMCxuDvRe3gEcnAsprYV83A6W/xwrTynTQbDR+md
	UP3juUfzSBPd4UI+6sSnob3TxH0Etke/lcnxLn/ZqTF7L6L33cFrKCWgx9hmfgGIn9mY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rkRto-00AFap-0r; Wed, 13 Mar 2024 17:56:16 +0100
Date: Wed, 13 Mar 2024 17:56:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev <netdev@vger.kernel.org>
Subject: Re: VLAN aware bridge multicast and quierer problems
Message-ID: <0f752b89-bc4b-40cf-bd4d-ac4e7d3fab2d@lunn.ch>
References: <123ce9de-7ca1-4380-891b-cdbab4c4a10b@lunn.ch>
 <5f483469-fba4-4f43-a51a-66c267126709@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f483469-fba4-4f43-a51a-66c267126709@blackwall.org>

> Hi Andrew,
> Please check again, br_multicast_rcv() which is called before
> br_multicast_querier_exists() should set brmctx and pmctx to
> the proper vlan contexts. If vlan igmp snooping is enabled then
> the call to br_multicast_querier_exists() is done with the vlan's
> contexts. I'd guess per-vlan igmp snooping is not enabled (it is not
> enabled by default).

So i have the test running, and i see:

# bridge vlan global show
port              vlan-id  
brtest0           1
                    mcast_snooping 1 mcast_querier 0 mcast_igmp_version 2 mcast_
mld_version 1 mcast_last_member_count 2 mcast_last_member_interval 100 mcast_sta
rtup_query_count 2 mcast_startup_query_interval 3125 mcast_membership_interval 2
6000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_respons
e_interval 1000 
                  100
                    mcast_snooping 1 mcast_querier 0 mcast_igmp_version 2 mcast_
mld_version 1 mcast_last_member_count 2 mcast_last_member_interval 100 mcast_sta
rtup_query_count 2 mcast_startup_query_interval 3125 mcast_membership_interval 2
6000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_respons
e_interval 1000 
                  200
                    mcast_snooping 1 mcast_querier 0 mcast_igmp_version 2 mcast_
mld_version 1 mcast_last_member_count 2 mcast_last_member_interval 100 mcast_sta
rtup_query_count 2 mcast_startup_query_interval 3125 mcast_membership_interval 2
6000 mcast_querier_interval 25500 mcast_query_interval 12500 mcast_query_respons
e_interval 1000 


The fact that 'mcast_snooping 1' indicates to me snooping is enabled
by default? The test case does not change any snooping configuration.

I will send you off list the test script.

  Andrew

