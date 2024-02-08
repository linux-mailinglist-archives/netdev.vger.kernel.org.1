Return-Path: <netdev+bounces-70261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A8A84E2E3
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744EE1C26D39
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C278B5A;
	Thu,  8 Feb 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XMPv660"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF607CF1B
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401553; cv=none; b=U65BeELh83WuS+vEysu+NsjF4ydjPDt8Iy9V0UK+Ln2YVl/IL4Nu4Vb0P+IziWT8k6l8kFhUaqPbN1SzyOmDJdn1cXzxXJAY2SSgoI6wWu5tq1whnWpTp962V9WsjV4i50L+t2RwwojMxLUhS7B0+KqT3t/IWyK3sRojswVXQQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401553; c=relaxed/simple;
	bh=yBxPxfLaN1Bw6yby/xnceqJOhIQhsAR6SxTXghuwXAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tbivFDWnxW0fKYntHkceB5nP99ec5/XEJ9ll7dhO2o3fxEMPISjFsTufOxb/N78ksPUpZlWzrDa9DDc5HF3P/HBKjY38cH5Fl26LU059GioJnT8fqgd1IaOPwQPSQupcoMv/ocsQAAsniyDbuLRR6JzkxOEfp+QOAi3BsOTouQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2XMPv660; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso3217132276.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401550; x=1708006350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9460BMzqDTk2cl5fPVFgGoJjhirarLcj4L4oplI9P7A=;
        b=2XMPv660o940mK4WVwdPjm4gTKqhIbx+xj/XNuQ93nuVBnhILNF85psKZF/LUUnbLC
         IlNT+E5M3JN0y/1FrtNzHl51eNpUz7K03FznULD45o3KIwZBZWwlIoZIEBLNKnd1A9wh
         1sgasXLAlMj85BOYsdyaXyiCRuFM0FuH90WWb3V9PfY0DBeF50JBzGZGsRxW0FPLhklN
         o9vro5xcspOE14tm0h68PlCSOo5kJ7hEl55PSLrtmWTD7YiP1QlqQP3x41vN506fCMwu
         JgSMBVt9ecaDbl1PQz0rjSTWqA/PS+NEdT4B3DrMFR6dwRQEhjQv9mOZNxoa2vRUYfAe
         1zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401550; x=1708006350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9460BMzqDTk2cl5fPVFgGoJjhirarLcj4L4oplI9P7A=;
        b=G4Lyq21OeQJFx5eYOYLDTFUior3crE1EPpcj07zh1E9vRNqFz5/mm3ESin5jOTwLJD
         ENgREf8IYtEOOjypB+Svzg3NfAAwpgp9l362v4VCJKqmmX9FKFUOwlB3YfT3W6iAIOa/
         WDD3Oy0t3IVo4UpT46+xPqh3Bhz4Y9RLhkM0s0Z1y5IL9nMXpah+qsefjBedU1S3VRVe
         qtt1UmINqoCSEdMs/Di5PfttkZffmazbnLM2z5M0fny16w4NggoU+7pM8oII3iiA1fEz
         1s8w2iUol0cclEhrARncwwhuRjJCWlD4UFrrs/9xrfBFWQAmNFK70UZPCF9HPsiTr75G
         jjag==
X-Gm-Message-State: AOJu0Yy0T54/rwcGDzA3Q6T/VK9gnRuKtFmU12rw0gcUtZdk2I673dOl
	aolvwL8T9uuNFxHaa/6NFUmwNyiGmOboFqIoSXrduptMPQ8bufFI2HGvlccU7K+R9Lyp3newIzr
	wrlmYfRu5uA==
X-Google-Smtp-Source: AGHT+IHKvmWQ1SY5Oaqtms7UmISj1Lf1vUVIufc1YH6jqXW7xVH6rERLfW4aoz0RQoJCaOXoA2StYdtXhDzkXw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:230e:b0:dc6:207e:e8b1 with SMTP
 id do14-20020a056902230e00b00dc6207ee8b1mr2081926ybb.2.1707401550284; Thu, 08
 Feb 2024 06:12:30 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:52 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/13] net: remove dev_base_lock from do_setlink()
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


