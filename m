Return-Path: <netdev+bounces-200914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB1EAE752A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7475A5097
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBEA1F1927;
	Wed, 25 Jun 2025 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSVfGMb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7F1E990E;
	Wed, 25 Jun 2025 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821096; cv=none; b=T8B9K0MowSbPDG3zrJ9osM+RQvcFdrs5ykwkmAfX2IUHrZ95mfKER5GeA9kS371SwGOohp4NgYEWEHfnYi1qtD6ymns99Bnhva5DR9ePqgI5C62r6KwXEVSkhAPO6FHORCY168VJYLfjHinhm4ul6YbuJSvhDt0ZjzA20rctFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821096; c=relaxed/simple;
	bh=asr5uTUioL/0h5I0aStm17Mh+pOtbR0ofOQLjCqfd+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6CjiCKRPkizY4sEuoweK/zprZWPVpBeRr0KiL9iTWijCxj5BCA2yjUPtlee7HrWVzyhJoamzTeh5Qsu7j6x2+bIjffM2R+bD5diXOrESAJWzVUoSGrLgfKuHKWzCeDqJyls3BOXwMX1ODTLeDGkJ32mFBL0K0ul/JFe8m1NJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSVfGMb8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a44b0ed780so79452271cf.3;
        Tue, 24 Jun 2025 20:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821094; x=1751425894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=678FLBRyV/EGtYHAvszDngJJOFd0kRmHfL4yh1GGT0U=;
        b=gSVfGMb8Dz+etAOKYW6FEyv6s5YVXoFJVGWONpWVrBlw2lUghmo+98rs+pfRcw3Odz
         uA0968tmTFOO+bunC/7kSlWPXgLEID310gjGQnf9VG4L0Fq+CNGQT9CEkKA/UZqtf8mz
         FAo6bLjWVvHXrUliqPn377eKuc/sEev5HJTCD86HnAcsblrVEr7OAbtBHF//i7iDmLYh
         g5uKjJkjfa+CWtFr+h3acE/46+XaBKSf1QLymt0HzANkRb7Pc9vLcdiJiG3+IqnGjr4C
         F5EDWWI8fRIjbL1bObL01nIW3vXj3CkcmfqJHM4MX7gP8vlmbLwbbCLSMFxWEIpUoFZS
         xNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821094; x=1751425894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=678FLBRyV/EGtYHAvszDngJJOFd0kRmHfL4yh1GGT0U=;
        b=UdwImOPhEFg95tOcMPNMXAoPen//tSk8mPzdYvIRa/hU5M0RD5qyuyCPjN+dY5T+F1
         QftDRG52rIM4dVds90lgFzJZIz/fNWLFLv9PDMtlifp4sXZ/5/F31+IhhHRrSAcdJyQ0
         m/vB3rq3ADxhUim9BC5lqAlRu2/QU1qVXP38QgarFhROFekzE/H3zpQqbilGYDhwKr7n
         Gjlp6Dzbrnwr40oj5voSh1hDlCk7tdjM/WxvGs4+/wXDRDPxMffQAxBYvtXCcTV0dNqn
         K3IwaEz2Vputt6+T+5PLtiAzw2lkAXTKhRwAHJWsRTCANIXPcjxQgqn7LCwh1yRW775d
         A7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVmZOziImLPMkSBxUL7x7fW6xVZgQrhXRwswLAcHrpS7+T0yTb0Q9HQi/ouVlNDJyoGUcqK@vger.kernel.org, AJvYcCXfMONElzGggzJCeQL5RFeQa/Y2Vb814wFgb/t52yn8Y5YdaKYhsu1bV6N4F80ZSxOK5IFkjIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGiTLzio5lnMMAopzDJ4CsJGKQhoZO3H4yO+DEU9hFbrSyDvp
	kovpOaoUvO5go9+K6wXpem9o0aBJmfAWFyi11MHc20/lL5lTlCQ286oY
X-Gm-Gg: ASbGncuyjy2FF57b5qmTbfMgsexLo2FBfv7oGAjk1pEaPKxUXxlzx5fPZwthL/ngHEK
	qavdW0IN9VzsV1M9oT9ddfk7UHs5HolHOp9njDV1WmuHrvQ98Hxg/fBYx51+/QcqcrmR5iojklH
	SyT7aUPGsF7+T2P4Y+lcODjd++o4X562vu4sDoUfoegZD1jpZCj1h4E/DtyJmoamNjYSeAYJldn
	n3S/HaftQo+4rZyk+k2M5cmofB1/TVC3Gcg4kfgipoCtoKtXFMWSBGVcgVKHo4AtSsiy68fMDnd
	zIezoh8Tk4A7ykuEeDqb6QSDl0BUu/tlW75TctzkULaf+HtGs7szGaPFFHllxr7CDsiQaxsWbgs
	kNcNTBMZNwbnO0mYlk3V0eIW0IrNz/rWLrHWgc1wmItf7iu5DAXnZ
X-Google-Smtp-Source: AGHT+IHLBlxfOfHRIysWYSzviK3Jt4IAeQ/77Q8AVFjgBBxKd1sBVPA9U6rgMUaVbnw8S3yFqLBbuQ==
X-Received: by 2002:a05:622a:40b:b0:4a4:31a0:68d1 with SMTP id d75a77b69052e-4a7c06a01cfmr29966041cf.21.1750821093620;
        Tue, 24 Jun 2025 20:11:33 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e910c8sm55291021cf.71.2025.06.24.20.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:11:33 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8C62AF40066;
	Tue, 24 Jun 2025 23:11:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 23:11:32 -0400
X-ME-Sender: <xms:5GhbaOYlPijW2zGQLp-tci70MsuyqTwoEdGALxVfJMoLAp3uT-36OQ>
    <xme:5GhbaBbjgKSUjtzUVVlOO36QTaobTv2fvXjBt-QNhwIA_SoP3dX4fxIAb9oWQ_dbH
    LnP2vaayRx1N9-c9Q>
X-ME-Received: <xmr:5GhbaI_Mjjo5nerOH4VbQOOe7d38PJ4pEwRqmU4sixv6D4rohAJH2ZoEUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhm
    mheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehpvghtvghriiesihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunh
    drfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepuggrvhgvsehsthhgohhlrggsshdrnhgvth
X-ME-Proxy: <xmx:5GhbaAr_TBWtPG53LqEuT_uYVB3xz830E-QeXFrrSMMtqYIL0Wk0hA>
    <xmx:5GhbaJpXZ0T4pKU5L1noz9wquu2Qrk4uR6Z_gmWi0VPBwIkA9c_SRA>
    <xmx:5GhbaOREk8cJkb9k-skbfy16FrYP-FxNoEzrQfiMViwc-Z78TVSyIg>
    <xmx:5GhbaJq-ZvZPtwS9S5X4hzz8qcAleb-161Cc_1uDyaWDn0e-EnbLzA>
    <xmx:5GhbaG5QpoNhDgvVmLxLdDnB89yMuLnpmHHbFEakTqiJY-k76XHB64g8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 23:11:32 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	aeh@meta.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: [PATCH 6/8] rcuscale: Allow rcu_scale_ops::get_gp_seq to be NULL
Date: Tue, 24 Jun 2025 20:10:59 -0700
Message-Id: <20250625031101.12555-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250625031101.12555-1-boqun.feng@gmail.com>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
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
index b521d0455992..45413a73d61e 100644
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
2.39.5 (Apple Git-154)


