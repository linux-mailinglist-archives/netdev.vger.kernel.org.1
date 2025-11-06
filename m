Return-Path: <netdev+bounces-236418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA2C3BFAB
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 497E4350CB7
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A5757EA;
	Thu,  6 Nov 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qkhvh0vr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC791DE2A7
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442136; cv=none; b=c1PWWbaFwEiV6hPoe+mZcYcl/LYF+GQ71pSxhiu2EfMCemHXimWmakh7O8ssXqhlN5FK26H2dnNzzv9yRXZIul11blrThN/xOARR3Ci+sgNVu7fcD12qxYHl421NbMQ7Wx21+2kZZgJRRlv2C330WaVU0V1x+Yl6pnUW5pMZOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442136; c=relaxed/simple;
	bh=YCH1EG3tt6Ke2Oavsj6zZ3dcJOSXiNwQWjtiAGf99k0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0oIgrW+hMCPk80Y3eY0XHOuXlkjN/yR8w3gwGyGF4C8/DZoP9npZ4ed96mhAoFW/r8IUV5ntikeJh8G+9KCP4YDQewZd3o4EUCoZ/FIJsIe8xSyHRttlqJVRxT3yFWpYiKT7kWBoZrbk8fwo/YVbRmHZIhz3tudvTG8yVAej6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Qkhvh0vr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640b9c7eab9so1769188a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762442133; x=1763046933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xxC9fYFDy9HPyk/qMyaqjf34tGPt2OGl5fMO+3uhfEU=;
        b=Qkhvh0vrllXO3d7WnVuU9lUmYobGtyFMjZcdmEJFCG2fd/CKhOe+dSI/y4aKNl/QmF
         lrWpccAshveGDcCsPlGuMtGrajRrgtysVqDkI2134Geihwt9ZueUM4+Y3lEwLaeRe8zG
         OxSABcLsxyME5Gnb0opBpkEwULoU4j6U5KHEpXUrJni8/N7qNIjhDtXhT0cqc2uVaubl
         Oh2KA0xPRKzGVMbAYDG7BwAxKiAmsS8/AgIjJCcXBEthEUI8oK3ITxwWsFaxD9xYEj6c
         wrM/Lcygnt6jxgQ3pyVGoANlbG0gsMrIio5rnHeTmZiAPJGaQBd08YQxN6O5YDTjDbz0
         mNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442133; x=1763046933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxC9fYFDy9HPyk/qMyaqjf34tGPt2OGl5fMO+3uhfEU=;
        b=iQm2U8/d/JKZBpDHY4M4Zvva/dyUJjP7js5/i+i8VVL1IkhvZPIh6FwgT7Q01m+SYw
         zMIPvIpQD1o28VIM8ePyqqmo989IKQqA0oS6XocMQUmOHwipUx3snc7NEB4QLgYfDX+d
         xpumtqEtDNonYeDecJn+LN4C9yLG9Lk96r2QGfl3Gx+NbfeUli5PxXH2wErR6oMVOCBj
         SgXEBcdS2OiP/03ClHC1T2hl6VyT4tNFQbm8Asz4fa/Q4IvW1iRzzz+SDTcZHLXpwaBt
         JdVwmIakYh5AYmCuuEbTO9YR0pvcfFO3+39GFiggC46oIVkv5/xTuGDAYLYzAzHpktRw
         Cung==
X-Forwarded-Encrypted: i=1; AJvYcCWDzz4FMCqZaIO3QhgiAVBWfi/mPI495OCHjdbgZv13/ywjkjErSfAzOVZcaJYCN0OnLhkfxbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWWJ8lIjS7ULAni3BDHAlRGDytXfPZ3sUhPaRnu0ZzWB/RD9+g
	a249msnCvFW0+oAvTqBZEALBX/JRD/e3jChLT/ApRSG0bbImYmxe6RLV
X-Gm-Gg: ASbGncs79rLeUdA0Y4ZAy4GsazK7ZscUYmwPS5C9pWuB9bE9kYGAMBc+3AVi2WB2CjM
	NUkAOVGRZoOEMzmDHqBlJyjUlodLHTG8mL33UtoIVzk/NLSTTOzGHu5k0vUEuukjBRnArEksLHr
	6ve++mANMMpskW9TJjaq223T0MQk8UsUgImHoWU8j1bEyuj3RGistwVgjvCuZkbpbtSMVRw45WN
	Z1keC0nw7njwkjuJL2d2uYWEfclfdGW7P0yQFOejnk7dRsvbbrm/fT2CZVXkMc4xQdR5B1jRJUo
	QMKoGVi61Fwp1UwiSRkTNDxcXyUghxinAiv7Ga121dc7Lkn22gnuQnDuBKviJQ7sRxOQ5qk0jut
	vscaWm7SvseAd2aKETIMeM7BKI1qlpNvZQ7LpupEpdWGCbzQJwxAFgQYaPp86EF3hRPG+Qo3Zcz
	MuqUaq51IJcRPvJwPnU1C6oTlxg5ijh5b0ZHumZVkhKUeGPpAfqE3eas3R6BOasQQ=
X-Google-Smtp-Source: AGHT+IEtDUMQY5HbJRJaUWD2C2rmPOt9GG6lcJ2SU4+nYohRujdB98Ocz8yMiCx6o+ye58Yh34/q5Q==
X-Received: by 2002:a17:907:930e:b0:b72:a30a:e8ea with SMTP id a640c23a62f3a-b72a30aebe4mr237427466b.57.1762442133091;
        Thu, 06 Nov 2025 07:15:33 -0800 (PST)
Received: from tycho (p200300c1c7266600ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c726:6600:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c6f95sm234012566b.64.2025.11.06.07.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:15:32 -0800 (PST)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH v2 0/3] ynl: Fix tc filters with actions
Date: Thu,  6 Nov 2025 16:15:26 +0100
Message-ID: <20251106151529.453026-1-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch in this series introduces an example tool that
creates, shows and deletes flower filter with two VLAN actions.
The subsequent patches address various issues to ensure the tool
operates as intended.

---
v2:
- extend the sampe tool to show and delete the filter
- drop fix for ynl_attr_put_str as already fixed by:
  Link: https://lore.kernel.org/netdev/20251024132438.351290-1-poros@redhat.com/
- make indexed-arrays to start from index 1.
  Link: https://lore.kernel.org/netdev/20251022182701.250897-1-ast@fiberby.net/

v1: https://lore.kernel.org/netdev/20251018151737.365485-1-zahari.doychev@linux.com/

Zahari Doychev (3):
  ynl: samples: add tc filter example
  tools: ynl: call nested attribute free function for indexed arrays
  tools: ynl: ignore index 0 for indexed-arrays

 Documentation/netlink/specs/tc.yaml   |   8 +
 tools/net/ynl/Makefile.deps           |   1 +
 tools/net/ynl/pyynl/ynl_gen_c.py      |  14 +-
 tools/net/ynl/samples/.gitignore      |   1 +
 tools/net/ynl/samples/tc-filter-add.c | 308 ++++++++++++++++++++++++++
 5 files changed, 331 insertions(+), 1 deletion(-)
 create mode 100644 tools/net/ynl/samples/tc-filter-add.c

-- 
2.51.0

