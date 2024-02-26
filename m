Return-Path: <netdev+bounces-74965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36DB8679ED
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D9CB37297
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395101369BF;
	Mon, 26 Feb 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myKa9VzH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F712FF6E
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959835; cv=none; b=S1RRxEdlYlrZ8BTdETzyeiaWG2nxABKPtqGUxwyugYzKKtKgu98o2U3R/42EgpX7VVyd7T/ewWwVgnELJjBiYdLlxGwuhuxgY30WlSdtVDWeBV3g2ODb7pW6vHVIYN4S405VQAv10zs8eq4fjTQpCayUl7lM6KHo4j6u0nRx1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959835; c=relaxed/simple;
	bh=P6VsjUGB5ACOEvqS0KSOOr84JP3x6/V4M1pqd0TvUqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHzDZxk3FUZIpFiw4uXWB4ZXQ8GGDzIZ+Qk+u45mbTtZxRedszXGGVJqd2OV8XleRgG3Kn5AuaVoP0hDQGaIal8aq+1a8g3AJuoxTPqVMaHQpccA5FGfSbdDoLJKg8DVG7n8dBwaR72szwdwek7XaxOERRDT1GRsqYA9P2NeFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myKa9VzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052DBC433C7;
	Mon, 26 Feb 2024 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708959834;
	bh=P6VsjUGB5ACOEvqS0KSOOr84JP3x6/V4M1pqd0TvUqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=myKa9VzHc/z5G0lzuXTJT2IoHVhDc6gLcoda9k+MgoejrBMM+iRqRiyB4LCADOfke
	 f3XKQAMqb6Bf5ghNBZpvyCFZ8A3GcoBGnHBKJY5usZm4ymfHD/cNmOAR8ttLXdYtnO
	 lIHrIsZerKjfIj+YDYk8sQQJH9WPKL6hqaro+NdUBWEw18ASkZUsIUBxswENFFILsh
	 TX8nBn4m9kWsTbpzLS+Qm+fqrT2scS4UnwjeaxA6DjrH3QgABW7TicQvR72RdxKh2Z
	 QNnBkldG9ZY15ETiP1bOJQV/LZfr+9qsvK/t7fntcQoGZ9Y+wxUktbVTLSNA8PgEeX
	 /fmaHkgbX91FQ==
Date: Mon, 26 Feb 2024 07:03:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 <stephen@networkplumber.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <xiyou.wangcong@gmail.com>,
 <netdev@vger.kernel.org>, "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 <amritha.nambiar@intel.com>, Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [RFC]: raw packet filtering via tc-flower
Message-ID: <20240226070353.79154709@kernel.org>
In-Reply-To: <40539b7b-9bff-4fca-9004-16bf68aca11f@intel.com>
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
	<20240222184045.478a8986@kernel.org>
	<ZdhqhKbly60La_4h@nanopsycho>
	<b4ed432e-6e76-8f1b-c5ea-8f19ba610ef3@gmail.com>
	<ZdiOHpbYB3Ebwub5@nanopsycho>
	<375ff6ca-4155-bfd9-24f2-bd6a2171f6bf@gmail.com>
	<CAM0EoMkdsFTuJ-mfqBUKZbvpAzex8ws9jcrPEzTO1iUnaWOPZQ@mail.gmail.com>
	<3c5c69f8-b7c1-6de7-e22a-5bb267f5562d@gmail.com>
	<40539b7b-9bff-4fca-9004-16bf68aca11f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 07:40:55 -0700 Ahmed Zaki wrote:
> Intel's DDP (NVM) comes with default parser tables that contain all the 
> supported protocol definitions. In order to use RSS or flow director on 
> any of these protocol/field that is not defined in ethtool/tc, we 
> usually need to submit patches for kernel, PF and even virtchannel and 
> vf drivers if we want support on the VF.
> 
> While Intel's hardware supports programming the parser IP stage (and 
> that would allow mixed protocol field + binary matching/arbitrary 
> offset), for now we want to support something like DPDK's raw filtering:
> 
> https://doc.dpdk.org/dts/test_plans/iavf_fdir_protocol_agnostic_flow_test_plan.html#test-case-1-vf-fdir-mac-ipv4-udp
> 
> 
> What we had in mind is offloading based on exclusive binary matching, 
> not mixed protocol field + binary matching. Also, as in my original 
> example, may be restrict the protocol to 802_3, so all parsing starts at 
> MAC hdr which would make the offset calculations much easier.
> 
> Please advice what is the best way forward, flower vs u32, new filter, 
> ..etc.

I vote for u32. We can always add a new filter. But if one already
exists which fully covers the functionality we shouldn't add a new
one until we know the exact pain points, IOW have tried the existing.

If we do add a new filter, I think this should be part of the P4
classifier. With the parsing tree instantiated from the device side
and filters added by the user..

