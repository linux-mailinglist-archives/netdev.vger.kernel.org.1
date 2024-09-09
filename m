Return-Path: <netdev+bounces-126518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C34971A71
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CA51F249EB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27D1BBBF2;
	Mon,  9 Sep 2024 13:08:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5E1BBBD0;
	Mon,  9 Sep 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887310; cv=none; b=qTnGkD2xuAyKZynJalFY75a5ATPC82tRuM/SYCoC/ULYYj8MnJa6TQGyTQAAuSSm1+Dvuum7OcYY9Zb0y9O0oG8PFzKKTwqnFPQwb0OIdSY6Af0jD7FJ58cknwmPD9r/6zT1qrgkrMsfD4PFTZxIJrGkexo6fwEv9rCoLSWwmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887310; c=relaxed/simple;
	bh=1G+O70kQlgUjlXyCifi2cYhG6zmRThen8fxju0O3iPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhkdjD58dKSal+p0JV+DPRtr+X5Xdz20VIuv/hWZm2nXGouiwGLZJyZvcNOf1LM24OJ9YAApFHgKoAaCr9rgo3xMUt573/QM3lWM/WRUlUnoyadVpGG7LyV3wYIvaT/sS48psvgr2nOPUQe6U55xDb+5J9ju0ivHBP843KNEEG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c3d209da98so404906a12.1;
        Mon, 09 Sep 2024 06:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887307; x=1726492107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAJypcMSdNG3RzgBifEDQ+E+OlrCHokwMoz1N9CXNp0=;
        b=qVHBvWqMucKH0DHQ2B9LBcN7Iqh1LuHK/K/6QIFLTvNNJuDsz8iYIIhjt/47q+NV77
         gvTocqanwiyj2fHbyJHceN5Hx25noEduzfKVM5KKAuui9DNDnO2zFpjh7eOt5gpAbYD3
         SF04SvOyXVdWF7EkljV1AxGgIdIs18a2zMS1d7qUDikgyAXgn0i/GbPIJV/icmUefqko
         iyLuPHngmAqSTQN+ok/alCfldJndGBeg0R8C/0XrWkMICgj1QWj07eps2YR0jNfnoO/J
         OufAaPa+GB9CUYaA8fiWAcpzKrjz9nP04nB3/a570DpF3rtotDKqN0llfHita8MFVIio
         RgPg==
X-Forwarded-Encrypted: i=1; AJvYcCWfHqAhjEIEy24CuSEDfmJOSc+F4B5XkK+xwzqjeXHJNJ0UhajbD2tqyns+uA6l/Z7zMg1EYiJ8@vger.kernel.org, AJvYcCXdjmEis2bR6od/igsRLR+HIVx6f/PFBpswCkfVmSzRHaKQkHof9OtR2J3p+t+444QRyFiYfwV5tLG5i9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKihNG0IbaGlzMCc0ywSgebVbmKuiovs02W3Xf+Itx0ANU5jM
	0TPksUHGxDIPXb7w90p+iljYefvQ5U+bAVBOQSxi2xIPb5jTcyLF2fyMUA==
X-Google-Smtp-Source: AGHT+IFDjqJL8rCosrnIxltP0D1c+uxNMUZLBADnfw22+kPu9o41pUDMhEHzF8fTQGGYQ/zn//Z7XA==
X-Received: by 2002:a05:6402:4316:b0:5c2:1014:295a with SMTP id 4fb4d7f45d1cf-5c3c1f742d6mr20151664a12.2.1725887306580;
        Mon, 09 Sep 2024 06:08:26 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd5245dsm3038743a12.52.2024.09.09.06.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:26 -0700 (PDT)
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
	vlad.wing@gmail.com,
	max@kutsevol.com
Subject: [PATCH net-next v2 10/10] net: netconsole: fix wrong warning
Date: Mon,  9 Sep 2024 06:07:51 -0700
Message-ID: <20240909130756.2722126-11-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909130756.2722126-1-leitao@debian.org>
References: <20240909130756.2722126-1-leitao@debian.org>
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
 drivers/net/netconsole.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 6a778a8690c3..7d2e021f04f4 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1165,8 +1165,14 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 
 			this_chunk = min(userdata_len - sent_userdata,
 					 MAX_PRINT_CHUNK - preceding_bytes);
-			if (WARN_ON_ONCE(this_chunk <= 0))
+			if (WARN_ON_ONCE(this_chunk < 0))
+				/* this_chunk could be zero if all the previous
+				 * message used all the buffer. This is not a
+				 * problem, userdata will be sent in the next
+				 * iteration
+				 */
 				return;
+
 			memcpy(buf + this_header + this_offset,
 			       userdata + sent_userdata,
 			       this_chunk);
-- 
2.43.5


