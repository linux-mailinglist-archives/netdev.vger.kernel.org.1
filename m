Return-Path: <netdev+bounces-261034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPeSGR8yn2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:32:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF219B96A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59817300AD76
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E83DA7C3;
	Wed, 25 Feb 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTH9LtVx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F63D522A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040725; cv=pass; b=nDebNhORvw3CVq+x8d5JdemDmovL+RnoPy5DIpZFWHmH4mPcjpVKca7rsA+Tt+EqMa6f/b/XvDV9RIJjK0drPnTTMeFkmmYo1n0ebTgwDOApQE14dkUL9rw8bI7iZY3dXJ93m26Wfb408txR88IRbYwt1nvq/oeX5QvVhw6SSU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040725; c=relaxed/simple;
	bh=ikz0mBe9xrKw3FLnnMjPj24gq1CC1fq3THpb6ah6Qyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaCtIqV2iqQjypGKxWKVXBv8B6wBUMxWT3qTp0gFSSt6/PMdVku+Z0f0CTaad2yRAWwnKFEes6Rq7TGNDBCdIK4nCbz/0EcbN1ymRQ3cs7hcSM9Q86lekF1MWYIeJgONnDPQKcvcxmifVpbVJDcsZe0GwETImyt8wBn7Spp7DjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTH9LtVx; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124a60cc9a1so69c88.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:32:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772040721; cv=none;
        d=google.com; s=arc-20240605;
        b=YK3kiSfpjHnzk+V4UG2y3IWphB0SocrzrzXLUvQmwtzGKuQYnxkuJ7uT7NfZ8FVbrf
         Md6i0g9eATsKjkq8tA+oocmAMAe+rOCniSsGHzqvTwZGmdmb5+LefhfjG+WmKM7ozSwk
         OzttOu2/gZhCWHky/WlnTPphkZIsq7BiR8zPFW9t3yALsKh2O8J5mO0E4us2pdS+aFPh
         2troVtQn2bTcup3VOso0hkgO/OOIj8NDoQgCwNp+h64KxANAWvuFHlltxPzRIMZNfToc
         0pFzmcPboRklAlAMFH2DMEuwLj1PHR96mvwDW1rbeV9BkJbN4tJ8m7nNs7z40OVeKwvd
         CZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ikz0mBe9xrKw3FLnnMjPj24gq1CC1fq3THpb6ah6Qyc=;
        fh=zDffDg9NyO8HV7+vaUxxG3QD72rFaZ4B+J1Poe48jAs=;
        b=O5IKhTZLOknT88N+dAXsYr4Ut6g1R5ydPMHgjx7NoyEjHFIMgUwsUnkUD3fl4ZbaFv
         bxT93BS+t22uWvARrySa3tlMBk0+CRIOpTrxcJGeGfSEgD7lR3ICJ2Vm5uBiHIfRLHQj
         KyowhvcL2qK8fgrqWvEFcdmnKSA22nG30dMTRukeAMA9RQPP6PxwlCP6+9AM03dX7qmK
         9tlAK0jT3o4eXrKXhuIU03BNWUqr7WJYdn3uIvvE3FOCu47acvZwiY+VD/mBlBN0Q07a
         fITdsmpReB2yLgeBxETBfpLQXu5kmXh+0xI6TZmoQg6PtYZXDpWrLR0hfV0eZG84Gjpc
         zAOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772040721; x=1772645521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikz0mBe9xrKw3FLnnMjPj24gq1CC1fq3THpb6ah6Qyc=;
        b=mTH9LtVxdNoo3WG4isIjVM2y0aCXwn4QfzqHp+ZdLThjVVYIf9h+3gMqb/2FMVIN/2
         NfKUbCNJMg4hRXiKDR3v6mMGf+mcf9kuN6YJ0BUCd0+OwUdHvXVirnLkfhHX3gASHQea
         9Z9shBcMcLJRQyOne5fD+FkYd3Rowy+7AJPi+i3HUZBBDPkxUOzTZsp4J3t9/nKop4rd
         kwnmHfS49MhJrGTBIwZh0m5/eq0fdOOL6fROwCTmqh+PIbMHr19KqH4YU6EP61ud88Zt
         WwfAsDIfq1c/rLlOH1I9xzhDule3ulZ74ZC57oBDJJYW23/l30QAY9hmrAqDWxyRu/c3
         aIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772040721; x=1772645521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikz0mBe9xrKw3FLnnMjPj24gq1CC1fq3THpb6ah6Qyc=;
        b=G9MtZtT5dKJpLM6aBRxVOG6UfuWZgFERndLk5JwUeUtI1Q2/j0zRracSmJzFrGvq74
         aaQ9B9G4ajtCx9KawvITPy4nkaPWmyGmP8FtyrX5Fqup5xzI/TycuIHjOY3/q1kJnp05
         NOpwwXhcM7ZKbkYOm0IoFyL26srd6NCMqWE1+oVo1L1S8DyQEZR1ZrTa1gbehO6mr/63
         itcRjuFeeZbZHW+msuhJ332r3Tt9snyuJZwpgkxnQExeA0/Nu9VGTjTcY41WSEHDKSW3
         N08P/871qrJ1RyXTajMwfHVg60yD0wHqpVM0+VRH6WEYby+9peIsruCvMm+gfqItaqP+
         giEA==
X-Forwarded-Encrypted: i=1; AJvYcCUBc7CYKIddRX0YL+Z0dfreNbi0kBF6sf7kYMd/zvkQyts9Kj1ECqePkoTrDVwHivGqfmVQjC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGaeatUn0vyId+ublbn9+iQdooNkRnHDf36IzfHeRU2s0wlz1
	V8Vfd4eg3NxypWX5ASHCLp5+4RKWh8vTtCue3vcTmkTAvOzNk6nxron0CEwQeVJ0GXtLCmxexvy
	AVBzm07xoW8Pj7MOJ0viVumTnkbZizDUnYm1XKZ9T0ZmnlMFJ9wQ8vtKP
X-Gm-Gg: ATEYQzw6j1vvApZ/7BdqBNkxm+LU+7rggNiFXivPt7On711w03lL/URPFnMxNdkVhgx
	rWufatQONh+cBpDoUTskUfB+ouoO/6Rp6jmQQ9seXRfvMIIKoOFa1v5Hp1OGWKslcRRahFlq6Ns
	TwEjDAzvgWWIP1IVSSk5CJhCk9g5arffPhzFHnzswbwNB0qUZzKUlKgIbH75Eu6SpZFTsdUbfgp
	j1UlwXAjXcQRY8DaguXBepLVKSqdUOo4wGsPzANkxWlqFSkd//FgSUpjkc13wB9DnWpkGJRV/KQ
	jEmBLrv8xu+F7vW5VgP2hNKOJ6Dwrfkv4K36Ow92
X-Received: by 2002:a05:7022:f902:20b0:119:e56b:c1e1 with SMTP id
 a92af1059eb24-1278077de2bmr117429c88.12.1772040720886; Wed, 25 Feb 2026
 09:32:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-devmem-membar-fix-v1-1-37dcae1e49f8@meta.com>
 <aZ5VNkUqkTEzX6PJ@mini-arch> <aZ8R5n80NmnPb1J9@devvm11784.nha0.facebook.com>
In-Reply-To: <aZ8R5n80NmnPb1J9@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 25 Feb 2026 09:31:48 -0800
X-Gm-Features: AaiRm52-iM09JwUfPrJ5fsDadFAqXlL7JfSPbARWlTQIyjUvuF7YUfIcEn9Pxpo
Message-ID: <CAHS8izM9gS+4rKaxSdqx3yjn4harxKQ2HeCszPyq6XNbq+UcMQ@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261034-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 7BAF219B96A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 7:14=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Tue, Feb 24, 2026 at 05:49:42PM -0800, Stanislav Fomichev wrote:
> > On 02/23, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> > > binding->dev is protected on the write-side in
> > > mp_dmabuf_devmem_uninstall() against concurrent writes, but due to th=
e
> > > concurrent bare read in net_devmem_get_binding() it should be wrapped=
 in
> > > a READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations pl=
ay
> > > with the underlying register in unforeseen ways.
> > >
> > > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Looks correct to me, and AFAIU Stan is right, we might as well
annotate all the reads of ->dev as technically there could be a dmabuf
uninstall happing concurrently on another CPU. I also think it's
probably good to annotate potential races.

The ->dev write in dmabuf binding doesn't need WRITE_ONCE annotation I
guess because it's initialization, it can't race with any reads.

This makes me wonder what other fields in dmabuf need annotations. I
hope I didn't miss many more.

I would add this is really not a critical bug because
net_devmem_get_binding() is in TX path, and it is more than fine here
if we fail this check if there is an unbind happening in paraller with
sendmsg(), but it's probably good to annotate potential races anyway.

--=20
Thanks,
Mina

