Return-Path: <netdev+bounces-300167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 37FjJLaWMmoM2gUAu9opvQ
	(envelope-from <netdev+bounces-300167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:44:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA2699D3F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:44:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GKJHUjok;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300167-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300167-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9149A3008D18
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53D83F0ABC;
	Wed, 17 Jun 2026 12:44:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D13ED126
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:44:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700273; cv=none; b=DW/24uQFrZQ2fMKGf/NyoKi757hoaW9+XVNFisbe+DbrLvFzx6Z7DDMMePlkf1wF1HTFfdEXEiq/O38+PM7pMYhpeCICEOf8obbf/qMT+Gw3kEG4DwBsj45ntb2FtxZwnx7LIx78lpQVY/bBUD4bEeqa+JShxQK0EE1LcGKveiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700273; c=relaxed/simple;
	bh=qtZpg6+SNfqVKkCzu8nevfRevHrYlcFg9kiIrAq1Sj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iC4YrFtOj+RUruk6XIdtynilhu50BZxYT32ETxJuBW6FzNSCAmowU0cwvHl43MvTh+d5xk7h77iPECDGRpRXu9D3ofvmvzy2QbwpL1Syptb6rDrYgngsyXMWH1j6Ib1+oc3pTl+kIU0G5xjfNY8XU8qqOVFljJ3UXAQHJVsn8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKJHUjok; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so2762376a91.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781700272; x=1782305072; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtZpg6+SNfqVKkCzu8nevfRevHrYlcFg9kiIrAq1Sj4=;
        b=GKJHUjokMAEgqtyd7JW5vvdy+sdj1XSLQet9y5JBdczyi23ki1WQ4JdNsFIFt0+8LM
         FDnyQNCqDT+DHXgD/LdsRvvvZN9AVZGtlfvoE9RSGu7hP/yig0K0cvJe0JKXexP8/kZm
         iY2a2bAX2x0rVkAayoAsu14rhxsYrxFEZkTxWyeLNuH5fKK+HyTeX7dwtGNHceRWSjsK
         aQtvGgiP20en1k09umbZOTJ3d7/SMs37ydq/tgjdgF3FDw4m3xBGoN++j3Or5MI9+l2F
         d0AkZkdQXyVug5KKwNA9lSLgDQWBvrMTdMG+Ka75hOMGjqjDPyhOTuokL399iIKWqqDy
         xc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781700272; x=1782305072;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtZpg6+SNfqVKkCzu8nevfRevHrYlcFg9kiIrAq1Sj4=;
        b=jywOj8Y73OYo0ZxWqrijyHC2RWKes/J9vtB9puu95sPRNtP+mTT9b3CWoz24xUQKLH
         YRAWBQCy25x34mKdvAukZixcFiYk99y/xEyemEr6/hiYlbhleXjSusCOsvf7sCxED1Fx
         sJGIvvoCk3r6gRe3ts15cXlmC0Tc2hIkhR/wg5NowkyR1UvPlhWWpluTkrehvLWCLbFz
         GIuZ4+18kk1uSnBlPvOg2je7dSaQAegPqafVDTPhskz2e6t11UPfBSdCvR4BUpQ750I5
         T04XuIY0MQIp9omDZaFH8zBr0YujOrsuA6K3Q5kISVjbd+LAgcyvymGyY+3iN97jdxsk
         2+5Q==
X-Gm-Message-State: AOJu0YzoAsPtYt6vUHtwgazR1af+jeDghR8PIcML949oQAazKrDx7es4
	pIvd95CbASSnEdvPoh8DhD3TWwm+08IzhSzoTuo8T73k6heYnF+zFmYszVk/HpqipvHf2g==
X-Gm-Gg: AfdE7ckrPZJIirKWjSbAm8Xl/r643S7XECMGDJgun5NkojclmmZa5pAkZ16jXoJhFvr
	reQTh6UpvJm9t/l550uWVaRTpKj/atiKgUkemSrQk8ojlCAlUUtWtp/zk2Cz1H/hwSqBnwxL06i
	D7RhF1+PN9Qfxi9iShaLE2vWF8K5iBL0LdyeHZNlopyvjlbzFOI41QIeOfkhCHxbu1vKqlfujR8
	xyOEl6pGw7W+v6f0tuQztL4jQ/1zf/h0nptBDNhpp/nqF1k7HsjK1gJFE49mgqqOvuMl1Jb0nXf
	ORHLbiDJA48vXvLqvRaUn38NhQLuKa9LVVPkqAF6NPT+SO/65abm/9x6D0aUD1HnVo+YHFYfQYE
	y5BT5awbPzcnLZ7pYZE5pj828TCoitEO6sIw5xbYke5Af7ecDo3Jwicbjjd1/dyzIV1THL0iM0z
	7Ja2FiR5nq
X-Received: by 2002:a17:90a:7347:b0:36b:b4a1:2939 with SMTP id 98e67ed59e1d1-37c9366b4d2mr2876234a91.15.1781700271792;
        Wed, 17 Jun 2026 05:44:31 -0700 (PDT)
Received: from [127.0.1.1] ([58.240.122.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae78csm5987071a91.4.2026.06.17.05.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:44:31 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch,
 angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject:
 Re: [PATCH v2] [net] net: airoha: Clean up RX queues in airoha_dev_stop
Date: Wed, 17 Jun 2026 20:44:26 +0800
Message-ID: <178170026659.2238511.17652659042899875248@gmail.com>
In-Reply-To: <178161160256.2165161.14322392784449633554@gmail.com>
References: <178161160256.2165161.14322392784449633554@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-300167-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EEA2699D3F

VGhhbmtzIFNpbW9uIGZvciBmb3J3YXJkaW5nIHRoZSBBSSByZXZpZXcuIEkndmUgcmV2aWV3ZWQg
YWxsIHRocmVlCmNvbmNlcm5zOgoKIzEgKE5BUEkgcmFjZSkgYW5kICMyIChSWCByZWZpbGwpIGFy
ZSB2YWxpZC4gIzIgaXMgdGhlIGRlY2lzaXZlCmlzc3VlOiBhaXJvaGFfZGV2X29wZW4oKSBoYXMg
bm8gUlggcmluZyByZWZpbGwsIHNvIGRyYWluaW5nIHRoZQpxdWV1ZXMgaW4gc3RvcCB3b3VsZCBj
YXVzZSBSWCBzdGFsbCBvbiBuZXh0IG9wZW4uIFRoaXMgYWxpZ25zIHdpdGgKTG9yZW56bydzIGVh
cmxpZXIgZmVlZGJhY2sg4oCUIFJYIHF1ZXVlcyBkb24ndCBuZWVkIGNsZWFudXAgaW4KZGV2X3N0
b3AoKS4gSSdsbCBkcm9wIHRoaXMgcGF0Y2guCgojMyAocS0+c2tiIGxlYWspIGlzIGEgcHJlLWV4
aXN0aW5nIGlzc3VlLCBub3QgaW50cm9kdWNlZCBieSB0aGlzCnBhdGNoLiBJdCBleGlzdHMgZXZl
biBpbiB0aGUgbW9kdWxlIHVubG9hZCBwYXRoCihhaXJvaGFfcWRtYV9jbGVhbnVwKCkpLiBATG9y
ZW56byDigJQgZG8geW91IHRoaW5rIHRoaXMgd2FycmFudHMgYQpmaXg/IEEgb25lLWxpbmVyIGlu
IGFpcm9oYV9xZG1hX2NsZWFudXBfcnhfcXVldWUoKSB3b3VsZCBjb3ZlciBib3RoCnBhdGhzLiBP
ciBpcyB0aGlzIHRvbyB1bmxpa2VseSB0byBtYXR0ZXIgaW4gcHJhY3RpY2U/Cg==

