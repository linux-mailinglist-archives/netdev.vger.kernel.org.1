Return-Path: <netdev+bounces-72415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E22857F9E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403F0B20ADB
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9F12EBD3;
	Fri, 16 Feb 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVu7rEjr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49F1E481
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094655; cv=none; b=G44lhqCnECnm2Bqvl8yZPmXlKP08pmuVkAaJmneC7B5oiZK1MDSacEOMR9YTEdaylENkp+c+N9jXW/xdY9y0CQU/gD3T1dFyoYMKTe01UhNJznD7shyJRG5ayck3hFRRb8HagMNnKJicMP7fBZcwkr5aWmSyFuj4oDu5tgNPezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094655; c=relaxed/simple;
	bh=o9X+F0n1cCwsdDOPXw80W3PjIR0uWuRva29fYWu6sos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqYC5ybZPnEIPoqrDVvqJA/aUs1BiT8CKpzw34Re6rjmNwHzxq75u/HMrGTactQTMPA/PgzanYIOBeIUvvQVb/vVLA6VpUMew89B464gG7pwOFceUWTO/ykAaP0BoSmDKq0886JVUugHvQLEGmU4C3ZplKIemClZzqz5emsQdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVu7rEjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1E3C433C7;
	Fri, 16 Feb 2024 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708094654;
	bh=o9X+F0n1cCwsdDOPXw80W3PjIR0uWuRva29fYWu6sos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NVu7rEjrxw+si0A/uf3/C8Sdho59sOFQ7BWRZoWgFfN1nWwEP2+m9c/G9+cKLRFXe
	 q+eWLUZCzgCg8zAvU0MuVramspdim/Qbne6tFsBAIG5xVzjYpfg7nNXwcjb71YXbuA
	 lxKTEZULFAGMF59xigF00rsboMlIuaGF5ECN1yyDbdidpgfR5IyP/Jzg6l2hTSBz8/
	 PmqBMCruSMVuXIB9MyBUFbDzk5QXgfmngIi9BvKn0nQ9mC4/SqxcoCuk7RC7Sc74xt
	 ceo+/O8xUaPzPoq15Kz0tWQKp7r+U7A6lc2ALr1cD31gBnuqb3T4F7NWP4bJw94P4y
	 cJwUZfnrlKMwQ==
Date: Fri, 16 Feb 2024 06:44:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Wei <dw@davidwei.uk>, Jiri Pirko  <jiri@resnulli.us>, Sabrina
 Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v11 0/3] netdevsim: link and forward skbs
 between ports
Message-ID: <20240216064413.7315e041@kernel.org>
In-Reply-To: <ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
References: <20240215194325.1364466-1-dw@davidwei.uk>
	<ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 11:38:17 +0100 Paolo Abeni wrote:
> On Thu, 2024-02-15 at 11:43 -0800, David Wei wrote:
> > This patchset adds the ability to link two netdevsim ports together and
> > forward skbs between them, similar to veth. The goal is to use netdevsim
> > for testing features e.g. zero copy Rx using io_uring.
> > 
> > This feature was tested locally on QEMU, and a selftest is included.  
> 
> this apparently causes rtnetlink.sh self-tests failures:
> 
> https://netdev.bots.linux.dev/flakes.html?tn-needle=rtnetlink-sh
> 
> example failure:
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/467721/18-rtnetlink-sh/stdout
> 
> the ipsec_offload test (using netdevsim) fails.
> 
> @Jakub: it looks like the rtnetlink.sh test is currently ignored by
> patchwork, skimming over the recent failures they are roughly
> correlated to this series submission: the test looks otherwise
> reasonably stable to me.

Wow, great detective work! This is what the diff says:

#     1c1
# < SA count=2 tx=0
# ---
# > SA count=2 tx=3

I'm guessing that because we clear IFF_NOARP and ipsec code doesn't
connect any peer it can't transmit? Any suggestions how to fix it?
Insert a neigh entry manually?

