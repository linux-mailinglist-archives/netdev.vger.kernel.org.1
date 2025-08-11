Return-Path: <netdev+bounces-212567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379D9B213EB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB366222A9
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F22D6E71;
	Mon, 11 Aug 2025 18:13:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9762D6E5F;
	Mon, 11 Aug 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936022; cv=none; b=gzDFbawVziyP4wmUkdi0kl5UN/8wLrAYJj9TbPtOnaUlsTXiTcau5nif9Y4d8AGhdM4OPMp91O1ZcfmLf1mEAzXBkdE/A/WWtyjATaq5oie/PbU8soIVqGF0zGZG2EEPDk60e7+/8j/Eu3/fBkUaw+KcgSPgV5oQIJZpmN6T22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936022; c=relaxed/simple;
	bh=HGXtRp+Nh1wheFCOXlrXqfEXKazzUVmIXY8bJFRZTeo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ecCYY1Qi+1ZRlN5UfFEHxkt+OUZUOAJjaG2LrcVgeIvHFGZaNA1jGS+ShtGEwc/dZIcZbsyR7q1TXTmQLqQSmWVOtUPqUH0P60SuUw4s+jfp/y9n4xt9a33i34tBXqU14dkleMUhxaqgny0DShDaGD9pkIQFjwkUoYRrmhjosWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so7296125a12.3;
        Mon, 11 Aug 2025 11:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936018; x=1755540818;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keRpLAPBAmv8YSWehH5EMn2xameRzUf+XzLAB7HzxJo=;
        b=cJgEnjBaZ8ykqNjWK9bBplcWaIKTI/pOdu450SN4/7qzenRlS1MsdnqsAqQ2byN5ZW
         KNHgVpJJ0bx+jSTUh/TdZKZD4EBNWSe9qdyzc3KcRNhNklugOWHyokikg/IpclMrBdAK
         UpCfuM5hEzYp8h7WOcUFsV5Og3F5aZkm/h7GHtYX4fQymN91BVmGC1tJ1rsT/UVg5TEv
         eJeJSpfxIeExWr5hU/XyZ7FRuP51V91yVb7mfjMvd953YVRLB8fh3CNc1r6DFTUKVZrH
         8CfoFEtyOg5GEnksoUPNkLIMwGJ/hBXXS/p9WkiMbO2AO/nWh6ENxi12v9ekhjTPrTCU
         6/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVHlSIF4f8sfCvs4BkBciqL74TygrUmYlH4je09MjuNwg0OqKUk6GqDKYxxmSR17CVH3NspKZJicDNpQgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlYVuTZ6BWCFtaU8fIbdxZOnMr3l8fRcxKmGna5ORbEzGOkec
	S4UB+9MHl/Hu5xrcLAsZW1Yrzc9DutnI3vnQD5u5QJi8ZcP3Bmk8qsIo
X-Gm-Gg: ASbGnctrHFl4PSFVae2fMk5Ea8RJj2ehZ0IHDtaG8ZNPX3ReH9YslJydVk95WJlJTET
	C/uLf/ywjd5dz6SzvxjcuxPVE7wIcTp3la4lehM9k5Aj3lEkit6QaeADAIfjWfT7NoY05nwD5Ox
	JU/UuYNomGNxZmbqR6jlbZHgLMQiKaD6S/47c4gi4Mp1CCDBPvNqYRvPriuXMMsRwhA0+B9opD5
	f7r05DrHAaYb9Yfo++rqTRDKTIMYSf96r3yuC3RlJDDROaTJbUFshZaOkm6vhVQyORlakvK1366
	jm3c+Vx+nDTY0YoULCtFU412NYmOA4jPWVAoqT4iWyQwFJ0IgJEvBiUzXTCcSUGAQ7ncWCcdqY9
	m8Ql5Q74loRHDJA==
X-Google-Smtp-Source: AGHT+IE2CA2U/XGWNHdlD1q/ZHK2Qu71KQqxKfh4cJFWndI5vZqUCDzYn1x/B0kxawxMgvMli/O0eg==
X-Received: by 2002:a17:906:ef0c:b0:af9:353d:e69a with SMTP id a640c23a62f3a-afa1e06e444mr39884166b.21.1754936017522;
        Mon, 11 Aug 2025 11:13:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076aecsm2049062966b.9.2025.08.11.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:13:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v4 0/4] netconsole: reuse netpoll_parse_ip_addr in
 configfs helpers
Date: Mon, 11 Aug 2025 11:13:24 -0700
Message-Id: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUymmgC/3XNSwrCMBSF4a2EO26kuUn6GrkPEUnaGw1IIkkpl
 dK9ix1ViuPD958FMiVPGTq2QKLJZx8DdEwVDPqHCXfifoCOAZaoy1o0PNDYx5Djk26JHO+Fq1G
 r3lktoGDwSuT8vAUvEGjkgeYRrgWDh89jTO/taRLb/i86CV7ypiKHWtra1OY8kPUmnGK6b60Jd
 x7FwSMvuVXoRCOlrvTRy72XBy+//5Zai4qUadsfv67rByZEaEQ3AQAA
X-Change-ID: 20250718-netconsole_ref-c1f7254cfb51
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=leitao@debian.org;
 h=from:subject:message-id; bh=HGXtRp+Nh1wheFCOXlrXqfEXKazzUVmIXY8bJFRZTeo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBomjLPHzwJXabqreIiacn9QH/kZmTfM6+1/kUNw
 /oEXONb/siJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaJoyzwAKCRA1o5Of/Hh3
 bXawD/9l1nGR5iNLHvDJ6btjc+n9qlTRGq5Rc9GwIJ0U62wiWN+4SQqFPBjvs5scMCugEwAGDu+
 g6tNAaE5HnhSE8a/kGh7Cj7R6P59cE3dXE8pYDcpSk3VR9/bIgusWk46kICfA32qW7oRxijxHtd
 yRx7Cd6kjeswOAIgRiJT36hW0A/noaQmLX7VlqewDvNgIxRwRP6TRipmbOSJ9MWycjFjheN/eUx
 woKA8rGmKp8IkWCUpbrmT72pOaDkorF6+4f2S9wz22lIYsrL3RmO2lyZScz5h3VdLHxLpMzlFnx
 9ybt3hiiszOA3E+6+rWuaZLv/rF0Wgm4sT8gEXo7Zt7/b+twVwfbrVMpIEF2TWVHN+L8ZxfJxZu
 xoybKZHEc9mAG17Y1EmtWtD3K9Px4JptovAu75cF49zLdaDabLsMCRWI3ZrQlDk67GAE+jQAowA
 +FTtzp5KOeetKcJG5/g1Qaz6T/7GcHrjpYnFwZGl5Hb0Q/IQw4QuKV9KWr312iPFYB0gGuLg978
 zereRqh+xMd4U8tdlHf3W345v8etuceM1IikcPA3WyUEZLu68vPwFpj7ojdRSj796/UItViudz8
 X8iDwaNXnm7gcOm6Oniu+axtW4X72lla3Y+uxt8B5tulfThNbkKLs3E8bEP4GwATsyJNg7Yvipc
 cZejs4m4wIJuc9w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset refactors the IP address parsing logic in the netconsole
driver to eliminate code duplication and improve maintainability. The
changes centralize IPv4 and IPv6 address parsing into a single function
(netpoll_parse_ip_addr). For that, it needs to teach
netpoll_parse_ip_addr() to handle strings with newlines, which is the
type of string coming from configfs.

Background

The netconsole driver currently has duplicate IP address parsing logic
in both local_ip_store() and remote_ip_store() functions. This
duplication increases the risk of inconsistencies and makes the code
harder to maintain.

Benefits

* Reduced code duplication: ~40 lines of duplicate parsing logic eliminated
 * Improved robustness: Centralized parsing reduces the chance of inconsistencies
 * Easier to maintain: Code follow more the netdev way

---
Changes in v4:
- Check the `end` string returned by netpoll_parse_ip_addr(), and fail
  if it is different than 0 and \n. (Jakub)
  * Also removed Simon reviewed-by given I changed the code slightly.
- Link to v3: https://lore.kernel.org/r/20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org

Changes in v3:
- Avoid #ifdef and use if (IS_ENABLED()) instead (Simon)
- Assing an int to a boolean using !! (Simon)
- Link to v2: https://lore.kernel.org/r/20250721-netconsole_ref-v2-0-b42f1833565a@debian.org

Changes in v2:
- Moved the netpoll_parse_ip_addr() to outside the dynamic block (Jakub)
- Link to v1: https://lore.kernel.org/r/20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org

---
Breno Leitao (4):
      netconsole: move netpoll_parse_ip_addr() earlier for reuse
      netconsole: add support for strings with new line in netpoll_parse_ip_addr
      netconsole: use netpoll_parse_ip_addr in local_ip_store
      netconsole: use netpoll_parse_ip_addr in local_ip_store

 drivers/net/netconsole.c | 91 ++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 54 deletions(-)
---
base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
change-id: 20250718-netconsole_ref-c1f7254cfb51

Best regards,
--  
Breno Leitao <leitao@debian.org>


