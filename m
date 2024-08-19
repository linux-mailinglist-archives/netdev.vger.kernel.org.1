Return-Path: <netdev+bounces-119885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D627957510
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD0F1C23AAE
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82A1DD3AE;
	Mon, 19 Aug 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6fn8rhU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4E145341;
	Mon, 19 Aug 2024 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097362; cv=none; b=DPvc98+9xFfDUtxdKF2MkQzWvpe9Z28fkcN8LqvEFyuzA/gHISAH8qTW9JT6gW9eCJgagpK0yJt5pDj+nQ/CjSBHXiUiHtRfgPCOPXM7tkQrUud0sV1xQJtl6n7vZK7p64qX8hdPhqDdSGmONDBKZR9f3HlMaa3XNYUp7XHC6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097362; c=relaxed/simple;
	bh=uS/M4QEvgCj88JTFWG7lropq/FH/WIZ1cBIY6CYKMGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSEX6iapWaoA+DvntIGkmoZb6AzkTb1J1F36vLUjbvekT9tlFVff0jM6orqfzhMTkHd+JOS8jY/lBfjt3yh6/BmEo2UX0nHrScRpH511ZEsaE7ZO1Aa0rPjoxcWQuDYCh/4nY8ciPxQpf2/q/J9Bu1VG627ZRo+QYrog44CnFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6fn8rhU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-710dc3015bfso3162475b3a.0;
        Mon, 19 Aug 2024 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724097360; x=1724702160; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3u14jaF6sMpm2P6xSbFPosvPrziDfmVI/333/HfvZmg=;
        b=Q6fn8rhUcyH7E1qlQMaPlbwVZ7V7IJAIEhABp2gmZqRrBrCucpM816GRaJidxQYoEX
         U5gP8uEzJf/O2VPt8aE86AC0sO2OGd1AFWnctbqFMyqNVdoOflZ/XXDMY5QuSt7DgbcH
         hTtOMS6Ql8unWCs33XC6Xn+1T5MYHb2sEgx80dS3HsaWwXuCD8hUqENfVOyg57kHd8eX
         uRURSmOUb/2M6wCouzHrqKr0d5aSb0HEPAPZtC4zKWSBnOXK8TEn7tQqPAdzURXrW6id
         a4rfTJ5uaQgXUTyVAU14/hgQnzNAwbBUWXFum0P2VP/pvyLHL0gHd/7044QMlhrA/PMj
         /mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097360; x=1724702160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3u14jaF6sMpm2P6xSbFPosvPrziDfmVI/333/HfvZmg=;
        b=ktUj5cVLDUAFyDMqz9RtXK3dyYGajXEmka1S6nPIKXYvBslDCrycSU5rVLinNWsFC+
         0WmYoh5b4+U9ixZ9s9kVQn9XrEC+/syYktp+oGbslPG2qePAfyyhLd3D24Tz+I+BJ/tn
         J6aQ9n2aBe9wCwqxWBEDjIX9auX4nzcE3DdpQdr3UuzvmrSaONSDMeyXcg+kQZQ4z6IM
         3VzHQUj84LoptyerPrGcAGB6NKISSCapvmktLQKON8YEY/FtupOkWQiqsIM+vNdUVu68
         AEKw8Gp1DZMBB9+nvJFmwsw2UJe8v6PYcUJ0d5khyufjuVbm4EztGnKklxyRUIOUguQh
         cwEA==
X-Forwarded-Encrypted: i=1; AJvYcCUnotAlpAbyLaFsikhXayRaanudOTHOXno0dBs4toXXTZL8+twbd0asw+NhYEsQv/u+oY20vaEQ@vger.kernel.org, AJvYcCUrX8zSH/CfPrPhmnmIRcj7LlwYPZbIbEXS8DwDgN4Q2PDOynF9Ot0bCQbJOEZOEK1WsJTxMu4hcZC9tsNbmh9Rpgxuu9Bw@vger.kernel.org, AJvYcCWXiKR/NZRBpKST3vdM9tWT3mBfypcODAr9PUpsbjFQEeAbpr6S2s1jAOeOGdDodnLWFa7c9AUmxESk5VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd++pSMzKGTdD5fUiZii1kdA6Qmz+rEloG0PEwI0Mc//tKpH4k
	rum2pdRqH8lftGkPk4ikdRO5NzLDBQplvQ9Udao97lmiSOAPT4x/
X-Google-Smtp-Source: AGHT+IFTnJ+IdpJusYJcVfML72MiQsY6fxuJQh0HWezllw+QiSMVbC73bgI1yusV/JD4kKkA6LI9lw==
X-Received: by 2002:a05:6a00:945b:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-71408337f6amr1201717b3a.12.1724097360260;
        Mon, 19 Aug 2024 12:56:00 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-713e85a2191sm2900394b3a.74.2024.08.19.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:55:59 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:55:57 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, jannh@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH v9 2/5] selftests/Landlock: Abstract unix socket
 restriction tests
Message-ID: <ZsOjTacm9SO6Cu+y@tahera-OptiPlex-5000>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <2fb401d2ee04b56c693bba3ebac469f2a6785950.1723615689.git.fahimitahera@gmail.com>
 <20240819.ig5eekohQuoh@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819.ig5eekohQuoh@digikod.net>

On Mon, Aug 19, 2024 at 05:42:59PM +0200, Mickaël Salaün wrote:
> On Wed, Aug 14, 2024 at 12:22:20AM -0600, Tahera Fahimi wrote:
> > The patch introduces Landlock ABI version 6 and has three types of tests
> 
> "and adds three types" ?
> 
> > that examines different scenarios for abstract unix socket connection:
> 
> Not only connection.
> 
> > 1) unix_socket: base tests of the abstract socket scoping mechanism for a
> >    landlocked process, same as the ptrace test.
> > 2) optional_scoping: generates three processes with different domains and
> >    tests if a process with a non-scoped domain can connect to other
> >    processes.
> > 3) unix_sock_special_cases: since the socket's creator credentials are used
> 
> "unix_sock_special_cases" seems a bit too generic and is not
> self-explanatory.  What about "outside_socket"?
Sure, I'll change it to "outside_socket"

> >    for scoping sockets, this test examines the cases where the socket's
> >    credentials are different from the process using it.
> > 
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > ---
> 
> > --- /dev/null
> > +++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> > @@ -0,0 +1,942 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Landlock tests - Abstract Unix Socket
> > + *
> > + * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
> > + * Copyright © 2019-2020 ANSSI
> 
> You can replace these two lines with your copyright (same for the signal
> test file):
> Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
Right. I copied this from ptrace_test.c and forgot to change it. Thanks
:)

