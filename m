Return-Path: <netdev+bounces-301005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ciQ7FTT5OGpPkwcAu9opvQ
	(envelope-from <netdev+bounces-301005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:58:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D84096ADFD1
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:58:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=q32dYR4o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301005-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301005-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FEA9300826E
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C248394794;
	Mon, 22 Jun 2026 08:58:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC84393DF2
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 08:58:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118706; cv=pass; b=sje4545AbMf0AIrzQ3T+1lh3VAEZmIJz3lKLxgIyv1G4ryDaWozjciW5whRljQOM3Tm0Y59jd+y5cveoafqW5PKQFs4pWtok/c8888rkFg02JvIXG1oNLJG6uX2sytCl9aoi2b8DkelCms0Kxbd/+Mw0l1AJQw7JGWMSr8TF1K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118706; c=relaxed/simple;
	bh=iZC05FtDxv/yJdcQO2hru5qpACd1SQiM/wBZrbjqcdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0beROLKhZnUJ8alx0itsEkIi8cTzceryWCE1C9ZiQAkCwP9HRP+M8fCD1B7hDEQrU57ZGy1Fc1fvIm92XyKBSXQZY4zCYNHBqjVG6jKEEuSnNnXCD95usyOmfyspjxNXGFt4RcGDNFTcnL0SBQjxw3/iIHu2966lxj63gSneNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q32dYR4o; arc=pass smtp.client-ip=209.85.160.54
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4471b489240so707596fac.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 01:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782118704; cv=none;
        d=google.com; s=arc-20240605;
        b=GRtVorfZrr2HiX32yb3ELk995/BNCzhMFBb0g8Xfxka9Uca3MhjwIAOQSxWPmLDUaY
         1JWjQH+7aG73B72A4hRf0shzrgxB+6Oiw7URPnqvr5yroTLJC/9DeNTCzOn2nyZmvI69
         HUYVcTcPtsnBNKzXFzc18FNGF08kbpW3zDLJa1fuQlJ6t5XCOHPJ+vZdi2+E3FkFXxSc
         sWt4lfytcmangmfg/+0UzxJCDajCnn0dKROy6qDd1/1SrI0VpnjAgCe5UH3RFWagbev8
         w6o2Wsdqygb6OQ9q54xaV6EF/Xb5YAmkgqRd4HtCjkqtGrfWbO+v9nhNguRM0Sp43oNm
         sB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iZC05FtDxv/yJdcQO2hru5qpACd1SQiM/wBZrbjqcdQ=;
        fh=9QuXG6jB4vTO/uS5/INZe6/Y+U/3PVHh359aQaXT49Y=;
        b=HFd3nxYZ0NWc3/Ug5O9APsn16ayNtHiiYi0VtbdYJ8IBSlDudkCmdie4mAP2phKjVZ
         PYKt9MTCDq7LUtl33c0s1aUxZvXprDTblYqvpcUYBj8jAazONm+MAO7r1ru5I+yn+vwG
         cqXSBVfMwq71GJDIvzu23ynFtiC5d8P2GWbwWb0TCha+k4fulSGLK7wLFfdxIwA7RSQh
         hcwVcFx+5QTszZuzHSkuO+d7lPuZZLQFt+jivJQpRcdS8O0NMi+dcZ/g64TyDVq+hv0w
         1R5lK86zKZB6NV8ZG8pua+oX1acbFB11LtuybiI8XjS0neqehwHUhn1v7hvyO/3DM1uq
         XVZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782118704; x=1782723504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZC05FtDxv/yJdcQO2hru5qpACd1SQiM/wBZrbjqcdQ=;
        b=q32dYR4oCJKaAuHVgWFGrBzjZtmzxIjaecGBw67jPsG6qAqXhTS8XjS33Q089XzN63
         F6WIVb/rrXFT6KzhqzbCZMxmM+T1CapvG0REbYVNyNHyABMFizpCatW4caBOhzxE6qoF
         SYrG8g36cbrhoe1CK3K9GL+4R8XDspku2aNtzBUvKjLUZ1HGQl7xGITHqp3gH5lQLkML
         M9lXAdJ8Smd12Wp7Dt0SbHob2mR40ipE+HRr9O2caWW2W+r2iAHt1GVvWhCTnFIsDCd8
         4FKrgOM4fGfVT0UamiNnRtTlz7xNy7O9GVk3qdmTMGTvRoOsk+f+MACFU4UYJYrYF0y7
         QZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782118704; x=1782723504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iZC05FtDxv/yJdcQO2hru5qpACd1SQiM/wBZrbjqcdQ=;
        b=Aa+4iq1mi05qk5bEr1mltzW4gs2XiMb7aG3vVF8ix17NvplSjGwnhcQhhjLNsoySNj
         dASFLVvqycvrhLygNtMJK2F2NLLVy+dLIeOfk5JqIPdDPi29aMLAHkJMqbvvVKn5ig/2
         Wpj0pGO/qtDBfm96iZgin5YUSSukPMgsGAONvYeX+JpMRWREwi18Wj1K6bttka/XiPAk
         da1ogc8A15k5yyPxVfm8KMblmoMjfjWgZRKQLOfu8bNXWkCQYegYaz23fEf63qIleS4W
         iYNfzpcB/bxdTE0eD8qwjFW5+PSZu8SA94Q5Quc0m3JsVMhyUua8/kKrr+FohJybqu4W
         IBMw==
X-Forwarded-Encrypted: i=1; AFNElJ8mlilbVzn/cajV62XVzH1/opwRnG4qJOUZXpzfCUxNcPboBMLTQUqrmRmfsATcRVXFpJfsTrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbX4xhW6SBvGQI3wJ6nEMtrqnRDWUJGFFsIaODkAeeka2L3fGW
	weP7QTelAzDxPCf3jaEXU6gnGPf4dDSPTcTAQLmQuPYGzcK/uOq/kyoU/v3TaInpvig9yzYYw/x
	gSMtGHEFY6cQb42vTI+OsaLwEj2XcHuY=
X-Gm-Gg: AfdE7cmgRRt/yoqqxCGd9EfiGiNO/PsVgOe5Fw7b//5HsPhTt7QAVm9U6FG/mNJPB7H
	PS/IB3xOv07erin1W7O6clgRaXyWJ4KjA3+Cip84BGvevvjiPr0VGjgWDmCeoePPPau7FnlNGQa
	34p+c+ULyUz6gbDD91gtB/jCgKT3RiP8n1DLUFbtfYnVvFKJLa1Ozkyo3gbSm4eImttrw40kasi
	BaPIsZL/vu0IWntUuN8jzhHGC3hw9PVqlgxHNbLEdASc1VBaxyPsf2gubHlrpz4gS66FPZDmvU=
X-Received: by 2002:a05:6808:1482:b0:48a:e206:fa50 with SMTP id
 5614622812f47-48ae2070605mr6632855b6e.1.1782118704100; Mon, 22 Jun 2026
 01:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617123443.3586930-1-michael.bommarito@gmail.com> <20260621150011.33c2fe80@kernel.org>
In-Reply-To: <20260621150011.33c2fe80@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 22 Jun 2026 17:58:13 +0900
X-Gm-Features: AVVi8Ce9Zsxr7NzmbjAndTFlN3LfI-bJw98q3WYcsDOmMbKiEAS091J2EKzRp6Q
Message-ID: <CAMArcTWH4a_O+V8aJ6QvnLT1_vWxeC8yF8LuphKt_oFH6nBkbw@mail.gmail.com>
Subject: Re: [PATCH net v2] amt: don't read the IP source address from a
 reallocated skb header
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301005-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:michael.bommarito@gmail.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ap420073@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ap420073@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D84096ADFD1

On Mon, Jun 22, 2026 at 7:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 17 Jun 2026 08:34:43 -0400 Michael Bommarito wrote:
> > amt_update_handler() caches iph =3D ip_hdr(skb) and then calls
> > pskb_may_pull(). pskb_may_pull() can reallocate the skb head: the new
> > head is allocated and the old one is freed. The cached iph is not
> > refreshed, so the following tunnel lookup reads iph->saddr from the
> > freed head. On an AMT relay this lookup runs for every incoming
> > membership update, before the update's nonce and response MAC are
> > validated.
> >
> > The sibling handlers amt_multicast_data_handler() and
> > amt_membership_query_handler() re-read ip_hdr() after the pull and are
> > not affected; only amt_update_handler() keeps the pre-pull pointer.
>
> Sashikos point out a bunch more of these in AMT:
> https://sashiko.dev/#/patchset/20260617123443.3586930-1-michael.bommarito=
@gmail.com
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260617123443.358693=
0-1-michael.bommarito@gmail.com
>
> Let's fix them all with one patch?

Agreed.
Michael, could you please fix the remaining ones Sashiko flagged?

Thanks a lot!
Taehee Yoo

> --
> pw-bot: cr

