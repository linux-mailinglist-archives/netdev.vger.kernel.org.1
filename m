Return-Path: <netdev+bounces-183300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23E1A90465
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EB917A9AA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC13594A;
	Wed, 16 Apr 2025 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ1QwLih"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADF4409
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810335; cv=none; b=oGxYk+dhZkcICOrl72oxs6nMK1BGDePVbGO1mVWjnyFfxuU+uCTIo7HHBiFFD0mXX8uzkEmFY93qlWAl8O/zvgMmKjzpDTOh8au08qooK4mbF3lvxQAwgE0SB/ENQHRkQfkaiYe0h3gNCRhJflb3r8j6OzFH2EcED/y1p236fI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810335; c=relaxed/simple;
	bh=+Bprm+jQzK2Qk5tEcCyXJHdixjHkT+diGVHI+2AhPjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oZY5h/bVV4inlVJDV999aHjj8hDL25+7uWYZEy07oY67XSrt/jDHnirNfuedFXGJxN4cVWWhi3p/bQcNPGLmQVGj8Y2YmcUzrS3IggcvaR/JIr80iwsnReNjofaP5LJ4iM3o0R4W1SvSasCivn1ylaRSxJx3osiBmqyDMmqZKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQ1QwLih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744810332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=457zR3h8UGkE04gyb0Jb3zcqH2gPSSk6srV8sYhzz3U=;
	b=DQ1QwLihPyWjbp7Si0S2HhuN91pN7n8ruzNJyzKq1dZ3xBzBqGAILrIFKjfBqhPOlo8IB7
	m8LtzusC4ydlkS7SLQsKOC72zlzBf8oXt0HS2BOH9PQSdFla4NRrGRocH8GwHYg+5Abxjg
	IwEDEbauOgpMNS0lBS3gcLJGcbJG24c=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-Whd61n2pPBqL7h12gRwY-w-1; Wed, 16 Apr 2025 09:32:10 -0400
X-MC-Unique: Whd61n2pPBqL7h12gRwY-w-1
X-Mimecast-MFC-AGG-ID: Whd61n2pPBqL7h12gRwY-w_1744810329
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30c04c54f11so33999301fa.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 06:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744810328; x=1745415128;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=457zR3h8UGkE04gyb0Jb3zcqH2gPSSk6srV8sYhzz3U=;
        b=TReLJ+xFekd3+Mt4Ec4sPMj7qKnAT3iYaosoiMjQxCWhDC0DWlbp246i8yfYjVVUh8
         3KOzFjBGX7ssV9kNua9ywnKv+m+/cDPIdDw0tWK8QXtYkrDxyDau6b/Bx77GPWkV/bFi
         QdGEEnvQhaHOC7x79ZGh8ZU7sMr8KmaesUDA47TAbNyAgM5Ip95KO95wfepbAxSWHjek
         DOIxwXwBKIHiNqtMUZ2mT5eru/FjXwOY4a9rifqaSwHuh9TjjGnRSymHfZ/Q2Uujt6BN
         BjkB8HRuhM6CYgrYlWpQGzitQaOWBsiUt9/yGeoCD7VY4wd/A09HCfyXmGgBq7yr85ug
         oLgw==
X-Forwarded-Encrypted: i=1; AJvYcCXRC2CEMPPM/3f7sNUbZDsQ07Qrlzn4HcbVcz0QoAh218IPGOYiCNak6W+W4lhU7HE6mNErWiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOF7LFlPZZUkZsvPyIf0GbeBLNidzmn9SNmRzEffjaN15uiQfI
	POtmSO1iGBjEn+AgsCe7L6n9YoSTw0i8S7lONZF9mbqDo92UwOOBVbKdExvBxWi3LfKVyclWqA0
	ST1+SfgnkgRspugV5NiEImx14IxbPlrCVD2kIN1Ex1Q6js5WIUmDdUO0sgvFruw==
X-Gm-Gg: ASbGncsqNlp64G+UY+7haeE2IgXKMYFTwTqW1WY+SU8Mywh8GHicAoK1/UCV2IEdNJ9
	fcAm6DqghiPEXYvkxYvdt6GQHF5XW0BfKERaop3rD/F5acGjmg7gHxQHd8WJj+18N8dXDIhjfFN
	0wtU4pWpZ2Rp4F8Z6FmoJg5EYI2vqHL86pKAv3Og7lpJT4Psl9gl/s73WIZigWssQf1ZVeSWGSI
	5kaig31MlCvvXPf+hgSAgG/I+rUzWnddvK8znzZz6c+i/gXuynFHPPLfeCeb0MbQLozZKJmGkU6
	9YWZ5sgE
X-Received: by 2002:a05:651c:884:b0:30b:a187:44ad with SMTP id 38308e7fff4ca-3107f718b00mr6731571fa.26.1744810328192;
        Wed, 16 Apr 2025 06:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElnOK3S9qd1KXpmFsBs94VTvypJz/yoSSnw9dvy8ZTso1V7fPWo4L2fDiSjHn120HodO1hjg==
X-Received: by 2002:a05:651c:884:b0:30b:a187:44ad with SMTP id 38308e7fff4ca-3107f718b00mr6731411fa.26.1744810327763;
        Wed, 16 Apr 2025 06:32:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464cc461sm23907401fa.32.2025.04.16.06.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:32:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2B5101992930; Wed, 16 Apr 2025 15:32:06 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Subject: Re: [PATCH net-next V4 1/2] net: sched: generalize check for
 no-queue qdisc on TX queue
In-Reply-To: <174472469906.274639.14909448343817900822.stgit@firesoul>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472469906.274639.14909448343817900822.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 16 Apr 2025 15:32:05 +0200
Message-ID: <87wmbki65m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> The "noqueue" qdisc can either be directly attached, or get default
> attached if net_device priv_flags has IFF_NO_QUEUE. In both cases, the
> allocated Qdisc structure gets it's enqueue function pointer reset to
> NULL by noqueue_init() via noqueue_qdisc_ops.
>
> This is a common case for software virtual net_devices. For these devices
> with no-queue, the transmission path in __dev_queue_xmit() will bypass
> the qdisc layer. Directly invoking device drivers ndo_start_xmit (via
> dev_hard_start_xmit).  In this mode the device driver is not allowed to
> ask for packets to be queued (either via returning NETDEV_TX_BUSY or
> stopping the TXQ).
>
> The simplest and most reliable way to identify this no-queue case is by
> checking if enqueue =3D=3D NULL.
>
> The vrf driver currently open-codes this check (!qdisc->enqueue). While
> functionally correct, this low-level detail is better encapsulated in a
> dedicated helper for clarity and long-term maintainability.
>
> To make this behavior more explicit and reusable, this patch introduce a
> new helper: qdisc_txq_has_no_queue(). Helper will also be used by the
> veth driver in the next patch, which introduces optional qdisc-based
> backpressure.
>
> This is a non-functional change.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


