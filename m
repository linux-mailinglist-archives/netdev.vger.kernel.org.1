Return-Path: <netdev+bounces-82312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EE488D354
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 01:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6EE1F3A023
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 00:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612B7FF;
	Wed, 27 Mar 2024 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn+mOBWM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248936E
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711498551; cv=none; b=bTarQGR+nWi0NldzxMNxGTETTCJ/xOZDq9nzmZOV+B9YcuBd0eQTvr8xAMvlQb6ne0IqFwtaONS9lpfcQIBg0OyBiI2315U7dUEUDQiV7M8459/K55K9LJa0UqywudRO7qUKj5+fYg//uVPQ7AijA9i1K+/ZFmz292RnAVNYFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711498551; c=relaxed/simple;
	bh=GYYQpFM7CNoIh+hNfbw7H+E95bYAp5U9KCVz+z9qxao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZFjKgKspPfV8reS6+C+nrVX4QPY1/FzXN1rkUNUJCBCWNAsS8K61CkDiDFu+JrUv7LlTPfx+/2a+9Y5HtIcEqRHwyVyRBeOV3OYvjY80juvfcax0xFhqeC/xz7hD4Qo4a+7m/j7sTpl/tUZIvZXRDJ4U9E1aWRYC8/r+7JC1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn+mOBWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACB7C433F1;
	Wed, 27 Mar 2024 00:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711498550;
	bh=GYYQpFM7CNoIh+hNfbw7H+E95bYAp5U9KCVz+z9qxao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rn+mOBWMtasJgRe1gWUSoyDmPdZvxdIHyA+AFA10/DLYHWTmSJZlM2WmzldiuEj8r
	 +V1dFyL8p0YW1Vd+MloVKgggso7l2xHI6vaYkhJSYez9lu1OQd06J664Rfh3bLnI9S
	 b7tFTfNzQIRRHUYKBkRs8C/8PD5GGO6qrOq424fUXf+PdLel5iLybeC+3z86e+SSo9
	 GnjAtJH+n7nYLk2aoGhLc6cYon7ih7dvgKjG8g1hqpum8iDHKCW4mHncZ5cFEB/2g2
	 Vb/H5CCo8BijlXYx3QMiCBLO/a20+IdhFQlKDmsKMPQRHOp+86OExGQou631WqDnPq
	 XdDVeeQSQXg/A==
Date: Tue, 26 Mar 2024 17:15:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] using guard/__free in networking
Message-ID: <20240326171549.038591c8@kernel.org>
In-Reply-To: <0dc633a36a658b96f9ec98165e7db61a176c79e0.camel@sipsolutions.net>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
	<20240325190957.02d74258@kernel.org>
	<8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
	<20240326073722.637e8504@kernel.org>
	<0dc633a36a658b96f9ec98165e7db61a176c79e0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 16:33:58 +0100 Johannes Berg wrote:
> > > I think you can't get scoped_guard() without guard(), so does that mean
> > > you'd accept the first patch in the series?  
> > 
> > How can we get one without the other.. do you reckon Joe P would let us
> > add a checkpatch check to warn people against pure guard() under net/ ?  
> 
> Maybe? But I think I do want to use guard() ;-)

IIUC Willem and Stan like the construct too, so I'm fine with patches 
1 and 2. But let's not convert the exiting code just yet (leave out 3)?

