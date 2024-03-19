Return-Path: <netdev+bounces-80635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01288013C
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71DC285642
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB39657BE;
	Tue, 19 Mar 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if2Ch+0c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0DF651BE
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863747; cv=none; b=iEnJ2lAGLnz1Vo/lF5+ag10MTIk+ZASGXaKjLQw/WHc6L6TlASD4p5H3IHo9uD2ztWRk/y9p1dPGuL4HRg7ZUzvXur6y7iiUMZlusoCkw6FRora4AXcj4DgfIzJNVhw85c/VwebZfq5BCjdcQw7VDRIfwvJSVipF5Q2K0fpm8Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863747; c=relaxed/simple;
	bh=uMB3lhmyFKcRGLM8S4JY1edMakQmNeLEU/M7AoWa24A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJkU/IvyIhKLPmnxHaZZaOPK6jQcRZW9YLr42L5LMv6ty9dizE7ffi0Zy65DUHBIs8Y1vvwlAHIpWkV+10F9eagRP9yGkMMVLN8Y1RfzNDyGcuTuF3jpfeL2eAuB1Vma2bIt4mvtb/vRMJki6FBFJHKeiSzZXs71SbVzko/2xZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if2Ch+0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF419C433C7;
	Tue, 19 Mar 2024 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710863747;
	bh=uMB3lhmyFKcRGLM8S4JY1edMakQmNeLEU/M7AoWa24A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=if2Ch+0cjJwj+b8ebjxNbRXLzcs4YWHOZFwgdcobsqVB7RY5Ce3yVOV2E2wFrzcCq
	 MuTqtRbqRxwdUwnC3fT4Ui4w91wn7wptex+YAbzfDJOXyMZhnDTLVONN+OR6aY9dvw
	 fAHlMQr7cs63AuHZh/+Ok8/nmkTHa+SdrEG7iPjFE+jJGiLINTeI1jl3xaZG345mTt
	 poFIaZ/sdSrBiPX7r/Wf8SnGWDnUHzuslZORcMJbRK1B9iFG7FwM0QBzwOOrLsJkTd
	 t4BFT+MT2XxKU2mmKdmMIMX/LncWjgAfxOwTyj+xoxrIramE7dbsEVGzNWMtvMd+3a
	 BJVlJxKg5bJvQ==
Date: Tue, 19 Mar 2024 08:55:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, idosch@idosch.org,
 johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org, Martin Pitt
 <mpitt@redhat.com>, Paul Holzinger <pholzing@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <20240319085545.76445a1e@kernel.org>
In-Reply-To: <20240315124808.033ff58d@elisabeth>
References: <20240303052408.310064-1-kuba@kernel.org>
	<20240303052408.310064-4-kuba@kernel.org>
	<20240315124808.033ff58d@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Mar 2024 12:48:08 +0100 Stefano Brivio wrote:
> > Make sure ctrl_fill_info() returns sensible error codes and
> > propagate them out to netlink core. Let netlink core decide
> > when to return skb->len and when to treat the exit as an
> > error. Netlink core does better job at it, if we always
> > return skb->len the core doesn't know when we're done
> > dumping and NLMSG_DONE ends up in a separate read().  
> 
> While this change is obviously correct, it breaks... well, broken
> applications that _wrongly_ rely on the fact that NLMSG_DONE is
> delivered in a separate datagram.
> 
> This was the (embarrassing) case for passt(1), which I just fixed:
>   https://archives.passt.top/passt-dev/20240315112432.382212-1-sbrivio@redhat.com/
> 
> but the "separate" NLMSG_DONE is such an established behaviour,
> I think, that this might raise a more general concern.
> 
> From my perspective, I'm just happy that this change revealed the
> issue, but I wanted to report this anyway in case somebody has
> similar possible breakages in mind.

Hi Stefano! I was worried this may happen :( I think we should revert
offending commits, but I'd like to take it on case by case basis. 
I'd imagine majority of netlink is only exercised by iproute2 and
libmnl-based tools. Does passt hang specifically on genetlink family
dump? Your commit also mentions RTM_GETROUTE. This is not the only
commit which removed DONE:

$ git log --since='1 month ago' --grep=NLMSG_DONE --no-merges  --oneline 

9cc4cc329d30 ipv6: use xa_array iterator to implement inet6_dump_addr()
87d381973e49 genetlink: fit NLMSG_DONE into same read() as families
4ce5dc9316de inet: switch inet_dump_fib() to RCU protection
6647b338fc5c netlink: fix netlink_diag_dump() return value

