Return-Path: <netdev+bounces-198371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4AADBE71
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1778B3B8B04
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8DF1A5B94;
	Tue, 17 Jun 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdKxWxtw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BD19CC3A;
	Tue, 17 Jun 2025 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122645; cv=none; b=f6+L/FbHp2l7efZUg5rAKKp1uqKuGlJBv7TkU2d4YRe8jUGe1hS3dPtSDayCfeRCbGojz+39bf1au1mAadFjOPUsC3rDIZ6tvwCgulW6ZMPXYumqfq4ukFm1qXQEjnBvZFVs7zr3loxAFIjSCYIdwE7chxs/OwzsVrF+XmsmksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122645; c=relaxed/simple;
	bh=fT1xXHNwQD5SOpaUNKqqlhoPF1dWwLBuO1DYC7Fxtag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqWwQK+AcizlvQdFvipSOhHzBsvB3KhdcRZWC+4kv3ANW9ZYZj8X80AEO16gX/HC/rzgWJgs6FVc3iQFOGuQmFcBxs5KT+oE6PxPoFhy6F9Qs5PMzwm1VKWhRSya+ykp9OO/ygeCYgjXOlIx2oSYNfL6/JJNbxn7BWL4g/IXbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdKxWxtw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748c3afd0dbso755277b3a.0;
        Mon, 16 Jun 2025 18:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750122643; x=1750727443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdCG7GiKOa8Kksg/uV4W6JGwK3wPZmMq/t9MwV0TaY8=;
        b=YdKxWxtwAevjII4ABMqzCoy+xDXdGKsIUmfRIUjFvvDmLSPIXXaQd4gUbnDxriajK1
         aOs7cI2NJSgcTVs0OBRFBMkFgDJIjx6zK3ANNOO/WTDx5LfLp/1GyEQF5eB/61+5jcVT
         83t30MMVvXimq4celhFN4EqFCDc+WfFZfl9+rACEXAkyLd949I+N6dU5usP8kBblwbb5
         40ufvG4m+n8jKNWOjFWFEiql8Pd3kiQFVB+GG/FRxlXA4Jl9kyQciZ9nWk8WoetVNFoD
         85PV7FIsN6zH+vAW5eetQZPxrpFWDkU/J4fwbnsMnmG/JKtNf6216/eyBiqYqNqFjkXM
         gnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750122643; x=1750727443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdCG7GiKOa8Kksg/uV4W6JGwK3wPZmMq/t9MwV0TaY8=;
        b=TrARs/YV19YZK10b6QWx2sIwSDHhyO51Fi6u7iyt7sb2UXvoXGfnY5g4mI35tdAg1D
         gVzzU48JNuWO7phbmDwVLx81SqrarEIaEX1Ngt0XHYcWA/RtFCqQ16ufMyCyqY8mQ+VN
         rjtEAtKRcoGgCY77T/SEGPjkddv5NQWo7xUs6B5TdHRRM4YMf28QLFfZHNTd4qNHJzbV
         jtrVFzMOQh5y7zZuR8/Wh/VQCr6n091OXP+VYVrxW6PJqHEwR5j7KoXZOr0dI01nfWGi
         rmTjci+MUo+4YOLZdPUny3qiIvnG6BKIIan1s/zFXA966mfAbkP+WIW7PY5wmqtAoK1K
         16ww==
X-Forwarded-Encrypted: i=1; AJvYcCVpRUCGpuGrsfDD6r6s4ajdtL/NgeHm+SJdgtl6pvjpophtvBKaRH7fZ654zGez/BMeEQTI6m24UG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdZ4XvsfOhOLyFs1REqnbK1+zTRmZ44ywt3wryC6POkZpIap0
	tMtIGJgdir9Rkq7tDzyvizXHQ5H3sWjPLLLtFF30rkCB8Jibtc6t8ZI=
X-Gm-Gg: ASbGncuZIw4AMLALJEC1Vqjts/U6y+ZpXl1yj2BBVHvAw5Xy/KuUW7JlIfarLecPFK0
	8rPfElq/IGhiTblUfm+sxdjXlbg/iIRxV92AoSNmhQAzdFMqQoLgOwCE3xEAIy7iLS/op/6VDQE
	gjeW4vLEtp7BtUomLkpT5tRusl0t4YXQ2H6HP7cDQy4b5r6SKHeckJCCDqVg4SCxdePg6BIZvW0
	sB0fTGivbyO2oNARy1cix2OfGGCEWTdcu6v3c/URVToDLSxvY6vXgzspPLlRLPBh0qLm/0oicnw
	B4Iet8A/xNTHyJzr4SUcpGbyptkEgwjUE3k9+/u1yxh++KfG8dCIgz1/yLxUaLzj18UyIaWmT2M
	t8+2uO6YNqZjgS7MIpB/95JE=
X-Google-Smtp-Source: AGHT+IH3wooPtQRQ7+Atp8Y8bDiCDFHOOMUJuevw+XdayNuEvKHxK3WB5inEZi/1Pvx032/2YdelVQ==
X-Received: by 2002:a05:6a00:806:b0:742:3fe0:8289 with SMTP id d2e1a72fcca58-7489cfc5518mr16972640b3a.20.1750122642853;
        Mon, 16 Jun 2025 18:10:42 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7488ffecccesm7545059b3a.5.2025.06.16.18.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 18:10:42 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:10:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hangbin Liu <liuhangbin@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier = 0
Message-ID: <aFDAkS3VUgHwxxr6@mini-arch>
References: <1922517.1750109336@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1922517.1750109336@famine>

On 06/16, Jay Vosburgh wrote:
> 	 Remove the ability to disable use_carrier in bonding, and remove
> all code related to the old link state check that utilizes ethtool or
> ioctl to determine the link state of an interface in a bond.
> 
> 	To avoid acquiring RTNL many times per second, bonding's miimon
> link monitor inspects link state under RCU, but not under RTNL.  However,
> ethtool implementations in drivers may sleep, and therefore the ethtool or
> ioctl strategy is unsuitable for use with calls into driver ethtool
> functions.
> 
> 	The use_carrier option was introduced in 2003, to provide
> backwards compatibility for network device drivers that did not support
> the then-new netif_carrier_ok/on/off system.  Today, device drivers are
> expected to support netif_carrier_*, and the use_carrier backwards
> compatibility logic is no longer necessary.
> 
> 	Bonding now always behaves as if use_carrier=1, which relies on
> netif_carrier_ok() to determine the link state of interfaces.  This has
> been the default setting for use_carrier since its introduction.  For
> backwards compatibility, the option itself remains, but may only be set to
> 1, and queries will always return 1.
> 
> Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> Link: http://lore.kernel.org/netdev/aEt6LvBMwUMxmUyx@mini-arch
> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Maybe better to target 'net' with the following?
Fixes: f7a11cba0ed7 ("bonding: hold ops lock around get_link")

