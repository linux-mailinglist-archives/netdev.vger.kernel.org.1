Return-Path: <netdev+bounces-70561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91784F899
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF191F21F8C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836F74E22;
	Fri,  9 Feb 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fL2n18GG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349944C3A9
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492670; cv=none; b=Q0XTl511wyniH452AoxW79t3Rgc15JTt7HiDMQa45qdLbpGXzN6PHBCPieqUA8Zl63FJDmtTPW3NBHeS949Gx7nR2VvCm6nD2Kyn+a4LAuLJnT/enQXOmI6ls/Ly3dtxa5r/vbhC+6krdF4czIogNDVf4wJa/NnFXhPlr+/vNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492670; c=relaxed/simple;
	bh=qLYPxEYaynU6C8DYNOJGRVtmOM3Avb4OBn+iBes0iMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jfLOAT0jHzS2FBT/syUodUzep2i6GaVAVDNHOYl9U6GSMWKNb7QghRLzmow6yiyXa8Op8USa7v721/n74+qKDnuwFfqiUfYS4KLLE6QIHDV6Wg1nYUma8b8dgifac9GuXBgbf4Ko6dDChBJuMIHIkKUsbV7FQrmlG2+X9o8Rc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fL2n18GG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047f0741e2so18560147b3.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 07:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707492668; x=1708097468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LH74PB6c2Sad2K4VvESrUHEGVRNCe41yb/ZaPNeg05o=;
        b=fL2n18GGR9GH7cd6XqPnWWHR3h8DCPGoPVAHBpZiEWZTu41EW8Lmht1rHcQau/ZdM2
         +PFKHWIfS3way1o0IxI1jWCcqiKlvVBl1BX0WRUP+PI9nzTAh08Ah0uV3BTeLyQMQvz3
         /tzzwO3yOFuomDqq5uaO3zeSD+blstBafCiwUvQ0hmMaCTt4PqcVQtpCODeLpnVsVkuQ
         W2SkmbJUnqqQPA1O6b22gf9zpRUasqlhRhBvCkAuMpFQenbZWDEPQj8G1DL8Nqg+zi5o
         ksnWKTrZPkHHbnd0nPftBrZBDjl3pbbX8fqe51J4sLjuy+JdQ03O4GYqjOgx5z2MvxBf
         wO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492668; x=1708097468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LH74PB6c2Sad2K4VvESrUHEGVRNCe41yb/ZaPNeg05o=;
        b=DYNAv8kmHksycjmzzeyp/HGBC8anQJ3th4gjyAGNk2txPQinCMs9ucPCFgFSzjHYJR
         YQYIAloeKQWJ+ej++Em+VIhUYsZeD9S6/rBYQk14Txyz18jWEo0cRJLd82Eq1GmMqAeW
         AGgDSv/tIBqIt4iJDofGqvuQqYBLccIZQtGkxH2UWjj2x1rJ/thUq1RB7vzEWx7LfEN6
         siZCf59hHHzrCOKpOrr99m/tAPZldiGS3cR79fNgEjBZ9zYTkZCdGJFsMVOp2mg2hBZh
         625RJnqev/C3b2jXCZGdwpCjt54L9Igye+3MhzvqUIuqMLdRiF7kjMQhnG6ki3/eIIt2
         lnuA==
X-Forwarded-Encrypted: i=1; AJvYcCW/IRT2iQmnP/79VemJVXOE8AQ7DmNVe+QmOEMQ3sbsyVvFMahinemybHdzM3EkiDJzu6dshv5o134dxtqFS5RkTkacU09T
X-Gm-Message-State: AOJu0Yz+x7AANNdZo+LkG5nBx/6/InVgI3jYIHGpNtxDCy7b68A68dkb
	weAyTZxSoOW9AW+WAc3gBoq02AtDwzVhFDPNxUr+eWiAbVYilUn/WhuXoVT34miaIIlZA5rAl0n
	4GiJejiVk6Q==
X-Google-Smtp-Source: AGHT+IEymYrO0ZoglR1qawARsDwm24TRh3TI7/0stlv66z7O6B1styRB6JDiaQKap9a5k9sZNdN4vMAPeJxaxw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:a1c9:0:b0:604:42f2:392c with SMTP id
 y192-20020a81a1c9000000b0060442f2392cmr277169ywg.10.1707492668305; Fri, 09
 Feb 2024 07:31:08 -0800 (PST)
Date: Fri,  9 Feb 2024 15:30:57 +0000
In-Reply-To: <20240209153101.3824155-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209153101.3824155-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209153101.3824155-3-edumazet@google.com>
Subject: [PATCH net-next 2/6] net: use synchronize_net() in dev_change_name()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_change_name() holds RTNL, we better use synchronize_net()
instead of plain synchronize_rcu().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e52e2888cccd37e0df794155004e77261c812ef9..cb0eaefa0aff79ddf009f0867b440200fa985e54 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1239,7 +1239,7 @@ int dev_change_name(struct net_device *dev, const char *newname)
 	netdev_name_node_del(dev->name_node);
 	write_unlock(&dev_base_lock);
 
-	synchronize_rcu();
+	synchronize_net();
 
 	write_lock(&dev_base_lock);
 	netdev_name_node_add(net, dev->name_node);
-- 
2.43.0.687.g38aa6559b0-goog


