Return-Path: <netdev+bounces-83349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F5989203F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB3F286CF5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DECC12EBD6;
	Fri, 29 Mar 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l52XuM7R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BE12DD97
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724810; cv=none; b=OM//qaSsbpBevsytZ2BkJ65/fgygy9PDNYvgo8MRHTqKGDWmbYxxmK7OtDlZq68NIXvRxgs5jAOYFJXq8hxS1GXO9uPSAItGXxVa7mtvkBdd6EllOcacMPQMsWa/RHbdrCoVQPW6X879Re/KhVvSjQh66sLTo358o1yUBbspi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724810; c=relaxed/simple;
	bh=mNNJDzZ52MTyYjoIJx2mc9EgBJqDrPMZN+gB1mfBuRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4gzwzByFNhnZOsxkFUbUKC6erhM3xfEz2jrhPUUfkvRLRpJmLIsQ49a2Yw8yKgAmcTVmFEBxMWQXgFNdkMExsaJ3/cQXI4tO9ebRNUVd8Kw3NgIhG/fMixkqnQimqmGPaP7rzLQ+m3aoGOHT6nZRM7YsGZG+E89CM3AQ58L7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l52XuM7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B026C433C7;
	Fri, 29 Mar 2024 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711724809;
	bh=mNNJDzZ52MTyYjoIJx2mc9EgBJqDrPMZN+gB1mfBuRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l52XuM7RdArm1wjCOVRMVtLtml2Xl6OJL+XVi5Y0MeIys5HCSRUySfaBRa2ApUI/2
	 OhLCoDnHdZap51f6i/JVw648R7pqvMngYtM3xDWEeJ9icX1Hka3ikfh0hYdBqd2tNx
	 hQx7Jtlgnsi63V/VN7NXZJVFHyBffTVQuL2WM2AlA7qJ8rcu1oNyF9/OjTrMKOU0ET
	 deA89PEUqa0dv+XEj7/MVwLwfwgiTaTvcs7V2X3maC4Rx6dHUwx6WqhLF295ncuEPG
	 FBR+WPFn3xQEniyqKALXetmQTTw8WXvq2GB7RY6ILUsFI5xQntJEvq7hB4iTgqrPX7
	 JQsMWKXlYh3WA==
Date: Fri, 29 Mar 2024 08:06:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <edumazet@google.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp/dccp: bypass empty buckets in
 inet_twsk_purge()
Message-ID: <20240329080648.3cd12eaf@kernel.org>
In-Reply-To: <20240327192934.6843-1-kuniyu@amazon.com>
References: <20240327191206.508114-1-edumazet@google.com>
	<20240327192934.6843-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 12:29:34 -0700 Kuniyuki Iwashima wrote:
> > -	for (slot = 0; slot <= hashinfo->ehash_mask; slot++) {
> > -		struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
> > +	for (slot = 0; slot <= ehash_mask; slot++, head++) {
> > +  
> 
> unnecessary blank link here.

I've seen some other core kernel contributors add empty lines after 
for or if statements, so I think this is intentional. Not sure why
the empty line helps, either, TBH, but we have been letting it slide 
so far.

