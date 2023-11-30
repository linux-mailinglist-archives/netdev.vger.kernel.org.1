Return-Path: <netdev+bounces-52528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4BE7FF0C5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4A51C20B9B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE462482F3;
	Thu, 30 Nov 2023 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70ECF;
	Thu, 30 Nov 2023 05:53:15 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1r8hTY-0005uP-5q; Thu, 30 Nov 2023 14:53:08 +0100
Date: Thu, 30 Nov 2023 14:53:08 +0100
From: Florian Westphal <fw@strlen.de>
To: Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	lorenzo@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH nf-next 7/8] netfilter: nf_tables: add flowtable map for
 xdp offload
Message-ID: <20231130135308.GA5447@breakpoint.cc>
References: <20231121122800.13521-1-fw@strlen.de>
 <20231121122800.13521-8-fw@strlen.de>
 <87il5re7su.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il5re7su.fsf@toke.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)

Toke H�iland-J�rgensen <toke@toke.dk> wrote:
> I am not a huge fan of this flag, especially not as UAPI. Using the XDP
> offload functionality is already an explicit opt-in by userspace (you
> need to load the XDP program). So adding a second UAPI flag that you
> have to set for the flowtable to be compatible with XDP seems to just
> constrain things needlessly (and is bound to lead to bugs)?

I can remove it.  But it leads to issues, for example one flowtable
can shadow another one.

I'd prefer to handle this from control plane and reject such config.
Alternative is to ignore this and handle it as "self sabotage, don't
care" combined with "do not do that, then".

> If we can't change the behaviour, we could change the lookup mechanism?
> BPF is pretty flexible, nothing says it has to use an ifindex as the
> lookup key? The neatest thing would be to have some way for userspace to
> directly populate a reference to the flowtable struct in a map, but a
> simpler solution would be to just introduce an opaque ID for each
> flowtable instance and use that as the lookup key (userspace could
> trivially put that into a map for the BPF program to find)?

Won't that complicate things?  Userspace will have to use netlink
events to discover when a flowtable is removed, no?

