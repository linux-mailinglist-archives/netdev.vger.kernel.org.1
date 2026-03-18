Return-Path: <netdev+bounces-268849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPCnJWgDumkGQgIAu9opvQ
	(envelope-from <netdev+bounces-268849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:44:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 267382B5088
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95627304BDBB
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB742242D86;
	Wed, 18 Mar 2026 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHSpjTXP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266C239E9B
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773798213; cv=pass; b=LKgnUyo69uX7YDJNMe4wG84oRZBT+sSYAQkcTNyqKVRQhfg7iob7jLQCi23t0Bn82s6EYb7mR02poKX5eMnIBvGVArA8iLGnFdflnw1dzW63MHN8PTsYZ0qOwM9DbMI7dIE+vesgdodWtZd4SjW+jntpNt5uh5a4vkpH2PfE2vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773798213; c=relaxed/simple;
	bh=7BhHAefvtC4T48LRxo6Nj3SRAcZH5mo7Y/wha2HxzMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeNrZJik4mQKuQb8pFPb2o+GlFiwGg1hn5jRGknyeOvBFZ27xdwvRHYfJmXRz9f0GuSq7IgQOfC04xgqWPs7d208zMOb7sAWrFfCfp/g59/JIgElhVBiXhuJ319Dzrvwz4Zmrpq3hIR/7yngnatMSIIQatsOWKNpQYxiCn3OwIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHSpjTXP; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439c6fc2910so4800032f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773798211; cv=none;
        d=google.com; s=arc-20240605;
        b=CCV46Ua+nQkAjoh7qSOoY/RpYYQrNa/3m7cjbeANXI+UNdkc+9dnGzzK41XO9Lesjf
         mT42soMauFeAVXan+Q37zFktxcC635oznnpTp8L7kIkivJAmluh22W/f8RNCqrGS6/ou
         75VvRIBMq5B5NAx3LYGpS8UXQSOSS4DThndokf6QwVLRr8MWRedODgdAIqoh4Xd1P3oC
         nWfEo9AkQhGyvRWFAToUIH4Ckmq+fcMchGVgN7/GSOcmVO0P2m8fNdui6CV0aOHDnCMm
         A5flqmBb21RvW+zkKhBovtEdE/mPLI/PBB0lmvoyT/+C4nMpPIKBV+mpJeGncOiZuTIT
         2mDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7BhHAefvtC4T48LRxo6Nj3SRAcZH5mo7Y/wha2HxzMg=;
        fh=gT9HqilvdcWQ1CWsnXhcJMamMMDDA/xB4P0o/nFQNII=;
        b=kWbgDW0UW8zELUCOiIba1zIfsEP1q3STtswi15m7+deimoys1WzXkFd7fN6I/lI28Z
         Ww/2vgwQFVX1oiUwQGGrh1L4JxhpTXH5RBWIWVJuYV3jWOUXRbJxYWF3alIddmyLpWns
         5+NQO8j3DEW1vDkdEU0PMBPGI9k3feWdcW6U8BoiiXuuZ0ynp9on/x9BiKAjJpkMUsXy
         csQb1iv5fUQ5bRArDmGjFq7mdBjXCzD5zaRSImSIh/EesdeFdvtK570IHtgTkuoXcHl+
         b7vRtm7efkhaXG93pFavcrrInXsQEjLQ+BWOZa+SncU7IZkKTyjkB9pXxJfE3CcuZ8Jj
         ow6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773798211; x=1774403011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BhHAefvtC4T48LRxo6Nj3SRAcZH5mo7Y/wha2HxzMg=;
        b=GHSpjTXPFvaLz6uwf6u/+NJ6ZO1UXT2ACXbGW5j9+yS2FmxIHzA/36qc2jcLhtSsaP
         WfGFkZ9Zd8cfgCi+3X/11E+SMh2iJ23UJx7uARUDYRWYCEjGAaQZzRs0qYWiRQUZ2sBc
         +VYvG2VdOHTZHDq/2fDeoLURGfa133bPs2yRNmEu6ygedlgZT1dFCFp2ENdlXyRCaK7p
         2FMk8Og9Y3jatgTRCzh2lvDhy4iHwzAzVXnXKOXKyXduKeSQ6TBVPCQKZ8hRSDYPdOd1
         R8GwIR3xUwYkmjdYcQS7q6VNw4XHNqsAM1J5ISrpadAyfs1elKHGYyxzzdkAhyulNPEj
         eHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773798211; x=1774403011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7BhHAefvtC4T48LRxo6Nj3SRAcZH5mo7Y/wha2HxzMg=;
        b=VljfxIOJAI2P2+7jRMDH44dnG6YlnKfnIzcsBtMyeZDRZhM7pcL3879vOmkhM6NwlL
         bWNTJkPF/Lcy6nlnIRtkpKNYMiIkREVTSuKmJXRS5wAZJ1kW9wp8SnuM6O1U9/OIdKQb
         D1XlIdaqSCteZsYr89W4J+9BYw9ReUprFITZUST9YabhDFCpBcSKSe39svo21Ej3G+A+
         LJ+P2Qh+2f2J5R05X6455CgL1qOuRr3TqKIG3ZAa4RXBs14MZfT75taakeJzqh8yfy2v
         Glf8K5Lnt/BM73sIO0SzFh8KZgZeD9m/qAvHZERIFCHXnFwE8yTgTuZWqsYY9W9fWJFV
         5hZg==
X-Forwarded-Encrypted: i=1; AJvYcCWZlJa/VTp0CRUkbXfhWEq6KZhTtIm/PrKdv4Ge5MMvObuEo8u54WbJIsSrScqY236o/i79ybk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxU3FyXZZmUzcUqjinjwfD5cnpy0iVVAT4lKj9uU/EiE1PQbYj
	CmbWJ7Rt9LePPbWMftaiSNdMVueuTx3ftntFzrrzoThBoBaurQTFj6QaA947NQFXO7vb3LR2GrN
	MBUwz2z95rdX/ZKxk474XeQ3HL5c6Vr0=
X-Gm-Gg: ATEYQzxqS2PA2SF5ROt1laL8qxqUwAVoRYgglFIpcaWEjgPMiz0QNHCSOUjotetFXEd
	01wcP01f5Sd8bLQW7NgX4WZYUn9yICWgf/Es/GBS7RGRckle9Ov3aMGbP8eoYZl8qiAyxbSLG65
	Giz3p7KbVxW/YK1Qe7tgmVsYH1t42qAmd8NdFkrpt/V3OlZvYKvh7z+7QlR2UQh6YV92hy6ka68
	OF06K6kizYSVV17KL9txpUvZTpws/MmYCBAgu2SgXFv9JAdsowGlVbixRBnjL6evgpkZ+8ydVd0
	VumNljEyT9N2Dsm9sNkHQBvbdyOTTUx/AyzKiN8X0tVyoaLlMJp52jwe1l3R28Dvrh9CO+B/zOH
	A4Xc88Bi2RurKAm1nKMeQvBAszK0xPgHLFpKs
X-Received: by 2002:a05:6000:4301:b0:43b:45a0:9df6 with SMTP id
 ffacd0b85a97d-43b527c3c15mr2325324f8f.32.1773798210560; Tue, 17 Mar 2026
 18:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
 <20260316171200.4b8a96a0@kernel.org> <CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
 <20260317152045.58c719a7@kernel.org> <CAADnVQLZOUMGxNDwxhRzfx4finsF3aua31cggKpgTA6h0pjgAA@mail.gmail.com>
 <20260317182920.3f4fd8eb@kernel.org>
In-Reply-To: <20260317182920.3f4fd8eb@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 18:43:18 -0700
X-Gm-Features: AaiRm50CHiKH0_7o4GCtfMzrpMzNox7Sq7UK2x6XyWyGXlvcrY57K02HjenTgg0
Message-ID: <CAADnVQKYW3cmJoPJyDowXvg92crKcc0be=+3pR=DfPWLdCxaSQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268849-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,intel.com,vger.kernel.org,gmail.com,redhat.com,kernel.org,iogearbox.net];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 267382B5088
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 6:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Mar 2026 17:57:32 -0700 Alexei Starovoitov wrote:
> > > > Do you guys need it in net-next in this merge window ?
> > > >
> > > > We have nothing in bpf-next/net so far, so should be fine
> > > > to take this patch into net-next directly?
> > >
> > > Somehow __xsk_rcv_zc_safe() landed in bpf-next/master f620af11c27b8ec=
9
> > > So I think we have limited number of possible moves now :)
> >
> > I wasn't paying attention. We can revert it in bpf-next and reapply
> > in net-next and probably route all future xsk patches to net/net-next ?
> > since it doesn't have much to do with bpf anymore.
>
> Maybe we should defer until the merge window and let it sit in Maciej's
> local tree for now. It's a tiny optimization, Maciej can resend in the
> next cycle.

or I can apply it to bpf-next/master and we start taking xsk via net-next
after merge window?

