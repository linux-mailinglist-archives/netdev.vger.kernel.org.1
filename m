Return-Path: <netdev+bounces-267115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PaPIfjXsmlDQAAAu9opvQ
	(envelope-from <netdev+bounces-267115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:12:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1948A274027
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 363D3322D343
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E163C7DE7;
	Thu, 12 Mar 2026 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ZLuEADjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE003C73F6
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327941; cv=none; b=rMD9uYwrPXy+uThXZWp3U/VucNEgxQ1mmPa2ARmnojY2y6WeHr90bmJPimt1/Xjdo1+nhG/sTajJe5mSOWMS66UPp+zTZWR9KUEIKn0iPpuwqMf/O/ohj7LP05C2T/O2iEj2fDRa59ahVk3u6sVfnd+AHN97FTXFKANYVSXT7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327941; c=relaxed/simple;
	bh=10NVZYZNHh8UNRWWgIond7aYsxXBLnPZEqS+81FpWlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lknd+h+JS7FCnyk/X3TFj+h9flfJ8Elmfv7iFd5XV2drOqR/8kzd9q8j9OC8nCbtGx/5XMLPuZZ2ZctlbQeeG0WcnHC0b2XCqz2JisdBJyVFDp78v9qPqOp/PKp0BTc/lXACOcxePFm0L7dq1/+v5cV/wQ+2pb3v/Kc1wiEkwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=ZLuEADjS; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7653db148so821268a34.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327938; x=1773932738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNc1V3lTb2QUW0xjd0W9BOVRtnhujjy4WaV1yGr6BKQ=;
        b=ZLuEADjS5Wujf+hyGJOkQpr/wIKGuXs9OOEVT4XriJwtaGHICDf/fK7wgqCLEVshea
         ZPDoxRigGndBOJZknOWOvmoIvA5p5AflGvpUg/lYA1HOMVjGphlSfEEp2YUKFkCpsUjq
         iY7dYM6BX9/OyYunBFKZ1LEEd+dgcchthClyw8FTO8bR13lJBq1OLNQ6XV+bQEoEw0nW
         hc0H26Q0dFwWj47erVfvxfR6mSo6cPUE9ccQuUXIqrq+LZpon6yRikG/EMTJ4kvhBZ6x
         p+knU1eLD3OrfrwQaFIiU9k98YYy4T5TDHuUp8m0AMRLXmoPg+ykG9oMleXMnBAqpVBq
         0UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327938; x=1773932738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cNc1V3lTb2QUW0xjd0W9BOVRtnhujjy4WaV1yGr6BKQ=;
        b=RSKDMKSr9tDbi+MJDt26dMS5XBchvHqwn9Iv1ftIXX5gNknTlDVStwkzWpCuEzunVL
         QNT4QnjRb8atd5gSNj6EBWeExARzgYc9M9mhm6RgfRDotQVcnrBO7QalISB+BpYwaAhg
         MWV4FjwU2EIQiijyl87r+Hs/jVqIXuqVX6SUgYCb00dLSv6CWiKitDbf5C6KEu9Vh4aL
         81nhY7rgUXHYmRyt9MTbK7+6eYy2N43rkfa5FI0aDW9lgjVs6mcRNbOkGv+b1kn0df4s
         FnTjsvjdzdM5kf6ZLdDHmRGRLSJQsgwNDgQ4KwbiTFlb4jVE0mbxpjaxVO3lyyiyqCe/
         0niw==
X-Forwarded-Encrypted: i=1; AJvYcCWHiVXLGCesSKGqFoVdsTgeUjt2BBbgBjZJTAVfodhtc9HcK9N8nP7YHgEp0xTO+nhU5mUeXCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmdpijvtDcVQ5GWEeQwQz9qZuotXoUAqvkHR8d/l6kkVxDvj5
	tFePli3HWGiEtmM2JSEmzIXRjysr4bVQq83mJXJPQ9wRl1hWxrr9uE18mUhxgXxxLeU=
X-Gm-Gg: ATEYQzzMwIq/96bbf2lf8Jmp4CF85Ceykq3Mbr8Vr1MY0mczfzS9tTP+oKlZ19cNOCt
	HLEVMrXJaYhlc+94RQmel39DNjEIY7qm5cvePHZ+tG4RavpQGLQIlRZidfGJY6h7beybbDkF1il
	hcFEwchVOuk88X8jrz7UFmFVjLKVxI8dGFCx8WIVrNsEKOIal2LES4ns6mG97HaG80UUI0Kkjv+
	suXcK6qUXzgqbq+VelbaeLhRQ9vdE5wmcV64tGdgqzDzhFzevTBWnh+8mQaGo4RWW3QM/Ye3QtZ
	WSOVwH+V+aga9+GF1VvcsLqHSWFhv8b5zT7Pbj2F6yDdaEVikapQxXt8X5s94lFlfS5ASvQQ6OQ
	SvLTZ9uhicqO7NiFF0pZxb5BI12Z7/jfjqcW9mUkgBb0u9YcMr7Hldo3khRIhZu+iI2LyEM4rEZ
	JXWLqEvYi49zdpGRN6jzaGqccwYTRXcyrOj0Vbf0/a9TKORJeg0R3rWahoNt4sNLY+tLGErCQGD
	2rj
X-Received: by 2002:a05:6830:3113:b0:7c6:d001:afb2 with SMTP id 46e09a7af769-7d76a85b34cmr3668805a34.35.1773327936791;
        Thu, 12 Mar 2026 08:05:36 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:36 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	dev@openvswitch.org,
	Oded Gabbay <ogabbay@kernel.org>,
	Koby Elbaz <koby.elbaz@intel.com>,
	dri-devel@lists.freedesktop.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Len Brown <lenb@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linaro-mm-sig@lists.linaro.org,
	Eddie James <eajames@linux.ibm.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	linux-fsi@lists.ozlabs.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
Date: Thu, 12 Mar 2026 11:04:56 -0400
Message-ID: <20260312150523.2054552-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267115-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[bitbyteword.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bitbyteword.org,kernel.org,efficios.com,redhat.com,kernel.dk,vger.kernel.org,davemloft.net,google.com,iogearbox.net,gmail.com,ovn.org,lists.sourceforge.net,openvswitch.org,intel.com,lists.freedesktop.org,linaro.org,amd.com,linux.intel.com,samsung.com,lists.linaro.org,linux.ibm.com,codeconstruct.com.au,jms.id.au,lists.ozlabs.org,ffwll.ch,sang-engineering.com,analog.com,HansenPartnership.com,oracle.com,fb.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[73];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	TAGGED_RCPT(0.00)[netdev,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,goodmis.org:email,bitbyteword.org:dkim,bitbyteword.org:email,bitbyteword.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1948A274027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add trace_invoke_##name() as a companion to trace_##name().  When a
caller already guards a tracepoint with an explicit enabled check:

  if (trace_foo_enabled() && cond)
      trace_foo(args);

trace_foo() internally repeats the static_branch_unlikely() test, which
the compiler cannot fold since static branches are patched binary
instructions.  This results in two static-branch evaluations for every
guarded call site.

trace_invoke_##name() calls __do_trace_##name() directly, skipping the
redundant static-branch re-check.  This avoids leaking the internal
__do_trace_##name() symbol into call sites while still eliminating the
double evaluation:

  if (trace_foo_enabled() && cond)
      trace_invoke_foo(args);   /* calls __do_trace_foo() directly */

Three locations are updated:
- __DECLARE_TRACE: invoke form omits static_branch_unlikely, retains
  the LOCKDEP RCU-watching assertion.
- __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
- !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
  when tracepoints are compiled out.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 include/linux/tracepoint.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 22ca1c8b54f32..07219316a8e14 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -294,6 +294,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_invoke_##name(proto)			\
+	{								\
+		__do_trace_##name(args);				\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
@@ -313,6 +317,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_invoke_##name(proto)			\
+	{								\
+		might_fault();						\
+		__do_trace_##name(args);				\
 	}
 
 /*
@@ -398,6 +407,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_COMMON(name, proto, args, data_proto)		\
 	static inline void trace_##name(proto)				\
 	{ }								\
+	static inline void trace_invoke_##name(proto)			\
+	{ }								\
 	static inline int						\
 	register_trace_##name(void (*probe)(data_proto),		\
 			      void *data)				\
-- 
2.53.0


