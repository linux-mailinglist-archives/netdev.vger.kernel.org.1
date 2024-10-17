Return-Path: <netdev+bounces-136497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B356E9A1EFC
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EBD1C211A3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07BA1DA61E;
	Thu, 17 Oct 2024 09:50:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD71D958B;
	Thu, 17 Oct 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158654; cv=none; b=L2NAZ4Oz0aA4NqYqB0jHo5/k1XG1jzZEl8pt1DuglYzrrMrhQD1UkVkfOINHFnBo3/WAKJGQl6vMXybT4qNDlKXFfGgGsI1W2w8zw3kaS3sCqUlOKg6TVG9EVhA9+T9KSsPMZ6cqWFY+/r+/dWDGRnXaqgOqlLu7ovpXqIx5L3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158654; c=relaxed/simple;
	bh=13oDv9K/TtdANIFyDZPCtxSwGQD8SejAzD84rs210cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT4hsCSk4vGwXaAsvBCXCsPWWtGpX29141bdcGd1Tgqf+roJ58VZrGz90dxpJnmOlSvTvg+mvCvvZducLGXvAHWdaC5l4x6CYFdhI4dhtOhiJeHAw+x6pfMf7UifqCZTBT1wIR8Tzmt0M10SJv3vulMDDFm5UePUUTTWufqQpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so1141251a12.2;
        Thu, 17 Oct 2024 02:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158651; x=1729763451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUKUh9/c0jcVOB7NUuvJ159i2bkxlfNZskS7vvZp3VY=;
        b=IZSxLZVEhnwNoiX35QnbONPr8jm6AIZ6bGpOK+PDChGij8h+iaJmqmxO7ylQrTS/Z+
         zc4ScUZ1iH58yJE9LCMH0BtLi2OB4mowHzojBhmpFNBbPg3nIVG4QCVwoMFIPKVH8FwK
         prIlTYi8+zKUWiRUr0qVlzIhoyaQCq/FDuGhkKjcFai7r66vhGo97GmmjLFsaibI8RwF
         OBuzCGGMcFEcBNUrjbdz2SlnRuUMUrb+GIqY1ekur/hXy1XCjiYqnXpEq1zl8kKoX+sA
         GneH1URlXyDd9PTMrsZ1/yJQWCP+tKEPOhT0W3o4Jc23ecRAKEbqYJE6qEmjdTzLXyJp
         2rog==
X-Forwarded-Encrypted: i=1; AJvYcCUeUcJEJ+PEHRUHgnngHaqPkOu+sQLMP+/NFgisCSQ//GS+IezDsQFUfpn6FZg1we4r8s/U28BnxsstGwM=@vger.kernel.org, AJvYcCVqdzq5HuTjxpsLI6jOK6bEi+7wiVEMNYEQ1lMIAIJjWbRvI+1K+qQcg6JZwNvuSaTg3OBj3qoZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+VA8erZ+2GGcLuY6KQ4CB0El0+KLV/mgbQBVMCIzJGH16lkFw
	1mmnDkzPgk46PGjZB5oLN5nwMKfPLTs1sO24/28inGNHWQKZRoIg
X-Google-Smtp-Source: AGHT+IGVu/dn/BdzmKxCnSpXlj5OYTnfNLE1a7yozVN6WAea37Uafy7xqpmHbejXysCYEp+ETifmwQ==
X-Received: by 2002:a05:6402:254f:b0:5c9:7f8b:4e49 with SMTP id 4fb4d7f45d1cf-5c97f8b4f3bmr10148558a12.25.1729158651099;
        Thu, 17 Oct 2024 02:50:51 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d7b7da0sm2548486a12.95.2024.10.17.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:50:50 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com
Subject: [PATCH net-next v5 1/9] net: netconsole: remove msg_ready variable
Date: Thu, 17 Oct 2024 02:50:16 -0700
Message-ID: <20241017095028.3131508-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017095028.3131508-1-leitao@debian.org>
References: <20241017095028.3131508-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable msg_ready is useless, since it does not represent anything. Get
rid of it, using buf directly instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index de20928f7402..a006507c92c6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1075,7 +1075,6 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	const char *header, *body;
 	int offset = 0;
 	int header_len, body_len;
-	const char *msg_ready = msg;
 	const char *release;
 	int release_len = 0;
 	int userdata_len = 0;
@@ -1105,8 +1104,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 					     MAX_PRINT_CHUNK - msg_len,
 					     "%s", userdata);
 
-		msg_ready = buf;
-		netpoll_send_udp(&nt->np, msg_ready, msg_len);
+		netpoll_send_udp(&nt->np, buf, msg_len);
 		return;
 	}
 
-- 
2.43.5


