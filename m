Return-Path: <netdev+bounces-199103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62559ADEF3C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963F040107F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729972EBB95;
	Wed, 18 Jun 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTpSBrAo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B62EBB8F;
	Wed, 18 Jun 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256668; cv=none; b=rFMdZRxBof6HosI5oOVycsmS7VAN/8CwEBJ4HlJoLFOaU7wovuv0HmarEBarJkYHc8sMRA4nY20KIbiPFKhQ8y4ja26aCdqakqKi7n9IEW8y1SC5O7qnEKVGOKiJ5zWKbusA+RtT8mp05Pj6XQw/HOYnkKOaB0vWHIeRF0m7a2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256668; c=relaxed/simple;
	bh=gyXKQrUKu84qG3DVHb5oBzmERPpCPM0gV75gBsZhfxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZXNYVJHMpV4BhS0FThb05m/8Uvr65PM+2vp4j30hBl+gy+K7dRtXORSVL6UlcTZ/Q6vKgRfcUJa067r0bbCBAzOjChvR2P5fqXL72BEXC8nWGT1eAnOy/sLi6KGcnkbPd4Njf6U8UU4XTzC1MW4IjK5EHWJNEgKpi2x8RHoiBk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTpSBrAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3497EC4CEE7;
	Wed, 18 Jun 2025 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750256668;
	bh=gyXKQrUKu84qG3DVHb5oBzmERPpCPM0gV75gBsZhfxg=;
	h=From:Subject:Date:To:Cc:From;
	b=uTpSBrAopVOvHbocEejkw4vKJ8R+uJ9B81CRw/Sf9gnzuW1ksNHr7ETdSL1YVWjJZ
	 THRXprjYLqDWIcigSP/CywZnWQF1sexDNc3VTZ+Lu8cNzUUFVtAawxnm/flx13MXz0
	 r4aOyJED37h7bef4VaCScIQYx+/1CliZxAXxVK0oGWdU7yyl9TMgkO62b/Zwep5lUv
	 Pmo7dQJDEsb+Hfez/uKP8NeI3X6uKDaQZaGO0eQTVWk9NLqwc8fzD3AZUOjoJNWdzW
	 VdQqldexvYsB7swkxZXmcT20rH0vvf59f+h1pM4s3pAI2KtjsGKl1wwf5t3WbYQJUP
	 whmFpWO9wxW8g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v15 0/9] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Date: Wed, 18 Jun 2025 10:24:13 -0400
Message-Id: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3MUmgC/23S3Y7UMAwF4FdZ9Zqi2IkThyveA3ER52e2WjSD2
 tUItJp3x10JETDqVdp+p4l73paj71s/lk9Pb8ve79ux3a66APrwtNTncr30dWt6Y0GH5AL4de/
 jdS/1ZW1yGcfqU0zine84yqLouz7ffrwnfvmq6+fteL3tP98/cIfz7u+o8G/UHVa3DueJiT2i8
 59f+n7t3z7e9styZt1x9mQ8qhfgGoo0QBzG+9kn47366oFyQK48xPgwezY+qKdaqCbOmUIwnia
 P1pN6qCJt6OFZmvFx8t4ZH9VzTBVzGTrHYnz64/UyPp3zT1yp5SS1Ws+zt/Nj9dGlBKl5kczG5
 9ln4/O5/yLMXAJhsOcHNwWg3QA4TWiVaKTkKGawCTAn2F8AZwdzKN0JROLwnwScE+wh4GwhgGR
 fXXUSu02YahidtwlnD5NgCfoC5GbnCFMRI9giwNnEPoQ8cgSt2l8Jj8fjFyMeC274AwAA
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
Cc: Krzysztof Karas <krzysztof.karas@intel.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5285; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gyXKQrUKu84qG3DVHb5oBzmERPpCPM0gV75gBsZhfxg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUswRhv+C8BI9lCOgoX3XMLs16DEI6rYCHwauU
 ak91lh/d36JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFLMEQAKCRAADmhBGVaC
 Fc09EACpZvR51gi2ztNt1WxYwDm60roEo7ktgTxN5oyeOR1kxNtv3R8a6yzNar4H3htZZyyA9ho
 64CfB41bKkOo5ycufIR1oF7DEVZGvkAioIB+mXgO1DqdCWyAXNvdOqjNSQTkNLrNbeU5JW4PrAv
 LMyea0eJIATbAh0fugBc0xPyCYGWHNvZsLkpmXGIStpBwUzp5coZcj+v5OQuo99sx47Bj/wq7S6
 DMic17vYWiV3We1yvyQqTvvLiuxlgynfGOu+h2GIyu0IkOsdmvMvdWKodxYOOP9nn9pc0E2PO+q
 BTjh1ghPswAyk3CjS1neBgfVQes2vJkpftxVCTGMmIwwlY3QvSc8rAOFJRM6leZh9XZ53Gn9uza
 hAzme+6f1M/3poKkXgG3tmTzjRAtP1HWm9Jj0/dM9BynEHzykENDa32Du51IL96S8CEDVfsTGbX
 /4Ec0HF393yf0X5l0WBOi7WptSmsvHIRCNqinFQP9/6UuOJb0yI1qZV1WW6kfKYGPRfgZoLWWke
 3rt+g/wxbpfT401zP772VW3PhBIZ742yrf6+C6bg8nDLbO72kzffgHjuUEl7dw/wQJ2pw+Q9RkS
 WZAttWoeTyRjjS0kOQhusYMBn1YT3ygcZo0GVnY4DWQnOMZceA8mPMCmwEwI9vTWBMFlNinxe4Q
 NSSoC9oxejzwlUw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

For those just joining in, this series adds a new top-level
"ref_tracker" debugfs directory, and has each ref_tracker_dir register a
file in there as part of its initialization. It also adds the ability to
register a symlink with a more human-usable name that points to the
file, and does some general cleanup of how the ref_tracker object names
are handled.

Jakub pointed out that I hadn't gotten the xarray locking correct on the last
set [1]. This version should fix that:

[1]: https://lore.kernel.org/netdev/20250611071524.45610986@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v15:
- fix xa_lock handling to be IRQ safe
- Link to v14: https://lore.kernel.org/r/20250610-reftrack-dbgfs-v14-0-efb532861428@kernel.org

Changes in v14:
- Clean up dentries asynchronously after ref_tracker_dir_exit()
- Link to v13: https://lore.kernel.org/r/20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org

Changes in v13:
- drop i915 patch
- Link to v12: https://lore.kernel.org/r/20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org

Changes in v12:
- drop redundant pr_warn() calls. Debugfs already warns when these ops fail
- Link to v11: https://lore.kernel.org/r/20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org

Changes in v11:
- don't call ref_tracker_dir_init() more than once for same i915 objects
- use %llx in format for net_cookie in symlink name
- Link to v10: https://lore.kernel.org/r/20250527-reftrack-dbgfs-v10-0-dc55f7705691@kernel.org

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
 drivers/gpu/drm/i915/intel_runtime_pm.c |   4 +-
 drivers/gpu/drm/i915/intel_wakeref.c    |   3 +-
 include/linux/ref_tracker.h             |  50 +++++-
 lib/ref_tracker.c                       | 283 ++++++++++++++++++++++++++++++--
 net/core/dev.c                          |   2 +-
 net/core/net_namespace.c                |  34 +++-
 7 files changed, 352 insertions(+), 26 deletions(-)
---
base-commit: 8630c59e99363c4b655788fd01134aef9bcd9264
change-id: 20250413-reftrack-dbgfs-3767b303e2fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


