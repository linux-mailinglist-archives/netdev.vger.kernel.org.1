Return-Path: <netdev+bounces-100281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7BE8D8650
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458232814D8
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BAF1E525;
	Mon,  3 Jun 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh+K4zvg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08168FBF0
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429509; cv=none; b=LP75IeFGw1elyRcqDqFn/SIC9P4FwxQzFURadpQUHv8FqGgUWZWNVMxfXzqTgPvTGGaQbzNcPE+nLG9+sMX3fNBCJ6Kb0wK4qKYg2bgzn60pH3U5IWFTKjApWZR1YFUeosXnF+Ip6o0nUwaANoj36+v9fByiKCym9ZJ+R23xtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429509; c=relaxed/simple;
	bh=ioQ5KF/zbLWQqVR58nqvHdJ5IzIHS0gPNw3Q1ZTT5L8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FWnTUqRcfezEedsi1ftD1M7Eu4j9HdQ7n42DDmL05YnE0Zb1cO2qObo/JuIZWd0JCQF7m0TnZbhcFjWPdOc5orObwBuD5zRdrT/OS04oKu/rB9HDtAIFvN9vyyR8ik8l+1+CtzJLPktgiaxJ4AkOsEFumReceh0D4h0VUfNU5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hh+K4zvg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717429507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W7q9OWi35t1/elcXtW2zo9yCoz0EpM2qoyV0Vc5TVeU=;
	b=hh+K4zvgkJ2fxC8Kd2dOMUk/k0ZzI3+ERHN+65Py1ymKc+5pL9AYdNtrg8+5cC5HzQYr42
	BAwBYV/pe3FFZQ+ugL7EYSO7UNDlAOb3Z0lSVvbYig1j8LiHs90T4TG7zi39nTn7MYfiCe
	/TG3OoloeFetHyhq6jfbNORb9L0pkb0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-UZrgumqjODSXtVIyPTxCPw-1; Mon, 03 Jun 2024 11:45:05 -0400
X-MC-Unique: UZrgumqjODSXtVIyPTxCPw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42133136397so3510325e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 08:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717429504; x=1718034304;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7q9OWi35t1/elcXtW2zo9yCoz0EpM2qoyV0Vc5TVeU=;
        b=P2MXMCisTnfl4QYlT5aokDjYkXS1MkRwDgryUOCoMiwMcdUA0SC5xPFOyDWzFGsMWr
         H+FoOz/4qG6tRbgd3sCGs3JitJqe+N1kHxByNZV3LK7KvkppFQRbgd9l7FGch3N/BT3Q
         5wds3pr0e9kScWlQPJfCI4TNZC3FKkwhxWpUXX+624UtNUa85pxuD+MOVzGQOdNhs8Bd
         zDWOf1MvwIVVm2CaoptMrW3bBcaJhFhgklhKRPFFv5SFwiKK95gp1IxIXyjs2Cg/ar9j
         aNLmyqNyGUQbR0zcjeKli6ax1yieCF4lmkQxDg6yq3cX5wp0MYYUjGYWlBNnD0S9Foxz
         Zn0A==
X-Gm-Message-State: AOJu0Yyr/Ys4F1Gc9ciFDEgigGAwOz/dGNLjqFJREHWCH/+GLznWSiDK
	/1mU3loSL7zpdev8g4oYKOTYQbkPkD2BDPuAi8vaBZd2UohPVeXwpLYAu8StF0KSKOlnCSk5+5z
	hdiFhn4fHWX9jTLW6g8wd8utDEnTgA7ei7uRd4n4BoJ4Btn8DOBWqAQ==
X-Received: by 2002:a05:600c:1c1e:b0:421:2c02:9779 with SMTP id 5b1f17b1804b1-4212e0c55c3mr76207665e9.4.1717429504255;
        Mon, 03 Jun 2024 08:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1pKGgnR84i8AqW8l4eNbVZNpKIgQK12LE32CevW6gmQshM9W+la+6cjCOrl28P7NJh+WRkw==
X-Received: by 2002:a05:600c:1c1e:b0:421:2c02:9779 with SMTP id 5b1f17b1804b1-4212e0c55c3mr76207405e9.4.1717429503878;
        Mon, 03 Jun 2024 08:45:03 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b74:3a10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0649fb5sm8921316f8f.94.2024.06.03.08.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 08:45:03 -0700 (PDT)
Message-ID: <869b10820071077afa766ca4467e2d2cc7615413.camel@redhat.com>
Subject: Re: [PATCH net 0/5] dst_cache: fix possible races
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Mon, 03 Jun 2024 17:45:01 +0200
In-Reply-To: <20240531132636.2637995-1-edumazet@google.com>
References: <20240531132636.2637995-1-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 13:26 +0000, Eric Dumazet wrote:
> This series is inspired by various undisclosed syzbot
> reports hinting at corruptions in dst_cache structures.
>=20
> It seems at least four users of dst_cache are racy against
> BH reentrancy.
>=20
> Last patch is adding a DEBUG_NET check to catch future misuses.
> =20
> Eric Dumazet (5):
>   ipv6: ioam: block BH from ioam6_output()
>   net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
>   ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
>   ila: block BH in ila_output()
>   net: dst_cache: add two DEBUG_NET warnings
>=20
>  net/core/dst_cache.c      |  2 ++
>  net/ipv6/ila/ila_lwt.c    |  7 ++++++-
>  net/ipv6/ioam6_iptunnel.c |  8 ++++----
>  net/ipv6/rpl_iptunnel.c   | 14 ++++++--------
>  net/ipv6/seg6_iptunnel.c  | 14 ++++++--------
>  5 files changed, 24 insertions(+), 21 deletions(-)
>=20
LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>


