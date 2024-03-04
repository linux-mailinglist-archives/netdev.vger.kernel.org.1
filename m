Return-Path: <netdev+bounces-77178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAFC8706DB
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877821F225FA
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A24C4CB3D;
	Mon,  4 Mar 2024 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhIW9S/s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156C4E1C1
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569122; cv=none; b=kxVYqtyJQahcWsI+a2PDj8SgAwU+gC61BjtoCLDvVrC/PLVhdhYvfuP4n/aixuvKqYqisc6dMrBzkFVYrjW4jiTdUIP1xHOq1/inAi9DAbih+6Oi1fqBMEmMJfQPcxB1qiwKH7YmPQEkKhafQxsn3HTNszI+btAWcT27Swb6q3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569122; c=relaxed/simple;
	bh=Ue0kMD+TPKPpYdI/+VuEw7ttwTzBUYwqU7bVLUMNuW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bD2Hn/sOSc+Tz++ZuhBwjsLYE5OLr369K75vsbPmKEkHRrNpHEGL7yCMFpQkKlhRdbH3gtgkPivgOmaSaZhKe19recKG0bBI1jzuD24pPY0p6QJdkjxYI0RvG7lM6Ay86ksIkIbJOUmuI8eDyzOXksQAxdQxvMYKHxw7vCKXKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhIW9S/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709569119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3otLaVP9dNO8UyNHTiZ0D/xIZgw3UUdt9yJyKAL/JYI=;
	b=fhIW9S/sQn+vDbIKF+9pcvH1xl7M2KUR1eN7DOZLnIUG2fcEVA5UTa39U9LbrMjRQWH4cI
	J7a2+BJK+cQIOTcJNHvSNqddyaWtAbnHqdDR8Mh2VlehKXruDNfukL8SD8R0ldX+XdIlN8
	kzlFsmNTp28gJo3x8Mug3YL3m/LVUGU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-zsOt2wwVMsSR8HFjGulJWQ-1; Mon, 04 Mar 2024 11:18:35 -0500
X-MC-Unique: zsOt2wwVMsSR8HFjGulJWQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3377bf95b77so416551f8f.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 08:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569114; x=1710173914;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3otLaVP9dNO8UyNHTiZ0D/xIZgw3UUdt9yJyKAL/JYI=;
        b=NRUbYgk6Zx8rfbeIvA1IGO2lQW4Kzlmg9x3gG0cixs+MFf618c1YxwOnU/danji994
         WEFknpRppCIdOKiFEjQ7/ZtvQ/PqvXcAcMNybl2XiJ0kfVrdShyF2DDzw3iuTzmgbCAw
         1Y2cUkGK61tFfaF3l2XfLe+aXjmb1dTkrVGQa2GGJWvGS69b/0wBP369UAXAoVsKjeT9
         nuaQTwQKi76zp3OzvjnfNBjbtwRwz16uCL57iGisZcUXDUf1gsoIdd9TUr07VW4stTuS
         TLrVz4Cj3tcDxKwJosyVXKwUhTNvAUp1g+LNqIuBYqzTGfcHL1X2mRkRBK7MkyNebtvw
         YbQw==
X-Forwarded-Encrypted: i=1; AJvYcCXMNZ/NfWEFZhJUJQZYJuBukBwYVbAeihAb9AAh6lkefj73H286uE4e0BuVokAvE/pcK7LlBwGaq/khCn+eAFqEnFQs2lIJ
X-Gm-Message-State: AOJu0Yzjy+IfGlMbdvJnl23ZF3SprpnOxF+2EHL2w9F5sk6NWIASj+1a
	20oSPeH94iLUPjHIwijbPVieo6ffE7VJ65JlpbfZoMLU8iKp/hipVNxyTB3SYk4mXtPofqij3yp
	/gMW+H1+GZ2iEWi/NUUvKc7CHdzCRdSutMS/S4is1wJ+B2gxyRG117Q==
X-Received: by 2002:a05:6000:400c:b0:33e:1eea:33b1 with SMTP id cp12-20020a056000400c00b0033e1eea33b1mr8421315wrb.4.1709569114718;
        Mon, 04 Mar 2024 08:18:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB1bzyg4YcPtujewmIPQW7Ua2CMQ85ppHFDPUxnDvW+3DIkX/usdNr4z0sXAHboZfpIhEG/Q==
X-Received: by 2002:a05:6000:400c:b0:33e:1eea:33b1 with SMTP id cp12-20020a056000400c00b0033e1eea33b1mr8421292wrb.4.1709569114313;
        Mon, 04 Mar 2024 08:18:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id bo23-20020a056000069700b0033e41e1ad93sm2139574wrb.57.2024.03.04.08.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:18:33 -0800 (PST)
Message-ID: <04c02c854f030d3cb0591cd420f28c57994a0aaa.camel@redhat.com>
Subject: Re: [PATCH v4 net-next 00/15] af_unix: Rework GC.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Mon, 04 Mar 2024 17:18:32 +0100
In-Reply-To: <20240301022243.73908-1-kuniyu@amazon.com>
References: <20240301022243.73908-1-kuniyu@amazon.com>
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

On Thu, 2024-02-29 at 18:22 -0800, Kuniyuki Iwashima wrote:
> When we pass a file descriptor to an AF_UNIX socket via SCM_RIGTHS,
> the underlying struct file of the inflight fd gets its refcount bumped.
> If the fd is of an AF_UNIX socket, we need to track it in case it forms
> cyclic references.
>=20
> Let's say we send a fd of AF_UNIX socket A to B and vice versa and
> close() both sockets.
>=20
> When created, each socket's struct file initially has one reference.
> After the fd exchange, both refcounts are bumped up to 2.  Then, close()
> decreases both to 1.  From this point on, no one can touch the file/socke=
t.
>=20
> However, the struct file has one refcount and thus never calls the
> release() function of the AF_UNIX socket.
>=20
> That's why we need to track all inflight AF_UNIX sockets and run garbage
> collection.
>=20
> This series replaces the current GC implementation that locks each inflig=
ht
> socket's receive queue and requires trickiness in other places.
>=20
> The new GC does not lock each socket's queue to minimise its effect and
> tries to be lightweight if there is no cyclic reference or no update in
> the shape of the inflight fd graph.
>=20
> The new implementation is based on Tarjan's Strongly Connected Components
> algorithm, and we will consider each inflight AF_UNIX socket as a vertex
> and its file descriptor as an edge in a directed graph.
>=20
> For the details, please see each patch.
>=20
>   patch 1  -  3 : Add struct to express inflight socket graphs
>   patch       4 : Optimse inflight fd counting
>   patch 5  -  6 : Group SCC possibly forming a cycle
>   patch 7  -  8 : Support embryo socket
>   patch 9  - 11 : Make GC lightweight
>   patch 12 - 13 : Detect dead cycle references
>   patch      14 : Replace GC algorithm
>   patch      15 : selftest
>=20
> After this series is applied, we can remove the two ugly tricks for race,
> scm_fp_dup() in unix_attach_fds() and spin_lock dance in unix_peek_fds()
> as done in patch 14/15 of v1.

I plan to have a better look tomorrow.

Generally speaking we have a timing problem. This looks great, but also
quite complex, and thus the potential for untrivial regressions.=20

We are very late in this cycle and likely there will not be rc8, would
you be ok to eventually postpone this to the next cycle?

Thanks,

Paolo


