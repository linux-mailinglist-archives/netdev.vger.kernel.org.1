Return-Path: <netdev+bounces-290031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPFHE5L2DWry4wUAu9opvQ
	(envelope-from <netdev+bounces-290031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:59:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C468A595104
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D2DF3073D2F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B993F6C4C;
	Wed, 20 May 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DC6LHlTr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E63CB2F8
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299888; cv=pass; b=tu0xmY0kT6y3+j9Zh5fhRiKAqMhg+W0Rnau26Tn/jJlo26UOpzXsGlGXOLMsAEf2m9dogMyveYpPa8f1oTpgbJ0xOl1JB8uFj6VYWVb2y6lFyKwo/ZF3ZRfroiGZdbP1ay4Uh89wjka3awVXWJSAIdO9mZWZ30ogDYRkgG0NxIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299888; c=relaxed/simple;
	bh=mQnou38Wl8TzkAaQ+0Y3VGF2v23aobiOBnHhJSntCDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIJYzDwAYEQP9TKCTrpi5CGJb9y/vuaAlYZd0KRs1ELa/+FD08CPJKmMrXNlsY6kbX2VIHTNT1LquxIYmuP9j59eOMqX49x+A4H56U9pXMuYi1Et6lIcaLn4+Gw6q+jq8fNp10UT0dQnMvRReifI1xHpHn68SjOelddh1dVa4h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DC6LHlTr; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e61648f10so18901cf.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779299884; cv=none;
        d=google.com; s=arc-20240605;
        b=BTJVOQN68fmC7JLcJtQ3CNJXJEwTngADe3/Z3ZodtdfemInQvXb53rIxvO5a7Ofa/+
         RaZ0wTVceHI1+VpYQTDVltx9ARWPRwKNVlqYrXJ6aXMtFNyy1QWJs9JHYo0z5gpVIBPq
         odFxFq/6ma+ffWoy+C4KI0IefrAZWJHVwhNhHYULqRvnfxwFMwi+LUjXl9rdd+/YRaDm
         r6PbkaSlelT3MmVXoxi5VboEM/8rVtD0QmYTfcKiudkqWw2riI9coA9nCvMJB3wMRitk
         wHa1nfWLGPPK2XHdcCoKcUyShlgFfO1f5kk0gInh1OaDwhjWviVtV3MzmfXhk0TjTgx4
         VdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mQnou38Wl8TzkAaQ+0Y3VGF2v23aobiOBnHhJSntCDQ=;
        fh=Ek5/aPgyfZmnxbbfmkXsfDv+vcHXalR6UqiGPU5+qb0=;
        b=NBihB3s7Ttnb+RIAXuU1F6oNs2Ki+4eBmyRXySKGGTZy5weah5I6PhPjr08NhDGTYI
         oETfrQtN8t9oWeLyMa1nPQCyOcR6Dt9qrYt3vq05GoVMB0NLMx4POmFzEWV/NKZ8+iVT
         wnNGREkDjpnZZN7Di3WBfLkDFrjd7JZM0Anmr/byq4VfcHVG+WjDPGa+4hMsq1zVjKLY
         7X2Hl7QQcHcU6PK9K1NEtC4+rIYXND1xx7HqX2afuOYThJiSRmGWh+hmtE9GnvouFVvA
         C2Vzlk5s3fdhtUkcCqi0ZhMeypwDA386pPV38XdzzNF0QH+6RFvGa9nYCWUyVV7AJkIr
         PsHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779299884; x=1779904684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQnou38Wl8TzkAaQ+0Y3VGF2v23aobiOBnHhJSntCDQ=;
        b=DC6LHlTrHS+ntpFJsL2kQaoV5qokglGmMogrE+P1AY1IPEz4dhwlvR4qgBiyfM2vKS
         HcCkLwEmgev1Eg6ziXyViEJ8e3JYZOvbTisbQA4Z7FWeLt+Vl6JPfQgurv6vrkIGqKeS
         E44JOgiI2NwgyvPxJAqy3qz6y79ZTZ5O8WwvbstDbOp39vcIke8YVjgQMEX6yy6Tk6wM
         WHGh98fFDcDxWNrg1wOqU919JnS0ltHrXlsfTqcvM6VXVFOLEM6wIF3YXWNHC2zpMmMN
         5lYRGNjgyL+pglIE+zkFy4cqMVdvdEguks/efG4MLKeLydaNlGDlGKSz5Ze5oJ7FX7sd
         YsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779299884; x=1779904684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mQnou38Wl8TzkAaQ+0Y3VGF2v23aobiOBnHhJSntCDQ=;
        b=E8b70hKo4sd3jUBkyzhGZm4Kk1wL+4cpr4Jl6uGRTLfT/KnSgc61/xpJBjGU9GLVep
         dT60J78pcRzYuehhqrTjtxzAjlFFvaXhBJNTJnJi7+8AK+uYny1Cre5UIhLjWmThBncx
         uA0RSI2wyqAAcLql7TihhCMiie9V4lcEI92IqC5MbDsCt98KqQnAc8i1NK8vFs3UdVhs
         lTV5W6f5GQmZhC1rF2LCMkZM0EJvQXfoJ8EXYyTOh80cRKuaYbDG9W8/gNGeO5eOl/fx
         i9K6R6ZYLbbD6JGsUjxhM3XTmPIH3NMdTJr7tkL3i2VwJnby0UoXBIF2YjmQzF0Ae6pl
         1p1w==
X-Gm-Message-State: AOJu0Ywv0mygzSzOsM10BSGAanenxa+dfSVAh8M86lSBh5NFYsi5rv4x
	WUYQLUYROe04YuMfRLcJawYzEWcbug767veo/VOTUtuX4pRjDAdVy0Mchu4VNYREY65ZzoYmWFF
	p+dsrGs9m5scq3+UNv+KuELPnE/qpuksrJp9qLOIEaMw6EQ79Sn13nk87
X-Gm-Gg: Acq92OFsSBX0+IrDsiIq+BC+oEQaAPboXcIiX7xyM03rrQtFv5UJDI+55rICLdcRRDL
	WB+qBod9CpqEJ9wWUpXTXq2dHKT58T6oOyxqyqoWk4evGpc3hSHgV6T6fb2SBSxh2JEE0IdKYRc
	4jL7AVnJFUmfzH42vsaazIKbn4Hxpr7OdYYa2de4HjbmZjqFiEKFhLNt3yMSed+OZUBVIT28lCX
	qV1vdBYlmcAaEOK19WOShBEQHW8bys7O8Pj8kNzfGX9R2Gf9yJGjmaMPYH6ubMc7bIQq3Xy8clY
	bBRqvfhdQWHTx7FxdBY6CBgxFkEwDQVJ2TkljLWGLsKumlsegm4Bv8kJVKzrLEk=
X-Received: by 2002:a05:701b:428e:10b0:12f:1f67:e742 with SMTP id
 a92af1059eb24-1362d6a9929mr11970c88.14.1779299869279; Wed, 20 May 2026
 10:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxpCqCB8jDSybr11TkudjUL8qWqJDDxd6zDAgR_Ewqoc7M7EQ@mail.gmail.com>
In-Reply-To: <CADxpCqCB8jDSybr11TkudjUL8qWqJDDxd6zDAgR_Ewqoc7M7EQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 May 2026 10:57:36 -0700
X-Gm-Features: AVHnY4IDYhTEItB1yhrI4VAlTFnwSiN59zhhqc9OEKn0UWrDLRuyoMA2NcPwnc4
Message-ID: <CAHS8izP0ywrP9Q+DaS2GnKE65qJz6opP-WAL_J0sMNXB21njBw@mail.gmail.com>
Subject: Re: Possible devmem TCP TX dma-buf binding id authorization issue
To: JUNYI LIU <moss80199@gmail.com>
Cc: netdev@vger.kernel.org, sdf@fomichev.me, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290031-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C468A595104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 8:04=E2=80=AFAM JUNYI LIU <moss80199@gmail.com> wro=
te:
>
> Hello,
>
> I am reporting a possible authorization issue in the Linux devmem TCP TX =
path.
> This report was prepared with AI assistance and is being routed
> public/subsystem-first rather than as a security-only private report.
>
> Main issue: after a dma-buf is bound for devmem TCP TX, later
> SCM_DEVMEM_DMABUF send use appears to accept the global binding id withou=
t
> checking that the sender created the binding, still has the original dma-=
buf fd,
> or has explicit delegation.
>
> Conservative impact: on systems where devmem TCP TX is usable, a local pr=
ocess
> that has learned or been supplied an active binding id may be able to mak=
e the
> kernel/NIC transmit bytes from a dma-buf bound by another process through=
 the same
> netdev.

This is indeed possible, although my feeling it's more of a valid use
case that's working-as-intended rather than a security hole. It seems
fine to me for one process to bind dma-bufs to the netdev, share it
with other processes (mayb even running under a different user) that
do the sending from the dma-buf. Sharing dma-bufs between processes or
users is not unusual. And afterall, if the owner process/user shared
the dmabuf-id with another process/user then it is not surprising they
used it?

> I am not claiming RCE, privilege escalation, arbitrary kernel memory
> read, a bind-rx bypass, or practical brute-force discovery of active ids.
>

However brute-force discovery may be possible and indeed a user may be
able to trigger a send from a dmabuf that was not shared with them.
They would have to scan the entire UINT32 (IIRC) space of possible IDs
though. They probably get some ENOTFOUND error for invalid IDs, but
the operation may go through once they hit a valid ID. If that is a
concern in practice maybe we should consider this fix.

> Tested tree: Linux master commit 6916d5703ddf9a38f1f6c2cc793381a24ee914c6=
.
> Introducing commit: bd61848900bf, net: devmem: Implement TX path.
>
> The full report is attached as report.txt. I also attached a candidate fi=
x diff
> as a discussion patch. It passed git apply check on the tested tree. I ha=
ve
> source-level evidence and a small local model, but no current-run live
> two-process replay because that requires a netmem TX-capable kernel/devic=
e
> setup.
>
> I can provide the small harness or patch-form regression material if you =
would
> like it; I kept additional repro material out of this message to keep the
> thread concise.
>
> Regards,
> JUNYI LIU



--=20
Thanks,
Mina

