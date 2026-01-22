Return-Path: <netdev+bounces-252420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECuCBpVRcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:34:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D6A6A0B6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42C7D30010CC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91C037AA80;
	Thu, 22 Jan 2026 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHP6BJ2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD93783A7
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097417; cv=pass; b=BLzlP7TSo2yWUvdIqqIJdhxKcOu8/n2VInBmjUoEo9hz2yLcU5o5UhtlNagR0Yjs84z8wbZ6Fje19j9UMaYLu0SLOa1ZnT9R0uCByzLrOKFFGfIl8xrpA4MOiAHdRuk0qctnYRaHp2skhPbZvq61knm4/WGCdJpbvr7Qw8bb9d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097417; c=relaxed/simple;
	bh=n0OYYqCb/69rbtHUI9UzlbCmsgYVrgX2TPDNqfiCr4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tI98mmHR4yF//ZTakC2+G4OJpca3XWlDeyibxLBs5ruIpxk5LoDNCDtQKgkp01+avw/8iiCjpnqHOvGCB/N2/wWDfcNdMnorrMONVEHQSOhUmQv4b9MiY1Dz7sLP0tRp6nrFSCnvEVRVd34Ax3/+gu6PoqNxwe7OMLIKgKq3L14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHP6BJ2o; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014b671367so11804281cf.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:56:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769097405; cv=none;
        d=google.com; s=arc-20240605;
        b=k+4iD88MwyNOIB4GXwmTzxXf+ZG6+vKL+AWvJuVTj1P5cwd9dboNVSR8qtuaJxVHnj
         AujqpO7WUWhf6rirgpPWVqC9SL5B68RJMv/CgdDfCtRlGnqYHNL2sW9MrkwcjBWYu8CB
         GWl8at9BSZtVq6EP8xLwu5A6ZjXM7GMGzrzPWgDtwMU91xdtSd0CRNJtkDKB4k2gJLKm
         dLwCz7JY560qaIxbpmmCB+4oDMeEH0rWS4EFI83ymul/w4gACGB6cLbQjBc9cQS6YTu7
         4S8X7o6TJwhaDEdzqSXEPubihv0hDKn73vOEdpDAnnB/HWfG/ZSEeckua6/1MtteFntY
         UTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n0OYYqCb/69rbtHUI9UzlbCmsgYVrgX2TPDNqfiCr4A=;
        fh=3Rk5QNjezc4mX5WbylVOe50dx4lNaBmVPjoqE/ClL78=;
        b=NINl+k9AFEPsKEZ5RBLeMHNzek1QdV8rbQ8eC+WmXS/uY/e8/+h7s8H4V8MqJ5Etox
         kcFSeoRBQ5w9HdOhbrvSn2tf2rzVAr40rP2raPgCFAihvYs/47iSx1rueoe2Pni144wC
         c7T6mW0pug3n+nm+FMsngaJ8jVa+coPhAmfj6NZxQ+we0vseHRQD2GTHQAENn/13FaPk
         mEdg6QZWfO4EecrQTO2tzdHZi5XmxD54EtxZ0vgmUKJ9Nc4+53B8becqJ8IACEQivfl9
         Ko9IfRqm9FSUiilSTb1zQyx9XNImduxCSQwuqsaDtqMiZxXWhjS7psPLT3ZUU0xOtSas
         rdlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769097405; x=1769702205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0OYYqCb/69rbtHUI9UzlbCmsgYVrgX2TPDNqfiCr4A=;
        b=PHP6BJ2o/4ZrCfyzqgzs6v8O7xjufM0bw9oAKPNZewc7EC6Yo7mWoTpgjG9BCTrUfU
         cMvPUjyJuFJNRPpToILmWA9ilO7aHfa0rlTymTQ/1Us4ln4h8HY8f4UgbArmZX1G59Y3
         fGOUBqZeZyBgRjcaNLa/QRuafkG2KtFo9pGJkdDUKakyv2kVgi2o2mUirfq6/MJuYjut
         lyjjWacDVFg8SC/fNW/ebhV8bONCkHr4zFqrLFdDAfLOC7GRe+2eOAwNH61h87NsftVz
         BWGB4iZAFpMdcwEd3yjSDXD0IHjuss5Htfutw1LAl3YIginjbUlQsm1PuvuY8NOAdQfx
         m2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097405; x=1769702205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n0OYYqCb/69rbtHUI9UzlbCmsgYVrgX2TPDNqfiCr4A=;
        b=GodrcdLkMQYNJdq/tO+Ccx/uKa84AiLYqmz23HvXhwObNq7BP7njYW5XR2QAY/KGYp
         d7l7gAEyr7h9vdiuwuN+Mx6f+zQHxnK8tzVpzPz0CJsijeG3OelTabrHO1gKoV39Uk+v
         Km1wP5EWg7GAmLqSoMUjYLlvEtdUWoFm6sec/syvG+OZDfNozR7rBYY2wiAQCWSVVKt3
         6R8JsGx8K7y7a3RDpzbCrCkUfOlVfLAIi7hguiDmEJ6cR6BIuH/YVdNNOWJzRS8sfg7H
         XrdLlEZ9gPwHZpNk4hWw6QMvYsqvkO4x5guIg9Q50cf0+Q2YBPFPCHuCJjPC9kiuE2/O
         a08A==
X-Gm-Message-State: AOJu0YyOOJnRCMo/pEkrMiQpSJiNWFlBBz8SGkQ0ryXqH1Kk8/ouVdvN
	VAwr8nwdEX884KIYYPjA2YRsfg0+WezrQapb57U3H9umcbCKeeQp9rqzsqZZ6fN3/nB4HiC8gz7
	hz0/NcmLxrphN/F6KR+1VoV6ldy6aEbsfNLmAeY72
X-Gm-Gg: AZuq6aLsWAWxSJSop1pbo3kkYPwQH8mvHXu60tm3lAdJmBIeLNUDURVyQ1UJLc6bgne
	Ug1cuqcaK9V+mxadllDiAVJmmRk/wjc9wCanr802Phb5Ud2ngyXIfavs4llGq75Q1ExcHrY+NmO
	yLmzLLB4CSKbYlrqwdaTyWwasio5BNa+vkl/XbUa3Zjf/TLnBJ5Q8KP/BHdSOw/UvHbOr4uvgmx
	uKjukNeWqhZvFUck1oAwp8RwBGzBixxHZ2rOVfeI+NDcrDZCuNYj3GoBJy8UAZOtC8sQxzY
X-Received: by 2002:a05:622a:1787:b0:4ff:c144:a45 with SMTP id
 d75a77b69052e-502f772502dmr67771cf.1.1769097404668; Thu, 22 Jan 2026 07:56:44
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120152856.1694824-1-edumazet@google.com> <20260122022237.2529455-1-kuba@kernel.org>
 <CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com>
 <20260122072858.2b652eb7@kernel.org> <CANn89i+0kJ5M1_6NPxbe4k5eY4sPwNeKN0yKyaHzFhZDT9-=kQ@mail.gmail.com>
In-Reply-To: <CANn89i+0kJ5M1_6NPxbe4k5eY4sPwNeKN0yKyaHzFhZDT9-=kQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 16:56:33 +0100
X-Gm-Features: AZwV_Qh4lEzbdmpVQODQdrsUddnRHGGdNfzwNL_xD8vJ_R8kviPZAbBrkglDPbo
Message-ID: <CANn89i+7H32ODq3=nEfoORTR+6FiO2mOWRcLFf-K=+4UQcOmig@mail.gmail.com>
Subject: Re: [net] bonding: annotate data-races around slave->last_rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, syzkaller@googlegroups.com, andy@greyhouse.net, 
	eric.dumazet@gmail.com, pabeni@redhat.com, j.vosburgh@gmail.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252420-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,greyhouse.net,gmail.com,redhat.com,davemloft.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6D6A6A0B6
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 4:50=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jan 22, 2026 at 4:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 22 Jan 2026 05:42:55 +0100 Eric Dumazet wrote:
> > > > This seems like the same concurrent access pattern that the ARP IPv=
4 path
> > > > needed fixing for.
> > >
> > > I saw this spot, but determined this was used at setup time, not in
> > > packet processing.
> > >
> > > I was maybe wrong.
> >
> > I guess if nothing else we should do it for consistency?
>
> To be clear, I will cook a V2 with this part.
>

_bond_options_ns_ip6_target_set() probably needs a fix as well.

Is AI review stopping at the first error ?

