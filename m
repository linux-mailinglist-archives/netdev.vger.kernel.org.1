Return-Path: <netdev+bounces-300359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OJXmASSwM2pUFAYAu9opvQ
	(envelope-from <netdev+bounces-300359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:45:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC08469E8F4
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:45:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rhOw7JoC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300359-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300359-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6FCB302F4B1
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620013B47FA;
	Thu, 18 Jun 2026 08:44:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128103AA182
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:44:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772293; cv=none; b=AmiuVNKO/pQ3eNs61mfCH+m9GNi5e7aa3Eo38//9e59Rxeq+81veFJ4fzBB0wcNE40QBTpDmXKDnJotROMokqYbWXwOH243pZSme+hUTB3wAugfeV91KplF7udNsZzbRc2DDh0fbTs4bLrZYI470Qi7IMUig7e8RpEOVATN20Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772293; c=relaxed/simple;
	bh=76A9PLA0Vo4uGvCdzH6m1R2rU33fdxsc/cfE8TrRFNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbEv+igvOXSh+KklT317nj+1cyZrRDKI8JpSerCbHo/TyK4mESP+fOq9JSn0jWOiOh9KLm28XpZQzObed3+3a9UeMkJJRByg9G2HPJ2FHmjpeOgF17xcLMCp7EZtsvYla9ybLPdYx20D2xkilpM97DzEMcTSVmqyYjO2ajXKLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhOw7JoC; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso4049145e9.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781772289; x=1782377089; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMZN9/XZRkM1cRtvf9YfI3LamYxCsoX5bvp0jYNhRA4=;
        b=rhOw7JoCdlFDxr43Ajxcrwuh2Rhd4S4I1Ll+1dn5dvfztv3CjTkcREYGKCcydkrIIp
         PgqgXXK1hSY6T07tW0y3prQJ7MzigP8P1EHEsu05I14uQXBCNPwCpws3IXIuo5wjMF7U
         CUAlZ8pK9h1iOh97bGCr/gOKxVhjgKgRA9a5gZdo5NJ/oLXEOHBly+GNq0SetASHCTgQ
         /QeWH4vajVClpYpm4owzidy+Y+tVeNZ/f35EBOX5+CRFZ5ZSScIjXw+/5hzeomOh8kWr
         YNKc1OOYLaEnQCAK4ZKdEnxGsH+jug+dk+uYpYCuCSiMgeA0r9Ua2mRJ+FSnjV5WEIOk
         quJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772289; x=1782377089;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMZN9/XZRkM1cRtvf9YfI3LamYxCsoX5bvp0jYNhRA4=;
        b=CZQHt7rBn3WDw+tQ+B52ZD/QiJRPfCNz9YFprMMUYOkTnPkl3AzhT6ZQknS7iXza6h
         wvKPkSbbaTLWLxmE2PUSyg+lD0FnYhdFrbNlk92L4K7Yb8IEqUlW08Ywz6ZrVsber6vD
         V8IymKwCUTnypneum+yfDRQ+2xia/FMBdgL9KpG+CJ1jP1nRplDR8ROJ+pwK4Bya3Ho2
         hKIflP47mOJFI80FYaa44I1owWJ1L3LRmntOECof4DhV+qvslYTthCKg8cLV9+ZWuiQN
         5uWlNcFvjvmReeGsqop2WmhDu9YBA3FZXKL7CT8KjZf5Y0vUZuKpX1CMB+RdJQJ77q1E
         BUYw==
X-Forwarded-Encrypted: i=1; AFNElJ+aNSYO6wPKbdKv6MIvlixIVgT7hQfHt5P3Jh4a3j08hTcufRS+LV4c2UbFOJPbw8ghdsVzspc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydlJEiD1xikzHtjdTcXknmwRoCT81mKuQOxJBnbiRI5TI04WF2
	fGGqapXG5ZmDqaJgtYpFH6O4z0seTzNM3ke13U1ZDuSNOP1M5bR21WJr
X-Gm-Gg: Acq92OHhlrQ+as8cizal70uGYdPRfPGSTizfEwpnVsESSjTccppOwzrkA6LDENltl5a
	rbGRiGGiYAfwIaqc993cEf1ZvSG1sFX7f3ffoPmGzme488Wn/X7tHRrSoLlF9KBGPW1gHwgVB3s
	REH0IaLLcuXm4dNAWkekBo0xjSdasdGbtv8Yx7GDwbVOc6RbG6sF6beLmC4tHL1QVT8CTdfxDLT
	NNNG286V+UkFsLt8OyawsMWH6gLHrGaNVw3HzyuB86iIA3JRzZJ3G4XwbLPk3aS2XWYBeJxEA9C
	1vQpDpb3y1728RRlhkCm90K0AgeX3jzr/j3sU3cukoRANkBkiTZRNHvBZKQLa4CDO6rNkSNL/Au
	Su6J8dMB12Sqk85MdjtQhLlrhB2gLzdcjF4XWl4y1m/D+THzeZ4gVrXxDKUYCbhb0aQy1o0vSDY
	KKps94RrJYyVSdWhWmMRnjB/7B7gIKjWyhL679cWqlxN1S/ogLTiJvbfNMf2PHP7dPtORZZWuzK
	vtaDAkaXKS7/IcwgX8KiNqeZ9u+UWye/FEW0IyN0yQMVxlMT2EdOLUTBSWHGHab/cg8wbMcjcDY
	G7UQqI0jg1WCNj0I4x3wpgUTiL4GWFt/
X-Received: by 2002:a05:600c:350a:b0:492:1e36:1fe9 with SMTP id 5b1f17b1804b1-49233430b8amr112747915e9.37.1781772289262;
        Thu, 18 Jun 2026 01:44:49 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006e99796483dfbc0d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6e99:7964:83df:bc0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa96f0esm255321905e9.12.2026.06.18.01.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:44:48 -0700 (PDT)
Date: Thu, 18 Jun 2026 10:44:46 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
Message-ID: <ajOv_oOd1zInaW1b@mail.gmail.com>
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
 <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
 <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300359-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:sunjiankdev@gmail.com,m:bot@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,meta.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernelnewbies.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC08469E8F4

On Wed, Jun 17, 2026 at 10:19:52PM +0800, sun jian wrote:
> On Wed, Jun 17, 2026 at 6:31 PM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > index 01f1d1b6715a..9cc898e6a9f7 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > @@ -4,6 +4,10 @@
> > >
> > >  #include "test_pkt_access.skel.h"
> > >
> > > +#define NONLINEAR_PKT_LEN 9000
> > > +#define NONLINEAR_LINEAR_DATA_LEN 64
> > > +#define SHORT_OUT_LEN 100
> > > +
> >
> > [ ... ]
> >
> > > @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
> > >             "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
> > >  }
> > >
> > > +static void init_pkt(__u8 *pkt, size_t len)
> > > +{
> > > +     size_t i;
> > > +
> > > +     for (i = 0; i < len; i++)
> > > +             pkt[i] = i & 0xff;
> > > +}
> >
> > A question was raised on v2 about whether pkt_v4 could be reused by
> > reducing the linear area to ETH_HLEN, rather than introducing a custom
> > init_pkt() with a 9000-byte stack packet.
> >
> > Can't we reuse pkt_v4 here by reducing the linear area to ETH_HLEN?
> > The v3 still adds init_pkt() and the NONLINEAR_PKT_LEN packet, so this
> > doesn't seem to have been picked up.
> >
> > > +
> > > +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *skel)
> > > +{
> > > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > > +     __u8 out[SHORT_OUT_LEN];
> > > +     struct __sk_buff skb = {};
> > > +     int prog_fd, err;
> > > +
> > > +     init_pkt(pkt, sizeof(pkt));
> > > +
> > > +     skb.data_end = NONLINEAR_LINEAR_DATA_LEN;
> > > +
> > > +     topts.data_in = pkt;
> > > +     topts.data_size_in = sizeof(pkt);
> > > +     topts.data_out = out;
> > > +     topts.data_size_out = sizeof(out);
> > > +     topts.ctx_in = &skb;
> > > +     topts.ctx_size_in = sizeof(skb);
> > > +
> > > +     prog_fd = bpf_program__fd(skel->progs.tc_pass_prog);
> >
> > [ ... ]
> >
> > > diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > index bce7173152c6..cd284401eebd 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
> > >
> > >       return TC_ACT_UNSPEC;
> > >  }
> > > +
> > > +SEC("tc")
> > > +int tc_pass_prog(struct __sk_buff *skb)
> > > +{
> > > +     return TC_ACT_OK;
> > > +}
> > > +
> > > +SEC("xdp.frags")
> > > +int xdp_frags_pass_prog(struct xdp_md *ctx)
> > > +{
> > > +     return XDP_PASS;
> > > +}
> >
> > A related suggestion on v2 was that, once pkt_v4 is reused, the existing
> > BPF program could be reused instead of adding new pass-through programs.
> >
> > Could tc_pass_prog and xdp_frags_pass_prog be dropped in favour of the
> > existing program? The v3 still adds both of these, so this point also
> > seems to be open.
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27680511802
> 
> Hi,
> 
> Thanks for checking this.

Hi Sun Jian,

It would help if you could reply inline instead of at the end of the
messages, especially when there are multiple comments. See [1] for an
explanation of how that works.

1: https://kernelnewbies.org/FirstKernelPatch#Responding_inline

> 
> I tried reusing pkt_v4 and the existing TC program, but they do not fit
> the skb case this test is trying to cover.
> 
> For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in the
> linear area are rejected before bpf_test_finish(). With pkt_v4 and a
> linear area of ETH_HLEN, the test fails with -EINVAL before reaching the
> partial copy-out path. If the linear area is increased enough to pass the
> IPv4 check, pkt_v4 is too small to both trigger the old
> copy_size - frag_size path and verify that the copied prefix spans the
> linear data and the first fragment. pkt_v6 has the same issue: after
> making the IPv6 header linear, only 20 bytes remain in frags.
> 
> The existing test_pkt_access program has its own packet-access coverage
> goals and is not just a pass-through carrier. With such a short linear
> area or small packet fixture, it can fail before the test hits the
> bpf_test_finish()'s partial copy-out path. A pass-through TC program is
> therefore a better fit, because it keeps the test focused on the
> bpf_test_finish() copy-out semantics.

If we're keeping tc_pass_prog() then can't we use pkt_v4 and get rid of
init_pkt?

> 
> For XDP, this object does not have an existing xdp.frags pass-through
> program, so the small XDP frags program is needed to cover the other
> caller of the shared bpf_test_finish() path.
> 
> Thanks,
> Sun Jian

