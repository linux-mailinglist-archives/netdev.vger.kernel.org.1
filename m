Return-Path: <netdev+bounces-120829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B595AF38
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B701F24854
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED216F0F0;
	Thu, 22 Aug 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCbjqUeX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39216DEB2;
	Thu, 22 Aug 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311317; cv=none; b=QxRN3DQJ5wRXEJ3FyeD9GF2VRUn3PrR5Jhtk1dIYMNVDgLW0kTlQibnZ2LLIikustmy9Zr/ZZ7tTgcZO4L5GCuI0YXns5lnybIIxz2nfx0kMfa9ZH+l4D0SCezeT/Xd5OIy6fhZjcRvEBNBRl5bQifE+Z+BJj+tkReLYzIyXjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311317; c=relaxed/simple;
	bh=nNDexdTioCTGGo+1m6GnqCfGEK2qQlnbf0CpCXYmhUk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gwrHJRiqyCfdbC8vmjAW4+keZtxqNT2paE0/Ba0/K4d9t1xVKYTPjSIwj1iverzlWrsOhWzeeoVPm8uon9l1Qb4gvYd8opfo03lxAF2jDfWyA1TTxOmwvhMPlhCAXMl5PyrfFFNVzcs2EiL3jjN8BCTtX2VnFlS8D9jxt70lLiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCbjqUeX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714302e7285so403752b3a.2;
        Thu, 22 Aug 2024 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724311315; x=1724916115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkB/d8ErHMSWFnxE7P9bAPdATeEZPVv3G/phURvLmPo=;
        b=ZCbjqUeX4Bsyfdykdc4ycXSBNxxQSuDtkkLwNVe537m6kK4ncJ+cABJmLkcfdXFsyt
         VlVPs9dITPUfCU7pFksM6oXuEfXZikDBeuZOLRcX7Mg1jS64P6dCJOSA8FF+LTIvzlYS
         TMYHfZgF+if4QWv4POGi3Xeqcte0KJvE8GbPTefawI6Ykg+WjyWfuj04CNtjaIuQ30+6
         rXNERSXat4vk31dsAIDSe0u1exBKZOyFydTCvtESOwtCDdj7+CoOoUKWgqoTieOdIdax
         c/G2mQcQ03Otk0HK+44WY9zXgZN9JqbRTykyqIVosokCIu4xAD33ADPOz5NcFx6Itpx/
         XANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724311315; x=1724916115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkB/d8ErHMSWFnxE7P9bAPdATeEZPVv3G/phURvLmPo=;
        b=rEqCRoZuGW3N2vLvLEdwDqQciM/aldxxcq5Iqa18aBOZQdxDxRb/Z1JLaM7fn7s/GC
         0pIQdizHag+OMHWEKcl0fJQ6DJJqSN0TAMZ83ZksUO6IeyrdWeEKO1nou+1mSzUssOcl
         +1yFTTZG/D6zjCogh3Gpk9K4Np3KEq3SL1WFKJ3FPyG12vGeHofPnRAVXV2izGkfz5tr
         DLxAHJMjqJ1pSicdJsa8AoXiBXjXVciSs09dt6vuFrLRmO27HVzRZReleFTmdjbeUink
         IaGoVuPidFW9OTbRyzpDmNbN4zqT6ur7vBSYR1qRE9XooQDl2FAbXeSB14rdcItmtrIo
         C2yg==
X-Forwarded-Encrypted: i=1; AJvYcCVwLZ1I7Bfn4zhxizjp5tr/zuVKTIFoYW9fM9GcAzQ4AlrZfsuMxbNRiERNsQlyLA3Tn73FO8QS@vger.kernel.org, AJvYcCWWTRzh4zr5NIHDElza/Ovr4rqPWrJ4swEK0qIrFTe3QF/esoh+1n/QIT+TPKIA3/HFgW+9Oe2sja6sD0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrDTzahTQJNJ6U0r1zw0RskLYOMjdaFJ8F+asFSbNcRDq6BiH
	q2MbF93iJZgQsJV+BoPJmNxFVtwMsc5Xd9+DOQpuPLbEXnYr87ay
X-Google-Smtp-Source: AGHT+IEZWm66FyTBPnaCOSfXUHPjXm+fcp7gqEt7jBcOoAjWP5aAD8200DmMaWV1xVpLL1BxGgZwRA==
X-Received: by 2002:a05:6a00:2342:b0:70b:cf1:8dc9 with SMTP id d2e1a72fcca58-714239600afmr6201644b3a.25.1724311314901;
        Thu, 22 Aug 2024 00:21:54 -0700 (PDT)
Received: from localhost.localdomain ([58.18.89.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434335e5dsm754330b3a.204.2024.08.22.00.21.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Aug 2024 00:21:54 -0700 (PDT)
From: Xi Huang <xuiagnh@gmail.com>
To: madalin.bucur@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuiagnh@gmail.com
Subject: [PATCHv2] net: dpaa:reduce number of synchronize_net() calls
Date: Thu, 22 Aug 2024 15:20:42 +0800
Message-Id: <20240822072042.42750-1-xuiagnh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function dpaa_napi_del(), we execute the netif_napi_del()
for each cpu, which is actually a high overhead operation
because each call to netif_napi_del() contains a synchronize_net(),
i.e. an RCU operation. In fact, it is only necessary to call
 __netif_napi_del and use synchronize_net() once outside of the loop.
This change is similar to commit 2543a6000e593a ("gro_cells: reduce
number of synchronize_net() calls") and commit 5198d545dba8ad (" net:
remove napi_hash_del() from driver-facing API") 5198d545db.

Signed-off-by: Xi Huang <xuiagnh@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
V1 -> V2: Modify the cited commit format and remove useless information

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index cfe6b57b1..5d99cfb4e 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -3156,8 +3156,9 @@ static void dpaa_napi_del(struct net_device *net_dev)
 	for_each_possible_cpu(cpu) {
 		percpu_priv = per_cpu_ptr(priv->percpu_priv, cpu);
 
-		netif_napi_del(&percpu_priv->np.napi);
+		__netif_napi_del(&percpu_priv->np.napi);
 	}
+	synchronize_net();
 }
 
 static inline void dpaa_bp_free_pf(const struct dpaa_bp *bp,
-- 
2.34.1


