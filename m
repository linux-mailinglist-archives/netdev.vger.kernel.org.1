Return-Path: <netdev+bounces-276453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DS8ESU81mlZBwgAu9opvQ
	(envelope-from <netdev+bounces-276453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:29:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AEE3BB3EB
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FFC2306E5DF
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3699D3B47E0;
	Wed,  8 Apr 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsKD0Hkp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7B3B27F2
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647619; cv=none; b=G0Xz5njc0DKXVlzrJ85NECBZ1qyKCIjxjk6FlRM01Zu21geCg64SQLCniMvHDdkQyyCY0fOmyBL45zgv8KshcbfjCvHTPI9+cmj9YtLRsWqPxAY+L8RdlXR3SHANza6slBG6fIKfgi/gjpvAEVSrwHxhdSmnluaFqJexo3MTlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647619; c=relaxed/simple;
	bh=AzehQ18alrzr2B4IsDUBovXNCXWu6SlHUOMWZ0pewVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+XIQoFoedOf9v5tZnS6nd+LsZFCB86cKv26tAN0cy+XEfL2G0eYzMNsWXsc1e66Krez/odE/jCeZkl+npZ0zrrF/pcwtGVAiCkZ0yv9UabHGCZlrl4xONgflvenc+LqzZ4Vl+V9zhUJcF3WE4sVrnEJOErYUxtQECRM5DOkjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsKD0Hkp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so41317635e9.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775647616; x=1776252416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ge0u9kdZKFhKwQUuXKTE2s3xbjDUvzv/MSs18Mhdv0=;
        b=CsKD0HkpgqXsNjJgnvcv1ObDqF2sJmD5u1ayZeItzhEm0pRTwzxeUt0DKfNcEkHsgG
         HFZQXixnRkBfI0onpORV800pN0LBi/bS9OSNqtTkPOgv3rbybTu1DgQEpB4uhZVNi1AK
         QWypWUqmF2oeu4Zou+cgRBX33kyRPAo7Yu0Yye/j9RqGoh6PXhmqQlaS3H3fmg5o5XGM
         GVTYJ8Tv4ChS7F8aIKwcrN6XXp8pCMRrlMd/Iv32DLR3r2NNzAhySOKo89fdq6nTAagf
         cXMaORSDxcyLD6igT7iMJFVyVOgafM2DgDiEVjgkMlmLXB3j7lBjG7IbTdUM13TRJMsr
         vhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775647616; x=1776252416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Ge0u9kdZKFhKwQUuXKTE2s3xbjDUvzv/MSs18Mhdv0=;
        b=LMA4A/MustjMY49RDyevqQaB3Dl8ImF24XEbJlBw78k6+S81sJNFMk1N025v4iFRCF
         Yb/p9wdjineQdWBdOpb8Fc1kNSIgjcSSQilMlsbKpv7m/b9v+RnPopBE8qbZrsDF2ErL
         qm1/yJyDotS6p2/7kALCYzVxaJhc4AyEMtKMLKjEafW8hRT0PU1ypwYlHvFgIkSFThM5
         gaN30qzi33UD7/zfVBkQ6egeRFipItlk4/w0ZlfV0soM49uv7FhSa4zfsMS/2L8FyIJp
         EXTAysRu+OBJjilCCR0bqJpwp/ZRvyKlQH/IeagDcmYx4qtvTmKy8gGGsapo4ftMzAOa
         S5lg==
X-Forwarded-Encrypted: i=1; AJvYcCV1AKsGIDYrczcbS/PHJOtdvxMUyxVKBC4CfwAAZ9gp9gaNhLppIR7Lo9MVwDecTWWGGoQnl6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/jcFam4KTxdCb6l/bdyniHZGWMN8SWqqK6cdScBxNeYRDfQG
	CAB3wPnLAs6XzelKbZRPn8F1CwoXTkMT0OcTo6Eq2UpZQvnYJev50Fdl
X-Gm-Gg: AeBDieud5Xs8gkFiwbskIH4sX2vVbPVFs/RFWJlCEFc3k0Mvayuof3mhttuTIHs0zZz
	wWafEjVUieUH78jTW9pMPjIxckGptyxQjP5ex1Fvex0bHc3i4L+ul3vYhJZ3XUhhu8NZ+m6Pxkr
	ASnmhG5V+XDWl2jM97zZRTM9rEM+v9f2eD7XyXFmee8kGFCkHnBqwB1/GNe2hD8wKNdYigzWt2x
	4in8ZfXp6tU6g0+vcSXVkq3IZiwopk7Br288+3sueCqgnHWdAgHmY61G8/YHVgY1aoB42Mq/um4
	NWQvLmJexULPtUEBQhR0TlasubDFeVtn5r2Jt+/GyheTh6oDb8lJ2iZiZNR2Pb01OHYUQ/gCYjE
	WMIJYA49My96suWEznzyBEcz2qC66PLFR53UYBJKFMrsPU9ztziRoWVAuBxvmEYOyllbOgtFNm4
	1eJSpH1jeAELBUAiDudQREVaDM4N0OQlTGps3SOsTa33lGiRVLzeHC/35LoMOYRWUF
X-Received: by 2002:a05:600c:3544:b0:485:303b:c50a with SMTP id 5b1f17b1804b1-488997352d3mr282797795e9.13.1775647616063;
        Wed, 08 Apr 2026 04:26:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5d85452sm16295135e9.15.2026.04.08.04.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:26:55 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:26:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 metze@samba.org, axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
 io-uring@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <20260408122653.295953dd@pumpkin>
In-Reply-To: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276453-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92AEE3BB3EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 08 Apr 2026 03:30:28 -0700
Breno Leitao <leitao@debian.org> wrote:

> Currently, the .getsockopt callback requires __user pointers:
> 
>   int (*getsockopt)(struct socket *sock, int level,
>                     int optname, char __user *optval, int __user *optlen);
> 
> This prevents kernel callers (io_uring, BPF) from using getsockopt on
> levels other than SOL_SOCKET, since they pass kernel pointers.
> 
> Following Linus' suggestion [0], this series introduces sockopt_t, a
> type-safe wrapper around iov_iter, and a getsockopt_iter callback that
> works with both user and kernel buffers. AF_PACKET and CAN raw are
> converted as initial users, with selftests covering the trickiest
> conversion patterns.

What are you doing about the cases where 'optlen' is a complete lie?
IIRC there is one related to some form of async io where it is just
the length of the header, the actual buffer length depends on
data in the header.
This doesn't matter with the existing code for applications, when they
get it wrong they just crash.
But kernel users will need to pass the actual buffer length separately
from optlen.
It also affects any code that tries to cache the actual data and copy
it back to userspace in the syscall wrapper - which makes sense for
most short getsockopt.

(This is different from historic code where the length might be
assumed to be 4 regardless of what was passed.)

	David

