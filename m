Return-Path: <netdev+bounces-196686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE3EAD5EA5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5963C7ABCB2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44928466D;
	Wed, 11 Jun 2025 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="nvy3ywaK"
X-Original-To: netdev@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C62777FD
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668162; cv=none; b=U/rGMjfKLRI6w2kBsHGO9rAKLKS9e/1tYfN+eXD9KUo+I8DsOnWUY+yxLyufMo4bO45MCn2jSg5bm+CP3Y5am2HDSVJrz5/hMVTaGmbh1d/55pm0vVTELGQ3mNJdvJS21SscbhDHA9H3BDBtKDw/+ZLCGPzsXmRNSb5H8PE2fmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668162; c=relaxed/simple;
	bh=uZMNI2eKpooRJpq5nrCE/LvN5FOfjLV2hWIZUyweVgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLqCsHcRHyS+8+WVpiT6DOFwuKtPMb/HKQbpQ2YoeIZSCTGOmRV3AnwywqYGntkQcOPQX6tT+sTxYAK/sveg1a2uGlB+9ib4stUKhbO21+5h/BH7LNM1syAK+xAUuTt0g3e+yQCko2L9FaepHFHvUZbSOwMFybJalTwh8viG7xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=nvy3ywaK; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Date: Wed, 11 Jun 2025 14:50:31 -0400
From: Nikhil Jha <njha@janestreet.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 	Olga Kornievskaia <okorniev@redhat.com>,
 	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 	"David S. Miller" <davem@davemloft.net>,
 	Eric Dumazet <edumazet@google.com>,
 	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 	Simon Horman <horms@kernel.org>,
 	Steven Rostedt <rostedt@goodmis.org>,
 	Masami Hiramatsu <mhiramat@kernel.org>,
 	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix gss seqno handling to be more rfc-compliant
Message-ID: <20250611A18503192e946d6.njha@janestreet.com>
References: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
  <d78576c1-d743-4ec2-bf8c-d87603460ac1@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d78576c1-d743-4ec2-bf8c-d87603460ac1@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1749667831;
  bh=FpMbOeXSW5gqREJmu38NRaAciY+AIiBd4f7rjLts1EQ=;
  h=Date:From:To:Cc:Subject:References:In-Reply-To;
  b=nvy3ywaKM+HXjcbXegRqJJhPWpPema6thNJE0eI9STl3qqpqpdaXrG0RPEcTb6eLi
  OuFY7Iq4Jo9smQZRj6nhny01S5wernP4efPDmtmCnXwnZ0SCPvRmjn+SGzZBmq77HG
  DzaYSnlxiSHw13ZY1IL/DsX9E0N6VuqliCxJ1xlb5MSpcGNKDrWgT0TNC34L6aqtA/
  0vlTLRSBQqCJ9XOQ4osz9zYEPUdSdnR6pEUtIjXbVoR9J62P4bezOZk9U8/YcgjV+5
  vb/KSZaepYU7UBrFw14chpuFvmzUCwJbRVdFHC+OisEvyGoVCqhoZsKxlVk+Wvjf9z
  22Ya9jACvP9Rg==

On Thu, Mar 20, 2025 at 09:16:15AM -0400, Chuck Lever wrote:
> On 3/19/25 1:02 PM, Nikhil Jha via B4 Relay wrote:
> > When the client retransmits an operation (for example, because the
> > server is slow to respond), a new GSS sequence number is associated with
> > the XID. In the current kernel code the original sequence number is
> > discarded. Subsequently, if a response to the original request is
> > received there will be a GSS sequence number mismatch. A mismatch will
> > trigger another retransmit, possibly repeating the cycle, and after some
> > number of failed retries EACCES is returned.
> > 
> > RFC2203, section 5.3.3.1 suggests a possible solution... “cache the
> > RPCSEC_GSS sequence number of each request it sends” and "compute the
> > checksum of each sequence number in the cache to try to match the
> > checksum in the reply's verifier." This is what FreeBSD’s implementation
> > does (rpc_gss_validate in sys/rpc/rpcsec_gss/rpcsec_gss.c).
> > 
> > However, even with this cache, retransmits directly caused by a seqno
> > mismatch can still cause a bad message interleaving that results in this
> > bug. The RFC already suggests ignoring incorrect seqnos on the server
> > side, and this seems symmetric, so this patchset also applies that
> > behavior to the client.
> > 
> > These two patches are *not* dependent on each other. I tested them by
> > delaying packets with a Python script hooked up to NFQUEUE. If it would
> > be helpful I can send this script along as well.
> > 
> > Signed-off-by: Nikhil Jha <njha@janestreet.com>
> > ---
> > Changes since v1:
> >  * Maintain the invariant that the first seqno is always first in
> >    rq_seqnos, so that it doesn't need to be stored twice.
> >  * Minor formatting, and resending with proper mailing-list headers so the
> >    patches are easier to work with.
> > 
> > ---
> > Nikhil Jha (2):
> >       sunrpc: implement rfc2203 rpcsec_gss seqnum cache
> >       sunrpc: don't immediately retransmit on seqno miss
> > 
> >  include/linux/sunrpc/xprt.h    | 17 +++++++++++-
> >  include/trace/events/rpcgss.h  |  4 +--
> >  include/trace/events/sunrpc.h  |  2 +-
> >  net/sunrpc/auth_gss/auth_gss.c | 59 ++++++++++++++++++++++++++----------------
> >  net/sunrpc/clnt.c              |  9 +++++--
> >  net/sunrpc/xprt.c              |  3 ++-
> >  6 files changed, 64 insertions(+), 30 deletions(-)
> > ---
> > base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> > change-id: 20250314-rfc2203-seqnum-cache-52389d14f567
> > 
> > Best regards,
> 
> This seems like a sensible thing to do to me.
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> -- 
> Chuck Lever

Hi,

We've been running this patch for a while now and noticed a (very silly
in hindsight) bug.

maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i], seq, p, len);

needs to be

maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i++], seq, p, len);

Or the kernel gets stuck in a loop when you have more than two retries.
I can resend this patch but I noticed it's already made its way into
quite a few trees. Should this be a separate patch instead?

- Nikhil






