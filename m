Return-Path: <netdev+bounces-285956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOG/JXIr/mk/ngAAu9opvQ
	(envelope-from <netdev+bounces-285956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 20:29:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0295A4FA9A2
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 20:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C206730234D5
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116113D903C;
	Fri,  8 May 2026 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tA9+tX1h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299AB3D8106
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264941; cv=none; b=JOYx2bp8wKw4jPEdhbkb8Y/AMXf+Dw33YlVMPphtphy+15rsQJtTdWEE4nojoJRhwsRnPL4D+9jvOmAUU1Pd40erMbmM1yYHNNJHPOVqphCgpokm5Cl+0oAy3+5ZNxogKSZ9VD4sLjE/qTw/iNiT6yNnPi84ZBvjT0kR+ZsC5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264941; c=relaxed/simple;
	bh=e+hoEU1BVnwIhgWSnafe2Ncw2XQkEPQSWsM97UwRlqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dn+7zw9ltBKV/+34NFGdCDSftHMre8BL67wZVtEc3Lni62PZ0ka9hvg7KVyIjyN7a9EWck2Qg3MCAaOhkGGhw26CKIBcTcy+Y/50Ut2gM573JV/VMd2iCnzZQ6FApOFONOKtwrAE3/sqYjx3RQnNMNTvcKQfb8G0GrZ9zmsXkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tA9+tX1h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso17731895e9.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778264937; x=1778869737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVMKZWAk0SD1GHr6tr/9fhB28kwxhrp+So3ZgzrkNIs=;
        b=tA9+tX1hlqIMJBQp8pL1dIdDwcZjzMQ9wtubMLabRWf7K0bR/A6WIro+Q2O1ojvMWk
         SX1rlwnFZNY5snfZhVIyu0B5KJUVmiELdEbMx8RZjQJoA36C1ABXz1fpeSbOd4WJnHtI
         +WuMIPxhbuLVXl9UOph4WsZMWrS2Qpla0uM5c6g/Byq6ekq0OqF1+h0Zxtdz/DR43d9j
         F54CLJnS9JOXI+6HJwnka4w8Jl+Io0316vhvqY0f7XB0vI/U07D2UUnJO0lUMGZ5nQaR
         YZKwCiYkvoN1QIspHuZQTB/BS2RIddDS1arJ4gJu96GfUyp0DJs0BkMtYC15aPhd57Uc
         g1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778264937; x=1778869737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oVMKZWAk0SD1GHr6tr/9fhB28kwxhrp+So3ZgzrkNIs=;
        b=fnnx9o6zwOn9ib6Vvxzyr0yy6RkzcPhPVaob142l3gec5R7X/sNAkgvrNMvnFTl1U1
         0q0M+j8WHc6v8QsG9AMN2+jIPd/cHIsTS0ejb95+Xh8WcuqkY/ggh3JNf+N3H49PINb+
         70Vo/4JaRwjmlW7ZaufkJi2Fuo0fWSardJ6+0JK2VbiToP1jnwHLvKIb4RTSpWubhrdg
         Ym47dArXBbLcdkvEyztMXIug9cRi5i3tl1Lvfik4G6SBfO+Nczvp8Q3r8ZSx6KAKuYOJ
         G+FV+JSJ2NaQVWioIzsjDZ89JardpchI3Ri7nHXoKO5CswM1xOJfnLm4W4hezbU+9ZJR
         XhPA==
X-Forwarded-Encrypted: i=1; AFNElJ80uS9hr6zpJrHbCrPgH7T1FxQHUOIfr4lRjCknvvDDE+4o6fYRNRGuWImLCn9A2ik3RLc52+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPVOkzKl0OAGNFyMo37pHkY6RfjkjGWTOu+FyuR8v9vHJDxpC
	kaCDD5s7U1e9NT9naQNOyYJFm4KDjsTdA9M6ONMiN9BvHUlUrMUdyZZ/
X-Gm-Gg: AeBDieslcZzoLrHMb+nLT+IP5tnL4Rn33Pw1dzwpr+yQMzHrV1WuRw7h43K26u8w9cu
	Uk0sXTNM0JAqZJ3Bhc/vEaiIv9wbruObbLpP1j2AidwgOfmA0Yy5ckaEFFqqcUpOlSc+mXB1DMq
	EHXg+ykjnSSbKf1TH62gffu33Wl4/eO8g7wJYkufvFn48o3b8LLD8D/vpPMcb+JCVP5RaN73GHW
	c2hpiZzC8VJlfC2nJ9OZevlVIExU6mjo9KdZKeEL+qQlTkNBrzYvvYdicxkj2WaYkoogbyKzAvo
	wkbqRPdQn3p4z1bTWl3Z7f6MeTjYcrVX41gT9bNz3I4/hx118+ugjC3/TkHpWMGxu7h1hqj3WQc
	nZhdObMvVFAoRJ+FH6yBw0V06yj6T/z3b8roukLmDUFCd3zSZxzzGsewD/QtN9D+xGoyxT73TFs
	F973PXYvQzz3qyQPDhukRorrTcHUVagxWwm2zDgYPWe4pVL+rBPZQ2pCr6g98c2S/v
X-Received: by 2002:a05:600c:8011:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-48e51e1a545mr213241825e9.10.1778264937224;
        Fri, 08 May 2026 11:28:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd3fd0csm10812815e9.14.2026.05.08.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:28:56 -0700 (PDT)
Date: Fri, 8 May 2026 19:28:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Adrien Reynard <reynard.adrien.08@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, kasan-dev@googlegroups.com (open
 list:KASAN), workflows@vger.kernel.org (open list:DOCUMENTATION PROCESS),
 linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list), netdev@vger.kernel.org (open
 list:NETWORKING [GENERAL]), linux-um@lists.infradead.org (open
 list:USER-MODE LINUX (UML))
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across
 documentation
Message-ID: <20260508192855.3b024c83@pumpkin>
In-Reply-To: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0295A4FA9A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285956-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,google.com,arm.com,lwn.net,linuxfoundation.org,davemloft.net,kernel.org,redhat.com,nod.at,cambridgegreys.com,sipsolutions.net,googlegroups.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri,  8 May 2026 18:38:03 +0200
Adrien Reynard <reynard.adrien.08@gmail.com> wrote:

Nope, all these are correct as is.
I'm not looking at any more.

> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> ---
>  Documentation/dev-tools/kasan.rst                   | 2 +-
>  Documentation/networking/switchdev.rst              | 2 +-
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 4968b2aa60c8..3a8bd40ad905 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -392,7 +392,7 @@ reserved to tag freed memory regions.
>  If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
>  will not be enabled. In this case, all KASAN boot parameters are ignored.
>  
> -Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
> +Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being
>  enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
>  support MTE (but supports TBI).
>  
> diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> index 2966b7122f05..948bce44ca9b 100644
> --- a/Documentation/networking/switchdev.rst
> +++ b/Documentation/networking/switchdev.rst
> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>  monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>  bond will see its upper master change.  If that bond is moved into a bridge,
>  the bond's upper master will change.  And so on.  The driver will track such
> -movements to know what position a port is in in the overall topology by
> +movements to know what position a port is in the overall topology by
>  registering for netdevice events and acting on NETDEV_CHANGEUPPER.
>  
>  L2 Forwarding Offload
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index c37e8e594d12..7b08738c30aa 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -1092,7 +1092,7 @@ be formatted as plain text.
>  
>  Developing always goes hand in hand with debugging. First of all,
>  you can always run UML under gdb and there will be a whole section
> -later on on how to do that. That, however, is not the only way to
> +later on how to do that. That, however, is not the only way to
>  debug a Linux kernel. Quite often adding tracing statements and/or
>  using UML specific approaches such as ptracing the UML kernel process
>  are significantly more informative.


