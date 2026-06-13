Return-Path: <netdev+bounces-298962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JOegKXNOLWoAewQAu9opvQ
	(envelope-from <netdev+bounces-298962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 14:34:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD73F67E893
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 14:34:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b=Kw80x6R3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298962-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298962-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B652F3004628
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35253E51DE;
	Sat, 13 Jun 2026 12:34:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6F3E51C5
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 12:34:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354093; cv=none; b=kNueRJQCtpXJMPKVTUJ86b3+qBeAb+MbYRWtDRF3BRKBZdN5e2FRxfp0v6dc+Y7p2V2EkOD5VO2VvKQ3YF8LtOMEXyj55nH0YqILhEq3lUQ5bQhGKpy2oMW4+hu3z2fJzwgQ3ITNCmy5HUZ0Lsav69dU3A8w9KD1zX8jK8ONyjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354093; c=relaxed/simple;
	bh=RKzgdwxgKthaxdR3OVgCKwO7zeM/hLE3c9ApZM6vJMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FdB+qeItwdvfTAIVlzIYfOBp5aQl5z4EIWF0UJ1D0k1cdytofPF2d005mTP6cMRlgxpkqr951F+yLXrSm1K7DOj7uxDMn1cDmBVbXMBaNig4CU8gDTZspUhkuYEesnX/rqP/d/K4hP+T4dk9KgfQRo2px8fhrdQ9CT1FrRWTF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Kw80x6R3; arc=none smtp.client-ip=209.85.210.49
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e709dd1ab2so762524a34.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781354091; x=1781958891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7swAtj3G/hGrSza2n1NGxMHxco6j6Vf20RGZiSvZ58c=;
        b=Kw80x6R3pjpGp8sdTlOsJz7YvGc7PuQp9haUNVqjwdTjNQ2jlU3pmeSC+84sx1DeIF
         B9ZZq+yeB8I1uIGrL1GMcbVylvW2eXT/Zl3m6lCFQtHbaLuib4agxwNuJY90LkxduC5n
         Df1Wj5IeHB2m2pyh7qEN1psFc9uwoLgBKphYDVe4njEj/vnv+OXQV3ME2HR6CVnTW2Mc
         /jauRr8JJy7yMgcSffVjaPjPRyqIK46k0UP/8suMzXjVkvyaUuTvxo39S5AD8OMgaYwH
         Ge7lHxIXh1mKJVdChtq8NztEL+Xt5Js3u+3tXkiqkKS0WLznDQ9kguRB3xwP8wNhar71
         Rkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781354091; x=1781958891;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7swAtj3G/hGrSza2n1NGxMHxco6j6Vf20RGZiSvZ58c=;
        b=oWMewf4i6RWFYjF9H6XB7ohk297S7DfLtpWbKriJGDTmdQy4UyyIKsW6i1UufHalTX
         /PQgVStkExnQhmnhVKr6z2IHzAOEUE5j+y2shMWYoUtXn8KdRvZptyMHouXGGuieX02i
         z48HLK2skD2zGhO5mHzojSKS+MaB0ZLVVjXm3xK8aNzdLkHlBbQQdqQbDIW3jp8R2mlk
         vBTB1PG3wehLk552W6Cd9236cnyNxZYok08HIHMYKFiM5s+CtXUQ2Deyys97dtrVyMk0
         UNE90aP+Q400zjDXk01NWWehC4/xbbN5VMBenFUZ/lHRJGYLWx1LRIZpcj7B0Ji+lv35
         3/lA==
X-Forwarded-Encrypted: i=1; AFNElJ9nAtObsTNAv6vTJq3ch1Z7IktKO03+9bt95UYXecywBtO6B/m928DfpgoYCKAGXayRpylBgkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwx1sBEdQ+27RcDMbs5/sti/bhMsawaV2lZGG6+sYh775tgjAX
	k9s/Pwq9EwnFq93sJYzdlsIg7C8LHwiCMg6pKOGlxRY+F4y2ylYPPXAnIbHk7zcnW4s=
X-Gm-Gg: Acq92OHv4mUqg8x9FSusI0wEB7+UKg57XNqPReRRLTBQOpeLheG709jCKNKeJNMqyqW
	oFNJgcwozcnnNwmg4sytiaonBdPiQhTzhE60cAxa3/bBMqunDliEGeNFj0M/CLhxleCR4w92/mf
	toMeJaQxCHbY4+ZmuUnRYJTDZfcye1XXal+CfJJpNV2wtSTG9/3Z9G9brxLiGbJ3bS5HbE8sj2r
	3u6nww+UItcGXn0IY0HmDBwyW/Nu1DRTVhRd2M8o74BqFMJF8Dzjh9kATZwlNchuBagLxu/NuJ8
	n5wq97nqiFWVpCnK1TjODMtUFtPWmchW3zC/v/AhOIymNI69bFdNoMGiT0IK6ytI/hrM6wWS4f4
	TPOCh4u0hbtrpfqUuajJtVRA7XphU/tXA66yF850U9AguNG3udqtm65+MrKiAExthM/aWdGnhrq
	Ga2p7TUwpl6OTHkxjyHlBCLCCOPY+NMcR6PW1FHUoU9FBzoiA218GQRcSDonkVyx5oFs0iOsYJR
	oLG
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id 46e09a7af769-7e7848a9e26mr5033267a34.24.1781354090874;
        Sat, 13 Jun 2026 05:34:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e781740de4sm3960977a34.23.2026.06.13.05.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 05:34:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
 linux-block@vger.kernel.org, nbd@other.debian.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
In-Reply-To: <20260613042619.1108126-1-edumazet@google.com>
References: <20260613042619.1108126-1-edumazet@google.com>
Subject: Re: [PATCH] nbd: Reclassify sockets to avoid lockdep circular
 dependency
Message-Id: <178135408918.1902132.15354673921815927532.b4-ty@b4>
Date: Sat, 13 Jun 2026 06:34:49 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298962-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:josef@toxicpanda.com,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,m:nbd@other.debian.org,m:eric.dumazet@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,other.debian.org,gmail.com,kernel.org,redhat.com,google.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,607cdcf978b3e79da878];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD73F67E893


On Sat, 13 Jun 2026 04:26:19 +0000, Eric Dumazet wrote:
> syzbot reported a possible circular locking dependency in udp_sendmsg()
> where fs_reclaim can be triggered while holding sk_lock, and fs_reclaim
> can eventually depend on another sk_lock (e.g., if NBD is used for swap
> or writeback and NBD uses TLS/TCP which acquires sk_lock).
> 
> Since the UDP socket and the NBD TCP/TLS socket are different, this is a
> false positive. Fix this by reclassifying NBD sockets to a separate lock
> class when they are added to the NBD device.
> 
> [...]

Applied, thanks!

[1/1] nbd: Reclassify sockets to avoid lockdep circular dependency
      commit: d532cddb6c6049ced414d64d83c6ce7149a6421a

Best regards,
-- 
Jens Axboe




