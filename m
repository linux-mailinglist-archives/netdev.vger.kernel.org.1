Return-Path: <netdev+bounces-103713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3F909322
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3311C2234E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E61A01B6;
	Fri, 14 Jun 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZYrk0p0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE901F946;
	Fri, 14 Jun 2024 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395504; cv=none; b=IWIyEVyA3c27kBnSJ3EcC+IMF5PqeCSK0lJXypB9Q7F/BhezaXgnv8y0/rFVjijwZljjqve2ujRuNV84YbY4eRsiHsQNfPpQlF+hXvJ894aycj1ADtHhdlnfVEqHzUM2FVMJE4OQGHRZF9HAVkRLedHvZPP9+ZaSyc0kbSCp1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395504; c=relaxed/simple;
	bh=RY8ceAoPye2/KbZtpTdpJ8++ZFtCXb35P5m4OwHe5Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szVtZYVMvQi+ykbOibdUQWx0xbCPYnwhLemub8p8NhZjMmfHYmy+F0uSPFjti/o7R7QWEwMROVfx/jtqdzACiunspNxnRAVBqNl4LTbh/PHV1JJHerfE2Dj5a90S6cyYCl0/XjCPo4AMjixUh8SGlwpnR/93RBBMw+FaAjsqFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZYrk0p0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c83100bd6so3216136a12.3;
        Fri, 14 Jun 2024 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718395502; x=1719000302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GOLNVEd7uGKCnwNzRJhDFbm6VnORpl1wejZd5oVyq3I=;
        b=gZYrk0p0XFmSrCMwr+cECwmmKsXx5ManCUtfKty2UJuV+2I7h8qZglyT4JXZrX2Aqr
         lCKfvkzTemVZGLJxyE2Xyzf0K2A8xmujKJIJkO7zCeWthN7SY/JwLQcH/Yx0VqAMCL5+
         jy6iUt6i8l80cTjdeGdjTYmnzlVQA7GTUhNQRvvJ7+xRG1pvGottCxfHxdRsQdzcx4aj
         PIbP/79c9Ia1KRqPVtedmyYYsuMXMDbaushwcRUoNBLTImgz/ZWTG5bqBNVid2L/avZH
         cFHRE+TvlHpZ4EMiGtmLSkkPIk88Ci5yQn4UQJdp62w+S4r0PoaAG5/zIFR2RdS1AJue
         0Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718395502; x=1719000302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOLNVEd7uGKCnwNzRJhDFbm6VnORpl1wejZd5oVyq3I=;
        b=TlHXbhLuUOVYLX57kYbNvL7blz3GIZhDNhtzMP6zLKx4klHzh5mfQAFIXwc0BpZNGR
         Ed4be1smy7Yvk2BtbCaODTSdzWzGsCBOc34sp6XzRhqHhjRyNj/CBwHGjWYhrhp3k+ht
         vslBIkdj8X9YnzydSWELd/C1p+qgwIDJNNNUSFxL3ZqJh0sErvPdHeY0/mTuVCvp3LwR
         B/itKw4B2LAuzL93J6Yenp6pvfMNkDSxW1lMMcldPJL5m/Y7AjZdSEhQ3qTddvZSKjYV
         umtuZM8EBG9w5IuMetV8+E06DBcYKis7j9XgypWlcWsu8QpO6pM1+mOu6JK8nVPvktN5
         m1uw==
X-Forwarded-Encrypted: i=1; AJvYcCU8HCuHqUnF15Ye1EOz5wQS4EBhmal5TgPNFsm+SLF07jVWUV8hNvkeIMSLDtp33cIyDkLxKOvl5a15B2BSncuipcz0qbJZSyo/FylRh5sM6zeMHMUib4s2XIdEwvUmX0rgaDqUkfnwD9wH7IZ25nqgTMyq78fDYV5U8sBnhMUsWAqDpmwsHQ/f717k
X-Gm-Message-State: AOJu0YwaE3pEdfljz+U7ir2Bj3c4PAtUULIhjQw4nRWi+CRzoAEc/Mvb
	oeyvlv0acuc+ra2zaq5XUglacIQSHmikxz18F/hI4YHndu/TFyc8
X-Google-Smtp-Source: AGHT+IEWfLWlENiwg72FCRRqNPcBcq3lwyJii5+8BM8ZYIu/nw1QYu4DRlw4LsF9JMJ9JUGXSABcog==
X-Received: by 2002:a50:ab1d:0:b0:57c:a886:c402 with SMTP id 4fb4d7f45d1cf-57cbd665237mr2364187a12.12.1718395501361;
        Fri, 14 Jun 2024 13:05:01 -0700 (PDT)
Received: from localhost ([2a02:168:59f0:1:b0ab:dd5e:5c82:86b0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e5aesm2639504a12.60.2024.06.14.13.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 13:05:01 -0700 (PDT)
Date: Fri, 14 Jun 2024 22:04:56 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, outreachy@lists.linux.dev,
	netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <20240614.128b8d9046fd@gnoack.org>
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
 <CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com>
 <20240611.Pi8Iph7ootae@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611.Pi8Iph7ootae@digikod.net>

On Tue, Jun 11, 2024 at 10:19:20AM +0200, Mickaël Salaün wrote:
> On Tue, Jun 11, 2024 at 12:27:58AM +0200, Jann Horn wrote:
> > This reminds me - from what I remember, Landlock also doesn't restrict
> > access to filesystem-based unix sockets yet... I'm I'm right about
> > that, we should probably at some point add code at some point to
> > restrict that as part of the path-based filesystem access rules? (But
> > to be clear, I'm not saying I expect you to do that as part of your
> > patch, just commenting for context.)
> 
> Yes, I totally agree.  For now, unix socket binding requires to create
> the LANDLOCK_ACCESS_FS_MAKE_SOCK right, but connecting to an existing
> socket is not controlled.  The abstract unix socket scoping is
> orthogonal and extends Landlock with unix socket LSM hooks, which are
> required to extend the "filesystem" access rights to control path-based
> unix socket.

Thanks for the reminder, Jann!  I filed it as
https://github.com/landlock-lsm/linux/issues/36.

–Günther

