Return-Path: <netdev+bounces-242704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69EC93D74
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 13:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5DD3A6A05
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3541730B513;
	Sat, 29 Nov 2025 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMCoC0Ks"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92E261B6E
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764419078; cv=none; b=Y+iNVggeNmzIyBorVZdQ+ibeAyn8rYX807nmbDi4WSKrabDSaJKeCYbSEM0P3JT0+lVTVKzIpTGRqpc2hIiXRN2QF1Iky16byWJl29BCnZq9QPyT5qNXFbY7/2WuUXQWmwUUN7tqBzgI5eXW6YbYU3J3ajiIgynrm1/s0ZaNQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764419078; c=relaxed/simple;
	bh=j4M3sD7us3SFWkNnnn8dW+s68JoCxXMcwwPqxafnGfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a+9SntcbuKuyMhUJstKxLuC086nb2FeT9arEmBQDlbw+mnttN7LF0aKlf5xBH10YTGJxT1tUrNdcVGAAl8cbuGNdNeCCgqTT+rRdHi0Amv/8YE59LLdfDm5faITalncahqTml/9S9MPBf/Do0aIdIiwo80DI9txNKpAEFUKjMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMCoC0Ks; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b553412a19bso2283202a12.1
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 04:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764419076; x=1765023876; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IAHXxP0perjKgqVFHaakct3L+cU6WogaBTck7Ta/YA=;
        b=kMCoC0Ksyelru6n5qEFSQ4h1NRrjozO5cjoHZ2gY+E3f3DnHr/0lX1+DwDamKsctTk
         nCr8lwmu9p4+ZhzWc+laGDjum5X1v+/uIxtNcfnW+airsSbu+gOlFkq+YaQ1CFzVblxa
         FiELlD3IajwzLkiQ7bfgmgGEp0eegoP3zTTo7I3rzPn77wApDaW7vcRQIVmOmtAC7PJk
         W/gTKszWwxPyVwiMWkZ6zWyA4JoIOKYmVdkaOG3C6a9Uqm6+lgUABOTXEe+LHhKevwCH
         3aOAxoMKG54L08fhGcqjAIC3R5jJyIZTZkq4ovFueZgOKFJiCY9mgi/faEZKIdStDBTC
         G+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764419076; x=1765023876;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IAHXxP0perjKgqVFHaakct3L+cU6WogaBTck7Ta/YA=;
        b=qL73WqPufhUVrpLio+ERQy6DqvYgomiWgTfbZqRHQF7Lel5EzPi4WfsiMz8RnSSMi9
         HQWxe6iDcwvYGYw6D5TVkomxSUysQ02JbDSc3rQES+F9g/ZCWebLGefKB8vfgqquvFmj
         b6crKzxb2cUOlGolWcMvii+NAb4DzQeZoQGSz+D3afDTWYmSfAT8x6M488EVtp5lgqE/
         xLGt1jAOus9xO8A9jRof9zCoQ7EPZdLBG7/ExFb31ZlPgog5FTVTi+kqSUCBI8mmgd+3
         ox2aYaAhlYRzNNwCJfJk0/IQrsa8QtzgQf7pahAynvlfWqAHHyHIHqie3tt+Emif6KFK
         FzuA==
X-Gm-Message-State: AOJu0YwNDGohxGaUXIlQvAWS+wLFAdThN7pWi8AbGvq4V8ABQXFhyTYk
	lRSb1OV6m59jEZHoNFsKv9i1pKHtSyqZZnYXWhA+16D2k9BC0il4dAaPbJ+usODxMO6xTw==
X-Gm-Gg: ASbGncsc0lhw024gpzw2UijJdxT9iQRsNzT5PAe7ynmlNa31nv7ZnD4DBPeWMi1n67K
	3SPv3muv02IYJSo4SQPKrSGs7dzXCfW+V6kdvnZA12ko+osD63npxdeaxVZ52MpF3pxqF4Nl/ly
	QrqWkivrLbXV97a2bZ5EH9FnHQ3fI4Z3lGCVRhH4AXjls/UgwT/YlI4GIsk9GS3w9IPNvqpYzHQ
	ng27/gWR5p/rWEyHEOqoEa5u8ht1HerTJWp90y4OU3wbjRdZVlvADeUR8TOm1ETIzselH5R7iVZ
	miQxN2WdJUOpwc4rkJJZI1fReBJGkzxKq8LbCfSPwveW/sDtPjvkJInhGHtLFGE5vFcJijXoPqr
	bsyE1s0bxPSuLFTQTW5MorpVZZACXWPp/co7K2TVCWbIP+LOjkeffpmq/VOKojpu1OgsV/91qdO
	VeBp6uvYLCK9lyqPSanA==
X-Google-Smtp-Source: AGHT+IFqqjQCrjafBGerzux+bnYn0h6zaVMzfv/X2v6ipqlNqLmeskBvtmHH6TaypCX1w0aozzuKew==
X-Received: by 2002:a05:7300:230e:b0:2a4:3593:645c with SMTP id 5a478bee46e88-2a71910598amr20080944eec.12.1764419075780;
        Sat, 29 Nov 2025 04:24:35 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965aafd17sm26059595eec.3.2025.11.29.04.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 04:24:35 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sat, 29 Nov 2025 12:24:19 +0000
Subject: [PATCH net-next] selftests: netconsole: remove log noise due to
 socat exit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251129-netcons-socat-noise-v1-1-605a0cea8fca@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPLlKmkC/x3MMQrDMAxA0asYzRXYhjSkVwkdgio3WuRimRAIv
 ntExz+8f4FxEzZ4hQsaH2JS1SM9AtC+6ZdRPt6QY55Sygsqd6pqaJW2jlrFGGPkmajkZXpGcPl
 rXOT8X1dw4Ojs8B7jBp0h7yJvAAAA
X-Change-ID: 20251129-netcons-socat-noise-00e7ccf29560
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764419071; l=2303;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=j4M3sD7us3SFWkNnnn8dW+s68JoCxXMcwwPqxafnGfE=;
 b=fDjLyuauUZfyqZFtv6U8FQeGA4GFqfX5kDx2fHj4giInAyCTbTejxvoXnmHfc9lmAuXACbG73
 LpnU8hvhGW6DyL6uHFxqnVoEW+VhFPzqOpM6HU4IpA1EcQevvxvKoOp
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This removes some noise that can be distracting while looking at
selftests by redirecting socat stderr to /dev/null.

Before this commit, netcons_basic would output:

Running with target mode: basic (ipv6)
2025/11/29 12:08:03 socat[259] W exiting on signal 15
2025/11/29 12:08:03 socat[271] W exiting on signal 15
basic : ipv6 : Test passed
Running with target mode: basic (ipv4)
2025/11/29 12:08:05 socat[329] W exiting on signal 15
2025/11/29 12:08:05 socat[322] W exiting on signal 15
basic : ipv4 : Test passed
Running with target mode: extended (ipv6)
2025/11/29 12:08:08 socat[386] W exiting on signal 15
2025/11/29 12:08:08 socat[386] W exiting on signal 15
2025/11/29 12:08:08 socat[380] W exiting on signal 15
extended : ipv6 : Test passed
Running with target mode: extended (ipv4)
2025/11/29 12:08:10 socat[440] W exiting on signal 15
2025/11/29 12:08:10 socat[435] W exiting on signal 15
2025/11/29 12:08:10 socat[435] W exiting on signal 15
extended : ipv4 : Test passed

After these changes, output looks like:

Running with target mode: basic (ipv6)
basic : ipv6 : Test passed
Running with target mode: basic (ipv4)
basic : ipv4 : Test passed
Running with target mode: extended (ipv6)
extended : ipv6 : Test passed
Running with target mode: extended (ipv4)
extended : ipv4 : Test passed

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 87f89fd92f8c..ae8abff4be40 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -249,7 +249,7 @@ function listen_port_and_save_to() {
 
 	# Just wait for 2 seconds
 	timeout 2 ip netns exec "${NAMESPACE}" \
-		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}"
+		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}" 2> /dev/null
 }
 
 # Only validate that the message arrived properly

---
base-commit: ff736a286116d462a4067ba258fa351bc0b4ed80
change-id: 20251129-netcons-socat-noise-00e7ccf29560

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


