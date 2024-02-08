Return-Path: <netdev+bounces-70336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57B84E6BA
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0661F2A05D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A61823AA;
	Thu,  8 Feb 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="3WOcK9m7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796C82D8C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413221; cv=none; b=GRAuxlC9px8k0lqmNIm3SuVITd499gA0xtZuKup9TtXIUlHP1O2lAKAzuuIz86DZMrnY7nHGe2zH5DZoAmtmTpcTgdM8mWrw7OEVms2VFtCQZhgSoSB7iAl2wsIZXU02ym8ZMgDSLtJe0zD8MFvy3RBTXa+Zz7rox587J9k6XqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413221; c=relaxed/simple;
	bh=AG8jG6dAnrcRElapPLvkRRBQUOO7ZJsaMCUziJj/mIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWzfrtUJd1/b7QdTGKLqwhewtJGeteXecPY0NJXuGI0+MuLITC2NG1XEjF8GELrM7lkPOMfEUh5EbLHbeKJqODctS6KAxxqwFeooCPVL1VVCLHye8sXRl2Lqn6fZDhSSHQoWp83o15Vn5bHzd8Gpe5iJloWcEfZk+WpqyG+D87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=3WOcK9m7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d751bc0c15so36325ad.2
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707413218; x=1708018018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd5Y0BCj/r3EVE4i6V+IZkFH+Ey+uHymlZ8rC/cUF+E=;
        b=3WOcK9m7a6/UEdwz3oduy4PgJJcmcP6769fLzqqNfI0ThPerPCK/w7dI4gYDv1iqHv
         9a17wbMx7JgDsYAuIbGQoz+j1JCn5B3vWAAvFInWTxcGILUCk9gr/IsnpV7CuVrGV0X4
         Bzj1SARYCvbuJdIODlwq0OC28Jh0Uz8bY3TTsrwqzaolbETEBnKvTzSLhdrI8DIEqBhG
         E6yLNOjufuKKb4scxzj6Kcmv6WJe+YjhBHjSbyutzXpxiyzP7YkfzDFUqA7U5e3R50Qa
         AT8+BpFmjxiDsj5zz1CTbHKrukFU5e5UWAkcieJmGsOE4Ptuk/neqYmB9vlNWbP5+Thc
         FDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413218; x=1708018018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vd5Y0BCj/r3EVE4i6V+IZkFH+Ey+uHymlZ8rC/cUF+E=;
        b=vNeIpplJbArxuASxxx+29tfcRdqFmLRo5U1+gPnVBauwwjGaVorP8Rk+gDTH8g6TQB
         maP3/wRIySbHRyI6cYhVZ9cDnmRyZLxo9ugyAUBu/SwIxZmcyGqQs+Wn3DMSSWL1ZDyL
         ZOFZ21NCeLukfgSKms4aZSklH6LkCR61YO93g7I/Isj/CsYDoyUSQrjoUD01n6OLB/rc
         SEHhv3IU5OFCcgkGpiiA5ExTDDOm3/0Auq5lsuuf6mSwDDGX1ItY8vvkCgTnuC9aDdRv
         UyaUDFdxJkMB8NZ2oI/c58m9o8aBpHIZ3Sly0/brsuJWEdAvCoBlREFgE261PIo9jvQ/
         H5ZQ==
X-Gm-Message-State: AOJu0YxAoQwp/c2JuGcKWW8vx9inXhWZ7L8/hhoKykjjb/43UMUd7IFy
	iIE+oWvjonJ06Eu0nFeJWOyEXeZJA11qtZDxAHq/VikNsCYI1plJ2+861t5IJdjz+tyxHSzyKkc
	Q4kU=
X-Google-Smtp-Source: AGHT+IFeyoHYMLPR9x523CVQ37x9vPYaNBhnE2DjpqhYvBuD1UGazegjNNIFA43dvCOOF6S4fQ3gyQ==
X-Received: by 2002:a17:902:d550:b0:1d9:a148:49c with SMTP id z16-20020a170902d55000b001d9a148049cmr10371879plf.57.1707413218313;
        Thu, 08 Feb 2024 09:26:58 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g14-20020a170902f74e00b001d9d4375149sm42265plw.215.2024.02.08.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:26:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/3] ip: detect errors in netconf monitor mode
Date: Thu,  8 Feb 2024 09:26:28 -0800
Message-ID: <20240208172647.324168-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208172647.324168-1-stephen@networkplumber.org>
References: <20240208172647.324168-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If rtnl_listen() returns error while looking for netconf events,
then exit with status of 2 as other iproute2 monitor actions do.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ipnetconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ip/ipnetconf.c b/ip/ipnetconf.c
index 9ae6c45e7fd1..a0c7e051bac5 100644
--- a/ip/ipnetconf.c
+++ b/ip/ipnetconf.c
@@ -193,7 +193,8 @@ static int do_show(int argc, char **argv)
 			perror("Can not send request");
 			exit(1);
 		}
-		rtnl_listen(&rth, print_netconf, stdout);
+		if (rtnl_listen(&rth, print_netconf, stdout) < 0)
+			exit(2);
 	} else {
 		rth.flags = RTNL_HANDLE_F_SUPPRESS_NLERR;
 dump:
-- 
2.43.0


