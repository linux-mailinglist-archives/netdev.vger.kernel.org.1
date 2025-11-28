Return-Path: <netdev+bounces-242630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB3C9338F
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 23:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B7804E2797
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827152E339B;
	Fri, 28 Nov 2025 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V65nveDI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F382DC791
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367694; cv=none; b=f17IJ/Sr0rbdzMqPNYM5TM5sKVtbqnB3K/cEz7MZL/5kLDut52y4pEXw3Erf4E6zwAIGScJSWq/mM8nQfr2ReX68R8lfmPBM0sYD5Xx3Cv54SnoJu02iW3U8zCCdwrdL5c9q7a/3ksE4eosDIarNcA+zEst2eTnOwQE/oMtIVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367694; c=relaxed/simple;
	bh=nJpadpldOBZRqMIPKhAV4aTclKnqAj6/LU3KTCvm2AQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nqO/67oHHQChG5FNC6m+yiuSbBJsgpo5CMTIRvxGc6RvrCmMLjJufQncCCFl9h4QaKhINFl4Lz9ZYPdB8jcoXv8JAT4RUZSTGo0xtRu4n8BfDfuiHKUSjsn3JtvlXN3MWDoXC1N91gnsp5F72cg/QPQPxXxSyYbKjoaWZYtExg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V65nveDI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so2009837b3a.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764367692; x=1764972492; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUan60wfJsHkrD1kHPjsQ4NVghOy/Ntfd2uLK97RNm4=;
        b=V65nveDItGJZH4Ec1tw7ccqbCWsOrEuvr6fSXyVOT0cPz247NiFVr2Wpyn5Jrc23E8
         T4rMVR6XpBqECLhUjUy0CzMPnRgWq/jOLimbKy4Iias0s55b+7Uc80rpuKbpPjg+qfvH
         TprK6zqeBwYA6QGnBsyy1o5NwdWr7+sNNgMzKQTUwV3drZgKOLDx4K2uRQ3yirvjhzys
         v4IiUzKjS2I1qUrdrejTKID+aGMCjDTH+lnWyvba0sgjPNBTPYYeHCAcxHUyHRB07r6b
         wQHLIMSXItMPsnilxZfPndOy50sjHrOHFoeZJXcHMbbEaATLK6QmoZNIESs8/raPwUVG
         UcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764367692; x=1764972492;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUan60wfJsHkrD1kHPjsQ4NVghOy/Ntfd2uLK97RNm4=;
        b=j7vea0fimSaMCx07eS9u7wqew0q2kOhjnsJrM6IT4DbSRNaYOOTn5VbCD5sNAwGGzx
         tC9akA2tMiweoPXzHtcbJxKBdeOFJlk7/NqNEAeQOUSMX3glvqn1T4HjBSlTSwG0uy8L
         mmsQ+XNhiV05UYPxO5OLgnpnvuEgpgVV/6DH/kvVaRjd6KcAQazpZZOiGhoepyPPpi/+
         4C8+CMe26oVicRsWFHXD5US/h26ThAeN27ZfbDM19kjqaHXws5GCWrOhnpoQ7E9mfoJa
         NKJztu+ZJJa/2PmbjxUflbGNAOkhVYC+OaK8Y6cdVF9dGemk5bHBqrFvmQNsTWAHynYr
         Odzw==
X-Gm-Message-State: AOJu0Ywm0D5Fx5ewjvimudfSMIZ3WMkfMiRgtaRRe2DH5wUifuSFVR4Y
	C2nRzVuCMrM2lnXbs/RTH/ALSWqwfjVm09/MkVcumhbNDyrkQuKN7AhQ
X-Gm-Gg: ASbGncsiJDaVyn/NicyQ9eCIy+N0c65bXkyZs1kvQGwmp0WJPXGxk2cLtbwUOmWPEw6
	K1I/7ZUd/moNWlkLk5varyYltjTkEPTnzZ3yiIWY4YR5Vk3XaGjjAmHuX0mTyyk01e3/J4bPIo/
	Ur9tzwNzKnKo7qW322RG87qis2xOwDHLzf6sRH5lyUyn1UGQzcZDOv9KkycuR21KSJ7/Wyifxgh
	iv5KMHFlddfaCiiMFn/PlB/daY5A3F+NsbrA+MviDpneqJXsQM7zhWjkaxqpkAH/9BZHRfRJxQP
	dVmyUbfUK/tOSKiBUNk7GJ3Llrw5FictsCrotlU+JNwNy1Tunkl7UnoHnfv5hIfkpVgmsbZMs6P
	YqSrDnMPvEkgkyDzfdm4Mzh5rXNuWQFY7CRn5Ea6C9qF7mJYfrbEkHIHPETV1DlRJHSawIFbpcK
	rH+8hRmC6JlNVCUgHu5F5mZ6Hqd4NQ
X-Google-Smtp-Source: AGHT+IGSx70Oj02Ci9/crptGoCoRHymMO6MlB+ROKyjGSb4e1FmSebU605sdyF6JXWkqWHcYcbzkdg==
X-Received: by 2002:a05:7022:4424:b0:11b:9386:a3cc with SMTP id a92af1059eb24-11c9d872af1mr17173439c88.45.1764367691826;
        Fri, 28 Nov 2025 14:08:11 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm26824205c88.3.2025.11.28.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 14:08:11 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v8 0/5] netconsole: support automatic target
 recovery
Date: Fri, 28 Nov 2025 22:07:59 +0000
Message-Id: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD8dKmkC/23QS2rEMAwG4KsMXtdFlp/pqvcoXfiZMXSS4oQwZ
 cjd62ZRzMRLIeuz9D/IEkuOC3m7PEiJW17yPNXCvFyIv9ppjDSHWhMElGCYolNc/TwttMS15HG
 MhVqRpNAueaM0qXPfJaZ8P8wPUp/XkftKPmvnmpd1Lj/HZxs7+oc7wNBxN0aBchvtAGJA5dP7e
 LP569XPt0PbsBGQ9QSsgoVoBIBCrk8C/xcY6+/Aq8CUFB4NOBfVsyAaoZvOJqogcQAnExPg8Vm
 QrdDdQVYBvQ7BKpAynHZQjdDPQVVh8MCTtOiCOuWgW6F7hf7LIRgVnDXcMd8K+77/AocPl1xIA
 gAA
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764367687; l=4229;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=nJpadpldOBZRqMIPKhAV4aTclKnqAj6/LU3KTCvm2AQ=;
 b=DTxYpted+ylrZjL9BC7vPGiTQ1Qy2LgsUdLWMeSgrxAFbIrBaOqKPmWuvDSJR2YlNANr0vhHw
 W/0H7cVY3MkBuK6SETdRXTutbGkECf35aRdZvG+s0yE0D1DNYSYFGqL
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patchset introduces target resume capability to netconsole allowing
it to recover targets when underlying low-level interface comes back
online.

The patchset starts by refactoring netconsole state representation in
order to allow representing deactivated targets (targets that are
disabled due to interfaces unregister).

It then modifies netconsole to handle NETDEV_REGISTER events for such
targets, setups netpoll and forces the device UP. Targets are matched with
incoming interfaces depending on how they were bound in netconsole
(by mac or interface name). For these reasons, we also attempt resuming
on NETDEV_CHANGENAME.

The patchset includes a selftest that validates netconsole target state
transitions and that target is functional after resumed.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
Changes in v8:
- Handle NETDEV_REGISTER/CHANGENAME instead of NETDEV_UP (and force the device
  UP), to increase the chances of succesfully resuming a target. This
  requires using a workqueue instead of inline in the event notifier as
  we can't UP the device otherwise.
- Link to v7: https://lore.kernel.org/r/20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com

Changes in v7:
- selftest: use ${EXIT_STATUS} instead of ${ksft_pass} to avoid
  shellcheck warning
- Link to v6: https://lore.kernel.org/r/20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com

Changes in v6:
- Rebase on top of net-next to resolve conflicts, no functional changes.
- Link to v5: https://lore.kernel.org/r/20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com

Changes in v5:
- patch 3: Set (de)enslaved target as DISABLED instead of DEACTIVATED to prevent
  resuming it.
- selftest: Fix test cleanup by moving trap line to outside of loop and remove
  unneeded 'local' keyword
- Rename maybe_resume_target to resume_target, add netconsole_ prefix to
  process_resumable_targets.
- Hold device reference before calling __netpoll_setup.
- Link to v4: https://lore.kernel.org/r/20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com

Changes in v4:
- Simplify selftest cleanup, removing trap setup in loop.
- Drop netpoll helper (__setup_netpoll_hold) and manage reference inside
  netconsole.
- Move resume_list processing logic to separate function.
- Link to v3: https://lore.kernel.org/r/20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com

Changes in v3:
- Resume by mac or interface name depending on how target was created.
- Attempt to resume target without holding target list lock, by moving
  the target to a temporary list. This is required as netpoll may
  attempt to allocate memory.
- Link to v2: https://lore.kernel.org/r/20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com

Changes in v2:
- Attempt to resume target in the same thread, instead of using
workqueue .
- Add wrapper around __netpoll_setup (patch 4).
- Renamed resume_target to maybe_resume_target and moved conditionals to
inside its implementation, keeping code more clear.
- Verify that device addr matches target mac address when target was
setup using mac.
- Update selftest to cover targets bound by mac and interface name.
- Fix typo in selftest comment and sort tests alphabetically in
  Makefile.
- Link to v1:
https://lore.kernel.org/r/20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com

---
Andre Carvalho (3):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target resume

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 171 +++++++++++++++++----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 ++++-
 .../selftests/drivers/net/netcons_resume.sh        |  97 ++++++++++++
 4 files changed, 270 insertions(+), 34 deletions(-)
---
base-commit: ed01d2069e8b40eb283050b7119c25a67542a585
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


