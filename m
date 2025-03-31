Return-Path: <netdev+bounces-178342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AD7A76AAE
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A20166E1B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FF021CA16;
	Mon, 31 Mar 2025 15:06:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280AE21C16D
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433576; cv=none; b=nbSaH1N/wvc2prMPCwef04D4pZtwjzBvfDZs8KmomwKoWYkSvH46+sSbcF+wnExT0djvBB2qmaQApUgc7Ki9mIhGx+Ama1vxS6SDLVagGnODEzaPYaeKZVVbkacmjXih1VqzmIIpR/ME+uqdeBZXauy2APOyWTfjrtic1rw+248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433576; c=relaxed/simple;
	bh=No/0VfPK7pHniKtbbaQJ0cyWQL9HoLVC3b3WbWBLe4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1PmUG6sMwHZV6w9phz9lzn8rACZUlX6LZk7a2NuVKdthOR8t2+0QgSPVWt7jeucI0OsGs/x9H9K38PoF9Y5WuSSXY2LFRSqWY9lWosIhZ7YDi8+uFSUteFzxCwyWFnVqOt3MSXJ1P3sXt9JOGnxTskmSZg06GaFzHEHtHGITPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224019ad9edso1370625ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433574; x=1744038374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOUxfu91P1ktbOKHx7UEPpGlhg2bkdrt6E9z1Gl/UMk=;
        b=ey3dAJk23l+piv197mW7dB1qpc8U7jFTH3PxlKJJ4ZubaN+tPnyrXpiK9vyQJQjnaC
         h4xYn2omVvg3BMWqHHpxXTeE1jsUljnuf0mFfSdlbZ88FLGTpaPn563YJAnaDGeDt8n8
         XwjG9kkjdddC4KRhcQE6OPZb20UhpN926XCmDdQ472s3aTjCrYlGebsHeywDTegFPLIM
         5P3lYXNCZPctwjx5chPi8kGts9GS75O6S87iZQALoGT2Dx4jfRz0QEaEmBTTGevrnNtN
         CjASzW3UzZq5Xvbu3eLFd6g++RdpdoRVfOSilHD89zWGZ9I5mOXWYJ1SRBc00lQ3f3uq
         EjQw==
X-Gm-Message-State: AOJu0YyLLkRrxmPWW+JP12kIwyPJqB7o0CX06Q12LzdbZm5A4A0QQ3ra
	RW9g3+1ZWn5tgMAKqb7U201VLeVglYcnubruyD7FsJMXgY0HxHFcT9/Z
X-Gm-Gg: ASbGncsxOlk0p72SuX5U/xColntrO4j9HutY6YBy7ZwdeekLh1gmLbhkYNeFpGulsRJ
	I+n67AcQOPypqPGxeqSjmXWAKfJtGcBrNkYN7YVwimP3VFP7ulR8zyNsc5G87/p6F6v43qbz1Sw
	MafMDPO2ylmoj4xZH+Pp6f2sLEivquKNIYMfmmn+XoSuvmJ6kNSB8YvLLf2SiAzrPT7vJOyH3uc
	Bb1D96+UhekEcu3RiOudxARYpLtsTYvaIWYw97m0Zg5NOconOl5KeuG4lSjeohyhrNnQ1LJiC7k
	hIMRZvirTFyQQ5dSyMieI8voNdoCcyoyu0ccIetLbwRq
X-Google-Smtp-Source: AGHT+IEuEyP0T1v9DHBqkTQCA7gh9eF0ly8zwvxyeDlONg0bvtPiXsfKYEETz1hwtokhkGxBMFPQTA==
X-Received: by 2002:a05:6a20:1587:b0:1ee:c390:58ac with SMTP id adf61e73a8af0-2009f78652fmr17854349637.34.1743433573924;
        Mon, 31 Mar 2025 08:06:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93ba0e532sm6461455a12.64.2025.03.31.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:13 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 06/11] net: dummy: request ops lock
Date: Mon, 31 Mar 2025 08:05:58 -0700
Message-ID: <20250331150603.1906635-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though dummy device doesn't really need an instance lock,
a lot of selftests use dummy so it's useful to have extra
expose to the instance lock on NIPA. Request the instance/ops
locking.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index a4938c6a5ebb..d6bdad4baadd 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -105,6 +105,7 @@ static void dummy_setup(struct net_device *dev)
 	dev->netdev_ops = &dummy_netdev_ops;
 	dev->ethtool_ops = &dummy_ethtool_ops;
 	dev->needs_free_netdev = true;
+	dev->request_ops_lock = true;
 
 	/* Fill in device structure with ethernet-generic values. */
 	dev->flags |= IFF_NOARP;
-- 
2.48.1


