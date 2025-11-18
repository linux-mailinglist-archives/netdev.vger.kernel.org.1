Return-Path: <netdev+bounces-239701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDD2C6B8B4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6BD642ADC4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6E7285CB2;
	Tue, 18 Nov 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn5QCHpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F212777EA
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763496956; cv=none; b=ALWDKHOqtBVfwbIb57yUCtPte0rFREGDdkVwNPTCSL2QmSbK5YBk8Rg6J5sDBM4bdK0EUgY1fOMNTGvFXbm0LbDQOnMnbgXMKcKksX247rc3r9mgDisy7nLIUPJVpRBkji4C6MjfNPChiC0XSq9s7yXKIgFsXnGwskPsLk6iK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763496956; c=relaxed/simple;
	bh=rqTfpaAWAox76v/5KDYEku0Uxdj559VNTVIUoRkYILw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FN85JHNuimhhobBojbkVrv7iYcJAxHiyHl4ho5J1QjSjIiP6gxR5BY2taJ4fv7VvGbqXYWza1Gsc87mYbZWfyvwXqUJfDRwfEvgR4oFY5GL+eQH24SYUUUZ8ufwr/Fx555caNT4Az7HBJa6CBHOwZCGufiDTpoOr32/Fp0iiUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn5QCHpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFC3C19423;
	Tue, 18 Nov 2025 20:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763496955;
	bh=rqTfpaAWAox76v/5KDYEku0Uxdj559VNTVIUoRkYILw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cn5QCHpN7Vu/qAsStCYsxyIvB1QLkKXBxCUgaJiTru5etwHSB+SXFRKkP1kK4D4du
	 /cLNFEsi0qpBy9+ETmi4A8R2kiDL+6xk2GmRuBqAjdbe1sRwD0IUhnfg/8CVaewmrZ
	 zBSVNe+IRryk7o/7Bq9oQ9uEI8p8tq9JXIpwtGcLfoL/eKdwjKkzZX8sT0m+Upb74V
	 CWa1HTuH6phbwwcD51t/1gnCCbU7cpULcAdRFBgKyHq9dHtEBSvyPxNpQmmn2gLSH8
	 6hnlhNlON9hE3lHYBdJgzaIK8YbjetKyyMf9HIo2V+clYz1COvjFFaTu2R4PcaUa0r
	 WCEO198PoVVGQ==
Date: Tue, 18 Nov 2025 12:15:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next] devlink: Notify eswitch mode changes to
 devlink monitor
Message-ID: <20251118121552.7e1bae0c@kernel.org>
In-Reply-To: <CY8PR12MB719576A592BCF41591F83C23DCD6A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20251115025125.13485-1-parav@nvidia.com>
	<20251117194101.3b86a936@kernel.org>
	<CY8PR12MB719576A592BCF41591F83C23DCD6A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 05:25:23 +0000 Parav Pandit wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: 18 November 2025 09:11 AM
> > 
> > On Sat, 15 Nov 2025 04:51:25 +0200 Parav Pandit wrote:  
> > > +	err = devlink_nl_eswitch_fill(msg, devlink,  
> > DEVLINK_CMD_ESWITCH_SET,
> > 
> > I've never seen action command ID being used for a notification.
> > Either use an existing type which has the same message format, or if no
> > message which naturally fits exists allocate a new ID.  
> 
> I am not sure fully.
> 1. devlink_notify() uses DEVLINK_CMD_NEW.
> 
> 2. devlink_port_notify() uses DEVLINK_CMD_PORT_NEW which is the input
> cmd on port creation supplied by the user space.
> 
> 3. devlink_params_notify_register() uses DEVLINK_CMD_PARAM_NEW.
> 
> Do you mean #1 and #3 are not user-initiated commands, hence such an
> action command ID is ok vs #2 is not ok? I probably misunderstanding
> your comment.

Let me put it more simply at some cost to accuracy..
The notification types and command ids usually match the response
to a GET command. Please TAL at the messages which are generated 
in response to a GET for the objects you listed...

Netlink command IDs are not required to match in a request-response
pair. In "modern" families we recommend that they do match, not because
the old model was wrong, but because a casual contributors usually got
it wrong.

