Return-Path: <netdev+bounces-168687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CA4A402F4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C233B5C48
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6C5205510;
	Fri, 21 Feb 2025 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUAoHsQL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF21FC105
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177850; cv=none; b=UKXb73/8A3UfP5XcsU9YyRLrr3OrR844sPLh99JSbPdbCsL71b4bgT19FbufWb2iyAIAEHK4XsErrE3UkgOmESH8+REPEPnjVf0tmsyqDwIi4bMsxdV1+LfYeWKB98SX3lKpkT0KMdEBigV3/lyqIdMhmVdAWXm8GuQPj8tHWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177850; c=relaxed/simple;
	bh=9fDS9hRTmB6MLQfKaT1GSxDmefvzeOlX23mRTCYy+NM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxtMZ6XBTaOyniH84kYm1oeQtSuDC0SEZ5vrCSmWsf2KY+3/sqh8HTijCKhcWWly8jYeEtixY+tdsmzeRJbAEMBiLt1UP8BMkMQ7+zcUmOQQdbhv7Z0oO4u1jMgLzTStEmQMgldYsFhZlrulKEo/4M5boh7XoIyy7uSCWzO5TYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUAoHsQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432ECC4CED6;
	Fri, 21 Feb 2025 22:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740177849;
	bh=9fDS9hRTmB6MLQfKaT1GSxDmefvzeOlX23mRTCYy+NM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gUAoHsQLK9I8U6dj+aBA5JtkXxF0qSgt/CA0+1/sTixeas1XV/MKSLCq1Y+mFOfcW
	 Jud/7wtuAskwzH0sV9/UrRPZWJyFhO2H7prNbZpRPXV/r8UrDEjSmnviD0wZ0BC3/d
	 mmR6dWsMPx72ilmGAOnVDRYSgTv3lNY5VnwBC3+A0DjaCpyHYT9N4YEfcyvURKInvl
	 oMKtNUxW+6IBgfMIng8P9dhK4wg5CQAD4gbDD3OK4N3lJx12e+w4EwVuKo19p5CoOU
	 do7Pitwekccrw+CXIdxNaeVEoGQWKZuSZjl8gl34aTmHzN9YBR/XnZb+MJdxV5/4/Z
	 XinzKitQ8nOww==
Date: Fri, 21 Feb 2025 14:44:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Pablo Martin Medrano <pablmart@redhat.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH net] selftests/net: big_tcp: longer netperf session on
 slow machines
Message-ID: <20250221144408.784cc642@kernel.org>
In-Reply-To: <c36c6de0-fc01-4d8c-81e5-cbdf14936106@redhat.com>
References: <bd55c0d5a90b35f7eeee6d132e950ca338ea1d67.1739895412.git.pablmart@redhat.com>
	<20250220165401.6d9bfc8c@kernel.org>
	<c36c6de0-fc01-4d8c-81e5-cbdf14936106@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 10:14:35 +0100 Paolo Abeni wrote:
> >> Davide Caratti found that by default the test duration 1s is too short
> >> in slow systems to reach the correct cwd size necessary for tcp/ip to
> >> generate at least one packet bigger than 65536 (matching the iptables
> >> match on length rule the test evaluates)  
> > 
> > Why not increase the test duration then?  
> 
> I gave this guidance, as with arbitrary slow machines we would need very
> long runtime. Similarly to the packetdril tests, instead of increasing
> the allowed time, simply allow xfail on KSFT_MACHINE_SLOW.

Hm. Wouldn't we ideally specify the flow length in bytes? Instead of
giving all machines 1 sec, ask to transfer ${TDB number of bytes} and
on fast machines it will complete in 1 sec, on slower machines take
longer but have a good chance of still growing the windows?

