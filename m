Return-Path: <netdev+bounces-76252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7186D02C
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37E628169A
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1654AECD;
	Thu, 29 Feb 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJTXaBEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667516063B;
	Thu, 29 Feb 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226610; cv=none; b=UyLYQhk6c/qKxYKbGPghpnUfqwR4MktydJ4PQrkRHwymN0Py1W2jD21EUPtTmdUCl+FiB/PCV+62x+WpyDKIeic1BIUWk6ARWO7EtzIw2cuVUEuH7NOtyOZsCJ9tXI0XLn/+l8/yaeYosPvoiSoVVNz45cqqQesgq/2js3vGYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226610; c=relaxed/simple;
	bh=lyakl89C4211ReYTZ5XokugSj8rK3f4KAtClldOWu2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SG7YaDJSxBCNDBoQrXBkcxMu/7U1AMc7qNLsOHffFdefhR3+69ur8/jlry+JesX0Hqeo6CLupaIQri6Z6KdxqFKUbHIjQV/IWaBiiX83WeIxOc1HJcoIWXQLEj4ScLzjFqopmJaaLAucGApZWxfWaHvWAnGeLnN+xwqEUhY7TDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJTXaBEs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e56787e691so1479782b3a.0;
        Thu, 29 Feb 2024 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226606; x=1709831406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeXgPmvZXuniNDAjs4HWs8wx0nhjzT0QjkektUHwCqk=;
        b=aJTXaBEs6mbsiZ16zSUnU3tMXQ7mq/gZH9thonK6a/sYDluARU58RAtsyhOWQy/ZjG
         nPFMQbka+ZB2/VKTGi2INXLptoQdXYyaeJXx6TTGsv63+4ddXg5CXlt9H6qSJLJ7VeiI
         a4FZSAYz6IVOKN6yiz2cy4yoJwIeRab+wFhLV5uf1im6941gQhz5oXdZLij/6K403/Xl
         /CnTtRaamO65IaVq7vl3o6vHz+ButtqZF6a4uXPD1ZlP27Z927xC0E/qMy8N4bJAvKPJ
         g7h9aTDBZRDXJ8vZP9LUqVjkmw8YRXayq3pR27+bEnMGK9bwNJNTmeAl8uXRIP+t3fRI
         ntoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226606; x=1709831406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeXgPmvZXuniNDAjs4HWs8wx0nhjzT0QjkektUHwCqk=;
        b=s2iHv0ojCPveR1v+OTK87tRNq0xQt8Sv3t20UJYLcnnFrogfolvsMMIjmK9dMayZ3v
         swMfb/Dt4mxWWcs3OJzfJYUrC9w9B7yd43LuD0HGE3hathTkO9c5rUhghpl2X9IhIJkj
         OnC0alhG0nJA7Oct++esn+ULfPYr874ebxgKeTE/6goPTlI09O8RpqUSRopKkooYVXRd
         rsUvpoMWHjK/bjZciIE5ND2YCFtoEfq2JWs81aOX4Yh6PRwwOFFh/drokeAm0j7bbFSK
         G+36Vrm2Fzgg7XuOGVmnqkgqw/i0UXp1yLj5rHYgeXDKUqzcrarpxjJUYScwpI1TyUwb
         QwGw==
X-Forwarded-Encrypted: i=1; AJvYcCXzOD8N7VjJup5qKvwfm/ToMBGVRHF3BLkgsETdsKbDpgyCYvsj9oCXqMuYvEWDsHhtwP/+4ShDlyR21COvME+k/rnhCyVY8nkDffg7SH5bv3GI
X-Gm-Message-State: AOJu0YxDUOfFUxPH08g8mQ6NtvVTyeZEysdpVDE6nNipGQynKfVCkSFx
	opixjKSWdMFkM9MIET5HVE9UpiYMlAWRTCVyiiXz6NGHfPeoyG6m
X-Google-Smtp-Source: AGHT+IHN5/R3DRf6VckUiAohPv6m9KoSzQFQqev3/paWyl0X+7k3iovLJ1iXHZ6zTqExjueR0pRmGA==
X-Received: by 2002:a05:6a20:3b9c:b0:1a0:8897:85f1 with SMTP id b28-20020a056a203b9c00b001a0889785f1mr2688235pzh.6.1709226605875;
        Thu, 29 Feb 2024 09:10:05 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id b76-20020a63344f000000b005dc4829d0e1sm1558808pga.85.2024.02.29.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:10:05 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] add two missing addresses when using trace
Date: Fri,  1 Mar 2024 01:09:54 +0800
Message-Id: <20240229170956.87290-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I reviewed other people's patch [1], I noticed that similar thing
also happens in tcp_event_skb class and tcp_event_sk_skb class. They
don't print those two addrs of skb/sk which already exist.

They are probably forgotten by the original authors, so this time I
finish the work. Also, adding more trace about the socket/skb addr can
help us sometime even though the chance is minor.

I don't consider it is a bug, thus I chose to target net-next tree.

[1]
Link: https://lore.kernel.org/netdev/CAL+tcoAhvFhXdr1WQU8mv_6ZX5nOoNpbOLAB6=C+DB-qXQ11Ew@mail.gmail.com/

Jason Xing (2):
  tcp: add tracing of skb/skaddr in tcp_event_sk_skb class
  tcp: add tracing of skbaddr in tcp_event_skb class

 include/trace/events/tcp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.3


