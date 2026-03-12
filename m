Return-Path: <netdev+bounces-267114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDrZA+bWsmlDQAAAu9opvQ
	(envelope-from <netdev+bounces-267114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:08:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBEE273EF8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8452E30452F5
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894983C6616;
	Thu, 12 Mar 2026 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="OW/DV1AC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0D3BB9F9
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327934; cv=none; b=sBpEI+jWVfFXB03QY9zSUdiw309gdYxW0TSp9wSewbOJuIJO9XiVwp00UQXlA97s+s2aNkWBtWIm3UMu4kjaEyfkbFcCPj13fg0OuIlOaBZo8OhgvKx4gtiXtEa9nL5jKNHBIdbFSRGMJj11YNB5JAadwZZaoA2YXpJ9lAYC340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327934; c=relaxed/simple;
	bh=wFrH16wRP/ZRrLPrdvN9J5kV/62KiVf8oPQZXnkjAN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnzeMTRu25UJplEOcNVwjAdsb6/jB+oLFm4g1R/An135a2WuY8I/sqjOKIrcLhHPA4P2BhSiM4c0ul5Gy4OUJrEPKiIk7IOZhNyv7yCrbU9//5W21ea1ZlrSHlHGcrwRg2nqd4+iUbdgmu1fERDRSwbQEOaeLRysfve+xGRckww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=OW/DV1AC; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d743cd9e5bso770928a34.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327931; x=1773932731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/UukkhQcW1lhFqWI/Fw5V3bxdryulukbz8WWfM9zNY=;
        b=OW/DV1ACXgC1meD5kqUaAm+FZL1lWnMvkS4yVJbykbP7K5vclRgwIJ0xyKjX7imhp/
         JxxjkcYDPIFgCcRsHpsq5835/4tOiZXx4U2LrD/Jieum8wVn2Z6Z5nqk/9SiB45nd/qy
         /BuK9l4E6H6ktN13lZ0Hr7tfv7gU2Q/gQrPyh80u+hQmfQJHWoBipgWsTEkUGem3Rz81
         JNQzSDmb8/zc02tAEL+0aWPXdIdNl9rSHS9aSNKbrZ7DJXEXNUQ5AdKmtdWCkC9j1FJ2
         ratzAuFfZH/Mj07Ii9/24wDft/5/id9dHt4PadP+Rpp8ksPWtVWSLG+Lvf0x5+CB9K5Z
         62Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327931; x=1773932731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/UukkhQcW1lhFqWI/Fw5V3bxdryulukbz8WWfM9zNY=;
        b=D4pTeeRLawpgJTN7IYIP2xDNU2k6XHuk2ieS/Dsl+EEGPd/91RgWDaZBb2cuUNF31h
         PfUmQUco7b9uhLFwcZPTQihJgVIXyfah8TyRKNh3mIKhwWZl8TcAi4HhZkjmJPzONcq3
         MB00z01pnNm4V2ch/y0RehsMUEY1KG4TsH+UZ+QmyAz97Jq2SEHvQKUteVLeS9Tu38TQ
         1vnQ/vfJJBGM3SV8ItOKYgfFrix+V2m86Y+caUrTso/rqTGdN+M+owDYLUNF5KHPVNz3
         lrDCpRfTANBV2r1m3v2RWfP+sNqAXHb+6kOYTccHYK50ahkSq0ooynUUbpwgYJRfCIFV
         2i7g==
X-Forwarded-Encrypted: i=1; AJvYcCXm1gJAdZsI0LdOMgvT1YqP1/KaCSivDb8YM/vkgeQaPTo12762bYTHVauxi+1Q0zyHEn6ewwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9CUh26cmewYU4J75+llcbi9kLRLGAzEXbVb2VM2MX48MZ3TE
	+LJoLXDCMGIaoXAdZFNdJ9V51JRkjPjq48YBuj5r356Tc0usVuCcOFsCXK01zWGrtGk=
X-Gm-Gg: ATEYQzzgnzjL1C8EYngZNOqNYZPqZynPatnpqM8QTHBmB/9dv6muJr/4wI/RDnjXjcf
	HL0nGgbhfMaoz9zDYVkyf7DrRzbPDReuiXYlE+ll1fl/w4rZjKIgCr0WsdE2Z1KlRDVWX0x1jtj
	ZZc0SwmtryUk2AxvuRkDWLKYiGDdMFAqpd7s8m2Qj6R9B1zskGiTULU8h/yVILBRnfUWyPiUxsP
	RevRUp8VBhOflSRwIRYdLtdPcDUKhHtXHQPZXqsM1Eb8KSWbpEK0+fCCZQF+yp+gItFXCST44/v
	uu4QbtOPnLOynMnJcWHhzHgaCu58EXMq0DE0ZCXSOIe5L0PAfhJPJLfWbUgKfK11kFVixYmHTjD
	hvY908fTF/FJFZDPO585x90mfzm4h7hvV/2gxQ3ffyeB9C0vv5iO/nW9FzaBMT6ybYDzGmtzLdR
	o20fsWQk6BgvTfIZwm26yN29tk7hW7yDvb0ZnYBpp5LU3kV9Rl9Q4e1HUaSL+VFXENfg==
X-Received: by 2002:a05:6830:488d:b0:7d5:1101:9196 with SMTP id 46e09a7af769-7d76a6bdefamr3754389a34.6.1773327930614;
        Thu, 12 Mar 2026 08:05:30 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:29 -0700 (PDT)
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
Subject: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation at guarded call sites
Date: Thu, 12 Mar 2026 11:04:55 -0400
Message-ID: <20260312150523.2054552-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267114-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,goodmis.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bitbyteword.org:dkim,bitbyteword.org:mid]
X-Rspamd-Queue-Id: 1FBEE273EF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a caller already guards a tracepoint with an explicit enabled check:

  if (trace_foo_enabled() && cond)
      trace_foo(args);

trace_foo() internally re-evaluates the static_branch_unlikely() key.
Since static branches are patched binary instructions the compiler cannot
fold the two evaluations, so every such site pays the cost twice.

This series introduces trace_invoke_##name() as a companion to
trace_##name().  It calls __do_trace_##name() directly, bypassing the
redundant static-branch re-check, while preserving all other correctness
properties of the normal path (RCU-watching assertion, might_fault() for
syscall tracepoints).  The internal __do_trace_##name() symbol is not
leaked to call sites; trace_invoke_##name() is the only new public API.

  if (trace_foo_enabled() && cond)
      trace_invoke_foo(args);   /* calls __do_trace_foo() directly */

The first patch adds the three-location change to
include/linux/tracepoint.h (__DECLARE_TRACE, __DECLARE_TRACE_SYSCALL,
and the !TRACEPOINTS_ENABLED stub).  The remaining 14 patches
mechanically convert all guarded call sites found in the tree:
kernel/, io_uring/, net/, accel/habanalabs, cpufreq/, devfreq/,
dma-buf/, fsi/, drm/, HID, i2c/, spi/, scsi/ufs/, and btrfs/.

This series is motivated by Peter Zijlstra's observation in the discussion
around Dmitry Ilvokhin's locking tracepoint instrumentation series, where
he noted that compilers cannot optimize static branches and that guarded
call sites end up evaluating the static branch twice for no reason, and
by Steven Rostedt's suggestion to add a proper API instead of exposing
internal implementation details like __do_trace_##name() directly to
call sites:

  https://lore.kernel.org/linux-trace-kernel/8298e098d3418cb446ef396f119edac58a3414e9.1772642407.git.d@ilvokhin.com

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>

Vineeth Pillai (Google) (15):
  tracepoint: Add trace_invoke_##name() API
  kernel: Use trace_invoke_##name() at guarded tracepoint call sites
  io_uring: Use trace_invoke_##name() at guarded tracepoint call sites
  net: Use trace_invoke_##name() at guarded tracepoint call sites
  accel/habanalabs: Use trace_invoke_##name() at guarded tracepoint call
    sites
  cpufreq: Use trace_invoke_##name() at guarded tracepoint call sites
  devfreq: Use trace_invoke_##name() at guarded tracepoint call sites
  dma-buf: Use trace_invoke_##name() at guarded tracepoint call sites
  fsi: Use trace_invoke_##name() at guarded tracepoint call sites
  drm: Use trace_invoke_##name() at guarded tracepoint call sites
  HID: Use trace_invoke_##name() at guarded tracepoint call sites
  i2c: Use trace_invoke_##name() at guarded tracepoint call sites
  spi: Use trace_invoke_##name() at guarded tracepoint call sites
  scsi: ufs: Use trace_invoke_##name() at guarded tracepoint call sites
  btrfs: Use trace_invoke_##name() at guarded tracepoint call sites

 drivers/accel/habanalabs/common/device.c          | 12 ++++++------
 drivers/accel/habanalabs/common/mmu/mmu.c         |  3 ++-
 drivers/accel/habanalabs/common/pci/pci.c         |  4 ++--
 drivers/cpufreq/amd-pstate.c                      | 10 +++++-----
 drivers/cpufreq/cpufreq.c                         |  2 +-
 drivers/cpufreq/intel_pstate.c                    |  2 +-
 drivers/devfreq/devfreq.c                         |  2 +-
 drivers/dma-buf/dma-fence.c                       |  4 ++--
 drivers/fsi/fsi-master-aspeed.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/scheduler/sched_entity.c          |  4 ++--
 drivers/hid/intel-ish-hid/ipc/pci-ish.c           |  2 +-
 drivers/i2c/i2c-core-slave.c                      |  2 +-
 drivers/spi/spi-axi-spi-engine.c                  |  4 ++--
 drivers/ufs/core/ufshcd.c                         | 12 ++++++------
 fs/btrfs/extent_map.c                             |  4 ++--
 fs/btrfs/raid56.c                                 |  4 ++--
 include/linux/tracepoint.h                        | 11 +++++++++++
 io_uring/io_uring.h                               |  2 +-
 kernel/irq_work.c                                 |  2 +-
 kernel/sched/ext.c                                |  2 +-
 kernel/smp.c                                      |  2 +-
 net/core/dev.c                                    |  2 +-
 net/core/xdp.c                                    |  2 +-
 net/openvswitch/actions.c                         |  2 +-
 net/openvswitch/datapath.c                        |  2 +-
 net/sctp/outqueue.c                               |  2 +-
 net/tipc/node.c                                   |  2 +-
 30 files changed, 62 insertions(+), 50 deletions(-)

-- 
2.53.0


