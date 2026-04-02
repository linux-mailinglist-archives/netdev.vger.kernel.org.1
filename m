Return-Path: <netdev+bounces-274417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBtzMDwjzmnElAYAu9opvQ
	(envelope-from <netdev+bounces-274417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:05:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 382483859CA
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA961300A52F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23FE396D24;
	Thu,  2 Apr 2026 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTzCRsRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B02395D93
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117043; cv=pass; b=dRg+3BR7/3V+9wxXvlcQMLJne1razxDCoHKE7ER9giX17Qew4cFo+nKEuRCP5qTHbmqWK/jnUnyYI0g0bnrn+FwhruCcFBBLDuTcn/jr8rK4OXoz+M9vQ48zRh6FQ/j0MJtilqltJI+kQ/8ymgJTBRG3ohNf0ZRDWVD2UkVS8AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117043; c=relaxed/simple;
	bh=ZSJEDCqzQpNwg2Pez1uKarHOagG8B10XKu1G7yflVSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKUjx3oTwbyro6CNOqecMc2HUV6K/cu+gjOR/N7JM8Rsp9EAW/POUtrPi45XI8TrBd4T8OYhoSazi/wo22boxfALiNf10idVstloDlo3PRwuRxIvvRfqxMI4FGuF4lByveUTJGBRKrp9P5SeFTLnE5GsERgWV4y4Ved83VO4ahs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTzCRsRd; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89fc349b5ceso9766796d6.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 01:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775117041; cv=none;
        d=google.com; s=arc-20240605;
        b=IGnIbYg65GOyp2mHFV+LulfTCUChjnmqq6yUPK1tvDaU/lnUfjkxkBuqs+StYnKhPJ
         HRgdObZT4rbin13XrMZRpvGxrI1VaA9gHcmkPWXdySfejcj2tvEq47E9UXCpJjYV5cQx
         +HjrwrEIRJERKm+/D8gPP8FnUSJ8unPRfPWTvU8dpzVqLTZKf4Sb2u1bLT3nEtVvUmET
         fykA6y3HPb1c/K9R+Njnr2VIvPo4WWp8G/pgRfiEu0ghR2Ji6XorWD7NRzL8ofoRx4+P
         FPPg/YtIh/1t8gk82oPO/ZAheLi6edltlCvZXenRXO3w8AbR6QCDk7gI+UNFjtTU1n3s
         FSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSJEDCqzQpNwg2Pez1uKarHOagG8B10XKu1G7yflVSc=;
        fh=ldmlPzGG+XzgNgSK5UXd6gCYAsneKP/yaCgbejaOPTI=;
        b=Scn5bcqNQ+mOC6jL6AbsAVW9ANDLvHbjCYBi9nY3RozLhJTtBGYXgcgclnB52CZQA8
         bi33/j6dudRi9Ftp3jxMrPFyNPIJ9YVS00cpt32c/WA0aWtPyBf+AUct5p1LkTtBB+TL
         E7lHPI5KOZl0p5pXPTSfx+5c0GrVePWJnjS1NSsBFEIyr1cbw/iB64naXcSw/PnF2kbH
         RAg+hkvvfmPU7PmC/bPnSlEw5thSZTVTLJ4c/Zw6/VyRSzXGj3h0LaCs0iZJmcwJPHHJ
         um4qhqg5F1cqpr540kLGME6SrDLLi3Ax3I/oYfiFINIm/94Hn0BLmWLIzZcCDafRK3CR
         r3Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775117041; x=1775721841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSJEDCqzQpNwg2Pez1uKarHOagG8B10XKu1G7yflVSc=;
        b=NTzCRsRdumbqdN8cfcLLj2D6nbLedW3B85HzhykmZMiQ+PA4ePfugICmqRte5K5v2K
         +GzUVOJHZZ9+1sgedJvD+MZV/NnpKa00aHpV+q8uagaR/4J9kEsTnvJ7NGXBK27ByxSz
         braAX0GJcCswAYDdBBHB99ku9cznbi1EyJ5r6Bc2qx/HlJ9l5bGxEZxBwbmFUNPQ4HkW
         RgFUeQE/NXNnFQtEzihDAFaD8CHXkfjoWBKpuphjgXYU/QivQWjePwQ+CIowLMP6IYrj
         2qrwHR8/hKpyGdQm6CSBLEKdwYKZ0OUAwZKZN8Qbr/+1zIrnDattMrsNZDqf0IVfnY0X
         DtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117041; x=1775721841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZSJEDCqzQpNwg2Pez1uKarHOagG8B10XKu1G7yflVSc=;
        b=KCDpkMKQDFMbAb4a4Yeo5A8plHg0LDqBjxDKainzxi3jVzjXnXcBhQVduyLmBDZDbh
         PjRvHfC+Sgs6j38O3qM6m7eJwtKlQthT80DcI38rygep17CZRrcugpaBxD8bFuwkYoZC
         i3UwRplfSTHwFyzlITRkLJLVFvL4D7R7/YKpm2oqqGgVfw91V5UmMgM02qpHkA560bDr
         IcUpzY5oXuavs2ZvABw33pWmOiI4j9HDwFKL1jGyQDs3luoQSRYo3Qp+cDh3MkgZ4d8h
         wkdY132pESq8lN1lrHAhr8Ru89ei0rDX6S5A0u8w9SMPrbnGpXmSRV9pCulsQIyQOM0p
         mbSA==
X-Gm-Message-State: AOJu0YxlqhX+6gCoWmeVYGuxeuZcnliyGjM5iAPjUaQA1FlSerWjyoIe
	q+Fa7tUBlrkii2z1Lfs1OzYcqPJ3krf9TliLTz5KgiKl1aWgZFJSO48w6cqmVil3L+b7sj242SC
	rnOJvptpojqamhbPvBAOG7rSk6up/oc6eCFb8/ryP
X-Gm-Gg: ATEYQzzunUCJS8xYUmANbyQlFc9w8sm2Y96i0U+OS8RWnElKTN3GADnCVUKFUXfaJ5f
	Txu/Q3+36bK0MS1s3MLTicRLX+D0KWAWx2V8ZzzqnU/ywCkPlkYKanaUmKCVQ5NWo31Yt+xmaBx
	kQcroEfzkHwMWpht9Ief+nPArQ8M1T6v90cOd0w9cLPF7IgiPMICDgWRXcOhJIasM1uQX8+Hlo6
	DWPZJKkhYXzr+9yJAJsjGH/b03P/VgRFsCv4QDUC2wf96B6QKN4+uAhnsJKklbR9aiuINFoUIEW
	2Z0M3Nqi7IcjWAvBxkA=
X-Received: by 2002:a0c:f099:0:b0:89f:d316:2b01 with SMTP id
 6a1803df08f44-8a437f104a5mr96099656d6.26.1775117040984; Thu, 02 Apr 2026
 01:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402033138.388574-1-jiayuan.chen@linux.dev>
 <CANn89iLdRZd-qO4tRpSGamHpggh=r5vM4xes5npYCnkwcNG89A@mail.gmail.com> <ad90b2a9-0f67-4796-94bc-9dbb76a575af@linux.dev>
In-Reply-To: <ad90b2a9-0f67-4796-94bc-9dbb76a575af@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 01:03:49 -0700
X-Gm-Features: AQROBzC4i4XqI4fo-eKWxUd2Cc5ktCNVV0BavblbpRz-nP4ApUgDItg-uyKcNc4
Message-ID: <CANn89iLLwk9G6K8r=hOxsQQ2AsW751E+2pOoud9c-R+R-3i6hg@mail.gmail.com>
Subject: Re: [PATCH net v1] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, Mina Almasry <almasrymina@google.com>, 
	Eric Biggers <ebiggers@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274417-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bluedragonsec.com,davemloft.net,kernel.org,redhat.com,gmail.com,google.com,rbox.co,fb.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 382483859CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 9:15=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>

> If we no longer care about the cost of accessing a struct page in the
> free path, which the original commit was trying to avoid, this is
> indeed the simplest fix =E2=80=94 kfree() correctly handles objects via
> virt_to_slab.

We only have SLUB in modern kernels, kmem_cache_free() needs to touch it.

Using is_kfence_address() in net/core/skbuff.c is pushing too hard in
my opinion.

