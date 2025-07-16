Return-Path: <netdev+bounces-207550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961F9B07BEB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F7B3AFA14
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E92F5C37;
	Wed, 16 Jul 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGWaMnF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183AA2E3715
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686743; cv=none; b=D9wrWKTFC2GDcxpKDrsFfy3DxGMFLfvFbTkL+eDeqASZ4q62611CqVNttBwx8ndkdvkOZfZrxHm7fjh71IlykwgYWBCufriv83SdxuVpOmsbtYCbR2serdIDqTPp7kPM7IZj0hGYOj3YQA96QQ+Lr0+/wQtsIMPjFGj11u79oBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686743; c=relaxed/simple;
	bh=B9+0g+0d/EHpDoGPUSylaxswVKsYOn1l/2vSjay4OQo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SX6/sqRmcX+pgK8u6QNkls1CqdISupH+Z3Yedpa28SLjSUnUPo7Pz6gqVPsOlN1XnyOXWGPzvaI1F24zQa58aJDM6NzeekBS0iT/mIl7RsHx7iXec6ikYoa+ubCwNKhVxpKznMGSdYZ44d7RdPh45z+aVRS2TQ4F6kB2u4Pgm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGWaMnF3; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e740a09eb00so162602276.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752686740; x=1753291540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mIl+KPOc5RydPnrmXCqMrITXsgkZJDaXRKUgFte5ck=;
        b=OGWaMnF3CIkvBRcUzT4i4Ksief3tmbtz+oAXm/zazwiLil48rghtCO+bpakvDkTqCe
         dDNjscFW87VhNZ0Hpu1UP6WSjBz0mALuUSSRVzhUtNFobvv3uqDw2JYWh1BpEWcUHDTZ
         24tuaj6mORGjnBvJbaR/3fEFs5PpjIm5h2BfLrGV7O6osIYp7hLk0zLZIc6bgPm1EIZC
         nFaRNyAkvDVENKK3OCOZeRZgNil1EKb9xZg3kKc1oPWNGC6mEGxihQN+EO3mAbljEb8X
         gyCzddWi4ygJdeDJ2mT6GEk2pYNl8DdtesLY35td4xHTr/LShe3FOUzhdvwcAHfBwbkB
         clfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752686740; x=1753291540;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2mIl+KPOc5RydPnrmXCqMrITXsgkZJDaXRKUgFte5ck=;
        b=ST44GkujPBYGSd+ph/20WvKdiLJQLBGcfYFOCVEkNbDMKWr0jyFSGby90jxBNc7x9v
         KUfCcg1hhqY0ktTavU7gr1qhtjr6SYhFYTGNSvJK53XNKB8/STugR93nlJUXYleJgibk
         7vB73XDkDeS5LzjipMfGRJ022CYxv/4DLfK5/PXRy0n4zUA6PNy5Va+fFYwdEQKT+uYZ
         UeNb3CZw/8af+wIo88qJdHAqiPjgA0yU818ftLI/KvRZHr0M0SA2K96X5ygvCDAObbsP
         xUp3TyPXX7RSHIQ4wpS/2qoIRYfGWkshmc/zZy9iSXyY41bVPW9p1/kZu5EUFcuUcGTl
         vIHA==
X-Forwarded-Encrypted: i=1; AJvYcCW+upOGzgOGSpjLo8HuJtYVq5ONf4CWqje/Ecd45t+HRgc4ZTuLe0XbSya4Ghy7HYgsOb2nzSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/l6FWD63dIF33WFDs4nP8kWvT5uza0cXZW/1EpDNH3jvdFVu
	6NYOcdGzmns19DqjYW6A16Yz4O43Rn3YuDm/gP2lJ4cjzwA8O+vNo/KI
X-Gm-Gg: ASbGncvK3ppi77WJbPzVpf+gnt2LjLu89Hj90fF8iUBhcwQS3N0QUxfisMcDI+Mler6
	afKPiWjrhDiacU4LIyl3mWdk4EDZa1cIeVGsbR8wfIc+j5HB7nfn2pkHCkLkSRO4LkLEN1RO5uB
	5ZMUOsC9qQoM3yAETL58XWgo5HD12QSpL4TQqBA+8FXE8AQS63JymY4pKMqmkl9I4hw4LDrXCzD
	OR8bKfbKick+saPAy/O3u8vh02fwR4W1wd84bsBTgMTDIgORyRj1yR5W3nFEZf9i3rTCk2n4dMh
	stRuXzWvQ428ZYeCiTtfFCdky793T8xkkbrbFgpr7jMxvzoGAFbF9UGVXf87aNZCiBzjota8zNx
	w0cDebdKj4c+/0m8Lrd/wJp+JF+qtp43fuNEwIHHjrccZ4soDjmNjcw0ftSTPYc8Ja3c1lQ==
X-Google-Smtp-Source: AGHT+IF7AasOlz+8EtxqS+q+1PxKgh0uMD0GhW8oujBwQWNf50Q/JI6tbI2He1T/3Oa+LrQo42ZZSg==
X-Received: by 2002:a05:690c:4b0f:b0:70e:2168:7344 with SMTP id 00721157ae682-718374f0f89mr46338687b3.23.1752686739928;
        Wed, 16 Jul 2025 10:25:39 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c5d4f9eesm30041777b3.13.2025.07.16.10.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:25:39 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:25:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <6877e092c394d_796ff294dc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250716144551.3646755-5-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
 <20250716144551.3646755-5-daniel.zahka@gmail.com>
Subject: Re: [PATCH net-next v4 04/19] tcp: add datapath logic for PSP with
 inline key exchange
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add validation points and state propagation to support PSP key
> exchange inline, on TCP connections. The expectation is that
> application will use some well established mechanism like TLS
> handshake to establish a secure channel over the connection and
> if both endpoints are PSP-capable - exchange and install PSP keys.
> Because the connection can existing in PSP-unsecured and PSP-secured
> state we need to make sure that there are no race conditions or
> retransmission leaks.
> 
> On Tx - mark packets with the skb->decrypted bit when PSP key
> is at the enqueue time. Drivers should only encrypt packets with
> this bit set. This prevents retransmissions getting encrypted when
> original transmission was not. Similarly to TLS, we'll use
> sk->sk_validate_xmit_skb to make sure PSP skbs can't "escape"
> via a PSP-unaware device without being encrypted.
> 
> On Rx - validation is done under socket lock. This moves the validation
> point later than xfrm, for example. Please see the documentation patch
> for more details on the flow of securing a connection, but for
> the purpose of this patch what's important is that we want to
> enforce the invariant that once connection is secured any skb
> in the receive queue has been encrypted with PSP.
> 
> Add trivialities like GRO and coalescing checks.
> 
> This change only adds the validation points, for ease of review.
> Subsequent change will add the ability to install keys, and flesh
> the enforcement logic out
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

