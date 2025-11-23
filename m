Return-Path: <netdev+bounces-241018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF372C7DA4E
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 01:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C873AA8E4
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 00:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D491F2BA4;
	Sun, 23 Nov 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="HmmNLFUp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAA1A9F90
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763859075; cv=none; b=bRiaetH3egYquc8Y9lJvZNYO2MVcIUOaZRkqeBXbUCjemlVAamC6m+eoqDAlG5P6yvG69DKDI32WEJz5Fkfef3IsYv1qUVV1KOG32q6xDLPTr+VV91iXM8NmANgfa4Yk+eKtpDvD/yTsJFbwgssggtnmMD8HBbeX4HRBfkshLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763859075; c=relaxed/simple;
	bh=k/40hItTu+AVHphEDoVoxbwwzcGksFFhdnkWFkQcuhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG9bvUr+cq7b1mUhCWfvQeQiGUPqGCCIyccWTxWtQMEIjUvT2xyEG1L90d/PL/ojnnOxaIhwmQ1uKKpX50PSjJ5qNOt7PYfTQxndk438Tc0AfDrIDb4iy+FJcMy2oGrdNKsOWO4rxYFAnjfQ505HSHAquWep7LAC5Mk9IyRlbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=HmmNLFUp; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e3dac349easo2382331fac.2
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 16:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763859073; x=1764463873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wVGbOx0XVIr5Jh5Xq6Mn5vIWn6tO+lNzHUh/FP/O5I=;
        b=HmmNLFUpFmGMrySIeHB23we5vaOd5wFSpKmhxS6L9inWnDKIl3wMvT1umN6Rlg1XmP
         UXj3RYdBKWNIPEUt1LzrciUltE4IIgnw4eN1xiVXOrEse00qWjalDe8LyLcy0JSx26VL
         H2BOjasnaDI55yLy2Do9Upf33Urh5kZOUgSZ77JTjTjwxCfFdse9WwH6K/ZjYN2xQa4y
         +OBeeB1luJOJS62awBEqHosIpUVNXoWRRlTWSkikuaA9FOh4+EMpyaa3gzDTmyqMq5+w
         bQzf7R+c1RdWMQSx37tZAwtP3aSLCIm87fkOCUmmfNDFL+zA8njpxAJZFwyff1mt9kcG
         ua4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763859073; x=1764463873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0wVGbOx0XVIr5Jh5Xq6Mn5vIWn6tO+lNzHUh/FP/O5I=;
        b=xEw7YrMjyuSOw0yIyXo5N/Xyh4rEJoMneBCa8C+RFZkJ4zzeT9uIJBtZ9u2vY/GaAk
         b5CS8t2S1IWefiiBRqk29qzseTw0nYG8oRX3bZHW89IfiCl2g+n4mazjp3OYoRQ7/Gay
         4muiN7SBAKiMLP30bfsIk6vP0L/4nWtOR2+FTOzYPrZyP5MvDTS8BRmB/o5dezDznhIw
         5EDjAhE+xyfd8ZqIsisU3ezx8QLHux7fEZoQ8iZ8PWiFhfT7+aYCD+9guHOOsBn3zY48
         /e3rApzGgHU1CJFlTikDkswC5lZuH1XxLwYXxza2ela6UKyo2d1zWavSoLXiIiayARus
         +J5Q==
X-Gm-Message-State: AOJu0Yy/zVL0HPyDHDPTLJHVGAQTAeT9u2eXRiRAX2jY8tZSbb0DIdcq
	W9eMtHMd2bRmoEinGp3TNeyFOji0KsUtlEP05iYAIZE842qaNOZgmvPnHjulDSX2Y0uPSuTb9Z4
	so7bo
X-Gm-Gg: ASbGnct2EPVzy+KEJZBb0glKx5V59F35YbQ7xnsb7gfIhP6F7iI8gfSM9dYSej3escF
	Gd5LuO1JFi/uk/ZwfrPiIfljWfD+iXtrWF2zo3CnK8CLMkFvWpCrcq+XfIQnTzfL5zZQsDauRgH
	d1IGlxfmy/fsQihiMs3apS6xbGCnF+d+XffEMbwDOBFp3qJdwkWY1IbmXwewQvBH+ZXDtFbxMpM
	hh4aKuA/wW/+LyfLDgdMuiUC2k/NcRYM1I0uG7kPx4ssQebcpVkQnHGUnSgh6YQiXVfbEv6NvLp
	tAGnoLySRJE5rnNIstJTRFkYLR/zccDhBc3qtmkUeYoFEmTT2bJBkZB2oB7Q6rhMiwC47A+Whyu
	/1Y6JMplAo01+odLP5w53tZydTuo/SEMUodA0IaukNSDoNDhSUwXWPr4tmDE3j62tmI3I2+XQa8
	XsIPlg63OJlIJKrsPRrIUQX63azbhHnkZ4X6FBJ7KINNREgwLH+0c=
X-Google-Smtp-Source: AGHT+IEgMzVqMpIptC4Rz2ZPSgEGe9wFQRjUY/XTFwOUdU8/TdY1X+HZER9psXioO3zTBwINqE/6TQ==
X-Received: by 2002:a05:6830:268c:b0:7c7:8922:ef9d with SMTP id 46e09a7af769-7c798f66bc4mr3517397a34.7.1763859073269;
        Sat, 22 Nov 2025 16:51:13 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d32cbd9sm3845121a34.11.2025.11.22.16.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 16:51:12 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v2 2/5] selftests/net: add bpf skb forwarding program
Date: Sat, 22 Nov 2025 16:51:05 -0800
Message-ID: <20251123005108.3694230-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123005108.3694230-1-dw@davidwei.uk>
References: <20251123005108.3694230-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nk_forward.bpf.c, a bpf program that forwards skbs matching some
IPv6 prefix received on eth0 ifindex to a specified netkit ifindex. This
will be needed by netkit container tests.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/hw/.gitignore       |  2 +
 .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
index 46540468a775..9ae058dba155 100644
--- a/tools/testing/selftests/drivers/net/hw/.gitignore
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -2,3 +2,5 @@
 iou-zcrx
 ncdevmem
 toeplitz
+# bpftool
+tools/
diff --git a/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
new file mode 100644
index 000000000000..b593cd6c314c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <linux/in6.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+#define TC_ACT_OK 0
+#define ETH_P_IPV6 0x86DD
+
+#define ctx_ptr(field)		(void *)(long)(field)
+
+#define v6_p64_equal(a, b)	(a.s6_addr32[0] == b.s6_addr32[0] && \
+				 a.s6_addr32[1] == b.s6_addr32[1])
+
+volatile __u32 netkit_ifindex;
+volatile __u8 ipv6_prefix[16];
+
+SEC("tc/ingress")
+int tc_redirect_peer(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct in6_addr *peer_addr;
+	struct ipv6hdr *ip6h;
+	struct ethhdr *eth;
+
+	peer_addr = (struct in6_addr *)ipv6_prefix;
+
+	if (skb->protocol != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	ip6h = data + sizeof(struct ethhdr);
+	if ((void *)(ip6h + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (!v6_p64_equal(ip6h->daddr, (*peer_addr)))
+		return TC_ACT_OK;
+
+	return bpf_redirect_peer(netkit_ifindex, 0);
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.47.3


