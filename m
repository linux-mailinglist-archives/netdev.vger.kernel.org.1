Return-Path: <netdev+bounces-191162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA66ABA4BC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677D83ABD93
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB6122B8D4;
	Fri, 16 May 2025 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htM/sldH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E1F1A704B
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427720; cv=none; b=TwxaMSEb4P3I+3NxYMExp4Ik8ZvYqhsp1HvMnKUTS+VckLQSsTAxmfg5ocBqqZHcGH52nXBg6/6mSfHskMS4CLyU9Uiktf+79KK8Ohmzb3s9C/v5naq12lMyEPoHDrQNsVTzyn9ZW0h5EXeGmYHcQ9L1pmRoJCXZsK8OXCgxZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427720; c=relaxed/simple;
	bh=fP8E9v3zJ+APJASBeiAwRmZRScRfbVU7Qi3sCSrOeSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=quMkSPwgZuNl5cPwJ8PLvbPcdzTG96uNhPzg/N2HHlSwqfTrB1S8XaJF8fm9m0Q8WnbAvqMeTfpb/fsE7PeSBaFBiA9KJdY0x9BzZBpwDPPwE8ICPs8QAlTiL4ggsEKiQIPCScHCnj04RxTq1FWA89ReJYYbg6HQjAIeLyuTcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htM/sldH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-550edba125bso731197e87.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747427713; x=1748032513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yxLxKPAkFRNTV46MhihIDPqFiSaNfOKTtn1tMu7HPrY=;
        b=htM/sldHuj8YjLeBH1UOzFP/ddOYptFMkjT9wuLWNZyz3cCOrJHHVu8UDSAqNCDDo3
         F0KM8PZvtOfxU5ssnM/a6vjELrTst3JJIh7nyV614QjtizCKet4YElyk4YUEgomdBdj7
         GsbI/voi++Lln4FKbs/mQw4mU85+7wLQr1uR7H7ffnlMjSrQPqSfRL/t0cFCL+cPKD5v
         iuhN/b1EM3qO+FtY5gJXcdRVCtXWEZigDq8FigWaaFMtAUXsv2S9AbVcek4fsz4hqAdS
         iAulIvdq2d9TdEv27hqu+LQp9zLTZcRKj5Q1TAAb0qF17V4Gz4pOHqU7PVE8lR9NgyPV
         y1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747427713; x=1748032513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxLxKPAkFRNTV46MhihIDPqFiSaNfOKTtn1tMu7HPrY=;
        b=WcOVhLf4lR3ReimrkT8TCsWbv9OYqlEjeR56oKmCttjHG5NU/IE3ulZKEGYiby6BTv
         i38MyjZTktHkhvG5uB+QeuIhh48hcjoRA6iOe0k1IHxik1TUr8gKeT39GnOGXiPYY2cz
         5H2KE8CW+22yWw4ISr5hvC91JyHdHwaxfhI6Sl+JUP0Rx5mzbTSybKvPD6DmUWWnFnEv
         QrSsZWByXxFeYq9VAQi93Z8vSu8xY3ECgFvg02ZdANVf8fTafb9yZkDm5hYvXnTiiebg
         U3G7+CgyhG0B7zr5WzUM1ogVijoW1+0sc2Ed6hQFWRKxxHcJ34tDILKg8OYrGY7eI8SF
         XulA==
X-Gm-Message-State: AOJu0YwDz+nEj2i/OX/vI8wM+w512Pm3kgvE3S9FDlb+P9oyvLBp+mJU
	H3csE8c0/5wXryGAk9uwflxHF/lhuSEePe89OJtoldlSHWsqiqY+i5FI8cR06S5G
X-Gm-Gg: ASbGncs96Gb5ukE7QrdncDj0aRm+1MGJz4S0Kda0F7zCNcf5KLKkglCSDF9gqZYR7rr
	CNqBRr24MpJS7DOO86iDZ8JT4QwbPLPUNi4QJNq8sN/bDkWrxjEQOgxh5ofMzBsbOmt5hbqzM0X
	gpAQzlTFyYXTr5tpoJuhTPGhMGJwqZcygY19k9iPJlH5sZK4yn3VW6vedQKz5TnPH297jG8N6dM
	auBdTgX1nlzm/msqArq0gW+FQ8Mkfp2s8YE5HC6WpuwRwqKKF2Q+kAj5jshFeda95wZPIe5CeE8
	Bgmk8wiXD3zKIxNpr9J3a+XNxC7OcGh9RvuOmzpU3bedOsISVENIIbFlCz2J4+c4RKF0beTgmx5
	WDYwpby3FRcQdtuxMtw==
X-Google-Smtp-Source: AGHT+IEldMGogEOipYwUKI4qpd4j6FalCJWEhKELhDj0QJkWsSZp8gdrNXJNvJ8VR9AQiIjtl3kXiQ==
X-Received: by 2002:a05:6512:620b:b0:550:e5b3:b1ab with SMTP id 2adb3069b0e04-550e719529amr1600719e87.4.1747427713142;
        Fri, 16 May 2025 13:35:13 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703f864sm577494e87.250.2025.05.16.13.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:35:12 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: netdev@vger.kernel.org
Cc: anton@vger.local,
	AntonMoryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] json_print: add NULL check before jsonw_string_field() in print_string()
Date: Fri, 16 May 2025 23:35:09 +0300
Message-Id: <20250516203509.259117-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: AntonMoryakov <ant.v.moryakov@gmail.com>

Static analyzer (Svace) reported a potential null pointer dereference
in print_string(). Specifically, when both 'key' and 'value' are NULL,
the function falls through to jsonw_string_field(_jw, key, value),
which dereferences both pointers.

Although comments suggest this case is unlikely, it is safer to
explicitly guard against it. This patch adds a check to ensure
both key and value are non-NULL before passing to jsonw_string_field().

This resolves:
DEREF_AFTER_NULL: json_print.c:142

Found by Svace static analysis tool.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 json_print.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/json_print.c b/json_print.c
index 4f62767..76e654b 100644
--- a/json_print.c
+++ b/json_print.c
@@ -138,13 +138,15 @@ void print_string(enum output_type type,
 			jsonw_name(_jw, key);
 		else if (!key && value)
 			jsonw_string(_jw, value);
-		else
+		else if (key && value)
 			jsonw_string_field(_jw, key, value);
 	} else if (_IS_FP_CONTEXT(type)) {
-		fprintf(stdout, fmt, value);
+		if (value)  // защита fprintf
+			fprintf(stdout, fmt, value);
 	}
 }
 
+
 /*
  * value's type is bool. When using this function in FP context you can't pass
  * a value to it, you will need to use "is_json_context()" to have different
-- 
2.34.1


