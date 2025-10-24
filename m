Return-Path: <netdev+bounces-232610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E028C071E2
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF29435CD2F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8269230C363;
	Fri, 24 Oct 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwH8qkN/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07E2E0411
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321447; cv=none; b=CnhVcea81d6VqMcWARCHJuMfVs8K+jIWsRMAn5QlqaqOsNevaUka/jVGNpTbf5SCu8kNlachUaZf/dpIqDgjb5RHDT5n4VSrWw6J5Htx++aIkNZp5NrDS58Iq0aDWiZyhcz+/slOgD8oAIode0EXIV5OVV4+0tPRFIedGglWgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321447; c=relaxed/simple;
	bh=G5jea8WjsKT+Y8WSH1LA2EbSQ8s2PtZdDsBTE0vngUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbrrOXrhoc1n2N2xAFh6801HQfQE+BodktUC5Yj9UW+2V/z2rXPZure86IbPnrtOOfz13zL2n30GiAUnUULvA2sXpQQcY3LjC+ygWEKG6PRcn31Lta4Vp1WEDh8BNbCmoP54PcUWQJgldQCXq23CNgoDzxCOK2BfjEjkD252J8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwH8qkN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA9FC4CEF7;
	Fri, 24 Oct 2025 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761321446;
	bh=G5jea8WjsKT+Y8WSH1LA2EbSQ8s2PtZdDsBTE0vngUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwH8qkN/dlnzTCBzeBvUSfVVtE/jCXFoMvaSPAgyvE3ZcGqBpc2b8yIaOaiu3iV6f
	 n1Iz4MREJdu55Zc73FKM06lXO0Fe5ZIn/I2MoZj+g5rPrUGT+LfvVUkAj3tNKGa2U3
	 1PNToggcZncekPGLnz7lRsTuA50SNUQH0yy+vwFxOVNv60fMl7uokM2sr6YPT1mUEO
	 EOxKGHX5ddpa1GzOSZssFENzzffSvfCkY097CVsxHAODdZp378C9TltPtXO3J1E4w0
	 tHB70aM5Sr8MGENWEOzcjFw5irJLF8yXklL4YxPhNaetdoutlYZXtDlf2Zfi30elqh
	 KvXtHz28Rt43g==
Date: Fri, 24 Oct 2025 16:57:23 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Yonglong Li <liyonglong@chinatelecom.cn>, netdev@vger.kernel.org,
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	kuba@kernel.org
Subject: Re: [PATH net 1/2] net: ip: add drop reasons when handling ip
 fragments
Message-ID: <aPuh49HWMxXNxsyM@horms.kernel.org>
References: <1761286996-39440-1-git-send-email-liyonglong@chinatelecom.cn>
 <1761286996-39440-2-git-send-email-liyonglong@chinatelecom.cn>
 <CANn89i+TsY67y-pCkOkJHsh11Leg77Ek7n2-j6X6ed-U20eR=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+TsY67y-pCkOkJHsh11Leg77Ek7n2-j6X6ed-U20eR=g@mail.gmail.com>

On Thu, Oct 23, 2025 at 11:43:25PM -0700, Eric Dumazet wrote:
> On Thu, Oct 23, 2025 at 11:23 PM Yonglong Li <liyonglong@chinatelecom.cn> wrote:
> >
> > 1, add new drop reason FRAG_FAILED, and use it in ip_do_fragment
> > 2, use drop reasons PKT_TOO_BIG in ip_fragment
> >
> > Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> > ---
> >  include/net/dropreason-core.h | 3 +++
> >  net/ipv4/ip_output.c          | 6 +++---
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> > index 58d91cc..7da80f4 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -99,6 +99,7 @@
> >         FN(DUP_FRAG)                    \
> >         FN(FRAG_REASM_TIMEOUT)          \
> >         FN(FRAG_TOO_FAR)                \
> > +       FN(FRAG_FAILED)                 \
> >         FN(TCP_MINTTL)                  \
> >         FN(IPV6_BAD_EXTHDR)             \
> >         FN(IPV6_NDISC_FRAG)             \
> > @@ -500,6 +501,8 @@ enum skb_drop_reason {
> >          * (/proc/sys/net/ipv4/ipfrag_max_dist)
> >          */
> >         SKB_DROP_REASON_FRAG_TOO_FAR,
> > +       /* do ip/ip6 fragment failed */

nit; This comment should be a Kernel doc, like the comments
     for other members of this enum.

> > +       SKB_DROP_REASON_FRAG_FAILED,
> >         /**
> >          * @SKB_DROP_REASON_TCP_MINTTL: ipv4 ttl or ipv6 hoplimit below
> >          * the threshold (IP_MINTTL or IPV6_MINHOPCOUNT).

...

