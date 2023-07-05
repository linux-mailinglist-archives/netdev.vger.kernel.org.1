Return-Path: <netdev+bounces-15560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BD748859
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D76281011
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6AA11CB3;
	Wed,  5 Jul 2023 15:50:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A11111AF
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 15:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CC6C433C8;
	Wed,  5 Jul 2023 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688572200;
	bh=LKIw2C4zLdq/arYohsNFX5l44L3BXGn1ZG9+kkvZW5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rEzT6KVm4TjVa+PkpwzsjqzovOD8U11GjzMofQOI+l7tZttDYkjFJHKgUDWemaJpD
	 Zxa1xpb1rAL9HXuUoTOeF/8yma5F+R6tP/6W2KctPtJ0ROyfx+UdRCHkr8Q3gyTF8Z
	 8ZQ1dZfKPNFsntZksx0mZhdXMTFiia2x1khpcGIFUZx0W9Jqkyzm3//hui+N6kDYRh
	 GfcDjukmIZPVY86mNQhoeKAhCtXRdWRwLZeQuSViAwtP/FdjNcMeNzTRMr4Z2HaRdG
	 Aj5GhKRYxgQFBEe7FBrDuu5DI01SXOe0KEuvaYU14+2W1Dhlah4GwOJSAbI+Zj/Ffj
	 x02WaUUycubBw==
Date: Wed, 5 Jul 2023 08:49:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, sergey.senozhatsky@gmail.com, pmladek@suse.com,
 tj@kernel.org, Dave Jones <davej@codemonkey.org.uk>, "open list:NETWORKING
 DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230705084958.1c4854eb@kernel.org>
In-Reply-To: <20230705082604.7b104a48@hermes.local>
References: <20230703154155.3460313-1-leitao@debian.org>
	<20230703113410.6352411d@hermes.local>
	<ZKQ3o6byAaJfxHK+@gmail.com>
	<20230704085800.38f05b56@hermes.local>
	<ZKU1Sy7dk8yESm4d@gmail.com>
	<20230705082604.7b104a48@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jul 2023 08:26:04 -0700 Stephen Hemminger wrote:
> On Wed, 5 Jul 2023 02:18:03 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
> > The uname is useful if the receiver side is looking (grepping) for
> > specific messages (warnings, oops, etc) affecting specific kernel
> > versions. If the uname is not available, the receiver needs to read boot
> > message and keep a map for source IP to kernel version. This is far from
> > ideal at a hyperscale level.  
> 
> At hyperscale you need a real collector (not just netcat) that can consult
> the VM database to based on IP and record the meta data there.  If you allow
> random updates and versions, things get out of control real fast and this
> won't really help much

VM world is simpler because the orchestrator knows exactly what it's
launching each time. Bare metal is more complicated, especially
with modern automation designs where the DBs may contain _intended_
state, and local host agent performs actions to bring the machine
into the intended state.

Not to mention that there may be multiple kernels at play (provisioning
flow, bootloader / EFI, prod, kdump etc.)

As a kernel dev I do like the 100% certainty as to which kernel version
was running at the time of the problem.

