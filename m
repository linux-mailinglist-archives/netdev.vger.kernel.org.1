Return-Path: <netdev+bounces-284927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH+jAMFg+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:39:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A71684DD6B4
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 954A8301F347
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF54494A1A;
	Wed,  6 May 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vI/leYgS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693124949FF
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081936; cv=pass; b=fr4/hGKPzmq5JGo3GqQpwJn0NhYVReT9U8819SgvBD30xuqbJVTPn+4KwQmtDrJUf0VFiYdWOg3TXhXJH0ug8wlknllvnnbAfZaXjV7ytCjuTaI3lL1HwggY0Bo4zv7JS/EqX2H/alm5AstBBgCeeOgEDcycXjWUuowbuYEQRV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081936; c=relaxed/simple;
	bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xz9QHsGCJtV2Kek3ehCbhbim7F4JfmAHq5Nzos26ZUSHj+ufWQO45Cbgydothm5B6TeYDO+Rl5wMi3AGk1iQCgLqU+b7bhPEH+6a3K2w3iuwbAtRsoW/49NFA0NcQzRvQCIOjybTXsqssLxOz4+vec0tcwX7NAnuwM/w7S7m1Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vI/leYgS; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d87c138e1so66300081cf.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778081933; cv=none;
        d=google.com; s=arc-20240605;
        b=lK00ksvnHaC9Dp/ZqXJ2HUnbYmjanIPOSKr1jn/ZDjOh7EBDGcz4Qk9Tw2spKx8AcE
         +fEWjPZm+wYzudv0LUz5JWlkSUIglMogb3JE02O0KoovQB70LvjczqIXvzmHlceDZ5ag
         Zt+LYKGzp84l2biYKZiEI8CwIvrSFPCTFbzMpSfMTlNvLEnzxgWW0UzQwWeI1+JKcLGt
         rmwZVjOWPqA2jFklVbF2jn7kqAk2MDpoRx0SbJz3cdVQvPyX7PG4tjjJZyQaInX74KqT
         909SsW8DORfNtNLAxgZmZL4O3ANE/cf0s/4uijkfVUespb7HwZi+h9vR496lTmCnzCEq
         OeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
        fh=rQG1hGpDKSkXcH5SmPABDfA6hSKHIC+bBENDHwQecbQ=;
        b=bb3RJYDrmThB3M+bI1OH5gvIS5bx/YI369m6oa6QeXgY37MpWaFbDyFca4zde5CE9S
         8hs68EXJK18s6QaGQRAEEcE8aRltXqzRVOB9jWuW9Q8e7NBA0g5Ok5OaZxmHCJFxmZkF
         KYuCB3IHc6PiAaD+Wqvc663F/yFECpzEns4JzIIKpf5HuwibOTne5M/Brq+/sSMvFfqp
         b0Py21+JVGvwC7To915mIFYlERibB5xcsxzne54b+487f79V11mrUjohnTYS5hJnx3ki
         bPhZ3H+cWnr9lk9XsQ9+HZaFPFHhW5SEOaEogx2elECgoJdt6gQzrcZnE89CDdoCuxvx
         Eu5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778081933; x=1778686733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
        b=vI/leYgSKSdkGtCHzOOsfZzB8bQLoTLFlSFqzokAA5W0A15tHkce7hD4vReh3yOTs+
         SYMWzDap8utv3MtQcOrLDVwZdRF2NB2UsMEPUzKLc+8Y4ehBQWdqhTC3ujgUOhNRg7ZY
         4Le+rUsb0rVIdi17jnVCKz1ptNKCw8FX57dfh01XV/AORmzlx6TETrf+U93kTvPXIXkt
         MA/gJhEEbqwHuxIAgFmTjQ8T2HzmF1dfvrSmb2USgH5LaZJWI+FaTLaqSVCA4pHrYp2l
         NWHHoqM9XX3b8j0BT5Ep4zazCL2mxAxZm5X+xUNK8Og47C2O4bXYTVrCjdr+O7ARwkoK
         ykSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081933; x=1778686733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
        b=lEyI7Rdc0bErv8XSBoVAsNsLTPYBO2CeGb0v0zxtYbabPdo2/d1nV507oXAdsdZl0P
         OQ0xdHJjd1m9hw9+v0dY1QQ8Kvq8+LQVcXnIrSHKSS5TycgtfwzIbNxTPrOJaZpuoqdq
         XEPLhaZet3ipPffPNToLlO/0Qqs6ZZqeDEMvGPaafr3TX1LyhNTP+9EOtg792xQkkgmh
         tpvUkxEl6IDsXfwLorXd8i4YwkxFiXqXIO6+aJbMULFusijJ8Ssz7JWvAMAZT71pcfIo
         hbH89lvQLwvMkO0WDaHIdFpjMdY8vDjzl9lZmRbkYMc6sVjcjGa+bz6RPj+DyVDzmN7I
         ziBg==
X-Forwarded-Encrypted: i=1; AFNElJ+FYLohy8FbQsp5uKXJj+2GAOScl/ja0mG5dKUpeTE4ECiW8cvTsUg9xubQ6OIC+GkJw1aM1jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCHUqo7O2WkCbWxRQ/X86O0KpsKSh1/CibrY7B7+EOKsGMDZ1D
	Z5kkxCixTUEkFpmq6ghrlU9V+e0WBHbrbkryIC1oDUq5Ghkuwc4FSHaUGgJYRTfbJhAf85iqXS6
	+q5hWWd3ipigIfduMpMX9FsKOjSZbQKQB80GsGEj/
X-Gm-Gg: AeBDietCRlc3pW79bm6pr6SW+BQR2Lrj35MfvRhC67C9mJcYw6rVFgT1MSnq3CeImMu
	x0nnvecEu35BHXkw2524e+5JQwOSiLS72sdM06l6f0rZ2faX2BY9SoqARM8g+PCEr08DAxaY9bl
	EcFf7yv+tuVW36qaJ1Mx5QAytNqMEPT7Sw0tnl9/MR6pvYMSgVLeHzvMHxFvmG8AFYJ43c6oYqb
	NGUjyLUBWl/9vzocymOdoAYLtHsXgJkC+C3qi6AFukzpgcg3+Nbi6uEYFVbww//tpSGxXRYDss5
	B3M+0O1VKcPueHzOcNM3SNtVz0c9z2cA558+5PsGhioQhErzYBaW8e82dCmgFrU7m0RftAHgD6k
	BfUOjSRVD/7uBBqnKHHPSJPhXnoU+ivy2Kdv+h1M=
X-Received: by 2002:a05:622a:48c:b0:50d:e298:8f1c with SMTP id
 d75a77b69052e-51461fce4d5mr53275791cf.32.1778081930259; Wed, 06 May 2026
 08:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430122653.554058-1-edumazet@google.com> <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com> <20260506111507-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260506111507-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 May 2026 08:38:39 -0700
X-Gm-Features: AVHnY4JGcss5DSvVQJ4HSN2zeUaBN69s0ioWUQVWnh7DFq6P70Z49QIoeMVTrAA
Message-ID: <CANn89iKWhJp2N-60FC4JpX2Dw0sK8-vk2WrHkDOnkgC_c8nbHA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A71684DD6B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284927-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, May 6, 2026 at 8:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > There is always a discrepancy between skb->len and skb->truesize.
> > You will not be able to announce a 1MB window, and accept one milliion
> > skb of 1-byte each.
>
> We can if we copy.

You mean, ignore VIRTIO_VSOCK_SEQ_EOM?

