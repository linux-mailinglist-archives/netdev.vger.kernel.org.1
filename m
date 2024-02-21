Return-Path: <netdev+bounces-73666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D285D7A0
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 13:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1A028368B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A4D4D58A;
	Wed, 21 Feb 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn9j6f+B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B04D9E8
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517091; cv=none; b=n9sMn4ZtS+B8kht0Q0IDNZSmXdH/FNsJBdX6yBuyTC/Ayf4iz/TR4BoWb0YSM/cQVBYE7Y/ec2crD/UHn5lnk5h3V3U7lCwcYlxOyHjL3TwQXuJzXhlTADhKy1TOFj2y8/07qN+/Y6DXv61OtUPrC7+ykadWVqxUbecKl0OY+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517091; c=relaxed/simple;
	bh=Z5u3RNJb/cKelaTMB4kaA0pCleueUlDUjANoZSfT+g0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qipEPfJvqSTeTnWDR9ESPMMMApG+6oeFyeoXMR5Q3ire23P2zRBKZoBXn0wQzGMKDyONCPjB0/PsAIAxc2ONX8fSQmwkv8OPcv8NKH3H3HKSktGpkWXz9KE1nHxmqpfWlGZlO6+AIwIcgAb4p7Ftuu/VxW4jenjD/yehJt6ccxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn9j6f+B; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso2687892e87.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 04:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708517088; x=1709121888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJqXdZDzlXcpVVvEM1biI7hIBvEUs7rSrTCVlhQwBc8=;
        b=Xn9j6f+BiYVButnxa26ID2Vj/eDQ5Ea97DddFO3VwuhhfejBXTs4r3vVG9AP0dL5id
         s9W67cDu1J74qHskLgrZpa07eu5m9BGZugCUDf7eizruoUt17UOt1fPJ+8j2w6NjnlPn
         1G2qjp7Ga94nIkZbnj+5Wi8KstcngeaohiVXwtr25Pfo3TpdprACFpPAAsCj4jrlCvIO
         sBvceYAKSHkyO4pERAUL85eg1RjmWfSB72XB8anw1yuXuzOzDhy7JZjnUGtzez7yn7xE
         SmIcui6TT+B+rSj6PI/f6LyV8uMUyNVDjaJ7nd4Am5Ujq952p3oVGMbz48sd/XvVZiqN
         pNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708517088; x=1709121888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJqXdZDzlXcpVVvEM1biI7hIBvEUs7rSrTCVlhQwBc8=;
        b=HZOaCH+CGUU4RhUXI60oEUo68johuD6njYV44icudlOVGfXfZUcArOAL5o4zYHeL5p
         DDWuLHyYsFZds4pVA49tK5dAq3bnFK4/i9PJue4UaO5p1je/paGVZkQNPk+DxfxPHPyO
         TAPec3f2wSKNuGxIF8+xKOeUsFDU5c3o+mFOoCXfDZML8sQVA9bjf2amxPAPIqPMTHBk
         JEqpal00EeJMn7VuvnFr3jwX7Ou/opMOduCYwZAID9mI6dawXAJR+gSt1qXxbroa3Ayj
         FgsaDuuHZUkODcqmTMzAN0qx1kNVtV8z+6hJd9FmxLVCglNBTf7osQhh29C1MrRB1bFk
         G7CQ==
X-Gm-Message-State: AOJu0Yxch8bYYvdoeFk3OQfr5sIiaNsvjGmQ4b0zE/sa9TXK9ujpm8YR
	eQ0UKsdDBJfuvJuNFkwQ+ZyTwrInE0u7jEyOldT4vLdH/ccD+J35
X-Google-Smtp-Source: AGHT+IFHQTLFm7wDl4eirKUuUBoxWuCFqNnMj1EIvw40LkOeTHCtzGHtUgPoO7fqVaoQjq/rjaQklw==
X-Received: by 2002:ac2:4d09:0:b0:512:b25e:571a with SMTP id r9-20020ac24d09000000b00512b25e571amr4636257lfi.3.1708517087354;
        Wed, 21 Feb 2024 04:04:47 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id d6-20020a05651221c600b00512cf8c11fesm278002lft.79.2024.02.21.04.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:04:46 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2] ifstat: handle unlink return value
Date: Wed, 21 Feb 2024 07:04:24 -0500
Message-Id: <20240221120424.3221-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print an error message if we can't remove the history file

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 18171a2c..5dede111 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -938,7 +938,9 @@ int main(int argc, char *argv[])
 				 getuid());
 
 	if (reset_history)
-		unlink(hist_name);
+		if (unlink(hist_name) < 0)
+			fprintf(stderr, "Cannot remove history file \"%s\": %s\n",
+				hist_name, strerror(errno));
 
 	if (!ignore_history || !no_update) {
 		struct stat stb;
-- 
2.30.2


