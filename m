Return-Path: <netdev+bounces-180410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA3A813EF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1681D7B0BC2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A41DA60F;
	Tue,  8 Apr 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga2O7URq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5522AE69
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134382; cv=none; b=pzBM9W1iUORuZ0Atv6580MD473WOzauFICLcYSQqobBF3ZLjinZRE3RYx0rJMPt2IHszQPLkPgGvVrf7o7nqAO+NF83FoEa/TGhp0YURTPAVQh9y32Du7JdUTKz+XnK7IKiBWpKCbSuuUytiDxgvgzviEPU0si6wT0W4a8Zkyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134382; c=relaxed/simple;
	bh=3lEXJFCMXEmWE3f2/zCk3HHtSBfWCIM7B5joDw6C1TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBDzKc7PzzvcbpKs5ObSQ6zAvU2guYMRed9ScvCrO4aqWjyCggch3ulqvKP7zHKw6M87FWnvlB0XaTpl4lg0Xfgn8exG5MS4FbV+R8WhEg29QzAZcY4zq3O6V7AYwKkfj7OeaNEGRhhzVGWhyvWmnlVp8i6wLFxb6qD7sK8nKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga2O7URq; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86117e5adb3so143950339f.2
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744134380; x=1744739180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UiqOrVnY+KTT6qvZRLqBrDGWIbu+5SGS7iypBmOfIA=;
        b=Ga2O7URqF4FWX9IxMhWQncuI4nYOQxdkEcgkwFRMSUg2udhNLokmb9plGjqp1DtBmQ
         ZYLbnPOCv03tUhGSwL4BtIwyk5i9LtrC9RaRQMGjBQjoIhmPLxg/0Hi42upXo01TZ+hC
         TEFub7qwty+JVGXhYPa/fdBqkOaIP69HLp/wK6ZUpyVGNjHCc01/CSBmKmONrF74VJD2
         +NRd3AgjWVIN1rI7DdJEiQKFVg21CVfYarNIRF2oKp5e1YsoxKfvv/jzZiyvBGqq2NG2
         R5wnKeQ5lR/7SDoLJvdXAFU6RinvfStlAsRvHlvvmxn0AvzzKhV9OTrwmpe6SCyYmto5
         bupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744134380; x=1744739180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UiqOrVnY+KTT6qvZRLqBrDGWIbu+5SGS7iypBmOfIA=;
        b=FyVtEaKZGM2BcjBDgPZAnWAaFroczxOE53mmdb8UnRFgBPOfucjk5sYcr1eiQtwJHT
         Du8oexPcNxRutCMU7WUqxbMIy3ec2UoWNAOUg2t9EG8VROBkliCDVooXvQmwaI/wQ+PS
         j6vFiy0dIcM6bzXmf4IlijD1BnovraNkZtO5kJftqlF1QTYLUckOpJ0nQfwjmSGtUbgD
         mf4WleCZG7GoQbd/6ky99r2/4gbPtLmtZPLUqRWfCtzsiGwzBds9Gg2kt6n59cLeyYtU
         wbiFExxdS/Fe4hHfufStpHEkLRmD2LVgYrqxkrAl6wryB/O4FLN70FDzV6e5mi0WH/1/
         zINw==
X-Gm-Message-State: AOJu0Yxql5SvO/aVE/deAjlu7TBFRauxul7eOkZO0+ZN32xRNvdUGAFD
	9urARA9nfs6mpdLWRq9QflGPjk9riH1oi7zbGBnZ9ci77035eYz9joHi40AV
X-Gm-Gg: ASbGncv2W8DtmMOoKfncHAEInE0plxyQPMmf5oihJ2cKIHHaFVR/7E32cTIUxOFpIz2
	tNcWCHjqC2g0ZlBxQ0/k8W1Rxm3jCXTzE0o3MxqlyPi9R9O5+MAImnY3jY3Y0YzHt4vEsXpOHVe
	LSXBqX+8vnIcyiddxtP1erTRcUw1WWkp4yyjxSjB2oaSEGgy8MKYOAdyn9+1ZC1mGPeHYgrA/vM
	l4rbuGczhgKGETySnXRmULy27KfFHVcU7kebKkz0cwXRDUZmK7ciaznS3FecvSmzrYMUlgIOYJW
	KzH+TtgtLIIiUL8v5eQUozGSaG5hpQMAB/jHrAFO7XGv7TazS4bJMTd8b6GoeuM1b9s0xZ4Y1qK
	9jaL8Wgnb
X-Google-Smtp-Source: AGHT+IE3jl7HBoysVWDj3eIme2CcImgnESaP6RoMD19MKgICwMwqtSbhoT8tM+lXSVhLUsRc1rwSiw==
X-Received: by 2002:a05:6602:4013:b0:861:1ba3:3e50 with SMTP id ca18e2360f4ac-86160f5f85bmr15209239f.0.1744134379725;
        Tue, 08 Apr 2025 10:46:19 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba9a0sm594670173.88.2025.04.08.10.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:46:19 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net] ipv6: add exception routes to GC list in rt6_insert_exception
Date: Tue,  8 Apr 2025 13:46:17 -0400
Message-ID: <837e7506ffb63f47faa2b05d9b85481aad28e1a4.1744134377.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list
of routes.") introduced a separated list for managing route expiration via
the GC timer.

However, it missed adding exception routes (created by ip6_rt_update_pmtu()
and rt6_do_redirect()) to this GC list. As a result, these exceptions were
never considered for expiration and removal, leading to stale entries
persisting in the routing table.

This patch fixes the issue by calling fib6_add_gc_list() in
rt6_insert_exception(), ensuring that exception routes are properly tracked
and garbage collected when expired.

Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/ipv6/route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ab12b816ab94..99903c6a39fa 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1771,6 +1771,7 @@ static int rt6_insert_exception(struct rt6_info *nrt,
 	if (!err) {
 		spin_lock_bh(&f6i->fib6_table->tb6_lock);
 		fib6_update_sernum(net, f6i);
+		fib6_add_gc_list(f6i);
 		spin_unlock_bh(&f6i->fib6_table->tb6_lock);
 		fib6_force_start_gc(net);
 	}
-- 
2.47.1


