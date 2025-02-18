Return-Path: <netdev+bounces-167261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A83A39718
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3B61891FAA
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E16622FDEE;
	Tue, 18 Feb 2025 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l02GRoEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134C14A614;
	Tue, 18 Feb 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870905; cv=none; b=F3Ow/iQa4wNNNrfhHUIBVbhDDLl4ib/iMrEKLUEerVrvTVO6bgHe4dZNpXVnQ0RIbfBr0U5YimDz2RMpTaZ2fLMf3MvbysiFT3n3LVxFTp4+Xy8KfJXUkmvL6Gvg5+ISDu94MFYOuWyqnR9j1BgHCtw5tcKD7EHHbeGnMoZfLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870905; c=relaxed/simple;
	bh=KUCO7GOcoDrDHadjAC27o2CRSYfaHDgMDjMGMYIWFcw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dbKw4F8yH+oeS8/r4UHBJ3EH8Y3Qq1eGlNX1IjTM2x2JpEGZoDZTOtEKNyuHh9LZWHyXQmOk+eoQ0yl15aJcJ6SVS2qhoBi0uiJrUFar3jqylquzWKxYQRx3DUouYZ1bnkY6FC8uqxaVBZKSOGKPsoHOBzJs+WQcd1LuKWq07p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l02GRoEB; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fc447b03f2so1296187eaf.0;
        Tue, 18 Feb 2025 01:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739870902; x=1740475702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8kJMtWw9wVrl3aRZwWKVOYpt3qrRhCd81TsGEYFpLTg=;
        b=l02GRoEBchKwQV48uqwjpUb3yJblAVEHvlm6Wugx8RhZUjpLjdf0k7UW0Iq/ESvsHJ
         u3usHASAgbTzamlkuXd2bT8kIRd54Y1OIETcAoqTPUApoK8Frtnf8StwkULuMFj6F4oH
         zaffIIK9AI+P7VM91YXdd/RpEkSeUaCEeXrHFkgBnlXVisS0BpUoF6dsT+8MSVxyjIKL
         VRmEyV3QGle1U0+iqk2Kc7vEtIrOLKf9Hp49KJg2RWIX7QVUq5zC8Pl8ByeOh0N+F+08
         tz3TiZx1M3ggQvdl+IP4WR8LwO44mfBPNlwvAA8GlZBe7fGPT7f5L6hZ9gjDNRclyREi
         OPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870902; x=1740475702;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kJMtWw9wVrl3aRZwWKVOYpt3qrRhCd81TsGEYFpLTg=;
        b=Hk7Zo8xtrlTWOvsVGo7i+x0VrzgRiMWCG+kjo8FIbryOedd6JOGMm4zUp90gosd+3X
         zH5+fmZBug9xMO4emngenXKsPf8BYHov/vC9vCirBRUq5lM1DvJJ9a3MdLtMl3yYW2fQ
         N87FAwmWp7ycpQgsRabemiwM5OvLQixJCPvl3F/SQQ0MtjWMb1NpBha6dNNVPHreJaX5
         cGJSksfyk45FqGbDlYrJ0D87dFWbrbKoszEvVx5vFzgbWvtCBk6asEAbSdVzsBjUrVmg
         QU09WLtlKFBqxxBI0mFt5cumz/TpBR4rK93buIlz8WSlu5mhfFx2DX1F2E5qSCZ6KRT9
         4+nA==
X-Forwarded-Encrypted: i=1; AJvYcCXy9TFYybw/hbDbJga5El3x0QJ0hP3T1Ga8on958Aw0CjZW4Jgo1wTl1SomuML1peJglsnmcwWLanFRsqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0225cu6FVHMqI8ERVEqS5EyFnxyz86FiIE/2OkwQsVk4BZddP
	yEbTiUXaKgl8EyfkDt6/K0NfR5Sr+jX0h12EM3WkL+B79OFKid6qnUS/TTvd+Hxq69AjVVAtp4Q
	zMX2BZiVsbxaC3GoAGkK4RyoL330C5AAZKYoNvw==
X-Gm-Gg: ASbGncsmN71Dbv5lVpATNImg4W2kd8bfr5IMv/Lpz/IPr1dxroexQmifZgxKTCFqZn0
	PHuJqWfVHpIcIczc3RUYtxtCUR9c/PS3S+BQoIGDiol1+bRkXIKipPVkPulNumUYif8HwWjc=
X-Google-Smtp-Source: AGHT+IGbMnXi83Muhh7hozQR7z1/wxvHIyNCpzQKVTEOGDO+J9syLNm5krScvYcmKeztpkeSfzp0rQUdKL4bvpaU70c=
X-Received: by 2002:a05:6808:2025:b0:3f4:28:1cd6 with SMTP id
 5614622812f47-3f400281de6mr3182376b6e.39.1739870902398; Tue, 18 Feb 2025
 01:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 18 Feb 2025 14:58:11 +0530
X-Gm-Features: AWEUYZn9N8YQjSA8rz4TzhThrcXz6tH7kdaOCaUbGFtWZGGJO-UH_9KpRuvxN4s
Message-ID: <CAO9wTFggVh9LvJa_aH=dDBLrwBo8Ho4ZfYET3myExiqf0yfDCA@mail.gmail.com>
Subject: [PATCH REPOST] selftests: net: Fix minor typos in MPTCP and
 psock_tpacket tests
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, matttbe@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Suchit K <suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fixes minor spelling errors:
- `simult_flows.sh`: "al testcases" -> "all testcases"
- `psock_tpacket.c`: "accross" -> "across"

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 2 +-
 tools/testing/selftests/net/psock_tpacket.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 9c2a41597..2329c2f85 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -28,7 +28,7 @@ size=0

 usage() {
  echo "Usage: $0 [ -b ] [ -c ] [ -d ] [ -i]"
- echo -e "\t-b: bail out after first error, otherwise runs al testcases"
+ echo -e "\t-b: bail out after first error, otherwise runs all testcases"
  echo -e "\t-c: capture packets for each test using tcpdump (default:
no capture)"
  echo -e "\t-d: debug this script"
  echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
diff --git a/tools/testing/selftests/net/psock_tpacket.c
b/tools/testing/selftests/net/psock_tpacket.c
index 404a2ce75..221270cee 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -12,7 +12,7 @@
  *
  * Datapath:
  *   Open a pair of packet sockets and send resp. receive an a priori known
- *   packet pattern accross the sockets and check if it was received resp.
+ *   packet pattern across the sockets and check if it was received resp.
  *   sent correctly. Fanout in combination with RX_RING is currently not
  *   tested here.
  *
-- 
2.48.1

