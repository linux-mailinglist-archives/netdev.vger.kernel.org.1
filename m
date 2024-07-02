Return-Path: <netdev+bounces-108362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25C923852
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919031C223F2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E119414F9E4;
	Tue,  2 Jul 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwKvPXJ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AB149E1A
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909909; cv=none; b=mSUkfbUvSyF75WX/xsdCTzZTn0EPGWPEp1bu+slJx4egQhiIKq49qhjI4T709TyPdoHV0FjBzZB9ZeNVL6ka6YTWmy9ggwwB2V6z7A8DovY5bpo0d+4qVJg2S41gXsrMmTN5Mx/wJj74XETvSsHeQV4azfsq2DhM9kprOAqipl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909909; c=relaxed/simple;
	bh=VmaOxrMDoxpJeQU1U5hafB/Lf4mftJY8KRF5RJ2sdGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TC2tTIqcDPx0hAK0fXM8yKipeah806vhw1+jKjPyzHI8AddZk3pQj0vtqcw6SfGu4CbZRrOnRsBxisVViTn21T7exzuKV8UWi19wRfcHDJBV3Tif6/eMavCokZxg8x6qfx/mKDNx7d+AwdtInfAH2q5WIGN5vGt5YX4X4axoy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwKvPXJ/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0342b6f7fbso6772251276.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719909907; x=1720514707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYup63ShssTSYOcnVn9rka8+8qfRXpQa81RERIvxbCs=;
        b=PwKvPXJ/osnkjunGcQY1xOmpOrY3U2x3R1oX7BoVUNPsalVqIT8wvCCNJuR0YDdO8i
         EWHWKdK4PfwN9Tw0DP/+9KQ4y2XC5dOED83aGaSMAhfSZ5b9YeLk2KWUuHOf/kFnDefQ
         o6n8lDdohYIbRHIs6B5aAHQuAxPsW9FzdLfZdJnzbXSy4oGs//wswtBCVpBsS3lq/oY4
         6wrTLZLrrm5V4yBThrh9Dl14SEGbiiNiTeud2rPgedskXBQ+YNFCyvJGTnzA/Ghlt2h9
         DBBLHkRaLZV8FLeRf7tMoi/5c8j76n7I/qW0GxLhpHpuPnqgLQULhP2vv5A2aO7PfOlx
         Cfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719909907; x=1720514707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYup63ShssTSYOcnVn9rka8+8qfRXpQa81RERIvxbCs=;
        b=VFaew6Xq1Sj+ReqIer0ZX7GNGRrQZBUrhR9Yb3CPxAvkiVx+V7V20BHbamfM1h0HKp
         0ULh88Dw3ttynUE7inupsl97e3MkvLoB1BY45yoBym/973nsRdNHlrFFLdLcxs4yxdsy
         65mKUck1ZXwriN01bqN9nHRoy1HPIU8lteMvpihSFNQpwJOg0itdggI8McTGUccumEre
         29SxCjQFEykKkHuk6M3s/lf2H460W0Sl2an4fN73Ve1HClHU4TuWUTZOaJh8Fc9/IP+Z
         lXL0kyPZ6T+QClmA5HaYOoRJ8EP3hYjnAUZWcpYeFMNQw59JZUTDfMOnKbOnKnI6oPb3
         nEAg==
X-Gm-Message-State: AOJu0Yz4wmPR8o0ofzH5om4+T/vbLDCrd/3nCMkHPhtgUE+EXEddzu3J
	JrRdtpXVrtlKgTZRc4SFut0N+XBgagVSOikyFlqNoWMiCx0nseNMWutsHhs1IpTjCDVOop6Hlye
	p2r1HxNQRFFSNbpfI0fDshLFTewIePousFUfV+JcUGVC1l1kblrHX/ffjCb+ZVdS4Pj2YtH3xdh
	RRZ4pMHrsPysHGHvPpDNh9cq8HA3rPjRfx
X-Google-Smtp-Source: AGHT+IFBGMHh20Oep5G/wRDjEC+B+ZSxCCW0tq6jQojKEDUweM7aCgrxwqgcz7oJGpF9ts/zhxyEuF3nvmw=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:2b89:b0:e03:5220:a9df with SMTP id
 3f1490d57ef6-e036e6ea728mr710972276.0.1719909907131; Tue, 02 Jul 2024
 01:45:07 -0700 (PDT)
Date: Tue,  2 Jul 2024 16:44:49 +0800
In-Reply-To: <20240702084452.2259237-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702084452.2259237-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702084452.2259237-3-yumike@google.com>
Subject: [PATCH ipsec 2/4] xfrm: Allow UDP encapsulation in crypto offload
 control path
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
Content-Type: text/plain; charset="UTF-8"

Unblock this limitation so that SAs with encapsulation specified
can be passed to HW drivers. HW drivers can still reject the SA
in their implementation of xdo_dev_state_add if the encapsulation
is not supported.

Test: Verified on Android device
Signed-off-by: Mike Yu <yumike@google.com>
---
 net/xfrm/xfrm_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 2455a76a1cff..9a44d363ba62 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -261,9 +261,9 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
 
-	/* We don't yet support UDP encapsulation and TFC padding. */
-	if ((!is_packet_offload && x->encap) || x->tfcpad) {
-		NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
+	/* We don't yet support TFC padding. */
+	if (x->tfcpad) {
+		NL_SET_ERR_MSG(extack, "TFC padding can't be offloaded");
 		return -EINVAL;
 	}
 
-- 
2.45.2.803.g4e1b14247a-goog


