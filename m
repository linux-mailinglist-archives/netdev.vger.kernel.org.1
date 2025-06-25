Return-Path: <netdev+bounces-200916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06246AE752D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA0217B000
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3836C1FA15E;
	Wed, 25 Jun 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2pVApyt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC611F4611;
	Wed, 25 Jun 2025 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821099; cv=none; b=hSTfpYQWaJqneDR9kaIeEaIJG7BaeVNfLUT3uFRmh6SxYkmXIJqT0wo32NYkZ5+lls/KefcuSpYhljOH6pI1h2+CEdM71Tz4wTHd+UA5NTgXQ8DTgdMyYSTWbJxI6ovNzUMVn4El4/EirdGcdYW12UuXchNNvFw8mEJ1ll9alNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821099; c=relaxed/simple;
	bh=A73pes+JuDp33aVXpLNlEeOGjBrNNA3VpTS+s9bm4yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoSclaRNcZtO7p60HM5+dcakTu6mvBJA6oAHOO7E8Ju4Cq6NgtAk+0SLe9UTl/h3MZcsbeBRPhOqpaT5ofv51+oBdbIpQU9PHrhrFmdLODfZXLmDnpsalb6BE9YLr3lq76G/QhW5G0jaBJev/cEKb6BlGfNhQpgTckSdYrnjcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2pVApyt; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a42cb03673so13756811cf.3;
        Tue, 24 Jun 2025 20:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821096; x=1751425896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zuqVIBjGXQL3Pb0oRS7JXPWUTOWoDxLBBUTqhc/Fk5g=;
        b=A2pVApyt9GS4pQ5YYfwGwcCEoaKVm+tuAik77YJUHLRIVotpF+CeaVRgVmgWrwXiv5
         DJdZkBJAtQ8ngvfps6uV6SFv0Ot/M0OpvQTpAl/s3rkWc9FbdxOSX+CTZMn/PhXZmnRb
         m5wr3Dws2PY7ZgulJ1unaLgoEMbh8cT9AUwBwl3M3dxGQmSuPbsl6XztKlYbwNRBwhuX
         9zCx9D9IgrdOM0V0Sda6QmFwBlqQJAkJ+qZ23mM27aVeXlMqG7Jt/jbQGBBZkq7BtcwG
         7DmBmriO9GpcLXYQWU+kAYBOVblcos4igIiOwEaGX6MqcBNM3CyLKsn1QM8i/2OFsYN4
         aQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821096; x=1751425896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuqVIBjGXQL3Pb0oRS7JXPWUTOWoDxLBBUTqhc/Fk5g=;
        b=bub1QYRWEwvI7/UniPwzYikvpjq6nJoCObBj/aRZbt7vgMRRZpiH2KpqVCYpW6T3PK
         tOnQsH/0PmPHegEUOMMMWi/XNxipnp2AxX3Ji/AIxtDQEoEoBYsRK+IBYL3W3Pte2GAk
         LVf2zLHIocAyfemEeDkDRBVyw3bhvL7ULlmWAHKhgHoDxwHjblwYrpmjSNHYGpQRKNoN
         cSP3t/o7Rkkho9HOVk+lhoXshxiyIZj3Lmc+GOx8BdY5D1334tWixveNxLd6JrT/8HKg
         lndjk6qUa/x2dT3CWhkVPeRkbRGYKHQHCigInM2REGsQt0JY8UoFhQ8QHGTxFpMgcg6D
         ZuiA==
X-Forwarded-Encrypted: i=1; AJvYcCWeNg8wI1Fr0U46FhKrnBLRz6PDidaQVsrmNfgpQa+psPyWKsYu9og/1iWxi/KzpL5ySB6N7rA=@vger.kernel.org, AJvYcCWkIzu9JsnUNRv63CRSdVeIbHmjapx0S6Pra6PWxJQgp8WDMkvbAr8ImmoAlHx7caRzZyfW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HEJYYGfZOqEf3qd04K5jLpLFJQ10ftYl9wGGRj0e9cpnC4qx
	EyMZVAirI4GXcLIBfaylK+ZDaRlpo9Mo3bmMhkCC7T0DtQGssK/O9yWf
X-Gm-Gg: ASbGncvV2hDcjdJjIr8P3yH8YXk+l1RIAU8A9h3hPIWmOfLT+elEQwZlu8t+DyyWPav
	nveTY+B5Z6EZ6Y7zURtVHx0ULBNhgNNkh4l7EIoGx5eqlM4KL7o94vDygKItnQImTM7P/jpx93p
	18C3dYAnFVGqej4Uy2H/6KH1LUwZbfzmuR3t+CSSbwiKJxxzG93q1G9mxRdCLyMdEEiZ/lgA2q2
	5cGG2d96EP+po6JkiCG5ldCgjSfVKz3D2uwgjAgtzOocXBPhbzOXffh0zAlC++m+fTR0K/rbEZo
	HTK+Ga5ZEEKUhsm1e3X+kFAYEL9VyDHKojWu/UziAKABSSIZ8tQ8a1vD9aVX/tlKE0zA4ODIKX+
	LGWeugi8JegRECNxkHEfBRIgBKt1DlNsW6aoxy7TRckoeheHyQKOK
X-Google-Smtp-Source: AGHT+IEbJPBHSvbUjLDI/ho9eHxTAS4JXGBSJ1tuasc06odARRqHpanKjW7XTONtNu3DCCjVSio2Vg==
X-Received: by 2002:a05:620a:bc9:b0:7d3:f3a5:71d7 with SMTP id af79cd13be357-7d42973f34emr215814785a.40.1750821096186;
        Tue, 24 Jun 2025 20:11:36 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f999a566sm570896785a.8.2025.06.24.20.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:11:35 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0826DF40067;
	Tue, 24 Jun 2025 23:11:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Jun 2025 23:11:35 -0400
X-ME-Sender: <xms:5mhbaC01JPxbFccv81BMVkJ4tEmhk31iu2PVX0MTK5fjwwYj8ufJcw>
    <xme:5mhbaFEuozaSCkHCvVzkMQxN7pAUO5HOXV_ldARR8Rnfh5dGH_gsh2TAsdIywT9e4
    RS9DxrxdP7rKVZ8mw>
X-ME-Received: <xmr:5mhbaK7WI8cSYmHV6moATZimuQIToczmFhe4VoW3qhdQt3vA88DZul1j7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefgheei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurg
    hvvgesshhtghholhgrsghsrdhnvght
X-ME-Proxy: <xmx:5mhbaD0obg6pyZ0mz_KgIsL4yG6n8dxY34eqykwaRYHoZjCCHsqcmg>
    <xmx:5mhbaFG0jVcxIqP7QCBiHDDXOKqzuG2GndcDI1hDcZX1V4KXq3fWDA>
    <xmx:5mhbaM8o6ZBcRLCXH5fbh1oy3ThmarYDv7A5k0oPkeaWGgrM28h44A>
    <xmx:5mhbaKnrYcFS1OBMgyTZ6bUlKo3Cb_BrPlU40j861bSuk21QkMikLQ>
    <xmx:52hbaNH55ybs0OUzatDJAZEmeLZudbgKUhu3XSgaGlkt1Xt4YPav0t7D>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 23:11:34 -0400 (EDT)
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
Subject: [PATCH 8/8] locking/lockdep: Use shazptr to protect the key hashlist
Date: Tue, 24 Jun 2025 20:11:01 -0700
Message-Id: <20250625031101.12555-9-boqun.feng@gmail.com>
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

Erik Lundgren and Breno Leitao reported [1] a case where
lockdep_unregister_key() can be called from time critical code pathes
where rntl_lock() may be held. And the synchronize_rcu() in it can slow
down operations such as using tc to replace a qdisc in a network device.

In fact the synchronize_rcu() in lockdep_unregister_key() is to wait for
all is_dynamic_key() callers to finish so that removing a key from the
key hashlist, and we can use shazptr to protect the hashlist as well.

Compared to the proposed solution which replaces synchronize_rcu() with
synchronize_rcu_expedited(), using shazptr here can achieve the
same/better synchronization time without the need to send IPI. Hence use
shazptr here.

Reported-by: Erik Lundgren <elundgren@meta.com>
Reported-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20250321-lockdep-v1-1-78b732d195fb@debian.org/ [1]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dd2bbf73718b..5c205dd425f8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -58,6 +58,7 @@
 #include <linux/context_tracking.h>
 #include <linux/console.h>
 #include <linux/kasan.h>
+#include <linux/shazptr.h>
 
 #include <asm/sections.h>
 
@@ -1267,14 +1268,18 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 
 	hash_head = keyhashentry(key);
 
-	rcu_read_lock();
+	/* Need preemption disable for using shazptr. */
+	guard(preempt)();
+
+	/* Protect the list search with shazptr. */
+	guard(shazptr)(hash_head);
+
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
 			found = true;
 			break;
 		}
 	}
-	rcu_read_unlock();
 
 	return found;
 }
@@ -6620,7 +6625,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-	synchronize_rcu();
+	synchronize_shazptr(keyhashentry(key));
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
-- 
2.39.5 (Apple Git-154)


