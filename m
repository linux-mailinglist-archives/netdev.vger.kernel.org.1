Return-Path: <netdev+bounces-48394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38E7EE3A4
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD681F27934
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B535892;
	Thu, 16 Nov 2023 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bNO6R+QT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF63FD5A
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 07:00:03 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-778940531dbso50202785a.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146802; x=1700751602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=bNO6R+QTsep6z1nTrZov8W3y3hKuiXJMn3lhrVntYFOR5afUi6SLd4/EZBMAyAFo8R
         omFCvcRwbJvJ7vjIApa9IUlm61wKsvMrc4d3MVZHIR5kq2JQZhMtVmuSVx+mrKVgt2rw
         vM+kOJSq03MbJ9Fygj56GzQ61jjNeDhk97e7u/MJK1mXcvOmlGf/8utBd6SIezOZIdQy
         zBHVC3KUxIWyqkLXXuuWXKMznVmZ5eONo/CC0qepXjRPuvx7lYynBjq02bVKy6hWZhVS
         fLWWBs4MJMCpyDdoI2ejB39r4ZUZMiBsjjmE8Nr4cFU9zkk/0VKSfatqGJ3Z3X5RDK3z
         35vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146802; x=1700751602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=GO6+nWqADAHQaOjE10YPswY3waYTXDQMm8sHK1AewHI64P/H+SaHtxher2ovvKgRok
         f4qdiMsyzMJhmnOm7aRcMHOiI5HHrh8OyfjPzo4E9JGBPX+YcwEk3+JHkWLgv8WEZQdW
         gclmjG9ev4tZRldgQussjyLhqzzBGt7uXI13kLChzfhvnDiXbkxknc3WQEHJE2RG480I
         pyU7p+RsRX5coat1L/ug4E2d7dEAEzBW7gzFUu1AzI3EgtkNSbVR3k1gcpl2cMLY6gTI
         FI4ZdgXCJJsJhBoFZfAhlhSzI0by5S/rpVVL+/T2u3WO8DLRQTX/BudtHMgN2VX8EkrT
         bnoA==
X-Gm-Message-State: AOJu0YzcjFqgh6SJFbH4MdNUZ8kkgtJzarfrINDXO7L4OBy2Ze7qYnhb
	ZwVdnHdiFssk6HQbcJj4tBQm+xIeSfQKvlV1Bts=
X-Google-Smtp-Source: AGHT+IHs0eE+Rz5RtW/NkgBtBUh2ZsO2FAMgtjwGD+IhA1Y2LoYqS7iHTkz8mb5/MStz9FX66VMuQw==
X-Received: by 2002:a05:620a:2889:b0:76f:98c:3f0e with SMTP id j9-20020a05620a288900b0076f098c3f0emr8378471qkp.68.1700146802447;
        Thu, 16 Nov 2023 07:00:02 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 07:00:01 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH net-next v8 07/15] rtnl: add helper to check if group has listeners
Date: Thu, 16 Nov 2023 09:59:40 -0500
Message-Id: <20231116145948.203001-8-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116145948.203001-1-jhs@mojatatu.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of today, rtnl code creates a new skb and unconditionally fills and
broadcasts it to the relevant group. For most operations this is okay
and doesn't waste resources in general.

For P4TC, it's interesting to know if the TC group has any listeners
when adding/updating/deleting table entries as we can optimize for the
most likely case it contains none. This not only improves our processing
speed, it also reduces pressure on the system memory as we completely
avoid the broadcast skb allocation.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/rtnetlink.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 971055e66..487e45f8a 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -142,4 +142,11 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
+static inline int rtnl_has_listeners(const struct net *net, u32 group)
+{
+	struct sock *rtnl = net->rtnl;
+
+	return netlink_has_listeners(rtnl, group);
+}
+
 #endif	/* __LINUX_RTNETLINK_H */
-- 
2.34.1


