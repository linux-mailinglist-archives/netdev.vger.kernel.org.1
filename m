Return-Path: <netdev+bounces-202423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB0AEDCDE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7494D3ABA56
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D279289812;
	Mon, 30 Jun 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIV0N4bX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2565272E7E
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286843; cv=none; b=eYF1UedZJhbqMJZPdxnxRRLk4krdVb1EQJH76F2CAZnIwXrFezqj+drk+GnRDg7Uq/vctbOlJDZTCu1C4KqmUhMzj9uiAlQzLUVCzngM4iiFjMNox00X7SOzDTikx45Yk7vzarvvcDkEo/zz3eK8fWHxakpyKGxRef1gpy+xXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286843; c=relaxed/simple;
	bh=Xr7o+AhIe8W/kujSZ0TmudTZC8WByMRIydCsP7iETVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HuxrKy0lzENwVC2B+mrqnj8S0fslOTlcsjNBqJ9w1LFse5JUkxE8A7g8z/9wwmXcduFDuOwmBTdG6pO1muV6cU5m3kiH0rQD2y0VTJeyqNcSrPmlmi2ttLfFQwM3Vv9dwXwMxvLBK4wICp+T+iiAqbjWzv4m2n36e9nJBkwTn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIV0N4bX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751286840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr7o+AhIe8W/kujSZ0TmudTZC8WByMRIydCsP7iETVg=;
	b=jIV0N4bXeoyT083KM8zGjNDh5NxA0lW0YvRB6j6AbBklYkJcVovEgTmTxupADHk6fQ6hx3
	bKHT8MF0QpA8NljHGCVOxXT2P3msJ8Ef+M2bQuaUadzspLahOpXavZd81f4ePNu7Xag2e6
	e+B36rksMPz0pfhoWD/KU8c0IwhfiuA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-V0KH2cryOy6Cyyuya_nKgQ-1; Mon, 30 Jun 2025 08:33:59 -0400
X-MC-Unique: V0KH2cryOy6Cyyuya_nKgQ-1
X-Mimecast-MFC-AGG-ID: V0KH2cryOy6Cyyuya_nKgQ_1751286838
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ade5013dfe7so406072066b.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751286838; x=1751891638;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr7o+AhIe8W/kujSZ0TmudTZC8WByMRIydCsP7iETVg=;
        b=iAPQIAgZU58tk0UMbjZJFgsvngJGZFQ+jSGDxwO+D5it0SQhdiEU5xVO0PJgvGh3kB
         ITXz0s1wraMOaGEFgaxGPdJiZlPOzTcwnigoEKUOL/4oOuE9xkbve9emes5Zx7/R0oYF
         ygmuO2jf9tjyaCxdX0Dkb3eNYza81d+M7Erwq1d229a9yY6YGB1aJBfTfmpr/wb6I23I
         9sja8ArIOUyTCBx9mED5Mt4GAQz0K9CV9rJKWLpJ9zBbOHwm42mpklUBoWBXkdf5Anue
         DUgbcpPS+FQhidsnJYlKdzZeFdXnwthwu8O+euMfXOCGPFq7vzmo45DpbY5jnl9ik5H6
         2+xg==
X-Forwarded-Encrypted: i=1; AJvYcCVrrS+w2pXnv+cCNDmVNaSy1pm2EaHlaIreWQ8SpM5cLBDhtKUUfoZPLbjYHicJtUUtmmX00i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVJ+jmDWNyZKTfjwWGDQAFo+M8ujALKT/yoXuKpM3jgKkr0AV
	O9lwDuv3JHOk9/xy723DqET83gqIWBpACYDjB9NsxvovYoa6sFR0VF/fo9fP0kUVDjaUW3mwYgy
	XBNuwUEq5s1o08iZr+zN8iB6psE8Bm2R03HOCdvzJZ7dsmnrj+6QnLQfHMQ==
X-Gm-Gg: ASbGncuaD5WxU9ORw6nEM/4Pr/6/xwXYlxvVgrn2l77jpeflDzqpezaoovAmo65SgDZ
	QTtsMPfPdkBDa3bh0tP1SAcFP6bh7MgcTVriDSJBLueMZn8GgpqWtbVLbuz3aMbUuWW07hfOhSb
	wENsXcxM3GEvb1DTjKcftUmiOPGTkHu5Lb/Derj0jIki9HFx+SyS8AFoBs3DmyYY493fPcu3hxA
	7jgALel53aigcfUeSF7rWOm7BpWBreWESSWXprXeilEfwHeciJ5UfInkvMCHZDPD/tQemca/8cD
	FmJpMO1VQYg+MmkSBQ0=
X-Received: by 2002:a17:907:96ab:b0:ad5:2e5b:d16b with SMTP id a640c23a62f3a-ae34fef316dmr1364968666b.27.1751286837884;
        Mon, 30 Jun 2025 05:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuQ/3n2JvnKt441v28aLfjQg9cxjikB7S9KyuXgCMAmI7U/YvHsnBgQ7OKUwQQwaMZ+a9ETg==
X-Received: by 2002:a17:907:96ab:b0:ad5:2e5b:d16b with SMTP id a640c23a62f3a-ae34fef316dmr1364963966b.27.1751286837372;
        Mon, 30 Jun 2025 05:33:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bd2dsm667503966b.113.2025.06.30.05.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:33:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E0FEE1B37D1D; Mon, 30 Jun 2025 14:33:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v1 2/2] selftests: pp-bench: remove
 page_pool_put_page wrapper
In-Reply-To: <20250627200501.1712389-2-almasrymina@google.com>
References: <20250627200501.1712389-1-almasrymina@google.com>
 <20250627200501.1712389-2-almasrymina@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 30 Jun 2025 14:33:55 +0200
Message-ID: <874ivxh0i4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> Minor cleanup: remove the pointless looking _ wrapper around
> page_pool_put_page, and just do the call directly.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


