Return-Path: <netdev+bounces-193621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C70FAC4D77
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E922B189C1D6
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595F91F790F;
	Tue, 27 May 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0HUYrvX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D08179A7;
	Tue, 27 May 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345626; cv=none; b=uepN6b7viAcVZHqeXkLgBgAElvzwb5jqYBcgune5hh7eLwIEDPDK4NU8EQMJp789EvqlMblCZjT6PDIzmk3BkVvVzbpUcJ+mjEMfx/bDc5q4XJdtcOLqZhoHXqtzJjdO5oI3ovJ/mqGMdMsKJ25IOceoGrIEzOxIJOZq9SWAkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345626; c=relaxed/simple;
	bh=8NjOZ54AdLGgUqGDrY8fBK4La5vrhFA1nfnRN0ROiE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FJQQXNdf6kMePBvEoZGQYpvE12Bq7NBteDsYOCRTA9Y9AS4KqIr+L/f2PtwsUWPvrkPlcAm16JPaJG4BtaeAR7Lw8IekCYpK21d901g6KRm0Ttr6Y4AaNab47344LgEkWeZCKNZY5yQuovrI1vk7GFIAKHdUNy6l28CM2SW5ymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0HUYrvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAA5C4CEEB;
	Tue, 27 May 2025 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748345625;
	bh=8NjOZ54AdLGgUqGDrY8fBK4La5vrhFA1nfnRN0ROiE4=;
	h=From:Subject:Date:To:Cc:From;
	b=L0HUYrvXZ/X7rqdMfiEYRH6Dp2yBR8oEazt+v7fKbLsZBZKMx5wxaXt7zVqpVsTXO
	 /PIPAzWV3hmfqpv9mAT1ZsHLlZc2k3Satwudw99vIEtv1bMWlcqGDx+u4vN80p1vZj
	 avoVRcEsYrBhTxhyAjzkf4mOVxw00lJFIQrLLxx+f1VxPukZoC7RQ+X4UPs5ryalrP
	 +4eO2lnOCQevHz0TIYr6nuIsS+QU9E9IT+xFufiNHEa0rsvGW/PqAm2UvElzDCQ2vg
	 SYT9cN7wpQwCw0mGZ1G20tUoaLYCdpDJ1LeCYjuf+9SsMuPCuCBjIYbPHoKLolqOeD
	 3s6QnrPTihZMg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 0/9] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Date: Tue, 27 May 2025 07:33:31 -0400
Message-Id: <20250527-reftrack-dbgfs-v10-0-dc55f7705691@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAyjNWgC/2XQzW7DIAwH8FepOC8TGAhmp73HtAOfadQprUgVb
 ar67nMqTWOzONno9wf7JtbS5rKKl8NNtLLN63xeqFDy6SDSMSxTGeZMDQESrDRKD63UawvpNOQ
 41XXQbnRRS12gBkHoQvfz5yPx7Z3q47xez+3r8cCm9u5PlPkftalBDlVqixY1gNSvp9KW8vF8b
 pPYszbovWUeyEeFyYSYFUBlXvfeMa/JJ62sN4AJa2Te9B6ZN+RtCjY59N4aw7ztPHBvyasUY64
 0PMbM/Nh5LZkfyePoEvhQaY+Beffr6TDv9v07TDZ7F1PiHnvP94fkR+mcclnH6JF533vPvN//H
 yIiBmPB/J3/fr9/A7PjxJGuAgAA
X-Change-ID: 20250413-reftrack-dbgfs-3767b303e2fa
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8NjOZ54AdLGgUqGDrY8fBK4La5vrhFA1nfnRN0ROiE4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNaMQugIkoIHos2G9RfKUCH3HUpiHZwznjaBMQ
 gKQUlByahmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDWjEAAKCRAADmhBGVaC
 FTB8D/0XarX8SSCyP3ut5/493ts0isLkqLvRVphy3ua0gR2yek698/ghm//ceODWB1kBIV1U3Om
 v1PJ5V+yKnP00UCkDnGhj0GQ1OyHwE7b6aezDhFM6NOeXnAOFCLmc1PMp+sC70YsK2NhpbyiYP2
 dBHwf42c41oTgxjoi+ic3Zl96+2cCfSAJPWZ9Z1/A0eprCaRZfgI5xV7f9vR1lhGIDZGz06SsfQ
 t6suvXas6q+Oe6OgHoFwmu8Hhoy1FnK4TTx0S7SEaEL12RFOE5cPW48+lqX59muO7ogDfnaUd++
 91ZCdrJUgPGGx+cVCTVSZmVviezriQwYe0MyRBi1+OlqmS5wuPpZ2osQT9cbhWZVprTM96UaHI+
 B3FJluTg+qUO4XVHlNfW8h9wpE1Gxj3QBpHRYDX2hpJRxqn5IclI0Z1fH3MLosKHuAMgqUyPOKJ
 wudkxgiuUoLzUY9GRgpc2SYDqqAhTm0pmGgW01g4pBUVofJCyQCvMQo5r4o+HZzwnLy7t0bWd5u
 TaypVc3BkD63AYeQ9yPUE73yDn8HxlwkTUFM7WRgfrLxFVBsZIsmEVtz+Ne7kEHABlulh/nmHMU
 BM4zjLYx05JIq1Adddve7Y5oB9u6fWbJDSi+N/tEVFCaSWlNpJaKyOCBOrw/1xW/ixFwig9JH+F
 479ukh5m/ogTeow==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Thought I had sent this a week or so ago, but I dropped the ball in the
midst of some travel.

The only difference from v9 is that this posting drops the i915 symlink
patch. I got a CI report [1] that showed some EEXIST errors when trying
to create those symlinks, which tells me that the names are not truly
unique. Since I don't know much about the i915 driver, I'll leave that
as an exercise for that team. It should be fairly simple to add if they
come up with a scheme that gives these object unique names.

[1]: https://patchwork.freedesktop.org/series/148490/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v10:
- drop the i915 symlink patch
- Link to v9: https://lore.kernel.org/r/20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org

Changes in v9:
- fix typo in ref_tracker_dir_init() kerneldoc header
- Link to v8: https://lore.kernel.org/r/20250507-reftrack-dbgfs-v8-0-607717d3bb98@kernel.org

Changes in v8:
- fix up compiler warnings that the KTR warned about
- ensure builds with CONFIG_DEBUG_FS=n and CONFIG_REF_TRACKER=y work
- Link to v7: https://lore.kernel.org/r/20250505-reftrack-dbgfs-v7-0-f78c5d97bcca@kernel.org

Changes in v7:
- include net->net_cookie in netns symlink name
- add __ostream_printf to ref_tracker_dir_symlink() stub function
- remove unneeded #include of seq_file.h
- Link to v6: https://lore.kernel.org/r/20250430-reftrack-dbgfs-v6-0-867c29aff03a@kernel.org

Changes in v6:
- clean up kerneldoc comment for ref_tracker_dir_debugfs()
- add missing stub function for ref_tracker_dir_symlink()
- temporary __maybe_unused on ref_tracker_dir_seq_print() to silence compiler warning
- Link to v5: https://lore.kernel.org/r/20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org

Changes in v5:
- add class string to each ref_tracker_dir
- auto-register debugfs file for every tracker in ref_tracker_dir_init
- add function to allow adding a symlink for each tracker
- add patches to create symlinks for netns's and i915 entries
- change output format to print class@%p instead of name@%p
- eliminate the name field in ref_tracker_dir
- fix off-by-one bug when NULL terminating name string
- Link to v4: https://lore.kernel.org/r/20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org

Changes in v4:
- Drop patch to widen ref_tracker_dir_.name, use NAME_MAX+1 (256) instead since this only affects dentry name
- Link to v3: https://lore.kernel.org/r/20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org

Changes in v3:
- don't overwrite dir->name in ref_tracker_dir_debugfs
- define REF_TRACKER_NAMESZ and use it when setting name
- Link to v2: https://lore.kernel.org/r/20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org

Changes in v2:
- Add patch to do %pK -> %p conversion in ref_tracker.c
- Pass in output function to pr_ostream() instead of if statement
- Widen ref_tracker_dir.name to 64 bytes to accomodate unique names
- Eliminate error handling with debugfs manipulation
- Incorporate pointer value into netdev name
- Link to v1: https://lore.kernel.org/r/20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org

---
Jeff Layton (9):
      ref_tracker: don't use %pK in pr_ostream() output
      ref_tracker: add a top level debugfs directory for ref_tracker
      ref_tracker: have callers pass output function to pr_ostream()
      ref_tracker: add a static classname string to each ref_tracker_dir
      ref_tracker: allow pr_ostream() to print directly to a seq_file
      ref_tracker: automatically register a file in debugfs for a ref_tracker_dir
      ref_tracker: add a way to create a symlink to the ref_tracker_dir debugfs file
      net: add symlinks to ref_tracker_dir for netns
      ref_tracker: eliminate the ref_tracker_dir name field

 drivers/gpu/drm/display/drm_dp_tunnel.c |   2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c |   3 +-
 drivers/gpu/drm/i915/intel_wakeref.c    |   2 +-
 include/linux/ref_tracker.h             |  58 +++++++++-
 lib/ref_tracker.c                       | 190 +++++++++++++++++++++++++++++---
 net/core/dev.c                          |   2 +-
 net/core/net_namespace.c                |  34 +++++-
 7 files changed, 265 insertions(+), 26 deletions(-)
---
base-commit: fefff2755f2aa4125dce2a1edfe7e545c7c621f2
change-id: 20250413-reftrack-dbgfs-3767b303e2fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


