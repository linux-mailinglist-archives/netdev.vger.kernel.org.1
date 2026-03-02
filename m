Return-Path: <netdev+bounces-262495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFQDEg4ipWnd3wUAu9opvQ
	(envelope-from <netdev+bounces-262495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:37:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C0F1D323F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46071302713D
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB031A805;
	Mon,  2 Mar 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KQKQzg2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83E31716D
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429682; cv=none; b=NUiq0afxn0/OIZf1KZYhmOSY1ouUyN5bctVKPhdkhki8yguFagrekk6eFS4R2RQiRVSlfNJpgb+zLKx2SNGm4TDVL7jIEPVORVz0Qfj5o7hr1wDy0efzXktn//Jiqib8HkWjGVFrNSQK1S+lk9VueOGwGdl598UmtCcYt/nquUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429682; c=relaxed/simple;
	bh=5kX91SrIp+/GdeIAq30lJmjZ6iDm8nEENKGV/DyKyYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEMY65Fo3VgkH2ALdN1D17Xfy0c4IN7lny8N1ykQ9prOKkHs1yXRR9GD898Sm/EpuXIVBCszhre3efHGX0+xUv8HbV84riTrtWDFqRFx7IZ8X5wJXZ3suAAs9nYN3BrfCdWIY28fyKTyzuVr6Fc3CoMMZ+6WXN64mmpEhkVVe5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KQKQzg2C; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f194e9a98so1503214b6e.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 21:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772429680; x=1773034480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJpZxuSj3LFUq3ynSftffer5w+sFwaHE1PwZL1GNYQQ=;
        b=KQKQzg2ChqNwVyyeOV/ziPVK6txqvyBQCKbyvN+IRRoC5KdE9gQCZwKWu1iQEz9l/S
         j0as8Z2srJ/5fCQXaSm5qMVimqJXGopAEI1YUqiEx65E6+bhPhlA/CF4iPrIFgtJPpAv
         PWljifrJMHUVzra1Gfvqc5rnFOEaYirxI61yuCn0ILfKWval80X5CTRuwlM3YCdXspr8
         Tas44H3RpEIdKnA2Ln4LZbEjobbm5YEpJWf19axpWH8R6E/2EDIYpnNQ1qlAA5n5sXSK
         dDisZCjZXe8RoZK8RA/bV2yVkVmb1Vch7jgyRRRm/5I7P+1wnMXHmiio7YwqvjeZ2TTo
         LaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429680; x=1773034480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nJpZxuSj3LFUq3ynSftffer5w+sFwaHE1PwZL1GNYQQ=;
        b=U4Lt4mefdpxvG3Sy1QPoQU2PKw9sNSMIvJ/aK0cmFaVf9RQ+Xwa2Tc4QHD5AHXKfuQ
         HQQrb9IuW7BZd96USrB850qNvn+FsPDQRrkN2PSRz4HUTsZohjTtbdMcOF/8QM+7ZDQm
         IcOK6MpS7xBFDIgdq85AJB9Zdc1wU2fzF1vsQvwbSAZr/gFlD8rrnm8TXQ8VWRDce6M1
         9fNlHVQKGFSZYQJmowncxqzU1bZ42QzLTZNLkP5WdzTEzfKU702dkX8uMFailfmnXQuV
         ZRtG4CFUlfwaB/gysQP0EREhcxUhjHKKvbfI7Rh58WHZvuM37mrGf0mN2RKLHGLiNzqg
         hnKQ==
X-Gm-Message-State: AOJu0YxvwjT6i9QzfU4roh80hn6R/wpR/S8DHFiDpNWaga7o9Fy2Me3t
	MVD/rVIPfT5Ct3d4Drik+rdXd5BXLAzXGLPfDYNZGZdawfRzDMp85jG3ywijmxK1PBVycNg1Dmq
	CmxEs
X-Gm-Gg: ATEYQzzoh3mVQGGwg+RPsC6hqdC0ionvUrhV0IaEWHk7w0ML5phyG8TFZEKCxF5d306
	bze1c3edNo3IBodxGCX0PDweAFUsKV2/2CU37vJPFnyfsRG69Qx9eHyM0zNp7sYG9b6rm+CiW7+
	EMuuxwHRF2tV9SQ/gF5wTcmDzf2HFqNzO+q8jWg2BZRWjm4myN1s3OVgaUIY6/T04eTigja5Brr
	Vz0E3SiD//T5a384R79VZZpE0yCaz3Aa5htO9+hX2Mb0tNAHYvz/L/tGHVx4Zbs6gboxj24Hbh4
	/cYfWKnudFQJBrRdGlUZDsMvEGY7pGtRIG6z57rrsWNUgBwLcQ8Wr5F36sYGUwrJzBmF4yx9zgk
	a31jcxKqXyvFvs5gQGFpxJe6zkA3eNVSD3WI023xyNI2gUowS6ev6mcjV+0FcyuqUnJVVOVjrsy
	ydGEGhfVcuLvp9G6LwbIHV6UacRNJJwdyhRO1lf6CwWg==
X-Received: by 2002:a05:6808:23c3:b0:45e:f09f:6359 with SMTP id 5614622812f47-464becebcc7mr6699835b6e.53.1772429680209;
        Sun, 01 Mar 2026 21:34:40 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41640b99b39sm6313103fac.10.2026.03.01.21.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:34:39 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Wei Wang <weibunny@meta.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v2 2/4] selftests/net: Export Netlink class via lib.py
Date: Sun,  1 Mar 2026 21:33:13 -0800
Message-ID: <20260302053315.1919859-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302053315.1919859-1-dw@davidwei.uk>
References: <20260302053315.1919859-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262495-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei-uk.20230601.gappssmtp.com:dkim,davidwei.uk:mid,davidwei.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: 97C0F1D323F
X-Rspamd-Action: no action

Making rtnl newlink calls requires constants defined in Netlink class in
pyynl. Export it.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/lib/py/__init__.py | 4 ++--
 tools/testing/selftests/net/lib/py/__init__.py         | 4 ++--
 tools/testing/selftests/net/lib/py/ynl.py              | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 5872d114f142..e5ef5e949c12 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -19,7 +19,7 @@ try:
     # Import one by one to avoid pylint false positives
     from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
-        NlError, RtnlFamily, DevlinkFamily, PSPFamily
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wait_file
@@ -31,7 +31,7 @@ try:
 
     __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
-               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "Netlink",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index a584e7f806a4..54e84282781c 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -16,7 +16,7 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
     wait_file, tool
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
-from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
+from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
 
 __all__ = ["KSRC",
            "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
@@ -31,4 +31,4 @@ __all__ = ["KSRC",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
-           "RtnlAddrFamily"]
+           "RtnlAddrFamily", "Netlink"]
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 32c223e93b2c..a52b067f7589 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -13,14 +13,14 @@ try:
         SPEC_PATH = KSFT_DIR / "net/lib/specs"
 
         sys.path.append(tools_full_path.as_posix())
-        from net.lib.ynl.pyynl.lib import YnlFamily, NlError
+        from net.lib.ynl.pyynl.lib import YnlFamily, NlError, Netlink
     else:
         # Running in tree
         tools_full_path = KSRC / "tools"
         SPEC_PATH = KSRC / "Documentation/netlink/specs"
 
         sys.path.append(tools_full_path.as_posix())
-        from net.ynl.pyynl.lib import YnlFamily, NlError
+        from net.ynl.pyynl.lib import YnlFamily, NlError, Netlink
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `ynl` library from kernel sources")
     ksft_pr(str(e))
-- 
2.47.3


