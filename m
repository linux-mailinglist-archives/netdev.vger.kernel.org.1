Return-Path: <netdev+bounces-210410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C133B13273
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 01:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF64C3B70DE
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5CD23F405;
	Sun, 27 Jul 2025 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="DQgGntlg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FC1C6FF6
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753657405; cv=none; b=FM3xafFLTLxv6rYv4J63nYW1raQP7QOPtPsjijmKPBVERkbUzXQUcoD2psvNBSYh4FhyDWmD0sfylC6JEtwX41ZAPhP6bXQlN55d2eY2WR8tlPSyFoRryEIu0JJrtMRGgiBQCpnMziq7acgNZAh2EP9cw3CDjk98LjPUK3VvEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753657405; c=relaxed/simple;
	bh=gi7SyZSq1IEFRpNo6BorGB0DfHaIq42vs6SAA09k97w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmdvaQfzC97s9ZwWtrJ+n248IcTrF0jh0cmeB4TkV2rXybRn6cxAgqSCujrC7u/CW/xeQaqEg1UXZsF87C59hNd77hdjdDxkWnpFR8R/fY8jBkxy98Q2YAkYIkEzDCjvgkIIxZriIl2J+Sz6r/ddnTveoVOqWm/7p+MhRhXNIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=DQgGntlg; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1753657394; x=1753916594;
	bh=gi7SyZSq1IEFRpNo6BorGB0DfHaIq42vs6SAA09k97w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DQgGntlgCdIw+GxiFOrXIReR56F5k3WeCpqxVsOpa/OcBeKW49GPQuqu03OhSYIsv
	 fgnhBZZAFSAcH8D5ksdGIS9ciUc/nhqMDKHCzMEt167+dU0+CoIDzRHSuVCCwy/T7K
	 uOcNkDECj07ZrtJ7jF9FKcBhVBosgIzfYskYIOoAp5QJwXrKXRVabPbPXiYrnMl765
	 ndB/dRrInfpjUacbXbYeSsheACTwCz4WFGRTmuGfNSV23SmAFrm7hygwz3n+L3nGHR
	 CuSQf3fxhPG+nLPDSLQkkjbWvK9ydYf0Adze/ulzCak9yl+Cj3Vn7AwTypRcH1Qk2F
	 HfPFm4men2iNw==
Date: Sun, 27 Jul 2025 23:03:11 +0000
To: Victor Nogueira <victor@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io
Subject: Re: [PATCH net v3 2/2] selftests/tc-testing: Check backlog stats in gso_skb case
Message-ID: <eJjkeB42Nf7tzAJvIyM89SCEMP7FEZtZ6cp0LC0k-P2Ok4Io0UooUAwPMGqlZ0qa-IgYUe9Wpb1X2vJzKChin9r7CKVMo9LjrTXfbo5HDy0=@willsroot.io>
In-Reply-To: <23059ce6-54b9-4788-bde5-013a6781e57f@mojatatu.com>
References: <20250726234901.106808-1-will@willsroot.io> <20250726234936.106930-1-will@willsroot.io> <23059ce6-54b9-4788-bde5-013a6781e57f@mojatatu.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 659de2f698819cf45f502123081cd94047b9032b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, July 27th, 2025 at 2:17 PM, Victor Nogueira <victor@mojatatu.com=
> wrote:

>=20
>=20
> On 7/26/25 20:50, William Liu wrote:
>=20
> > Add tests to ensure proper backlog accounting in hhf, codel, pie, fq,
> > fq_pie, and fq_codel qdiscs. For hhf, codel, and pie, we check for
> > the correct packet count and packet size. For fq, fq_pie, and fq_codel,
> > we check to make sure the backlog statistics do not underflow in tbf
> > after removing those qdiscs, which was an original bug symptom.
> >=20
> > Signed-off-by: William Liu will@willsroot.io
> > Reviewed-by: Savino Dicanosa savy@syst3mfailure.io
> > ---
> > v2 -> v3:
> > - Simplify ping command in test cases
> > ---
> > .../tc-testing/tc-tests/infra/qdiscs.json | 195 ++++++++++++++++++
> > 1 file changed, 195 insertions(+)
>=20
>=20
> It seems like some test cases broke in this new iteration:
>=20
> # not ok 670 34c0 - Test TBF with HHF Backlog Accounting in gso_skb case
> # Could not match regex pattern. Verify command output:
> # qdisc tbf 1: root refcnt 2 rate 8bit burst 100b lat 0us
> # Sent 98 bytes 1 pkt (dropped 0, overlimits 1 requeues 0)
> # backlog 98b 1p requeues 0
> # qdisc hhf 2: parent 1:1 limit 1p quantum 1514b hh_limit 2048
> reset_timeout 40ms admit_bytes 128Kb evict_timeout 1s non_hh_weight 2
> # Sent 196 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
> # backlog 98b 1p requeues 0
> # drop_overlimit 0 hh_overlimit 0 tot_hh 0 cur_hh 0
> #
> # not ok 671 fd68 - Test TBF with CODEL Backlog Accounting in gso_skb
> case# not ok 671 fd68 - Test TBF with CODEL Backlog Accounting in
> gso_skb case
> # Could not match regex pattern. Verify command output:
> # qdisc tbf 1: root refcnt 2 rate 8bit burst 100b lat 0us
> # Sent 98 bytes 1 pkt (dropped 0, overlimits 1 requeues 0)
> # backlog 98b 1p requeues 0
> # qdisc codel 2: parent 1:1 limit 1p target 5ms interval 100ms
> # Sent 196 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
> # backlog 98b 1p requeues 0
> # count 0 lastcount 0 ldelay 1us drop_next 0us
> # maxpacket 98 ecn_mark 0 drop_overlimit 0
> #
> # not ok 672 514e - Test TBF with PIE Backlog Accounting in gso_skb
> case# not ok 672 514e - Test TBF with PIE Backlog Accounting in gso_skb c=
ase
> # Could not match regex pattern. Verify command output:
> # qdisc tbf 1: root refcnt 2 rate 8bit burst 100b lat 0us
> # Sent 98 bytes 1 pkt (dropped 0, overlimits 1 requeues 0)
> # backlog 98b 1p requeues 0
> # qdisc pie 2: parent 1:1 limit 1p target 15ms tupdate 15ms alpha 2 beta =
20
> # Sent 196 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
> # backlog 98b 1p requeues 0
> # prob 0 delay 0us
> # pkts_in 2 overlimit 0 dropped 0 maxq 0 ecn_mark 0
>=20
> cheers,
> Victor

Hmm, that's strange. Those tests run fine on my machine, but it seems like =
the ping packet sizes are different (1 packet for me is 70b)? But running i=
t manually gets me 98b too...

I will just make these tests follow the same pattern as the tests I added f=
or fq, fq_pie, and fq_codel in this case.

