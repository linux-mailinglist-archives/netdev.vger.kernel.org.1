Return-Path: <netdev+bounces-230090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB906BE3E4E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFB5650778D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59467342CA9;
	Thu, 16 Oct 2025 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="WjFuUfW2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CD342C80
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624575; cv=none; b=uceNwn2G8xtGruBXWpfgt/VLT57N0td97CR5ooGKkPBNgTTxi4zWFRYZ/1SXgbILuoG7WcP1a9kTVyE9h1eqN23KebIJlFKVai98p/A2bbOH+JP/tWL8E7E9o1+ar2e9p7rpe1vElShxGGgcwcYJuoxwowdXZkxO9vDhUzFuAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624575; c=relaxed/simple;
	bh=24clnB55FhTXMp6OmY5NnZeEMfNz7EwKMLb53yZh+bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NplsCw7XbPMTV6lukoQ7ycXq0AtHLnSWWzLMQvCuZ6l9aZcsEAJCEAUcXhecCjr2CyxgCur4WPxwvh9jblGLiAsHpbIRPBus8lQLigQhA8L0wNCH+M6cPVHkdLhNg2jBJx/fQul2GTNjsmoyYOvUszXoHd0XSdocGxjjmyBiGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=WjFuUfW2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so1453454a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760624571; x=1761229371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8qZQdR7x546GAqgtZJodcGIYh+OFm9vxtGpfYPYiQU=;
        b=WjFuUfW2FOydAymI8twHhbYfETwN62NAypszRrsViYyjGH+Uun6E6hKyxFHkcLqRW0
         n9C6JI7OFpttedn9AxrQwPv6mCGtLt2BCFlIprp5ir68H2X/m5jFgsjc773HSmYppKbV
         idH4ka3QGePEVgUyzoZFFk0H5vrowVk9LZ8Sc4F+moXqRAqUJKcHv145+V89kSiX+DAz
         mhTiNlxLCWRW0k3E2S44nIJ+ojnZSOSlNmsozb1BFmvch7aTBn4MY4jCQph6zKnPx4EP
         XdL0XHfu2qT6ZuXYLo1/3+BuYmw20A0xT72TacnBiFE2DceKSDJ6P4kBYTNVOjtAmrj+
         bMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760624571; x=1761229371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8qZQdR7x546GAqgtZJodcGIYh+OFm9vxtGpfYPYiQU=;
        b=D/dFzlvfQy96PiNOr3Gj9MFGq8cCveQHqLDE6bFaHp4DcYcgUJG2kZ6/aIajpej8cl
         gzIAqH6tHdpHus0Ro9EUROeNA4+xQROwrhlXwYmPglLnwGp3tBpG6ydLeUOtm8namwc0
         Yd0yvaRarRW+Pg6S2vZ+/JD4AWcvKO9fvNZvZYod6XR/p3Lp4JNG6lEf8s+1FPbPtl7/
         WJFoHZXLaOC4M+W1YLHQD9usTPGdksZtTUn+uJvgr/hiVGHe5XQhXieMmi0kPnHWGVtv
         c3TnQDnIp9UnEvMI9curHl0rpBtgB0+1ASA4f08r87TglYrguOXNOQc2Bv0GkQO91uTY
         9ZGA==
X-Gm-Message-State: AOJu0Yx4mSWrDmjHVTU9HUWIxxOl40j1+lGTNb+uYAVkRswGjY9l+65J
	ff4OkbSaA4EZrVsM2KSWXbPsxl/2tnm7E/N9RltgNllDCWOy+Iy26Th3zCubHALZbPZP/4C1zMS
	6regBntU=
X-Gm-Gg: ASbGnctoRXjGsZbZhGFsDFvEIiAzA8vJR9Ree5Dvtwk9+1r0uWl0ySSUTclGUWrgT7q
	kwQ+yyS3tbiEO1+nyRrHoiASMWfuueEkjXPnm2w6DPuzCdAkLuQuan9AU3AukndC3GjxdZoelSj
	9xewTwupPux629SQ/7jmGaPkzT3NkHKZjQsKTgZCVXUZBIsAtfi3bAoTQOvFT/eiyqEI8pzERyA
	Iw45bIJdFU3R6rN4tv6g2N1rR+yqg5armTt/GNS12Xje/gooE2r4IOLUKKNl0lbD1HwNVNC6/Wc
	USDXhGeuFRIiBbGUFQJFyDyShlYN2oHxEc8CyHEavoRQEUqWQ34z3Iutu9ovcHSWS4MGwUVquwu
	sZyYmo4xy6hn924CDx+RQA61D68La8ZCDCesL2cLJczeJQHAdjpUqdvs/2xS3O1eOrFUnBzdQrd
	7M0S3WkA==
X-Google-Smtp-Source: AGHT+IELf8ZzZSEoSnWpBrhbBIofef/M9Kco/1Eq4qe/+H9CX0s6NFEUEVarvqklkcocu1C7O5KczA==
X-Received: by 2002:a05:6402:4316:b0:637:ee0d:383d with SMTP id 4fb4d7f45d1cf-63c1f62cad5mr94685a12.3.1760624571519;
        Thu, 16 Oct 2025 07:22:51 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b1e89csm16174574a12.19.2025.10.16.07.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:22:51 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH net 2/3] espintcp: use datagram_poll_queue for socket readiness
Date: Thu, 16 Oct 2025 16:22:06 +0200
Message-ID: <20251016142207.411549-3-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016142207.411549-1-ralf@mandelbit.com>
References: <20251016142207.411549-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

espintcp uses a custom queue (ike_queue) to deliver packets to
userspace. The polling logic relies on datagram_poll, which checks
sk_receive_queue, which can lead to false readiness signals when that
queue contains non-userspace packets.

Switch espintcp_poll to use datagram_poll_queue with ike_queue, ensuring
poll only signals readiness when userspace data is actually available.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 net/xfrm/espintcp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index fc7a603b04f1..bf744ac9d5a7 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -555,14 +555,10 @@ static void espintcp_close(struct sock *sk, long timeout)
 static __poll_t espintcp_poll(struct file *file, struct socket *sock,
 			      poll_table *wait)
 {
-	__poll_t mask = datagram_poll(file, sock, wait);
 	struct sock *sk = sock->sk;
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 
-	if (!skb_queue_empty(&ctx->ike_queue))
-		mask |= EPOLLIN | EPOLLRDNORM;
-
-	return mask;
+	return datagram_poll_queue(file, sock, wait, &ctx->ike_queue);
 }
 
 static void build_protos(struct proto *espintcp_prot,
-- 
2.51.0


