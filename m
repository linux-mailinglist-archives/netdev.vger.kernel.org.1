Return-Path: <netdev+bounces-71178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F1852902
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC0C284028
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058EA1754E;
	Tue, 13 Feb 2024 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1MBqfOF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A614F86
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805976; cv=none; b=k24tkFNTBrJ+2cipTWqLyFvIkwB/WRJ0+1liumm0TS+cBA7exf8v2kmgyHXR716sstLWHebXwDgokYk6jA1bjSeX832eKg9MHKgX20L/iC6Pbr99UqkWSQXertSrQVU89tMeziA0GeDwh9Xkk1+ugrc8xb8Qq679J3PZQHDq/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805976; c=relaxed/simple;
	bh=YTEyg/1+GiY/W0+VDC/b3Qq8cChEbXx1vVFGD44gPcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sQ/PvQnbv/wD3r0Y0ANNcToTPpPsC0BvfcJn/uuV3CtvdaUkCmTL57ucq3O8EgLCcaS7fCLx2PY4NjEXDq/U8pi9Gniw+ZwtukS9botvUH9ZCDjOEtgv1PD/N/b7KGrSu8Y8fPCdarmqe/eyrZ6t1+ypx4kzR8Phhj7reqZUQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1MBqfOF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047a047f58so73348107b3.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805974; x=1708410774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HK2l2I8QxbGjQxSZecBtZ6duDYVxBVdYd1H4ObV5H/U=;
        b=Z1MBqfOFfuMy0BA+ttMpIt1tjlDzYpzqu7WxdYfDPFk0vbwaJewGE1qptcCFVQJ4rR
         TZSIYFDCqO0YVxdF6x0pSFWvx6wdw8+Jg8GVWfI1Q4MsZppSUv/3eYQFR+hiIQ+qwY5r
         3zoj6+70wQqok7ByDprJOIeIRRYQEm6plUqLtuM1QlW+6F8Oj0JK34hOX+T5+KprxGzP
         mV1uzxEHmLOlTuc1euSATx83k//acmhB6fxLOy42U/GeRSe6T8mWcoq/twbTfjEveI7U
         0P9GZgG5Sw0OWZKU3fJku1AYZ7zQgbOiJUKUjI2uvnSz66qAMI3k2yC7TKRsWISJPSZx
         04xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805974; x=1708410774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HK2l2I8QxbGjQxSZecBtZ6duDYVxBVdYd1H4ObV5H/U=;
        b=psAp6vZ8e9tqIgY0ThBx0Ua3ahHFixbXa0uya+Z6x5mrlcQAsO1sP5Im2iC1tMHe7Q
         9WBXADqrjkRlShsbQhirOzYELCvqV7ef3dMOXZzLFjnCsyPLiJi7YPzsesI+EnBYcADr
         WyRbwZVfbL1HsSn+qDCQih/w9n/qDItlCBRM5vSNUq6T9TXYEtU16QB6VeKNd9dtuGbS
         2SySUi/YzFkJoZgwkQCQXt3Gnbi8gjmOs4my+lANjzDjv8AZdZfGwy5BQa6VF9C3a1oW
         yljHy3+apAKTrzJJqvuYhXLSQK5UcEzbdrAFzBp3LNMTLNt5k3wsTkEEyML0pGb2BI44
         LJFg==
X-Gm-Message-State: AOJu0Yx57PRpSJdxmCOk2P2Vcfy2YhDj7jCi0qKyWP21JOuG3pr9YdK+
	CjqDS4EP8LlaIQAvmB4sH1D59suWpd8duZn9Zrk5MU0JrAVGJnhflK5fALleNKcbHy2f84DYRqb
	C6AF/iuDi8A==
X-Google-Smtp-Source: AGHT+IF7XGtNPh+4Gi3lPvi0iGAenwUU8cIZGey8/OhJTBOLSurHd139U2SdTE5j7VFIBzvh/rSehW8EjtdFTw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:c07:b0:604:5ca:5ab2 with SMTP id
 cl7-20020a05690c0c0700b0060405ca5ab2mr2351812ywb.9.1707805974497; Mon, 12 Feb
 2024 22:32:54 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:35 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-4-edumazet@google.com>
Subject: [PATCH v4 net-next 03/13] dev: annotate accesses to dev->link
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following patch will read dev->link locklessly,
annotate the write from do_setlink().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31f433950c8dc953bcb65cc0469f7df962314b87..8d95e0863534f80cecceb2dd4a7b2a16f7f4bca3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2974,7 +2974,7 @@ static int do_setlink(const struct sk_buff *skb,
 		write_lock(&dev_base_lock);
 		if (dev->link_mode ^ value)
 			status |= DO_SETLINK_NOTIFY;
-		dev->link_mode = value;
+		WRITE_ONCE(dev->link_mode, value);
 		write_unlock(&dev_base_lock);
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


