Return-Path: <netdev+bounces-233601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FCC162E0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3CB3BD7C3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA034FF4D;
	Tue, 28 Oct 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTTSJAPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1B34D93C
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672610; cv=none; b=svDXT7/9JMvyAC3LVeYFZi9HGkK6ha1QY1yeq7h3MgZLpT8/tuEnw61xZ3TX1Ic2UTIVyeQzdqN3sys/25uPXK1UhtOOZeHa9JLBogiwCh2F7rljUABTDGL+kDYeUVnwOBJJZQb0etOAA11oCZHZR4Bv+Mzl4AP/hOfu2l2wf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672610; c=relaxed/simple;
	bh=SuJH3HWPiM306OrhrNAnCKKfLjQue1QzIizP6/wUym4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFKRnoi566oATV2iOKrViSSLZq+JlJXnEH9bjaI7pGZmUqgl6gfRG+MMWPWLjm0adD9U/UDm09Y5JZW4ohuxDKMArUW8J8RJQXHEqa4hTPmTXHwxG8aoLsJFoP7MXVqyqKC3aoxCZhQsKr08eHJAhjOK6EGxBSP7VrLwUPf0Drs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTTSJAPJ; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2697899a202so980555ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672604; x=1762277404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLUXKj3JdQcNGrW23cOuQo3J+oSHDUHH9EfbwIbJJXk=;
        b=aTTSJAPJynIoQg0lb3IO/0eK8p4kLxzuQSHUauj5fzlwjsenWnT4fOcGy79r33bDgp
         pDRw9SEg36LGsa3gTvPBlJvB6vf6TZO5UCOL6nZ3qx7S6JGLCJ5GBydj8mPsmu7ahb9m
         QZPBcFeNEz36G8ZMohy7YJXKqbj5X6zdyveGzB2RgqHjUoLbohV/aSuV/LLsEpWBBEMv
         d3N8Kf463x1V9hOikdJN/ZFac8CWeWQ7xc5K/8SQHVLhy+XN9/c+cHw7gDMDiE/x8Ppi
         8StagREI89fnRQklOKRCc2a2FYU+Jm0vxFAXAtIsXbwsDex5Bx1zNCCuRqqb/0awlqrl
         eKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672604; x=1762277404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLUXKj3JdQcNGrW23cOuQo3J+oSHDUHH9EfbwIbJJXk=;
        b=H1/LhjflVgavQUqXIU4sCu3vhZguePiZT381Aa8lGdqAErVGlUM0u9o7p6R3CG+JY0
         8hKMNSOKpXxkqlawTa15A4aEPnJhhWg25Ehs66geRpvzkDKbpDBw2NXFbK15WURVN7Iu
         1VLtCm5ko51S5LlRl6hUH2qeiFZ2rrKjy7xjFRGa1AgqXW+5IgIfT+JgLheMR4QEZExF
         +C53NFTULqAmEZGHmPSHkILVvMagO4UCuA/lwx0lGdW/3UDwzOa+NLLJ1oi7+yB9qJWG
         MLrsjqPzbGlBc2n+H4vxYfuM7PbqUPPL/zoZn3s8o+0jVeVjDJjepmZjHCRW5SNJ9mM3
         0paQ==
X-Forwarded-Encrypted: i=1; AJvYcCV85GuRqqA4A0JMh7vyB7ZL4AHn9lmxF4mWfVNUWh0MT4utGpoHaEjJJb+O5PCEtrApd6LfpdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynl5lLz+SPqjkqD3Vl8L+dllDHGOLzoXgsiYTipxsQPdbJKYSv
	RaJpW94YOgnLYIK1MAe8uOqfN6OqKkxW8ID4SSh1BqCwkVkh4KbfTo6Q
X-Gm-Gg: ASbGncvEe+jtX9agyAGyFfnN0cj0mhoTQzjNiq2R94hVBsXXIrRDJO9EaFaK52S1r5j
	bImuHT4X8rMYe0CssXpIMmymFUbwSXfA8WIsaFRPXjlipYq+JZ066CiZ90rLDjh3JVEc2FyZVqi
	iLgOUv5Rl8VlldWwJjOtc6uI0M/wmxQxpjrb+PWeZeTAzv+PePQJNrrCd8xZAKAhsm/sCPzl/Uw
	50gB1Sm7Bb1imGbsWXV06ks1ifR7E+af+pOc01sxPHZy95w535kL/hjU/fI/CTwBqcAoE8gErNV
	ecEbu/dLRnCs2s5UaP4l7g3QIE8i2VFOgnRpHYX79Sv+zTnv7WBdDZFH5ne+AadIhm4QBRm0Wzx
	jKxnoN74wnXfsvj7oXC8NOu0p2iuoV9kt1AISxRzwDxcNfQQzvxVw8cQNnPqvz/2sGJs2kmBFZ5
	B5dVeM0+noSw9jGrvB/vPsoubvYP25LA==
X-Google-Smtp-Source: AGHT+IFtX2DEf86QAUTfh07/RypVq+7k1EhRmR6o/ag686o7shl3n/6W/Quvmd/xiNh5jfkuDo/tDA==
X-Received: by 2002:a17:903:2f83:b0:294:8c99:f318 with SMTP id d9443c01a7336-294de7f3f19mr861325ad.3.1761672603628;
        Tue, 28 Oct 2025 10:30:03 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d41c4esm124942545ad.81.2025.10.28.10.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:30:03 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2] selftest: net: fix socklen_t type mismatch in sctp_collision test
Date: Tue, 28 Oct 2025 22:59:47 +0530
Message-ID: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket APIs like recvfrom(), accept(), and getsockname() expect socklen_t*
arg, but tests were using int variables. This causes -Wpointer-sign 
warnings on platforms where socklen_t is unsigned.

Change the variable type from int to socklen_t to resolve the warning and
ensure type safety across platforms.

warning fixed:

sctp_collision.c:62:70: warning: passing 'int *' to parameter of 
type 'socklen_t *' (aka 'unsigned int *') converts between pointers to 
integer types with different sign [-Wpointer-sign]
   62 |                 ret = recvfrom(sd, buf, sizeof(buf), 
									0, (struct sockaddr *)&daddr, &len);
      |                                                           ^~~~
/usr/include/sys/socket.h:165:27: note: passing argument to 
parameter '__addr_len' here
  165 |                          socklen_t *__restrict __addr_len);
      |                                                ^

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/net/netfilter/sctp_collision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/sctp_collision.c b/tools/testing/selftests/net/netfilter/sctp_collision.c
index 21bb1cfd8a85..91df996367e9 100644
--- a/tools/testing/selftests/net/netfilter/sctp_collision.c
+++ b/tools/testing/selftests/net/netfilter/sctp_collision.c
@@ -9,7 +9,8 @@
 int main(int argc, char *argv[])
 {
 	struct sockaddr_in saddr = {}, daddr = {};
-	int sd, ret, len = sizeof(daddr);
+	socklen_t len = sizeof(daddr);
 	struct timeval tv = {25, 0};
 	char buf[] = "hello";
+	int sd, ret;
 
-- 
2.51.0


