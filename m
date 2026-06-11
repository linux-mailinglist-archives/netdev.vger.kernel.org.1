Return-Path: <netdev+bounces-298165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JOf7AxjLKmpuxAMAu9opvQ
	(envelope-from <netdev+bounces-298165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:50:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2AC672D6A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:49:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=dOmXApoi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298165-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298165-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA1530F6683
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0A62FE074;
	Thu, 11 Jun 2026 14:49:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275EC2D3EF2
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:49:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189397; cv=pass; b=UBM8Vd+bzEqAOAFUeOSVMhWAcVuhKqjcb6GHktl7BLlnD1dnrX7eFhvnlZcTwVdV7UsaA20n4lmFXhLOOuMz+QPpOVvrj21pM4DPuzV6VPRvTSnLwDOplawKNv3e6NRu8Hr2Te0QJ5I3tTloI7GppfzrjkPEsWIrBiuqbr2Dkkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189397; c=relaxed/simple;
	bh=/ILYYpAoRDVevb+EvSD4ELoybgABetzRIVdCTXaJN/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/rpHUzND+Q0AIV8Qb0XDVSmMpGvGlilDMMz6s9lLcSjwfE/0HdncuuaoPAZrlqVo8ufy6bfs6Kr2WBOnSTPylL3RRklQZxRTDbI6mEds6HXeA5GtvIPEovqEhMP2k9H8OnH2M6p4RroUvzlzhIptz+usuR72/9ywGcMOFwrZOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOmXApoi; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51788280e71so87599211cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781189395; cv=none;
        d=google.com; s=arc-20240605;
        b=cAfqLoUaq29Q1hig7LjQ3lCE2qg37//tBhOeTYAcZKANZKPu54YhoT6myjrTOs7Pfx
         WEwN5dG+88nuf2RCd9K2dzubgM6rETCRLH+fcFnq/rRgABhhaUUHBFyDqk7o2+fIwQHu
         V+Kpk6cwnsQvE4ZGd7kAITE7uVctr0Ytce3ZOIRHXg+LAfzi/IqpWAQUuab1ds213Emn
         36O13W/biZuB0gV2aLvtXnbs7gy8V/dOXldr4iMrzWWZTR87Jm3jyFSfqEcagDMHYv7N
         IaDvFo8chSlMfWDeCkone2fcokK7p0g1R4+rAZc3DA3VCCHD+xVchBxhZ6PsmuLSxUwn
         GQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ILYYpAoRDVevb+EvSD4ELoybgABetzRIVdCTXaJN/A=;
        fh=/tM2CQhCHsfXRUgPQm1ZNGzTDkp4eMm2q2CidSUiJI8=;
        b=TE8BIkJAxG1hNTO6pRLEC6HpNOswVyGMF8NoCOkD6Jz2bsMANxnd9Vae30+8UlY0X4
         BimOpIs+M+kygFbWPtxnpCAOwO4yVw8eVFLaMTrS5VuSGVwIQVzZ1PkvfrsxczyYEFqu
         Xb4No+BXuuY1zf/fMhyy/TiIEvpqkJptAxvCLcgBeojxgpiHQg0zGd4Iyc/Clwsps8f1
         lwDQ5T+XixTbbp6IUdnZb55/uvuUJnLvt/WsopVkFfZQc45TI41jb5E/0Y3eZ7g1pKBS
         luSXz2EjQczK9nf+SGXfSejT3u8YvsNaLspjZ/c48P5klwBZn1+qIoyGlxPF9ukJTIHV
         WFCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781189395; x=1781794195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ILYYpAoRDVevb+EvSD4ELoybgABetzRIVdCTXaJN/A=;
        b=dOmXApoiDeT4bTIhU2L+6GXKSKySpVdI/cX+ZJuTFwKSMv91to0Cp6hKIdiyRefKvd
         TKLicNHDrDUbEBIPJwADIHgwuO/G8EpK+/NyAB7uELiSyS5J/cKxythAHMvag49HgeW/
         c9HcbbIC7dJfZO/FQo6pCYeIg0tQ4wLCwg3IdRuXgFXExUgAuZA4APlXyLiz9HMS4FtP
         zqRqqN/jVVMYrfxe56Me4lZBD8BKi85Q0sXgdmi3ryNcKLRzHOSAxcykS44GnHevj9Um
         s0R0CjzQq1MNwv0a5MAV87+fz4CGyVBVzG3Jqnf+9QAdnNaxRVHBt+GaUQvzusYbPkZY
         KnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189395; x=1781794195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ILYYpAoRDVevb+EvSD4ELoybgABetzRIVdCTXaJN/A=;
        b=jzj1/km9gKguhq/+tpvA0eMMk82g9caQ4QztbsHLxoABbInwte4XKHJUXQMQzIIBRj
         JS+7wfi69/bKwe4UuWNr5IaD1W7hpoZK9egJPwLba7e0FmnHxGvXgxFwwlOEtBnPUNkh
         2a+zZ49QJc2DDCgBcsb3GO7CEwe13EW3RPRsJGZo3EkepyGlkpLbZQe0JzKQ9c8fS4Fn
         pETxFaTUJQxoL4KHArtfQmD25M78oRaWuJsEyhk/8ooPd2GRAOPEwtzQPQ3Ejuek81a5
         bo/vjYlbxtqvUyfYP3O9haqigQGDyWH9rzI43VBXy7uw3jIA5+jZ0xgrP1kEQVEKgP0N
         tzpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+42uaYrLsUYBlcJHm8ullfPiTCS0KcbQj+YkTiXjTO+U6k2zhuFRlIIlPTxZAw76wVNVTevyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAI/e/aeaUCUqHonWEY41WCfCcFD8VHeCph4MOXM4VZ92f8On
	iiXiah8seSDcYn8isHvII7C59CkJELk208NchWX2GCC/hPM7vfmsmiqdPuoJcjdwPxHDfqKVARm
	dMnALHjFPca/5o+FQ4MQ82Se9UEHZratn2HolEOsp
X-Gm-Gg: Acq92OHBsNOPZtOl9GLq5e7yuTpqyL+XehOvjiaA8ligjSVFKoLmuOf7qCB7u22lBYe
	F0a3EHGhRknzA/ilgOnbb2Ou0UOaWlAsY06vbPFd2u4y5wgvE48N+NGph/ZqQegjlCLLgGj1vVl
	ag5rfEsKCzw/0hVZ9rRaGrbeURHEr7yfF8NEBeApPLTJZ/9F8zcQiyeb2SYHbxRAIkC7k6/u42u
	hbU5zvAUPs3FwdSD2ikH/hyg85MSST4ZHGZS+Z3R1N+88rZ+3jNUaIGCkNh2XRBBfAWk38y4aMQ
	xs0rkg9qWniiqnlws9Ms+6QxwjhDFiutfNUNmbyU0nf0xE14hFpwfd7tqvZIQG6Az4mtoYemF2S
	XrchtBNe5smUrk+Nt4e2XUDYh38ThUQ==
X-Received: by 2002:a05:622a:1355:b0:516:ea2d:7c5a with SMTP id
 d75a77b69052e-517ee20574dmr47956201cf.41.1781189394381; Thu, 11 Jun 2026
 07:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610171458.1359630-1-edumazet@google.com> <20260611144551.GA972279@shredder>
In-Reply-To: <20260611144551.GA972279@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 07:49:42 -0700
X-Gm-Features: AVVi8Ce_L48lMz1ENYypIX-HctlYHw9VMkYFtnKiZNdi9gYerFPnOCdNUILp8Sg
Message-ID: <CANn89iJsh7bKrh-6T9yqzDUrEJdtW7C7VjXysdUopW6yFaAemw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ip6_tunnel: annotate data-races around
 t->err_count and t->err_time
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298165-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B2AC672D6A

On Thu, Jun 11, 2026 at 7:46=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Jun 10, 2026 at 05:14:58PM +0000, Eric Dumazet wrote:
> > ip6_tnl_xmit() and ipip6_tunnel_xmit() run locklessly (dev->lltx =3D=3D=
 true).
> >
> > ip6gre_err() and ipip6_err() also run locklessly.
> >
> > We need to add READ_ONCE() and WRITE_ONCE() annotations
> > around t->err_count and t->err_time.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> Thanks for the patch, Eric. Are you planning to send a separate one for
> IPv4?

Sure thing!

