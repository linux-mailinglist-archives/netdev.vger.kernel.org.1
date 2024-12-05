Return-Path: <netdev+bounces-149252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3319C9E4E6C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F001881E2C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C441B1D65;
	Thu,  5 Dec 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFZjeXB4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC419F475
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383914; cv=none; b=HnRCQJWqS1eBPjEUfw0bNp0iIWoSKfcEfuMNbWiXqwOO/Y0ZV24nkoURthnTzCS+0TsBoo09H0NUrw/ONo6B90m8Kj2fr5nsMeApF4RE9Z2VPoalm7eYDJAovgVYwvsU1EOBJcl+gBqnNWBatAB8XkOJ3sEDkbFvAZYEV12+8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383914; c=relaxed/simple;
	bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+sRS/07PdwqoPI4l8V4I9zmTmnZDdTZkNheYbySTo2Ip0WH9lC7eCFuXImXCsunCZk3JL884HeTNonzXH+KclHMq7tqV8TormxCyeOzktm4rtbrP03f6v643j6GbDLxSA0NJKfqbyzcvhgacnBl0jVtyXp7tVpkEh3cYLdlzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFZjeXB4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
	b=dFZjeXB4gYftJNRM2yFK9kmCKZBSfeKeOz8atk9TKmihyghO6h0cM6s2oRCLqtkiQNWTHX
	G9tsScV1UaLSfGxzsToHg+YbjXe0X97IL56QWGo9/fifoBMUPuPWXt4jR+iEiX1zB9O59y
	5sqIssxTP3Q9wZ1RbMePAb80OaJha00=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-8tfG-YocNlm24fZiYgJzQQ-1; Thu, 05 Dec 2024 02:31:50 -0500
X-MC-Unique: 8tfG-YocNlm24fZiYgJzQQ-1
X-Mimecast-MFC-AGG-ID: 8tfG-YocNlm24fZiYgJzQQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee6eb39edaso829111a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 23:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383909; x=1733988709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
        b=nEzloNb28KIOF6zGoy7ttZziLvT5wBQD8WNXQsZCZ8dTkyE8X7UDPhpkXOoVvlZlJa
         SDkzsJ5OW5Z/wgwW87PijV672aIRAuRkdBwkkKfUSTkM0/HXfokIUijYqm5wOA52p+Ix
         M4t47SAC4jjUO+HdL53XysTRykyKUrfzXxQVWjoHMAuSu1Qqx1O1z5UY+gsjvtp2phtx
         EOHRtXYt828cWlrSqROB+La6qdhCbo+fsbaTD8EocFITvZ+BoAG1ytci6qmvCka2lLze
         mnAKWt9o2nxpqABiZIBgjHhezv5yBPBQ6sj8qHFOUZX3M3RLuFh1cAGTAFs8IiM2FgQo
         04dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs8WJEv5TLdKlik1E1FrVQgsrUP0LcbfAsKmMFEpvGDxBweJhDphDbI7fwKm8tYx/I8AdsTjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXaNZv1lESD6nMfo4qJ4h35AphbdNSXXprkNpaprpu7P5UpI5
	49xh3B5WseBJqDVrpmSoHNoaWBaUAQvMSB7xQ13Cc6qs2zs1bkDwH8nu1R7iR01bm0rhosipSP2
	ZmQ/MRQOZcnXHejwtE/SHt0uQX+543kCNyTBQf0rjbjTZosvGEo08Sc91cYofPL3l7f2JJ4LfiV
	zHkefhhNO58HEE12C0dhCB3m8EDsJV
X-Gm-Gg: ASbGnctaPMvBxR7jyonMUKf9Ptr1COT1bUbyfxCZpfU6LLYQB2+p7N17fBanBW2L/CQ
	O887Y6l8h99jaYoaDKzBFHDv8sOmFmzoU
X-Received: by 2002:a17:90b:3903:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2ef2f498ccamr5022351a91.18.1733383909073;
        Wed, 04 Dec 2024 23:31:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGixH+V19QXJVTaRQQMS7yMn8u7saE4FALdvwG/htpjGLWE45l6MvTr9cB/l1hOZceUtfHA1KOmc6KCU2mMM4A=
X-Received: by 2002:a17:90b:3903:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ef2f498ccamr5022336a91.18.1733383908747; Wed, 04 Dec 2024
 23:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-5-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-5-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:31:37 +0800
Message-ID: <CACGkMEsBKLkY5vRjWkP49LOOYmhY=Dw7U97xy0+xpL3-9Jnmiw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] virtio_ring: add a func argument
 'recycle_done' to virtqueue_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_resize() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new function argument
> 'recycle_done', which is invoked when the recycle really occurs.
>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


