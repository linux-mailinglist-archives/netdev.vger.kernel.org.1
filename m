Return-Path: <netdev+bounces-109711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 277B2929AFC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 05:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84627B209E4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0404019B;
	Mon,  8 Jul 2024 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSB3f5qM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705676FB6
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720407618; cv=none; b=qOfijuvJAxfYE10mjNvxQNX+bwMXTaWoTONsYNQGGTY0x+JCgJ+BaDYPhyYsUnnLU2VlfyAK5za3U02livhhNdbXmIhu9CnnC+kIqrWtrVayI0aj5NPnSjNbjmNk8tRks2eWRvz3r/Y3lhG3tUyEBuEBeLmBuIBg2VxoLKpOTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720407618; c=relaxed/simple;
	bh=nFlDv1NOYrhQO+X0gyL+QpQanefOoYwqZuoMIFru6C4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=GqzjjtYd1YYnx2q1e2Mgyb1KCh6imOAXzGVl6cW/7/u5j1VTMCtJyg4agDYZGTDw97d4Z7kxHwfz/ozc+1kCtSgMr6eQWboMb5fal2Ok5wZoHPebPy9ZgEOZG9BAFkQAkzuipDpw6V/wNRcBfC2/a+VTCaY1YuKOSl8y1qIaeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NSB3f5qM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-650866942aeso31108127b3.0
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 20:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720407616; x=1721012416; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OmER8C1/JdDrutRTIGPY8vZ0xdZGvzG3K1yK7h9DJQc=;
        b=NSB3f5qMsTHp1MM+k2nUqli8m5VsQ97rbq8x8EWGyKJMbB+yHn1bbIYgsKHJCnonIa
         UZEQPDKOfJPOxRMMgEAnwN9uwKQ7iphWcP/DVMijkiWlJQBVaIZG7diQzckkyrY80ooR
         /cdFXUMU3Ncr2YcfIf7sXippKW8HZ+ep49eKwY6SyEjpsdlGxlhQ4K5l0HjoYZBfesLU
         W5ehQHolcCsyi3IO8VIulYHdEeRBCOb+jS6mfyjlmgx37PQZrXI1HJM24RsyNdMTV4pA
         ee1eiOos+mLeYiG90jOAO99bGcKBJJodjz3bIZiUGdQz/wAkbkkbNZ3WsRc9xGwSJYvI
         aM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720407616; x=1721012416;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmER8C1/JdDrutRTIGPY8vZ0xdZGvzG3K1yK7h9DJQc=;
        b=T+eipPIF+TmALVDUpAXLuaIcI+yzmGJoObAMLQ2gMRaMTslJZPoqW48WE6QdWz2R9S
         lTwNokSiEhgt4MdEC0VukY3eIBr73R8es/gMzMhN1pfzNLa3yGNXq+zJBYJxtn9HG0/v
         G09X95LEFKQktxPp+X4EF2pAO8f4pkxqW/eYOvE8tEBQPHHudKmBPYaTYq60bihL/9cH
         hM8b3dBgIS5o2R0ZGw/5i3mltzPr3QhCnxrVKsvqVa+gfikBjji3UR6TbVWijxsaLV4f
         2drFQTosgyjP7FDaP03X8AUdD56rRo78x2H7/XoyHqjSxqwgDWeJ6/ZOQpNydTjMlweQ
         wixA==
X-Forwarded-Encrypted: i=1; AJvYcCWnLvUPlqgqXk3gFskupqTc/wYWcw2JOFwOzYkf4unc6haQSoAUlOnVh5s3cRII7s3rdTNIt/tHSjcAbo9ImnrmhYdvdXx/
X-Gm-Message-State: AOJu0Yx650J+gRClsuUSaQblnBegeERUnLoFtjkgZv404I4BFyVYn9kh
	bl08ywtmcOt7zqL0+du32sYTXo+laQMIhd0GxfduJLfFO4viSKv6sOAM4pBPxA==
X-Google-Smtp-Source: AGHT+IH56mHZzc2PGUc96mAlNFGCC0ebjc/IQF4Lp0LxmJdbp7YfFeEQmZeo5vmjezF6px9HyB5eiA==
X-Received: by 2002:a05:690c:f03:b0:64a:e2ab:be33 with SMTP id 00721157ae682-652d6d9c2cbmr135504707b3.22.1720407616215;
        Sun, 07 Jul 2024 20:00:16 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6548d849e27sm9447637b3.19.2024.07.07.20.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 20:00:15 -0700 (PDT)
Date: Sun, 7 Jul 2024 20:00:04 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sagi Grimberg <sagi@grimberg.me>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    Eric Dumazet <edumazet@google.com>, Hugh Dickins <hughd@google.com>, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: fix rc7's __skb_datagram_iter()
Message-ID: <58ad4867-6178-54bd-7e49-e35875d012f9@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

X would not start in my old 32-bit partition (and the "n"-handling looks
just as wrong on 64-bit, but for whatever reason did not show up there):
"n" must be accumulated over all pages before it's added to "offset" and
compared with "copy", immediately after the skb_frag_foreach_page() loop.

Fixes: d2d30a376d9c ("net: allow skb_datagram_iter to be called from any context")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 net/core/datagram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index e9ba4c7b449d..ea69d01156e6 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -420,6 +420,7 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			struct page *p;
 			u8 *vaddr;
 
+			n = 0;
 			if (copy > len)
 				copy = len;
 
@@ -427,7 +428,7 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 					      skb_frag_off(frag) + offset - start,
 					      copy, p, p_off, p_len, copied) {
 				vaddr = kmap_local_page(p);
-				n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+				n += INDIRECT_CALL_1(cb, simple_copy_to_iter,
 					vaddr + p_off, p_len, data, to);
 				kunmap_local(vaddr);
 			}
-- 
2.35.3

