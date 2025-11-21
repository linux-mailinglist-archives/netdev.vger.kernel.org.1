Return-Path: <netdev+bounces-240611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BC0C76EDB
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8019351D64
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3F292918;
	Fri, 21 Nov 2025 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfQ+kffu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B228D82F
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690380; cv=none; b=fue4HrdrRBAWmnZR+sDt2mKojd+Mr4X4+8J/ZLZTdsNuBvwM9WPQk54d/rK+DDm17ahjOKYSnf8QcJeU6u/zDNUCSTf3+jyTMSB+yvnccPJ78oH/siyCFhrmDx4sND9MYjZ1iEgqXHrpF5wwbIQamJtnXnmGlY2HEwOf7uBHelo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690380; c=relaxed/simple;
	bh=nTmR67vcxzQ35y9XXUKwhejR8p487YKbOcVxeDeeIXo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AAP5SiZYFBgy17+bJ8nvNA9v9zWV8eSqD1QD48JUgqGsy2xVylMk/m9wXfhlaeoYah27P3oMLWaseVIiAOpNQSYMqstPbQYITogeHTUw7vDghlrTSu/C+GTdwEQs4QEbayg1x2xY40ZYw2dmvf+WTq95cJQJOby8aKQvahh5FSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfQ+kffu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so2839433a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763690378; x=1764295178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lv2owah3Q5gGnsvEuPsRQ3WtigDkSvOdHACxiziWag=;
        b=tfQ+kffuxzIHh56EnQi2EBbNrUSzniuhkjt+bvJGJBM6qkFeQZvYZD18E4C/XBaivT
         JYeTQSoI0x4BwpMlY0vCUZJibte/CxBN6JjyYllfFHAqwgY0qfAVSR8gnxnoOtaJaG4n
         D1JjI9omVTEccFHinmTTeF/h9dtgd4jZD0X4BJgHMs9bTOR41aU9FLvCTQLTfG7Zj477
         UHiRUHSbQQmez1XcYmDppPWoS2Pu0Nq9lLFhhjTBLIWCbr/XatpSHnfXw0M0QQBUqxkf
         l43j1oB15u8Bt+KpJXWdyNfOBYawq0qq9EmNGCkK0ow9vKo7L/HTQ0BevI1qvGucCXgG
         FPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763690378; x=1764295178;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lv2owah3Q5gGnsvEuPsRQ3WtigDkSvOdHACxiziWag=;
        b=DmRQR/6lyOHutHxbBWt5xs6B6p+8UVOlcmtkU6r+CGBHRmFraY5mdvo8S5T6I1eKM4
         Qb+oD7eaiF+ny/0UBm/MCwwZO7LWxHFrrLqG4BO4mQH3SWt5FgEeWlaywhYvP0r6PA10
         NCdSe8NoqNVl1v3miohbtsRDOMQa5XujE8jwsaVZAnjBORGYrj+crGlVHoFHuJ1+RWU5
         Y4Ymp1qEZg7tfkorvSgw+WmYis9WYlsMNHDKj9k9LhwCGXt2AqQsqYr+VA1SPKdgd5ca
         LumreyUbVGLK5kQc+sZNPT/wSoSBiphVjEOi7RD1dGFYmCdTYGSa69+JYEIIovERJpQ8
         0wUQ==
X-Gm-Message-State: AOJu0Ywa+PLJASxeto5h/03tucfMjytZarg1mPo0Da9q/1pOHHajoNmI
	hE8jdyV5fHsDkzXDusgyClhia3HgJPqMh02dbO/Y6JJ3iRx2U1+gGHoO0l5eK/gIfilQT1e+Hw=
	=
X-Google-Smtp-Source: AGHT+IEgiepQngkYa4nS7VAoljVzEM4N7b0jgDAGg+PBUAAxSepqjrb6BlolpwPgDNgpb96mvoA+ff5L
X-Received: from dyji33.prod.google.com ([2002:a05:7300:7a21:b0:2a4:50ea:8fa8])
 (user=maze job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7194:b0:2a4:3593:c7c1
 with SMTP id 5a478bee46e88-2a7194ab2a1mr168695eec.1.1763690378218; Thu, 20
 Nov 2025 17:59:38 -0800 (PST)
Date: Thu, 20 Nov 2025 17:59:33 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121015933.3618528-1-maze@google.com>
Subject: [PATCH net] net: fix propagation of EPERM from tcp_connect()
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Neal Cardwell <ncardwell@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

bpf CGROUP_INET_EGRESS hook can fail packet transmit resulting
in -EPERM, however as this is not -ECONNREFUSED it results in tcp
simply treating it as a lost packet resulting in a need to wait
for retransmits and timeout before an error is signaled back
to userspace.

Android implements a lot of security/power savings policy
in this hook, so these failures are common and more or less
permanent (at least until something significant happens).

We cannot currently call bpf_set_retval() from that hook point
and while this could be trivially fixed with a one line deletion,
it's not clear if that's truly a good idea (would we want to
be able to set arbitrary error values??).

If the hook *truly* wants to drop the packet without signaling
an error, it should IMHO return '2' for congestion caused drop
instead of '0' for drop.

Another possibility would be to teach the hook to treat (a new)
return value of '4' as meaning 'drop and return ECONNREFUSED',
but this seems easier... furthermore EPERM seems like a better
return to userspace for 'policy denied your transmit', while
ECONNREFUSED seems to suggest the remote server refused it.

Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: bpf@vger.kernel.org
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 479afb714bdf..3ab21249e196 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4336,7 +4336,7 @@ int tcp_connect(struct sock *sk)
 	/* Send off SYN; include data in Fast Open. */
 	err =3D tp->fastopen_req ? tcp_send_syn_data(sk, buff) :
 	      tcp_transmit_skb(sk, buff, 1, sk->sk_allocation);
-	if (err =3D=3D -ECONNREFUSED)
+	if (err =3D=3D -ECONNREFUSED || err =3D=3D -EPERM)
 		return err;
=20
 	/* We change tp->snd_nxt after the tcp_transmit_skb() call
--=20
2.52.0.rc2.455.g230fcf2819-goog


