Return-Path: <netdev+bounces-212666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF2B21996
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B6E19069DE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4DD28D859;
	Mon, 11 Aug 2025 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kYfCbCTq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6028D83B
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956561; cv=none; b=A5/ESrPf55iiElYzZRITRaPPgSOyyqvCAOcW1vF0yBLHGd/OzT40O95dLi9GZDUEWtX7OY+Su/hXtrli3AvwuU/zu58bemLnlD7Qspz13GOv+zzn/1kLMYYx6pDQDCtWrwNLQvVYl2II/flwbOJzAfCFPHLBlN3Di+G2OqySbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956561; c=relaxed/simple;
	bh=ZSZH875hfmzEjtSo4B20i5Oa4she6b7rPraPJrCuigs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL/eGjwFpbBI9ou5A3OnoXYqwwQjEanWf0pdn1PRF/9mvWZjeSGyq0ha9qajcGFNbR+DrvVvZchqjDX5VJn2h1J/+AN4ygzLyoIkHg6/WOIcLNYiacKrDOH2hRQ2yrqbeEgHGeIcL+OlX+6IuN0Tmp09oSIcW2+aEDK/4YmrG8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kYfCbCTq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23fc5aedaf0so34104195ad.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754956559; x=1755561359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSZH875hfmzEjtSo4B20i5Oa4she6b7rPraPJrCuigs=;
        b=kYfCbCTqJclEjDVdWv3+1zYghgWky0yULFRfUnkZBiCaUPNp4BKXYXDmg2HN/TsJla
         9uNM3+IDF/NKZipxs1QKWen1/Ok0HNKQ8LmYEj/4ZTgAu7iAn6CU8AP7piQTxAvOhEVL
         Js0wW1XJaNANnEuN0AiSWrJRH9nU8xnOK5TTkWcD7olyvdkJYNnnFxOIXRvlPdA7qdYX
         krZypjf9A5XckdxFQ9QOPv7ISOqB+llwDUfQXc6xkUIxxlDjNEpSxR8wDuvC5GlpZe40
         3oiE62ql0hncqUrH18JNmg7YQfYwg8osZCLBT7cga6J9ptlmeZop1+eMFi/AlGj9GzUO
         Hbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754956559; x=1755561359;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSZH875hfmzEjtSo4B20i5Oa4she6b7rPraPJrCuigs=;
        b=AWBv1RNSGbjRK8PpfELFm9aI41euAXgU5xopDk0MIMT3CHXzEa4GtTUpFuw50PfnjN
         AgS3FNvhuo8h31ur8HHKZ0SqzXVU4Y2E1MJybd0OwW6vhEFVBMhUeX1HBRy9HyGRr7AO
         KDKfsVm3GT3Jdvqlo1k9vFMInT/CVtFdQcj60DGtEuU9jIbB1Zo11zkPDjly6k4Am5I3
         V6F936BvabuTABVBIo6Pn3Qd5Y+r1t3gIZ4n3tshM9egOVx849d84SiHxnTp4INTOccC
         wWtlTQSbr0N1y/6uI7xa0v+uJItgvbbGOCjm+LMUb8pbQu94y0hHgJ2N7Rn0Ko9qIfU2
         pJfg==
X-Forwarded-Encrypted: i=1; AJvYcCWR3So3l37V3ju8YrzEL0SaeIv/SuyZHJIom9CdIL/YpCvPRLJm1pR78YrAZkCpGyBG+wP+5SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSEFq7wOJVfpA+pjKhS0Mkt3x4rjGUsTLu6DUWuSfE8JZL4g7
	2gVjJloqQmT7dOytnkzFejoizVtOHKBNH59H3VKaJMVDmhH4wE8xQuW+v1gmRmOOJGI=
X-Gm-Gg: ASbGnctL2txFQ8aTzl+pp/e1r2jEobRztOlWf49pU60uS4+KpmmMm1B1RMeyV7WrMKa
	vK24cFnzldSxgdwSsrz3b+Fd8Y3kn3ZxS+XBBsZiGhluQACgnWWHNCBJ+UEjy6JAh91gVZJAcN+
	ecjgl7mLbssPdOrYAlyJDI9qAO/dCwvm//QY4gLJAgOSazMfRBlknww3K7w2IVV1npaqWUFLva3
	FzKS8/m5Yvz7HtI55wmHZ5MdR9qZrxYPdgGTP5ea4NYbQH8asWD6dNqFnTH8qiTCn7A+KsbZfAX
	6ZBMQY1Fzbh4MZ3EoDOGMTVM1BUFKowVUP1HXqLTbFSp8pSC1VHivJw9YhvqEkWIsqvYiklPH9Z
	z/VnjLrcReT5d4tyZhfXZ/lKUHxNc089GJWg33Pxb1sd5Mt0VriKkOK3HIxrUFHXdGvs=
X-Google-Smtp-Source: AGHT+IEO4F2oqpKV+JV93A292iPe0aRlvbeyH6lJCXqp41wK7PZo9M552zAFRviLOLROCmq3HYIhJQ==
X-Received: by 2002:a17:903:4b24:b0:240:9dd8:2194 with SMTP id d9443c01a7336-242fc2a5c3emr20038575ad.22.1754956559098;
        Mon, 11 Aug 2025 16:55:59 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a06sm283682825ad.81.2025.08.11.16.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:55:58 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:55:56 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 2/5] selftests: drv-net: devmem: remove sudo
 from system() calls
Message-ID: <aJqDDIZxNAnZ-I8W@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-3-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:31PM -0700, Jakub Kicinski wrote:
> The general expectations for network HW selftests is that they
> will be run as root. sudo doesn't seem to work on NIPA VMs.
> While it's probably something solvable in the setup I think we should
> remove the sudos. devmem is the only networking test using sudo.

FWIW, it looks like:

virtio_net/virtio_net_common.sh

is also using sudo... that said in general I agree on removing the sudos, so:

Reviewed-by: Joe Damato <joe@dama.to>

