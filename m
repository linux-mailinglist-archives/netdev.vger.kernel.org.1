Return-Path: <netdev+bounces-68898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B972F848C45
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 09:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1089C284766
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647B1427A;
	Sun,  4 Feb 2024 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0MoUBAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B114A84
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036706; cv=none; b=Vs7KJqXsCI2M4CKrmUQZVi+nnhfHwd/yFCPo9ZvKwPMbfdx8XEIcnNR3uygjuI7XlTWsL/EszzLLw9t1CxxFv8evlMFq5VH4fp2jOe2v12G1TD3ak1huprYh1e6lKDK98kW25MdUnqq223hyZYLn38EGPa5WoObFrdRdPU5/wRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036706; c=relaxed/simple;
	bh=KDU5Sap9KmERo+IOTSOxwD/wM01vjxr94Mz5wDzVw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6q+eGx2jH2ixg8OA/mCT73MSnUY4Viz4pgZimzq0kafGytFgz+vxVCpWUGPckSz6cpFWqs2E4jGwYVomTLmi22f/oYrBFJgrdkaQNOdIZnPCoAqRbUtN3XjIL3CZq1sIq348TjEKGfbIg+ViTXYhuLh9g9MaSwGPqNxbWwrNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0MoUBAp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce942efda5so2989745a12.2
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 00:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707036703; x=1707641503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7f+YPdLV02rXa/1f3nKaHnsp07nRY0/vdqPS1EubdSo=;
        b=J0MoUBApKW2mNnC1Z3AIL2iEQFgSjOowIpRhs4kxqxRAOk9ITzf9EBUqt0tGIL07Y9
         X7XGn+mhivnnzk29Q+Zy93Ll7vjCKo4rBjPG7QoXmzTAsmjvsglhkwoJ3RcYizYuac8t
         qZd8NR56g2GvRUBYInRlfXnsqcL9syZdHtAMi8N7UdIEIr9lhIRvpvUu/4c5hykm6ppw
         W6SqVB/chpdEIVZIIg3QU2Sl4lL0kUQHmkthyRJGCzQCZh0sQuB4xV4aLbO6hIABhBBz
         3JHBnU9aZRWUzQ5a+AHmGJwMn/HeAnUoAqKkNVndUzyeIZ9sM6xitlxGSB9lsJrra1fp
         qMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707036703; x=1707641503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7f+YPdLV02rXa/1f3nKaHnsp07nRY0/vdqPS1EubdSo=;
        b=PyGTSJE75qqFPFmYZL0Nq9vefX2Tgq9u7Xl4CN1iP+3iodEkQ4mndBH0tRNIMS1w2q
         UTS2q04wZszQ8qGGb7XxWZBRQ6uaxrCF10G7skPSIYPo2y5MsmDXSR8lPJr1D/RJF/rG
         m/o9DEbA3RA/1Vldi3Fy8VHvb7xpuS3+bPxgDbBmac8X+8txK1zgi+1gMqyrrMyuibsk
         aBBznX80IanE9mzoMbvg3mu4FgS4DT25HUUo/o5qrHA/RnDPo9zqbVuJ9Na7VdcB1yb5
         6xH59yLxOVp80Yo3Iq0mlFXKBnD4MVbFW2Ga2mXTqQ7XJvfDtQR9BUK8oqo70jub2nYZ
         ChIw==
X-Gm-Message-State: AOJu0Yztdr9aQanrtVLxYvhTRU+Tw8k45Dij7pEP8Qfq0tRj721hiXM/
	YsQW7XBUtJMS09E0G30HcB0kZ8E229m6L2CnvtbOiMs6teBwRnbiS0uzukn4QBYAMA==
X-Google-Smtp-Source: AGHT+IG6i24AD1txlGWx6h1I5GekDlSUfWp5Vqr5uBRu+/O8nyZwOM7Vfk3pB6ZytpKDg3aUp8JtKA==
X-Received: by 2002:a05:6a20:9592:b0:19e:4790:25dc with SMTP id iu18-20020a056a20959200b0019e479025dcmr11588978pzb.60.1707036703563;
        Sun, 04 Feb 2024 00:51:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSVB6hbczM3xkr1lx8CMvgDeBsaxgJBf3YOBMwj2MU3gntq19PWR7sb7mWHtXopJhBqhMqWvnWO1PObtsz3jltSiqANm+VnRHOQOsr7C3llstTD7C5uiAjuxtDu2h3GSe99QMAuBmF6Qupcumi2OTCGKigb66YfLtt1vEuLrUE/pkgVLPVlD46vgUTWVB9bCdf5dfcjW5h8ZGMS7MDAtK0oBr6WSDLuM8KmwgBb0IY0AA3LRn89OEpJbTkw2nKROkaHA==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ka39-20020a056a0093a700b006d9b2694b0csm4398228pfb.200.2024.02.04.00.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 00:51:43 -0800 (PST)
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
Subject: [PATCHv4 net-next 1/4] selftests/net/forwarding: add slowwait functions
Date: Sun,  4 Feb 2024 16:51:25 +0800
Message-ID: <20240204085128.1512341-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204085128.1512341-1-liuhangbin@gmail.com>
References: <20240204085128.1512341-1-liuhangbin@gmail.com>
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
 tools/testing/selftests/net/forwarding/lib.sh | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a7ecfc8cae98..db3688f52888 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -37,6 +37,32 @@ fi
 
 source "$net_forwarding_dir/../lib.sh"
 
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
 
@@ -478,6 +504,15 @@ busywait_for_counter()
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


