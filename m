Return-Path: <netdev+bounces-168776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A58A40AAA
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 18:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E14917A8BE
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C51F1506;
	Sat, 22 Feb 2025 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERDzn3Md"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D611FBEB0
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245326; cv=none; b=jwkarHBAqFQhBXkCsqM3mP7z2KjSv6MXOqAckAAWdZssZvqQxBB3V3HPDl3KdnOIMJZ0eGqPSDX7Zxix6xdFoVprK6yJ7Qq3vuymgStFAzqKHPuDHZdhJ/2P0033uC2rBTkgIXPJ8w3aWp5mynWMi1JsNzd84BHW5G3XUK5zKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245326; c=relaxed/simple;
	bh=sUY+mAD4rVfn0dOlPNKHIluujoJqqFXA+7Rn7ec1kZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipxh7PzNYDIkaqnH6RGPp6ItPyzRJP7G7HcLSh9tx3pAViBCfgg5A9zSTyBTHXgzuXAhJdnR3zR3xkxM4luo0JsadjiFNw+JeeuUNS72goC5gFRKBPRWHo1mvHvc3VShExOcz6QXtbLkm0/HFWvrU2Y0rrvtaBA5PES/EhsXOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERDzn3Md; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0ade6036aso417649085a.0
        for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 09:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740245324; x=1740850124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtcPRn+RBYTuznfR8B+d0bc0I99buE84oIwPzVN52k0=;
        b=ERDzn3MdmoGFfG4EOZ3XT4LSkFfQz/JKOCG3w/SUwSxEwCYcSvjpy1xPaF6AEIxuyF
         KVgt2lLa/15UnlOnvhHQ9zdy1rxvqUEAbfSgs3TG+8+GcMYwsM0mUUkasXVavEHkiaKD
         T5+q4ufKTVh/liG1g8CPpT0CptZIgks6OoXaslp3y2rydsYZi0kufAGO8EY1Y6HUj8Qa
         V/Txat5ootOTymJrGHrH2payG7dn451yw6gl0h6CfFnwxcKzCtGDQuztAKXtMtVoAnFG
         FrbQrZ4qK+QgNma61ofVznExBD507wR7nmO+zZNCD0K6dvcuWS5DDZ58lUPR89Ty39Oj
         YuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740245324; x=1740850124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtcPRn+RBYTuznfR8B+d0bc0I99buE84oIwPzVN52k0=;
        b=HgX0DcvghfcmwsZmvvYl7yi2MYpOGs4vCV+qSe2OqeKuKpWKDWau8TlKAdsXknxX4g
         heLOC7vkNzGWGWg886bie4qx466+4JGVLCzwRtqTlKcHXml9ukGXIXXP8ZQL6mCHCM2d
         NipS4vnTVHLNtB6qvLp3f+Q4ZKvT+7HAkesfBimAbvtDXO85FRCyMRB0SB7LZOzGGhHk
         ZjAxAUtic1vpEaAzHX/LNlEEOprRNVCOddsgqqy4KVproAgxvPYxOGGAjYardXtgW0Ny
         1U5zSDWvTOcSW30fZGV+GXESdPYwdtG9d8yMrc2IILzs3r1JZXxBHoeJHVihMnd8YG9S
         pijA==
X-Gm-Message-State: AOJu0YwlQO1YFqCrHdvLMa7dH51Z5AbbTxATXtEQufLwc6Z+teUBd7gH
	9BWqhfiTaMjl9wBcsCsjwADOO8OsM3GwuNvXNpl8gEsLnYdvUbkZsXf/NQ==
X-Gm-Gg: ASbGncvDxtO0fkPH+mUKoAZT8SyM/NOR2ySyB5FBPbXJkNKaIitu1jyEp9oqbIp6oHL
	3sjdl+59cPjDqR8yMrAKoLimkz1LYmixuNCXCPYD8ZdlvLCniV+Ld5JuVrWiT+uvnjww56VGv6D
	3X6jRfslYl3QFIG12zpTwaVFTBh51OAgZ4SLxZT71A5mP+c9xWWJl2wGFrMkRC/Iih6EkbLYNtu
	PJB28mJaIS552Syxm5JM48f6d2zdYSz108GomsWP1G77wS7EIQpgkNy7tDnKhOkA9wLdXmb0EKb
	Jo0YdTZFUSTC2s6axgxwmo08o3egSuSMiwcTrqeSyleF2ZnmWOt9uvANiM5qZwVcZIClVG9qxQ5
	+eMhxVz00J446nj8ixwARUUhnfQ==
X-Google-Smtp-Source: AGHT+IGxU/yVUSaS/NyHI1gfTrganCT362QBPTytYsmsnLLPG4npE1J6GN4sJoY77kiGViGtG+4rHQ==
X-Received: by 2002:a05:620a:1790:b0:7c0:a5c6:ba19 with SMTP id af79cd13be357-7c0c218f469mr1703110785a.8.1740245323904;
        Sat, 22 Feb 2025 09:28:43 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77920csm111119606d6.15.2025.02.22.09.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 09:28:43 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kernelxing@tencent.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] MAINTAINERS: socket timestamping: add Jason Xing as reviewer
Date: Sat, 22 Feb 2025 12:28:04 -0500
Message-ID: <20250222172839.642079-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Jason has been helping as reviewer for this area already, and has
contributed various features directly, notably BPF timestamping.

Also extend coverage to all timestamping tests, including those new
with BPF timestamping.

Link: https://lore.kernel.org/netdev/20250220072940.99994-1-kerneljasonxing@gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Sending to net, following recent examples for MAINTAINERS changes.

But note that the BPF changes are only in net-next at this point.
I can resubmit against net-next is more sensible.
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ac15093537c6..c92bcd02049e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21923,10 +21923,13 @@ F:	sound/soc/uniphier/
 
 SOCKET TIMESTAMPING
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
+R:	Jason Xing <kernelxing@tencent.com>
 S:	Maintained
 F:	Documentation/networking/timestamping.rst
 F:	include/linux/net_tstamp.h
 F:	include/uapi/linux/net_tstamp.h
+F:	tools/testing/selftests/bpf/*/net_timestamping*
+F:	tools/testing/selftests/net/*timestamp*
 F:	tools/testing/selftests/net/so_txtime.c
 
 SOEKRIS NET48XX LED SUPPORT
-- 
2.48.1.658.g4767266eb4-goog


