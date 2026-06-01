Return-Path: <netdev+bounces-293682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SODvHmplHWqwaAkAu9opvQ
	(envelope-from <netdev+bounces-293682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:56:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7661DF74
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C0ED3009FA2
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1839B4A3;
	Mon,  1 Jun 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLjH+VMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313338BF62
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310967; cv=none; b=pQ+E2zRLOwgXs95mVFOFjVqYtSKNoFdy8iZ1QAuzCiCvjwAwuH4VwrrJPuj5uF1QnzIxZ3aqp8aPRnP4sLKqIVmfr3ZoH8HuHVla8GRyxEbwMs2wVMP9t5eW44h3+cooSa5wB7d/5it6j1zorHMGdtiIxEyyxhObCEnj+t296nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310967; c=relaxed/simple;
	bh=FeH+gRohkC68MnnjdHRbSKUwQxEUA3mWvM4XUzl+aMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrf8tMDfhj5LKLPpTZUmh1pkwKZLrnasuimuW8SdDzbITfv7qrfjdbuBdConbqdaVYbbPbJUrqR4r7bY5XY99RpHuPaH3bMKMUBPUJ29a1PVaSpOsTcX1PnkQB2ddJSIYdJRwxvd09V6/GGhIVJw6ELBAcYHXqd/dlasl8seqyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLjH+VMS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b9d265355so2192842a91.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780310965; x=1780915765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lr/jfIoXaA3DgpdxroQv8tyvIlqJX8SEbcj4APUwDCU=;
        b=FLjH+VMSbemTiLPHwmkxWpTkCWXeySLXqUQK+ElghBUcIUSsvAuMhBTU6BT5jSby6o
         i03jPw7JUBnLQhpXQzdaMvSXzkIBwheAcO/iX6nRbtVbcJFahLGaH/5H0aNHe2gjw36e
         FoK/nHH3ZUBkZQ03V9/HRMW+EZCw45JT9lt9vYyvukXQj1gWPrfZbygjaIXfO1C9ieOI
         g/ICW8pWaGis+Ikt+NJ9XTSv8oNs9vnWj7JQTBnyuBDUKjnrePhoTiifEshhLWLZrFmP
         H+UtTzsdXPMcqeIpGsWPW3qQzZwFOox2U3MPO1LhH+fQWo1naF5DPuhd8Ds7yf/rWhqP
         sceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780310965; x=1780915765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lr/jfIoXaA3DgpdxroQv8tyvIlqJX8SEbcj4APUwDCU=;
        b=D3I3zhMvdDSa6mQ3jQiayIJ+rPF2984sDa9j8tyoiZeOodkyF1/RcnqcMf6BwsaMe2
         g5WkLQou8za1jqSM7v22LhwaPMkl7qvdSMcWdkSiHBNNrskFTxSBESTFWDdJFBuCfxC2
         BTmlMX+ViiKRQjZFIOApbfzDoQ6LBEYaj/tMzmj/w7tR0JBcfdnGRTycst4QxU+9cPUm
         yT5IhPlB3beYFzrg4UPfccrArY7dUObKjG7E+1FmJprIN/c2lo08/pUo//PuRDelNikQ
         0fFpOREiCyBUbaN9eBkWiFX6nMLr+nZXfqzX9ehlWy5IF+sMO0W1xDQHTctLN26QcbNm
         DtoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vs3wnxEOydaxwI4wKWktL5slMVVg/foOiOrN2XatTbmeRIIGM0KYBg9bWmSRbFLEYI68ij4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4i2eYZ/jNzxmjUzS/760UV9yQzjYXxL2fo1gzPX/+5q2UFn8
	rmAs4KmdUGgoWJaefJsh6pE8ncYA4bH40VVPTtyPftGM9SRuceJHxpn7
X-Gm-Gg: Acq92OEf6t3rG9rNwAwdxPB9v5IrIBaWbpyVjrK0/GreDYi8Gz042h01jnqW1RSaGB/
	O9sTNMymTzu2xJeCby7tLDP8h4lGERYn2t4HlGUwMKjCyLBiQFK+saMGRJVhIQjlfXFSiJZSLHm
	vMqlPXZ2fvPb54fHE7EfmPyZJd2cqS8U/psShyBeybPI8d4onYkHA679Ok3wmb/yuebt58hPUEm
	tXE12T6zXTwHuMRlFKEgsw/OogrbI+naSscngabTOo84d70K4ojgkFOFar6ndXmavOwvGe7GHUz
	jtclo2TN1HI3mY5NrtFdwWRTyiyCVzLVw3czaNHoT7++yEhmXpCP/cbhiBoUut4Qc/hPWEx1k2I
	nKPj7bFZIFdXtb9NQ1bmRXLkND1ctp+pgUREYvfWuSive/cUT5Fjr79luFIxLG4bA23BWmF0CC5
	TN9l1wRmchOtRKeZ2IoLSyxhm4Bvt63pgmK1mpgJx6+OG1O3aa/lcUUA==
X-Received: by 2002:a17:90b:2e46:b0:368:ddd7:abcd with SMTP id 98e67ed59e1d1-36c6848c5ddmr9775332a91.27.1780310965117;
        Mon, 01 Jun 2026 03:49:25 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc02d0a22sm10964780a91.8.2026.06.01.03.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:49:24 -0700 (PDT)
Date: Mon, 1 Jun 2026 19:49:21 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] inet: frags: fix use-after-free caused by the
 fqdir_pre_exit() flush
Message-ID: <ah1jsYSmm2PzZ3V1@v4bel>
References: <ah1Sw2g-I89BRRiT@v4bel>
 <CANn89i+q8uKxsjCCe6Gz-YcHTwGZQsDWRKNO2FP=+0Z4S7uQCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+q8uKxsjCCe6Gz-YcHTwGZQsDWRKNO2FP=+0Z4S7uQCg@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293682-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E9A7661DF74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 02:56:37AM -0700, Eric Dumazet wrote:
> On Mon, Jun 1, 2026 at 2:37 AM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> >
> > On netns teardown, fqdir_pre_exit() walks the fqdir rhashtable and
> > flushes every fragment queue that is not yet complete using
> > inet_frag_queue_flush(). That helper frees all the skbs queued on the
> > fragment queue but does not set INET_FRAG_COMPLETE, and leaves
> > q->fragments_tail and q->last_run_head pointing at the freed skbs.
> > The queue itself stays in the rhashtable.
> >
> > fqdir_pre_exit() first lowers high_thresh to 0 to stop new queue lookups,
> > but it cannot stop a fragment that already obtained the queue through
> > inet_frag_find() earlier and stalled just before taking the queue lock.
> > Once that fragment resumes after the flush and takes the queue lock,
> > it passes the INET_FRAG_COMPLETE check and then dereferences the freed
> > fragments_tail. inet_frag_queue_insert() reads FRAG_CB() and ->len of
> > that pointer and, on the append path, writes ->next_frag, causing a
> > slab use-after-free. IPv6, nf_conntrack_reasm6 and 6lowpan reassembly
> > share the same flush path and are affected as well.
> >
> > Mark the queue complete and reset its remaining pointers under the same
> > lock right after the flush. With INET_FRAG_COMPLETE set, the insert in
> > each reassembly path bails out at its check as soon as it takes the
> > queue lock and no longer accesses the freed fragments_tail.
> >
> > Fixes: 006a5035b495 ("inet: frags: flush pending skbs in fqdir_pre_exit()")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv4/inet_fragment.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> > index 393770920abd..d532f6182c8a 100644
> > --- a/net/ipv4/inet_fragment.c
> > +++ b/net/ipv4/inet_fragment.c
> > @@ -243,8 +243,13 @@ void fqdir_pre_exit(struct fqdir *fqdir)
> >                         continue;
> >                 }
> >                 spin_lock_bh(&fq->lock);
> > -               if (!(fq->flags & INET_FRAG_COMPLETE))
> > +               if (!(fq->flags & INET_FRAG_COMPLETE)) {
> >                         inet_frag_queue_flush(fq, 0);
> > +                       fq->flags |= INET_FRAG_COMPLETE;
> > +                       fq->rb_fragments = RB_ROOT;
> > +                       fq->fragments_tail = NULL;
> > +                       fq->last_run_head = NULL;
> > +               }
> 
> 
> Any reason this is not done from inet_frag_queue_flush() so that we can
> remove the related code from ip_frag_reinit()?

I looked at the callers and agree that doing this in 
inet_frag_queue_flush() is the right direction.

> 
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index 86b100694659ee51292625216113f9411b98a351..6c5f373e55d3a39a581a6364599d911782469f77
> 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -326,6 +326,10 @@ void inet_frag_queue_flush(struct inet_frag_queue *q,
>         reason = reason ?: SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
>         sum = inet_frag_rbtree_purge(&q->rb_fragments, reason);
>         sub_frag_mem_limit(q->fqdir, sum);
> +       q->flags |= INET_FRAG_COMPLETE;

While testing, though, I found that setting INET_FRAG_COMPLETE there 
leaks the inet_frag_queue. A queue flushed by fqdir_pre_exit() then 
reaches inet_frags_free_cb() with INET_FRAG_COMPLETE set but 
INET_FRAG_HASH_DEAD clear, so neither branch there drops its hash 
reference. So the INET_FRAG_COMPLETE assignment should be dropped.

I'll send v2 after 24 hours.


Best regards,
Hyunwoo Kim

> +       q->rb_fragments = RB_ROOT;
> +       q->fragments_tail = NULL;
> +       q->last_run_head = NULL;
>  }
>  EXPORT_SYMBOL(inet_frag_queue_flush);
> 
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index 56b0f738d2f27b6b4c4b55f5ca9368305ce1eb4f..c790d2f494870e1debd7e73b2d67df017a29f8a8
> 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -250,9 +250,6 @@ static int ip_frag_reinit(struct ipq *qp)
>         qp->q.flags = 0;
>         qp->q.len = 0;
>         qp->q.meat = 0;
> -       qp->q.rb_fragments = RB_ROOT;
> -       qp->q.fragments_tail = NULL;
> -       qp->q.last_run_head = NULL;
>         qp->iif = 0;
>         qp->ecn = 0;

