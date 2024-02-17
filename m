Return-Path: <netdev+bounces-72618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D386F858D48
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 06:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345CD2837AC
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 05:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6A1CD03;
	Sat, 17 Feb 2024 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="IZsqckJS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C51CAA5
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708146266; cv=none; b=b4kcHMuB2X+qBHHGcWoxVeW9O3wvYHGoizgAPXmH8U1KMqwN/CjZ97mccol6w5pAq1HnOczLCoLntXu1X/ztwwiQds3PyzM6j+aBgwhmHGPkHxyjHwYG6UpCJZOkdpx/4I2iCz8NxSr4Hx5wBS+/QeF4+PFMVR8Ru7ty+bjL4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708146266; c=relaxed/simple;
	bh=8VUFqO7uMyvWoGqPY0is7aeFHyAn4ytK3vcbIsUxFBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e686k7Vl7LMtDCFedGe4Nac8wUyuHyDFC4eCH/rjqgkZbu8cO+cTwHcbP9ErI2ehTRdsV8LVqj7+FgAhJ/SvFiQgErk8GSVqB7eMPenA5bumYiIEjhjPnQQi/xc5VKG/kaDulwj9vNpXIIl7gQ9N0785JdIUz0bgmZ83r9xcIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=IZsqckJS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1023677a12.2
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708146264; x=1708751064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15+Wstd0K/tQdqUBE0nxl8MuFaPL4ZsBE+4CamJf2q4=;
        b=IZsqckJSgqGgDUgC31kTRFRnx/aAzKHGl7PW/f41p4h2PTYy6Rx+DzYD1XwaavHRgz
         t0W+8qk14Z7sCsT+YRtpjXuvLAMhB8Iosp69Cfi5DAIbxEZlwLcV6EXeBc8ZgFVm8tEl
         S9TLj57VickXAnL22m7VOsIYMluK5V62TxK62vZW+zrzyH1XShSVaIFBpGU083tFYilv
         q5Da8jL5GmU8kjt2o2K80Wab/roMQq8FwYUHhkXMyYC6zUAGJe57o48exiuMiDK0Teyu
         RJhNnLuGgVhlO9UTwwjxb/t8+9N53vePTT5/FvT0Ufi1gJUgbdrPHOv8J5L9P9gKOs5r
         U2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708146264; x=1708751064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15+Wstd0K/tQdqUBE0nxl8MuFaPL4ZsBE+4CamJf2q4=;
        b=pp/7lrRJr9OXFXgOcWEVEgiMKKWcD/kNMUEVRCDuCs6XN9ELqkqbZlc16XG0y+fQHk
         xTjKLVUPB+Z0+9/721jrowBZWtWGp8kJRZGmKSWlreNNoXalfir4LB1tyB1B+d7Bwy+Q
         E00vO1GeHRbAsfeq/V8gFCnFB2HFa1N8cj0aGviBel6tXONEWTpt3Dz36IoZXF/h5y5I
         /iQ/P7nJimOiWJQ5KcqAI9+ZwAm8EExzoTQgy1Y/9o3O1JHYRHu1iILETQ656kVXzfNz
         aAnabYvtjb0IIl36qlAWmSbcAhhkA8IvU56VWONWtyfysV8WlxrkVKtymwf9Giv9s9hE
         0X9w==
X-Forwarded-Encrypted: i=1; AJvYcCXmzueq/z6G2xE+ZYXlLiuc6qU5GDnhTzyCDI8oSKnpL1ZT072iyg2+vX+CGHp/8apMwhY3M0l6R7IaNZuqVSaV71VG3Rzb
X-Gm-Message-State: AOJu0YyeK12WQNZcfaQlzuKiKEEmTVh27AeYmuYxdF0j9bzAMJWfQuLz
	vJXEQ4Gn3LWIRqzxBl1QnoSXWsWz4atfn11E5QxX5cyHNTWAwbJcNDthLWdpG96MvAemcbGMYYE
	6rSM=
X-Google-Smtp-Source: AGHT+IF9srCvGFY/UGP4ztg0hTzGBQEkKOe0I7iiklOxexzEjVSj6nkd5VwDA24UISFByNCCXRMLPA==
X-Received: by 2002:a05:6a20:93aa:b0:1a0:7fa2:305 with SMTP id x42-20020a056a2093aa00b001a07fa20305mr7456614pzh.47.1708146264043;
        Fri, 16 Feb 2024 21:04:24 -0800 (PST)
Received: from localhost (fwdproxy-prn-017.fbsv.net. [2a03:2880:ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a2ec300b002993743e4a7sm840105pjs.20.2024.02.16.21.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 21:04:23 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v12 4/4] netdevsim: fix rtnetlink.sh selftest
Date: Fri, 16 Feb 2024 21:04:18 -0800
Message-Id: <20240217050418.3125504-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240217050418.3125504-1-dw@davidwei.uk>
References: <20240217050418.3125504-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I cleared IFF_NOARP flag from netdevsim dev->flags in order to support
skb forwarding. This breaks the rtnetlink.sh selftest
kci_test_ipsec_offload() test because ipsec does not connect to peers it
cannot transmit to.

Fix the issue by adding a neigh entry manually. ipsec_offload test now
successfully pass.

❯❯❯ sudo ./rtnetlink.sh
PASS: policy routing
PASS: route get
PASS: preferred_lft addresses have expired
PASS: promote_secondaries complete
PASS: tc htb hierarchy
PASS: gre tunnel endpoint
PASS: gretap
PASS: ip6gretap
PASS: erspan
PASS: ip6erspan
PASS: bridge setup
PASS: ipv6 addrlabel
PASS: set ifalias 7a28dcd6-7fc3-4499-9f58-9f85d34eb328 for test-dummy0
FAIL: can't add vrf interface, skipping test
FAIL: can't add macsec interface, skipping test
FAIL: macsec_offload netdevsim doesn't support MACsec offload
PASS: ipsec
./rtnetlink.sh: line 756: echo: write error: No space left on device
PASS: ipsec_offload
FAIL: bridge fdb get
PASS: neigh get
PASS: bridge_parent_id
PASS: address proto IPv4
PASS: address proto IPv6
PASS: enslave interface in a bond

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/net/rtnetlink.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 874a2952aa8e..bdf6f10d0558 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -801,6 +801,8 @@ kci_test_ipsec_offload()
 		end_test "FAIL: ipsec_offload SA offload missing from list output"
 	fi
 
+	# we didn't create a peer, make sure we can Tx
+	ip neigh add $dstip dev $dev lladdr 00:11:22:33:44:55
 	# use ping to exercise the Tx path
 	ping -I $dev -c 3 -W 1 -i 0 $dstip >/dev/null
 
-- 
2.39.3


