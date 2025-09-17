Return-Path: <netdev+bounces-224066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE693B806F4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2592E1C837B4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E128362998;
	Wed, 17 Sep 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgQpZjgA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1D2C21FE
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121253; cv=none; b=bjpVvBohvJ3MzbBu6/eXrgN4ckreOEGH1TWq0HHpo1s5wk3N54MdrKY2u3Ziq7N8PNRe84dEv0B4jFKLenZIHpbFR285P4scnPsvvAM4FKFBL/Zi9SwEdUU02/bJRIItkdcQKM4iMdd0XkLxX/jY7/t9TkLPpccpMSI843WtcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121253; c=relaxed/simple;
	bh=TYl26bnnItnY7GXgsZuKrLRJ9dbcrEwHipWv3mASrrM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bzQcKWNwrk5/JTNOHLXUI8IZGI+7dbyv85tS9lk4OTVxwcm9aa2D/TmlKg2vnms8IpP7uwUY77X0w5qqiKcKwiIK0b8ba3AXKD1do+2WMPiD8qf74NefZMHJ5oGGwrMiF/AeIoUSBbteCagUII1+0I4jN0saow5hj6d3ePu3ANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgQpZjgA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-816ac9f9507so109518185a.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121250; x=1758726050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivEkx74f4u9cfjT3HX+tGSTGuAqV8MxnV0gECkK3awA=;
        b=FgQpZjgA0z2Zcdjf1G8zp3ujZOf65Xj2M/ayUmXinNhoL0TvxL9olLUBdezQ3ZcIxZ
         AJzvAJcLHsDrIa6cHDuvskcv0Cqx6a+feAEmA2QGI/c+89vS/ZeljmnsDqdYbRctWHMF
         xneQTDbe/waGuVd+uSHlVLPF0FvEDda2Zx1pQyMg925SC4+qASijl2sgOB9lAtA/D2EN
         vAeLqR97x+heh2QTQ2MPixx1BqOzKJG2+vohs060V9NOwhYTxVaNBf7YPVGGnK47jW8N
         fLIq1JTw/vEtWEFW2pXXsJ6Aw7vaunSFoq6T0m1D633EAN5CZeeEtEUya8MWb8Npi507
         aNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121250; x=1758726050;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ivEkx74f4u9cfjT3HX+tGSTGuAqV8MxnV0gECkK3awA=;
        b=UGk91lI/GaGpr2R+KKqymQKkOztZR30PuVTXfjxlGPz/V9zZTGWDq+Xgp/Fqs79hli
         jJUoyXoEp0pGZR+nGT1BSdCigwYYYsKTV7spzuO6DgvUdbxUKyTMS+b3htqNkRxZwDGR
         DoT8D8oxlpDOYVXUTiuDGub7uv5bGB4m7CyY9I6IamsaIKp74RGVkzp2AJlPf26HSkcJ
         3P6Tf7rlmvr9LLke9VdlOdNChlNEfA10utVPKUoY6v3+RSgjrxx7nyXmms03yzBN981x
         aFuGfh4KwxwKhZLsbfcSYX4dxvT6XtV52uZGQhFnw+yujEaikPbA5lh5r9mNLDbD1fhl
         LDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGqbUKl2eIP9VOdlBBya044vMigSQYxCEyZUjwrlnqGSAlbNyBBLUXmkPYt08Oponi63IyGsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+Wh3sxivvwPQ6xNc9aJ0z+Tgw3y71bNQ0wfZbZWIDBiZ4NQH
	D1+ebLBRVDL5YO6g55/EqVjINClt+e3eoGrb60lMmhdXJQCDv+AzYETG2VrUCA==
X-Gm-Gg: ASbGncteVlbT9hb1d3KmSs98pamhK406fSzNZRR5fxxoxsfI/V+HT7dIDCBaRKOTBOW
	1ObZos1B4bESInpoIZM11K/lFHifnD7euGYygv59ShXYuaRkxLxxpMU+hA1HP6X3Hts6G8SNYMD
	Z1Ef8fbix/i6bg6B5uAYbeG5ssCE185lt5uCFMsa2wdhohg9es4SmaGReP6cH21eixJmOzR041k
	BgXcgU8N63H9KVBGLz3WUtcIdt9stQ2B0hQW5yOTBFmjAx+fGpxLRGGLeV5matUbQdRue+6us2U
	zNluwjl3aBQT3ki2uXpVTdEbDmNVE9jhyRd5HnmymEYtOMJNmHWkh1Pc9i0iZ2IbWsDy4FheufJ
	7+n1oaa07GMOunvc9chF8YxKKDQxeeyc3gUzQEkO0vP1xae2+hsV6QjX+siUWiSq1dNklJ2R0j0
	UyMg==
X-Google-Smtp-Source: AGHT+IHkinDofXmq9sQ/Egf3+UwCDZNO9SRhlLCmEZR67xfdUwxiin0FIqIlnuUorDJDlCJIH5ktDQ==
X-Received: by 2002:a05:620a:aa05:b0:835:8ba:c4a7 with SMTP id af79cd13be357-83508bac4c4mr77020285a.0.1758121250385;
        Wed, 17 Sep 2025 08:00:50 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820c974d54asm1142082085a.19.2025.09.17.08.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:00:49 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:00:48 -0400
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
Message-ID: <willemdebruijn.kernel.20220031a140a@gmail.com>
In-Reply-To: <20250916160951.541279-6-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-6-edumazet@google.com>
Subject: Re: [PATCH net-next 05/10] udp: refine __udp_enqueue_schedule_skb()
 test
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
> Commit 5a465a0da13e ("udp: Fix multiple wraparounds
> of sk->sk_rmem_alloc.") allowed to slightly overshoot
> sk->sk_rmem_alloc, when many cpus are trying
> to feed packets to a common UDP socket.
> 
> This patch, combined with the following one reduces
> false sharing on the victim socket under DDOS.

It also changes the behavior. There was likely a reason to allow
at least one packet if the buffer is small. Kuniyuki?

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index cca41c569f37621404829e096306ba7d78ce4d43..edd846fee90ff7850356a5cb3400ce96856e5429 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1739,8 +1739,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  		if (rcvbuf > INT_MAX >> 1)
>  			goto drop;
>  
> -		/* Always allow at least one packet for small buffer. */
> -		if (rmem > rcvbuf)
> +		/* Accept the packet if queue is empty. */
> +		if (rmem)
>  			goto drop;
>  	}
>  
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 



