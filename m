Return-Path: <netdev+bounces-63433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF1382CDD6
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 18:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BCAB22558
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32034C7D;
	Sat, 13 Jan 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCF85/IM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3EE5221
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 17:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F4AC433F1;
	Sat, 13 Jan 2024 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705165870;
	bh=ot2YVVEqK8HFfiOpxBgx2WaTCe/MDy52aGOPEwMCNAY=;
	h=From:Date:Subject:To:Cc:From;
	b=PCF85/IM5BPXJTabvgJkef/COvwCI7y+nzR6PwvnnwOLjiuOBmIs1VspFDN8kirRC
	 B+w/8wbh33y/CkQuK6DumMhX9a/a+IEFcCMCRZRiyAkKNRi0To2qIZPb1TY5eYuKUD
	 Gdoa0HPmuHw4nK9bKeYKPbIU1m2d1WEMVVhvFxnUxC8YM+tmm5IOKewcwYe9SIr7Z5
	 HL3+P4zoyV1bwjpeYmeQXYmx+SwHYlU6lf7Ff+M+U0K4w0g5L+4KzFvUZWtyyQo//J
	 ck4ykCM7W7vBGP7/JB3T4a2oz7l+cYQx5i6URwi78xqsbSfi0qTV4UVAAzgj7OUn4u
	 Dy6xz+EdrkfIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 13 Jan 2024 18:10:21 +0100
Subject: [PATCH iproute2] ss: show extra info when '--processes' is not
 used
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240113-ss-fix-ext-col-disabled-v1-1-cf99a7381dec@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPzDomUC/x2MwQqDMBAFf0X27IJJbG39Fekhmme7IEayKoL47
 w0eB2bmJEUSKLXFSQm7qMQ5gykLGn5+/oIlZCZb2boyxrEqj3IwjpWHOHEQ9f2EwG6sX2/3bPw
 DDeV6Scjefe5IlhS3FZY+1/UHb45FeXMAAAA=
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Quentin Deslandes <qde@naccy.de>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ot2YVVEqK8HFfiOpxBgx2WaTCe/MDy52aGOPEwMCNAY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlosQsi3X4tj0JQcDgiK7S2fi+I0czeAJdLw5HP
 iBM5K1dX0GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZaLELAAKCRD2t4JPQmmg
 c1YuEADfx9LBvnJ8Dbkg23/ggEVIwfIhn1+LWSRHDgyBC6CLxJ2Y/3SzfgAh/5RgT7uzIilD2QB
 F9Pb8RlIWoBjn06LEJX8wSaqtZkoJ6+WK7lo6bS8uAkUYQtHzDe3nN8i/1RScdUifBJViN7QF00
 ofIs9dONWmdi7QQsjom5f1MfZ3pFY6RJtYMssjNLQL8FX/0dju9zLAH4QbbkJ9ePfitc7kJpdlU
 sQ9zikhbfoLmfYtuHUOZ+EZKInR6BW8EVPhvmYKzqc/89v0/I9vF7y7JECU/UmH7VaGPcSY0Mkk
 aXuorV6WUyC+MrhdbWGltin+RV3qvHEicwrdMSa0M8V29Q5yn05ivZ4nApraLURV1ZE/IcBLLHl
 eIl/baNNApraq0UeARCeVDLGsIYdmaOnwsDJ0E2neT6zJ77Jxylyn5mYoH2Pci9LcH+qP3pPV0E
 JtDVEASaE26zeDuroNe5LWv8aI/sygyiuFET6tK4eBc0Z1+qwWDqVG3FIq8hJcURK8Xicn9z6B9
 cUvg5ur6TR5zROLx5T8ItKoe56Y1f8KK/RZQ0YUtXghrlEsVjP2fNwQ6XuVLPc/rpOZsVKGwlP1
 vNkxO/LkKDFwzyWgr+3TjAlYgtqlwzoaHu53unWEomvtm7P/zuWA26UntBwCNJP67K+ow2BD/Dq
 UrLce/bp8srzC4Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A recent modification broke "extra" options for all protocols showing
info about the processes when '-p' / '--processes' option was not used
as well. In other words, all the additional bits displayed at the end or
at the next line were no longer printed if the user didn't ask to show
info about processes as well.

The reason is that, the "current_field" pointer never switched to the
"Ext" column. If the user didn't ask to display the processes, nothing
happened when trying to print extra bits using the "out()" function,
because the current field was still pointing to the "Process" one, now
marked as disabled.

Before the commit mentioned below, it was not an issue not to switch to
the "Ext" or "Process" columns because they were never marked as
"disabled".

Here is a quick list of options that were no longer displayed if '-p' /
'--processes' was not set:

- AF_INET(6):
  -o, --options
  -e, --extended
  --tos
  --cgroup
  --inet-sockopt
  -m, --memory
  -i, --info

- AF_PACKET:
  -e, --extended

- AF_XDP:
  -e, --extended

- AF_UNIX:
  -m, --memory
  -e, --extended

- TIPC:
  --tipcinfo

That was just by quickly reading the code, I probably missed some. But
this shows that the impact can be quite important for all scripts using
'ss' to monitor connections or to report info.

Fixes: 1607bf53 ("ss: prevent "Process" column from being printed unless requested")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---

Notes:
    Note that this issue has quite an annoying impact on our side with
    the MPTCP subsystem: because '-p' is not used with 'ss', this commit
    broke 2 selftests (13 subtests). Also, 'ss' is used in case of
    errors to help better understanding issues, and it is not so useful
    if it is missing the most important bits: MPTCP info.

    I know that typically there is no bug-fix version with IPRoute2, but
    could you please consider one in this case? That would avoid
    troubles for those relying on 'ss' for the monitoring or the
    reporting when this specific version of IPRoute2 is used.

    In our case, it means we have to patch our selftests in 20+ places
    to support this "broken" version. Plus making sure this is
    backported correctly, resolving conflicts if needed, etc. It would
    be really nice if we could avoid that by making a v6.7.1 version
    including this fix :)
---
 misc/ss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index 900fefa4..5296cabe 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -2427,6 +2427,8 @@ static void proc_ctx_print(struct sockstat *s)
 			free(buf);
 		}
 	}
+
+	field_next();
 }
 
 static void inet_stats_print(struct sockstat *s, bool v6only)

---
base-commit: 05a4fc72587fed4ad5a0a93c59394b3e39f30381
change-id: 20240113-ss-fix-ext-col-disabled-3f489367a5e7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


