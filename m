Return-Path: <netdev+bounces-208428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A0FB0B64C
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 15:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D65B3A6E67
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F01EB5D0;
	Sun, 20 Jul 2025 13:56:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD519D8BC;
	Sun, 20 Jul 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753019765; cv=none; b=RuCAVm5c3PtDX4/OnVnGbKfi27biPyDBxkpxj7u84+RNOraMjHJy4IltEFtKB844jTq55n9jjeVswFyFlFR9DLdVRpcj81hW7O6NynNu3Fhsk6QIDoXiI0eCuKsfHxMdgD5bzzbknYA3ulXi6kTFWImXaD3WXQrLtkKLxfa89sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753019765; c=relaxed/simple;
	bh=g/HYQQn93b9PDBOpEP6NnaPAqOg/efONOh0W5SjPU7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=emXNf5TCFJNwW7h9YyX2f1nQvU3F7pfgWCpluMH0ZnTrZFDr9e75kES0rGaJMsBxjxQHf2VkSDiu4/cks5xTJko0mX+4nLphK529otLdnlK6jF1V6jfYnQdxTQ82Q+jJZb5bjUMOkvF6WGjbo9v8WFizJAWVK9IAt6j7MuKIwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de CCFB64465F69
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from workknecht.fritz.box (ppp-93-104-0-143.dynamic.mnet-online.de [93.104.0.143])
	by smtp.blochl.de (Postfix) with ESMTPSA id CCFB64465F69;
	Sun, 20 Jul 2025 13:56:00 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.2 at 472b552e6fe8
From: =?utf-8?q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Date: Sun, 20 Jul 2025 15:54:51 +0200
Subject: [PATCH v2] timekeeping: Always initialize use_nsecs when querying
 time from phc drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-timekeeping_uninit_crossts-v2-1-f513c885b7c2@blochl.de>
X-B4-Tracking: v=1; b=H4sIACr1fGgC/x3MSw6DIBAA0KsY1iVRrJp21Xs0jUEdZfwADqi0x
 rvXuHybtzMHhODYM9oZwYoOjT4hbhGrldQdcGxOMxGLLC5EzD1OMABY1F25aNToy5qMc97xOkl
 jgPzRVgmwM7AELYYrf39Ot2Qm7hWBvEofvkQiVwHSYOcUqrnKYBu6Va22CHI0XpplG5em9z22W
 irxKvzU1b9R36Ux7Dj+bv4JV74AAAA=
X-Change-ID: 20250720-timekeeping_uninit_crossts-c130ee69fb1e
To: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, 
 "Christopher S. Hall" <christopher.s.hall@intel.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 markus.bloechl@ipetronik.com, 
 =?utf-8?q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
X-Mailer: b4 0.14.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Sun, 20 Jul 2025 13:56:01 +0000 (UTC)

Most drivers only populate the fields cycles and cs_id in their
get_time_fn() callback for get_device_system_crosststamp() unless
they explicitly provide nanosecond values.
When this new use_nsecs field was added and used most drivers did not
care.
Clock sources other than CSID_GENERIC could then get converted in
convert_base_to_cs() based on an uninitialized use_nsecs which usually
results in -EINVAL during the following range check.

Pass in a fully initialized system_counterval_t.

Fixes: 6b2e29977518 ("timekeeping: Provide infrastructure for converting to/from a base clock")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Blöchl <markus@blochl.de>
---
Changes in v2:
- Initialize entire system_counterval_t, not just use_nsecs
- Only initialize system_counterval_t once during instantiation instead
  of every iteration.
- Link to v1: https://lore.kernel.org/lkml/txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo/
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a009c91f7b05fcb433073862a1b1a3de0345bffe..83c65f3afccaacff7a2e53e62f32657c201fbc8c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1256,7 +1256,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				  struct system_time_snapshot *history_begin,
 				  struct system_device_crosststamp *xtstamp)
 {
-	struct system_counterval_t system_counterval;
+	struct system_counterval_t system_counterval = {};
 	struct timekeeper *tk = &tk_core.timekeeper;
 	u64 cycles, now, interval_start;
 	unsigned int clock_was_set_seq = 0;

---
base-commit: f4a40a4282f467ec99745c6ba62cb84346e42139
change-id: 20250720-timekeeping_uninit_crossts-c130ee69fb1e

Best regards,
-- 
Markus Blöchl <markus@blochl.de>


