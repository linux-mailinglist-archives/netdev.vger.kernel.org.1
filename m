Return-Path: <netdev+bounces-69841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364D84CCAB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E7A1F24C1E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21D7E0F3;
	Wed,  7 Feb 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYqwdOzN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAD7C099
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316001; cv=none; b=KDxonZ67EnorKj2RgiucyiK8ZHs5D2pljSh7KEZgwJuWxPr+J65TsZO9vG8XhMs2uMYYoBpCfc1zQqMTCG076I7F1fVsAPX3J7mo2Nshq19WDVN+GwnyzExVTmdIHUYyqZKJt78qYMGGMJQiD5DImdXXVexXJ78NcMpMiDevoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316001; c=relaxed/simple;
	bh=rjPZS37myAMVLcm5QTyyj0gwsDFQ/NzT5JabszGNCeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZdIeiwF27Hc/YBhviwrgjyseXQGb+ht2ilzGmBOtcnJuUedIFj2jK3ruc5EF+r/8pTwUklZeNHvm6Ah/f970YSwkUPqHwzkgodliX+kOCF+m5lUBbc529Mtmhj57uZFKAxu053bgM6z5j5kLDtvvNfIXXiGC90LtxxEQgWQ/Nw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYqwdOzN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so1057914276.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707315999; x=1707920799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvc1bc4onOJD+myVGtsrNWF6tYGSfb8pdE7XzbX6nKY=;
        b=YYqwdOzNaGmhJaYXxAnDO+bmxBbM9FGovUtFIDxxhQ/qQXEJkVbW7bf7SBwAhQDW68
         1kDeWDyAKHflIgFmj+X25qRfceneD48qxvCMCZxFxtBsloS6Y3KsSSePwlIDY8kWAMGT
         Ty9dbhAkVAAroc9bmpcRPZnOw1xhfSC6wQQIm1EQWOOYeZRMOmQ/aTLf0ezzAS/LLRwO
         ePF9n3zxmN5Cvlc7dFCX/J/yI/HWUVZUiqOLkgN9geafYPbQ955ydhotdxRlcIK2cqkX
         mHYaeUXxW1LtT7usgG98IZ1lFezjsRxKPfjchwohupAKeLLy6hqD6vgwRz51SKk5ZNCU
         WU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315999; x=1707920799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvc1bc4onOJD+myVGtsrNWF6tYGSfb8pdE7XzbX6nKY=;
        b=QFbUJFR/rP1oUEzSJEx79FIyuJyP8xd1OGBO2JkMRU/oFa/k/ZvhV+jae0NO/Knm6p
         55nyCl3cwE610tW7u2Cra1LoKlOGnIbtHk+wEi5mCwOtCqF6j+9N3pXHnuepj6v+6XCV
         vbGnO5U2J6eUUthdfra8X/wOUm/vSSiqyrzWXi7b6mXdrkhZPuRvuIZDl/HGCVm1Lnqh
         H3eKaQ4PrIdpMnkiMAzHYzXA2tTMnYxOToxhbzSAAecAVx2XGKczJpfPAZvBRqDskyhA
         hsrfCw2GVx/uTR8uyMuCqVaHLJ6La3AJ1V4UpqG+QiKkFPiLpv9sVEqX5G3E8quBbNNU
         jWbA==
X-Gm-Message-State: AOJu0YxMNY9RSxz11yQF6pkiPrOFDX3O/RMhh8kRz0/jRbdQn+BKEdjM
	nrjnnLX6b22WewY5lDy77l+9VpruW57j5qOELj+1B3FOZCjj6++oj23TXX7XClndlWlkJU+btBx
	ibJcePPaPyg==
X-Google-Smtp-Source: AGHT+IF5+ucplCkm+bL2dyU10FA2s/gT8MsaKjZZsiK+GKVkT03j4oIT6skCNzP/BxJGxOFfL/5wiaLgtsCnsA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:a85:b0:dc6:ee88:ced2 with SMTP
 id cd5-20020a0569020a8500b00dc6ee88ced2mr1189456ybb.12.1707315999114; Wed, 07
 Feb 2024 06:26:39 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:19 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-4-edumazet@google.com>
Subject: [PATCH net-next 03/13] dev: annotate accesses to dev->link
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
2.43.0.594.gd9cf4e227d-goog


