Return-Path: <netdev+bounces-294041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM0SLeh2HmpsjQkAu9opvQ
	(envelope-from <netdev+bounces-294041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:23:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24063628EB7
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E35EA30205E0
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 06:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D5357CE1;
	Tue,  2 Jun 2026 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwV8BqG0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E430100E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381412; cv=pass; b=Nt5M6y0Zu6XE7oOVFm5b4eyHtCdtechT7EqYoMM662qIt7VoLNJonb/cRbCzfEPn+lvn/02g7c1Lus0HkDBFAbWAucwDRfbXERqfRYz7PkR88KaWsJ1qfHlGfQHijXnnHXvxPIywCMjx8INhfiUHosQud3KcSc1FjFKoX1umSLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381412; c=relaxed/simple;
	bh=bHbWohJPBF9CHwsWq93xd0EknGGk7dN/OkRGS8+4yhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4ulqlCf8y/h7Y5o9qisb2cmBDCn3mVJGs9LCHaGz0Cx3zkUu47RqtdkLOTAbtzh3JYdlUVarz/1bbXljmbBUi9EzfuwPlxjs53Cvg+D9MhE8raYS2C/Hw3e+UbUT9Rp/YvDqM7mCmXbv6y4GDZW0ygIrgjnylFMt1Rko1pqKzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwV8BqG0; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490a762db7aso15735975e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 23:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780381410; cv=none;
        d=google.com; s=arc-20240605;
        b=UGPXLotaoGA6ReFCJtbBDApd0Sm9mgG0S97JMk+X+YEQ3BXhXap1v9gwM4kPgvFhPz
         iVemp7cCxmOWUsZlWwoIQV9+uLcSSFbWPCiAJJQE/y7ci3MF5jO134D9BUMevsutNAkd
         NMRxifQgSh2VybNFk4g6Nx+Kq4h7QNTmd7Zlau1qV6hyI+GRAnO4Z+gj8JSBaGxPi9P2
         UyR+65O91dGf/LWNlY9JjDkhOGdaSpzbEjFX1uGClLNHpRWGC4Peb1wh6tGBnI+P0ngb
         G8bLl6bz4afFn13nVYVJkHbF9o2yd8gm2KYH8TJMwWmwV2uFgyrEquRQhBaW1jvhfwD+
         zNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bHbWohJPBF9CHwsWq93xd0EknGGk7dN/OkRGS8+4yhU=;
        fh=d4nLNAPUJWPcIhxUZqGLkBMuCAyCsVqoTQcIYAGHKS8=;
        b=JG9h/TmZKod64G8hZpQ41D6AyIv3sGdqjfcjAnvN91cKHSQfosl7lOkazvvKLNVl/W
         gpmWNFjc3KT5cAejzrg1gra2QWBCMIPe0QgOF2ETF1fF576tokxHGuA0ATFM/sI2NQiM
         ghLto1FKDynGupop24e03THzDCwo0cXbCi6knNW/+6wjUYNUUe0HkWlIFveeWvTsw/iA
         pwx8cE6hgXzWKs+xZS+VG4J3l5it/qsB3ATu4Zpt859k+4KsqBJPhUZKRwyz7+vYWJS8
         eNZGXYwnKpqHAocPK6zkN65JpXiI1Sp/jJ+0qWLGmE8dyeRUGkhaD0pGmBMNYOGTsRbN
         ixjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780381410; x=1780986210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bHbWohJPBF9CHwsWq93xd0EknGGk7dN/OkRGS8+4yhU=;
        b=YwV8BqG0EOkI7v3fATcIFQS3dUlpA99MAPW4bat1PnQTcYNpdeMlZdKM6Lf4RzaSlu
         0VAfTi/qIiRRvcK6Rq7RzUySUPhAbG59uS7oY/KfvZfmrxxQRRkiAJS6Le5SfkoUxjcP
         PGoPVaEactBylBghfr1A2lIln1YQrBOpLym1O7wNoDjRXglaclol1ggcyyOan3SLnI3/
         gLeuMLzTnLLQhSxXI75X4TSZHIxVjq1ygQHfptpSSeOw27wKf4RaEbMPi7yVfQPsrNSb
         YdbrWjEYlPXoWulvVY+O7sGeEUYts7YByHe84gsbU65BQdPQzMnojwC7lDJ9bZJRZkzL
         7Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381410; x=1780986210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHbWohJPBF9CHwsWq93xd0EknGGk7dN/OkRGS8+4yhU=;
        b=nKv70kRaDwWEQsoEag8Oy4FHZee/tyOVy8TSUOX+1v2OrBseTkYWT8Za0rCfvqNlbp
         nbyJ3+fOoihDw8OTR78BhlVLUzsC9PStoLEj9LeAv8hUL3J0qnJF0WxJXKOR+2zmMBtr
         KmRXHsTQm5NdqqdNaHoNUavMmqdTmkni1HeXmdoSIxkaXXVoshzvNg/tJtGGUUnE2jjB
         SKBM+nqAFvmAKLwgHbtrVzB8TzDGamC3at2cAr5cVngRr+PxD5fL+EOpnB5GtPn6vsiA
         Ii2EI4jhOq/+LdycrW6gsS0UHTUnJhUVl6l9ayOG9Bgs0Ni65ds/fDEDZyeU3V+lMBOd
         TDAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+y1LDAgzI6bpJCVxeSFYLM11/YZvxuTDT2k2wgPsDWzGfirW7whHA5yzpPu9l45uJG5Sq3JHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOVVAHu3upVtzYhm8EQ2ktrxURZ9joBk/YaY11+lPr9xbmjhZ
	dGRPs9yEYyqX5lMAwXiDQFls3T1KMmDJbH7UvHpHj5N03qGGkt1Bu+zwytjeu6d9EukpuEYZIzv
	VzVcASF24g7QK3Wh3CH41zIS6W2J3r6E=
X-Gm-Gg: Acq92OFN0fjgPCZv1BRjukRHtvnLRvX32t3Czlazgw0Kb1+xZqKNNcUH+PqSPbilDaZ
	TgCGstuih/OrruotsqUQPiA032a5GTRM6LoMNHH33tamd+z19WAgNcnmCbq++D7sox64phSwLh3
	7Z28V0SwcQtkOLqwVwus1L8liGOvvHIJnhuFkvcpOCWoeWNp9IK1il4d0/BmD1Y2CsauFX5DbRp
	GDg90ENCn7pwUPfFOIt8rmzl/Q1K6Mh0lPbOSD47vTgzosBCNAnupDnQZmNLPgbesvKlRRmu6nf
	jk7MAJqub038Tqw4Zg==
X-Received: by 2002:a05:600c:6592:b0:490:a1dc:e542 with SMTP id
 5b1f17b1804b1-490a2904ab0mr275922295e9.6.1780381409619; Mon, 01 Jun 2026
 23:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601034148.1272080-1-maoyixie.tju@gmail.com> <CABAhCOQ7Sd2G4ZVwNUK7i6cF7v=CwhcYosvYAgopb=32aNimZQ@mail.gmail.com>
In-Reply-To: <CABAhCOQ7Sd2G4ZVwNUK7i6cF7v=CwhcYosvYAgopb=32aNimZQ@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 2 Jun 2026 14:23:18 +0800
X-Gm-Features: AVHnY4J_sOxDZYbF_hzxFAN6WDTC4_Z74hTDLDHSLVwE5BKSjGzP4QlCsca9gCc
Message-ID: <CAHPEe=H_7Cbz2-QQt4fTM-tAUNnRnm4wxRZ+TRXHkz9Tdqkerg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: require CAP_NET_ADMIN in the device netns for
 tunnel changelink
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294041-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 24063628EB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiao,

On Tue, Jun 2, 2026 at 10:10 AM Xiao Liang <shaw.leon@gmail.com> wrote:
> Should modifying params that don't affect tunnel lookup (e.g. GRE_CSUM
> and GRE_SEQ) require CAP_NET_ADMIN in link netns?

ip_tunnel_update() unlinks and relinks the tunnel in the creation
netns hash unconditionally, even for a CSUM or SEQ only change, and
ip6gre_changelink() does the same. So every changelink writes that
hash, not only the ones that change the endpoints. That is why the
check sits at the entry, and it matches the ioctl side in 8b484efd5cb4.

You are right that a CSUM or SEQ only change relinks into the same
bucket and has no lookup effect. I can narrow the check to the params
that move the bucket if you prefer, though that means diffing old and
new params in each changelink. I lean towards the entry check for
consistency, but happy to go either way.

Thanks,
Maoyi

