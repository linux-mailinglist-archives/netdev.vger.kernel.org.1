Return-Path: <netdev+bounces-98171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2918CFE49
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 12:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAE81C21EA2
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790113B583;
	Mon, 27 May 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPmE4Dg1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB713AA4C
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806570; cv=none; b=mzvyBkdDoyjBTmINWhKu8bE3Mgvu17P4n0xJFB/B2nGxFCrE8elTL8r6ERXs2tZl0hs0eVst8wYzTwA9Le5qHlquuA7HTAZxKj5yVfqWqKevUWcpehn4aQp96sGpeV2Ua9ZQci9giIEwojQUYyUh8HiQzfipkrtSgNEt8+LhfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806570; c=relaxed/simple;
	bh=gGFRH+QMQrbS92724QnrtnBFaSS9nWnZwluwJcOWqz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cprm87jyo27Apu9Up/4L8u/G7724aOMAjurqujfJUkJUdoRcrgAjCm10upLVzdVwLVvMa8WdN35urGXx6tMYHof/sh0SSUNOsyifs0cHTY6PQtbq96h0dtvDbeVJcBkwvUI3bHr61fB0Q0blxkvUGDiBQwT4gw12KPk+CQ3F+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPmE4Dg1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716806568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VUEyE7hO1ry74WdBJXpvACHQB3hHU7epD9oVNcx6XuE=;
	b=cPmE4Dg1PXt/RKSduABWa5Yn8kjB0LQmVxs9BQVzEgtm+7iHxGrbmUW+sX2Tc2/8G92zLD
	b3mWRGMhibI/4ky/NKdeGnNanLClKBJVFpvNwqcL+SvbUlP6al87K3979RhXXa9rMAv8fE
	yUOsCwovthYUmK21o1SRTd/XV6qbto8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648--7KFfnlWNwmmMPehlI8v2w-1; Mon, 27 May 2024 06:42:47 -0400
X-MC-Unique: -7KFfnlWNwmmMPehlI8v2w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3550462d388so292379f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 03:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716806566; x=1717411366;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUEyE7hO1ry74WdBJXpvACHQB3hHU7epD9oVNcx6XuE=;
        b=GWpB5PiqlfmtYFZKzKW516ckGkRIr6fthkULFAzai6A/RgBPo2xtBlQB7YmNydVsB7
         PuSMZesL4qEmYg/PusuyY4sJ1u66Zuqphw4wZGEOxo7L9vCAjiW0dxRxmdvOL+LXqfXc
         2wGKouDNec6RENdAOfyM3U1kBeb5pD7rUgFgmj2/gXBYFVmXy+WXEjgWssoBSZ5G+JDj
         2Ni8WXISNSg4ATvXxuLOY9NIITapfVBQISv+Q+LRXJouDzEz5aUojtSjVQSyhIu5qkPK
         igBEm8h8PQtLyB9dCWPDuEf6LrBPTtQkhREiK1uVc23PYQMi5OzI3I9DLLHEMHVAccwp
         j3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUrGdjebQXmHqMFRuih1YVn3NwsbCxArCbhmwMLHislEzg2iOhplfmxOZNrq2PaLx8f0pVSMjXAdgoQJcvjdnOYMExyeyH8
X-Gm-Message-State: AOJu0YxpBgb9nY3T6pXh8i6C0UfWciRc4yBrH7SaiYKBLrVNzi5AcYf8
	c4ZPISXUtR84svRkbEntlWNUjuhdYw9YhMsOWeixVJzk1CDf3SYofyThaiZ2mkV4TsnNY3TdyYs
	EcHQfzDf3hjknSKE5Zd904+fyVs7/pRdW/1oaHmy5Bnh97R8c2r7PQw==
X-Received: by 2002:a05:600c:3c94:b0:418:2719:6b14 with SMTP id 5b1f17b1804b1-42108a12f37mr68434465e9.3.1716806565912;
        Mon, 27 May 2024 03:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaleptpx1ltn8JB09LTAMZaiT/E7O048gwy6VDfsHkSc/rj6itl2ZrGjxsL5sK9VZ84ppPJw==
X-Received: by 2002:a05:600c:3c94:b0:418:2719:6b14 with SMTP id 5b1f17b1804b1-42108a12f37mr68434335e9.3.1716806565435;
        Mon, 27 May 2024 03:42:45 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fb99e8sm138002815e9.43.2024.05.27.03.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:42:45 -0700 (PDT)
Message-ID: <a8b15f50960e15ba37c213169473f1b1d893f9e0.camel@redhat.com>
Subject: Re: [PATCH net v2 2/2] Revert "virtio_net: Add a lock for per queue
 RX coalesce"
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
  Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Date: Mon, 27 May 2024 12:42:43 +0200
In-Reply-To: <20240523074651.3717-3-hengqi@linux.alibaba.com>
References: <20240523074651.3717-1-hengqi@linux.alibaba.com>
	 <20240523074651.3717-3-hengqi@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-23 at 15:46 +0800, Heng Qi wrote:
> This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.
>=20
> When the following snippet is run, lockdep will report a deadlock[1].
>=20
>   /* Acquire all queues dim_locks */
>   for (i =3D 0; i < vi->max_queue_pairs; i++)
>           mutex_lock(&vi->rq[i].dim_lock);
>=20
> There's no deadlock here because the vq locks are always taken
> in the same order, but lockdep can not figure it out, and we
> can not make each lock a separate class because there can be more
> than MAX_LOCKDEP_SUBCLASSES of vqs.
>=20
> However, dropping the lock is harmless:
>   1. If dim is enabled, modifications made by dim worker to coalescing
>      params may cause the user's query results to be dirty data.

It looks like the above can confuse the user-space/admin?

Have you considered instead re-factoring
virtnet_send_rx_notf_coal_cmds() to avoid acquiring all the mutex in
sequence?

Thanks!

Paolo


