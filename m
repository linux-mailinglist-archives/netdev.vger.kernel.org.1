Return-Path: <netdev+bounces-245741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD5FCD6C82
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 18:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B2FA3008D70
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CC32AAD2;
	Mon, 22 Dec 2025 17:14:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F412C326B;
	Mon, 22 Dec 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766423698; cv=none; b=NkZP86MzDm/cE+tJMVq8FFGaW1PtWWRtq3hcX7DWuaJRWz8B04+hqtEBudxkgfGzfthpY3pejLsYPe/onZ0mjXHnO4+sy8U5JHeH0x5no79F1XM6efogK3FootaYTUmEMiXppfvNfNd/dUb+MtcteJyj3y311CadASx2z3IDQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766423698; c=relaxed/simple;
	bh=HxRv7w1vED2IfEvH0OJVl2E0hhx3aQIhJZ8DWtCJKDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brwyxSUXPPGu9ZWfDgciVHR2hyzWOrfWxUAA4Fl9lV/qJL2BljTAEvc2BvL7U1Z0wYCNNU95lua7kDo8nSpMR98Mcf7QmryPctUsiUeFrDPQtQbVheCdoBDb6djDzhNZTTXf1vLwR3t5ct7J0lf+9tFsAXubg1SKfdC054CLics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 6BE6316024A;
	Mon, 22 Dec 2025 17:14:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id CEF4B20026;
	Mon, 22 Dec 2025 17:14:51 +0000 (UTC)
Date: Mon, 22 Dec 2025 12:16:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v2] ipv6: fix a BUG in rt6_get_pcpu_route() under
 PREEMPT_RT
Message-ID: <20251222121639.3953ea08@gandalf.local.home>
In-Reply-To: <CANn89iLeASUZyonYSLX0AG5mbC=gxux0efehkBc_j1bbj6xrvA@mail.gmail.com>
References: <20251219025140.77695-1-jiayuan.chen@linux.dev>
	<CANn89iLeASUZyonYSLX0AG5mbC=gxux0efehkBc_j1bbj6xrvA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f1pthr7jy8yo3p7913jp9hosr6jxco9w
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CEF4B20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX191uoSRoAcs65lca+dI6dYowq+H76BrJY4=
X-HE-Tag: 1766423691-122231
X-HE-Meta: U2FsdGVkX18RgFuzWGdrZg2FEz1En/6K2/0DFCl3jGHb5HogSWaGuaLWlsmdcFYRBfSZm1uJbUNzxanqTn9Yc7aoEdmdUOFiuf2j0Zotp6ZtMTdEAbzqp3mSHsggP/nBGzYaB36IQ2CwP6hn/ntfiqjDBZlKvWE3ev4XsMf9iHcGg9y86zzi9r1I9ny3HyPMaEwCKvLLWMKWFpAF0FTK1Y44Fc/b+TydNJzAup+0czTm3vF/67ubBg3UTtcK6dj8DRCzHyi03YnmALCyweINZsBmBGfhLgR6/0TvLGnS78/DQ+lGFY1vHU4t2ESh0Y5tc+JaCn+OtwQVtxT72z9Pigy3l+YRVs15MPpZJmEGRX7O8nq7bJw/AL/kv/5RnCgPKqtcNQwBr6C7SOCA3qkj+Q==

On Mon, 22 Dec 2025 09:50:58 +0100
Eric Dumazet <edumazet@google.com> wrote:

> > Link: https://syzkaller.appspot.com/bug?extid=9b35e9bc0951140d13e6
> > Fixes: 951f788a80ff ("ipv6: fix a BUG in rt6_get_pcpu_route()")  
> 
> I would rather find when PREEMPT_RT was added/enabled, there is no
> point blaming such an old commit
> which was correct at the time, and forcing pointless backports to old
> linux kernels.

Ack!

-- Steve

