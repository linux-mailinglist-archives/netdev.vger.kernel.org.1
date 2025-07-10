Return-Path: <netdev+bounces-205911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD55B00C3A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED62B561966
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2037C2F2360;
	Thu, 10 Jul 2025 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViSFXXxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAEB2EE608
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176371; cv=none; b=Mlqb3+DdHfIOKlPPNKCevaOjBIPcO6c98jILJZQwGvkckjd6SrtuVmlOve7Vcoh8xcJYKMQnunp7sMWLJAR0wfKTBEGOTh7nW/KlN2JNSqwO6vksKysPG9cKKQHrp+9htCV/VoUc+CJNyyW6tDqyA3xnHqb3EQv9oRKJvgHtkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176371; c=relaxed/simple;
	bh=Hf9dcBJHVwFU/fWIhqXLbiQAEEYBtGe62EbLHpOy1+k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GXcpluK7PbdiHzjWbMdtA2DQmmantvgEC6FqMzt38AqofW7Bizr6XLqit9x/eUglEizp3DpDZjkXut9wlJeJY83F8d7m2fl1zhdGp8onli2yfTrYUnlOsYXoFS7Am5eqGQnxbiYmNwqS9za2gU7299Sfrf9M/ErG3NFlLwPPgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViSFXXxO; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8b67d2acfbso1211033276.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 12:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752176368; x=1752781168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPpTitKoksYianAayooCDCXtWyM+RwpClpdtZvOf+3A=;
        b=ViSFXXxOJpFZbbvXKgNdEliT0IgZorlFhnGS70vuEujirBUrzBEfAYMAFg5A4v4D9r
         g5jN4YpHCwNQDnpysRP9OLzZnTBJHb11gDOJR52fOZ3KVapkwePwjnyBHZzlOEEfvqk3
         Q7P5l7SSVUJIlEsxbXgJOK8ZvVbjmlOWAolqPpk6mbeKXeXvfLAF3ygw582rAjPYwKng
         N/5LJzz0B7/7yRpZCl0FkZvTofWLYBSrrj3VSlvGDM4g3KgpSQjkGbWmSfhxBuzXrSUO
         F1p9T61XvvTK+99SqSqNx+o+FL3bVR5sAc2reaOYhauYyJMFqtRphnvTKjc33LzlUE+I
         KYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752176368; x=1752781168;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bPpTitKoksYianAayooCDCXtWyM+RwpClpdtZvOf+3A=;
        b=Hvk0vMhn+FmhtynWw2tbM/rQKAT7itarXqyVIWmiWHUZM3X653VmJL1eusgEdmiu8g
         xHBj1HxYsXMtxQsQRfOmtZscd/m1pdJzSnydyhRfH7g2EPsuJZXe8ptZg+bl5QYwi2f3
         Q8iY6mEIQPUWaBLwcJLq2/qNuy90SDODWYiNb1o9wXVzEORVcahNbri5QfXO9QI4wJ7z
         0mtyQLV3tiKrTo2vIwqhQSze7FDk+8a1VAzyrjEXfiGvSnDbHnV04+QHkjfnGx5qvfvq
         jyQiVIhZoOjyTvUhUJmV8Oq5VMjNAVMnpgKy3gd9EpcBwJTgpcVQbhk7+HMz2qEXoA4t
         J60Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHJoMPKFuRde9LTGR8gSRVoMRdWFxctP4vOqeIulcb10jx5fHE+cfrpONQdT45o+UdqnOq/78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxXTz+w/c3HNqDynL2SZY6ck4/RtxX+J6FEmpxetBgjdRNaR7
	5LVagAqzw547hh+kn3XMo96lvpLjtoP587wq4R1aBPrjevKvWiJurUFq
X-Gm-Gg: ASbGnctwk0OVSdJWKIJUKq/af6OrWfVnPn5+AZGoli9N97BUCY8zl+UBEMpHejkNOP7
	n+puCfn6GjXXONw3kbAqRUlr9Oh7doVSDuY9oY7nCees+lvK2WD8ja81W4l3eRghzfJJKKuwlb/
	vlmywPwJxZL33jH6qW16pQlX/+SVcTvW6+o+4GlQ/m/5glV/sKp+yAmTJMnqBQacvTtxnEeW57H
	FJILBBHnYLEqn656hYQe2aUi6lq8Z5zRPpYOo0pK0aiaL2W5cQWev4adSqYjmw/xcdr5lUKhmBM
	fMmmmvyLblQRytENZ6r7Zi7T7x8l8FcKVODI1KHiHnb4IL6x7kU9j/ljaz/tPx2l1asxtvv1SUA
	cc3YYYyroUx90WXI4Lkpywwfd2rcEpRItOFLyVS8=
X-Google-Smtp-Source: AGHT+IFdJmt4orjKf+rHFkluQQ/emZRHZ/M04khes3KqD1sYgqLVwPVeQ0oqzLIU87ngF7J8axcthA==
X-Received: by 2002:a05:690c:b04:b0:70e:2355:3fe0 with SMTP id 00721157ae682-717d5bd6a22mr14536167b3.16.1752176368383;
        Thu, 10 Jul 2025 12:39:28 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c620ec59sm4223147b3.120.2025.07.10.12.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 12:39:27 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:39:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <687016ef6a2c_114eb42941d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250710155641.3028726-1-edumazet@google.com>
References: <20250710155641.3028726-1-edumazet@google.com>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add --mss option to
 three tests
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
> Three tests are cooking GSO packets but do not provide
> gso_size information to the kernel, triggering this message:
> 
> TCP: tun0: Driver has suspect GRO implementation, TCP performance may be compromised.
> 
> Add --mss option to avoid this warning.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

This is because of this in packetdrill linux_tun_write, I suppose:

        if (packet->tcp && packet->mss) {
                if (packet->ipv4)
                        gso.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
                else
                        gso.gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
                gso.gso_size = packet->mss;
        }

Which seems to imply that setting mss means that all generated packets
use GRO. Which tracks with the commit that introduced it: commit
58a7865c47e3 ("net-test: packetdrill: add GRO support to packetdrill").
Which includes

	+++ b/gtests/net/packetdrill/config.h
	@@ -73,6 +73,7 @@ struct config {
		u32 speed;                      /* speed reported by tun driver;
						 * may require special tun driver
						 */
	+       int mss;                        /* gso_size for GRO packets to tun device */

