Return-Path: <netdev+bounces-144675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EBD9C8169
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF8A2837D0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0B81E9074;
	Thu, 14 Nov 2024 03:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYTYmt0Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C156AAD;
	Thu, 14 Nov 2024 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731554351; cv=none; b=XBXR/5CLF8Q6/YqNvONqXd8kOG8yRpnoUKnerlpPzHqyRr1pc91UbQwbMF/dKyWDWdHUjGtfC/WH5vKY+2Z9xboM1aNfaU1INTvoKm2fMzRbOAhzsj/u1yVWbtMw9zuWG3i6enE+2GrDfBEqXk036iWHbVkdFwYlQxwLMvYkaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731554351; c=relaxed/simple;
	bh=Yq1+6nK+LxMRxpgCo00ZoaEvjLTfqSrkJRDCOrj8YJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hoe7zaOgcmyCGVtmy6UNEjOEcXEBWhpJt2SLScoXHb6tFKFAO9LBLSo4ppEOrx+2aHuPr+fX8YrQBZ7yhd9WKYQmy17qoDbECZPEgZDQa+twIQOjpRpxiCJvZVPRXoy8JlS1WEQjW66f+8jnvT5lUtnbx4xIVd/w+b3MUEl2J78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYTYmt0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37128C4CEC3;
	Thu, 14 Nov 2024 03:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731554350;
	bh=Yq1+6nK+LxMRxpgCo00ZoaEvjLTfqSrkJRDCOrj8YJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MYTYmt0Zeb+GLahunFyo7ba2qGhn6Ao2p7cOMvd3FG6jwMdUrE9Lsmk0syPpvRaSM
	 A6UkDKgAg1u+/zP/+mbanWyOlaTn8ZDaLMcfS8+z97s4nGMsbDxq2DtllrRWTK58Qu
	 ZVA13UA6XjH1ObJdhzfXAbHhvoaP87AEfNyfHsUnbjXr0YD6Sr2XOf5cbTJYxJXEoI
	 9/A3ZFn0lXzV2eOods0xFCEjLVxh9tYo6XpkTWS/si+GwNfV54MIqBUIIvBeiw7HPD
	 qHXLxNVgPW9LVgl2HXUh45wa54m0SwmyvIU+DMOnDb+vke2YdQ2cCSuZuPN4ewRZ1J
	 DGZ3G3Pl5ErQw==
Date: Wed, 13 Nov 2024 19:19:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Jian Zhang <zhangjian.3032@bytedance.com>, netdev@vger.kernel.org,
 openbmc@lists.ozlabs.org, Matt Johnston  <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, open list 
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mctp i2c: notify user space on TX failure
Message-ID: <20241113191909.10cf495e@kernel.org>
In-Reply-To: <da9b94909dcda3f0f7e48865e63d118c3be09a8d.camel@codeconstruct.com.au>
References: <20241108094206.2808293-1-zhangjian.3032@bytedance.com>
	<20241113190920.0ceaddf2@kernel.org>
	<da9b94909dcda3f0f7e48865e63d118c3be09a8d.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 11:13:33 +0800 Jeremy Kerr wrote:
> > notifying socket in the xmit handler of a netdev is a bit strange,
> > could you do it somewhere higher in the MCTP stack?  
> 
> Sounds like that would be useful in general for MCTP, but we don't have
> a facility for that at present.  Any existing implementation you would
> suggest modelling this on?

routing isn't really my forte, TBH, what eats the error so that it
doesn't come out of mctp_local_output() ? Do you use qdiscs on top
of the MCTP devices?

