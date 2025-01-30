Return-Path: <netdev+bounces-161669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB08A23250
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D02164EBB
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC871EE008;
	Thu, 30 Jan 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/JWaW4G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3D154BF0
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256023; cv=none; b=BKXmCsq3jp6IAPFpTeXtaaWZxer6ZLeJNyEzpF5b9hmZRKqvBM6YZaiTXxgLGibfZcw/GJxsZ1WkLdgfEhZOVZK1LSxqT2LrF7skV8pmo8wGRP+zKfAuk9m6SV0izszDnyqpAB7dZK9iysDUN9s1V962YqNmu2C7aMX7A35pcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256023; c=relaxed/simple;
	bh=Pqyn3bY7MdDWiKsoJ5HjhDrmUwNX+zaV1lXiBUi5cqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eG8nXEL0MLGiWhDSBS0WXdrMGguluExAwjwOmIzarR3UGpOoNeS02UHq669FNKisaShoBWNTTAzi3WgC5SQIen4Xn2fMUncOgqbmNQpSPSt7t7gpTzyxY4CSN7pUnsB0ZyRIVEDxYouHnmfqbBD/enny7oau20UoPL6CzqlD66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/JWaW4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE031C4CED2;
	Thu, 30 Jan 2025 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738256023;
	bh=Pqyn3bY7MdDWiKsoJ5HjhDrmUwNX+zaV1lXiBUi5cqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u/JWaW4GIkzfr70sYSfV25Jiwcr9KdCJYdltqVtr/uUu1mh+AzPzTP+8zm08Rq6b8
	 N0twv9m7NLh4fCm987ScnF20l6KxBMOHgkJ/QVzcBjxMq2SwUs41U9HjC4ikE4PFsf
	 diG8znJSAuBNwLk73O86JmzSJ38XcQKm+PJnYrrXaZiCNkyIUhT6XmYCC9nA2VJ8xg
	 NRtJBeTK7f1OrGSy4A4hfAeUdePxLK8VxLSd2QLixoIaurFdcJuM1WNDrzZXw7qF0X
	 RLnCXBIrYUZb11hmyMagsZlz3TsCjcazgI7EVa3B1iP+tIUuMXbLsUebYJKYkFWG3O
	 /2JY+rVUBJmBw==
Date: Thu, 30 Jan 2025 08:53:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, dsahern@kernel.org
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6
 and ioam6 lwtunnels
Message-ID: <20250130085341.3132a9c0@kernel.org>
In-Reply-To: <59f99151-b1ca-456f-9e87-85dcac5db797@uliege.be>
References: <20250130031519.2716843-1-kuba@kernel.org>
	<20250130031519.2716843-2-kuba@kernel.org>
	<21027e9a-60f1-4d4b-a09d-9d74f6a692e5@redhat.com>
	<cc9dd246-e8f8-4d10-9ca1-c7fed44ecde6@uliege.be>
	<20250130065518.5872bbfa@kernel.org>
	<59f99151-b1ca-456f-9e87-85dcac5db797@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 16:12:23 +0100 Justin Iurman wrote:
> > And perhaps add a selftest at least for the looped cases?  
> 
> ioam6.sh already triggers the looped cases in both inline and encap 
> tests. Not sure about seg6 though, and there is no selftest for rpl.

Right! To be clear I meant just for seg6 and rpl. The ioam6 test 
is clearly paying off, thanks for putting in the work there! :)

