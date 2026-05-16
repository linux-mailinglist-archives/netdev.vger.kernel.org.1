Return-Path: <netdev+bounces-288610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGUIHy9NCGpqigMAu9opvQ
	(envelope-from <netdev+bounces-288610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:55:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583F55B3A4
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84D043007896
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A43A962C;
	Sat, 16 May 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsZq6v7d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6618871F
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778928941; cv=pass; b=PQCQ3uSwiS916o0aYNrH94fa3aQL9+LYCQi6szqenXCLSDxzlexgUTYd95zKr/kNjsrKYCWoPbJm5XJImfkwtIh63DzN0VJY3Zno5+hl5kcN71o8Hnc3L9j1clP8ChhTQzkAFhdy+wR8feXJsHkWF9KtUMAqJEcTv4qKdcoP+Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778928941; c=relaxed/simple;
	bh=UJm0Vha4QgPi+LutZgf6PJHq7Sc8qU5QzD/hNhrZv3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxp2xPeEiWgTZY/LqS/Py+9Ays1xRvbB5JrD8hpc4aES8vsO/CMidAa8B2pEft+9ccLFQEW93srwnJkSke0k9qGfGa30gAPp+73FLzDyM6cByyYjjSSo6k2K6S+1KPUjrbcO3tymNy2229PtoQLX6cDsVBQOQnEDcik+ZCPSZF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsZq6v7d; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bf02533706so2511157b3.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778928938; cv=none;
        d=google.com; s=arc-20240605;
        b=lPQhpPRyTABz/Lm2lFb343u9n0cSYKPTQ71AdQXxRh7xdch75FnmgN+tZQoAKD8JmI
         QU5Ugi/FxGBqejVjzU9XxoadmbtmcR7zMBZzvw9Hp0YbSIHGo49pClcWDBlYe2eUSPVe
         wqsGgzOgzQ/GNKII8gJGt7jORactk2V2BtoL0XQvk2y/FaVZnJVo61TMw1g8PXYdwrxn
         6hNU4kBBfjSBOOrn99m8/PtjBxqL4MPK9N5B87+mD2x+cjoXkMi3bEyxBFZ3hndkSuPq
         zi2mq01o5Et7llsEG68DKA9FqY4uHT4b/8xZaRuzhSV5l29Zhzg8Yx5elOIUz+54Amtc
         uqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UJm0Vha4QgPi+LutZgf6PJHq7Sc8qU5QzD/hNhrZv3Y=;
        fh=GLjAj4KRIaHgLg3EUO3pXpTE1yF818bhsdfj150VVXY=;
        b=dY4qn1592Fhx0FZQNwPrsfsimYyC0TU7jy/McjVHUnls4PZWVPTmjQZau6nCgIhVoK
         obKz/iIfWmtLEH8a+rSs6n2+LEaTnF0nUrKgconN3OXH68zCwpZ4hoB6qDmGQWldkXe6
         ALzLiBsGxwZCuicteQmsn3tLmoH19klIGC1FYUlW41/n7aMV3/246iWj5jwRDH5xNP7U
         tGfpryxY4OWwNQYRv3cQMywW6EIiNeaIBjq2OKHKTw/2rYc1fuMyZrx66QQDGFiyABCo
         LgAmmoxP+Ja0E6eVou3GiJOhaTdv1nii+OVdm3Wao1IEeSHZgxYmxp+jHAaYWzZANlf8
         tJIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778928938; x=1779533738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJm0Vha4QgPi+LutZgf6PJHq7Sc8qU5QzD/hNhrZv3Y=;
        b=GsZq6v7dZDcbSi8fd9eExCz0xZgbsKrPjDRcniLyr2qYMIeOc/shZVvAEaTFUeU9bG
         6dElielVZdZcfxecQYfz1D8rqKLXz2jLZB26AYnzRBY2TgrIjqDaAC8Y8I41Ggb3CQtq
         c9GWpK/8R/ywGIJ+QyLh/ttGTtOVLQA6fBghH/lXJzSrJP/rNDwyoDnULRuswKer3EOU
         rSXUHhEFMPeSdic6k0ivYqclBmNruqWfQU31rfq0QmZ6CcGCWSx1fNC4HBUmJtZfkvM2
         xrG1ihBNZot52uy8gaTwCLV6cHPPk92oBuW370lnEY9OVtHc4DpMNBIfvnhUfBCekTXR
         P4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778928938; x=1779533738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJm0Vha4QgPi+LutZgf6PJHq7Sc8qU5QzD/hNhrZv3Y=;
        b=I0CQFThI8eBj3zLrwANbj9CCyxA6fDl6QLBhpTZXudyX8enq2rUnVQkWNGj0gp+Bbm
         SuFBThGLh/xaYuQOtCKRlWzPniMf/lpn8O7du3wfCJuzznlAM0ZLplYKL+34xuMq2dfZ
         2ovbBWFWNxfPuZiYVIq+daj/HiaoCBzE3R/PbeKcN6OzDoFQuTOkyAiwFkoICUCUjE2K
         KgqjS43gtuK5QE8sQukffUh7wuW67bYNpTTI5rhXl67oNq0vB15yW3P430/CNZo7vkB3
         fizmHUVekJ9ETUIf69UHwQ0/5jTXwjKqgKO+gIcU8QwVWaelFHNNLwTCyoNdhpxOeYEn
         /3vA==
X-Forwarded-Encrypted: i=1; AFNElJ90BS9LhTXIgZVnvRnlPi8DJSRIKFKtKpna5h2fh6rgQKcMgmb4elSsJb4ua9rMVA3gWui/kA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJfwrPOWK/J7x38zO1FlaDd0lXTL0GtopSWlq4juSaCxwmNB+
	0IavjFHTGTRghrBLCaq8nriEhTMbNrTfEg5bRYaJ0/+HFCY3riMor+fVOw3Xxlt9kIqMILLgLGv
	SHVJMHwqQUkekwUHP9ct/BoUYgaN+Fus=
X-Gm-Gg: Acq92OEybzoE2rDfYrkMJG30x8AoeMhaoLVXqFUCU5nrN/oHpp1l47z7T6mBVqTfU/t
	LMuPXrr+UYNC8qC7s+uB1lTYwpGqNIngHxlCLbgDi770LRvFEvGY4IABFYP4oG7Wl1Z6KnkKJbj
	QQFhvMAxkNzz+Gwq3ON5RntJTFlCqEmLDKiodRTT5jtmNqAlWyRvHtm9qmbm2fpa8x9yWHVOm2E
	7cLV77YXy2adTis3elBagT/XWI0qZIhDhVbVU4ZDAmB/SoPTzGTyTj6M1cOumiaml/d4Q5WF3z3
	VyLHYdc=
X-Received: by 2002:a05:690c:22c1:b0:7bd:95d1:ed51 with SMTP id
 00721157ae682-7c95b829b37mr88157687b3.28.1778928938365; Sat, 16 May 2026
 03:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87se8mytvv.fsf@toke.dk> <20260512144512.9960-1-bernard.f6bvp@gmail.com>
 <20260512163648.7367a640@kernel.org> <CAFAa3YDcBsCnEJ1t+a3iHhzxW65HX+QNkZWPKHvDYp_V+UwZYQ@mail.gmail.com>
 <20260515181411.28af7ffc@kernel.org>
In-Reply-To: <20260515181411.28af7ffc@kernel.org>
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
Date: Sat, 16 May 2026 12:55:27 +0200
X-Gm-Features: AVHnY4LM44c5zj8zy_QkFpcfHYCBiRpHUh4S3nKYrYR_oB3folOtDOnJ-b_4rwg
Message-ID: <CAFAa3YCx0schCKn8k-nPfQPSaQ_5PKYFzt-5j-ZyEZbKr2DyuA@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
To: kuba@kernel.org
Cc: toke@toke.dk, stable@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org, 
	linux-hams@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2583F55B3A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288610-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, 16 May 2026 Jakub Kicinski wrote:
> It's a GitHub repo so PR is probably appropriate there.

Done. I have submitted the five rose fixes as a pull request to the
mod-orphan repository:

https://github.com/linux-netdev/mod-orphan/pull/1

The PR contains six commits:

1. rose: build with hamradio_compat.h on pre-7.0 kernels
(compat shim for struct sockaddr_unsized, required by af_rose.c)
2. rose: fix dev_put() leak in rose_loopback_timer()
3. rose: hold loopback neighbour reference across timer callback
4. rose: fix race between loopback timer and module removal
5. rose: clear neighbour pointer after rose_neigh_put() in state machines
6. rose: guard rose_neigh_put() against NULL in timer expiry

All five fixes have been built and tested successfully against kernel
6.17.0-23-generic (pre-7.0): insmod, functional operation, and rmmod
all completed cleanly with no crash or leak detected.

73 de Bernard Pidoux F6BVP

On Sat, May 16, 2026 03:14 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 15 May 2026 16:52:43 +0200 Bernard Pidoux wrote:
> > I am happy to submit these two fixes as patches to mod-orphan if that
> > is the right approach. Please let me know.
>
> It's a GitHub repo so PR is probably appropriate there.

