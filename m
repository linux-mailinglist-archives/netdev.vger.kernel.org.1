Return-Path: <netdev+bounces-91841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E068B4295
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 01:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031161C21922
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 23:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602153BBDE;
	Fri, 26 Apr 2024 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9c2QJpp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56233D0C5
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173389; cv=none; b=u0y7ZRN9mG6J1VePvBwT5u3Ijwzc/cDiacWZcdaOsdBI3f1C51Ovw4GfCrPzGTuIb6tUUtlosRfWE8uYIFiBCwi0U+kPrlkpN5hyWIAbXS0nTrrq71vifLHyPdZMIMJJIBgbPFcAeUVcTwhvPuv4UrHSX3jf9V3/9z/GLKjzHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173389; c=relaxed/simple;
	bh=dJZx+bWVfHgMrqmTnjIgnvlLPMRXQsZOjWAcwXJKI/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oJyYoSPvkKMARqf1Go5YLaCYbzibA9exPcygYbQ9DM9k2ZeowjzY1ElO4M2GXbH1VmQQkgOd2U8W3VoRSlL06+yUPeq5Wox6w5dHpIeZy0TNf2ctXG9EdbuVAHYi8rAnCOGBE3ZJH2bmAuDyxdbSlGvZtTKw5sSaCihJtbP8e8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T9c2QJpp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bbd6578f9so569987b3.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714173387; x=1714778187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rkq5Hk71Z4xLAWnNRc3PQs5dqWDpmf+w7dEGFP8byM=;
        b=T9c2QJppVURtZuH/qoKq8jw47dgHuYm/czG2xQZ0a1qWE5JyfCtwsRMMp6GUIyFa1n
         7mqi1imsHAfKNKpDun9Z4z64wxSvuORHK4Pzbt8qT/esO6sw6xG5Vkk0oKMdKO4JkoOK
         y4DxPefGY0HXlRT97rbRjjWnHjkXPGz1SMeULmngnsuGDthuoe06QoZI8rp4UM0DJbAC
         w/meXBuZJl7uhQ5I7HgjM1tRjQLIcF5f6KSFdTACcBgThuAv4H+hYW0kfekzvJIVyo4p
         OB8PzdEyH/1KeRZZo2dzWn+KUABvaMR+kIfFCsQf1XPcgZk7bN4kHV4SoRbExX+ueatS
         FQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714173387; x=1714778187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rkq5Hk71Z4xLAWnNRc3PQs5dqWDpmf+w7dEGFP8byM=;
        b=BpPgSwA6Y00pg0qEU8AHEJFy204rU/hDoW0hbqJg+xoDXp5mijAwiHcj9NHjFTZu6Q
         FrlKZctZJWE3kQzW1Plwaysyyl8l+a09HIZWybCKP9HiX4vIuS3zdMrTFTqGaucKZikf
         Hbcb0t3KZD09ohyWS9zvht+KsOl4RsbT9iOvUJT1EMrjUcnGQwpcFlw3exMVEYQH/pez
         zskgSrzE1ZpApXq8W9oJRc9tgjeVeqbokMZyBU38dwnhO54l3KKHajA8v91pG3cqz9Nc
         IkWzjU5bjGFA5nnA2A4LUhYwpIC04HIZ6YnnTt21pcNx4sEK56ozi1rN6WdcoWEA/Hhu
         DEQA==
X-Forwarded-Encrypted: i=1; AJvYcCXKZM1qFKuWjTkiXmioEH/rpliKy97zbmOjR5UNW39oVLPwIzL4CXz+/i3Scp/Y0J6SGbWGpKjq4/k66nA7kR3iestSHl2t
X-Gm-Message-State: AOJu0YzaUKUob2x8DtJ82Drc+kAT1qWwPTk3MNsDxpoWRDaVTl/+WT5/
	t2x+fGQVSCaD1UPd8wov2VRwlujZs1K/jQoeYoFTtp1nZj+8GTaX2FHE5Yu5V9kuLw==
X-Google-Smtp-Source: AGHT+IHkPhYkAfQltsmOTcR4mbPNxZSC7fngqepkW1ciAPMXg3HLwQtpcrjcv21+CcZ2y5C0m5cAaFQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:48d3:0:b0:617:d650:11e2 with SMTP id
 v202-20020a8148d3000000b00617d65011e2mr1011450ywa.3.1714173386825; Fri, 26
 Apr 2024 16:16:26 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:16:19 -0700
In-Reply-To: <20240426231621.2716876-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240426231621.2716876-1-sdf@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426231621.2716876-3-sdf@google.com>
Subject: [PATCH bpf 2/3] selftests/bpf: Extend sockopt tests to use BPF_LINK_CREATE
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

Run all existing test cases with the attachment created via
BPF_LINK_CREATE. Next commit will add extra test cases to verify
link_create attach_type enforcement.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/sockopt.c        | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index 5a4491d4edfe..dea340996e97 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -1036,9 +1036,10 @@ static int call_getsockopt(bool use_io_uring, int fd, int level, int optname,
 	return getsockopt(fd, level, optname, optval, optlen);
 }
 
-static int run_test(int cgroup_fd, struct sockopt_test *test, bool use_io_uring)
+static int run_test(int cgroup_fd, struct sockopt_test *test, bool use_io_uring,
+		    bool use_link)
 {
-	int sock_fd, err, prog_fd;
+	int sock_fd, err, prog_fd, link_fd = -1;
 	void *optval = NULL;
 	int ret = 0;
 
@@ -1051,7 +1052,12 @@ static int run_test(int cgroup_fd, struct sockopt_test *test, bool use_io_uring)
 		return -1;
 	}
 
-	err = bpf_prog_attach(prog_fd, cgroup_fd, test->attach_type, 0);
+	if (use_link) {
+		err = bpf_link_create(prog_fd, cgroup_fd, test->attach_type, NULL);
+		link_fd = err;
+	} else {
+		err = bpf_prog_attach(prog_fd, cgroup_fd, test->attach_type, 0);
+	}
 	if (err < 0) {
 		if (test->error == DENY_ATTACH)
 			goto close_prog_fd;
@@ -1142,7 +1148,12 @@ static int run_test(int cgroup_fd, struct sockopt_test *test, bool use_io_uring)
 close_sock_fd:
 	close(sock_fd);
 detach_prog:
-	bpf_prog_detach2(prog_fd, cgroup_fd, test->attach_type);
+	if (use_link) {
+		if (link_fd >= 0)
+			close(link_fd);
+	} else {
+		bpf_prog_detach2(prog_fd, cgroup_fd, test->attach_type);
+	}
 close_prog_fd:
 	close(prog_fd);
 	return ret;
@@ -1160,10 +1171,12 @@ void test_sockopt(void)
 		if (!test__start_subtest(tests[i].descr))
 			continue;
 
-		ASSERT_OK(run_test(cgroup_fd, &tests[i], false),
+		ASSERT_OK(run_test(cgroup_fd, &tests[i], false, false),
+			  tests[i].descr);
+		ASSERT_OK(run_test(cgroup_fd, &tests[i], false, true),
 			  tests[i].descr);
 		if (tests[i].io_uring_support)
-			ASSERT_OK(run_test(cgroup_fd, &tests[i], true),
+			ASSERT_OK(run_test(cgroup_fd, &tests[i], true, false),
 				  tests[i].descr);
 	}
 
-- 
2.44.0.769.g3c40516874-goog


