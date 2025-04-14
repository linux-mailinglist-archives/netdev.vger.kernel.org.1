Return-Path: <netdev+bounces-182042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C3A877B2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEFD3ADFF1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90171C862C;
	Mon, 14 Apr 2025 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNFJBilc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0F1BEF7D;
	Mon, 14 Apr 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610490; cv=none; b=f+TePK/USjqLReOSXgZJTMAdborS5TRzUZ9BoBZSzM0dlgK++TKyWe4Kq+RKXl57HK5PiEa39S+c9fSn07gpetplwNIpqSnAlG2jh1H3vfOtQLln9TtmaxFZ+NBLs1Oi8Tp5cfCGs1wbvXTwWncL6uUMQcsJiYikkkvk5JVryiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610490; c=relaxed/simple;
	bh=cPAIxLpCJd/jsKJtkLMVLNpBa5sHhRlJb5p/IMXI0Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ocr7jIGf9/i7btwFVLmoTXwYg89B+zUR2ndBROWDBzalwOnIVLD/18CmzgoRSCsJDN8ZIaaX98+B5oFKNjo+Bz5Ey2WkWC1Zd+MBKxaZyBdeNqjfqFBernXJztmT0kjrhIr9RyEuPcJmwZJHLxH9kedlkIngK67U+UtAQjrKprg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNFJBilc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5ba363f1aso539441785a.0;
        Sun, 13 Apr 2025 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610488; x=1745215288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G1QmxPKlOY2AJ0bwfuxV24rh+8soVup+peq0V7qXYkg=;
        b=iNFJBilczHPum+QZwwP7VKiWrR3hoPdPmwJmuFlnXz3VQUCgWewPWekg5sswW3yUnv
         P37gN7yqcaj/pEfG6inKsey4Ky23uqiY8jTvhkG11Z4zHtJ6ETp/YgC1MPDmJc7U1dN2
         9p5yFa0KOWXnEaoKOkUy+qifk9afUytJU3trdIMFhZAj/p+v/x7JYVzR6pLUAkcokKLO
         Tpvn+1Tc6hX38KRLABfOO8KDnkmRW/blapfn6V0qJzN+wisJ2JgnOICGkR+urHrcoC6f
         E5D0dUMgJNNbs0fklcwVJlIkvj4yR6ZbWI7Y6ukj0mEUixZx/iCaHVNx6TqMiDtB7Ich
         35GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610488; x=1745215288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1QmxPKlOY2AJ0bwfuxV24rh+8soVup+peq0V7qXYkg=;
        b=ViBlomGRhc7m2Bb93UE0W0bD7BuhZAIJdsMq75LiPPHkvbRywBmI1YoAALxppbbzn2
         idiDhozesVU92hDVrafX1U0kHFZ8UesevoK2Vk0N0EhoR5FhwliVzIosbhuKlpEUF6yk
         mePT/Ro5F2Fa3Z9wNvptfkV0vadR3AGTjSvy6O1S/dlOr279GnkgRddiW+TgK/QOtUd4
         MR9HvBfLele7gLxSiymScWRrl4VcYiZLiYNumnkGnVbmfxGFB10BIIoLfgRGSf1GXuNS
         J1TsnSXaTe9RTysT+ffphr8HIe1LPtxb68JgX8GpL0YZVJpS894UDSKIfMOdDDzveh9l
         GOWw==
X-Forwarded-Encrypted: i=1; AJvYcCWHlSjsabVzeot+TpMOEHlC81IwYxJLPrAMVFZ2TCUE/pJm4r+nAtecqzzNcwyXf05Z77Mo@vger.kernel.org, AJvYcCXP945JKQ8dRqxiy3QJfFVIHxptbFpsPmwXwFjQHqLKYwybeNP4jdF0dpM/CjzcpQJvu//BSNJH5dygYQM=@vger.kernel.org, AJvYcCXgxbujlxgdOkS3L3HdDXsOjqGT/rSZ1oRlCwTHFiFPMpuX0rkRvkUB2XIzU0++lLA9ZI3kojHV@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTqEXXmaBb57JqXCduuW024d1z3lnPxG/UtK5xChkEpZk7gAy
	XreMQ9Hz0y0eQRQ403e5Xmlw2bSdgODYX/Se/X9fGC1Nlk33BK09
X-Gm-Gg: ASbGncvK2SU2NMqhxoQQfNAzmPHEXsNaYTGJZZ+oAupzrORI6MME/EHgCAGtMevp3gK
	6RgmQ4Xv9NBY4tEhQpPWCKb1dSK6cLR9tpds17JumjzfP4uYTkYDBu96SfKgx2rwN4fSZQFzOPc
	Zuj0CSq0rp3tCV355As3pLzTi9oFKYqAYL9kuD+4jxGo2GnWLck38Tt1HrU+yMwZproHymmab4r
	1XIAiEygBGqz2Owov/nNZDluElAGYV4lLXAPzFSwSJOzaIRbB4Zu6SPKd8CMwTw25aef1GcMQza
	2MltI1fQUlfQg0psZh63QqM51tPrEEUEMegNFCdRMGs6+Z5hIL8O03CcKKw9frkicP2K8iemdQT
	uK9c0MGUm4J2T+gXcTswbLruVHc1klGc=
X-Google-Smtp-Source: AGHT+IEkDKGgjvm3RVX2cBPaGJLH15qauFWnGGanryIKVwCwoPAa7fmI4pjLTlYeFgZ79MAusuX89A==
X-Received: by 2002:a05:620a:280e:b0:7c5:6dc7:7e7c with SMTP id af79cd13be357-7c7af12a073mr1532923285a.26.1744610487682;
        Sun, 13 Apr 2025 23:01:27 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95f7a7sm78160046d6.13.2025.04.13.23.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:01:27 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id D3F181200066;
	Mon, 14 Apr 2025 02:01:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Apr 2025 02:01:26 -0400
X-ME-Sender: <xms:tqT8Z0p82G3YoKdcib5y9ag8dRTrEDyQJOkAicF53ra2x0rUJUw0Xg>
    <xme:tqT8Z6qDBU2do9rvacisrkP55FLWLlZz2HUwKoi7USQfGRrQnefBbR12GcaujYSGL
    ul17rvXiYqNJxx6wQ>
X-ME-Received: <xmr:tqT8Z5MjvIOqwZQeAH4z0Es0ZNBkCQGshuFIRZFpgl4TH84cL0Qw7jN7p2LcXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorh
    hgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegrvghhsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:tqT8Z76jeKnIWq2GoQJ9CG6lCp-gdKDtmhM_3wUATUgNd75GobDtzw>
    <xmx:tqT8Zz4w5n44-4n4zpRAH5Ken6j4pzKiBBmrVExMmBiWw7BEHJM1oQ>
    <xmx:tqT8Z7jaaJWESqbqxO_bII36-0qVVm-yfH0fD6a7Ew-Wf4WsIeDVXA>
    <xmx:tqT8Z94BZHYp7jjgsKQDDHe2IAoX_9k7ZH7tEFZJx06eOcdn8RbcRg>
    <xmx:tqT8Z2IMm4dz674ld7nSiXJMTkGrRDptm1gaZ1BtE1CZDp4iy6c17iLs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:01:26 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Breno Leitao <leitao@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: aeh@meta.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC PATCH 6/8] rcuscale: Allow rcu_scale_ops::get_gp_seq to be NULL
Date: Sun, 13 Apr 2025 23:00:53 -0700
Message-ID: <20250414060055.341516-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414060055.341516-1-boqun.feng@gmail.com>
References: <20250414060055.341516-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For synchronization mechanisms similar to RCU, there could be no "grace
period" concept (e.g. hazard pointers), therefore allow
rcu_scale_ops::get_gp_seq to be a NULL pointer for these cases, and
simply treat started and finished grace period as 0.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcuscale.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 0f3059b1b80d..d9bff4b1928b 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -568,8 +568,10 @@ rcu_scale_writer(void *arg)
 		if (gp_exp) {
 			b_rcu_gp_test_started =
 				cur_ops->exp_completed() / 2;
-		} else {
+		} else if (cur_ops->get_gp_seq) {
 			b_rcu_gp_test_started = cur_ops->get_gp_seq();
+		} else {
+			b_rcu_gp_test_started = 0;
 		}
 	}
 
@@ -625,9 +627,11 @@ rcu_scale_writer(void *arg)
 				if (gp_exp) {
 					b_rcu_gp_test_finished =
 						cur_ops->exp_completed() / 2;
-				} else {
+				} else if (cur_ops->get_gp_seq) {
 					b_rcu_gp_test_finished =
 						cur_ops->get_gp_seq();
+				} else {
+					b_rcu_gp_test_finished = 0;
 				}
 				if (shutdown) {
 					smp_mb(); /* Assign before wake. */
-- 
2.47.1


