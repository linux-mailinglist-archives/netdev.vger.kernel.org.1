Return-Path: <netdev+bounces-71611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C8B8542C7
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 07:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152F61F2651C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 06:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B42410A25;
	Wed, 14 Feb 2024 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZcJzoO6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9211183
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892094; cv=none; b=Q/KE9HA059Wb5X+y041sCZzHlPHAmkoieFJ8edQxu4pC/wvEpjPO/PkekgRPBeZPIYq3+L8i3XhhLtCdkCZva4Mx8EY2+L7SJZ9eV40z6nQpHeVmfQr0x9a5nWa0oWj6auS+Qrz/p8UtVSYgDZToSDgUiixhu4WDXtXPXErPrU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892094; c=relaxed/simple;
	bh=WkZA+E7q8KYUi6XYUq6rjkEwRL31FZWVxGw+FHkxPHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWtb7AJpqDwfiEJ/Jch4oVtO8xh79e+UH/VuOahDc/XgJJiYZScbHw4TTm3lASB86AHvTDHaOYYI9YqidL97+7ZSc9T/N7YYNk911sgHglsdDz5PSu7nxrS2sLWcjFKnvAbV2538MYsHSm9wnGG4Z0+ZNVoczMhncH3zVnb1hmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZcJzoO6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d731314e67so12131465ad.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 22:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707892092; x=1708496892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yId8+OmoKZ6TgzWiXO+Y0wAOUleKHYnUhEOkQC1qWQ4=;
        b=EZcJzoO6xFhyikcMG+YhFDOB/KHRKLjH8WduOekVhEwjR8EvPTEiSwMEYA+NXjpYj4
         9t1QpQI+B4T6BY4r0H4r9ivm9QIXj7UPP43224ANpEiPXQjuD7yTNx5N5GvJmR0yFhf3
         ud4HTwH8pH5X22jaDGs3stkLYAbGTaA2DMQniAWtUL0ufOXRjhnk8OBFk3FzC6kCZEk2
         isGhWYDTFFd7f4zW0MI6m4hIN9GPBHCHQygIL68iF0Q0Kh0mkrTr0X+LYV1/Emn54CDQ
         +NPIlM7+6faP9/L8lT/S9oeT2RgQOOp7BqDVb/JCb9RG9l+JkUWuMNvbyBbNGyLx6bCk
         SYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892092; x=1708496892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yId8+OmoKZ6TgzWiXO+Y0wAOUleKHYnUhEOkQC1qWQ4=;
        b=SiNxz8Rh+4HJohsU9XEHLNiBzNWAetU9HUAoFlwV9e1/r5p7/gVQVufcWyJ8LrG6nQ
         kuNGUCbn7ygXGRazfSgQgA8b0pULAtMhZSpSGByVCQStDDPH1joVp33K3jJdzmKQ3H2G
         rsXiocSlgyC1tariyH0BZp9rkJUPmAZPyX0n04dga+ERIJLqRScG2v12WpufEAtwW7O0
         2t8Tbi07GrzaWEtd3KxWSN812XSFbugrF1oa60LqpwIjqGW2kN7KcOoLjT6ZQR88P+6y
         wdbws/WZtc/lnBAs2arm5ORI4ydvcaFos199V70UWL7c94JEWxlKvDsxvn3Yi7zTtNiP
         VBaw==
X-Gm-Message-State: AOJu0YydNSdgerkCbxyKafBuVhjgtG1enZwCGEsC1v014jjdTTW9oVMj
	NI+8ggqLJ+qNNN1OhF4aT4fE3v9XvEaRKHHoyjRcG+BvswZFRXnavZJXQdJD7ZE=
X-Google-Smtp-Source: AGHT+IG31vVq2WqJnl51p0q39DPRKTlWLdZhhL0Y5l4G4mPNfdq96uxim+5HGOeG5nBeh3gCU53DYw==
X-Received: by 2002:a17:902:f685:b0:1db:28b1:b5ca with SMTP id l5-20020a170902f68500b001db28b1b5camr2345200plg.29.1707892091894;
        Tue, 13 Feb 2024 22:28:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX29KtfpGlxcTkQUVz5ScG/oLxnTcQYJiqbf+Leaks5s1c/0HSI2tWz/lIXtL161TE8Dyh0sD03v80dafQZ8CeeKCW0+AGs9b+0BRG85STefhCpHDLLWSAUSqJtt7gJga5Fryhom3sYi67v40hwH+pwtacB9kt86V5p+S0vJCrKavwzc69+fjuQ6DKZvHF5ZOw7gmAZViP8kmp+a51aSrG2NK1hdp0MaLDx/hMbXGdcUq5Y9F7TPKn35jegb1gLavu2YO5Hzb8=
Received: from xavier.lan ([2607:fa18:9ffd::2a2])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902e31300b001d8dd636705sm1983843plc.190.2024.02.13.22.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:28:11 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	dan@danm.net,
	bagasdotme@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jikos@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH net-next v2 0/3] net: ipv6/addrconf: ensure that temporary addresses' preferred lifetimes are long enough
Date: Tue, 13 Feb 2024 23:26:29 -0700
Message-ID: <20240214062711.608363-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240209061035.3757-1-alexhenrie24@gmail.com>
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 corrects and updates the documentation for these features.

Changes from v1:
- Update the typical minimum lifetime stated in the documentation, and
  make it a range to emphasize the variability
- Fix spelling of "determine" in the documentation
- Mention RFC 8981's requirements in the documentation
- Arrange variables in "reverse Christmas tree"
- Update documentation of what happens if temp_prefered_lft is less
  than the minimum required lifetime

Thanks to David, Paolo, and Dan for your feedback.

Alex Henrie (3):
  net: ipv6/addrconf: ensure that regen_advance is at least 2 seconds
  net: ipv6/addrconf: introduce a regen_min_advance sysctl
  net: ipv6/addrconf: clamp preferred_lft to the minimum required

 Documentation/networking/ip-sysctl.rst | 14 +++++-
 include/linux/ipv6.h                   |  1 +
 include/net/addrconf.h                 |  5 +-
 net/ipv6/addrconf.c                    | 67 ++++++++++++++++++++------
 4 files changed, 68 insertions(+), 19 deletions(-)

Range-diff against v1:
1:  95ff3ac2f7a9 ! 1:  6978ee9a6d9e net: ipv6/addrconf: ensure that regen_advance is at least 2 seconds
    @@ Commit message
         Link: https://datatracker.ietf.org/doc/html/rfc8981#name-defined-protocol-parameters
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
    + ## Documentation/networking/ip-sysctl.rst ##
    +@@ Documentation/networking/ip-sysctl.rst: use_tempaddr - INTEGER
    + 
    + temp_valid_lft - INTEGER
    + 	valid lifetime (in seconds) for temporary addresses. If less than the
    +-	minimum required lifetime (typically 5 seconds), temporary addresses
    ++	minimum required lifetime (typically 5-7 seconds), temporary addresses
    + 	will not be created.
    + 
    + 	Default: 172800 (2 days)
    +@@ Documentation/networking/ip-sysctl.rst: temp_valid_lft - INTEGER
    + temp_prefered_lft - INTEGER
    + 	Preferred lifetime (in seconds) for temporary addresses. If
    + 	temp_prefered_lft is less than the minimum required lifetime (typically
    +-	5 seconds), temporary addresses will not be created. If
    ++	5-7 seconds), temporary addresses will not be created. If
    + 	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
    + 	is temp_valid_lft.
    + 
    +
      ## net/ipv6/addrconf.c ##
     @@ net/ipv6/addrconf.c: static void ipv6_del_addr(struct inet6_ifaddr *ifp)
      	in6_ifa_put(ifp);
2:  c7f773887259 ! 2:  e2b3623db770 net: ipv6/addrconf: introduce a regen_min_advance sysctl
    @@ Documentation/networking/ip-sysctl.rst: max_desync_factor - INTEGER
     +	How far in advance (in seconds), at minimum, to create a new temporary
     +	address before the current one is deprecated. This value is added to
     +	the amount of time that may be required for duplicate address detection
    -+	to detemine when to create a new address.
    ++	to determine when to create a new address. Linux permits setting this
    ++	value to less than the default of 2 seconds, but a value less than 2
    ++	does not conform to RFC 8981.
     +
     +	Default: 2
     +
3:  b4e3dc5b3479 ! 3:  422f2a0a209e net: ipv6/addrconf: clamp preferred_lft to the minimum required
    @@ Commit message
         Link: https://serverfault.com/a/1031168/310447
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
    + ## Documentation/networking/ip-sysctl.rst ##
    +@@ Documentation/networking/ip-sysctl.rst: temp_valid_lft - INTEGER
    + temp_prefered_lft - INTEGER
    + 	Preferred lifetime (in seconds) for temporary addresses. If
    + 	temp_prefered_lft is less than the minimum required lifetime (typically
    +-	5-7 seconds), temporary addresses will not be created. If
    ++	5-7 seconds), the preferred lifetime is the minimum required. If
    + 	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
    + 	is temp_valid_lft.
    + 
    +
      ## net/ipv6/addrconf.c ##
     @@ net/ipv6/addrconf.c: static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
    + 	unsigned long tmp_tstamp, age;
      	unsigned long regen_advance;
      	unsigned long now = jiffies;
    - 	s32 cnf_temp_preferred_lft;
     +	u32 if_public_preferred_lft;
    + 	s32 cnf_temp_preferred_lft;
      	struct inet6_ifaddr *ift;
      	struct ifa6_config cfg;
    - 	long max_desync_factor;
     @@ net/ipv6/addrconf.c: static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
      		}
      	}
-- 
2.43.1


