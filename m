Return-Path: <netdev+bounces-301600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SxkkF3WqO2oabAgAu9opvQ
	(envelope-from <netdev+bounces-301600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:59:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 529AC6BD1FE
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:59:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="CSjZT/rK";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301600-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301600-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CE2E3014E45
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573338BF62;
	Wed, 24 Jun 2026 09:59:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9533ACF10
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:59:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295146; cv=none; b=b/Fs1eHmbtLfZ0wIHfyhqmHI7W+zt/YNZ8uayg8fwpoIMGnYRD79dXOHFau2jctMBg5bhOj37Vj0ofRN+MyB65BqWqvab6H0695KnaQOhXuIu7bT2JlGHqlfpOwfhRY05lNwsMGClmpIq+RfIewYYM1Dw1PNwvDCk9eulQP78Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295146; c=relaxed/simple;
	bh=kbnDf0a5NvzGlSFhlTe2TF6vhRNL2dO82YCQFBLak2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNFZR6tPBuVSTM5b/rn/MHIdvs99mn7miOIjvJrLFZ4Vu2ambPFccLHzT1AbDjbT/rLoQK1gY3GlvsOTVljYEHLDGo+GG9nKV1+7c3m4pSHi+bUpc6Asv2yDsOj8S7/4Nh7sGwtCe4XqRuRaRwlkILtHIxHzqSvErUsB5o5J6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSjZT/rK; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4602e2a0372so647346f8f.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782295143; x=1782899943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYdLcwX5ZcT0Nvx80SMQN+5Ha2iiINESIZiPkUN1J0U=;
        b=CSjZT/rKNiMgw7bxKMZvNLdhz2qMv1f1flpPbdoBK5B4fv+Tp94kGQkZMh+CXGrDra
         9c5/pDqCjoGSokgOzwHHjGBL+wW5/QEwu5VY0pW9dq6rdu6dmPF3yi7CcAFjISpMs6dV
         v444WkurGk6Zg08bwKsmvfa5BxNhEH5szmw8B1nkSraQ19SFaYgO5pruwOdkb3EFZIB+
         YBVGgk79tzB2wmg8hwdzfx7oUJ7CG4ciPwVxrP90sPDfZtXoAeYv04U2+cA7n5azMU8N
         qo0IaruO0wmf8JQuYAgvHTOdpaCHphmb2Mxlvk5Xdw398WNsS5o05/JWLqMu/fggdsoV
         nAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782295143; x=1782899943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYdLcwX5ZcT0Nvx80SMQN+5Ha2iiINESIZiPkUN1J0U=;
        b=jpNA6FgKG6Mv4Cfnw2vW+4ouTd+pTTfqDAxnjhgP8zpy+DYFcUypAxnBg+TiCED4Xn
         MQgmhnCzAadLwploUF/QQ8+UnBEZAsjQOJYVAVSUabzQ3dXwD44M4VXWTfWIsWl5Wqqx
         Iqc9l7ZR/Xi6y8F5S4jps8FH9un7myY7BLoonkGlyqonW/wEpTg2eWyFDlgvAefr11JM
         qZUhp3FQF0UyB4pXDuLB1TGxj3jShQvgQ0g6OgR2TcNwinBJq9FHWlMjKryROJHzJlaE
         h377idBMYF5W/qRlLPG8AuM7ktRiIZ95Csn/M8+5J9tpjixjte+pBM0Cv284SkpwWcGo
         CXzw==
X-Forwarded-Encrypted: i=1; AFNElJ8Dn0XysE67aktn9ug4kPOaDtqPR/ZzyDK4iWiL9rijOOSUVHCSYKTRDo5g0ahNjiQC2K1f0Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfQqV3NuZS1/5m0Z+HU02iJfx9MzlOsL9fV5jy7HbCwoq5JCI
	vNPj5PPnYagW7x6Z5XuqGafYU2WOdKxokJO8Z3hXAgLNl9n2R1A64eiL
X-Gm-Gg: AfdE7cmwZbH3zj0AmfEp+tdd5dVIlXLXuNkVwcyORWBLFPKaFV40kjTwCnn9m89+KSX
	mYjEUYuLNI7ebKCeq2u6Ii5fVI+TD6MNYKeFLnYv1atmLZhBk4SedlKq96s8gcHFadqhU+aw1gg
	GBx754H1KrLvGKycM+4h4c5Pp1aRENEI7src+NsdDynGw66d9hBv58E852EzewIQMWX7DpxrwzE
	pnUzk4Qg3SxfJg8soPWxbjrTKNTKwKQTILfHZ8XHyruz6syVtBxe9QoLje1C+JXkFrGCDUtJIMe
	G/pGGjzPE4B4suREN5wMGrQfffzQd+eooRbdu0pi/NiZD6uzHn/eHWmGS0aGPk77KJHMQq0AJdV
	3a29QFsh+qmqciqm6lTic/oHL34Sqqpe9fvPgdyH+YoBs2c8Vfyjyzrq3/WrONu8i2T9+YxcT7I
	4WwT9dXYZuW45EvaBbUw+cQw85BqiYFYk8plTxmpVEHacglw+LIw==
X-Received: by 2002:a05:600c:870f:b0:492:3445:ecf8 with SMTP id 5b1f17b1804b1-4925b34a38amr94308615e9.3.1782295142647;
        Wed, 24 Jun 2026 02:59:02 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923914fsm370236405e9.6.2026.06.24.02.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:59:02 -0700 (PDT)
Date: Wed, 24 Jun 2026 11:59:00 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, edumazet@google.com, john.fastabend@gmail.com,
	jordan@jrife.io, kuba@kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	pabeni@redhat.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v8 3/7] bpf: add bpf_icmp_send kfunc
Message-ID: <ajuqZMzqACLOijoC@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-4-mahe.tardy@gmail.com>
 <DJGWWQQD3B0P.2O1D9MO17YRK4@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJGWWQQD3B0P.2O1D9MO17YRK4@etsalapatis.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 529AC6BD1FE

On Tue, Jun 23, 2026 at 10:09:20PM -0400, Emil Tsalapatis wrote:
> On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:

[...]

> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	case htons(ETH_P_IPV6):
> > +		if (type != ICMPV6_DEST_UNREACH)
> > +			return -EOPNOTSUPP;
> > +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> > +			return -EINVAL;
> > +
> > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > +		if (!nskb)
> > +			return -ENOMEM;
> > +
> > +		if (!pskb_network_may_pull(nskb, sizeof(struct ipv6hdr))) {
> 
> Minor nit, but this may also fail with SKB_DROP_REASON_NOMEM. Now this is only
> possible if the IP header is not in the linear space which may well be
> impossible (?), but do we want to differentiate with
> pskb_network_may_pull_reason()?

Indeed, I think for the IP header is should be fine, but I replaced it
with the reason variant. Thanks!
 
> > +			kfree_skb(nskb);
> > +			return -EBADMSG;
> > +		}
> > +

[...]

> >  static int __init bpf_kfunc_init(void)
> >  {
> >  	int ret;
> > @@ -12639,6 +12745,9 @@ static int __init bpf_kfunc_init(void)
> >  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> >  					       &bpf_kfunc_set_sock_addr);
> >  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_icmp_send);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_icmp_send);
> 
> Based on Sashiko's feedback, since we mostly care about cgroup_skb
> should we just make it exclusive to them and drop CLS_ACT?

This would indeed simplify this patchset, I could drop most of the
complication induced by tc ingress routing. But I think having both
cgroup_skb and tc support would be nice as a first implem. I'll try
again in a new version as I added a test for ingress tc and could
actually fix the routing based on sashiko's feedback (this also drop the
first two patches that were partially wrong).

> >  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
> >  }
> >  late_initcall(bpf_kfunc_init);
> > --
> > 2.34.1
> 

