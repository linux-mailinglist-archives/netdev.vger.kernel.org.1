Return-Path: <netdev+bounces-53057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AAF8012AF
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAF281D86
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA2651017;
	Fri,  1 Dec 2023 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="q5Vql7nv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069D131
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:29:17 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-67a35b68c34so13319836d6.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455356; x=1702060156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=q5Vql7nvBqtaEFq0Qybbrl1DM1khCLe6VCoKxes1PysozeVSdNFXNrtMoKVnC86V1X
         MdBJOp5gWh3GC+HOH8yOfOXDz54zmFvrt8iwm4mCwIZ6F0ayukj08vsLV31exkxVoTX5
         pR5J+T3zMg/SsCVlIMozdnGi48gtkPPiebUIit8TpO6cr+DPYxj1CrKXNq6cwnkA+L+T
         c85dxHKdaV3ITzc3nPrtvSQPogbEkmgbieI+q+whM03UQE749Hf/ToIieFn9ekw/jh8g
         CIsruGMpqVfsqff5y3trbED0Hv/kwh0mUxshbz5ispU7viEjHj0yN3YiP/PhGmDPRI2e
         dF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455356; x=1702060156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=hYgzg+DLi4Pq9YLsmprKyjJ04d7uUEiroPF5DvWcT+3MBB+lXB262GWEkoZIJOE5Xw
         msazL2duUklMHqVLVVbKYosqvgMrV5VTR9w5Ws+CjKOC04cclYK7beEinPehAGBlCfpb
         +xUU7ix3Zkr8tKvQ/gVs3874Dz0s+ApdnoOVsAn7M8shZbrb8trLUkC/epzvPuualubt
         APA2Lz4a6fGX2Sb9Lp7lMj/ogvKW5G1+mbzYQWP1UfAmww3Bks6tMadCM1rwhsttyzEx
         kFVNBQXuUjgt70hafF2b6eS33fWxSU5+WavNFwOKypc3cUH8CGfybm0vF8tq0QjBqt12
         t/wQ==
X-Gm-Message-State: AOJu0YyH14jkCnE2WB2jXGD1Vq5ddDuwnRnFqOjm9Xvl0AjtwLYUNJ2l
	KgwIE63koPE5PCOJMibfQ5xOOAbdcp9wuIfKL2g=
X-Google-Smtp-Source: AGHT+IF02JfTNKSARhCPX0BtP56SP2odh8C3TRc/IEjI11PQAtz4DVyGmUZbiqIBsWtDeFXttaAxQg==
X-Received: by 2002:ad4:48c4:0:b0:67a:3834:10a4 with SMTP id v4-20020ad448c4000000b0067a383410a4mr18047250qvx.14.1701455356608;
        Fri, 01 Dec 2023 10:29:16 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:16 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
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
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH net-next v9 07/15] rtnl: add helper to check if group has listeners
Date: Fri,  1 Dec 2023 13:28:56 -0500
Message-Id: <20231201182904.532825-8-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201182904.532825-1-jhs@mojatatu.com>
References: <20231201182904.532825-1-jhs@mojatatu.com>
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


