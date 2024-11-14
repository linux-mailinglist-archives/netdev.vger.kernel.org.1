Return-Path: <netdev+bounces-145027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AB29C9272
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64381B2486C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E51991CB;
	Thu, 14 Nov 2024 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0XtqxBV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0872BD04;
	Thu, 14 Nov 2024 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612706; cv=none; b=NstDbvs+fhUlPQz0GacWz7WY5OG48TXA/3EgrR+3G39KwwO7Qvo7gNz6DBz6q8qLfSUhZEKt1YCLqhI1D6jJHvxiSj6SWD2+/U6eN6/mqGir9Le8EWaqpclXO6pmrvYh80/T/Si5lGyMF/TSfIwLew0xf7HmxqZXk/Rh8GPs704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612706; c=relaxed/simple;
	bh=GYubzGEh2XpxWZvakdhNqfnxzuSFtrRCMCJTDhwFdSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckFLEjmL4lFLrIUeZLGAh7XlsvMiy7PNwt4eHx0vB7CS87Ce6GWGSTrvbYmJgGdwl059T1sznIZHA7tIXhRB17Ok21IrhYJa+/2/XbSrd2U4GEj5HEXwqNnJFxQAaX7i/EGQuPtw2WEpiAOzLW3FbEvkFG6+Yd6o9CHk84UKnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0XtqxBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8B3C4CECD;
	Thu, 14 Nov 2024 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731612705;
	bh=GYubzGEh2XpxWZvakdhNqfnxzuSFtrRCMCJTDhwFdSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T0XtqxBVPqMD8GPMTWzO5zXAjJZbQEHgDQsGpUn1XiphJhf03GnAS+RS31K9iFkON
	 8C2cIxxOqayGoaIlg7BdzcIBQYbsh5DgydmCHt5hx3kPSdrIePEVel5eNfuDFd61qS
	 DM08HpHDUyAM+osjGp7mV2xdEgAuL/Eb8gU2kRdiNsoP44T2vvXPzm85J+f+GX9NvJ
	 FQli+Xwo2yFTGJf2nosXmMoVnYyzx4QF/oUWAeV7+UPn3AWA7ysBhKplhotFZYaI3v
	 obiImEIXGOvl2yVRopfQU0VzR470NM1a4lo1qOK1hI2hV0/r+rppitBybk4qs3BK6r
	 CtjnRJsBcQjSA==
Date: Thu, 14 Nov 2024 11:31:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>, open list
 <linux-kernel@vger.kernel.org>, Mina Almasry <almasrymina@google.com>,
 Simon Horman <horms@kernel.org>
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
Message-ID: <20241114113144.1d1cc139@kernel.org>
In-Reply-To: <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
References: <20241113021755.11125-1-jdamato@fastly.com>
	<20241113184735.28416e41@kernel.org>
	<ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 22:29:50 -0800 Joe Damato wrote:
> - Rebase patch 1 on net (it applies as is) and send it on its own
> - Send patch 2 on its own against net-next

My bad, I thought patch 2 is also needed in net, but not in stable.

