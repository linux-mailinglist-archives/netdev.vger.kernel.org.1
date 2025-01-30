Return-Path: <netdev+bounces-161650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F39A230AF
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC133A603F
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299691E285A;
	Thu, 30 Jan 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip/19GXj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A91DDD1
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248920; cv=none; b=QUadLGipZP/FqAioDXt39dYKdYXncXWO2aGTxKWeQKANY/Mh7t4w/aY8/dY+bzLf6E6smvItf/g4Qjly0NhZgrwzdsN9gybS949KMzMY/W1T9GQW22RS7/FY9ArXOJr8wtHdmQouFrZEJBirc7K9lGesqjV06qfPLIBL6tdnHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248920; c=relaxed/simple;
	bh=igMJpRJbSL4SaoUVu928nxTRzo9wMQT7647vIp/UO4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3aulx31BSt2q7qVdOpbRiPz7CkMtQafxiEqiWWByBDga8lYevGSx0z3KTeZSXXSOYveegGvjk3JTeBSLc7/jWDmuQriWp5EJN0iYaAPbbWbiLWE9seNsUDlXrOgopvoyUa438Nf40iBS8iRDkO18HFOVAU05fM8BPaSnYMfS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip/19GXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231A0C4CED2;
	Thu, 30 Jan 2025 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738248919;
	bh=igMJpRJbSL4SaoUVu928nxTRzo9wMQT7647vIp/UO4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ip/19GXjwlqNq4IdWr7jYYGyWncJhQPs8yrinM3j7A+8MB4FiCYUEpAlIMxalCRON
	 83j93qq3qW3qkKvIE+EGMOyHh70vHC29CE6ib7Y6TZJ+fOG8s5cLAFCmP/WPfTcHBG
	 tWtnBR0w/5c1pTzfhIafvbmVRpexk6qE3iamrIOqZEnQdMdX9Xyw/eXqx3MP2PH7BE
	 NjUyZmgU4dsPxWl9mmU+1D2+CXc+5Tiy0L7HRY9UYIkbtxy4NUJZD3E7dNnt1tilVr
	 1a20vVz244pv+ujVsqj61r0C20wDfObtpyTtag8qhJVIojKgfWoTcdGvfzQNS9yRYu
	 rpICZXVQvU0Cw==
Date: Thu, 30 Jan 2025 06:55:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, dsahern@kernel.org
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6
 and ioam6 lwtunnels
Message-ID: <20250130065518.5872bbfa@kernel.org>
In-Reply-To: <cc9dd246-e8f8-4d10-9ca1-c7fed44ecde6@uliege.be>
References: <20250130031519.2716843-1-kuba@kernel.org>
	<20250130031519.2716843-2-kuba@kernel.org>
	<21027e9a-60f1-4d4b-a09d-9d74f6a692e5@redhat.com>
	<cc9dd246-e8f8-4d10-9ca1-c7fed44ecde6@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 14:52:14 +0100 Justin Iurman wrote:
> > On 1/30/25 4:15 AM, Jakub Kicinski wrote:  
> >> Some lwtunnels have a dst cache for post-transformation dst.
> >> If the packet destination did not change we may end up recording
> >> a reference to the lwtunnel in its own cache, and the lwtunnel
> >> state will never be freed.  
> > 
> > The series LGTM, but I'm wondering if we can't have a similar loop for
> > input lwt?  
> 
> Hmmm, I think Paolo is right. At least, I don't see a reason why it 
> wouldn't be correct. We should also take care of input lwt for both 
> seg6_iptunnel and rpl_iptunnel (ioam6_iptunnel does not implement input).

Would you be able to take care of that? And perhaps add a selftest at
least for the looped cases?

