Return-Path: <netdev+bounces-238451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B2AC58FDD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847ED4A39F2
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5843559CD;
	Thu, 13 Nov 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2dNwiVh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526A33DEFE
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052150; cv=none; b=kXPnRGq29bZkUlXwbs0EamBkKAbLQqzn3SIXGJxzcdD/gZPh3X6QOpyHXnbt+uEc9fdxjViuR2mG4ZXCGl2b6W1eA//rrdFaSqueXY+Lj2jcSWioAeb4p5/bNCsQLocvFWfI09xK7b5ZdHB3wl6SPga7nHMvc45lZd1bJhEVDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052150; c=relaxed/simple;
	bh=lD7uKF4a/ewK/luXx9qr7X9aeCw/M0HmweHz5Mq9Qrg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FrnhpszAGMf8CW9pF91Ww9w1mky1dPTArmP0m7iYXPwU/tFcZr6voDfMviqj0FxsNBb6f9eKBiRdjpdx1fBpZkEp+CqS0a9AWCLmE0wp1stlzKtxnPXbuzvjjMxBH6dAwVnyaNKVZ49mWsjp+IwNks7qH6jd448V/PhTq+qCE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2dNwiVh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429cbdab700so121436f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052147; x=1763656947; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1iPrEVkt5hq6iKDIzwWz1JLhZGrRKwp4Km+TwvoaLw=;
        b=D2dNwiVhy+mUgtHvd+YgQq0WZVjbQaIlIyPr/zZZLBhw7I6BljtpWdruZjlY12tgLv
         UbmebPhfR5p91qeL6c02aKbYCqnWEq38L/fJTclWOF0gOsVR8ELjzwvGOStrV5VYTkjG
         Rbt03Z+jAnZsgTTP4KoORc8vRhALunufu9A8/wKoI1Ap9UN6P82hN3KXMd1GQKR6ROTk
         EuJwBkFZMvZdxFvGvIjcmpC2R6iTCdfheRlNqqBXCSIo4UFyiYbNJOup6n8/jB2TNUXg
         UvTGanMlJqMJgZrWO6eu/IjnrUcVR6prLIDaPVLjZUoMxcc2zF9S2UyE7zzjjsFlBTfb
         GOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052147; x=1763656947;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1iPrEVkt5hq6iKDIzwWz1JLhZGrRKwp4Km+TwvoaLw=;
        b=GT7bHn6/yfuCQYOijy7bmR9zKhHd5JnGjZQaWgQi13SyBjbCBxWtMKyATc9xWXNaCb
         e5aAcVQUbacDOiVTzuNfa1YDrI+lFXcBX0KXIEEkXD2nknn7DuIbnXiEqlEPbkX7rgo7
         u5r8Z7vHKv7Z7NnULrk+J6Z+/rCfp9EZx/KOdGDR78YM+nnUZkfgDKjZ82SJ2t8YAEN5
         gRZdGvO6VoJjXyg1H+JlcFzGiderR6FJlDytPQ31DrbXDHlVgikLmRIVRnrIFrvA+EuR
         2b5DY2LbV82tF7U5wnMPsnJZZ2M06crOozRVtdHEKfL7U22YrgLjVbgez6MteiqYvNZt
         INIQ==
X-Gm-Message-State: AOJu0YzwOQzdRchw+MI0kI2IbkzWEe8if1HjIm9VmjwUCcOI6oEBp13N
	aDTrDzt7cfKIphY4cwIRrInVdb8I7cMNf4skIwA1+P2JoZXWn1K8FEbk
X-Gm-Gg: ASbGncvZWJCCZN+qq/RYIvGZ3JaXUglzrHm4H9ZCo34Sg8BTHmjawXarnNCLSBtf2U2
	VnQ3H2o0h0tdulHtxcwNGzs2chXntGdOpCS2LxeSAuhJRh41ouGM9I1FBkh5WwMSV5BEuTJHXXy
	+0GDejkzypaR3Twi2QtKvNqgbzs6bpmvaAaTs65OgazshuA9+iyipliNeebM6/0L7QBH7IjvM/l
	jhj0A5FB31tCtT1JBhAfwQKX6xNNhSPfq55zuaY4GYg9ruosx1uRp0Fq+7iI31UHaG08dwzQdSn
	zfmfz2UKazl1ALfYnfzfJ9nnCCHWwLApras0DWRYZzQPO7S27Z9xkENm7nJbfy3behsB7Xb1vRh
	GAyGUjn0sRYTeWYgcJ8OAPyrGIliO5iQqsv5NWg0evl6c7QZzDgODo/ye5h/ZpsK8+i+/T3R7G8
	X7CFWz+H6jdMeKMZEFvRAeNU/Szw==
X-Google-Smtp-Source: AGHT+IGclhtkVC+SQIwavEUnzhQXgeen+aHzFX2HGR9pvr4YinanB82JsLHIPDaDDzl6c6Ni7eJakw==
X-Received: by 2002:a05:600c:4706:b0:477:7bd8:8f2d with SMTP id 5b1f17b1804b1-4778feafe3amr467895e9.8.1763052146552;
        Thu, 13 Nov 2025 08:42:26 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778f247821sm17578525e9.5.2025.11.13.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:42:25 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next v2 0/4] netconsole: Allow userdata buffer to grow
 dynamically
Date: Thu, 13 Nov 2025 08:42:17 -0800
Message-Id: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGoKFmkC/32NWwrDIBBFtxLmuxa1eX91HyUEo5NmoNGiEhJC9
 l5xAf08XM49JwT0hAH64gSPGwVyNoG8FaAXZd/IyCQGyWUlOG+YxaidDe6DozmsWkmPuEevjIq
 KSTGZzjSyruoW0sXX40x7vn9BMpO9RxjSslCIzh+5u4m854Tg1f/EJhhnopRtx6e57B71c8Wo7
 tqtMFzX9QMD55JW0QAAAA==
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The current netconsole implementation allocates a static buffer for
extradata (userdata + sysdata) with a fixed size of
MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS bytes for every target,
regardless of whether userspace actually uses this feature. This forces
us to keep MAX_EXTRADATA_ITEMS small (16), which is restrictive for
users who need to attach more metadata to their log messages.

This patch series enables dynamic allocation of the userdata buffer,
allowing it to grow on-demand based on actual usage. The series:

1. Refactors send_fragmented_body() to simplify handling of separated
   userdata and sysdata (patch 1/4)
2. Splits userdata and sysdata into separate buffers (patch 2/4)
3. Implements dynamic allocation for the userdata buffer (patch 3/4)
4. Increases MAX_USERDATA_ITEMS from 16 to 256 now that we can do so
   without memory waste (patch 4/4)

Benefits:
- No memory waste when userdata is not used
- Targets that use userdata only consume what they need
- Users can attach significantly more metadata without impacting systems
  that don't use this feature

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Changes in v2:
- Added null pointer checks for userdata and sysdata buffers
- Added MAX_SYSDATA_ITEMS to enum sysdata_feature
- Moved code out of ifdef in send_msg_no_fragmentation()
- Renamed variables in send_fragmented_body() to make it easier to
  reason about the code
- Link to v1: https://lore.kernel.org/r/20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com

---
Gustavo Luiz Duarte (4):
      netconsole: Simplify send_fragmented_body()
      netconsole: Split userdata and sysdata
      netconsole: Dynamic allocation of userdata buffer
      netconsole: Increase MAX_USERDATA_ITEMS

 drivers/net/netconsole.c                           | 370 ++++++++++-----------
 .../selftests/drivers/net/netcons_overflow.sh      |   2 +-
 2 files changed, 179 insertions(+), 193 deletions(-)
---
base-commit: 68fa5b092efab37a4f08a47b22bb8ca98f7f6223
change-id: 20251007-netconsole_dynamic_extradata-21bd9d726568

Best regards,
-- 
Gustavo Duarte <gustavold@meta.com>


