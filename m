Return-Path: <netdev+bounces-79711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA487AB11
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCC91C2120E
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC49A4D5A5;
	Wed, 13 Mar 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RdSU3EY0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F34CB2B
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347155; cv=none; b=Mp3jszhva0GdAW1iDghtZF5AEdydtYsnCYIy/i7rmOutrgDwTzVdVh+nJgruwu/96Df4IyEw8NpQmBQH/czveDI1+fk/O73kWHVlKMIevK8f0YCNX8D+mUBN1J2T2l9I4nrUn/QiuqKOBkYrtgzB7xbKiZZcPsK1Uk3AM2FQv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347155; c=relaxed/simple;
	bh=waophCxTcodcZBiaZRBq4Vcy/9u+Db/aHwd0TOyESlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjNGCYBUrU7qpuaboIxw366T7rXYAQzsx+JCFnGi99sUyRyQlda7S4tY/XIKJRRqaKgVx9uDjAy6Z/htkfoR2Q2b/pUgjr7v29b+64R6vJ8yDHQOMWr8WkTQk5M7VLlcM06uKXSeLteguG7uGkjQHkNe4C9XUYL+ubuPl7DTYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RdSU3EY0; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7882e8f99eeso800485a.0
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710347152; x=1710951952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hz52VDhsyBUm+rkXRTpJXcM4FSy0vt7HjYW4U4Q0pQw=;
        b=RdSU3EY000ormZCobNVsi8X8ZcmHO2hUrQybNRFpiTKEhAbnstxVmtInPHXSt2aKxb
         PS3A5Z9vFgtBWo3OPKELMRGKXRFnYFn8oEm0OKdRZqBg8XqlpdTDHmYxlpIMgtpWIHro
         jzi7Vw1k9/zp0D+bp8lbe8/J0BOahc1XAJakEumFQ0uR9j3An0CbhrWPdBJMZc6eUzy1
         zYo0kk+DpgXL9eMpD62O/sjKMw4puhi8quHZVoOpGurS7WHZkzM4GR2S6jxq55FJZFoc
         jAX2H1BZSlt7eZcJQ/IwKdhWWSjdo/fakbvzyJD7sBBG28olu8Ns0gmSrQ9khAJMSaXx
         P/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347152; x=1710951952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz52VDhsyBUm+rkXRTpJXcM4FSy0vt7HjYW4U4Q0pQw=;
        b=hsuGCxkf/aDM08NJ+RpTeDmHRUQf3e01D/8+sTqeRKJD5kgzpVMJ6DH+9vMYchhZGJ
         b97u5rOfbl/kB73+igcA1WBfsefaWNBzaEKaDCY1pzWNDtDes3TXIDsRipYE1eCDaWyu
         M7V76f+HJ6Xhp9O1PZVlLl2qJGAo97wnQtYM536dQmgZxMt1FlGph8aAE9peP4mV828I
         jlFV9VoBW3FDiA5Tz/CVXDu849U0nxEvxO1kM075O5c0ppYzjzuvY7gh1ki3tPAFVfwX
         s0HpggOl/ZBHHBtj/vRtleKOI2MwclvJyNacGTXplYquIgzmEc1ybOQDSrSJv6srKwwf
         2bTQ==
X-Gm-Message-State: AOJu0YxowrHRAOb2P/hICCBjXkFFbI1peGpLj8w+/uhXRzl4RQC0CBv6
	HwvOSpRE0QQM5SOjrKsj0m0XFzUzxENHsCRkPNJat8F1BCyETOOvGKALxF/f0v330jvswAQJ9A6
	bYaQ=
X-Google-Smtp-Source: AGHT+IHG2Wo7WJzKa6z0HU+as2odTaqY/F5UrV7eoi67pzTk35M3ZippREVklQyBwoPl9T2v05w+XQ==
X-Received: by 2002:a05:620a:28d1:b0:788:2dd5:6f12 with SMTP id l17-20020a05620a28d100b007882dd56f12mr467010qkp.67.1710347152457;
        Wed, 13 Mar 2024 09:25:52 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f91::18d:37])
        by smtp.gmail.com with ESMTPSA id az39-20020a05620a172700b00789ca2c923esm818990qkb.114.2024.03.13.09.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 09:25:51 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:25:49 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH v3 net 1/3] rcu: add a helper to report consolidated flavor QS
Message-ID: <f71214e6221c5c50b32a62a33697473c756e604e.1710346410.git.yan@cloudflare.com>
References: <cover.1710346410.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710346410.git.yan@cloudflare.com>

There are several scenario in network processing that can run
extensively under heavy traffic. In such situation, RCU synchronization
might not observe desired quiescent states for indefinitely long period.
Create a helper to safely raise the desired RCU quiescent states for
such scenario.

Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/linux/rcupdate.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0746b1b0b663..e91ae38c33e3 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -247,6 +247,29 @@ do { \
 	cond_resched(); \
 } while (0)
 
+/**
+ * rcu_softirq_qs_periodic - Periodically report consolidated quiescent states
+ *
+ * This helper is for network processing in non-RT kernels, where there could
+ * be busy polling threads that block RCU synchronization indefinitely.  In
+ * such context, simply calling cond_resched is insufficient, so give it a
+ * stronger push to eliminate potential blockage of all RCU types.
+ *
+ * NOTE: unless absolutely sure, this helper should in general be called
+ * outside of bh lock section to avoid reporting a surprising QS to updaters,
+ * who could be expecting RCU read critical section to end at local_bh_enable().
+ */
+#define rcu_softirq_qs_periodic(old_ts) \
+do { \
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
+	    time_after(jiffies, (old_ts) + HZ / 10)) { \
+		preempt_disable(); \
+		rcu_softirq_qs(); \
+		preempt_enable(); \
+		(old_ts) = jiffies; \
+	} \
+} while (0)
+
 /*
  * Infrastructure to implement the synchronize_() primitives in
  * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
-- 
2.30.2



