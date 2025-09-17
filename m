Return-Path: <netdev+bounces-224069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2811B80682
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFA71C8451B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B21EE033;
	Wed, 17 Sep 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ0Wl4Pn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A06333A90
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121374; cv=none; b=daUvXSkpHNkBeqlF3s1599dDi6nw4nsTkzXbqG67M4NO523QepmuNPijhDEG15iGKjZt9yjoXOJ6tHgdRPyRbx/wShAhHUu65qE72BrbvQn+k/v4TKG37YMv5jeQuxVPeW7P98GKUuMc9y1X9LAaHCuGeVB4ZlpFHymQ5BcCKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121374; c=relaxed/simple;
	bh=Se1Vw577jRLdWzMKK9gJ2dg/L11L97QCxTRk27ZeQVs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=faYDfqEejqKviSQ8q4YeSX4jA2va20Qjg3F0Q9oMFxWioJ8dGnlHDt3uePv8MTkJ4IZJtxtdZvvSJCFwHyOTd2i/L3ip+ZyQbdRFCrCt/m8wGEF3nkGRVOpn+056GIXKjoFC1uK+soPE24g7sLifKIlIxZSeSjsL8IxNbZ7IHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ0Wl4Pn; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-62adfdda606so2928180d50.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121372; x=1758726172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2BZduJIvK3gMA8imGSv6gc0QlifCA9VJ8GCfWrBmjU=;
        b=DZ0Wl4PnJHIxnei8DI+Vf8DX0imu3ynUADObE3aa4Renwwn36/lpGk3u6NvkWS108/
         ofWaBiUAyRVAe8Tf+pehxfomvFe0E5T33qEA83pG0G2kTR2zfbtE0YUVavIuFge1M42k
         THdZFBEmPQAq3HX0O2raSvcEMuEwhkKypT3boeszK6sba3QTycdMTyfv7NN4zwi65Kz2
         Qe7dCjRRT8zV5kDN+E5EXp+nkmtOjJqN2ipA+7RY5J5RmoBF8Z3kL/8pLaY/8T8WaYIq
         911+eZkpce5ogi/eHgeLkoC19Pq1kUJwu4+Jr/BYv4vFbSAzqsMnNegFHuLnVCHd5CX5
         UJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121372; x=1758726172;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n2BZduJIvK3gMA8imGSv6gc0QlifCA9VJ8GCfWrBmjU=;
        b=GISyhg9EfS9gPNkrlDiFYSnRe/LgUloDMR97H3V3fk1UB84yad8kv96aIRcUk8+b+O
         j0mrS13+3HtLz/TL8A4IbuAyOC3R2N+iZQsuxoicfDRoCfqpYoCBp2xBXNSoVd4B+irB
         SOQwcvrBdZkK0vtwthAYQNZoSNDbiZzAZYLtZ1yKuOA3Zp/rjGDcJggGh+HXrkDqYJ+c
         EfbwOWgAKFVRs1ndxa/Kx7w86VafSFKtPDbCyTBEeBObkaSRPa//dx9W7PZSgLsWEbmt
         47qExsirsm8I1GjHm+uHSMTXVSupC+gpO3nhWLn88ZPiaCVHfWOhoRhalHL79pwggR/V
         2E6A==
X-Forwarded-Encrypted: i=1; AJvYcCVeQB7fj0TFbs4vm0K05S1CYPJo59sxWerryeeXaed4KIiwD7AuzoklokxVMuere0t1AqNHyXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbLydKpkMdJupkDUHEzbhRxAfeeA++RxQ5E96MeBbLljtb6ckE
	ULpVRpGB6jGIRWgBKzh9KvFHKjXWkVE/VJRsHNdzEFR0pbtFkDyBAg2VKSzTlA==
X-Gm-Gg: ASbGncsDIJIGBMe854JBClM7ujv2bvRqjJp0z1SVg0if3/1TszDRkSAZ9+59o/b73JT
	ktiRZj+gQvzKD9CI+DSAWe83uE0mQVrfotvrQQUrRZgWq71ROem8sdTr7vptX94AAO8elZt3TOZ
	cPlrQk5L1tm4KfQE8Qml0z6lhM4rZMYrheiZTWlvhaXGs5I3vAGF2ctq492x4IHQd6Z0zvTi16b
	REIQSk0FXbq3IlD7gUODTsQMV7hucUu25/GGcyauVNAcLdUydM09vxMtwyZ5COYi4CyMCWMToSr
	aN7RTUN4MNMPGixZL5cFGzgWozsC8UknsGzUa0AOj63lmVoRAgC2eB01xuMeKJBhtJ3m/1Q1jQc
	axaSb9TfSUPcsn2TMCdFtZ0UY7BtYbDRV9eMbYaJP7phsYLchxuKUi1bH+sOtfWmeWq/N2eD3i3
	ypSQ==
X-Google-Smtp-Source: AGHT+IFxETrnXcsC7EmeG0LL53JLGzM0BnZB0OOtH9avA8srJXI4cGVttvBSsoMXk5JeO+C3mZIsOg==
X-Received: by 2002:a53:b08f:0:b0:633:9631:2fe1 with SMTP id 956f58d0204a3-633b05d4168mr1678222d50.4.1758121371434;
        Wed, 17 Sep 2025 08:02:51 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-78d80b41f3fsm26808276d6.61.2025.09.17.08.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:02:50 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:02:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.3384fba821cd6@gmail.com>
In-Reply-To: <20250916160951.541279-9-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-9-edumazet@google.com>
Subject: Re: [PATCH net-next 08/10] udp: add udp_drops_inc() helper
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
> Generic sk_drops_inc() reads sk->sk_drop_counters.
> We know the precise location for UDP sockets.
> 
> Move sk_drop_counters out of sock_read_rxtx
> so that sock_write_rxtx starts at a cache line boundary.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

