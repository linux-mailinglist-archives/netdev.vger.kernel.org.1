Return-Path: <netdev+bounces-41542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CF7CB465
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3993F281820
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC436B1C;
	Mon, 16 Oct 2023 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHKI4VZA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA134CE3
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA149C433C8;
	Mon, 16 Oct 2023 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487310;
	bh=yl0rOlnQ2M/dVHHqqAGa5DA1OV0u7I/tDmHPhDi34Do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHKI4VZAug0hkCl9QMpSr5mx/+OIJWVji70KF30HMPrOfgguhOVsE0uTe46L7XT6b
	 vQufxdxMTqnZQrdsgPIsqB89A+hi7NkDHUN7/6YaT+mTzRpS1r8V8BLylSp7zZRUQv
	 koJdza+57ATFOh6CyN07N1vqWxRJXXBlzo3p+9+WnV4AiqyhZ2O+58K/1ehrMZmhu3
	 JwvDvWFo0RbEwoOjhwglRucxdpJs/grWVBWWlUdzkhSbN82SFkOimhC/mnpf2lNLrB
	 h1RZ+SCVe50jYD+ZHIQKghpj1HfRM38SSHo4sQVInF3wfjLO8WqLl3teigD77rVcAH
	 nsMebzJRQv7Qg==
Date: Mon, 16 Oct 2023 13:15:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, anjali.singhai@intel.com,
 namrata.limaye@intel.com, deb.chatterjee@intel.com,
 john.andy.fingerhut@intel.com, dan.daly@intel.com, Vipin.Jain@amd.com,
 tom@sipanda.io, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com,
 mattyk@nvidia.com
Subject: Re: [PATCH v7 net-next 00/18] Introducing P4TC
Message-ID: <20231016131506.71ad76f5@kernel.org>
In-Reply-To: <20231016093549.181952-1-jhs@mojatatu.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 05:35:31 -0400 Jamal Hadi Salim wrote:
> Changes In RFC Version 7
> -------------------------
> 
> 0) First time removing the RFC tag!
> 
> 1) Removed XDP cookie. It turns out as was pointed out by Toke(Thanks!) - that
> using bpf links was sufficient to protect us from someone replacing or deleting
> a eBPF program after it has been bound to a netdev.
> 
> 2) Add some reviewed-bys from Vlad.
> 
> 3) Small bug fixes from v6 based on testing for ebpf.
> 
> 4) Added the counter extern as a sample extern. Illustrating this example because
>    it is slightly complex since it is possible to invoke it directly from
>    the P4TC domain (in case of direct counters) or from eBPF (indirect counters).
>    It is not exactly the most efficient implementation (a reasonable counter impl
>    should be per-cpu).

I think that I already shared my reservations about this series.

On top of that, please, please, please make sure that it builds cleanly
before posting.

I took the shared infra 8 hours to munch thru this series, and it threw
out all sorts of warnings. 8 hours during which I could not handle any
PR or high-prio patch :( Not your fault that builds are slow, I guess,
but if you are throwing a huge series at the list for the what-ever'th
time, it'd be great if it at least built cleanly :(

FWIW please do not post another version this week (not that I think
that you would do that, but better safe than sorry. Last week the patch
bombs pushed the shared infra 24h+ behind the list..)
-- 
pw-bot: cr

