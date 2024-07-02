Return-Path: <netdev+bounces-108318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E2091ED2C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 04:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06C1284BAE
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913C15E85;
	Tue,  2 Jul 2024 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkl12aoT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C51758E
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889150; cv=none; b=Z2pOOYrIR7mUiCs1HSVjxs4phWImjGPSiO8/sIsmNnBiq5RgVPd1G1bqsGbsChttwTrQ0xssNepT9hxfFl7A2GmQ8GoLRyPqB8uMypk3+ks3cnW8vTxenPe9lPpjxL4e/H2aHgl2i8Og5EKUy1GBiT/rfYMxfDWDApOg6p+sCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889150; c=relaxed/simple;
	bh=xkEpVEyG7+xnFPfanpY7P3oVu6LWXfqm4So7WWZLy9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYSS//Q46/whVIbzvO/4JyoxwZiNnKaDI8aqMnG/qWpxpuoe9w4foNoAQhJEeVeXhlxFaDVELlWPr7vASgc/DodXL0TmVdDBH+JVbYoD1Mxm1uPy1tbq2IN9j6g5Hqmxsg9loGf9PelLvM65IMv2XixnQd/6OF9q4bP0zMgjdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkl12aoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DFFC116B1;
	Tue,  2 Jul 2024 02:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719889150;
	bh=xkEpVEyG7+xnFPfanpY7P3oVu6LWXfqm4So7WWZLy9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qkl12aoT0fBm5SEVB7xASFaukVHngmT6F7XngGLJZxx0j3Nd6H4Rof0etKxH1xEZ7
	 z3Jq43hXyqrbz0ZtccZzZgmZcbaq5jkcv/GT/6qxHAAol/ReNUQrZKI5wmJKLLEJAq
	 okn8iSwpBMPD36tLqogZa3a4PSBSrLVTPByQQG7AkIdORGPgIDz/vZ1mOnGv4l1B2P
	 mUwnCJ26KRUdo/JKFGE4K/UVMlEsi/R+jOgNqHv3bpwU7S3KQThMTzkgtbGnAEUvDr
	 oP2pg8rpAYL1EwBtER7rm/5GRMfvzKRNrNhaNDSaMomP0dJUje7KouvXc7Aeri5k0g
	 A4TUcTlMNmFiw==
Date: Mon, 1 Jul 2024 19:59:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: 'Simon Horman' <horms@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andy Gospodarek <andy@greyhouse.net>, Ding Tianhong
 <dingtianhong@huawei.com>, Hangbin Liu <liuhangbin@gmail.com>, Sam Sun
 <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v5] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <20240701195908.06f8edc3@kernel.org>
In-Reply-To: <1623861.1719875266@famine>
References: <20240630-bond-oob-v5-1-7d7996e0a077@kernel.org>
	<20240701143247.07bc17c9@kernel.org>
	<1623861.1719875266@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Jul 2024 16:07:46 -0700 Jay Vosburgh wrote:
> >	if (strlen(newval->string) < 1 ||  
> 
> 	I find the second option clearer, FWIW.  This isn't in a hot
> path, and including strlen() in there makes it more obvious to my
> reading what the intent is.  The size_t return from strlen() is
> unsigned, so we really want to test the return value for zero-ness.

True, I picked < 1 because the line below offsets by 1.
Either way is fine, but lets make sure we drop the parenthesis.

