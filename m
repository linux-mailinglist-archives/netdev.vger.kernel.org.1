Return-Path: <netdev+bounces-107617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14691BB43
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06001C2195A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F111514E0;
	Fri, 28 Jun 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxZdCbtJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE21509AB
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566112; cv=none; b=E9XfOTYMkcck8gQMySoivObkgPrkPCZZwB2E3uSZ77e4ft+O7M1ux45q3z8gWH5f5WIbDi1l12u4mA8M8ovqaJjaFwXUKKPn1cLsQwr0oLB0IfNum6Cfkn8srKLRMD5Rjx/sOsLbE3+WzlY2WSGfX8zzMP3C15QlUAnt24GhFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566112; c=relaxed/simple;
	bh=XQUUwtY9SWRb2rEi7jNoFwyug0udjuIjoVSgzEGMvhs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nQ/+tTuXO0/Y81jHUSZx5ZeRQsD08plS1MNE6VrDularBwvM2ktkhijumJ1Xzxt0SCcqaLzL3ZKkCNqvtyf4BUWbXmjK4D5N2uxBMno9UnGJjsSneluetxAFdEqn9ptebpHg5kU38/ry/EexYm9WPyemrDVfa6ETlO4iObWDLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxZdCbtJ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b5031d696dso1832646d6.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719566110; x=1720170910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIEMziZI+/a/nVz9RnVytLpDaA3F+D2wej9Tt4z/8Ms=;
        b=TxZdCbtJQecfSKg42LkWfE/DqOBfV3f9dvqdcqTGyHCQb2BeCwr85Gm/ZsqxeRgj0d
         l1BeyeBtFsL1sML9AJ8pGH1zUjGLNCoe5gxOzN99a2bhBcRhv9/UwGHw0NmnUJEZYA46
         jGaByJsK2ftfogieZCWvfmszmHb6oOANWC6Y9ZOyJSN2DObWJL0PB+zfWtFMTFpyLvLd
         Tt53XUB2lRsmQ8nhIc2ApzSTQX64P6uZOitgoZfGkto9viXe272SVDYWk3H/V6pJ5HvK
         AppOYxP0rE08uDbfTECiTTPQMPneTwDoF/xWSBG2Q+57n3KBrCXbZD1w/hlcZ7kos/mY
         nntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719566110; x=1720170910;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIEMziZI+/a/nVz9RnVytLpDaA3F+D2wej9Tt4z/8Ms=;
        b=BT4mFQw5VwWIQ1U0NCGAcB4SUjvej7DWpM9RZnfo7DCt4Ydh3wzy1b4Zi/YuixJ4MX
         fsw0wLhgCUNrbu3WZ97FKhwlo8joVlWiw6T8bV4SJOfjyfKwUB3v5tCyn3PMH9zw68N5
         VO9sH7GmKmuK1ZfzX9RP/8wnBd50ryGYSjjgBLP9GrvBFqjgmweWzWlJt2xeQ//CPbWG
         xl3NwoloJ8NUEDrDEjkmze49v3IyF2CJQxUEiP7PhD5iBk4GXdNgkBfccZZ5zzsmsxfx
         f6cEjHcboFqiCc+DEWcSAXj6Mr6+B9fxk655+/NsPkOa5aMGbR/ogb+tGLu+Lay3S2NF
         GHZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJKfEZA1MyJwidgtp+LfS/Uche+zfQoTie9InCzEXes8mATD0Q9rKqN437ukcdRXrrTatNejgQzsynE8mlxikALZdvNV/s
X-Gm-Message-State: AOJu0YzKuOvDPiySfqon1vlhsMWxM0+D0L1L4bTP+bWEFg0jQqSljwYh
	iDa8l6YsCWXmcIFMiHFZVCBADNDn9RIhDyJc++iOpsUmiXszLIo7
X-Google-Smtp-Source: AGHT+IELtvqKWLBmjVkuy+a/UCs9DdzYpG2+Ua7sVgpyQov/KDnA4TbpGTsMpYI4saJcNcqUNQjiRQ==
X-Received: by 2002:a05:6214:f2c:b0:6b5:4e24:5b39 with SMTP id 6a1803df08f44-6b54e245c75mr172288046d6.41.1719566109657;
        Fri, 28 Jun 2024 02:15:09 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f2726sm6223356d6.85.2024.06.28.02.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:15:09 -0700 (PDT)
Date: Fri, 28 Jun 2024 05:15:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
Message-ID: <667e7f1d1c911_2185b29486@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240626-linux-udpgso-v2-2-422dfcbd6b48@cloudflare.com>
References: <20240626-linux-udpgso-v2-0-422dfcbd6b48@cloudflare.com>
 <20240626-linux-udpgso-v2-2-422dfcbd6b48@cloudflare.com>
Subject: Re: [PATCH net-next v2 2/2] selftests/net: Add test coverage for UDP
 GSO software fallback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> Extend the existing test to exercise UDP GSO egress through devices with
> various offload capabilities, including lack of checksum offload, which is
> the default case for TUN/TAP devices.
> 
> Test against a dummy device because it is simpler to set up then TUN/TAP.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

