Return-Path: <netdev+bounces-219353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5F7B4109B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93131B63F81
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21427A476;
	Tue,  2 Sep 2025 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEe5yux5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E13274B57;
	Tue,  2 Sep 2025 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854591; cv=none; b=LlAtHLOU00FKygaih+Xnz/7fd+tHIJV1M19TCDjAKkcUvuPYRxv0OQpUZ1QIQDGMwyf0O+ZGVOt33+DoDDjWPpUtBwoORcCgwTaetm1HbkjeHLIDxbutMBGo0iWVrXwwVDHW4jkXUj+XhWzt2kepIxsXYnBjQs5lZsaw5nxWZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854591; c=relaxed/simple;
	bh=HS2jGEZ7zulaUmSWROX+FYgEbo6eNtCYZXo+jqtn2Oo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uC0DMrhzoSs0a591qkwkfHcL5+JnUv75Iieyb1+1dCfoQ1jNl+gc4/DAgXdUO7cSt7OvfIVXODPcNbsABp2VXLGc9H4xAjnFt08RB9JxPnvV+V5Xkd9HoA4TR80giOy/6dERPQXIz4h9wDMEoOQFD7aSvl0wVV7nQhZOlVmupjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEe5yux5; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-892196f0471so1977816241.1;
        Tue, 02 Sep 2025 16:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756854589; x=1757459389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHJXdbNvbe71VInSbZOxet9v8zdgIHpZX0h74ciegP8=;
        b=UEe5yux5K5rNfHfcQ0J5szwdi1dIw3+iZq/xbbUZfTKdOvr0l1fMEdwDVii8aHaTAp
         WM97wCsgEv0rTP2heITQYYL8uszriVzaKcEb+Sb6Pnc2vdeU0CiSRxhFIJkmzuBc1B8Y
         EqRWDros9IKZNisFNG20CRrZaItp9CtSA25706gJe4txC79Qhsq09c0qPgkAutqnHXY4
         /zS4cCQrUUgB7osrgkZ3JAPeK/r3WTOFuYw+p/O5ArgKIBny+mJEarm1pphvoN9EJ1Lw
         hzMZzqnwl/+hoHo3EfF9HaCZ11WrVxRcjg5Qt5WNMcurcYjaUOYKHjau/7J8aAgz80Mn
         m4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756854589; x=1757459389;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VHJXdbNvbe71VInSbZOxet9v8zdgIHpZX0h74ciegP8=;
        b=EUNZyeH0sPOz9K4pGPbJmUtwTjVl2rIw5E/kjmRhzOMzztJwlb+jIi28Xvk4pGt6IG
         HR4TmoVjNwujlvQQm2HjH3WDG8XH8IjjbZa3zQS6WJ9vypqCEWDoWzrUQKj1pvQixN44
         IPlAeJOcezS05VUfVKpQarmDMAEnfzGYc7+W29+zDPPEN7i7hncnR4nuRsDvk9Itsph0
         QlCDnxMTf+L3QfPO7+AScRAIG27Ua/cAp5Wx2SnkY68iNJz3oP/ERX1jzlLMVR0u19ZA
         R9HEbKRKK1H2oovldYtHY71KIrZgGaZRWKFPRkkylHD297LM2zrxoJpgduMCqKCGIja+
         +bVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD8O39WEOZZClz8q9STrnguyLPqizD+Q79SIO++6rbUsW2mN8lQB6Pdx7EOdUs/398f9Lc2jfZ+o3mFV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcSVxrblCtP+JxKUG/VwE8NAr6Ksh6IOh9IGu0yNMQFfFX7Vn
	rzKFqTn30oKn1sVlxBxkzWW1ss//AKxCKBmwlQXJPSoL41MKEorgdWLz
X-Gm-Gg: ASbGncuADUn57ftWAHpU9FmWhJCCE/jW4Rmnvu0RM7HnxU0zyEfiY6Yy1uBWTUG0RN7
	Go27ZPowbjoTTStLDyHDqfsobYhUECac5unU+1t7BkZG7sxWSftDZ6bL+prDQH/Z8XRZmK3jtDG
	K8CNg/Vna7MU8rSesn9Gg0UMfwtu2Sefb3/5iALsfZh6jiez514A6mB4nkZ6SqMuqEg46z8eQup
	+TRrXU/UXIBu39kZKUhtPODrduq+ox9Szm3o5P83t8pSufBnDVrXY18difUk54UNvZEYWNuWlrc
	KRq0erS6WZn1bY2+p/Svoo7UIpu3iz6Ve6HJ3SlgPzKGZ5UlzcjlZL9/PiqNr5vdW8BfLfcFamX
	n1Snm/44vjDDELMeJl3T+mZ9/cOgqr5DD/xP6+nGDsxMj1Oi/KUDHeta0lv2aH7uAHhPhLiDVdm
	prtOiUqDqBmJS1v/psIRCUUfk=
X-Google-Smtp-Source: AGHT+IHxLuLCKZBNbBTvxy9DB+q5tdYIBT2jIbA238hhbryhI9WewsFJ9qYqpYAQF9Ajvi6zmY1HZA==
X-Received: by 2002:a05:6102:2ac9:b0:529:b446:1743 with SMTP id ada2fe7eead31-52b19a55edfmr4837156137.11.1756854588888;
        Tue, 02 Sep 2025 16:09:48 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-52af235c6b5sm4769566137.17.2025.09.02.16.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:09:48 -0700 (PDT)
Date: Tue, 02 Sep 2025 19:09:47 -0400
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
Message-ID: <willemdebruijn.kernel.3542f359d6270@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-7-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-7-51a03d6411be@debian.org>
Subject: Re: [PATCH 7/7] netpoll: Flush skb_pool as part of netconsole cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Transfer the skb_pool_flush() function from netpoll to netconsole, and
> call it within netpoll_cleanup() to ensure skb pool resources are
> properly released once the device is down.
> 
> The invocation of skb_pool_flush() was removed from netpoll_setup(), as
> the pool is now only managed after successful allocation.
> 
> This complete the move of skb pool management from netpoll to
> netconsole.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

