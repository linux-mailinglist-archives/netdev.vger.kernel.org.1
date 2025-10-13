Return-Path: <netdev+bounces-228838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A49BD4F54
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3B973505AE
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2011EEA5F;
	Mon, 13 Oct 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpSzwZHi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6F17F4F6
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372606; cv=none; b=rF9R0cYJ0juJMoRUb/JYIFaGc2iKNfSryNxdX50jweS3Jbli43uZmoLTvwNg671ds08128Y59AEVtj5J3B/93z51RjOuHoIUxf+DAkWF74TDHJ27Ij8t7mbGutB/Xusv7Al9qh5mdBVk52OE7eAkNSwYxE+JebAuFNgmGVL+Oe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372606; c=relaxed/simple;
	bh=lsbB8/lJ+Gx0UTZH8AOZnuzYbyHnzKv4F9LUcq7NEVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eka2FjTp74hu4Lgn1uLST0TxuWjngTRtr4SURq6QzCp6OVofMHX7DI55akqgdvi0cxvA9q+69s15r8qxHwMr8cX5Re61nZxJlPoumoZAsWNmpT30nQcXs/uUTvFUgsn5XTHyR7IdipAY8aIoRb6TUwe3kDIInzlLaiDwTa0UG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpSzwZHi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760372604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsbB8/lJ+Gx0UTZH8AOZnuzYbyHnzKv4F9LUcq7NEVU=;
	b=WpSzwZHirHWsUe+tmvSxOZGs1kQZN6To48G6r/9s4FZ2guV93LU3sEP3d19p29w7ZJHz7j
	kwF+NU1AEgWiUKuLsBBHaij4XfXBZESYlZmyYLzpwLyj4VTTLmTfL+71BYwHpIU+iX+n35
	IuoNRm6wqT7tBEt+obpXii+QP0oRbjo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-CcA3-vVzNZSHmVrY6m3bbw-1; Mon, 13 Oct 2025 12:23:21 -0400
X-MC-Unique: CcA3-vVzNZSHmVrY6m3bbw-1
X-Mimecast-MFC-AGG-ID: CcA3-vVzNZSHmVrY6m3bbw_1760372600
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-633009e440aso6465300a12.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760372600; x=1760977400;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsbB8/lJ+Gx0UTZH8AOZnuzYbyHnzKv4F9LUcq7NEVU=;
        b=urTiqusCuDEkR/I2LOtIY4wrgzcksXdhCpbnLR8xY+/ugXD+3ku0asvpUIfBEkiTyw
         QEAHtTAXQS8DQnZwDBbYMKRrlF8+z/4BP3dJgrBWrIR7LsdqMe+i5xDWsFihrDPZtI92
         MJyxjb5rf7H1ACA6SQmAHy9epVXTsO7PrBOL8iIXVwfSX2Z98RrBs4FacycPPLiTkOsC
         njGoKobh66ik9D71rC8Xf56QufrE/ZlHbx4o6f7pTxBAsoJv2fmEBEaTL2nZXm6XuX+Q
         Oh9W+gpzzwLo7boefBsCJ6133b5dP1coV6WEsWMPleo5PS4hpy++ZG8zktplhnj+wn0p
         0KPg==
X-Forwarded-Encrypted: i=1; AJvYcCX4qFQzbobSuag7tk5IIrM4WQBXtVmgM09kTx1p044O1D+uvWHOp4FS+yPYEyeNmX/B/KXmkJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCyQe3b2ugXW4iVFkMleMG6rijHSzi3v23DuCOLWb6v9W/Zzew
	thZVijuft1gJ+wHs8bpv7j/RoKU0220vcWQuRJ9auCE90S9723gG939z/Due0wT6sDbmiBYvdhn
	n5UgixNUVWb0gg00s+OPCsUQd8L4XOcqeowA24YB/AGpsZ48PObZWO09smg==
X-Gm-Gg: ASbGnctbH8VLPuo7RLNit1N5QNsEV8qBSax+d8jIl+de8kRNVCAQojraC3pZ5ugzMWc
	m8JNgkN7h74OQQLvPmXLcrNn3onkLWOOGHckwmggBoaVf9oPM6ulOvwsYPT8IspfJOK9VzDEltO
	GKTLqVBIgb/Ytzq3aKKZ3vqelNRTZaWDXsOn1qhrq6WQcEs15xOrloy2K5NsIGM03eEjNrIkBH8
	4v6mQVa/qIr5zXEbnMSRXMZLzOGrzuFJWzSLymrEnRo/2FolOtQ2lpAAR687mqd+T1Yy7X4zw6C
	ZWy7fL9vXU5ze536tY8rqJcOkBYajtiQ0M89KHhS2jjfYwHtMeySxndnxxRDQdLF
X-Received: by 2002:a05:6402:c8c:b0:62e:cbbc:8736 with SMTP id 4fb4d7f45d1cf-639baf0a86fmr18149194a12.8.1760372600270;
        Mon, 13 Oct 2025 09:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Bx0WckEf52gyLFrFyPmXvHBPflo/MPtXSPH/d61HW50+E3cvB28FiE2w39IrwhiCveltvQ==
X-Received: by 2002:a05:6402:c8c:b0:62e:cbbc:8736 with SMTP id 4fb4d7f45d1cf-639baf0a86fmr18149179a12.8.1760372599882;
        Mon, 13 Oct 2025 09:23:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a461703dbsm9251500a12.0.2025.10.13.09.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 09:23:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B7BDB278A12; Mon, 13 Oct 2025 18:23:18 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v1 net-next 0/5] net: optimize TX throughput and efficiency
In-Reply-To: <20251013145416.829707-1-edumazet@google.com>
References: <20251013145416.829707-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 13 Oct 2025 18:23:18 +0200
Message-ID: <87frbm6aa1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> In this series, I replace the busylock spinlock we have in
> __dev_queue_xmit() and use lockless list (llist) to reduce
> spinlock contention to the minimum.
>
> Idea is that only one cpu might spin on the qdisc spinlock,
> while others simply add their skb in the llist.
>
> After this series, we get a 300 % (4x) improvement on heavy TX workloads,
> sending twice the number of packets per second, for half the cpu
> cycles.

Figured I might as well take a closer look at the rest of the series. So
for the whole thing:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


