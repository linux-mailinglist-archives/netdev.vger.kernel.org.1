Return-Path: <netdev+bounces-256530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GaNBdG3gmkzZAMAu9opvQ
	(envelope-from <netdev+bounces-256530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:06:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31539E1268
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D68F030055E1
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1282D9481;
	Wed,  4 Feb 2026 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtPOa5dO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BE4503B
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174411; cv=pass; b=kSWmXrUhj1NEUTK1lr8z2SEtfI3NfPbvtAgbTw9RgjCdSkiP3Mst+QVXcGYH2kxW4gChKzzkPWgHr8ANGZJr4n0DqcdCJWLIA0iYaiqD7hMgKWawGiNauRWUtKEy/2UnrG/sPwtobY/W0u1Ge/Yq8GU0KZVYTITt3VdqIFClNQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174411; c=relaxed/simple;
	bh=ZWoJ3GVJiB4UdADrK0/gtgENuyPcnOv4adJrk9eDXcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttPI7sC9zSJTkVFPoHtf6UOzfoKsElwIHynb7Bz1DsiTZAOw3TtFvER51HKpVCd0qvzIcvkqAf8lN8XBcn6m00Ti7j0BRNzC7pBdZRHNbu+/VWAE+8g1knHH6OpLfcnHCMa44GLQ6B6LnevOW5U02Tb7tVn45X8oKUzI7bRJAmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtPOa5dO; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-894770e34afso84211046d6.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 19:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770174409; cv=none;
        d=google.com; s=arc-20240605;
        b=PA67BDdsBcoJ40lywaMJPy+uBXY4DAYBVzObfIqPSeP5tlmXtSnOA4qS9dwOcAS+dK
         bgkHvhKmkj73fPHDomCw2btyRhvok7AJPy9WijGZVRkYKgjPmj4LwSsZ5gWJ53bdrpY+
         9LA7Bk0OhFov5VB5LUW5m2K/n0tP57Ft2CGj7l5s9PlRKYGMSES4zrrbVMwIh0p/iFyU
         0+rZ0fLg+35cg8EGvdx08CrWhr/P+hNN3WrR4jPH1g7AWN2NYtDkHflYWecjvVFZBfxS
         ZY4aIDFx/2f0zhMf3XJIYYnW1k1QVFjNde53/OCD+JC0gO9mp/dNTl1qbsdNbaHpmb5S
         aFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZWoJ3GVJiB4UdADrK0/gtgENuyPcnOv4adJrk9eDXcw=;
        fh=ER+0VxfGbjHt/c1qaFvd56x0d+lYS/DPLQrFTVUZW08=;
        b=NPCnrQ0fsdYzdN5pJatpG+34Q0AAGjmbRbLKuBk/i5NJy5P2XthbR2mKJcvGa12hEb
         kE+6NDGNQxkKXLff8VxJXoelHxO4SaMHQm7wk2sUhEcolk9Tf8pCHy9ugVL/bqTz1Lq/
         tHyk++wPPdvAHPUsfVD9ENATus/vWvDYemOF9Mq9N8QWSSkH1isKS3gsW8PmynwLgfOS
         9qF/Th1cuLags2+6woMJiCUZ22vBmppmYRuSW1QHE7NrEio4bIYjOpaPJKo0X5fcLsgG
         zBBJgTYt8ok1HnxE4CHcvRG+6LQLwK1Z6Omek9uU5qnGppI1tqmI4iwXLOLXC9W+Y706
         iNuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770174409; x=1770779209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWoJ3GVJiB4UdADrK0/gtgENuyPcnOv4adJrk9eDXcw=;
        b=CtPOa5dO97AnwqU0wyzB4PALW1a7paLejCvsgIgAMQQhyBC5JZOVtGQC0GEiSMbsB/
         ufwflHsPYSdT7wkMaPdy1WvG8Kpi8aNDHfbL0I24GbT/xKXwr8se2aGr+YbQqvTUG60x
         +RsYlBGtMt5ceHInnVUb/qKy3DLqGMrEFtY2Dt5UqT88c9VW+7gbD7NdYaNbxDJB83Y3
         h50JZ1c9dnHuAGKnnh3mmN6nLFzGj/C7q7s+i04da+gnPKmjRpQtZ2zBXsuce+4mpvLv
         nkaMMAa+U+4xS2eYHeN2J1LudkWlruzS+g+YPZTEh2ZOSB1kH9UTZi9ZJxKsoGqCm7Wf
         kMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770174409; x=1770779209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZWoJ3GVJiB4UdADrK0/gtgENuyPcnOv4adJrk9eDXcw=;
        b=kZkqpaWhYyzIali/0g/38+1YNPlSTz+bCJvTfglr0hjBd85/FiXhp7Qe2Uti7Qrxbu
         IBYyH9LkE8/6dZWWuVYiwyyrXpXf6b8s0vnZRfkccbHMqU1CJI0Dqxs+yZzeur72Bczx
         Nc7xgLzyR0KwDDshYRe7G/8DjqUyqSWKkqIrps/taoKwo64zmwC9V1yX9u2bn6NeoHzb
         lT+qe4aw+0WTU/Pxj8xuzGgpzs1gdaGdx6Eh0U+SXwMw/orcWWMFO90bNVmv38yc55LD
         jqwAIVwp9a3dj6vXriYSlibeoP/SCJd99tn9WHfezuR87b1EgelEuMc/9rjxejTuXbSO
         5BrQ==
X-Gm-Message-State: AOJu0Yyyib55jdVYwq3F6PTWj1YMBOzqIPhGwYRTRNo2NyS9FyvdKicJ
	xknL5nVsdiMrUxpjH+wZvWiFs5Ximh+//HWsdR+n0yHW8B5ncrDoohQCb/XsnHNRHtt4R6iZbrO
	pZ7k2Vzpr2ZBUIx/bM2PUIOR/A+1lEuk=
X-Gm-Gg: AZuq6aJWX3vUh8QuO2+ZfPngKxETcbQwfX0tuwUw1QDkn40jrGr7oNhZrd5zZKj66DI
	pRckhsPIZ+T0al+ph2ELZKoAlnpcJIOjKezPUMtCSKLwghIptx0osTttpix/9ma8IcfbDBbhnNc
	T4wx+CLN9c9BFKxoF6vva+oLQ1vfz7pyOTRg6/x2tcuJ/MM0whaodxsl5MpdYaHROByuqErDQ3M
	t8MxM2FmCP5G/Cyphha/Y2zoqr8uECDcdI7zAwXVWCmu1ET4p9pCAHgzZwzFlRAsguosYsRnMjS
	+QR+oGYYHjSnbeXNZD2db/51XwEmatKZK/PufqBVDpTCshfAHNTnHmlp
X-Received: by 2002:a05:6214:cae:b0:888:8248:91df with SMTP id
 6a1803df08f44-895221020b5mr24355176d6.24.1770174409445; Tue, 03 Feb 2026
 19:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131012119.25863-1-enelsonmoore@gmail.com>
 <20260202182054.0a755aea@kernel.org> <CADkSEUiAvv6eHEcLBkHRW8KFqSgcxg46+1BE25T50hT6ZkGbbA@mail.gmail.com>
 <20260203145729.5c491d71@kernel.org>
In-Reply-To: <20260203145729.5c491d71@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 3 Feb 2026 19:06:38 -0800
X-Gm-Features: AZwV_Qh98CiWL3s8abTYrvn8uFaEkcBIk2uqWpo1O48_W1et-CoW8dbUYoh76C4
Message-ID: <CADkSEUgHZEi5=pWORZv8_L8B_X9Fu3jp=BsGnjGq7a2TLHDH_w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: ethernet: pcnet32: remove VLB support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Don Fry <pcnet32@frontier.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256530-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,frontier.com,lunn.ch,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 31539E1268
X-Rspamd-Action: no action

Hi, Jakub,

On Tue, Feb 3, 2026 at 2:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
> IMHO we should probably start deleting the "QEMU emulation uses this"
> toys, too. virtio existed for long enough.
I wasn't saying we should keep it *because* QEMU emulates it, but
rather that it shows the driver is not totally broken and is likely
also working on real hardware.

> But let's wait for 7.x with that, we deleted a bunch of drivers in
> the past few weeks. Let's see how many of those we need to revert
> and whether any lessons need to be applied to next removals :)
That makes sense. I am looking into whether a lot of old drivers are
known to work/are conceivably still useful.

Ethan

