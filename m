Return-Path: <netdev+bounces-91639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B628B3493
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1671C20F08
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00D13FD82;
	Fri, 26 Apr 2024 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eu3nt4dq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843471411C6
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125219; cv=none; b=lcPbnsAOuvm9T9Q5xabMsMsYiVB9csoQI5kj7qBmqkmdTl+OxXLLz95TOpN0cBRQ7mqFz5uc0oLCNnYg+X03/MqblvZA0p9LhJxCtrYOyVAnM7mW+qM23ABzQsPgToZdS4HxL6sEy8QaiNe8kVVYBENcPU0eC3v9ZF0EBN21Ztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125219; c=relaxed/simple;
	bh=ZXN0gs0K1BRAaFQ7PMkpCXOAbHruTTGKUfJyFA2Pgr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tdlr3xarBME5rTuiJMhF94+cr8Szv19lZlaa59qbfkYPBuLs4m+DZaiVSaHhARGibNjAuDmyVPqaiTUq1+E9zKGWo+wT+WyV82FNqGy5skaWd0nSrZfmGs0tL2/ZqnXfuWdRiw4rsNitSJzLjqEnxdEvkdIrjH0jKhFAwkhcjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eu3nt4dq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714125216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xdhA0L/FT5p9+GsCL/jeeC5DkMMMh3/RT01Rp/cFgsA=;
	b=eu3nt4dqmUse+zSMaAFgNnemdb3fYmjSOrchqXiuC6Jw6RtPwTM0pDMlOVoGciCTttDmOD
	fsa8V3xpeRixMqbny2xBbjdeDFxNTY7yiVssR7NxLwyx0WxvC+x95wX2mZMed51987Y3o8
	q2h9PmpC363A2jDA9Q0IT5naNVDIHB4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ddnHSID8NHqIdRgdS9jC9Q-1; Fri, 26 Apr 2024 05:53:34 -0400
X-MC-Unique: ddnHSID8NHqIdRgdS9jC9Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343eb7d0e0eso270210f8f.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 02:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714125213; x=1714730013;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdhA0L/FT5p9+GsCL/jeeC5DkMMMh3/RT01Rp/cFgsA=;
        b=kWn/3VFvoVGAqwa2oFTK+c9J+NNJ+6dqst62BTvSTeNpD7UfD6SeLhgtvN4WVu1Xfj
         L7UGS5lBASYGkS6+n39PKiXKeDxs3L0TSWwcO5KN4b2p5MbBMFU7ilQh0zIFcoZ0qhtK
         I/3Q8ygN7P7cBaiCNHBa9Ylst6AyX/jIe1m386eo+3ugf0CDPhyhUN3qX+vroyl3gBKf
         UCf1PHcObpaDuk4PM5LKrgYsDYHlajBQle1gAgzOJQvHhK0m3+tPIvzGYIfd+1RjTGz5
         GMqkRK/8fdi8hSgTZsNutjJH2eTCHScR0qwR0h0glaAHvKrjSr+OGQ0PWGT6VLuZgCAd
         Qunw==
X-Forwarded-Encrypted: i=1; AJvYcCXVjUcdsrxgrOCZaVibA58UiHsadCmieB9IPI9DXeHaUbUNviXvN3z2q3W8Du5EsspbdfWVPz7WDuhTR1EQmVmK0sSazpFg
X-Gm-Message-State: AOJu0YwphwmlcUAnOnRGAT2knkSop3zJc8ar59+6sKl/T9xtqT5smGuq
	0f3t58HTOm+gE2Ieia4JXrPdjkTxMQk6uHXsn2eYcyko1+pDp7jR1vyi6wfMtoL6/P3DJv+/FnP
	nLNRT6D/CcVThlGvfceXNgTWBwXRD1Moz6wcW6Qry73P4xYLBIfwf5A==
X-Received: by 2002:a05:600c:35ca:b0:41b:7ac:f5e9 with SMTP id r10-20020a05600c35ca00b0041b07acf5e9mr1559316wmq.4.1714125213453;
        Fri, 26 Apr 2024 02:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvn2OAmfL1wURh4cdXLhzcLIEPzTZL3dr6s5TwPGmuCiNnV9dOu3etu6/6iUZzJFQYubU3kg==
X-Received: by 2002:a05:600c:35ca:b0:41b:7ac:f5e9 with SMTP id r10-20020a05600c35ca00b0041b07acf5e9mr1559295wmq.4.1714125213026;
        Fri, 26 Apr 2024 02:53:33 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d6950000000b003477d26736dsm21910405wrw.94.2024.04.26.02.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:53:32 -0700 (PDT)
Message-ID: <20148f24e2e35e711dc47878e19fb6bd118dce29.camel@redhat.com>
Subject: Re: [PATCH net-next v5 0/6] Remove RTNL lock protection of CVQ
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org, 
	jasowang@redhat.com, mst@redhat.com
Cc: xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, jiri@nvidia.com
Date: Fri, 26 Apr 2024 11:53:31 +0200
In-Reply-To: <20240423035746.699466-1-danielj@nvidia.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
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

On Tue, 2024-04-23 at 06:57 +0300, Daniel Jurgens wrote:
> Currently the buffer used for control VQ commands is protected by the
> RTNL lock. Previously this wasn't a major concern because the control VQ
> was only used during device setup and user interaction. With the recent
> addition of dynamic interrupt moderation the control VQ may be used
> frequently during normal operation.
>=20
> This series removes the RNTL lock dependency by introducing a mutex
> to protect the control buffer and writing SGs to the control VQ.
>=20
> v5:
> 	- Changed cvq_lock to a mutex.
> 	- Changed dim_lock to mutex, because it's held taking
> 	  the cvq_lock.
> 	- Use spin/mutex_lock/unlock vs guard macros.
> v4:
> 	- Protect dim_enabled with same lock as well intr_coal.
> 	- Rename intr_coal_lock to dim_lock.
> 	- Remove some scoped_guard where the error path doesn't
> 	  have to be in the lock.
> v3:
> 	- Changed type of _offloads to __virtio16 to fix static
> 	  analysis warning.
> 	- Moved a misplaced hunk to the correct patch.
> v2:
> 	- New patch to only process the provided queue in
> 	  virtnet_dim_work
> 	- New patch to lock per queue rx coalescing structure.

I had only some minor comments, possibly overall worth another
iteration.

More importantly, this deserves an explicit ack from the virtio crew.
@Jason, @Michael: could you please have a look?

Thanks!

Paolo


