Return-Path: <netdev+bounces-245981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5511CDC563
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 14:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5FD83015E2F
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AB5348896;
	Wed, 24 Dec 2025 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLba7lP5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BD2BE02D
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581808; cv=none; b=bQ+VFVySySps6enPyYbuGxFTVjEQxpe/Za09e+coD8fP+azQsH6UEoZIojNgls5ScZz22Etp6CZF/4jkQpPMAHK38QYD+ktUEVUNmdQCLcnrjiylWJud5oV0yhlD2lURH93dvVSQsznsAz8XE60sggr6JGSZFXqYe5uEI15wl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581808; c=relaxed/simple;
	bh=ARq0/QucFj/sxPqr+22ybRos7rUcjBBi5nq/Y4PoAvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCHxzagBIzcduND1BUKhu2VdQ583mT55nd/YuZANIs5COLB3Kds8Hl6EspYP0Nn1gI0lYhLs6X2alNPX0jPBh2Mzy2s23orAjuYxhS0T3wUbv+nKj5M/ckuJMu5q+Qe94D0zZfoDDq/znIQe9K3IY3FUZWDZtE3Qhto5wT0P9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLba7lP5; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so5301683b3a.0
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581806; x=1767186606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki8yj47Ksf2sOkp6JBKCA9cB1ptX2Wx6sb0cvY7RlMA=;
        b=CLba7lP5VtaP3jg1Zy6VGKj+qXkZLv2HZF6wTH5Gx89eYoaKF0H8yXxGIRJt0mpXh9
         3nKjeer/OTbF5GqczyIJxslYO4lRGRJ6ditMguttBKCAazkSOwixtLf4hxTpBWm0ilqK
         xmT0YfaxIe0xWDz40sftNxLYOxVhbqxazqKzt8U0eM++PbjEmMmAFStasJaUrYFMtDA8
         tkc+UVy5dpf5zkv6qc8FiVlf+9bgophfRUZ1pI5H1UJBRrwFUrhL2I3wTK9b7bajPqpV
         OK1TkjHR0SeVsceQ9Q+APS2z5QVlVl+6cYZZaQMT1N+UvjwxkzD2ABmINL9jM29yL+Xr
         rq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581806; x=1767186606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ki8yj47Ksf2sOkp6JBKCA9cB1ptX2Wx6sb0cvY7RlMA=;
        b=Px3EiA8bnpWw4GFwgie2CJIW2uu3+m47r6LKB6UVq5qoIXgnbZA4xTZ/yImlw7I30y
         f6R47kUtX3FpefmCbWxLF0HYXWc85AAF1S8Wy0LqaKMJ9wtKjvLu8kWfM73mFZLnEYPW
         FRcoZr7XfYLsYrlNg6sFLzFGDWpwF5s/WUQYsKeOQpnihVAAD9O2R2IbgL6f3Pi2aoQz
         DoK4v60/u0uvn5gHwPWZo6oyi/0ld5FMb+J145dtHvr/oIUCWNEwRXi6mahFeFQSum5M
         +IgyzOYOUDDBK0WILbcFLXeigujzyHehFzhpBeQNJR7RhI3fyZSSSjevB3zZW1jTiUOw
         Lo4A==
X-Forwarded-Encrypted: i=1; AJvYcCUPwmJWDl8gn80Z0TkWHB7yg0SwI6WGh9RgaY+HXSwrnmJc2/ZRMMwHQAP1yxRke5a+3KwMzO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuzcoje2zrMt+WFtha4i3zGFcHQWTARpB4RvrpVZ35yAcF/1/+
	Rwl0pdnmwn96ldKFpz4MhID5Poseb53A7cRgHie7vAtFJ76sw5aadepa
X-Gm-Gg: AY/fxX7Xady7B7g0hHlcxchVOWQlz0VQmmAdyUs+6kuFcjsA9osN1EyHKsPOi2nkLD/
	hcPcIbf/L+jc2VIQjoVZf5mwQmlm5ZseG9rblMXsKLeUPDU9vPC2/NfXYMunfZRNf3CB5EKPnJH
	3+aL4vPT6sA8Jk8IAIoieyElyeIXmhfK0M0/zEiGynoq6b4Ze5QLseYX+o8hnTBExJdz5dTdEJs
	kjloQ6FjykdiBAsGxSECWSrdnR5Zpf5T50zT1hA6PyPe8SGvj9GBjOR/Q4JtY3JnmyQYS8PjfKA
	fOMBcfWOI1QFBu4WL2gw4av3Q1aghoWt+0saymBxHrwcbYmXog+l/eAKTZ+QfHNehqfPIqv04cR
	LdxlYTPNhr7h3AZyUpPtbc7KYfGREwq7iTOxJQfmrgmmLmT0Sx4CCBVw62w2yWb649D8GrdaRC2
	t8104cDV0WiRwwPM1Wcg==
X-Google-Smtp-Source: AGHT+IEsQ3y6BfEUuR6gPcWe8dQ3+JU2VN7JGTtTSLSdiP5hgCSTgDCloIJCRNjxPEDqHrTRUmPDCA==
X-Received: by 2002:a05:6a00:2c85:b0:7ac:3529:afbb with SMTP id d2e1a72fcca58-7ff648e9b90mr15231794b3a.20.1766581806344;
        Wed, 24 Dec 2025 05:10:06 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:10:05 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 10/10] selftests/bpf: test fsession mixed with fentry and fexit
Date: Wed, 24 Dec 2025 21:07:35 +0800
Message-ID: <20251224130735.201422-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 5630cf3bbd8b..acf76e20284b 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -180,3 +180,19 @@ int BPF_PROG(test11, int a, int ret)
 	*cookie = 0;
 	return 0;
 }
+
+__u64 test12_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	test12_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test13, int a)
+{
+	test13_result = a == 1;
+	return 0;
+}
-- 
2.52.0


