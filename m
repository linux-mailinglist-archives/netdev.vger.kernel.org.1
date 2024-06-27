Return-Path: <netdev+bounces-107379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA7691AB88
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061B31F24B95
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D676199249;
	Thu, 27 Jun 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYRJzKLU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E0199243
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502532; cv=none; b=f+E3i6IbrBRvdiKVcpkjv1+HHrs3MOjj9lNIYwWE7LW5hjvpD2dhm4iQUqg0RqSWVI9QK91Se4c1VokXTB1vAIwazaa0ssmRQE+pvNfRUUfrBpeZ5iBY9TjTx4df4aajfNBv4sNi4u2QB466EHHWW99LORl/J+C/bkVfWu5w4to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502532; c=relaxed/simple;
	bh=tQqmTtoXh0rhnRHGSuR5mSbSCsB4JcmmN29toYcRM6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6ubNX54X4N0iE5cd3aUzDDjq3OCBLlr9MqB3I3j9biQMuXf7dEgZoFWVGCIvuYlWHVzzs/iKIWOqcyuGMOPjquBaTtrP/avnvWp90Pi5HQIUCgZcDyMVzSYkdIbYC4Zh8vJTRaYl/Y7qhvb8NMZNTSd8+9lIuWB6lcB4b9MfrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYRJzKLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C635C2BBFC;
	Thu, 27 Jun 2024 15:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719502530;
	bh=tQqmTtoXh0rhnRHGSuR5mSbSCsB4JcmmN29toYcRM6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FYRJzKLUSn52DtBw7vlv37QkpHE+S2k+RehkiDrGkDg0QmY3KZ54t3LNG4aK6vlqr
	 aUBkXH08VFw0pvrrhvY+kocufZoeumN321E0osBgHLSYrTEqbZVXkfyEzWdT+xjUDh
	 BRWVl3Lp4yOsrQZErEmbH/diMiwamwexfAk2fSDw0HtURQY1laW70EswZ6b2SrDxpw
	 4Fuma6OTLDG2kvEplA2ApvRcRAmB8Og3AMkqxT1QFZL3Dh9m1+pc7IKkXqz7AGs2DM
	 +18qxzh4VGmkJ2MQnIhie8/Qkey+tlMUuEYmnnVJKdIRP14haiC2u6dZPqcTxWe5Cb
	 eyYypX1BdtUUA==
Date: Thu, 27 Jun 2024 08:35:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <willemdebruijn.kernel@gmail.com>, <leitao@debian.org>, <petrm@nvidia.com>,
 <davem@davemloft.net>
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
Message-ID: <20240627083529.3befe119@kernel.org>
In-Reply-To: <49fcfb78-32ac-49de-8e83-2e12bc04fff2@intel.com>
References: <20240626013611.2330979-1-kuba@kernel.org>
	<20240626013611.2330979-2-kuba@kernel.org>
	<d7a8b57d-0dea-4160-8aa3-24e18cf2490e@intel.com>
	<20240626094932.1495471b@kernel.org>
	<49fcfb78-32ac-49de-8e83-2e12bc04fff2@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 10:40:31 +0200 Przemek Kitszel wrote:
> > Hm... not a bad point, defer() cycles are possible.
> > But then again, we don't guard against infinite loops
> > in  tests either, and kselftest runner (the general one,
> > outside our Python) has a timeout, so it will kill the script.  
> 
> I mean the flow:
> $EDITOR mytest.py
> ./mytest.py
> # output: Exception while handling defer / cleanup (at 4 out of 13 cleanups)
> 
> then repeat with the hope that fix to cleanup procedure will move us
> forward, say:
> $EDITOR mytest.py; ./mytest.py
> #output: ... (at 7 of 13 cleanups)
> 
> just name of failed cleanup method is not enough as those could be
> added via loop

Oh, yes, nice one!

