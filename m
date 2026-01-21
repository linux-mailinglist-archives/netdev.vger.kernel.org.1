Return-Path: <netdev+bounces-251673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHchLS8dcGlRVwAAu9opvQ
	(envelope-from <netdev+bounces-251673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:26:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF14E7B0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 684CB74D081
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC02749CF;
	Wed, 21 Jan 2026 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aErjsNkJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4F2609CC;
	Wed, 21 Jan 2026 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955178; cv=none; b=hf9Lqmdlpss0SZUx7tevHFufpfg9ZL81nNmJpFjHzjSbW2YuGkEEsjCQqJ8opmItm60laNMTNCPXlcEo0sHqu4J3XVmAQQZ5HystqvcTg4OThD53/gnerg7bv+YrpQkZuk2QoKVALIoxZGRwezzNmqbttazizeGC3wMB1wgYp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955178; c=relaxed/simple;
	bh=+f2LPxP00sAARaOHMgIpigrLJul4L3h+Y0S2id4GkWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/7squPnHQjxrbfzzridBfeBlrS46QqiBVJ9Rr7W+cwk/8ilxTQSV6fWEoyp5UGF9keR0OtZAgQnIHKtr03sb7XnY7t/zjSS8vHOZ1MqGTvYGqbOaEfdxn5cBqFbFccejsq7RXg7k8P5f3dh1qFGTBEVs356nohqyU9pIofXRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aErjsNkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E05C16AAE;
	Wed, 21 Jan 2026 00:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768955177;
	bh=+f2LPxP00sAARaOHMgIpigrLJul4L3h+Y0S2id4GkWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aErjsNkJM/8iEUXSRo6tJCElcZDqOVyWFmTlm20UvFakyMKQrdq7DWhdxoucO3xaJ
	 u3/umRZMRzwZ5wLNZDoEV2nzVZvN765LA1aHW7hpidt6ZuWVBh6lk+DOT6nNh9+G6X
	 OnZq+Dn5nFfL/cPVtr3ZVLRTnW48qTaFoasiTIFovEQaGGtRuw4YeTTrlx9hoYfRTk
	 4VGa8O1KASwy0vGxcKprhFx/M1lzPfaIQmNSNfAvAislKB3apAHN2ORfI8GRroVTRz
	 MSVLCQe2oxJMilSZjKR6GBYiTOtXFpN3+x81zWwRhcjprqSkQmAQoz/qmVZCxGoxuO
	 Y2k2dTyJgHqeQ==
Date: Tue, 20 Jan 2026 16:26:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
Message-ID: <20260120162616.463c8af1@kernel.org>
In-Reply-To: <1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
	<1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-251673-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4DFF14E7B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 16 Jan 2026 11:40:06 +0100 Jesper Dangaard Brouer wrote:
> On 15/01/2026 13.23, Jesper Dangaard Brouer wrote:
> > Add specific drop reasons to SFQ qdisc to improve packet drop observability
> > and monitoring capabilities. This change replaces generic qdisc_drop()
> > calls with qdisc_drop_reason() to provide granular metrics about different
> > drop scenarios in production environments.
> > 
> > Two new drop reasons are introduced:
> > 
> > - SKB_DROP_REASON_QDISC_MAXFLOWS: Used when a new flow cannot be created
> >    because the maximum number of flows (flows parameter) has been
> >    reached and no free flow slots are available.
> > 
> > - SKB_DROP_REASON_QDISC_MAXDEPTH: Used when a flow's queue length exceeds
> >    the per-flow depth limit (depth parameter), triggering either tail drop
> >    or head drop depending on headdrop configuration.  
> 
> I noticed commit 5765c7f6e317 ("net_sched: sch_fq: add three 
> drop_reason") (Author: Eric Dumazet).
> 
>   SKB_DROP_REASON_FQ_BAND_LIMIT: Per-band packet limit exceeded
>   SKB_DROP_REASON_FQ_HORIZON_LIMIT: Packet timestamp too far in future
>   SKB_DROP_REASON_FQ_FLOW_LIMIT: Per-flow packet limit exceeded
> 
> Should I/we make SKB_DROP_REASON_QDISC_MAXDEPTH specific for SFQ ?
> Like naming it = SKB_DROP_REASON_SFQ_MAXDEPTH ?

FWIW FLOW_LIMIT is more intuitive to me, but I'm mostly dealing with 
fq so probably because that's the param name there.

I'd prefer the reuse (just MAXDEPTH, I don't see equivalent of
MAXFLOWS?). We assign multiple names the same values in the enum to
avoid breaking FQ users.

