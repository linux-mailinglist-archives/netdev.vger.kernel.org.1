Return-Path: <netdev+bounces-178668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D041A7824E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 20:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C66516F307
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FB121CC51;
	Tue,  1 Apr 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGDTgEUS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7621CA1C
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532028; cv=none; b=BNskcRiYhmEXdvgK0um4okEgfUeH2efAT3gPnG1vLipmuyJa0dg8fYR8HOZAY7lFHvWs80AQJlZN+uSkOoTqDJEg9ERvlfIlk09z0pxW3jYLmxYWF28Yokg//D8rIytmTDMWApqmXr1ZdmAbqR5CS7BhHERP5irp/GZnVr1DTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532028; c=relaxed/simple;
	bh=95QeDf0/+jbroRmGa0qtsVqLmm3cierM28kabh7h9Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQJdQuQbv8FxMCfAQuGWmOj8W0A3B+hBVUwM/5tceTug3SlFiT4OGPl5EvnyiZLR5DW2bl2yZ+6GEAkclL9Ypl+Eff6CmmqvMCwubn0Kgin1LSp72C2dDv3lUv6Q0oaOu6d7fyuuiJsz/sPkKW8j4MRg8kFPOHhb5EEGts4ABmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGDTgEUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFEDC4CEE4;
	Tue,  1 Apr 2025 18:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743532027;
	bh=95QeDf0/+jbroRmGa0qtsVqLmm3cierM28kabh7h9Jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UGDTgEUSCZg4ZEWQZVNbXm/mjeywgI4cALUNllu2Pgvfq/loNMI6lOavPEr94JzUB
	 CKD/DMXW0fRrkw3djAQZssEXXd9rVoD1HsHOhqeVSZR8+QWD3LrvUKynfcp3PRGGFp
	 tkQIU1F4SQBLOoJ4qdRSIvDEvjbcFMsuJ65SSdrE1AxxmsW0LB/4A6gIGzzl/DrtKQ
	 853Yy/hlHr4fI9iAW+eH0tvK2CmMnS6q89Rmqq7BtJtFRKynYYFfhD/tPmyu8qVU4q
	 rS8H+PBivzJp8CH2LZyUbXgpBDl9rwoxc9UHQlTxpbpN5ptMBdY/RPYKL9s3I0ESue
	 sW5x4uwKkFWSQ==
Date: Tue, 1 Apr 2025 11:27:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, "David S . Miller "
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/4] Add support to set napi threaded for
 individual napi
Message-ID: <20250401112706.2ff58e3d@kernel.org>
In-Reply-To: <20250325075100.77b5c4c0@kernel.org>
References: <20250321021521.849856-1-skhawaja@google.com>
	<20250321021521.849856-2-skhawaja@google.com>
	<Z92dcVfEiI2g8XOZ@LQ3V64L9R2>
	<20250325075100.77b5c4c0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 07:51:00 -0700 Jakub Kicinski wrote:
> On Fri, 21 Mar 2025 10:10:09 -0700 Joe Damato wrote:
> > > +int napi_set_threaded(struct napi_struct *napi, bool threaded)
> > > +{
> > > +	if (napi->dev->threaded)
> > > +		return -EINVAL;    
> > 
> > This works differently than the existing per-NAPI defer_hard_irqs /
> > gro_flush_timeout which are also interface wide.
> > 
> > In that implementation: 
> >   - the per-NAPI value is set when requested by the user
> >   - when the sysfs value is written, all NAPIs have their values
> >     overwritten to the sysfs value
> > 
> > I think either:
> >   - This implementation should work like the existing ones, or
> >   - The existing ones should be changed to work like this
> > 
> > I am opposed to have two different behaviors when setting per-NAPI
> > vs system/nic-wide sysfs values.
> > 
> > I don't have a preference on which behavior is chosen, but the
> > behavior should be the same for all of the things that are
> > system/nic-wide and moving to per-NAPI.  
> 
> And we should probably have a test that verifies the consistency
> for all the relevant attrs.

I was thinking about it some more in another context, and I decided 
to write down what came to mind. Does this make sense as part of
our docs?

===================================
Adding new configuration interfaces
===================================

Best practices for implementing new configuration interfaces in networking.

Multi-level configuration
=========================

In certain cases the same configuration option can be specified with different
levels of granularity, e.g. global configuration, and device-level
configuration. Finer-grained rules always take precedence. A more tricky
problem is what effect should changing the coarser settings have on already
present finer settings. Setting coarser configuration can either reset
all finer grained rules ("write all" semantics), or affect only objects
for which finer grained rules have not been specified ("default" semantics).

The "default" semantics are recommended unless clear and documented reason
exists for the interface to behave otherwise.

Configuration persistence
=========================

User configuration should always be preserved, as long as related objects
exist.

No loss on close
----------------

Closing and opening a net_device should not result in loss of configuration.
Dynamically allocated objects should be re-instantiated when the device
is opened.

No partial loss
---------------

Loss of configuration is only acceptable due to asynchronous device errors,
and in response to explicit reset requests from the user (``devlink reload``,
``ethtool --reset``, etc.). The implementation should not attempt to preserve
the objects affected by configuration loss (e.g. if some of net_device
configuration is lost, the net_device should be unregistered and re-registered
as part of the reset procedure).

Explicit default tracking
-------------------------

Network configuration is often performed in multiple steps, so it is important
that conflicting user requests cause an explicit error, rather than silent
reset of previously requested settings to defaults. For example, if user
first requests an RSS indirection table directing to queues 0, 1, and 2,
and then sets the queue count to 2 the queue count change should be rejected.

This implies that network configuration often needs to include an indication
whether given setting has been requested by a user, or is a default value
populated by the core, or the driver. What's more the user configuration API
may need to provide an ability to not only set a value but also to reset
it back to the default.

Indexed objects
---------------

Configuration related to indexed objects (queues, NAPI instances etc.)
should not be reset when device is closed, but should be reset when object
is explicitly "freed" by the user. For example reducing the queue count
should discard configuration of now-disabled queued.

Core validation
===============

For driver-facing APIs the networking stack should do its best to validate
the request (using maintained state and potentially requesting other config
from the driver via GET methods), before passing the configuration to
the driver.

Testing
=======

All new configuration APIs are required to be accompanied by tests,
including tests validating the configuration persistence, and (if applicable)
the interactions of multi-level configuration.

Tests validating the API should support execution against netdevsim,
and real drivers (netdev Python tests have this support built-in).


