Return-Path: <netdev+bounces-67832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67409845160
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2442C28F085
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 06:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394B8612F;
	Thu,  1 Feb 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abpGXSTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA46DD0B
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 06:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769008; cv=none; b=EEy/biVEh3BsZ0DY14N7wJRWZP769cHqx+aJ/HXduEp7nayXTVUTpMzBFrpHsU+jqyOZGspAtFa0IPBqUH172twjc8IneQNS27zqZ0ZBdS7zpiPc2uMTDTUaSJ3EoW9ENWP5YoVK2Y0+foBp1AAXqMvaz1Fr2lPxkQR3o8o9wGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769008; c=relaxed/simple;
	bh=DEJdWYns591whJd1rLSMrbdSOtHH9z6hQUwg4x8+DIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRCIop2c7WEJonX/WuEjfyy0bP4ugBentQQ++slwRkPBLUQ2/zPzJLfqaFBNM2D6djzJgW2uuWuaPTyB7b7lcPNY5xRYxlYYE1cxL5OAy4WW5yDi+85VJ1VkZPggJRUhPk8R3WcE9V++V/eLKphpBwMcrAWlWS+evXeGaScHQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abpGXSTh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso414083a91.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 22:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706769005; x=1707373805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1wOc1dBlqKAqzY5ma1gRIVsIZ65JWNBqw441NLcBTs=;
        b=abpGXSThgYI4rrvOiKyp61lIZe1XwmkaCPutLyruogygkdHYW55ymFIPnIS18QfHDf
         Jko2VyusiNY8CSe4dnPbsQMZ73dT8OR4DnHf2rOp9FUIYHDVfad+eKvR3kx5unIpUWMB
         sLnXiVhRIJW3Hn4KnAVtWHwFVx7ufH9EL2/a6F8MmAzhSVKnFB1BAzQa0udp2o2+Vh3f
         rwvcRFrL2qn2l1sehQENfd894fHyfDmji2FCCf21W4HbQHn1N3C9Oa7wPuX/nDhswpXk
         OrtKDjfDR4GTvB4M7WqvRMA8QM8yGKLDAsChsut8FvyPbeWPk5dlmAEC3KjrtT1h6WBL
         jkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769005; x=1707373805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1wOc1dBlqKAqzY5ma1gRIVsIZ65JWNBqw441NLcBTs=;
        b=iH6aj1RUN0qRuqcMYhSHM8L3sxDb3iD2gywneSPCLNwR5bBgIQb3z5Q7RBD4RNj/7Q
         izIwIc4b16drFkMorSRngrEP0OO6PXvN2tZiSonXjju/jYyXH6nWj8tJ3+KAfyWWx1Z1
         xnppjIrVs7coGfm9a7TvDbbVGP2q9yUnpkO0T9DKyMcOKco6dw81FL02huAILfIw0NGc
         LegHdV437dnvUyNeaKvovCNobRsXcj3k/qkjfOimQK5iTuu6odK246mGpYJwajF9C4X5
         J5e6KO+7SQOPqdaUYdnls7Ahme21C18qF6Ccf00ZSyS6iwBNipT9GVLAls7iWit4h+bf
         UYsQ==
X-Gm-Message-State: AOJu0YxlUhH0Gvk7pwzSj0PnwGYxR4LbLzEpikW06au9MRaUQVDCbyLb
	8yvbBIXfK70G4QCQ3r2KhomCR8IsDzsTQXoWl+6xHXjZJQs1wvBsmVDTDINzmD/j+7cl
X-Google-Smtp-Source: AGHT+IFj+gHRIZ1pjspfuTZ1ywwyZKF5bOg7hzvZ+fgSJi8ovA+ICJ9jZwmK8sEW4r88K5YDJsp2nw==
X-Received: by 2002:a17:90a:1506:b0:296:15e7:8f33 with SMTP id l6-20020a17090a150600b0029615e78f33mr702228pja.3.1706769005152;
        Wed, 31 Jan 2024 22:30:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbzAgiYRBb6cmEFpS99nOabq5ywTnxCx3lloSvDAXEfbakUwZCdEJJoBns6eFBp973eCeVj4QE9yN4fYadPEo22haBxnaA5ATQI9Doqm6eCqs/VWt3ig0eIddAFL/jWEBeCd+SPGyHGe3GtmcQUVDCouOHleD+/9tU9JNVfxLzE2rxM4FbnU7fLHqchINri4PdNN+v4OeU/MFToBDAKGXnfUf4uIbwLjqvVkCLVAmFXWvH3Si2/8wZOjtD9BnU6WdYfw==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pm12-20020a17090b3c4c00b0029618dbe87dsm515895pjb.3.2024.01.31.22.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:30:04 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/4] selftests/net/forwarding: add slowwait functions
Date: Thu,  1 Feb 2024 14:29:51 +0800
Message-ID: <20240201062954.421145-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201062954.421145-1-liuhangbin@gmail.com>
References: <20240201062954.421145-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add slowwait functions to wait for some operations that may need a long time
to finish. The busywait executes the cmd too fast, which is kind of wasting
cpu in this scenario. At the same time, if shell debugging is enabled with
`set -x`. the busywait will output too much logs.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8a61464ab6eb..f9b0195bf7ba 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -41,6 +41,7 @@ fi
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+# timeout in milliseconds
 busywait()
 {
 	local timeout=$1; shift
@@ -64,6 +65,32 @@ busywait()
 	done
 }
 
+# timeout in seconds
+slowwait()
+{
+	local timeout=$1; shift
+
+	local start_time="$(date -u +%s)"
+	while true
+	do
+		local out
+		out=$("$@")
+		local ret=$?
+		if ((!ret)); then
+			echo -n "$out"
+			return 0
+		fi
+
+		local current_time="$(date -u +%s)"
+		if ((current_time - start_time > timeout)); then
+			echo -n "$out"
+			return 1
+		fi
+
+		sleep 0.1
+	done
+}
+
 ##############################################################################
 # Sanity checks
 
@@ -505,6 +532,15 @@ busywait_for_counter()
 	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
 }
 
+slowwait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
 setup_wait_dev()
 {
 	local dev=$1; shift
-- 
2.43.0


