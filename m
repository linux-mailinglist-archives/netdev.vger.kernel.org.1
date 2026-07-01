Return-Path: <netdev+bounces-303458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DcVGN3ySRGp7xAoAu9opvQ
	(envelope-from <netdev+bounces-303458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 06:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C060C6E9A04
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 06:07:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T+TN43gB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303458-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303458-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D7DA303B936
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 04:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85E37A488;
	Wed,  1 Jul 2026 04:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A6379964
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 04:01:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878484; cv=pass; b=XLJGEwSZFG76Zd4BBO8FrBY9Q+2zRP3lWjb5Fc6TudTk6jh12vrxJKaHlNCVtEYn3qnx/Nbbnix1M4ew7TYvTClVonUwgQUeH6CfdnNMhFGVwRjbQDszyni9A7nWeXq9oZjftiF442SL0qdO2xoTnETZIBJlkjtnhgRKjIpQKiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878484; c=relaxed/simple;
	bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF/vFt2iR/YYbhbQ1lgOfB5YBXLft0j1DPuFncP3HjvUNaqmrjp3NnqJmDutbGStIGlxXajjaS556wCvkUamOqDwnK494D/dOe44G6sBaJbgLa/miBh5cBQ2IJXyZ+8dG3RojFJ8UVdfusiM+LtwNIf3kI48Pc/Fn3B9eN2VeIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+TN43gB; arc=pass smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c128c8c7a76so40625966b.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 21:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782878478; cv=none;
        d=google.com; s=arc-20260327;
        b=CP/GRHIdxxhKDODfd6MsQ8V+EncW1RpI5OZbzvQyZWESXLl6zGHVwEitc8E0HiCNfr
         YK0jGbAVTi5+XjSJ4l0wb1iH9uUhjr5VFMpr7qYNDU8i4KZv8aU/l7zyxPpqte2O7QrK
         1PMreI4Rxji77xHJfUhYQZmiYjP3AbAd2hZYPyDTUsyuH21rbeAAG4x/55JtI1wja8R0
         niDWWi29Yn+i2L5Kj01eWmuO4Ej9y6AKU2pggFW4DdWBsA/VvOId7+OgkMP2sRvZXlYU
         MXpJdMEAH1XZlu3acVq4M5ZCvRwJhkD7wqAm/szkeTiEz5vS9pCDJrkrzowXxMEzPfMV
         KiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
        fh=c8VsDb+7qoET8m87XigSnZhmMvXEeSrWaG7yczHbtgw=;
        b=ZajjVYT44R5D96YGAtpNDFB6RX+cu6SdfKy6GLY2pyQucZFnkYce/ukOUDqdQWhAKb
         BOAJXmA4UhMvOHNSQMOOQdGbdgghUjxMxMF6MqRFhPPNT30jUqdKOLgiF8IyyGU5OXcf
         AaeuIPOps0RwY8dIXrdXqPLqs7uqpGYNTNaGpAt2T0QywdPqk749lB9JfS02QnvJqZQs
         pD+ppPNqV/n5WTaZOS/1mXUGN9Qo93xaDf8yN9a2YbQ0lYcQgvrcjdIq+2WRZ78QPyV3
         CLqMRYajzsk5yhsKIpJG1XPns8ZpXUTF6T0GDojZ/1z+ElZQ3Si6B9Zm3V6r2bo5D3UP
         utWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782878478; x=1783483278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
        b=T+TN43gBQVKrBdVmq3uBpm9OUZnWTc73cJaWcOQyH2zC5IFTKsqSbnW459D3TOkP1r
         T85xFxouLO0ID5qQP8ltAvZFmnSP6R1IFhEKTp8CRE4apE2+G58EGxok+Lpu/rvALvXB
         wzTm7KHngZ+6esh8D4Q778IWDHLYa25cITYjwEJ7J1pcHQPcE6tMNHobsAl9NWE9MyrX
         AInBI6vTtramaQ6gDyatXRPVXYy8CPL8qz9Sf2EmTca/0FX2qTBdP4UhiBrOWfdOdOpd
         nPnaLf7+jVMLQUt3ffEXVZCHhAgtbBGE8007E9mHQ8cwWQti6oLSBKd89yGZ8AO8kSxj
         lUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878478; x=1783483278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
        b=KN1vcJyB7PWXYIIicRqrObCDs38+TZIhwiCuviFf+3zuh8ObRXMpIkdwwWzKEqRC5o
         VRg++BEU7cRLdq1Mj/57N8x8LWgEEY6w2WdVDLKiFlg/uoT/K0bljZgQU/LAgLDYMDwr
         CMi++PKuUOSNVEAEWd45Hd7YVAJNhlEGatDRaFkV5m0shnnHlI+XBS1c/xXuKBpT0LXQ
         Gah2IZUyQ6ueimw67qWz3m93Wntj0T7Nqqvz1CxlzCRT9lRd3e0kpJRrO9PQmffcLpg7
         15DN/Oby4csWPiGoNYSXHXZRSd0Fx+lsREvxelDRTeaFo0eZZrUjKkDN46RSH6sspP9E
         hV5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpvFcIF55YuDqeBLJWXVPRVII8Vr+cPr7MN5RY+5no9w4aJyIMom6CnknHA7zcR0/+aO1H+s2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuQXvH71061hIrdwfaSJH+8R7O64hs37lJSIVCQ0mmDHYmiQy
	fswqsOqRa6Bcs8rLTxLJAEpeCjwJ76YAofhgUEd14IKWwEc5u4BjtspwSFgj4IB0MwrMFxsMxk0
	R76BlrMxVw5iGdgbmB9Pz5R8Ekt3/qqY=
X-Gm-Gg: AfdE7cmU64RTt1hzOGSbNSadyodBmVgpJ3kM3vK6Ima+2G02AgY3bjNkhpQZyWMVreC
	vWy5an8EdPuNzFDT9xM1xxGkN9Je1rAj7MWu3EJcdt4rIhYIWIU4tL83Y9wKIFLyFWrbTaYknUF
	Dt6N/RoJJp9Scf7qmTEo9peyMAC4gBYQ05osaj3e6Tp1ORUg0VCCH2Xy4h/1Oc/6N2uR5VBS3k6
	UX0cnUXVJbRkd6wf0tPB79FmI3lEIWslH0SteeR7n5T1XpVcf3o/N2EjPaAgS4MJdgioDttQqAH
	7OKtGoQ=
X-Received: by 2002:a17:907:9694:b0:c0d:7c31:26a9 with SMTP id
 a640c23a62f3a-c12a79b53f2mr2792166b.2.1782878477949; Tue, 30 Jun 2026
 21:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89ea76b3-e956-4232-8180-ee3929adf905@kernel.org>
 <20260625101132.3859505-1-safinaskar@gmail.com> <63f7860c-4f5c-4682-8914-27978b9fbfe1@kernel.org>
 <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner>
In-Reply-To: <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 1 Jul 2026 07:00:41 +0300
X-Gm-Features: AVVi8CdRVGURQNkveI8Kk-KHYrlO3h9NseHLMt2SfGvb89Oznrvksp3ZeC4J-SY
Message-ID: <CAPnZJGAJROqfCWSeeBu31HsE6nmgxVqHTNeC554S5y1Y-VN19w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vmsplice: fix some problems in my previous
 vmsplice patchset
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, avagin@gmail.com, 
	axboe@kernel.dk, collin.funk1@gmail.com, david.laight.linux@gmail.com, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, kernel@infinite-source.de, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@amacapital.net, 
	metze@samba.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org, 
	val@packett.cool, viro@zeniv.linux.org.uk, w@1wt.eu, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:avagin@gmail.com,m:axboe@kernel.dk,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:kernel@infinite-source.de,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:luto@amacapital.net,m:metze@samba.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:w@1wt.eu,m:willy@infradead.org,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303458-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,kernel.dk,redhat.com,lists.linux.dev,infradead.org,suse.cz,infinite-source.de,vger.kernel.org,kvack.org,amacapital.net,samba.org,szeredi.hu,suse.de,packett.cool,zeniv.linux.org.uk,1wt.eu];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C060C6E9A04

On Mon, Jun 29, 2026 at 11:56=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> The amount of regression reports that we got in short succession doesn't
> make it likely that we can merge a plain degradation.

Let me repeat: this v2 patchset fixes all regressions found so far,
except for major CRIU performance regression

--=20
Askar Safin

