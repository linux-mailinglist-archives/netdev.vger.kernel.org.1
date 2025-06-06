Return-Path: <netdev+bounces-195478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA17AD06A1
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1421891F65
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB48289838;
	Fri,  6 Jun 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmie6J7U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96ED1A38F9;
	Fri,  6 Jun 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227338; cv=none; b=ScwfA4CxTafmn6vWOiAZptvgqpb6BihVpoLR1HSIhCv1yjhP3Lfujdc4wEe2j9zK3l0JD9E2k+9zdGytdy2PiiEnQJMDLCEshGxkKTVJpq+juBdnTghAk+7fu1dmM7fz4NGjaQF1SP5I5wdK+sywU6EHY331DyIqp6/+3ABZkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227338; c=relaxed/simple;
	bh=lcZjw5NhrGSP8Fd/RXZZSsMKxRWJXSUvL3V+ujs52pw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SfHe0cDv2Le1DY21TytGigVnCMinoiUC8l93eEMlWS8sq+T80cuTt4RmvE958PTeQTUKr4xInw5vrJpV1cuc5SiPxBENlOAxLNorh2aLDa8nB8qKnaOX/XclKj4TNtLaxIwSBU0iCP8vYNsquf3VKkJt2fXxFfNR3E2zQj6Px8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmie6J7U; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742af84818cso1728328b3a.1;
        Fri, 06 Jun 2025 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749227336; x=1749832136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QkuGPWcwShGZxELXQedLn34TZVaZiBOSzMW66deSoV4=;
        b=kmie6J7UF/L+PF8IIRX2vEEIXOJtZ5eFpmByHscdTMUgVBNwmsPlLjvP459VC2oyOj
         l1yXhiY/E2+C6+wOXoTr9lsKVdeT+oj/VcGoclGovUwlrOAJT4gdUK3uxqHMPnl8d5Uq
         mAIrHiCQUpzMvF9HIbDea6hAF4H6QhMVPfmudbkGlnWkMnK6tHFOeM/58khl7Cr63G4I
         PbwEzNThuouYifaUccAtv8uVkVZdiTmQJ6l4hUNfAN2czknXRovHjA1FLl7wE73DIUKR
         u24gnhLTCSFImWouZjkJaYQYcD4z8kmW7ntUVV5F8rRk0DEQU1R3gOFCr+bT6kcPlRqr
         /K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749227336; x=1749832136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkuGPWcwShGZxELXQedLn34TZVaZiBOSzMW66deSoV4=;
        b=YKVGCS0+1dQSeexd0BP0bfi0sJZUlzhARSZL0WkLyioo75xpKlbPMiYPR4p3cBoIH6
         9QtUGDpZKlf/bSAeUY/mOs975hKRC4mo7vaQEjaPvz7uWQkE51zyTNXtJIXc3VP0CFFk
         Ep8tT5k7Qw5YNEBRRk86Xp8G0ayHThIeJ6NZkaEEyp0x0w3+yw59GVyoMs3fY9q+j+na
         lARStsdJu+1BbA13F6KdNLJhaS3wQhYcG68PxX9D0SLRqTo9hl/8TXV7r2RrBlSLnMjX
         lmElXONshpF+u2hDvGU3kZmXgPYcEJS2lDhNyB/4UnVNqUmCh4wtnf/ud1rMc5tRjQO5
         VW7A==
X-Forwarded-Encrypted: i=1; AJvYcCUqdKkU9KVbeA+Vyg7YzBzlTiAQICfSqA6dPSYRdePIuBf+EQXg637y4tSlrULgqptYVDEunnPf@vger.kernel.org, AJvYcCX4KS41t0L8z1r2Fz1fPqG4e6wGsbRNgBgfFcIcLJanMVddjehfY2ycrir8ehktxoCswY6njiIFooRhpFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXFSk8f+LkArsBh6ojlv/wwAT9XFnT5pde3rSUHgIqpIO1dNi
	r8oYPQeUQ6DOdBffxp+RUCeUJc4YtThDsVhH/kp3kJ5xlJlzalN3mmJ4kKIkDw==
X-Gm-Gg: ASbGncsDX3ieOEVvtQp2CuCTPHZYfFl765MyBqpHksCzi+TGNi3H7R7b7c2k7D1gX39
	cfv7kOKhN5IVNQPCf62+OmJk0PLNgrunIjEFJAxd5eZXwu/UT//eeKq0uAU1ZT7wZQeNHmiupLa
	Y5okei3cCxoy5v52Ii0YhN+IVKwlIo8SsUKoCqxyHB634cbToI4UKP052wXbbm3OfkPrqHdOOm9
	nOFjTVN9XX90jw0FT1WuZSDuJcTyt4pNkhWr2at31HXY+2nGfAthJo+VlmFdG30JGzqtnIZ3y5Y
	HnbxPxFu8ST6678qeLID5IQW+zgtZ2bw5xtlbFwawGBkPGkscHHbxeHzX91TBhXnLyqB5RJcI74
	sPogqWy7v1OpufJZw1/uU2ZhoHo/MMXxA6QB8LUXYFhxm
X-Google-Smtp-Source: AGHT+IH+metPkg/LraNFZUYfYpbf2anAcGQuwx6Lgl/tXUsyktwsOrhi6yQI+Pt7iLkFsIQYNIWtSg==
X-Received: by 2002:a05:6a20:a12c:b0:218:bcd3:6d2e with SMTP id adf61e73a8af0-21ee68a40e9mr6719638637.36.1749227335961;
        Fri, 06 Jun 2025 09:28:55 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482fc43a1esm1105072b3a.38.2025.06.06.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 09:28:55 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] mctp: fix mctp_dump_addrinfo due to unincremented ifindex
Date: Sat,  7 Jun 2025 00:26:50 +0800
Message-Id: <20250606162650.2063172-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Yin <peter.yin@quantatw.com>

The mctp_dump_addrinfo() function uses mcb->ifindex to track resume
progress when dumping MCTP device address information via netlink.
However, if mcb->ifindex is not updated after each iteration,
the dump restarts from the same net_device repeatedly, resulting
in an infinite loop.

This patch updates mcb->ifindex to dev->ifindex + 1 after
a successful call to mctp_dump_dev_addrinfo(), ensuring that
subsequent dump callbacks resume from the correct device.

This fixes the netlink dump hang observed during sequential
`ip mctp addr show` or similar operations.

Fixes: 2d20773 ("mctp: no longer rely on net->dev_index_head[]")
Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 net/mctp/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 4d404edd7446..ddde938c7123 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -142,9 +142,9 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 		if (rc < 0)
 			break;
 		mcb->a_idx = 0;
+		mcb->ifindex = dev->ifindex+1;
 	}
 	rcu_read_unlock();
-
 	return skb->len;
 }
 
-- 
2.25.1


