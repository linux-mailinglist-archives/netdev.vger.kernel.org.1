Return-Path: <netdev+bounces-108875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6243D926200
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950D31C212F8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6E177981;
	Wed,  3 Jul 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QenHP1QS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE6173359
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014229; cv=none; b=goN6TmRycK3LcDsp2Yttkd416tIZzuuNez6jNhd2MHX81nwsG1934Zi432tuK1wbW9wqmjQ1lEshSvcPVAbr4axCqIg5RcUdE+QXGCIIMa6RhzH+gtN6fVCukSBfAg+V1ri7jDRkbSB4471FvKxwPsbNnV+mq3+LLVwkGsYWk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014229; c=relaxed/simple;
	bh=mkLGQHONAy5U2T2HsxXYbNGhPADLc7up1F+vQTj7d58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7UhwyYS3a+l2apwvEmwZd/OAa7H9VJEhwd8JxxPeoOBj8JDz4zS/80I/l6uY5QCN/UnUeNZlPMfP8Eby79Gkutq+/6GISZ+2o2ziAbykvjUs9MewVm0k/tuXizfQwTWP1Bj+Huy11lKjX2HdQcFMiAgIItHevDWZx+dsMTawek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QenHP1QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8502C2BD10;
	Wed,  3 Jul 2024 13:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014229;
	bh=mkLGQHONAy5U2T2HsxXYbNGhPADLc7up1F+vQTj7d58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QenHP1QSnzQbUX+c/h9E+mo24I6VpXIf+xSw/6oIjcu3yMb9KKkaUif47ljYjg5k2
	 86tzL8z43r/EjqkoJrckJ8YCXDme69+9jdKr0+Q06G86wGGN0vaWLk1LYE1H9aw0B5
	 oVmmFgsyvSmrzr+Thjj4L2Aoa/bpoYF45JvzjCmheBBJYRRaB+9bCHyAPGVmTcK2HK
	 J2dYcd7csbnIV0BD9646ivCk2e3q53oNzA/TSaaHPq1pkYxJB1lA5+jTWFZF92E4WS
	 vrgLSd3Zlg4cTyVmKxYe2fzm8747Mc8dz8loDeTfj5a/etCKHVsOcJcfbyqfqXzHUY
	 +fX1Cx+nh2kfQ==
Date: Wed, 3 Jul 2024 06:43:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com
Subject: Re: [PATCH net-next 01/11] net: ethtool: let drivers remove lost
 RSS contexts
Message-ID: <20240703064347.1929a75b@kernel.org>
In-Reply-To: <c22f9b2b-cbcd-d77a-2a9a-cf62c2af8882@gmail.com>
References: <20240702234757.4188344-1-kuba@kernel.org>
	<20240702234757.4188344-2-kuba@kernel.org>
	<c22f9b2b-cbcd-d77a-2a9a-cf62c2af8882@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 12:08:36 +0100 Edward Cree wrote:
> On 03/07/2024 00:47, Jakub Kicinski wrote:
> > RSS contexts may get lost from a device, in various extreme circumstances.
> > Specifically if the firmware leaks resources and resets, or crashes and
> > either recovers in partially working state or the crash causes a
> > different FW version to run - creating the context again may fail.  
> 
> So, I deliberately *didn't* do this, on the grounds that if the user
>  fixed things by updating FW and resetting again, their contexts could
>  get restored.  I suppose big users like Meta will have orchestration
>  doing all that work anyway so it doesn't matter.

"We" don't reset FW while workload is running. I'm speculating why bnxt
may lose the contexts. From my perspective if contexts get lost the
machine should get taken out of production and at least power cycled.

> > Drivers should do their absolute best to prevent this from happening.
> > When it does, however, telling user that a context exists, when it can't
> > possibly be used any more is counter productive. Add a helper for
> > drivers to discard contexts. Print an error, in the future netlink
> > notification will also be sent.  
>
> Possibility of a netlink notification makes the idea of a broken flag
>  a bit more workable imho.  But it's up to you which way to go.

Oh, have we talked about this? Now that you mention the broken flag 
I recall talking about devlink health reporter.. a while back.

I don't have a preference on how we deal with the lost contexts.
The more obvious we make it to orchestration that the machine is broken
the better. Can you point me to the discussion / describe the broken
flag?

