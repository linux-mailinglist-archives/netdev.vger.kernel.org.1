Return-Path: <netdev+bounces-240864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A589EC7B915
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30E43355699
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95292239E7D;
	Fri, 21 Nov 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGqUg+Pq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5234C97
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753970; cv=none; b=J1JRctzdW6QVpYBCXCKn6HvyAfgYdabKQHtbPEtfvLG3+k6lvSbt53Zhcdne6xLA4t5ws67VtFg4WJZQpobeRccYJwSdU0//9nXHwq2eFSr1iOvD03fbw01B/TmiK3HAQX4FPxptxPXc3stnLrZ42wSyHPwumnz2bcRb2YkKCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753970; c=relaxed/simple;
	bh=PSJdiJSZHQoDHjKMtU/dVFqbsdhzwrtVGb0akkZddmA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rwptHRevj+tEtD4DbiKpWn1nWiaXQbAk0wtwpXDMizn0ObcUxG46P0LAWOc2+TpjxZVU7qmESOOYX1FFFm7tz7Xpa/+mcE1olo5GJp7NC8WPWWwWNc1QkXaLcmR2QvtO9rxe407K2u2fv/PQwaMQz9MBjgdeHLaZy+mVdGp5nqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGqUg+Pq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787ff3f462bso38209077b3.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763753968; x=1764358768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl5P9as8ricPRe9tEp0IeEvtBFgPl+zBzFatXU8CwSo=;
        b=TGqUg+Pqs2DcP0NueH5KiuMgpxcm+3jxSQRj1DoGwFbAdL8KE0ulfX9lgK2WI7QLml
         TlIVhjRfaaPaS10XWBCSCbMJPzW7deXQzZ7TwpDm2eSc5nUbCwvfyDklIyK7O4ah1hWz
         2PIQmDgAkutu6yC81d/nWUC7DZriS+OAKWGK8+3T6qKS0s0tKi4gbS3UNd/DoqLI/Yfp
         cFX6VHVBUTM37UNM5JiVkC/QQy3eUZbkjuCqA2ipN4SzPVgPwaqHZvzA6u9ZLFVSeNzb
         xcMZaWWVA61nJdUVaGwP9Jvu4v3aq9A/g1ELic+POWZdMY0yHHPDai+tL06TV25rAmBj
         1T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763753968; x=1764358768;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hl5P9as8ricPRe9tEp0IeEvtBFgPl+zBzFatXU8CwSo=;
        b=Rkj4EqB7z5Bi0vccangrbQ/XHDNOP0EHOg6MtpbDnd996afBti7pPZ5wiVZL+w7kt8
         9ogtN2favMkz3KgebZOz6FC5DMpzmRqKodM+yrjTy33V9A1Lo3VKUckMZkZgthIQEF7m
         L4ueDrOKa90x/4AHW78gsAkS0fM2zIE4YZU5GW5WoYvo8a6/E5CKh2mVitjMubpqmytk
         UiCK2w5ZK6762J55zRqjO8ajwgO9X0z+rc6fjGhGxX4+ZmYRQSEprRxcwuECRnLBCE0O
         yZouyzgRk/Zv90BdMkaCOr+2pL0lRLeLOwLN3qJFU/us2ZUa81ejS8mrZaNx43/dpKG5
         QF2g==
X-Forwarded-Encrypted: i=1; AJvYcCUODpGgjNw7IeoD+V/XMwo5p8bGJBU0p7YLym87bNi9SoqCyZiC4QpD0WwaWwPmEOxqY2ajsZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydhqMco/4iDysC99kX2CKF/z4cP2FaQze3Y8QS9kblLQKT9eWb
	+lx3cCLmW5F8y04LYyaGprVAzV0k+/xBDg4eJRDlRrRho0QYtqMyGG4t
X-Gm-Gg: ASbGncuZskl3nwu95QBL7k8I+0c7AV7Jp8hTVtMHoeSjdmz1ZmHo7ucNlIT+ygdU7db
	d+j4bu4gzvI5Zzaf63SZELRERCizQ33U6KkDGXkZ0vkIaPdCjJ9XLQ5FhGknON2zqmAeJ3EOtNn
	kmfzA+mdCCyyhlDOcctOkL2LElLZ24nCkg5tPUXm8V9YNxdA//4tPGAdTum1DgGA7RLsOltJD29
	aeNMNyizOi+cAuACNVi8wrC04z0kb5GxuEtMBlbTxcVYjjrjdalr6XX6CFzB5CSThcad7jE8eck
	GamAPogmBS3mNLL0VUjS2UtEcKz+psiT3yufL7kkmXFM/IQpes0k0Be2W7DB2tThUioltaY0V5K
	f6+LftszdTOk6I7JXfIAK5HgIWK8bxXnJcIugAYnaWICty5e1PajiUgB5cBK8VcgFHDaa8a/For
	pIvNdjXWBcC2osT3Uoe28S/eoO/YmZrml6FXCesMX+F+VC0t4+Pus4XNWtyf26m0WIkpU=
X-Google-Smtp-Source: AGHT+IG1pe28gpP7vpDGx0myhlyP0s2ykBtYBW25shiFw+ZuK5u3K6mc5PhTaKESGn3ruLKrW+c3pQ==
X-Received: by 2002:a05:690e:1596:10b0:641:f5bc:692b with SMTP id 956f58d0204a3-642f8e5136fmr5153091d50.36.1763753967880;
        Fri, 21 Nov 2025 11:39:27 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-642f71ae728sm1963938d50.24.2025.11.21.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:39:27 -0800 (PST)
Date: Fri, 21 Nov 2025 14:39:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 kees@kernel.org
Message-ID: <willemdebruijn.kernel.256cffcbb2583@gmail.com>
In-Reply-To: <20251121061725.206675-1-edumazet@google.com>
References: <20251121061725.206675-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net: optimize eth_type_trans() vs
 CONFIG_STACKPROTECTOR_STRONG=y
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Some platforms exhibit very high costs with CONFIG_STACKPROTECTOR_STRONG=y
> when a function needs to pass the address of a local variable to external
> functions.
> 
> eth_type_trans() (and its callers) is showing this anomaly on AMD EPYC 7B12
> platforms (and maybe others).
> 
> We could :
> 
> 1) inline eth_type_trans()
> 
>    This would help if its callers also has the same issue, and the canary cost
>    would be paid by the callers already.
> 
>    This is a bit cumbersome because netdev_uses_dsa() is pulling
>    whole <net/dsa.h> definitions.
> 
> 2) Compile net/ethernet/eth.c with -fno-stack-protector
> 
>    This would weaken security.
> 
> 3) Hack eth_type_trans() to temporarily use skb->dev as a place holder
>    if skb_header_pointer() needs to pull 2 bytes not present in skb->head.
> 
> This patch implements 3), and brings a 5% improvement on TX/RX intensive
> workload (tcp_rr 10,000 flows) on AMD EPYC 7B12.
> 
> Removing CONFIG_STACKPROTECTOR_STRONG on this platform can improve
> performance by 25 %.
> This means eth_type_trans() issue is not an isolated artifact.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Good catch.

I guess this applies to many callers of skb_header_pointer.

The protected against risk is that the caller passes a len smaller
than sizeof(buffer), or that __skb_header_pointer/skb_copy_bits cannot
be trusted. The second we could analyze and allow-list.

I wonder if there is a (known?) mitigation. Using sizeof for stack
alloc'd structs in a special (macro) __skb_header_pointer rather than
having the caller pass a separate length arg, __attribute__
((no_stack_protector)), percpu storage, others.

