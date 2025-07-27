Return-Path: <netdev+bounces-210408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BD8B13209
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 23:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67B43A3DA7
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 21:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091E924676A;
	Sun, 27 Jul 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="jKOTtYK5"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084A1DE4FB
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753653164; cv=none; b=k8aaSVrTZrYKbXIgXl1ctR1jpE0vbDRUPvEl4EkcjWuBv3taCaCA8Ay7VwZHtcOl3ovmYzm/W00gnlrLy5qi4WAYnw4W3IkRbqpg2cO+P4Bo/8aatpcIs0cALv3rIOM58v3XXwA/xHquotdnD7m+OZ69x7wJ2nuq1gdxUK8MZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753653164; c=relaxed/simple;
	bh=BsFLu2PrnOgLDND8gTwXNZQyY3PMgtgnKbUSKqjTb4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AdSlT3XmAtjo94GTNPT6iWczhKXjVZAFl5MoPMrQ6lPVecaEoQw0XwY6g0DZ6tOOJbF7oIGMShVQRScmHb5gbe4QpJTdvBYzfyUjTRRMXpnGYbCHEEDmYY1UwJMBu3QjrumXj8kJhnUV/CnX3Y9OZsASVPDak210kYgIX3eMt3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=jKOTtYK5; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id EE7BC240027
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 23:52:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1753653161;
	bh=SOEe8sOFwoxGjcZfi3tvT/0iwJ9By2qEoi/cCaaRnw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=jKOTtYK5scgzdWWs0FHxeGxx21P6miN5d+n5UBZxU2KytOo+dP099g0hh4cWUVA13
	 uTG/S+AhZ+aGaqrdwHnRFtv1fasIPTxWU9o1aNnm0p85qAgwahpJGArikyaLUwB7D6
	 QxG/J5YwnZrCzEvh9TntGPGzDoYgh4b6/t2NRMKA8pGN/zot+J7A8iXpJG2qv94yrL
	 dDUlDmDj5BQTHwwpGzvYxoZOksqQFvXo1wWP6OrhmACVWHS3QbjxkznurVCcMIOaLX
	 GSzdpqv9pQyDgGnR29QfH8b0W98bn8MObyyQ9a1kTrgK8gdKn3YRjyVtkEigLJFTLf
	 cmjtP+sKbZRHcul3QoGLAcBKn1Xx8Jk7RMNolsG7icu9VUBfyLPCAKm/C2q3roXUNu
	 xnzBO1J7H020SoZzPCMLG/yOIAIMzD5eTEv4VHzsYRKUzVUhxqDww/lkw3nVzJORfJ
	 fhkyyAFpLrUklfw4Pi0YEg+NHSbXFgsZof2T7wFuZKS6rMMMu4b
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bqwMC2flRz9rxf;
	Sun, 27 Jul 2025 23:52:39 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,  "David S. Miller"
 <davem@davemloft.net>,  David Ahern <dsahern@kernel.org>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: ipv6: fix buffer overflow in AH output
In-Reply-To: <20250727-ah6-buffer-overflow-v1-1-1f3e11fa98db@posteo.net>
References: <20250727-ah6-buffer-overflow-v1-1-1f3e11fa98db@posteo.net>
Date: Sun, 27 Jul 2025 21:52:41 +0000
Message-ID: <8734ahcndl.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charalampos Mitrodimas <charmitro@posteo.net> writes:

> Fix a buffer overflow where extension headers are incorrectly copied
> to the IPv6 address fields, resulting in a field-spanning write of up
> to 40 bytes into a 16-byte field (IPv6 address).
>
>   memcpy: detected field-spanning write (size 40) of single field "&top_iph->saddr" at net/ipv6/ah6.c:439 (size 16)
>   WARNING: CPU: 0 PID: 8838 at net/ipv6/ah6.c:439 ah6_output+0xe7e/0x14e0 net/ipv6/ah6.c:439
>
> The issue occurs in ah6_output() and ah6_output_done() where the code
> attempts to save/restore extension headers by copying them to/from the
> IPv6 source/destination address fields based on the CONFIG_IPV6_MIP6
> setting.
>
> Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b4169a1cfb945d2ed0ec

Oops, wrong syzbot dashboard link. v2 is sent.

C. Mitrodimas

