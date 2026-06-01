Return-Path: <netdev+bounces-293728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LCnJsh5HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:23:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 597ED61F34F
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72D53302834D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E037649B;
	Mon,  1 Jun 2026 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3Ae9hAh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F6331203
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316062; cv=none; b=ItlFUdfatNOxA6Gu4h3lPKFkzsigcMc4lqP6HlfcWSO0PeGmONcRXDbLfWS9bB/VNHZrki6xAuDi7UopFeTCz43UQyzgJeMMcRIWRYDjtnRviwbf9gnmFQAMvCvDCShlwH5q/aqVUXkpoSl8OX9HNQ4XIDpuz2zM7mCCHUQYEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316062; c=relaxed/simple;
	bh=ckB/0OrsFAl0uXjbvDISsyp9MLSMakEeAmw4BaJPm88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLOEBDgPVeYCVgxo0a/yybgY4MBfwBetO0z2IyxFDLsdN+DncA6dO1Vc+bDq0yOvoCCNKgB9ewPg/+uNWRIumCDEnZc3mRqJ3n+22VaeF+DzhJeoLDXLI8/HkbnDmBKRtJIJfJbg5ejayMc8fjEWA9STgXUid6+13mleZicCIL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3Ae9hAh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso103604265e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780316060; x=1780920860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LspmPQV/lHUgHA9RJ7Trmk5tXDicO37E7l+XwVPkr/U=;
        b=k3Ae9hAhCViAGBd5kkfRnCmIEDj9nPEiC2h1k27d6xLf004gk0YZhyqL1jRyZmHOTy
         3cQvR9UIgL4aWarHwzEXeWXrfZ8tDlHLkjfGeQgsZu1TW8aWJSbppEbXmlmpv5wXpPoj
         Km2mZe72gDI0c+idsg+Kjwx6R60JfZBlgEqTJcmwuG4+/mVC1BArdt864f9hVoriEfx9
         Z6xEuq+uj9ID52x/QPtYV4+NRsWJBLI4m4oI7rL3yyLxsbVgJfRHr+4pxVGMPe5m+4mx
         PfwQpTDH829FiunORZkzoqZt42542qhsB3V03Vfj0tHotgS+Vb89cDSs1lMRIJpvMAUl
         YVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780316060; x=1780920860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LspmPQV/lHUgHA9RJ7Trmk5tXDicO37E7l+XwVPkr/U=;
        b=k2wsUWxBU2slt/s6VGwrWJZXWzLBInLjGaGsSwKE5VHQpOnoD5+wwI7e+XKl6mUeWh
         xTZo14DuKB9gCrL53qwqUQLxrjn6R88vdS7A2M8NKoYJzdPBUgQJUZUOtkzM16TQjFrb
         6n2i6ZUd3AW5JQVi31CvNA8r/6QWzirNFFiUA3M9AnWi0mKfsigepOlOhg30xawFR5h1
         tVlt3ngm59e61VTF6tTb/uTf4QsHmDtD8cT5qwYaJ+1i9QEpQgePgUPYb2lCeRILOrn7
         uo/8dCGe8+5PiDoCGooKAcFWO9QdNiwCDpn5I2lh/Nl933v8NUjkc5YButt1kCRilMG6
         2RFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UHRn/6gxsrOo0CrBYaFHOM9bVhzAwwU8dMYSXh8YXmcc2QcajMTuRCYU++lwBry9bXyajHJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0tFFbmgEoP07iFA0icfd3PIu+0h6eQ7eb4JmzTwdIwlZlPFCU
	F0S3pl/XB4AINtnZVTqcL2kaQ/SW2h+AEO3YgsChk1RPd+91xE9O+QmkG1kTa2jI
X-Gm-Gg: Acq92OGyt3MKseh1JUJttsZuS83wD2VE5V8PteT38/t0S+xuc+WIR/+0oqMwz2uDfLD
	d/U33r0yEKabOwWpWxRUVVj1SeaH4RDo3Xn5a90Cu/V+GKzyQoQRITukoGH7BUSf8GsTqp6h5j7
	rDrTIaGhH4zQ4b4zU7s0Ia7B7pKooZjG9Jy7YaKErIYwh1YvPRCai3DKNEaea4V79Nv8v/71Kh7
	LScy7g8Pg7dKUswSduM6FUTN/cZQKR4MVrEhAR00kd/s8FGfDsyfg7W9SkDMvPAzhSnw393/sqU
	NB+2nfINPglAKL5QBn2w7IzOHnAtGFkKya/Yp80q2p3mvMpISZSJ0kb73ISyNLWhnYMdF9hzGL3
	ZJyRmALwQpelMZbgji2c8bbom2Vkp3KrLh8qIDR5jeYoOQo1s7+DZc2BICrZLJCHbfavx2qEwJE
	pOdz9Poql0JvDxEuPk1LtH6z3u3i8yNr2MzHZlysG1gJIsgXPhyI4L/bY0CGXQU4ryqiNSG+I=
X-Received: by 2002:a05:600c:3b09:b0:490:a7ab:bbee with SMTP id 5b1f17b1804b1-490a7abbdcfmr141119495e9.15.1780316059659;
        Mon, 01 Jun 2026 05:14:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c127befsm77948305e9.31.2026.06.01.05.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:14:19 -0700 (PDT)
Date: Mon, 1 Jun 2026 13:14:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Yao Sang <sangyao@kylinos.cn>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, "Gustavo
 A . R . Silva" <gustavoars@kernel.org>, netdev <netdev@vger.kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
Message-ID: <20260601131416.318cfbd6@pumpkin>
In-Reply-To: <7a018189-021c-44d1-a46d-a75016818a0b@nvidia.com>
References: <20260520102130.423044-1-sangyao@kylinos.cn>
	<1780035629778309.247.seg@mailgw.kylinos.cn>
	<20260529064521.4i5pyilf32au4cnf@sang-pc>
	<7a018189-021c-44d1-a46d-a75016818a0b@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293728-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 597ED61F34F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 14:00:15 +0300
Tariq Toukan <tariqt@nvidia.com> wrote:

> On 29/05/2026 9:45, Yao Sang wrote:
> > On Mon, May 25, 2026 at 01:47:59PM +0300, Tariq Toukan wrote:  
...
> > Regarding David's suggestion of using a memset_user() loop, I've also
> > looked into it, but couldn't locate either of those APIs in the kernel
> > after check.Please let me know if you have any additional information
> > or suggestions.
> > 
> > If this approach looks good to you, I'll send out the full v2 patch shortly.
> >   
> 
> That would work.
> Thanks.
> 

I wasn't at all sure there was one, but a loop using a 'reasonable size'
buffer will be reasonably simple and fast.
I suspect an on-stack 256 byte buffer would be good enough.
If it were a really hot path there are other options, but this looked
like initialisation so performance isn't that critical.
(But you don't want a loop of put_user() because that will be slow.)

-- David


