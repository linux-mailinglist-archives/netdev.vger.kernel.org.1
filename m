Return-Path: <netdev+bounces-237282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC62C4870E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608B41885D34
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F5D2E6CC4;
	Mon, 10 Nov 2025 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlXeQsd/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A8255F2D
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797510; cv=none; b=ZXUySlEtGt65exDPmmyZZOMqZeDsNQaCohmJvgjzk6Bk+QGnVJncgiJsy/olByqnPGu2fBk1vztjG25JcsKnq2J13353cjQ+n838y8IPVjGXdHUpkvQt6Xak7lrJanbJZWruuYLpI2ejvJb9nCO6vJMLc/OFnp5yhDKajgi03co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797510; c=relaxed/simple;
	bh=nmOBoPP+KXPCADv8LoYu2K7otwUwoO2gwn+1j4NKkPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+Knhm77/Pf5EKxw3jxu2aOCmBU6L6khGdPJGE8lgZ9fRmsZt5DYFKnT0AmcSR7+qgImUWEeW5ph4OZzyb61ye7HgnY1x4H+IwrtreFfA9X8/EaD9lDa/gmvNOvON5aqkb59C94A0XvJLfGevmy9JHB8La3u0PmyQjZxndGcZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlXeQsd/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762797507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L+y8i4FklIJCXniWOmgzmbsIxv22QiNxkZNEPmMt81Y=;
	b=TlXeQsd/yy6J3mFGk2/kVeRVJUlpCJk6DW2ua9KqOqvG4i0sYbwlW6ix/M+XvFgiElr8r+
	JiKizx/Kj7K2e8aYNMjqPoikFvsnemYCp32qth2/md5ISz4DavULxXv+luyxBamkZKoSGr
	Md0DS4eKlJB8ceAzWC5mJOVxZQVKKBE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-EYV6PwUCPd-XVPZPbZ0Qnw-1; Mon,
 10 Nov 2025 12:58:24 -0500
X-MC-Unique: EYV6PwUCPd-XVPZPbZ0Qnw-1
X-Mimecast-MFC-AGG-ID: EYV6PwUCPd-XVPZPbZ0Qnw_1762797503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBF391956061;
	Mon, 10 Nov 2025 17:58:22 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.193])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9D10180087B;
	Mon, 10 Nov 2025 17:58:19 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] dpll: zl3073x: Refactor state management
Date: Mon, 10 Nov 2025 18:58:12 +0100
Message-ID: <20251110175818.1571610-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 drivers/dpll/zl3073x/out.c    | 163 +++++++
 drivers/dpll/zl3073x/out.h    |  88 ++++
 drivers/dpll/zl3073x/prop.c   |  12 +-
 drivers/dpll/zl3073x/ref.c    | 197 +++++++++
 drivers/dpll/zl3073x/ref.h    | 126 ++++++
 drivers/dpll/zl3073x/synth.c  |  87 ++++
 drivers/dpll/zl3073x/synth.h  |  73 ++++
 11 files changed, 1008 insertions(+), 944 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/out.c
 create mode 100644 drivers/dpll/zl3073x/out.h
 create mode 100644 drivers/dpll/zl3073x/ref.c
 create mode 100644 drivers/dpll/zl3073x/ref.h
 create mode 100644 drivers/dpll/zl3073x/synth.c
 create mode 100644 drivers/dpll/zl3073x/synth.h

-- 
2.51.0


