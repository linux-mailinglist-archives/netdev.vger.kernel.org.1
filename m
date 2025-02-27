Return-Path: <netdev+bounces-170394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E116AA487CC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6E71886B36
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459120B1E1;
	Thu, 27 Feb 2025 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtukSfIu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3103C1F
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680823; cv=none; b=U0c5BBONLBVjb8dTiQzbJ6we7U+2ZXA8lKYn8FeF5DSEcXe3JGiXOCIBqA0MAbxvYMrj9K1vpCwi2G1mLsJonpbQujWrlEUmUpsZwfLXhDS8hBO1vKj2XDS3Z7iJcpKZduLK2CFr843BYpm5X5X5atISHqrZMjbWKvhQ7b5GhuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680823; c=relaxed/simple;
	bh=0zsz+mMjvGo4Tw2uJZlOjqUkXoLaWJucvmHSP3Y2wl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U92Dq/dZsH7XJoBo91RTKzWYK4uPkDEWOm2m1MO8dmMNKE9rofxHnJvt2kV5q1wiw0W5yu6gV/5I+ssabaE1GfFi08vxV+69Ijii/Y9fpXeQY4frCS03Lf1u3vMH2B80LHzd+KIYl6JE8w2GJM/XVu5UEKVRgL1KiKylwEFk4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtukSfIu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2233622fdffso26171885ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740680821; x=1741285621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zsz+mMjvGo4Tw2uJZlOjqUkXoLaWJucvmHSP3Y2wl4=;
        b=BtukSfIu3xE6Mgl3Mitn16aWTx++e6naGChoGpcbeL1V9xm3BFx6TV1hGutJpuRdh2
         fNDoove6cW7yyVNnAa5XgXMnwC6splCYe4oV1nNyMANLVyvpG0Ugp4jo/6nkYJ7ehAIN
         edoVGoMnaAYstRCKhkKW/De+AmFk49k2mj8PeRNIUBKwWqHN6PQ4ex1h+oWvQhfvyKJG
         EYNnEZllQje1pY0sTm2Pz8YEwBU+jGhgj85WtG0QFKr6pgklatC7veLoXPWj6hMvzj9W
         XKOR/p8YYRlIj2pzZUitlYToBn2eb5pqr1WxVZ6IFGngFoI9J6WSXZ99ZqCpk5HrnPoF
         pC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680821; x=1741285621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zsz+mMjvGo4Tw2uJZlOjqUkXoLaWJucvmHSP3Y2wl4=;
        b=qxCiEv8m8rbtEGXOYF1Hzk9p3JPlKeM1ijZmracKmKcuNhI487n7ji8Iw1cZ5SgFZs
         QjH722MzqCDKoWeFT/wGlOuzyPCvH76S5amsGqYhknCQVOXPE37hugiY8chIFveWqBvD
         +1KdEvIitQWY2UtQlqs5eKFeQ9FsItiTwB6BSOK0L1Zj+lplQHAlFz1fZDuxu+MA5VXM
         NaN2PRxFWLeCoUVTkePVv4NNVdYZfGpKAQ/0ZBux+ft1dF2L2LJUGc7sTaWyvmFnp6f4
         4XbEBTuumRvH6h2WOwAOaXL6NfQ4mAud5HpEh9WkAd98dCqOUy0RQ+OUoSfBWwaufnMQ
         BfUg==
X-Gm-Message-State: AOJu0Yxfogs/bNgqGGZoaasptX7wbUkwKSSa6XrEAS4NYuD9FgAAnx66
	G2r/jDbab98ek/RGAxZUHDTgQLwfZduA6HkXnUgHonJfhR/enJQ956nJmg==
X-Gm-Gg: ASbGncshYvxHKHy5gekKOQNA3tsqzyizT7xwGAgOuyH0uecg+sfcyWhtaZOhk22BndP
	VA9S3vDlDHBYrcvVl4QrDqgVyxhgEr7+srMTOTHdTlhY6eKwPz1vl1nfNitMEY+8CkynrvZ++g4
	MVkO4R08NH+YMM+DSwbUmH8Q6ejM0RZWcmcTsiQdHOImMz59oR3l/+haFSkdxgiqXzN9Vq0ePfJ
	CZU49IuQEh6zAd8/qd/k1+7KGo7MAL0oN3LYupoLRQALGRXqr8NUm/FApmUSKnm4WnSnBXIc9Ab
	31vFq4mf3DAsRIjUrHl5OnKJapsFIg==
X-Google-Smtp-Source: AGHT+IHEdSjFoqx9WzzmMqbMgA2cVIHdezB1TX4mdA4Zi1dxguprs/7eqvhWc1ZvCkzdbITTxoRwVQ==
X-Received: by 2002:a17:903:1d0:b0:220:bd61:a337 with SMTP id d9443c01a7336-223690ddef3mr2483025ad.23.1740680820872;
        Thu, 27 Feb 2025 10:27:00 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024cc7sm1980421b3a.117.2025.02.27.10.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:27:00 -0800 (PST)
Date: Thu, 27 Feb 2025 10:26:59 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: kwqcheii <juny24602@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] sched: address a potential NULL pointer dereference in
 the GRED scheduler.
Message-ID: <Z8Cuc1sIjXMQaf3W@pop-os.localdomain>
References: <20250227160419.3065643-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227160419.3065643-1-juny24602@gmail.com>

On Fri, Feb 28, 2025 at 12:04:19AM +0800, kwqcheii wrote:
> If kzalloc in gred_init returns a NULL pointer, the code follows the error handling path, invoking gred_destroy. This, in turn, calls gred_offload, where memset could receive a NULL pointer as input, potentially leading to a kernel crash.


Thanks for your patch.

Please add your Signed-off-by for your patch, which is a minimum
requirement here. You can check Linux kernel development process for
more details: https://docs.kernel.org/process/5.Posting.html#before-creating-patches

Also, ./scripts/checkpatch.pl could help you catch issues like this one,
it would save you and others a lot of time.

Lastly, if you saw a real crash, please include the kernel stack trace
in your patch description. There is a significant difference between a
real crash and a theoretical one.

Regards,
Cong

