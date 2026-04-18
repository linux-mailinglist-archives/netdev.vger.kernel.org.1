Return-Path: <netdev+bounces-279471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HVnGpAX42nxBwEAu9opvQ
	(envelope-from <netdev+bounces-279471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:33:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E442004D
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB323020AA7
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D97343D85;
	Sat, 18 Apr 2026 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNMW1R7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FE33D6FC
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490381; cv=pass; b=fRKVEUqiSi+yej9mk403TRD1uoXJ0s9a7QazhTTcQDdeY74PXoBlWtLcIRPcyg1CUx/1AYOgDkIDXi0WnU7iW4wpJlsDfRL0R/CUoAM3CHmpMIJPSablaaRl3hB6KKM56ao785WAggVzGUNiBi6OTD6h4l/zBKzxzu3O8+R8Saw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490381; c=relaxed/simple;
	bh=uFedD+3QvAriVuwF00hiO/nZc1ckKInhzFP3I5SrM5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peMWUah/6bqEe42Q8Z6PUq1dXnC7rWV50rtIdUrxbrI0yRKFGsOAAme8gGhLG0ZYAdkI9HlntoHOHHbaZzD1qRe/fWTZes7k4gJr2p66ixCSctqSYPkTnP8nQ/SpTuBUWGM9F3w6VadSv8reCDl7lLxLLq8sJg94uOdwmS4/4Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNMW1R7P; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c637089ccso3311141c88.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 22:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776490379; cv=none;
        d=google.com; s=arc-20240605;
        b=k/zPu9ysuUnnJSu3tjdxWy56H0/eLLSi5FqTrKaUVz4XIKWciCws1WtpWOaPjzr0Uy
         ZdHK0N1rCBl8NcvihZ7XT8gIQgBPqH+K73oTd3EfxNyV5H39BX6wy0I+mCqW+QZjjiL5
         RoZslhgEztVF/o1EiKtpPVdLN2vUgzE3dQdExvJdKAiIhiNSTwq1E+Qe2j3YD5AAi4/8
         hjfHOqP2sJtLP6ZPRh6C99ioWOB5ZkGh/ZWLC+bFOke07j/X/2OuJUZxBlrVEkwrnozp
         WYrBR9a59ZfuBpsJgdb6zWjmby/2Mj+5E55DRji3wYRgWDhtJCjnWd/aP86kXb0inlDV
         V7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uFedD+3QvAriVuwF00hiO/nZc1ckKInhzFP3I5SrM5E=;
        fh=SdjRonWCxS/sS4InHKDyPpzWtMs5DJCbMWtZEr5bwy4=;
        b=IOQOjRZbPRxktfrqP19HoXXg8KSQWxcGZuLC6fAfGBwbFk3gXWVHCbbIUI8o3KRSNI
         0iWLHx8P6midT6Z5bhwfvK28EZt0v4efL9DPpTtKjUiK2mctDEC388IHA3pfieTwCGJf
         /1+bsTPxFJ3pXxzR5c6etmnZFWTg83xcWjrqrmlWG+79YGlUo4S3zU0VbyYodDNUzjzK
         5EyRPmqyhVR0fDYfHqgj62CmoyB/YRiTafTespULAx8BuD7RaWnoBRN8X0IvXe4ydGMb
         KSwWDxe/WNe7WGgF0acR7OfUh4neHapnAwhIbHDgkXBIWo2Qp1BvaAcjOZ7Xib37KZiJ
         tsVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776490379; x=1777095179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFedD+3QvAriVuwF00hiO/nZc1ckKInhzFP3I5SrM5E=;
        b=XNMW1R7Ps6S9uiX2mnN7P/vjUCnVQjAO2HJByya96YKdyXDpZlGHEj4UFercz/Ct2k
         BEB5BvdrzAlck7E6/sj8QrGVOiaNDzuc5knCcnyrmEj8fmfLyDXksdTZxxtgqGqL5pv0
         FUH021U1frEnmGHgbMD3NHfCzqOM/0pksKpSM1ogJL07bn1tmLzj+cR9TP2mKyk1kliR
         BpudlUorHpRBOTEyVYVTImYLoAuesQfYTzDjrChUaXvDNj2eYfooxAjUh9vaBTMaxpdj
         MJgZ33v26Cd+uvTqwLODJ+sUVK6zSh9ot1mY1sF/ppJR0ZHE3sVJdeNOwl/GaN3BRm00
         TFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490379; x=1777095179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFedD+3QvAriVuwF00hiO/nZc1ckKInhzFP3I5SrM5E=;
        b=XE/LaHdKnnoqU2afwyrYNV3oOdpSWcXM5QGgKFPs70zCy0LJHqw+e3VgUmziJd4zEA
         9nRQLj5r8aJDOa4NPnxeINwBd/VEsuHF9d4sKPwEhCr+BvvGspIJhesB+LTN/9U7WLfA
         ZdOk3KvSgQdoha/GkhLxrOHHg8LhdRxiz73WXPd7/+bV2oOYiDNzk/jDJW87XAev60Pg
         RA7M3C5Wr8jdPdH9d/QyyRXfDfu38LJwJ60bm3bXnnH2/AbcWLTjOEi5DAC+f7HSZt5K
         uwQN1VDtstRE12YSfjv68LmVHzk5amg+xyWyAFCUWoMGeKOzl6xaG6AugMErAUhPMm1m
         zLoA==
X-Forwarded-Encrypted: i=1; AFNElJ8+ACAacXSFq66u0KPURbfTlGxJCqMLE8GCgLKRqUynZQOrPrQTQzCGLkW+ON3+xYSEbsnzTuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4J5FY4lpxiVPg58TCPIcXGIDzqnyi2r+2WqL/8ranj8RSfXzI
	8eovRQDvmoNF6DYrb3wpbRaxtDEKSK1A0Csg3OUniBXDD7g+0Ixxi0XBBO/e4IoyzU1jsQkxaEd
	RSmEZcsPDNhzfr8XQGhH2a2PDafC/QUapP2IYqKzl
X-Gm-Gg: AeBDiesdwVLK07RGcJu5+I3bvy9Y0tba1P88sX1OPLmAVm7DS1lwfERQSZCmokNeQVg
	VjuuZ5cpFBpWeuOh9YSEnrJF+zRN3yQuEL02iCOQQU8wGNuGuEZaWIEzSltgCHiAcKviBTopcIB
	ewxUaFSBAfTLW1mqZTwKq4GqT5gOOaJYBR7RaGNeJXkzb0X1ms5jkXZ+WDKBAv0/EEs6cz44KMN
	hJvh0ImjhCx4TMFX6ewJJSszxcGSoLzpeSoxRt3VaZwcngNAYrLIZVPm/5GRWXnSMb5V3DOBJ3t
	hs7I9wmN1TW3IlrHrFqApToq9jaR6d0AWpFcQT644WaLw7VC1Bnn4OvgwP3Cl84BQOESv6Ja6Oe
	VcdtcpngHm0X5B1xO8NwzvU9LnGuOAE1aT46Lqq4xTeB3lsWpdFHM1x7Aa/vL56uUm4QCuIQ2M9
	lhttIqqX1T
X-Received: by 2002:a05:7022:30e:b0:12a:949b:b9b with SMTP id
 a92af1059eb24-12c73f99c7fmr2908455c88.23.1776490378478; Fri, 17 Apr 2026
 22:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418024957.2669737-1-kuniyu@google.com> <CANn89iLL0iWoU-jh=Nk+0fsGWNOeuwQ8DP=dVUT=LjBGHR_2FA@mail.gmail.com>
In-Reply-To: <CANn89iLL0iWoU-jh=Nk+0fsGWNOeuwQ8DP=dVUT=LjBGHR_2FA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 17 Apr 2026 22:32:47 -0700
X-Gm-Features: AQROBzCxtj1xMlQXbQJf1J5L3ZsiKzyaw7qXQLmLKll_g-ZddxvceNI3-Ue_WAA
Message-ID: <CAAVpQUA8+eibr_0CcdKEWUhzyn6SNE8MA5uzYCJhNmWstq2OAQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Disable usec TS for SYN Cookie.
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-279471-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B80E442004D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 9:59=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Apr 17, 2026 at 7:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > cookie_tcp_reqsk_alloc() sets tcp_rsk(req)->req_usec_ts to false
> > unconditionally.
> >
> > If want_cookie is true in tcp_conn_request(), we should not set
> > tcp_rsk(req)->req_usec_ts.
> >
> > Let's not call dst_tcp_usec_ts() for SYN Cookie.
>
> May I ask why ?

Sorry, I missed tcp_skb_timestamp_ts() properly restores the
cookie TS generated by cookie_init_timestamp() to ms unit.

Still we don't need to call dst_tcp_usec_ts() for SYN cookie,
but this was more like a cleanup patch.


>
> TCP usec TS are based on routing. this feature is not part of SYN
> and/or SYNACK options.
>
> Both side must have:
>
> ip route ... feature tcp_usec_ts
>
> syncookies are orthogonal to this constraint, so TCP flows can use
> usec TS just fine.
>
> pw-bot: cr

