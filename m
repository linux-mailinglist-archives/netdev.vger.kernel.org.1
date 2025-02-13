Return-Path: <netdev+bounces-166131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B2A34B69
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B692188F7F2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCBF204F74;
	Thu, 13 Feb 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5tGcbkY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66920371A
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466466; cv=none; b=eXQlBgXYOLFcqLcpUrv98JPMb+3+s3+TVe1XZCTqOzC3lWZNbI7zYP9ACeoDWalWNFD+Z6zfnI783TfBfgDxn1lnCtMRZvpL92+zL/Au/f83Zwr9TEL5o0XNkaU3FfUoEP8upxPhqsTD5zBJxa2kawCh6n+CWpjmYVEf7hY++/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466466; c=relaxed/simple;
	bh=d74L2YCH3HCnhbn3y3zBQu1YVCwqrGXd6/+PS2bir3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLVj6lmqUyxlJfrIA3ZMokcsswG1V2Zo7Qs2FTAiOnQm9+KWAxGoFDuuKJ5AXtBhGn1u8pssv1wmFtG2nUuowtEYiNKEzyRF4bhVIbOgMktptHvB3BoS5JmET2IiYR1aI3QJiWmvehrgwYXt68w6XXOpfaCBkKK0aBm7aDhQMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5tGcbkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F230DC4CEE7;
	Thu, 13 Feb 2025 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739466466;
	bh=d74L2YCH3HCnhbn3y3zBQu1YVCwqrGXd6/+PS2bir3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S5tGcbkYViUhx5yIefgzEbxVv2MA8E1XPgNJaEtvuHJNpdzipCF4CRmQxHVDkiKGP
	 ITvg+C122oSJTZAmi1aPhMUzSJsQjOFjD2NBY0tPIA6HVksRB2yLTgIp/qNMvkHRoZ
	 4kAjrbf6C8GdN3tpiKx/PlSrpia9az7dvn8uF7S+lXgTpJLZonX9zvBUk9o34fNVfB
	 bdDALjkovwJKGMy+kGtyhaXLo5l9BVnR5a9NhA5fh1PFT6v5LF0XCp/ZIihJ5iwIpt
	 7ijqf6e4Wq7XjjwrEU2gRrxwjAvyF7LCFANoy9bKrzwUOPmevdhA9n4lgvY/8yI1EB
	 5h5BtNI8gLNsw==
Date: Thu, 13 Feb 2025 09:07:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemb@google.com, shuah@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next 3/3] selftests: drv-net: add a simple TSO test
Message-ID: <20250213090745.09033f27@kernel.org>
In-Reply-To: <67ae175d7a7fc_24be45294be@willemb.c.googlers.com.notmuch>
References: <20250213003454.1333711-1-kuba@kernel.org>
	<20250213003454.1333711-4-kuba@kernel.org>
	<67ae175d7a7fc_24be45294be@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 11:01:33 -0500 Willem de Bruijn wrote:
> Is the special handling of GSO partial needed?
> 
> This test is not trying to test that feature.

If I leave partial enabled and disable tx-udp_tnl-segmentation 
I still get TSO packets in the driver in the vxlan tests.
Not entirely unreasonable since these are the HW features,
and with partial enabled the HW does not do UDP tunnel-aware
segmentation?

> > +def main() -> None:
> > +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> > +        cfg.ethnl = EthtoolFamily()
> > +        cfg.netnl = NetdevFamily()
> > +
> > +        query_nic_features(cfg)
> > +
> > +        tun_info = (
> > +            # name,         ethtool_feature              tun:(type,    args   4/6 only)
> > +            ("",            "tx-tcp6-segmentation",          None),  
> 
> tx-tcp6-segmentation implies v6 only? The catch-all is tcp-segmentation-offload.

oops, if only I had an ipv4 network to test on :)

