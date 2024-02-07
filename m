Return-Path: <netdev+bounces-69849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F4B84CCB7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630CB1C243F5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F577F7CE;
	Wed,  7 Feb 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mr6+wra4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E77D3F2
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316014; cv=none; b=qGJc41FkfIUVwwTxL2qdVd1QkWQ27Sym+fNEUGFOS39RZEZyQwHSkbaYHlKsBgJ8kH9QImWv77tej1fU0eySc1kaGnqcVdQzGt77FA7fLPZBmgZX32pohuESQ5qyS7JOoGyvtpV86994GAlQAX37HtiELebU3/m47EVk9kGTM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316014; c=relaxed/simple;
	bh=yBxPxfLaN1Bw6yby/xnceqJOhIQhsAR6SxTXghuwXAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mKSMj2kZtBkacCAR6HIh3XCky4pW5niiqPr/XulgLK3q5+1kNg+SUlRbAVOFljEOgvrAMoFur58kglad/9yHDa6augpniktLMYiKbKOCOHpl0tbDXEY7GGGnseqk6aBDPKxxlqG43rJRl9GIB6bKbwKgkzOQeACJjlXUDZv9wWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mr6+wra4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60481a6b1b5so13055577b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316012; x=1707920812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9460BMzqDTk2cl5fPVFgGoJjhirarLcj4L4oplI9P7A=;
        b=Mr6+wra4RKM7SvYBlANdgPLuJQqk/2cXNt1i0mxnT8+/AJqjvAZfK1j+gmLB+A4N0W
         cxscN5XfGNyFWd8AXDqreUZqNYfLG8Z/nSjnJZgxgPMvxRA/akaquWZkf8vroMf06Mf3
         ge3rrBmfpXH+7u+iqknrJzFA8gmXbO81FFleYKx3/NqKkVxFwBuRF/ugCqb2ZFML4lBX
         a8n+r2SW2qtmrQh42MiKuCjjGmqo0zgkbCVeejPrrbzWeLGCwgkDqNaGinO1URRuwydQ
         g0d5WDeY3dDIQZFzsFVgFuTHzGwGlw3U8lzzlMV3vnVL4nprjIMnHkgdupmv342mL8Ze
         oMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316012; x=1707920812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9460BMzqDTk2cl5fPVFgGoJjhirarLcj4L4oplI9P7A=;
        b=nnstWeXe8HoFeWcUMLotY71N2riN7liNNX3TNlcojhfjNdA7wXDdcsYNvOhKtZMYO3
         x7b4SPVKKQEvKquT1pi6WDQiP4sq1jO/EG34k37ZfzcvZkBotP3K2v427Y9OfKrCvjmS
         1m6cwvYDxOdv8xUzhyUnPAZFoPcu8ZpPfu+VzZ/O5mc6SXXkQhwSj8htO+YMVqEO8kWO
         X8AMFRg3b59tc/xw2xNiL2Wlqn71ahQyI4PnQeqtuTX05wrLg8lmekMePtQ3G6VnGz7F
         W6UCCInxjmzXjOas52x+uHttl0x2yZ4u1wAYwuWlb4DZK2s44gjDfPOLbAJPiGD0KeSc
         J70w==
X-Gm-Message-State: AOJu0YzibxVDwNuky4M+w02i4nD5/PBG6krNpba6mahrigaiIsyvLqmb
	YqAHt/vozM+cgH+4O/nW0unYQaFir0+mKYgQXQU2DqhISUy4hqIJT+v3KCtCs5pA6dZy06i4xd4
	bgkfM9KeJWA==
X-Google-Smtp-Source: AGHT+IGBxBduqDBS+TH0sjUgD+/qQFas0qwhhkHzAbQ0xS243BHjstQ8ZKHwNJFv+3bXiw7zleAwqHzZmKi17w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:9b92:0:b0:604:f04:d228 with SMTP id
 s140-20020a819b92000000b006040f04d228mr1077191ywg.5.1707316012337; Wed, 07
 Feb 2024 06:26:52 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:27 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-12-edumazet@google.com>
Subject: [PATCH net-next 11/13] net: remove dev_base_lock from do_setlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We hold RTNL here, and dev->link_mode readers already
are using READ_ONCE().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 46710e5f9bd19298403cdb8c179f33f155a4c9ad..66f1fd4e61e3042da3403e512d051267dc5fd03c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2979,11 +2979,9 @@ static int do_setlink(const struct sk_buff *skb,
 	if (tb[IFLA_LINKMODE]) {
 		unsigned char value = nla_get_u8(tb[IFLA_LINKMODE]);
 
-		write_lock(&dev_base_lock);
 		if (dev->link_mode ^ value)
 			status |= DO_SETLINK_NOTIFY;
 		WRITE_ONCE(dev->link_mode, value);
-		write_unlock(&dev_base_lock);
 	}
 
 	if (tb[IFLA_VFINFO_LIST]) {
-- 
2.43.0.594.gd9cf4e227d-goog


