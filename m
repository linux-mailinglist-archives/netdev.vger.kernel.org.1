Return-Path: <netdev+bounces-182044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F529A877B6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C536F1887122
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B41DDC3E;
	Mon, 14 Apr 2025 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKQXjyFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F31D63EE;
	Mon, 14 Apr 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610493; cv=none; b=tPo6fSwLVIWwUMvNTQvGNmgq4Gm89jRN8lfTreHHpE/yxb847BiyD2MwBJyGIVk25/626QD0c758pEF4UU/QBScYmiSYa6jcvBLVLmy2DoOKTvOKO0mDAU5NZseaH890XAjPsSEuwzxYN5nJ/GBST1PIt8GBu9iFx6oPHbbfB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610493; c=relaxed/simple;
	bh=gSFvINbMx+mpurJjbuzYdJO9KVleuEcbzdDZgdWmmk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llP4Ffw1UzYoVRfXdq11ZA/yjJo7DCcUWFPJchui2J/5t7Hax9LBuLYEUMMDXaaR5K0dOZKy3aVMHShnhBFBMkhwy/fVwzOsRP/lPqa2+Hl+/FZbPhFBY/4JI8s2MZaNCxmjSXFFJJmkuHYQaXbJBjw8uQOY6aLtzOMnA62nYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKQXjyFX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4774d68c670so56759131cf.0;
        Sun, 13 Apr 2025 23:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610491; x=1745215291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8yEZCCjAIKX8Bcif/S/pGprjlBDXpto+eqqOQvtfBHY=;
        b=eKQXjyFXrSCPvnyv1YTcT3o5a9SCJyKmbdV994s5qz0eLxjG/1EJbPrdxeqWWIVdU0
         F7mnGFazccSlEJ6M9GxxPtfJMaqaD9TPfVqiTu2gs576kDHm2kms/zVoJGeInFicXhA3
         8dRj4vtzfGhKlxHbS8qfzzF/wWzz/VUL17fTxvIWbyuVsftNzVji2AWpFn8VVhqXKgPi
         b5K/2GZonQO7WbKQqvBTvZi7f3FE4A1MQfp35i5+VOkSsjNOyc4KIL7x8aBbK6+35m7E
         dII/VjUG9jzD08qh3m8J1+mISJvBCBN/s9UbOK7qMcW91AGE8BbcSvy7ebtnF9abFcfT
         ww+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610491; x=1745215291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yEZCCjAIKX8Bcif/S/pGprjlBDXpto+eqqOQvtfBHY=;
        b=mx3v1YcYt/1Hgop4AowfkPd2+VrKiL8RguJ9/8SY05bt8XZrEc6Yo75lK2/xGRNoEF
         IICVVLFVY0/065RHEW+PKgnTNUW3jGjSxt3IzmtKTn/MOfiSnR7gj5zzUWfRtDmtPTMO
         oW1WL1Y5rm3G/e/B1AKN0pC+NVM7d5IlSFajsDx7ENxoxv3/3C0tHJuJ5qwMNi8e2hcz
         gSdrGmV277Hg2NPCRbqFlmGFlrWbx2rFF1u/pZd/OQPa8KltlknDiuCv3RjlNjL47zSm
         qVePhNCeOaIAXmhLAf1gFh8SJue0efcbsqzAP4OuAFsOsJlNg6O/YPHcDFIQkmLhxbTl
         eqhA==
X-Forwarded-Encrypted: i=1; AJvYcCUW2hktAFmUcxcPKAXP8Y94vMdyTH855bz3eIEoB2ARJrfJmGN0dTf3i5F9oiebzNOtmcDm@vger.kernel.org, AJvYcCUzyfHmAupOw+s33NcleUnubsG8VVLg4Yr1rMEVzP4kkkCmOzHukl/yrlSICfzHjqDFUicHjLOV@vger.kernel.org, AJvYcCW6rb/313aloITG0NDsRUUugyrJD7PP78uDoAUsVIGU4fMp38lDdUIZQIGiZIyuvXcdyWlnTxPzP7hVdx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoYdItgEKpq7qqfjxvjJnYNYSiTZ5MGua6HHuGfYMZVvdlkNr
	QnWA/9cBUq52ojyZVbW3sHerVC8PsumVc0BnKQttj+73/A5gg2oZ
X-Gm-Gg: ASbGncvOULVFHUAHzBZRjE1xipAZp9cRf2Ff3Z/UURmcViLwA1Hm8eWpkply+qnkonX
	2QaQ1YCGn9e1hhwlD/bz+A1cSP7LG5q6CdDMyNqiH0dhy1gG5mp1spWvhuOOI/4K7wXS5TNKNuq
	r7qstTGYefA9BsyQhKAIt0yQqoaPiId0KBokrB31Upec7EpVLrcGyHHY45mdk/sHkq3HiruI9oc
	UJgEJ7Lm/8KPvjus0KTLkyPw5POIoVxrwhjpGrcJxqBvCJlUu1f9LK/IY/1rVMEANDmcHXViO8N
	wZasUpnfsN6XgKUZF9K7UHzBkyW/YCGEiChxTJHpcw+swHgvBo++1aZFGEk+dWlvCHi+lCEJaFJ
	6wFQpIDn82VbsnT/Jk6sF86CKM1KAwUI=
X-Google-Smtp-Source: AGHT+IHDWExJgXvc7ntxhN+BtiblsGHzc2LmReFgtphjkcdAbqKB5qry0e5AfEx4TNIw1Qs3SvIh3g==
X-Received: by 2002:a05:622a:1449:b0:476:87f6:3ce4 with SMTP id d75a77b69052e-479775d3200mr175981031cf.39.1744610490778;
        Sun, 13 Apr 2025 23:01:30 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb15d12sm69685261cf.27.2025.04.13.23.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:01:30 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id D4E601200043;
	Mon, 14 Apr 2025 02:01:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 14 Apr 2025 02:01:29 -0400
X-ME-Sender: <xms:uaT8ZydELvQrIgVwszF6wU11o2rahUFItTrF3zadihTQqwhCsatsOw>
    <xme:uaT8Z8Mq2HY5L8zMm3J72rFNw00Qj0WcF8pxDZzTkdpzkb4SVaEkD9wwgqVlg60Dv
    9IK7JI-jGAtDxSOzw>
X-ME-Received: <xmr:uaT8Zzi_mU2pxqqc_Ce7FyyoC9KTuIACSf4u10_oOlkFcMKVNm16J2teSi2Hzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhgvihhtrghoseguvggsihgrnhdrohhrghdprhgtphhtthhopehpvghtvghriies
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtg
    homhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhho
    nhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprggvhhesmhgvthgrrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:uaT8Z_8mxkiy8oDxgoCUsMjw2axgTr0RETjqKWwXbjaBwgvASKq-Uw>
    <xmx:uaT8Z-t4v1QZbAyzPoJYPJZk-aNcATPkOOh09_umb363Um3CbzcRqg>
    <xmx:uaT8Z2E6tN__OtMKc-flKBoe7vcBUF4te7zg0y8e-g4PIGCSdNJswA>
    <xmx:uaT8Z9OSOY4GkjNvy3_cWkXp2h05ZPGh98opqud4MQ6Z0BkxP5T6dw>
    <xmx:uaT8Z7PioaUMssI2L9JsqcZnNTvN7vj5XZHepuzjcOU14oODaUHyJpom>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:01:29 -0400 (EDT)
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
Subject: [RFC PATCH 8/8] locking/lockdep: Use shazptr to protect the key hashlist
Date: Sun, 13 Apr 2025 23:00:55 -0700
Message-ID: <20250414060055.341516-9-boqun.feng@gmail.com>
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
Link: https://lore.kernel.org/lkml/20250321-lockdep-v1-1-78b732d195fb@debian.org/
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 58d78a33ac65..c5781d2dc8c6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -58,6 +58,7 @@
 #include <linux/context_tracking.h>
 #include <linux/console.h>
 #include <linux/kasan.h>
+#include <linux/shazptr.h>
 
 #include <asm/sections.h>
 
@@ -1265,14 +1266,18 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 
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
@@ -6614,7 +6619,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-	synchronize_rcu();
+	synchronize_shazptr(keyhashentry(key));
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
-- 
2.47.1


