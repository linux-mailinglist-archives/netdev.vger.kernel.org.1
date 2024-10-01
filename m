Return-Path: <netdev+bounces-131020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1F798C670
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34CE1F2516B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB09B1CCB53;
	Tue,  1 Oct 2024 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axI+n+Rc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278CD1BC072
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813124; cv=none; b=HlBx3MANkZ01wuZAf9gxOXK/mOvZAGW+isK5XWtTt5QW8NDE6THIQ7iLeo5xf4u/OBV8cdxj4BU5BGd6ZXCz9vHtLaQenW71jpOx22hg3XlTNNCGtWLIxDcz86laC4baRv/Q0oACAHluwBQZLJ47RR7b5o4ivHwAmJaoSaGIQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813124; c=relaxed/simple;
	bh=FGh5ycurZBM371+dRQANocPtOe3aFx0IKhDeX6YWPV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNmrgyqpczVC9jCjWOr+pofthklOYHHCoTFHyirtWDwoSonjOBMfsKSqnkN7/j9pqMF2e9CRo2sXxcIImgZgNCxiz7YAQ/+lRV1gLa7x2NzCNTs9gtvxyxzpgX+ABMUNOvNWvVH7HGfhO6jfbkkUL0HHRAX0Wfls2RMT+RKFEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axI+n+Rc; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4a3ba6cb8f9so147901137.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727813122; x=1728417922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Do2kkoAwaHePhNBTxd1KcDlGaDgNktVsUL7gRkAXEmY=;
        b=axI+n+RcTS7zVuVUXYPu+6WnlfiWpftN6xbuO18DdmuG/bAlJIUKVujukl82xvMziu
         QnLiIGgkA2QXhn7KmQBXRpN0kzpR0WZ2zAzmznwhzfjBhQ2pdY6OBZsdh5tpEpm7a65k
         nAl1FWWi1uTy65cE7t6Avc45d32OQw5rPJfBMSDP4kSP78fAM0L8mo85obhdRcWmH0y0
         25KVbvfSdzL9AOgedApxxY1hKqQ9LJ8m+egD7a5yK4yex9eH0kxdGu7L3zBZIPbaApx8
         P1VDKVV1tIhF6dISZFc5TFCVs8kjIq7JQdfaBPhbYciCA1yRoS/rO94Uc70mxDe8K6wU
         d9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813122; x=1728417922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Do2kkoAwaHePhNBTxd1KcDlGaDgNktVsUL7gRkAXEmY=;
        b=R7glr3LDFPL5Su+i4wY9rsDmy/ozH1SeIlriT5UF+7KQeJhpJMGunRZx+V1Kn70TOk
         39OvGO1wbKwSLeGyWrmTuSqFcaTBIhIoVzXHH5xgE3/swFiR23SQU0rQ/CJ4DhLGP9M6
         ukTAXkYTFYExV311sNYEwMJ4cMjZU0PGHNUU/8HG+YtE3y/COPdSq4dErPu7PNDobNW1
         iVj+nf3C9D/B4Ns7fiRG4iRvzynuCipl88mjvrsu1jQaHqAq10As7jZFLsFYKWHVF6gu
         nAL9Y8kCRHkWJN7tsjfAPYKQDIlFtTQmPOL2yTs3iFYMQ7iCMphim0dpDlP7F1rD/JvC
         BLCQ==
X-Gm-Message-State: AOJu0YwleowM/6UQxYb7XgDo0tfmmtlAnLWOK1qar2sYl1y+7t301hlZ
	o/RmazQfjSezum+M/ePH3VoHX5HBrLwpP1Bh/sjC8p7cRfY+XpWI
X-Google-Smtp-Source: AGHT+IHWtWk6V3Yv+3EbnP0/xza42WpyrpeLd6kPXx1qVJyToq/yKAQHzYmSD+0ooRtAmQg1Xm95oQ==
X-Received: by 2002:a05:6102:418f:b0:49b:ef23:7e51 with SMTP id ada2fe7eead31-4a3e69ad13cmr447139137.6.1727813121855;
        Tue, 01 Oct 2024 13:05:21 -0700 (PDT)
Received: from ahoy.c.googlers.com.com (182.71.196.35.bc.googleusercontent.com. [35.196.71.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84eb504217bsm1237447241.14.2024.10.01.13.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:05:20 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>
Subject: [PATCH net 0/3] tcp: 3 fixes for retrans_stamp and undo logic
Date: Tue,  1 Oct 2024 20:05:14 +0000
Message-ID: <20241001200517.2756803-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

Geumhwan Yu <geumhwan.yu@samsung.com> recently reported and diagnosed a
regression in TCP loss recovery undo logic in the case where a TCP
connection enters fast recovery, is unable to retransmit anything due to
TSQ, and then receives an ACK allowing forward progress. The sender should
be able to undo the spurious loss recovery in this case, but was not doing
so. The first patch fixes this regression.

Running our suite of packetdrill tests with the first fix, the tests
highlighted two other small bugs in the way retrans_stamp is updated in
some rare corner cases. The second two patches fix those other two small
bugs.

Thanks to Geumhwan Yu for the bug report!

Neal Cardwell (3):
  tcp: fix to allow timestamp undo if no retransmits were sent
  tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe
  tcp: fix TFO SYN_RECV to not zero retrans_stamp with retransmits out

 net/ipv4/tcp_input.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


