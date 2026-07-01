Return-Path: <netdev+bounces-303486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U0h0NOy3RGoCzgoAu9opvQ
	(envelope-from <netdev+bounces-303486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C16EA521
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AtghwOvm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303486-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303486-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3667A300CC13
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7166D356742;
	Wed,  1 Jul 2026 06:47:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7C386C24
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 06:46:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888420; cv=pass; b=sRl3lMRyjZx8A1phyXEs6tijmKi3Ucp1MB1zWpsoaKQ2ZbAM1UONFNPfQF2/7T7jUjCqmF424vJUAKvSarnTmmM4bcddaqhVNc9UAyIirYIPPoTarS79yvVQCmWKKeXsJxTZelZatQXH4/58JGT3/mRoU1QpXDw1iF/LypP74pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888420; c=relaxed/simple;
	bh=TbNeNBCk6WJr1aQKbG1mmJzxw8Bu+W6bJoyIPyoG5NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbLjquyGyDNWmV4wseeqWFYmOmGdZiP1JeOyu62Sv+qNMAZme5ICvOghzFmDsGSEqRndvzTRHT7pySt/XhQv+QbS0TZtJhfA1+5A14iamrU/+MtYn8K5wIFuOewemQrIG62K0S0TIKO3GSjWmkZx3q3h/+BpOlNYvn1X6rWZt7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtghwOvm; arc=pass smtp.client-ip=209.85.160.181
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c16ac21acso2145271cf.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782888418; cv=none;
        d=google.com; s=arc-20260327;
        b=V+95e5byNhw1MwUX1m6Zfgp25QD2REvT9dOB+NEJn4B8Z11qTDwOGE5UcZAF9MEU01
         Pq40052zNfN50cBKC38mpd9bEKSxLQmdYOOGVV4AlAb2OXu/9JpSIma0iZxcwMi6ob0W
         h0QGkK0cqCPWCBwj+jVOZYJiUGiQteUMNFjhgj3nPa5xZgvwZpwXla1FI3Bbt94DZt+8
         UqxIy28jDK6sQjw6wocR2qZkcFJocYZjYMwa6MaUZbYWrfip11rNZpeXN+MnO20RwQtc
         YTR4Mf97XcmwWm76+UO6RH0dbpmYho/ktF/QbwGP5ETTQUdUkFeXEehMDznXoBHR0AgA
         2lIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TbNeNBCk6WJr1aQKbG1mmJzxw8Bu+W6bJoyIPyoG5NU=;
        fh=jFoR/M/5fGCu5eToY8dAsZk9Uy4nB3H7Xd+2ThMPJ3c=;
        b=miwyZ6qWyAYNHMznLZO/i7+wO270LmMwCUxZRQecCZNS/iuMsDxwedRQZ0xa3iZ+qk
         NLH7POVuTsyktN6ItMOb5wf4MG4lcJcNSf1fPDoiR51B/zCYYhu7NUWDx5ablfG/PRXJ
         uXl5pxaThl2escKeBim3Gd4PIUs1LgxdF5YwXbG8rAMIP7AcPhiriLCGpYW+lnr5ORhJ
         UMDTZc5YgVfuNeupwTzIF1viwWPP6s7KZX4EmbxBr+IyXmOnVSWwvpnUitwiWPGzqPSt
         uKhhGsciiY5WBFxDRdm7Y/lhzaFgiitNPpct0dnLm8LvZHsNW1nQLrI86tzDvs7iTuKF
         b+oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782888418; x=1783493218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbNeNBCk6WJr1aQKbG1mmJzxw8Bu+W6bJoyIPyoG5NU=;
        b=AtghwOvmrpmIEdnq3S2X8+Z4Cr0Td5b35gfZLodXdaHzpTQnkf86v4LNmSw0Vhh5NY
         Tp7A46JtBdfLMWdmKNW4UEq76klxVcELkGxYDxH15Hj46TCe+j04VvO7NIlVnUlv4wP5
         r6cHU/FwTADRHHO3Pr94t+vztz8xECrAEn/WweSkkChwfcPn8kn/EEcQKuLYY3mCHgIe
         72ypQH0ddlLv4jyECFVL6I3cJXPMkW0s5YCnp79I18E5otm1piGhPNxhiRYsOu+puRmE
         akDppZ7FQ9vphvDsGIpVAkA1g+MpW0W3FXjEk1VfEOicbabaUGz3/sFRxrVwoXGrVkb7
         usiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782888418; x=1783493218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TbNeNBCk6WJr1aQKbG1mmJzxw8Bu+W6bJoyIPyoG5NU=;
        b=bgHsEVGIFw/MI0mlODpwvBxwzTK35VhfWM3T4h7X/z1egC8EUIJ62/XT4eOmQIFMsO
         8pqQafwnHddaiHGZY/7UUaSPFF8NOyq33OlIY8lZ3dAyML0VMGU76JWJKb09CRRu+d+9
         /BVOUE2w/SjjLWigEEfaB0GBfVRVgMF508/3t7VrNjtGQR2Zkge7c/JWoyeLqye8Lw6T
         Jh7DhMhfvyMP2rL9uif+30MGhkuWD+3LoTRGXQjKrL//FBXXdvDNtTs++OeYozBn8b/m
         RpzkbsWt9oHx2xr6T1Ch+utXixqeA0uantiapfgxEyG86m1sZMQWOtUPbhqAejl3rF5F
         KdCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CXxopF+gTn25vuN4/KCfCZbFWipJbT6/cz8Ohss4gvH+UKftmwc0OM4BTdrdk6zbXe5LkVvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXeYix0U8qLVABe6pV3qpQupctFCHJDOr0q75dXzktIIP1p8pu
	15NYy+q/3H1a6FCL9Rca2MwYRnrP0M1XMpTsCXzwpGoav8mD+iatyxrLiYkYm0HQFc10PtAvP7+
	b9oBeQR0KOMf4zWcSUCJxLnLSQdOVlZk=
X-Gm-Gg: AfdE7clp9NMXQvQ74fVKrI+PApdYiiokgkdZDqrzrLJm/fmsa6bt9eY5hYNRrZb7Nyr
	Axju2M5fvLZOHLfJsbPiUrJ2wPNuEUxsozhQ8hoO9JM0bL9IYAv2Cn8SVPNDYQcOheqMzXGMACr
	cJWor77gnIMRAPwesZgMgXcTkFiV0RnEMoVXAhLZF4o6HB7BnZVAQVYbT6IX7BaPYq0dOb93Gcv
	V+MiScdL1UPBfrZG6UDbv2jakSBb4MTFbUzxSIwT6ObArt5EBACSICyXrVXjNd/jWX8p2VNDNoI
	5SifTS4=
X-Received: by 2002:a05:622a:1b0e:b0:51c:1c2c:a8c9 with SMTP id
 d75a77b69052e-51c26b0032fmr4317211cf.43.1782888417926; Tue, 30 Jun 2026
 23:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782548651.git.bronzed_45_vested@icloud.com>
 <3ab4a04fbab887238facc1792e02c33fd68190f7.1782548651.git.bronzed_45_vested@icloud.com>
 <20260630171016.11c02dec@kernel.org> <20260630172027.5eaba39b@kernel.org>
In-Reply-To: <20260630172027.5eaba39b@kernel.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Tue, 30 Jun 2026 23:46:46 -0700
X-Gm-Features: AVVi8CfO5QiD98MJ_hYZDu30YTUPPLdZgb2SSSCodaZKsuvmpfjVBBSuMXcYpKA
Message-ID: <CAPuPA7KMdDSGKWJXEZzSpgbdUj4_BGGX2+CedgchoD77bPd8sg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: act_skbmod: require an Ethernet header
 for MAC rewrites
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, jhs@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, peilin.ye@bytedance.com, cong.wang@bytedance.com, 
	gnault@redhat.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	zcliangcn@gmail.com, bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303486-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:peilin.ye@bytedance.com,m:cong.wang@bytedance.com,m:gnault@redhat.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org,bytedance.com,gmail.com,icloud.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lzu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,icloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 290C16EA521

On Tue, Jun 30, 2026 at 5:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 30 Jun 2026 17:10:16 -0700 Jakub Kicinski wrote:
> > On Mon, 29 Jun 2026 10:46:03 +0800 Ren Wei wrote:
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > > Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> > > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > > Assisted-by: Codex:GPT-5.4
> > > Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> > > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >
> > Let's do away with the 5 reported-by tags? You can use a tag for your
> > tool or your team, it doesn't have to be a person. Look at sashiko or
> > syzbot reported-by tags.
>
> On second thought, if y'all work together maybe there should be no
> reported-by tag at all? Can you explain the situation?

Hi Jakub,

Since February, our team's bug-finding tool has found hundreds of bugs
and vulnerabilities. Several people have helped improve the tool to
discover more bugs, and verify that they are real. I did not want
their credit to be lost, so I added Reported-by tags based on whether
they contributed to finding a particular bug.

I agree, though, that having five Reported-by tags may not look ideal.
Maybe using the tool name instead would be better. I will discuss this
with the others.

We also found many external volunteers to submit patches, instead of
simply dumping bug reports on the community and leaving it at that. We
were worried that too many reports might annoy maintainers. That said,
it may be easier in some cases for maintainers to fix the issues
themselves rather than review our patches, since we are not experts in
every subsystem.

