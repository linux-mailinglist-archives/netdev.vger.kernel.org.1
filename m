Return-Path: <netdev+bounces-124571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDD2969FF8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9202F1C2473F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852CE1885B6;
	Tue,  3 Sep 2024 14:08:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14D18786B;
	Tue,  3 Sep 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372506; cv=none; b=gj65+711qAOg16oEk6+AoDbsHDKJI+aiCZDk03Tv9wH10PYTEv/J6QIlxOsJPaLih0jBg4rOV96ppPq5nZjLaR04j895TJj5AgXk0OU9caS/NP2dF/xIpFRHfw+nEb0rGCfyXaFfo5xO0r0PYVUI4E4v4qGhHVKsEADnoBqfOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372506; c=relaxed/simple;
	bh=g5KsSG49oRt33PNXtrGSdHt1Y9XV1D5tMkkzqy74KZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/i2PLsNSl2hYC+blSuDVGNIJMxlm6jh0DJSEWEArrjJXSh1f0h4op3tbBdHJgtaOcI+s3Vbq1Ajjb7g7Qzj6BnV/wcgUw68uUZ2e8uwK+FD7CmOZUj8Y3Q+zVTTYUQa70rqv5iDW8ZfiT0eHJY7VWvjwXDN4+2VR9sN7/SCz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8682bb5e79so660789066b.2;
        Tue, 03 Sep 2024 07:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372503; x=1725977303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emDa0Cu4b8tMOUv9O7EFPrzNcNUmMKCv5Eqwf3IBEIQ=;
        b=fxhT8ZoScnAkFnholuUgPsU+zbsjc346GPaxBrI5t7v/80fwgv4A6fLy9uxvO6MU7Q
         01+qA07xy7MYE/jP/V0U5ikaC7PZ2+PnVEdU8TH4nxDAyXrZ8qsjhxNiR55FLIv6GqBU
         u4sggryIDTEgY5wZgJ0i9bCszms3i5U0Xu3YcRNtj9epe2+rltJtyxqYMiq5UOlJfAG0
         huKLWNBs3cYnlS609XZdWp2c0Q3dIFwSCgPDTKsVbrP3eZ2hZwkV2Rk8UTGQflwRf2PE
         XAZjEz/LozfxdGggDESqkrbCWBkE7zlpbyFP83nQUbWjCbl5PX1YjBGXkNLmZFjjiJap
         LQkA==
X-Forwarded-Encrypted: i=1; AJvYcCUZdFvm07E68xXQgkv1H7LPwvFOgciN1myJNdCW36Wj+ko6LCv82Q4xITyHD6i/HZjIzYtpIUib@vger.kernel.org, AJvYcCX9CP7SFcGkmb0hn4oPyZQpeZ9VfYGTKMfIxGMkwRoUwTtDKXtXoL8tix4POHbR2uyqwQa4wba//R/RgMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCSLcUeo8lSeMs8ghdOPp+bAAwTV437LZ3IonsLMFQG/0tR1A
	/mPRlwjsYay5VUITmQAPWvWO5/uGyvgxVgk2UjSTjKwjWkUNvVx+GFkZg7gM
X-Google-Smtp-Source: AGHT+IFkmkShia1eyAD0c3UFZFyDkiSQA8XeGHbJAKGYaXtEY5HI+qywLz+EkCKLCWesAkMR8vX/Cw==
X-Received: by 2002:a17:906:9c84:b0:a86:77ac:7e4e with SMTP id a640c23a62f3a-a89fae1b87emr558609366b.34.1725372502665;
        Tue, 03 Sep 2024 07:08:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989022481sm684087366b.86.2024.09.03.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Matthew Wood <thepacketgeek@gmail.com>
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	thevlad@meta.com,
	max@kutsevol.com
Subject: [PATCH net-next 9/9] net: netconsole: Fix a wrong warning
Date: Tue,  3 Sep 2024 07:07:52 -0700
Message-ID: <20240903140757.2802765-10-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903140757.2802765-1-leitao@debian.org>
References: <20240903140757.2802765-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A warning is triggered when there is insufficient space in the buffer
for userdata. However, this is not an issue since userdata will be sent
in the next iteration.

Current warning message:

    ------------[ cut here ]------------
     WARNING: CPU: 13 PID: 3013042 at drivers/net/netconsole.c:1122 write_ext_msg+0x3b6/0x3d0
      ? write_ext_msg+0x3b6/0x3d0
      console_flush_all+0x1e9/0x330

The code incorrectly issues a warning when this_chunk is zero, which is
a valid scenario. The warning should only be triggered when this_chunk
is negative.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 1ec9daf95093 ("net: netconsole: append userdata to fragmented netconsole messages")
---
 drivers/net/netconsole.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 81d7d2b09988..83662a28dc00 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1124,8 +1124,13 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 
 			this_chunk = min(userdata_len - sent_userdata,
 					 MAX_PRINT_CHUNK - preceding_bytes);
-			if (WARN_ON_ONCE(this_chunk <= 0))
+			if (WARN_ON_ONCE(this_chunk < 0))
+				/* this_chunk could be zero if all the previous message used
+				 * all the buffer. This is not a problem, userdata will be sent
+				 * in the next iteration
+				 */
 				return;
+
 			memcpy(buf + this_header + this_offset,
 			       userdata + sent_userdata,
 			       this_chunk);
-- 
2.43.5


