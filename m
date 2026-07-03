Return-Path: <netdev+bounces-304512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ycZxOrmbR2qMcAAAu9opvQ
	(envelope-from <netdev+bounces-304512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:23:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B4701CD3
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:23:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JTDZ1FAy;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304512-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304512-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A399300F57D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8A3C1F5B;
	Fri,  3 Jul 2026 11:19:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3136A36A
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 11:19:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077587; cv=pass; b=HQu3npQQA75sFPEgr3GrfIKTeNP1v4y52HhgAWB2ig/HBg9dk0BwvyGUI3HlTRdppD3R0tILL7LaYx43cp6BBs+MszAGbP/MAGx0ESO0NkdUebuCX8pRA8wq2IUZrqwgVGWB/9RZjzxJ0eGEstRGRmXEbUqZHGRuWjSq/4dKF5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077587; c=relaxed/simple;
	bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTbLkAZORcUbBpjURUQG+NxYcR3D665oi9t5/6Ak1t6niRL27CcbOc5iz/QZlcaSklCaO/WiRcKb/smkKcq3mODGRfDG4aRUOouqOHaOsej8W3GQEiBabEGWn3J6KzWWA19snspOWtOWmrxE2Mk/50DNXF7R01TIxwpI62+/5sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTDZ1FAy; arc=pass smtp.client-ip=209.85.128.175
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80e24970f1dso3415237b3.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 04:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783077584; cv=none;
        d=google.com; s=arc-20260327;
        b=hCI+ItY/73yp0Q2MK9jFuLSz9gNqveU+zYA61w+kCPUQFiZOshGOD9y762Gc4+g0D9
         AuTe6KYSheTE+vsRG0IlyQ6v1klEp7uG6DSKDsoKZlp9gdG1HtJWzpzP1QqGBfc74Q7K
         EW77gWuX5yxJAntnpFwgn1tA64oAPrAfQdy6tMycuMTxJLvCVtzpw4ryo7txjcO9/Luc
         BtEjU5rd1cX7sX/qM49zMuQjxbandFzms07WnN2HSVqKNf0gHr6dcXzm4TAVRQ8Cv7ym
         8PvoZ7NpZZ2IWZKgtKONNyOFZ+XIXzk/VbQfMCik0Ho2bAHc3uoNC98sKu4yp3Hz/aGY
         sWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
        fh=o7KEBBCCTfLaATSW4ArJ7+32f00LsKadOlbvtxNY120=;
        b=gclpOaMTbAdZPRyazbJnArCyRYzv+SWHpL5CUU3wJtjJEnqW0GU9+NZjIhImdzFr7z
         tSrJ3VEXSAVtjrChHFcmk9oEms9q8x50AkxrkoC8QzCZBhtAF7QzCjcVofDcRBEGr/62
         PrxGQBA1Wd0hAJGA/TLi60gT/VhFpEPxOM+IkLbaG4A/kEQ1n3iHoCYWg0vbAXeJ3IYZ
         edYvLIVj5G9psg6VXQSF7eYhFckDMP2C5SoD51Ci6nosLynwu8gZi+Yqv8VJ2KTtHSEB
         w340xGCLdLsirbg0ulEaKV1ZyNS9rfVkVbP2FmrEitTXA5ufTBJYWzN7zxivvJd2hoPA
         hmEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783077584; x=1783682384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
        b=JTDZ1FAy0nlpJMAUJk4fkIaePwrfF8e7uiKGYwEQQc6VQ9EjRyMHgZyG8rCDATz50G
         AASt8bINGeFULCGM3bF5Uq7GquZ783w9NHJ/iryn/OqkOsK/YbPF8d1MaWiserKBEfU5
         PphJ6xcZGvykbwfxUg2c2oTNoOxIAwHlZBCi1PWzaydsPj2iOi6xMLwUlfi55d5sh39f
         iQ1YbbMEdCLOJ+OzWfNWWK+tv2VjSEdgMZ/CE3C6GUFkJ5GC9geumnyRsPNkm5myGJ7D
         vzYlGpg3IRpuCvOMReRkHyPo92gSv/AKGOlfAMObDAdKf/UL8NLAwM/8rRxm/AmT3gQg
         kVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077584; x=1783682384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tne/IiURknu/rHjBvSNsBcmdMgimIOJxTGUJSZf6l74=;
        b=UcEGbEzTdBuihPFoYnOvqPKESuc7qR7nhRx1ocN4MyY0ttle+6HSBMJnyS22g3EeIq
         EG8yG4aD87RXg2R3iwbVEST/t+/3lAROAqN8MEX66nvFsK1HRVyIP7pzvZJIIPzG0P0l
         FRwOdXJR7EXqIwmajSqYSeVb8Nbt8APCtLy6aUgzGirJdELyTz20XC2bwTZAHL9afeEo
         lvSkClaKHah5sVyFlQgff54BCNcRLA81WEHhiW9y9Sk3ZuP8Kz0qfDiG9Ybi9UwjJwQF
         pVaNSMfyfA00iyxh3hqHNNsV9HwL8O+VN2eS2GH8CLH/kpk0YksGd/Oh3C5hxaCDyqjS
         Ymxw==
X-Forwarded-Encrypted: i=1; AHgh+RoBSovEEFy4eONvhoFji1RJ+oajlV1IF3cwX3oj2ZcH7L+devikD+tdq7QL0HoL2h9qwprKSY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6N+k5jgvwplAYKaZDHy3dZ4lAt0XCD4eb47wGywx2Vi2Q1/O
	F1T58EV58INRG5EKoX3V7QvkGOI5V+I7P9G/QkLQHotEyb+ahQ9S0gocKfjdZhvdYDsKV+J80LS
	2SWHxCnCUrVv+xtdCM2Y+s8XIF1SOUAE=
X-Gm-Gg: AfdE7cngK8OysDFS07kmgNrk6hNXgoJgmBR0EYYDFTEIUMlJWS6Np5udblhtQoxI3q4
	fhR7T9xK/tkKo4B5ekiabW2mWjvT5MobPcUh7TqKkkWutHjUlGGS6X5k/nkvbOWKk4zaroh82Rm
	cz3JG78IMr4ef0qh7sVMzDLKNUB909j0HLnmn4HEh++EiUp8sa1BHYpXgs/7xgXTaOczwyf1Ky7
	omi9YhysrVC13/bRUolefQMVTNjxtiJA9gQt2rkjDyKK7assD8CQJL9ozIivze5CAAwgrF3Tw==
X-Received: by 2002:a05:690c:7307:b0:80c:85e5:8749 with SMTP id
 00721157ae682-8138b1721b7mr93282977b3.71.1783077584023; Fri, 03 Jul 2026
 04:19:44 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 3 Jul 2026 04:19:43 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 3 Jul 2026 04:19:42 -0700
In-Reply-To: <877bncnx25.fsf@bootlin.com>
References: <20260627235805.17310-1-alhouseenyousef@gmail.com> <877bncnx25.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Fri, 3 Jul 2026 04:19:42 -0700
X-Gm-Features: AVVi8CcoY5btWDQlEBKCdQnuzHazbJEJeoWIsXdznqL3lACOC9I6h18j1gdrN64
Message-ID: <CAMuQ4bWf+o_ZDMXn1tTw30veo-30Mt9XZehT8BPErJ30Kx_95A@mail.gmail.com>
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering hardware
To: miquel.raynal@bootlin.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304512-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:miquel.raynal@bootlin.com,m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com,m:alexaring@gmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,4707bb8a43a42fca2b97];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 607B4701CD3

Hello Miquel,

After ieee802154_unregister_hw() returns, the driver callbacks that
can replace phy->pib have been quiesced, and hwsim_del() has exclusive
ownership of the final teardown. The pointer is no longer being
fetched inside an RCU read-side critical section, so rcu_dereference()
is not appropriate there.

rcu_dereference_protected(phy->pib, 1) expresses that there can no
longer be a concurrent updater at that point; the protection condition
is the completed unregister rather than a locally held lock. The value
is only fetched so the final object can be passed to kfree_rcu().

rcu_access_pointer() would also be sufficient for that limited use if
you prefer it, and I can use that spelling in a v2.

Thanks,
Yousef

On Fri, 03 Jul 2026 13:15:46 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Hello Yousef,
>
> > @@ -1004,12 +1004,11 @@ static void hwsim_del(struct hwsim_phy *phy)
> > list_del_rcu(&e->list);
> > hwsim_free_edge(e);
> > }
> > - pib =3D rcu_dereference(phy->pib);
> > rcu_read_unlock();
> >
> > - kfree_rcu(pib, rcu);
> > -
> > ieee802154_unregister_hw(phy->hw);
> > + pib =3D rcu_dereference_protected(phy->pib, 1);
> > + kfree_rcu(pib, rcu);
> > ieee802154_free_hw(phy->hw);
> > }
>
> Would you mind justifying the choice for the _protected() version,
> please?
>
> Thanks,
> Miqu=C3=A8l

