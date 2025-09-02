Return-Path: <netdev+bounces-219332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F4BB4101B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7C91B25903
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057A275B1B;
	Tue,  2 Sep 2025 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BugSlYTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8F20E00B;
	Tue,  2 Sep 2025 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852879; cv=none; b=fr/4dHEMa+yu5ONKmQZqEnms/D/JyQKrCwo4JxQTkUPafTTbxoK6Pd/Yrx09eUEoCIjTuvT6HmWNC7uSJJoYRxfzXCQpEhxb6/BP7J+ezlJNFFyDTlbtHL4gRwLR80V8OSoW3HZoPkEjaVSmiCy+XmvdJdl1aRCV1jQAD9eGAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852879; c=relaxed/simple;
	bh=v4Fil2zNyhzEn8Y/gdgAfMokXDb53dQ2oSj4wy3BVhM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nVBa4cdcOjQEs8tPu7sxKQae3Fh6Ty7CFDxZ+lHHuRqC7ZFsRm6D5yI0cZDFpbtXGOyTz6Ivw5W6006QggNXMNUzjq3SQP1JwRAM7M4zEL/tGxr90+1y4UEmcCXSIZ4YRd/z/JpRIlCgY8xWhT0L9WwVBOCnpxt6bXuLBLNHK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BugSlYTP; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-52a8b815a8aso1787415137.3;
        Tue, 02 Sep 2025 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756852876; x=1757457676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QBseKVhIOD7rddztwEAR/sKg97wfiErirFVx2pC+y8=;
        b=BugSlYTPPYx8cYryDX2dTbzPUmqhhSeGNx5O09uUnwRU0Di8HYBqqhLgFmZU6sn2Pd
         nNZzRf1bCgFEXGMm8MJfN3pnVhbM12t+e4jU3cnGP3gDabGYEQ5MCO2ibg56I6nDwadu
         rkJWgSvd6Y/ulyFmZgN8d0vDHdi4/UE1qALEzNt/mwm8Eg5lL7B85N71s/8pf3OKmgPq
         qmTx12BsafvVQoJKrnQfTN3RcZl++ClvmMWHvdyE9SNKR9Mr1Ysw1HJ7VuoSwA67jujb
         Ns34bOOnGa63fjny64aadgtauwZzr1v4GQ5T0ueYE8pQ1meIYucu4pCb3LOEtTc2BUOz
         YMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756852876; x=1757457676;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5QBseKVhIOD7rddztwEAR/sKg97wfiErirFVx2pC+y8=;
        b=GmG9rQlwNbBvupQNMnViRUzesMLHtOOEaSZs7okFqXXWbtrDfT2djmp0O+nenICgx/
         NcMNA06n+stHaHSs8/JSnST7rpRy2N/hJqo3e3iAPctaoHO449vHRQoitTE4s/XvvNmc
         5H6z9Z9C+UUFRc5yuyB848keCU9pOfZgN8gZX3xmLmmnN1x8ZU8pflry8BhX1n84yDYF
         On/ZRTKmBH0BCFSTpF67EYD74AWBU4Hm1tXjQ/0yprioM695wsuJOKd6PTl49c5C3DsS
         llZCHme1J0x/uQ5m/dc9/GlZtu5/6+fH9HA4OOCRo2S0gCoQLNbC7Wma69SvgXING38R
         iseA==
X-Forwarded-Encrypted: i=1; AJvYcCW9YsGdoy3ZnXNPFu/h9ybfj1CEmYl4KTgnTMJ8WXkeqOi2ELHxh8/93p7HHvy+Bg3fWPgT2cMoNNaVuUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xvDycURQv4IhKp6p+GoRaCCyts4Fu+W0DgeVciwC82Od7bNj
	yN4cKzLR5+5ZzQoJNPBPm+wHOyArhgReqMPbOGvfqrTQrQEtsbmkYKIQ
X-Gm-Gg: ASbGncs+X+Hktm4Q0LVNCg6L3SIk3SrnmAVwkfsrh3hbYfjMqsrBHXqBFH7GjOrIfmL
	QiFgmRnsHqLpE6XK+pdd1aJIFOTsMjgF/GGSrIxeY6x34LoVOeJfvBDbJcv5SDkmda67xZrA6/U
	s3TVkf4RSTr02GcjTf4lb+NrqdynOGodEk7AglTGEYw3Hi/m1DYZu8h63zz7jthS6EeBe9NhR2w
	TL+zYPzO0DuCaKCBzUI9160gy0Xk0fGeWvUteiUnPXjE9xvUSxzTKzUs5pb6stu/wdN+fz0R3Kn
	LP4u8aJkzJmg5Sg5L2Cu5WyWRl2ZqA07bFqfCqGsaNVQBMlZ5C6sYptzs+sjhRRj1Y5yOCjC7FH
	jrvWzzAQyLno8UNZWm/q/2RCc75Je5GUbu7nVVvdk18i8gJ2wSpw0LtyvJiNGtS6FbBS7ixNZ5N
	k4uA==
X-Google-Smtp-Source: AGHT+IFoVGNaBflNy7LsGWkGUCgZQqNNgejO2tBaLky1MLKy0WgsmHoenbfRtwGQMjxSn6O8Urvjnw==
X-Received: by 2002:a05:6102:6c2:b0:4fc:eda:abd8 with SMTP id ada2fe7eead31-52b1be31b32mr3580050137.24.1756852876012;
        Tue, 02 Sep 2025 15:41:16 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-899f14c7752sm762863241.4.2025.09.02.15.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:41:15 -0700 (PDT)
Date: Tue, 02 Sep 2025 18:41:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <willemdebruijn.kernel.16c9d77b1d2c@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-1-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-1-51a03d6411be@debian.org>
Subject: Re: [PATCH 1/7] netconsole: Split UDP message building and sending
 operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Remember to label the target branch: [PATCH net-next 1/7]

Breno Leitao wrote:
> Split the netpoll_send_udp() function into two separate operations:
> netpoll_prepare_skb() for message preparation and netpoll_send_skb()
> for transmission.
> 
> This improves separation of concerns. SKB building logic is now isolated
> from the actual network transmission, improving code modularity and
> testability.
> 
> Why?
> 
> The separation of SKB preparation and transmission operations enables
> more granular locking strategies. The netconsole buffer requires lock
> protection during packet construction, but the transmission phase can
> proceed without holding the same lock.
> 
> Also, this makes netpoll only reponsible for handling SKB.
> 
> netpoll_prepare_skb() is now exported, but, in the upcoming change, it
> will be moved to netconsole, and become static.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

aside from the above,

Reviewed-by: Willem de Bruijn <willemb@google.com>


