Return-Path: <netdev+bounces-202623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D3BAEE5F4
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4603BD12F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ECD290D98;
	Mon, 30 Jun 2025 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="osRXnm5N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52228DB5E;
	Mon, 30 Jun 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751305092; cv=none; b=nr9JOqfVN1jXThAnsSmspbiUBmD5f8lgs8MZGOztSYXqqgHhl6fwWUVYplYsQMIQLjVpgc9xBdXGIHxrN2dxRTuOlErx2w2J1rtiv5kIwDyIW5I+YUd6kmUMb5KY1EEUtLl7sVjDHOqZDcpJy8KdxkV16uAV1W0ATSXq8keC4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751305092; c=relaxed/simple;
	bh=di6i7onnN5iVLgY5hf9AO/y5tx5aWpYSnrrFx9g8Qsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b59PJvrLZWZRkPV9LwpCMgz4Fwqnh1Lj4EOhVJiGESPm9ckVjWsGwiA72mL+htveKJPWfvexn1Cennl8o792rKfNKisu+hTD/yjwc7zvQ4LGPGibAw50bnIpSA/cPvdo2QKDJwpBbPiSQBO73SXeneOlJerxU98UM+CXv1HqD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=osRXnm5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00D3C4CEE3;
	Mon, 30 Jun 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="osRXnm5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1751305088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dNSYdZ206LpIslFzq5r/Nbu3CGm5JCkikmIlkXCpOHM=;
	b=osRXnm5N+m5H8QTzfZ/ROXWKeNC5CrQwxyUEsEq+N0IykPTl4maIOvcZkgvOquEcyALR09
	wq8Nl6SiZE/VpInQGm59xW+9mhw1wTDcy0d+5cVlJsPdUsy3o4Lrbp11jXwDNTsHxyx3nw
	qeXoeuJ/TcM9tjGCYq1qNm0REcXaLPY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d3a18d76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Jun 2025 17:38:08 +0000 (UTC)
Date: Mon, 30 Jun 2025 19:38:02 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wireguard: queueing: simplify wg_cpumask_next_online()
Message-ID: <aGLLepPzC0kp9Ou1@zx2c4.com>
References: <20250619145501.351951-1-yury.norov@gmail.com>
 <aGLIUZXHyBTG4zjm@zx2c4.com>
 <aGLKcbR6QmrQ7HE8@yury>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGLKcbR6QmrQ7HE8@yury>

On Mon, Jun 30, 2025 at 01:33:37PM -0400, Yury Norov wrote:
> On Mon, Jun 30, 2025 at 07:24:33PM +0200, Jason A. Donenfeld wrote:
> > On Thu, Jun 19, 2025 at 10:54:59AM -0400, Yury Norov wrote:
> > > From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > 
> > > wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
> > > function significantly simpler. While there, fix opencoded cpu_online()
> > > too.
> > > 
> > > Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > ---
> > > v1: https://lore.kernel.org/all/20250604233656.41896-1-yury.norov@gmail.com/
> > > v2:
> > >  - fix 'cpu' undeclared;
> > >  - change subject (Jason);
> > >  - keep the original function structure (Jason);
> > > 
> > >  drivers/net/wireguard/queueing.h | 13 ++++---------
> > >  1 file changed, 4 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> > > index 7eb76724b3ed..56314f98b6ba 100644
> > > --- a/drivers/net/wireguard/queueing.h
> > > +++ b/drivers/net/wireguard/queueing.h
> > > @@ -104,16 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
> > >  
> > >  static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
> > >  {
> > > -	unsigned int cpu = *stored_cpu, cpu_index, i;
> > > +	unsigned int cpu = *stored_cpu;
> > > +
> > > +	if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
> > > +		cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
> > 
> > I was about to apply this but then it occurred to me: what happens if
> > cpu_online_mask changes (shrinks) after num_online_cpus() is evaluated?
> > cpumask_nth() will then return nr_cpu_ids?
> 
> It will return >= nd_cpu_ids. The original version based a for-loop
> does the same, so I decided that the caller is safe against it.

Good point. I just checked... This goes into queue_work_on() which
eventually hits:

        /* pwq which will be used unless @work is executing elsewhere */
        if (req_cpu == WORK_CPU_UNBOUND) {

And it turns out WORK_CPU_UNBOUND is the same as nr_cpu_ids. So I guess
that's a fine failure mode.

I'll queue this patch up.

Jason

