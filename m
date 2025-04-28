Return-Path: <netdev+bounces-186529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA0A9F870
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD1316FAEC
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D11B3934;
	Mon, 28 Apr 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK5vlaER"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153526AF6;
	Mon, 28 Apr 2025 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864824; cv=none; b=nKhgRGRHXJR8stjVh4VhEQd3NnAvK5jN145X8f0oL5bpRAJ2ca294UlvYJ6vNls755q1qFrrDrXBOd3iEWEjJlaBSrgu8QNNf0G+UbM2dQRSxFAkfgUt41iOX23jp/ESTD8FVZR4CmFQ95mJB8C5A+matzMe0+HJxvUMnXHwCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864824; c=relaxed/simple;
	bh=h5NvfaerCqqps0cYzgZ9hk6memBJ3cZgDY3NSZ5Txjs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hbMUz7f2TbgUBfAYPjK9tcavB+n0VBo8T+OnKWxOXGVNVTaR/9nRuXkU4XHQYj4o4WXvFJQmsHEdDFL/ByoXRRoznjnlSn6ONMLee2TMjimDtBG8sHKybi3DF+VqASDiO3/idovJChMRhBfxafT7vNunzUpUxX1vcUDC4nrLgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK5vlaER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071C0C4CEED;
	Mon, 28 Apr 2025 18:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864823;
	bh=h5NvfaerCqqps0cYzgZ9hk6memBJ3cZgDY3NSZ5Txjs=;
	h=From:Subject:Date:To:Cc:From;
	b=EK5vlaER0+czh36fiLkRaLGLy7vyk1yh6mCHlfaBDlhKdEcmsRi1oJs/h/HSsFGF0
	 zOWVevDhweqDE9lkWZh0a9t47fvmXB+gUNBU0B3kx0MvZKsP83h7xeYdPrXAbLYEQ3
	 8h9ogbtfVs8zaaG0nVY5kOLu5qlL1m2dSEzlOyg7WtOIq2jRFNIKErhIPW64lTgLvD
	 weZSj/4fLeEhHJsntfqXCqRxTo54rc4MZP5FrJ6BwRNlcSs81mk72HJeuDeYmx2A/g
	 FuzqDoewJWUX1RJhAjzbTlXRsYkNw5tDm5Rci4fVbrBc9UBexO3o/SPuBQKIr95f+E
	 cC+8lJprhAHdg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 00/10] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Date: Mon, 28 Apr 2025 11:26:23 -0700
Message-Id: <20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFDID2gC/2XMQQ7CIBCF4asY1mJghrHUlfcwLoBCJZrWgGk0p
 ncXTUyqLN9Mvv/Jsk/RZ7ZbPVnyU8xxHMqg9Yq5kxl6z2NXNgMBJJREnny4JePOvLN9yBybbWN
 RoIdgWEHX8o/3T/BwLPsU821Mj09/ku/rN6X+U5PkggeBpEkjgMD92afBXzZj6tm7NcHSU+Whe
 Cu1U8Z2EiBUHpe+qTwW71BSq0A7HWzl1dLryqviyRlyjW5bUurHz/P8AmLli/FtAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3743; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=h5NvfaerCqqps0cYzgZ9hk6memBJ3cZgDY3NSZ5Txjs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoD8h0Gv1hJSTC52TiQX1Rum6sG9p3zd0+46lkO
 ABX5YCEVFmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaA/IdAAKCRAADmhBGVaC
 FWBlD/9nSekgdog3Y0VbADaub1JMYh6XgrPCxk66va48i1As/b4j+949889BsJXOuU5eo1qYYv5
 2ZBqcDue3RzxePkz9jw2cWg8Zo7YU/7//UKTqRVI6kG+vf4R2lhmLctKR3oWFuWWmwyh+IvuhNT
 kFyYYZ12L2pvx12FFj9qkNPwHD9JUT0mkJztQjiysVueJqqHkGHkFbZPJ2YikAHu+vMmb/+Aqrm
 utmSB/wIXxRezR0MERBzxEC0K9rcK07noF3B+8AfPrGrNkSYGjaqY8JDogMsFZdvjUIh9/4MZVg
 arhS0Z8/l9qSi/rzz84Y3LuUrgwyGeQpl726/D3EXqZufPcdQi3/5Zy/5wgonetj1Z93I85Mlh8
 oe1qOzLkBHWep2exCnUhuAhtaQE7oyuMh5Ko64JjTaI2Dfh7gnPP5vmhG0ffzPF4ej6ge2mb2qL
 5imTmUlovF/SI2qbppJZIdT/8wQtRXNIdQ8hBxJO/8vH1b2DgQ9ufuA/SDgrKbimiZhq1pmx+a0
 CUZOYzRvsUW/yG3f0oTq2+NmVZglafk2dObXM6k7Rr3rNDQa+OjHpSp+JZrMVaWoDn6s79uiYW3
 2Mnqcyz470Ltg27ob5LIzJJ+MFF197KO6zixiHZ1+zuDUewp5jc9IJNQcpX02XDVQslelNckqCK
 t+z/OEdbZsXRXiQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This one is quite a bit of a change from the last set. I've gone back to
auto-registering the debugfs files for every ref_tracker_dir. With this,
the callers should pass in a static string as a classname instead of an
individual name string that gets copied. The debugfs file is given a
name "class@%px" The output format is switched to print "class@%p"
instead of "name@%p".

To allow for human-readable names, I've added the ability to add a
symlink in the debugfs dir that can be set to an arbitrary name. This is
optional. I've only added them to the netns and i915 trackers in this
series.

Finally, with the above changes, we can eliminate the "name" field in
the ref_tracker_dir which shrinks it by 16 bytes on a 64 bit host.

The original plan was to merge this via the networking tree. That's
probably still doable but there are some display port and i915 changes
in here too. Note that those are untested, mostly because I don't have
the necessary hardware handy.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
Jeff Layton (10):
      ref_tracker: don't use %pK in pr_ostream() output
      ref_tracker: add a top level debugfs directory for ref_tracker
      ref_tracker: have callers pass output function to pr_ostream()
      ref_tracker: allow pr_ostream() to print directly to a seq_file
      ref_tracker: add a static classname string to each ref_tracker_dir
      ref_tracker: automatically register a file in debugfs for a ref_tracker_dir
      ref_tracker: add a way to create a symlink to the ref_tracker_dir debugfs file
      net: add symlinks to ref_tracker_dir for netns
      i915: add ref_tracker_dir symlinks for each tracker
      ref_tracker: eliminate the ref_tracker_dir name field

 drivers/gpu/drm/display/drm_dp_tunnel.c |   2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c |   4 +-
 drivers/gpu/drm/i915/intel_wakeref.c    |   3 +-
 include/linux/ref_tracker.h             |  41 ++++++-
 lib/ref_tracker.c                       | 194 +++++++++++++++++++++++++++++---
 net/core/dev.c                          |   2 +-
 net/core/net_namespace.c                |  32 +++++-
 7 files changed, 252 insertions(+), 26 deletions(-)
---
base-commit: 5bc1018675ec28a8a60d83b378d8c3991faa5a27
change-id: 20250413-reftrack-dbgfs-3767b303e2fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


