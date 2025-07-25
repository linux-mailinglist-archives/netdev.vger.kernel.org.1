Return-Path: <netdev+bounces-210159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5D4B12330
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683EA4E50F7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D872F002C;
	Fri, 25 Jul 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeNDJcrP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E72EFDB9;
	Fri, 25 Jul 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465650; cv=none; b=izbtvK6ik+jlhXlUIZ7YhqMd4whOfNOXyslj58neqoNld/65M1TG3eAwVh9O+4cIPy5ZgpJrfvXIktil7mZg3i4JHB/gowX1MYdw3faQxL/DTURNkIDbfhpsyrMgl6RBRjtmHXCDCJ97DJbv0PZPXRDQHB0Tlb5V885JS0pI7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465650; c=relaxed/simple;
	bh=uK+Zu0KO0atqx4ZnWxOihGDGVV7isMfzF77SakOG4+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBZa6Pv4KjrVks+PMq1a6h57m+oc8TuNdnY9e2eNUkDtJx5Lp0EwXN+Pj7bSqJ5GtRO/JvtcFdC6F/9i1UMLgErbx6oyTwSwVPQ0HgutckCwi4cEUFGESYdwg5SO41bysPtspM932hrFPtiKQqU4aPJTCk1QrmU/bNRnIq+ZXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeNDJcrP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234bfe37cccso21153205ad.0;
        Fri, 25 Jul 2025 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753465648; x=1754070448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjbxMN7ETyQPsztoZorLELWE0JXnFSJjRTr+H/q5haI=;
        b=JeNDJcrPxd0ttateDMQilDRyJ2TLTipPmnhLhL4qLaeSLynGGHAo3eHFsAWgIQKs+2
         HYqu27HI+NhfB5XrVynHyJcnCAncQG5iP8X9q82V08drwkavNrsrw04TbNC/l7ZerIYN
         mO2ge87MWdFBzCpW6rbcfXyoOq90rkwGAq9FAr8mpi6DmMPQLNeCtKc/qt4ckl/f7nON
         8sxbqiMLlar1KklDkH+t+KvNP/Wbd65C384rQIlQHoNz0YqqGSMtXzKeeH3WquQCH5me
         YUrrzZOMPy51aRAiP93PFUQLaK29xy+HhzDERj9hBaxfW3cvus9WrGcr/AY/XvSs6by+
         xTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753465648; x=1754070448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjbxMN7ETyQPsztoZorLELWE0JXnFSJjRTr+H/q5haI=;
        b=PwC9VLoSfWL+8FoqmBYxPR73e95a3sZpJbgp6rn6Qp1WD8ilZrt0LwYO34yvCevAqz
         WXbSTr9RjlHbWjgVNCfXOij/f9LL8narC0cDNrPJSK8Q7eIZFeIoRAslh9XhnhWQd5pU
         vjIc3gTPr4CUKtCTCSXW7PQDx1J3jP9fk6JL/qZt67nTOQABDC1PBiCRbaScD3NL++ge
         UJkxDhGhfOFaKF1VZdzf0t21Bq1C5ZUxC+P2qqPzpTi8OaTU1Hq4S+Lp75c1ofsjBEs1
         4yYE5unnwbk34aMVXntlPK6ko3QB0FTZ2o3/5lJBpW+Op1sDTQMmu1+Y7fmDUhy9xQg/
         Xi9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEUq8FVuF33eBPY6emw6J7zVseyaEBGDOofLu7non7YrmsvUPFMWvZJI/rujtCDwte1zWrmpym@vger.kernel.org, AJvYcCXzgkZunE0oMe6X5NHaUyEIjdTk1LJsYZllepWwRAmyi0TGjlZwBJ4mvJepj2wxjJghKuv0Ye+Ps1xc+ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jv9oYMtlD0k4WGK9yBGvpWtxit9jXR0zsNYxoa8avN9eO6c8
	V8OsP3UruYweNGkMGnd+kLZ5F8Xa42vxJGFoSNciM92JpTmvTOOf2tsv
X-Gm-Gg: ASbGncsi37EBP6u2C4z/9geqRwN9JhmpoAViVyE77cH6YedbXY01TmepeC+mBSag6no
	C3GTYbgxbKG96wvfQbap3Dn77ZQguOdSGolPIsojzcVK99Ornmscg7X/cQCgL8uI8TF+yH3cb4+
	O3wr2gx2mxPWpAmZp3K0WneJPb117BxobOVWNmnjWfY5aG1m/QvtErHtHWLpWHM88aE9+q17Sgo
	u+KGGhU7i6M52CM8cNVhjy2ya+nMJvD2MQvehOhcObnRjKXW8snwC3PMphm1QoN+Vl8l0X4GXr1
	yhCFdffYiQ7gaOumeAsZphz6+8RY6hzKdbq7Y+HlWQSSsmn7jq3OgGSSVGMkGhEG0dtRIMDs5aR
	U2Kh9rN5vYEfOVKrvsz6ylE5HbQ==
X-Google-Smtp-Source: AGHT+IE9MofzC7clK4UzDItX3Pfjz8HqZyGO9RqSZ00cu4R7rGR7UhjqTFipsz0w9DeGBPmkgngZeg==
X-Received: by 2002:a17:902:d487:b0:235:f3df:bc26 with SMTP id d9443c01a7336-23fb2fe067cmr47444175ad.3.1753465648272;
        Fri, 25 Jul 2025 10:47:28 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe53b52bsm1809945ad.170.2025.07.25.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:47:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:47:26 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, sdf@fomichev.me,
	kuniyu@google.com, aleksander.lobakin@intel.com,
	netdev@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in
 dev_qdisc_change_tx_queue_len()
Message-ID: <aIPDLjCUHCf+iI1O@pop-os.localdomain>
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
 <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com>
 <CAO9wTFiGCrAOkZSPr1N6W_8yacyUUcZanvXdQ-FQaphpnWe5DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9wTFiGCrAOkZSPr1N6W_8yacyUUcZanvXdQ-FQaphpnWe5DA@mail.gmail.com>

Hi Suchit,

On Wed, Jul 23, 2025 at 11:47:09PM +0530, Suchit K wrote:
> >
> > WRITE_ONCE() is missing.
> >
> > > +               while (i >= 0) {
> > > +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> >
> > What happens if one of these calls fails ?
> >
> > I think a fix will be more complicated...
> 
> Hi Eric,
> Given that pfifo_fast_change_tx_queue_len is currently the only
> implementation of change_tx_queue_len, would it be reasonable to
> handle partial failures solely within pfifo_fast_change_tx_queue_len
> (which in turn leads to skb_array_resize_multiple_bh)? In other words,
> is it sufficient to modify only the underlying low level
> implementation of pfifo_fast_change_tx_queue_len for partial failures,
> given that it's the sole implementation of change_tx_queue_len?

Thanks for your patch.

As you noticed it is tricky to handle the failure elegantly here, which
was also the reason why I didn't do it. Did you observe any real issue?

To answer your question above: I am not sure if we can do it in pfifo
fast implementation since struct netdev_queue is not explicitly exposed to
the lower Qdisc.

On the other hand, although dev_qdisc_change_tx_queue_len() is generic,
it is only called for this very specific code path, so changing it won't
impact other code paths, IMHO.

Regards,
Cong Wang

