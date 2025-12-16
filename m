Return-Path: <netdev+bounces-244943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85232CC388D
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DE033035A16
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A978343D79;
	Tue, 16 Dec 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/gSau6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEC42356A4
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894902; cv=none; b=R5K3eu20VOv3Tg7j1X0uSYVs+dSfodvqcHYZ9T/JEkDX4uUliGmhOfG7NKqSj5K9wiImrJOPcgXBJs9hsKramukcUT49QbzDl7X78BdzgWARhQ08pE4dRHN9vFAt8nQkiTJSHXo1Gfl7w8q3JVLYudddL5fEkNGGUS9diOGZ20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894902; c=relaxed/simple;
	bh=rRg1rU7RdBd7Gq/Vczw/5nedpV2H6E5sTzFYSK2TRDk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hOo9jeyLlxZ01NK9YEdDzuuFbNKf7bSk1m6ShtpII2lOO13hQeTeI3KTYBsUpEFzHDs1nkP6mClae9eRczO4v5zmYzcG86G5dBMNGJ++JbbTNQC/nlCbtM/Mv2UT4PqkGfX+6GLe738wTt7sUyFiIQ6dKCQ1KCDDAWQQ4QUvaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/gSau6p; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78c5b5c1eccso62486107b3.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 06:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765894898; x=1766499698; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0mup+HLlOmrVWqFXbyf+MzotU/km+jMX39WXot6KIA=;
        b=a/gSau6pK/u1fIeU4zuETqT0VmX0W0tfKs7peZ9Fauug8kh0UZGSyaxxrvyeFJst21
         4gy1SWA3wp9Zx7sHocCCp2Z3af95NwabA02wFYIStJkCoI8p57dTfyb9vqwSIKQN8So7
         6KWpnx03+pQ4K9l1NK95ILFRge3F7ntylo5SGzfLbTyDrOfu5swJ4A1GMeFg/tVA4BDA
         1Ta/VUIHtKBg/aonSOOa9GOyZmitqo1baKkHEiHm0m3kVKC21snSh5pRA8NkL8AZLCH3
         tkpevNRRh8bHcHNpU+N9uyBiIa4n6vYbA+zOXY8spnqs8ug20uX7MU4npDjTGPUMaV+o
         o/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894898; x=1766499698;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0mup+HLlOmrVWqFXbyf+MzotU/km+jMX39WXot6KIA=;
        b=VmWAIBg9wVjYmq7muXjaQPWeWCPBoM9CEqPq5KJrUjr/QIfB/1NYBsVFofC58ap2jJ
         rJszcpfW0F+sAsAzzAc5DKUFlToHc91b4gDc6E8MeyLUoT635MvllTtwkwFi1i/cQYFJ
         lqR8u/A7VqTp5S8tXPlD44MgGzbHY1nmeCKF0BmoqBjXez/zpImDTJpwWRV8hw7/lQoD
         WRSILwYHUeRZfxGPA+HTVbkRwXlUCBNPTLyVv9K/kjW2pfV8mrXcBxHBTgxINuIOVXQF
         odKGZWJ4gguhG5g/qaZdpAhepPYxHTstw0770iJ+Lr1ef1+gcrBbSH6pZPwy5nFBY53A
         6DBg==
X-Gm-Message-State: AOJu0Yzwx3KowF9aAvN0DcUuM1wg6G9zgMA3aOYy+nvssJLVmCCikiul
	/6CKmnS8dYzJnIO82Uqwgtm7ELPmhhww43jffzbftvpUmif0HSJMkk4S
X-Gm-Gg: AY/fxX7A0NR5qqBo4FPZ0ZY4LELMQ4a4Vb0WR4wX96E89xmzoKKQYfOUoFsSS5PxoqR
	E9G6+sLmzd/rmWgufSdK2uURHjAeNjAZDWwld9lZD96Oh/6BsJm0zJrm64uyNV1aAB1x7odrvcF
	bcvXM1p8bVDccusijZ/hQqZw4zpRw4F1Wxw+O4KYSQY9BZnSRrRBE7yyITGOhwUqhW2n39z6ovh
	DD3W4v35QodBBo6dqmhYtxtOTS1Kzt1E46R7K5K2CmC6LMjsaNZSkR8DmSuSYHzBlgAluyeBg0e
	RZLawMPd3F4EevFL0TLB+A21MOx0Y2a13bhVApSTN/n8Vd7Qcupp72+AKAdyoqYsgfimaGjP/VY
	dEXoopF2nRkFMAsrqkT9uEQvJrLeDPEMlonG1r57a1pq/O2nJD5y1uizOee+hxOmODkE3xC9/U2
	p/tUE12+VVqrXlNf6NXb3AnqaN+EZ/9Yo=
X-Google-Smtp-Source: AGHT+IGejGVDSZX+7LKGxziOgzMccisD2YOnvJr92J3v9iAv92NOwjPH5YZx0F1XbU1v7gDjsWQY9A==
X-Received: by 2002:a05:690c:4c0a:b0:786:8410:31f6 with SMTP id 00721157ae682-78e67155d6amr106126917b3.22.1765894897917;
        Tue, 16 Dec 2025 06:21:37 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e5bccsm39322147b3.26.2025.12.16.06.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:21:37 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net 0/2] selftests: drv-net: psp: fix templated test names
 in psp.py
Date: Tue, 16 Dec 2025 06:21:34 -0800
Message-Id: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9qQWkC/x2MQQqAMAzAviI9W1iLivgV8SCz017mWIcI4t8dH
 hNIHjDJKgZT80CWS03PWIHaBvyxxl1Qt8rAjntiYkyWsIgVDHpjcCMNvnMre4KapCxV/7sZohR
 Y3vcDi6GTbWMAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0

The templated test names in psp.py had a bug that was not exposed
until 80970e0fc07e ("selftests: net: py: extract the case generation
logic") changed the order of test case evaluation and test case name
extraction.

The test cases created in psp_ip_ver_test_builder() and
ipver_test_builder() were only assigning formatted names to the test
cases they returned, when the test itself was run. This series moves
the test case naming to the point where the test function is created.

Using netdevsim psp:
Before:
./tools/testing/selftests/drivers/net/psp.py
  TAP version 13
  1..28
  ok 1 psp.test_case
  ok 2 psp.test_case
  ok 3 psp.test_case
  ok 4 psp.test_case
  ok 5 psp.test_case
  ok 6 psp.test_case
  ok 7 psp.test_case
  ok 8 psp.test_case
  ok 9 psp.test_case
  ok 10 psp.test_case
  ok 11 psp.dev_list_devices
  ...
  ok 28 psp.removal_device_bi
  # Totals: pass:28 fail:0 xfail:0 xpass:0 skip:0 error:0
  # 
  # Responder logs (0):
  # STDERR:
  #  Set PSP enable on device 3 to 0xf
  #  Set PSP enable on device 3 to 0x0

After:
./tools/testing/selftests/drivers/net/psp.py
  TAP version 13
  1..28
  ok 1 psp.data_basic_send_v0_ip4
  ok 2 psp.data_basic_send_v0_ip6
  ok 3 psp.data_basic_send_v1_ip4
  ok 4 psp.data_basic_send_v1_ip6
  ok 5 psp.data_basic_send_v2_ip4
  ok 6 psp.data_basic_send_v2_ip6
  ok 7 psp.data_basic_send_v3_ip4
  ok 8 psp.data_basic_send_v3_ip6
  ok 9 psp.data_mss_adjust_ip4
  ok 10 psp.data_mss_adjust_ip6
  ok 11 psp.dev_list_devices
  ...
  ok 28 psp.removal_device_bi
  # Totals: pass:28 fail:0 xfail:0 xpass:0 skip:0 error:0
  # 
  # Responder logs (0):
  # STDERR:
  #  Set PSP enable on device 3 to 0xf
  #  Set PSP enable on device 3 to 0x0

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (2):
      selftests: drv-net: psp: fix templated test names in psp_ip_ver_test_builder()
      selftests: drv-net: psp: fix test names in ipver_test_builder()

 tools/testing/selftests/drivers/net/psp.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 885bebac9909994050bbbeed0829c727e42bd1b7
change-id: 20251212-psp-test-fix-f0816c40a2c1

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


