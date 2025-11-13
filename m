Return-Path: <netdev+bounces-238218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFEBC5616A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338513A70FF
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C8832936C;
	Thu, 13 Nov 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm5JGk4t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F073324706
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019687; cv=none; b=KaG9WXVhY3p5f/ZeI3TBt47filVaLOzKnvbCPe/D1ulZ7HY9B9yw9y7gdtBduOCXRxZJdGgQUkv/yRxFmbgda2tqXYnQIt/KFMHVotGpgqjoFWrIbh2I3u3T9DU9JKRYbx9R5DLxc06XHPMsiK9kPx0F6/sqS2v6gcBZeuScBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019687; c=relaxed/simple;
	bh=phG2kdlKFCFGGcrwYKhRxY8z6nAJuhjeRVMV6n1LXVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUVSYj6PI9yJgrgsc4pHaJdnEnIOjnbW0mYu0F/MTKvyAHJ6grw2xDQPbImexL38UkwIucjiv1DUnEjq2ufY0r+TioOdTMCUOvCZ6Q4PwWSysgWj7Ce0TL4VQqjYh87QckHcu7peQllXlk31O9yl2ftxTgekrLkZ0HIRsBahqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gm5JGk4t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763019676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gHRWXDU+OQWR7WydISJX/UhlJBRrrdKiQTabNpym4ds=;
	b=gm5JGk4tdLhsaoq11+GJRahXmo30oDzjgbsecA8HREb7GxgkIawixVe0NDU2whqOInt7SV
	jTueOE7oRHAyijkG+p3L20ISz4Q1YAi+1ZUa0LlchToR0uXehmk42V1NKnIgHdisENU6Cv
	k6P15UNNrQ//SonRwL3eORJUgMqD7FU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-NrBwPu2ENm6tEW485LBQog-1; Thu,
 13 Nov 2025 02:41:11 -0500
X-MC-Unique: NrBwPu2ENm6tEW485LBQog-1
X-Mimecast-MFC-AGG-ID: NrBwPu2ENm6tEW485LBQog_1763019670
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB55718001FE;
	Thu, 13 Nov 2025 07:41:09 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F1F73000198;
	Thu, 13 Nov 2025 07:41:06 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/6] dpll: zl3073x: Refactor state management
Date: Thu, 13 Nov 2025 08:40:59 +0100
Message-ID: <20251113074105.141379-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch set is a refactoring of the zl3073x driver to clean up
state management, improve modularity, and significantly reduce
on-demand I/O.

The driver's dpll.c implementation previously performed on-demand
register reads and writes (wrapped in mailbox operations) to get
or set properties like frequency, phase, and embedded-sync settings.
This cluttered the DPLL logic with low-level I/O, duplicated locking,
and led to inefficient bus traffic.

This series addresses this by:
1. Splitting the monolithic 'core.c' into logical units ('ref.c',
   'out.c', 'synth.c').
2. Implementing a full read/write-back cache for 'zl3073x_ref' and
   'zl3073x_out' structures.

All state is now read once during '_state_fetch()' (and status updated
periodically). DPLL get callbacks read from this cache. Set callbacks
modify a copy of the state, which is then committed via a new
'..._state_set()' function. These '_state_set' functions compare
the new state to the cached state and write *only* the modified
register values back to the hardware, all within a single mailbox
sequence.

The result is a much cleaner 'dpll.c' that is almost entirely
free of direct register I/O, and all state logic is properly
encapsulated in its respective file.

The series is broken down as follows:

* Patch 1: Changes the state structs to store raw register values
  (e.g., 'config', 'ctrl') instead of parsed booleans, centralizing
  parsing logic into the helpers.
* Patch 2: Splits the logic from 'core.c' into new 'ref.c', 'out.c'
  and 'synth.c' files, creating a 'zl3073x_dev_...' abstraction layer.
* Patch 3: Introduces the caching concept by reading and caching
  the reference monitor status periodically, removing scattered
  reads from 'dpll.c'.
* Patch 4: Expands the 'zl3073x_ref' struct to cache *all* reference
  properties and adds 'zl3073x_ref_state_set()' to write back changes.
* Patch 5: Does the same for the 'zl3073x_out' struct, caching all
  output properties and adding 'zl3073x_out_state_set()'.
* Patch 6: A final cleanup that removes the 'zl3073x_dev_...' wrapper
  functions that became redundant after the refactoring.

Changes:
v3:
- replaced confusing memcpy in zl3073x_ref_state_fetch() [Vadim]
v2:
- addressed issues found by patchwork bot (details in each patch)

Ivan Vecera (6):
  dpll: zl3073x: Store raw register values instead of parsed state
  dpll: zl3073x: Split ref, out, and synth logic from core
  dpll: zl3073x: Cache reference monitor status
  dpll: zl3073x: Cache all reference properties in zl3073x_ref
  dpll: zl3073x: Cache all output properties in zl3073x_out
  dpll: zl3073x: Remove unused dev wrappers

 drivers/dpll/zl3073x/Makefile |   3 +-
 drivers/dpll/zl3073x/core.c   | 243 +----------
 drivers/dpll/zl3073x/core.h   | 184 +++-----
 drivers/dpll/zl3073x/dpll.c   | 776 ++++++++--------------------------
 drivers/dpll/zl3073x/out.c    | 157 +++++++
 drivers/dpll/zl3073x/out.h    |  93 ++++
 drivers/dpll/zl3073x/prop.c   |  12 +-
 drivers/dpll/zl3073x/ref.c    | 204 +++++++++
 drivers/dpll/zl3073x/ref.h    | 134 ++++++
 drivers/dpll/zl3073x/synth.c  |  87 ++++
 drivers/dpll/zl3073x/synth.h  |  72 ++++
 11 files changed, 1019 insertions(+), 946 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/out.c
 create mode 100644 drivers/dpll/zl3073x/out.h
 create mode 100644 drivers/dpll/zl3073x/ref.c
 create mode 100644 drivers/dpll/zl3073x/ref.h
 create mode 100644 drivers/dpll/zl3073x/synth.c
 create mode 100644 drivers/dpll/zl3073x/synth.h

-- 
2.51.0


