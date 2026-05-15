Return-Path: <netdev+bounces-288422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILhjMutoB2qZ2AIAu9opvQ
	(envelope-from <netdev+bounces-288422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:41:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF3D5566A6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF8AE3009FB9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F122B3FDC0F;
	Fri, 15 May 2026 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XghzgMbW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B23FF1B5
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870293; cv=none; b=JCFEziS8kATcVFlmwWI8R/Wjn3uE92JcVHI4YFSl+SlfcgFo0+WOpWOdx1DmyjUE+WFw+yT60oYoeO+9IOcY33naps4I2Q1w3NgiLIOa5QXkAnZciOkOFj/I7Ay6ckhKItnb1fKCl4ftjtzZFYuz+k9tMxzYIzlsdLO5WXcDMNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870293; c=relaxed/simple;
	bh=k5VW4oDrG/O1uIaSctnLaAkhDnEI15xDK9kkrZgNuXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lt7OK/gKwzNQd0FTpVaWypGT6FZXaPd12fIt7Jjk0Ce5EPSaCDqeVqjOg7dLVuzd6X0664nRoo32Y3N8EnmTSzfgHd2Pg1Yx9hp+KdlFjFH5JAJHgSqOVXZ803pfY61B25/Ls0fRPAj+E0ddei5BLassazOTpID9pZ5IY//WMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XghzgMbW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso874205e9.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778870287; x=1779475087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5VW4oDrG/O1uIaSctnLaAkhDnEI15xDK9kkrZgNuXU=;
        b=XghzgMbWSQOxk32wfrd99kf1tXI3HumLCinzWmEWtLVzIFjPIhNSNIq4kDC4tTL2YE
         ojQegKItxinfFAiCTz+geqaOJ0Vf19NMskIjxE8uKTBu3pip19EVqp5E3u9bJy3WqZ8k
         CO9tbRQmXYzStZm2kmfkBEqPgnJemreJU/W+YitqMI7WMMO6KckgR1avTXPfEXC39Cum
         T+/2xSH1EynZHsh3N09H/g819AfiiA2U4aZ8Rr7iU1zb4I647UxITthgmwtuVL4c/LST
         9D4rUCokKH3jGLH5WhD3GjlPjooncqa3QimOXxDBedZQjIYilKHShbuLzOvMBLlVJenf
         o91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778870287; x=1779475087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k5VW4oDrG/O1uIaSctnLaAkhDnEI15xDK9kkrZgNuXU=;
        b=Ric4BSFEe2hf7/uDFbfHn+her1LQF34HfVqtzTF6Yzk58vMEc2zF34wtwt+sXPQ8Jp
         T2ZTP5Pslau79AjfacW2Vxe0kPSKugPTd6cXLMLT2wh7Y8KRRGBh6tPDA6j90f4r5uWV
         i6J8OqAPRL104tWKXShTKlkDlZUkdUT4PbBTKt/c1LVtsjlKlJTPJiyHRyXmQKoC0Y6P
         ibRaNGwgfXMkNxvIxIumgMP1FaUNDTcNeVFq1LKPNftkT6J4IpPKaIdAR8053R3jwKge
         86wYqa1e+DOIArzKwCmrqbfNk/CmE9+m9Z6ddwgkUV6AXTgfAVo/jCYe1r+gvVPz8TGv
         UBdg==
X-Forwarded-Encrypted: i=1; AFNElJ9eqCKeVEajDVTGgVVTQsuenj46uzy83EnHa4Y9R9XRrdbZNuNHYG0xu1JBCnbSMWsfiOYqLWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALYULK1+saRpWPdiInh7YVmipEfC9ULT7Z5um5dIa8kFQVrH8
	Wfy9nQjgKvfth2f33vRxjG6jz8UDP2HQb0bZyMWbz5a+aYHV5LemZ2ep
X-Gm-Gg: Acq92OEwZ22MqLJylUku0UIEgH5hm9RlWfEah5GXmGhn/CnQWQN9kZFuWUeGvhZdx7N
	UR/vYlgxIVSMiaXWNlG8cyWT+ma2SnVGRY/DXCwNzmkg+6v7y3hv7jFKDAlM1YC2drauCTJdmua
	1Ygq3i0hqUd+r3SKnz95eDqGvTepSPR/s0nFPrI2ICw56RlgqU1tUxiCQothr8A1lr9ApNnqJu9
	8wpfvT61ffCrwcoHxWpH6eII4dCpPjOG9xZB4MNGNfYfQ6sKTTcKx620pcOPcjzrKni2//pz1CW
	efjd1dWiBs8i1drLQxXP0buat1cTqn3FGz5FPO+k/RgScTcztW6/dGfUZESaR7e4KSYRZobQtTi
	sU5kRjmnko5ePgC0MSVcZUdMMc2pCBM7fCpMPDkgVs2glY4JCFKoYVDc6LZdfEZ9T6wZAMavwgX
	UxCoaOSaNfZJ3Nfj/a3EolrBQr44xtKrgtiOnhhLevulwtCAPRKAeSJ/lhO6C/xbQEXVxPEbU=
X-Received: by 2002:a5d:5f53:0:b0:44b:9dca:7d93 with SMTP id ffacd0b85a97d-45e5c58761emr6944564f8f.26.1778870286817;
        Fri, 15 May 2026 11:38:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768bcesm17709798f8f.4.2026.05.15.11.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:38:06 -0700 (PDT)
Date: Fri, 15 May 2026 19:38:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Arnd Bergmann"
 <arnd@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <kafai@fb.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Simon Horman" <horms@kernel.org>, "Stanislav Fomichev"
 <sdf@fomichev.me>, bpf <bpf@vger.kernel.org>, Netdev
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: test_run: reduce kernel stack usage
Message-ID: <20260515193804.4d85283b@pumpkin>
In-Reply-To: <b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
References: <20260515113102.2389020-1-arnd@kernel.org>
	<CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
	<b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0CF3D5566A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-288422-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com,fb.com,linux.dev,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 17:15:46 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Fri, May 15, 2026, at 16:47, Alexei Starovoitov wrote:
> > On Fri, May 15, 2026 at 4:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >
> > 1k?
> > pahole -C xdp_test_data
> > /* size: 192, cachelines: 3, members: 9 */
> > /* sum members: 120, holes: 1, sum holes: 56 */
> > /* padding: 16 */
> > /* paddings: 1, sum paddings: 36 */
> >
> > what s390 doing to make it huge? =20
>=20
> I think it's a combination of cacheline alignment (256 byte
> lines) that leads to padding before 'rxq' and at the end of
> xdp_test_data, as well as CONFIG_KASAN_STACK that increases
> the stack usage further.

There will also be a 'double stack frame' in order to put an
aligned item on stack.
That could be slightly larger than a stack frame and probably doesn't
show up in the figures.

-- David

