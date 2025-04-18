Return-Path: <netdev+bounces-184159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841AA93896
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41101465CB3
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297918A92D;
	Fri, 18 Apr 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYuN4sSg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEA2C1A2;
	Fri, 18 Apr 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986276; cv=none; b=XyPmsJAkra7LSXWwPokqHyrPa6MB03gaizkpGhtwP2JJaiqWVVSAP3Fo5TS2fV6BooVEB5D7RvmHdlT4m3VaW+3dLx6Xj4oqiYIBJHmyPLsmiwrl7SaBmPUAK+RjYcfCGS+fYsTwXF/eSwPcKnadDE37NrAAOxCFhWsOjd0qsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986276; c=relaxed/simple;
	bh=9nFO2uV/6R5my/yO8nRy9Gc5lPiZRpUZnZeySK77PSc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eqevWe5EqAa9tMeiwPCkFYjI4Nfuhv16SEarFD3D5PWO7hG2ZGZNgOEKqPsUNNuYgrVE/RZ0icFBrbgxSWstW/TAbD+nzphQKwYQZ1j3IVPuD/tJ32+b2B6+bYaLJibG4B097hISTaCphRXQHurczVGRS98eHWOf5Ceniz2HskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYuN4sSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48327C4CEE2;
	Fri, 18 Apr 2025 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986276;
	bh=9nFO2uV/6R5my/yO8nRy9Gc5lPiZRpUZnZeySK77PSc=;
	h=From:Subject:Date:To:Cc:From;
	b=gYuN4sSg7ZpCPmi416kdmbNcu3ww+zffYxlpdnoK7NgAgA5ZUXpnms3oOdaf+NjaB
	 3cdB0aopw55+EMt2G4UIM5ZtQ/QBqkMy2ay55WUptf/XPdJClPBjeK3H5wCb6WEX18
	 jEruut+qDkeDp704L/+OD3jx8BX8w7fDcNJMAOBZZz+2cDCIXwytgvOnB0ziKTioPZ
	 9grxJC0C+BYkDX0FbR5My8UiM2qOPBqHGrMrUiBY5FJtuXdIovmiu2+vKh3ORLNuna
	 EMN55dxBU2eBgyP6SQDSM2e+I7PLJ2lxHWIJ9r1+fQ8eh+L2PAQd/22Ccg59u4Air/
	 RfgW3iLaYp8+g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/7] ref_tracker: add ability to register a debugfs file
 for a ref_tracker_dir
Date: Fri, 18 Apr 2025 10:24:24 -0400
Message-Id: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJhgAmgC/2XM0Q6CIBTG8VdxXEeDcyCpq96jdSEIymzawLGa8
 91DtzbLy++c/f4TiTZ4G8mlmEiwyUc/9HmIQ0FMW/WNpb7OmwADyQRHGqwbQ2U6WuvGRYrlqdT
 I0IKrSEbP/PevNXi75936OA7hvfYTX67flPhPJU4ZdQylkgoBGF47G3r7OA6hIUsrwdbLnYfsN
 VdGVLrmAG7ncevLncfsDXJ5FqCMcvrHz/P8AQBgcH0tAQAA
X-Change-ID: 20250413-reftrack-dbgfs-3767b303e2fa
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9nFO2uV/6R5my/yO8nRy9Gc5lPiZRpUZnZeySK77PSc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAmChvduo3yDD9PFjedE268IXAg7BNeU1w3gL1
 vUNQq0Lo2SJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAJgoQAKCRAADmhBGVaC
 FRLcD/4g8wKYKiiarDRpC13+LZMKlU/x4Ohycx6e2qiMsWBMjCFtU3E/aYv2gx/bb86lou/+UQi
 eNaCO6HHAW3u+iufA4+SGhJC3V2ZrrN8RayqqVwj6PGBoCpbon9OxzB65jo4zg8S1YuKcEm5++3
 3ceBgeKlj9dmhyEsJph8UxPuP/H/0c5bAk5lakNMKv4Rok0pOMvY383w902NJfzrDODlP4sc44+
 d8hRMNT4pPjcQUoJrjMkW/PYTMcZAira/yQe+wrT8mM7DEN4tJ1ce8JqJc9wAiGouVrEXTunrLJ
 dE6qy3ONlXu1DTdpeUDh1w7Dxb+u8+F3NaJwt8IejmqlRa5bobDTRtn8kqygPt3mFn3C9IFvNkH
 Cd5XQRaFWaX/6HBH90vvZ8/CbuZ7ZvBCqYpLGrpSPM/wv5/FV9Hu23ntSEhvn0Yf6WrYFZhLNiN
 oPrz0XWwJ2xAsEna7eiXB/j8oslc3YFmoYOrdBabJwIspOULWsN1Fro1U1m8WHGxsL639WcNgWz
 N6lT23VWLwMiNbpf++c2lmjQFiCOTEpFils2zVKYQ8WN/Ur3Xb3BHQynG9PIF4/VWJIEQRMSA7f
 +A+qEmgI1itlrmIy77BAfYtSPuthg/MXigWOE5OnGIM8mh+FzBR4bHEtuUCzdra0hZc7m9OwqoK
 S6S7fLYUVR58yJA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This version should be pretty close to merge-ready. The only real
difference is the use of NAME_MAX as the field width for on-stack
sprintf buffers.

I left the Reviewed-bys intact. Let me know if that's an issue and
we can drop them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
Jeff Layton (7):
      ref_tracker: don't use %pK in pr_ostream() output
      ref_tracker: add a top level debugfs directory for ref_tracker
      ref_tracker: have callers pass output function to pr_ostream()
      ref_tracker: allow pr_ostream() to print directly to a seq_file
      ref_tracker: add ability to register a file in debugfs for a ref_tracker_dir
      net: add ref_tracker_dir_debugfs() calls for netns refcount tracking
      net: register debugfs file for net_device refcnt tracker

 include/linux/ref_tracker.h |  13 ++++
 lib/ref_tracker.c           | 151 +++++++++++++++++++++++++++++++++++++++-----
 net/core/dev.c              |   6 +-
 net/core/net_namespace.c    |  34 +++++++++-
 4 files changed, 187 insertions(+), 17 deletions(-)
---
base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
change-id: 20250413-reftrack-dbgfs-3767b303e2fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


