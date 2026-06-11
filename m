Return-Path: <netdev+bounces-298120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LZreCiqtKmpDuwMAu9opvQ
	(envelope-from <netdev+bounces-298120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:42:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9314671F34
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XmFgfAua;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298120-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298120-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24CC630EC305
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368643F99FB;
	Thu, 11 Jun 2026 12:38:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111053F9F43
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:38:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181502; cv=pass; b=e7MUfZ22YuC/K1Aqtd7zP7o4Lloe6XiqOgHx8p5PegU8v5dc8v6xJbGWbKukwbd16Y4r9sXcKlGDcp8nVFQ968p3R+pOqvOSkDTLAL4/tW4VGS5Wlx54cFG/3u/Q4mxfbEfnQnaq7wb3eAy8LRzF5U2uN/X/qAUffoXs+lg5Lks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181502; c=relaxed/simple;
	bh=ojsKbpJZqsF4mqMN6JdK1iLxFv+TqfVytC3MxmRt82U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oib3qwjua2DlSoO/LqPO9yRYEFYGvfZWllUqKiQf7ZHSc8irtreaiMeJ8SamJ2GdlXzx43I1yHL+D52Y03S8N+t4PG6/QRQSKxV6sK479fTnf+ecuBr+1AffWEQcDNsbAeos27E+t5Y5eSprWp5gWqdLslf5/0crAMU2Kk7n31A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmFgfAua; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176bbb9384so78818481cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781181499; cv=none;
        d=google.com; s=arc-20240605;
        b=fhba2N0LMh4C21l+6UlxdF9Qgp/ZaEebK6C5U2foXyPtWVX9MbPDpmgmzuYyclUhI+
         nVbnw+Q+fQQsdPjaVMbJDGypZ6nvD88WV1x4NX07sVPdAe4/GYRiPisDQ+HYDlrVla73
         P9UvPm77PGFf528buTxtK/TDIuIo9hVWKm7WvYlEKK0tO6+IZvi95F/lms2hxTodytnL
         7w9pgZJ80vHHnLimJ8i6y3jkrkMOfdKWYJijfd/nQ4QzGBCZmNunrdwCW1b3jV4RKsik
         dJE9BUPzie+r5UN0fVF42Ew96pyZQQGqkauc4TbJqEMgxm3g7sKH53JrzljKqkVi3NiR
         e/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ojsKbpJZqsF4mqMN6JdK1iLxFv+TqfVytC3MxmRt82U=;
        fh=rHGAY0vGuNwpJb6WtB0+yFpJS05O5FO5yHZd7Sy40bw=;
        b=KsBiKNYv9ZW2oRu//E6bRTInHgWo+uJDSAdVZ7gBa2Kl1VRi74knxBxcz9hDh6c0gv
         Ux/LBSXh2cRrhJq73Ly7C5sepyGNQJjFG6kU/OFDe5Mq2Uj9KcxWmHdYnp7aQlclC0RG
         s4gqCS2ve0jSHeey/38vTUNYBmn8egplFuHM5e7m2M/0MeM+LFIWsTlChnZFY8v9Sb11
         cXyhss4RMVaGAea+kVO3n7BbdUj12Q7iElouQO7h57ymCxrgufXtI9+fe7fw+/je6Bx+
         YVCfw9DvOUxmv/FT+meJ6BUD1l39K9xqd7+Q+8r6w8skOOi2WkXLzoMJBsYxZGJ9nhto
         P+ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781181499; x=1781786299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojsKbpJZqsF4mqMN6JdK1iLxFv+TqfVytC3MxmRt82U=;
        b=XmFgfAuah5vS/dvbHCBe3N7xPqiv9/1xRY+f57Avi6F6TpLu2hDaSnxi1uulmerpIk
         Ebm1mWCZ+u5rPJOd6d/2YrxBnAR5AwZAMJLv2jTpb65tUry5nTWn1vviOHtcjPB8pYh6
         9jNSnWmKWXffR0d+d9cKY5B8xkiXnrZYDyUVgoEN4qlWRk5lAmVVoZvqnnkV20TMxpi0
         qYYmhrvZZfHhUyK0OqBd8IGKkmtnQS2sgw1HfS5RBfNy90KM+rHGaZBEsFrsNeMWI2Uq
         833MFunh1TjGCXuhCwiq3qUWA9gtlSOeot9SDk/8KEMI7rrahBOI1SU+BxkUSyfU+OS5
         LLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181499; x=1781786299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojsKbpJZqsF4mqMN6JdK1iLxFv+TqfVytC3MxmRt82U=;
        b=cE2vIXw/nCif5d4uHBORlFt48G8RdFAKHbFinH505Kb2IftZZdp5oHdKU7J2ftXtWE
         IJh1zNESMO5cd0tRdiM1KF36so9yaX9m2OU6wwHu5uXyOh0Plj2DXgqFeLLWdRYn5IVz
         qeNbgbprezd/fhJf6mUgyR05+FYj3cCUaYEUdwAs5NUonaD5mPyuUuGionaclUN5wBTX
         kcUbqqyOadw+zszs2SO3aEarct4JHaiE4396dSN3D0HSGsKvMv3unzYR7utMNg1RBsvR
         rgVRM2fWpbfH8rdayi0FLZJveNnSjYww2obMJSBxqtTR65fBPh54kQAzOygyKtcY6ENV
         uvSg==
X-Forwarded-Encrypted: i=1; AFNElJ8k0RUYvwI61WbHnpKsdb7mAqw7mhs+AWu+w0ItT0L8lc3JgrPYP/gOgTzLaIhUDH5UARxrji8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFH/mq6sVe8UtbKMbZJ9F9xGRj9bMUQZRJ8sn0hP1vif8H0xdA
	GUkCkJBNFjXd6e+750cF6KSW9IzJGxwJUXLigVWZbebxLXvaR9XuQnSYSsouMxEZpApSVHWrp30
	z2t1/FZ07yfiUPEVskWRr6T1l2BKz6nD8YPsuGzcl
X-Gm-Gg: Acq92OFBBri33GBxt3zz0OJnkL/REb23/Pn6Ke0kGYYPMOPHdCAgsNuIaO45pidPKSm
	jfnjoVsE8RUVVK2EhUxo4+jqk0eKvOb057xftvuLkiGKAcKj/kgXN8HSnhrjzzF56V5fhkNCjzQ
	qXl+DvMV80KtaFu9+oXgKt8h+K3U2eQSK2XtLx1iCi5oJouqgp3EpxZQZP/mio0gy71aj14mtQl
	AZRsxqlZlnSq4HMRkX43V+o8u22EheKM+Nf0z30BoRaqvitIjMKPLTHHch/oc8vSkubv0ZUJpjN
	28ChmHwPAannkzXqAPZy8NiJ8MX72p0bKmv4klvr6X2f7emJpcwK6ieMSgepio69VVCi4UKlT5V
	75wAWl7kMt6MKt9gK98LNCsUuyNAExsKnT4y3vGlU
X-Received: by 2002:a05:622a:54a:b0:517:8541:8b70 with SMTP id
 d75a77b69052e-517ee2144afmr39725381cf.45.1781181498220; Thu, 11 Jun 2026
 05:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
 <fb96d949-dcf5-494d-8076-eb4a972fa5e4@redhat.com> <1014329c-d60f-432a-b165-62866ca6a4b4@kernel.org>
In-Reply-To: <1014329c-d60f-432a-b165-62866ca6a4b4@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 05:38:07 -0700
X-Gm-Features: AVVi8CeWcYBSHusf8PMPiwu6R-DABtcuuO6WPLkteSYaC0gxDZcGsCxGDjDoZO4
Message-ID: <CANn89iKZRmLfjO_9JURrx_6Hr9pMaQwD2zABc+dHyXiENXHNVg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some packets
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298120-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9314671F34

On Thu, Jun 11, 2026 at 1:49=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Paolo, Eric,
>
> On 11/06/2026 09:39, Paolo Abeni wrote:
> > Hi Eric,

> > I'm wondering if you are ok with this patch in the current form?
> >
> > One thing that was discussed on the mptcp ML was exposing the
> > tcp_out_options layout so that mptcp_established_options() could receiv=
e
> > such argument and likely clean-up a bit this code.
> >
> > Not done here because placing tcp_out_options under `include` felt a bi=
t
> > "too much". Perhaps adding a `net/ipv4/tcp_option.h` header (and
> > including it from the mptcp code) would be more palatable?
>
> Note that I also didn't do this because that would mean the removal of
> the TCP TS option would be done from the MPTCP side, and not here from
> the TCP side. That didn't feel right to hide this from the MPTCP side.
> But I'm fine to change if preferred.
>

Current patch LGTM, thanks!

Reviewed-by: Eric Dumazet <edumazet@google.com>

