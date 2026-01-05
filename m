Return-Path: <netdev+bounces-246828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA0CF1893
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 01:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F247300351B
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 00:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE492BCF43;
	Mon,  5 Jan 2026 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGMpH0sd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F67A2F872
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767574753; cv=none; b=n/s1FDRbhjhx3sfoQ3gWYY5MO8WBkO8i+rKU4zrvWt3STJKIAywFkH6PgenMu+F3T8R8/aTCWRqDo3vrTKMZk1yyhx1htrymqv4VQxtZK0M5o4DzfZQV18Ll524yECtJlKds84FZyFGIPpc8lx7nZP9Jx/kjTZSWiMNPqaENMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767574753; c=relaxed/simple;
	bh=m96MFa3x8e4FGlWO6DaZSmBzfv+zmnOSQ9VL159FjGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdkxnYSXli1GDyn9y2oSUaDO+SNnK2b/OHhj5ORTf/TiB0MxLXnVkcHP0eA01kxK79Xh5WUilj32TwA3FpYyzLLOjgzwO3K3rP7JgeNCb7aQ/Yy/fOJds7jPz6aXCznJzw8tYTLMSjU5xNZOpX5GQyxv//qft6+sOBmWX5G38nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGMpH0sd; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c6d13986f8so1024032a34.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 16:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767574751; x=1768179551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr6CL6ryUgvflNaOxP8c/DQAuzEeK0UQJCdZNd07Ekk=;
        b=OGMpH0sdwC9y25HFGzCnFCjI7cEG/G9HfNigcD4qKhrVZwCl51nON8xi4LevjegChO
         4GK5p5+mzr3AYdHdZK289aPyNveXffSqA50p4GkSDFs3VTScHxOmR175IkPMpcLfnmXy
         AbnwpE/WdN75naviGh0KiL0JO3cT2Vo2FbmjEFJTdY830plwHxmAFVKI8yZ3TnZOSvXf
         I38sQ1YEanRu0lebLvwjSCwDuukRaabajYwrL+bN2PEqxoVWVjfoCXCrS+85LyWZKDpi
         Bq1TL/JhyIeBc4o2Y6MXP8GZmOnhm8tHLZpsmy6vPAcXcxzHcZCxKzmcOBPMAbWzHQWm
         415w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767574751; x=1768179551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qr6CL6ryUgvflNaOxP8c/DQAuzEeK0UQJCdZNd07Ekk=;
        b=ie9+Td2HTMy3ZqdySmv8KC35oSgTCNQLbe16yZgM7XTMNN+O+0iG11YZeSxFrWZm4Y
         dueSoL4SNEivtIRdd5mBZYwggCMzebjHsZLaKU16e/4PB8Ybf3B98C4XPTtZAVm37ZQ8
         voj4HTw2ZXjeplriPlR1szDmW9gs7u7Skc1WMSFJPNMm+AWxeOyL8MqBjlZDVFj54LYz
         X4j4yWg/BbuyiW/nz6vXeqlWSCaUpCYGO9A4XTAjEIE4L7OknpRUM27XjbjFrKrMo1Z2
         S9ZLX7nl/468+HZq9xMOSqnCay6zKuyEijkKYYcM94IeP07ofkJG1AJjsntogQa7lJsx
         ydnQ==
X-Gm-Message-State: AOJu0YywfR1flGb7PH5v48kkn6fYPuI3xZrJNiiqbdI+xOD6OosLXBLJ
	1Daoz0ta0Y8RoMKme5m7nS66a8M950BgroWbKSnke+N5oOngeON1qVSysmjQpBto
X-Gm-Gg: AY/fxX6J8ac3g+sVx1WM0rrjcGlThAfaKK/EsDKd78HWfwSWLGg82GgrC31QFr+eFHP
	nytPS5LBSQ8h0f75sSdUmSs5XDrUWotFt5P4MQIL9vW113aEh0b8rd68xwuQe/hoCv3sqgNu2Vn
	wE89LbwTwkX3STMufrNIAp+mirEMt/IToS2BEHfeR42K36NAxOKAmXu/+epRigjAX72HXTzVCOY
	0sirkeff+hDJ78Yd+EgUEQoCGwMHHVcoukTsCLxxuWzOeg/nuofrOGhlZN6faFpPL8nDZCbIF9e
	PlBCPpcZKFC/UaFkpJaRXvximnB06lOtC50IyytRUaIpZadhgt+LzwylNQoC4reXkpcpdiajq2+
	cQoJZai3dX9JTrz9BDzhAFkjd7iNdEZqrG5H6QOjQ+k/MY7l2W5ANsC/5A3WlHxyVHY8NyPvONj
	Jd+3cPZgM5ZyxmjM2QGIbyM31Uwy0wNUdACN0vjidgoUE=
X-Google-Smtp-Source: AGHT+IGS48Hr0VVCmwPxOlboGr8KgZOtnvBFq7n3uRB3SVLRxLIoJAKMDjCKOIQCYrXwsJjmgs5E2A==
X-Received: by 2002:a05:6830:3c1:b0:746:d097:9342 with SMTP id 46e09a7af769-7ce2bfacb60mr2724660a34.7.1767574751064;
        Sun, 04 Jan 2026 16:59:11 -0800 (PST)
Received: from shiv-machina.. (97-118-238-54.hlrn.qwest.net. [97.118.238.54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667f9201sm32509377a34.26.2026.01.04.16.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:59:10 -0800 (PST)
From: Shivani Gupta <shivani07g@gmail.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	syzbot+8f1c492ffa4644ff3826@syzkaller.appspotmail.com,
	Shivani Gupta <shivani07g@gmail.com>
Subject: [PATCH v2] net/sched: act_api: avoid dereferencing ERR_PTR in tcf_idrinfo_destroy
Date: Mon,  5 Jan 2026 00:59:05 +0000
Message-Id: <20260105005905.243423-1-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260102232116.204796-1-shivani07g@gmail.com>
References: <20260102232116.204796-1-shivani07g@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a crash in tc_act_in_hw() during netns teardown where
tcf_idrinfo_destroy() passed an ERR_PTR(-EBUSY) value as a tc_action
pointer, leading to an invalid dereference.

Guard against ERR_PTR entries when iterating the action IDR so teardown
does not call tc_act_in_hw() on an error pointer.

Fixes: 84a7d6797e6a ("net/sched: acp_api: no longer acquire RTNL in tc_action_net_exit()")
Link: https://syzkaller.appspot.com/bug?extid=8f1c492ffa4644ff3826
Reported-by: syzbot+8f1c492ffa4644ff3826@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8f1c492ffa4644ff3826
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
v2:
- Drop WARN_ON_ONCE() as ERR_PTR can be expected in a corner case.
- Add Fixes: tag.

 net/sched/act_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index ff6be5cfe2b0..5e0a196ce66a 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -940,6 +940,9 @@ void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
 	int ret;
 
 	idr_for_each_entry_ul(idr, p, tmp, id) {
+		if (IS_ERR(p)) {
+			continue;
+		}
 		if (tc_act_in_hw(p) && !mutex_taken) {
 			rtnl_lock();
 			mutex_taken = true;
-- 
2.34.1


