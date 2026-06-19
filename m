Return-Path: <netdev+bounces-300659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6JHkJqUHNWrTmAYAu9opvQ
	(envelope-from <netdev+bounces-300659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6B6A4E02
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:11:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PFwqJugu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300659-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300659-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB713302AD22
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438663612F4;
	Fri, 19 Jun 2026 09:08:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80F35F5E1
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:08:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860129; cv=pass; b=BQEWuxtz48aWEKSUImx0T0hwoHoXg2WKt8I0LIMU4x2eJpbCN41DYHiKdJAdyW8DdWQMNXa3G+y7iIGctzvgmzwcfhud0Sodr+MeeLWbLUPqZLXdd0ARS+1LVazm3+zuTXWvjrNlROWElKgwmkbxdEbRwluk+v+Tlrfmvf0aQzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860129; c=relaxed/simple;
	bh=T/K5UlzDllbLEYYLehMYSn+//Xryze9YYv1LULQa/mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRGXO51BERFoWb+7ZOf1yHUy8kCq6UFhS/EDpnQzN/TB4Uyp5wBvhO+EA0O8DZPlKnup/M7lrVuOq2HBBPQ5fNNBkZ1X0nMbKOT97mC3Fyi6XK0ZEfesR5Bw59wNbFEWpG4Pr96HEPEkPCo5WXsDlTdGdiGD7VixJo76zVd5aI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFwqJugu; arc=pass smtp.client-ip=209.85.128.178
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dbcb505578so21879207b3.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781860126; cv=none;
        d=google.com; s=arc-20240605;
        b=bR8I05ihNHzBJyPLjjucCNsj8gC/PqSJL4FGYAomRajgnTULHWLlK5n4TxdFUI0Awd
         v2xIaIvdbRKW/p332ZF8LnNap2BHgy4M8T1tlMPq2eA5liTJ8cy9BzdP2L4bblzdEUQZ
         Abmmp24Gf6pFAb5lCfgaky3YmD1M66QhbMlHaBQXc5CwnRYlYkSPP8r1cAyrpw+9oELn
         x8jve0OnVvGZs6e6Z3Ef6subIET4Rc0g7hsDs+kgQn7JCLEMLFIed1JaMxPbxazbaD3G
         VwDaILnQvrpfw/Z98grB89qgumXnAvCsbtIFqOa6ad+phNaFJPEazXWWntcfTctNNwsX
         2GEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T/K5UlzDllbLEYYLehMYSn+//Xryze9YYv1LULQa/mM=;
        fh=p2jlLVuvXxQXo4i7c93IjwEqT8NqyuvMgd4kecpjUhs=;
        b=VGTjmYKYd34+5cwb6RgSAENhpBWDSX8H7RzwMn0qNkn1hbigP73uwwQSqWIHPdIU6Q
         UK60GeRB88H4Xw2fY73CnJzuabsn/yH0UmH56kS0QlDalpOyLWzBiWSbghP4tJj1r3M9
         UFnaOA1MeCp4wj9/lwwufRrAWcfeU0e5r2meseYaAXiY25OvLa/6DaQyaNtC05Xung11
         p4XKr/YvdXi4GE5/8EN/pSzqHH2U7zTrRVWQTj4sV4EeW4JE/AWWVOt7WMOH+B3LrK8/
         Lwzv2P+l2M+cPn4XXJ/P+Mjcaz3ClxpcfX5MAU5TH9lm/d5BoGiII3jYt4eTkH1uKnB1
         /p9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781860126; x=1782464926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/K5UlzDllbLEYYLehMYSn+//Xryze9YYv1LULQa/mM=;
        b=PFwqJuguw/X0MUQPzdQpu5Du8dVYZP2egHhfyM2XKAgtuc0MJzeJiwUKuXM3+wzlYR
         3J7u8mlJBTUJ3gjoMCJwiMfoFBuVJyJVne7+yteAB/vBGxhPYroC2GigPQKHMtRhbO32
         PMR2qW2I3UaD3n0/PNiWivNArf6goAbIF5t2w1i4Lxw3VPqJMB9CT7qSOzPdNfOKUVuS
         28UUmHOI12RmR1XgOopLs/Aupz+GAEspuWALWsVQcmL2OEYpGjrd4pKjGFdFumU5g02L
         GthAIqLH5KQ4ILMJ/gOsiu1Lap5eqBY2HVEbGTCmfZTddKw/KsJsNPJTL0wY4TG1Z8Bk
         Rhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781860126; x=1782464926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/K5UlzDllbLEYYLehMYSn+//Xryze9YYv1LULQa/mM=;
        b=qDx9/zrssNIfS3c6pzsRMsRQQNV1AsZr8psgiUtlxiHn3dD8/TQEweZp1MRcNtNVKJ
         IV/raqXG5SvLenW9XRaIkwe98kCd+QIDFrMwAFWceqOHb/c38m7uFYVKhOGEvp2AyqMz
         EdXRsRNT+j+L0U/LXLjSykoHMT052kD3Gz3zuGPnJFAf+or/SoD4R5B9796Gt8muk6xO
         PkwfkGtco8KgAPO8mVaA/fKb++fjCA+ZNKRfOl6civcIAu0W1UTaVQeTLcFbp0coxTnw
         mkg3jqzQAowm7+XbrGA73P95WaEWzcj4IpdSmTbbM7s+UyAV8ML0ZwK0WaHypkNyTdYO
         8KFw==
X-Forwarded-Encrypted: i=1; AFNElJ9Db9BmfWsn69EiET2TbJiR4uMkCnxBEXRaOVkEoX7A0TxAu24QuL95faiFEDTxjuHZtu45IkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2tOp1ZCO3HRxM+6fAV4tltqUUNG1yJqUpldO1C8uVHAwnqMF
	enDQR3Jw8D/+83RSt67TveMv1ES6EHrjP8IvZJ1p+h052417Bbw1khKefyNYxSHJq68VuLrObvH
	wZdqJtpMx0u438GGgpnRmgw7nk6b48TM=
X-Gm-Gg: AfdE7cn4CXXjKysdYI3ZJFnw1IujsEA7APcql6+BGQAdO2IqfgGojBcdBI7tUFcHsLM
	OUtRqUjzsfiSk7zybieKG5YWfVxmglUSNlu2KjZ2UvhzqxPWqeGQlaJQZO9xSDkEpI5koWq0jUo
	IH/4pQpNzYMhpLlS7cMl5RONh2dUw7JT4eH5q7yzidmRLi2n1TD5uQqOhknLrkFBWGR1NxfBcFM
	a01W7P0xxZHRlFmQqLqt7P1HrIVmV1sCcUqQ7jGPgKys2zyCuCEa3iSpqTNriY3KBzew4NihZiD
	9hAxzyRN80n4Xec0JqPZp6FOc1QQj8uwumCvEkGx
X-Received: by 2002:a05:690c:3705:b0:7dc:ca63:b0 with SMTP id
 00721157ae682-80132d3838dmr20841087b3.40.1781860126104; Fri, 19 Jun 2026
 02:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
 <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
 <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>
 <ajOv_oOd1zInaW1b@mail.gmail.com> <CABFUUZHCr=4kb7kSaaPGpc4nkyn32i-svD9v7ONF+TYrrQ-xaQ@mail.gmail.com>
 <ajT3x2H0swzg4yhm@mail.gmail.com>
In-Reply-To: <ajT3x2H0swzg4yhm@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 19 Jun 2026 17:08:35 +0800
X-Gm-Features: AVVi8CcmPEP5XdoxB6X1yoIuhlHbMlAQ1h-E7WonW2hkMbAK-HKHfU53WVaNd10
Message-ID: <CABFUUZE6uZDjaxa-ss9CYhjNTCt2Z_ND1S6-nGvCLg7hDLTEQg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	lorenzo@kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:paul.chaignon@gmail.com,m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:paulchaignon@gmail.com,m:bot@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300659-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,meta.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EA6B6A4E02

On Fri, Jun 19, 2026 at 4:03=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Thu, Jun 18, 2026 at 06:45:18PM +0800, sun jian wrote:
> > On Thu, Jun 18, 2026 at 4:44=E2=80=AFPM Paul Chaignon <paul.chaignon@gm=
ail.com> wrote:
> > >
> > > On Wed, Jun 17, 2026 at 10:19:52PM +0800, sun jian wrote:
> > > > On Wed, Jun 17, 2026 at 6:31=E2=80=AFPM <bot+bpf-ci@kernel.org> wro=
te:
>
> [...]
>
> > > > I tried reusing pkt_v4 and the existing TC program, but they do not=
 fit
> > > > the skb case this test is trying to cover.
> > > >
> > > > For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in th=
e
> > > > linear area are rejected before bpf_test_finish(). With pkt_v4 and =
a
> > > > linear area of ETH_HLEN, the test fails with -EINVAL before reachin=
g the
> > > > partial copy-out path. If the linear area is increased enough to pa=
ss the
> > > > IPv4 check, pkt_v4 is too small to both trigger the old
> > > > copy_size - frag_size path and verify that the copied prefix spans =
the
> > > > linear data and the first fragment. pkt_v6 has the same issue: afte=
r
> > > > making the IPv6 header linear, only 20 bytes remain in frags.
> > > >
> > > > The existing test_pkt_access program has its own packet-access cove=
rage
> > > > goals and is not just a pass-through carrier. With such a short lin=
ear
> > > > area or small packet fixture, it can fail before the test hits the
> > > > bpf_test_finish()'s partial copy-out path. A pass-through TC progra=
m is
> > > > therefore a better fit, because it keeps the test focused on the
> > > > bpf_test_finish() copy-out semantics.
> > >
> > > If we're keeping tc_pass_prog() then can't we use pkt_v4 and get rid =
of
> > > init_pkt?
> > >
> >
> > pkt_v4 is too small to construct a meaningful nonlinear skb with a stab=
le
> > linear/frag split while still exercising the partial copy-out boundary =
in
> > bpf_test_finish().
> >
> > With pkt_v4, we either do not reach a fragmented layout, or lose contro=
l over
> > the linear/frag boundary needed to exercise the regression path.
>
> I think I'm missing something. Why can't we use pkt_v4 with
> tc_pass_prog() and a linear area of ETH_HLEN? That would leave 42 bytes
> of non-linear area, so a SHORT_OUT_LEN of 30 should work to trigger the
> bug, no?
>

I should have made that part clearer. With a linear area of ETH_HLEN, the
skb test_run path fails before reaching bpf_test_finish(). After
eth_type_trans(), skb->data is advanced past the Ethernet header, so the
remaining linear L3 area is 0. The short IPv4 input check then rejects the
packet with -EINVAL.

To pass that check with pkt_v4, the linear area has to include the IPv4
header as well, i.e. ETH_HLEN + sizeof(struct iphdr). That leaves only abou=
t
20 bytes in frags, so a SHORT_OUT_LEN of 30 no longer triggers the old
copy_size - frag_size < 0 path.

> >
> > This test uses a 9000B packet so it does not depend on small-packet
> > allocation details. Smaller packets might work depending on allocation
> > state, but 9000B reliably gives us a non-linear skb with page frags and=
 a
> > stable linear/frag boundary for the copy-out regression.
> >
> > init_pkt() is needed to ensure deterministic byte content across both l=
inear
> > and fragmented regions so that the memcmp-based validation is stable.
> >
> > Thanks,
> > Sun Jian
> >
> >
> > > >
> > > > For XDP, this object does not have an existing xdp.frags pass-throu=
gh
> > > > program, so the small XDP frags program is needed to cover the othe=
r
> > > > caller of the shared bpf_test_finish() path.
> > > >
> > > > Thanks,
> > > > Sun Jian

