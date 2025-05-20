Return-Path: <netdev+bounces-192086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22E3ABE837
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B65E7A847E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4A25EF8E;
	Tue, 20 May 2025 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m53W7X9I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3225D219;
	Tue, 20 May 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784700; cv=none; b=bbAVsHrKNlZzsNYSR8dW7wnfpy2FBpgXbc5RlyurkdOdMvJz0uKNFcSsTmIuvgvPV9mrjLV3k3M1lPwAu3az7/iX4lw8vBhww2gefuN2v9Jni28rlYNI4ckeMpvGhK9aPSENtuSpRhATTIFqxjovLtRI21EV85bnsRT9xkBees8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784700; c=relaxed/simple;
	bh=3vPKhs0TtYyPhR7ipFa9HKDsAjtlvju/YP2vL+ghe2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4y+uxNYmcHVroBv9SAwauTHjIzW5kk1jyBSGBsJe4/jknPC6Mrtu9Y6Rq0C0ckpyfBY9Nph6AevNCi4QZQuIVPkH2kaGByx3C5zoqT8HlvWeW6LIiek5oAgSmUu/y3vko3l3V6/J1UxXqQprjvYCmDxTctTmhvkoegJ9sY+Xv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m53W7X9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79BAC4CEE9;
	Tue, 20 May 2025 23:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747784700;
	bh=3vPKhs0TtYyPhR7ipFa9HKDsAjtlvju/YP2vL+ghe2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m53W7X9IzgWx1gKPPXBroP7ZqbY6e+USrHBRv12W8Y2tm8ggBGlTIrEsl8PsQXs1B
	 E6kBbPQzPuGAvCVLAmJ8Qpt87rpCTjXgslb+LGfbHY6OX4Hb0ARqhEOH+UH+Jn+s2j
	 vj98NHgGanEuDobCe1sVOehVZsR8MDctHFeWMafJ8Bjf56c0cMCTsZscRQOd5/jmZ9
	 hwvub+SyqRPMcR8nQAQisw+NFry7e8S8L+uD1tXlvStj/Zc/glHJ9YAtSui5/9kWnh
	 YhpVlUbbbaPOJwBC7LepVeedMKxAgbKxOydHX66QlByaBdXbBzdCa2LGzFa+QB8lLz
	 KnL49T0VT65TQ==
Date: Tue, 20 May 2025 16:44:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Faicker Mo <faicker.mo@zenlayer.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "ovs-dev@openvswitch.org"
 <ovs-dev@openvswitch.org>, "aconole@redhat.com" <aconole@redhat.com>,
 "echaudro@redhat.com" <echaudro@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dev@openvswitch.org" <dev@openvswitch.org>
Subject: Re: [PATCH] net: openvswitch: Fix the dead loop of MPLS parse
Message-ID: <20250520164458.392d5ac3@kernel.org>
In-Reply-To: <c7d27849-f48b-4c85-bcd9-5d2206856abd@ovn.org>
References: <20250520032654.2453312-1-heapbin2@gmail.com>
	<SJ0PR20MB60791551365A54151B195E44FA9FA@SJ0PR20MB6079.namprd20.prod.outlook.com>
	<c7d27849-f48b-4c85-bcd9-5d2206856abd@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 15:37:53 +0200 Ilya Maximets wrote:
> Is kernel.org blocking the sender somehow?  Does anyone know?

The patch was submitted with an HTML attachment :(
Same with the v2 BTW. vger drops all emails with HTML parts.

