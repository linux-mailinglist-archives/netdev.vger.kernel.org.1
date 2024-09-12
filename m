Return-Path: <netdev+bounces-127884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7EE976F55
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED491C238D0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2721BF7FB;
	Thu, 12 Sep 2024 17:12:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E71BF7E5
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161176; cv=none; b=l5/Nhe/exfbQaeUOxsIr82lryrhcqWOt7JR5fZnM+4LA597DjgoDhrwS9uGwx1BBs9w2Rh0+OutbjL8zgShiCb5lfbTpZ2dCHgr/8e+/2xAjc6lROvPQIBLVcbPEcMPwkpd/gmp9IcbkZNT0qpMTchZtq6TbPQQZq0hUtDljIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161176; c=relaxed/simple;
	bh=1ogZL8GdbW2aFlDOeHVyn14P4e17DWCzWxkTJ5g/vS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEDIuFKeDjnXsDDPbk4KAhfXyNF5idBYCuIy8MjnkjkC0SQ1qeHNIUSWIrwsCpWwvjwzQ6pYVAqFtp6uV/J5V+0neI8094M5GXt8YikjQCmbJB+jCUby9r+pazILPyCKSyDnQ7eeSaKSZkPAZBbl22E47DZdvHS5GRcJT7xe9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8b68bddeaso80060a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161174; x=1726765974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDfolIjQlfBt1OrhxWrwJJpwruVFBq74SW3OsEBWFjs=;
        b=K7v4Gq8dwSu2jbHIDw4UXnDVKdd8M5dStcCorn5JwVVzyqRygMc4GPYhfN7CiJrjDx
         6n2H9YhuYPxBbGeDkvZpjaXW/xQyhizLyp1RCMmZ6LaWCbiXlJSLV23+gV0Vc7da1pUr
         BDK0coZXR38iDtqqEvILI2mNeIw4JDqqfMyPkDaAHXOO1WF5Ozhwfyn3Tnp/v0jitoia
         9lVttKrcn4/actTC0CrTcZBiBrYweNhTkPjJ4p5T8K1gtVP606ZYo0TJ9qkelnkNF48H
         0ltzUN5r9VQuRdRIk9MLHflH2uo6OFz3F7JRw/tTUbjr/NL4DcTabPmkul8zRveOe0YU
         JKHw==
X-Gm-Message-State: AOJu0Ywevp9j7AqjXaPnnYASNPuLtxRKQnRmXCOfBGEDXT/R3meUwbnA
	FZdoc3T1C8IXIRCu63nhDEVI1g7tr43dzTBcqRl6Cm9exAx1odv+n8Uw
X-Google-Smtp-Source: AGHT+IEDYyJbCyhLvorf67CpddF8LJ/r4AFLPItCBdEYasDil5w3rtEUadjLqky2Nxzqmbd+MNjx0w==
X-Received: by 2002:a17:90a:ad92:b0:2d3:bfc3:3ef3 with SMTP id 98e67ed59e1d1-2db9ff958f7mr3872847a91.12.1726161173672;
        Thu, 12 Sep 2024 10:12:53 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db070b14d3sm10716048a91.6.2024.09.12.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:12:53 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 01/13] selftests: ncdevmem: Add a flag for the selftest
Date: Thu, 12 Sep 2024 10:12:39 -0700
Message-ID: <20240912171251.937743-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912171251.937743-1-sdf@fomichev.me>
References: <20240912171251.937743-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And rename it to 'probing'. This is gonna be used in the selftests
to probe devmem functionality.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 64d6805381c5..352dba211fb0 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -523,8 +523,9 @@ void run_devmem_tests(void)
 int main(int argc, char *argv[])
 {
 	int is_server = 0, opt;
+	int probe = 0;
 
-	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:")) != -1) {
+	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:P")) != -1) {
 		switch (opt) {
 		case 'l':
 			is_server = 1;
@@ -550,6 +551,9 @@ int main(int argc, char *argv[])
 		case 'f':
 			ifname = optarg;
 			break;
+		case 'P':
+			probe = 1;
+			break;
 		case '?':
 			printf("unknown option: %c\n", optopt);
 			break;
@@ -561,7 +565,10 @@ int main(int argc, char *argv[])
 	for (; optind < argc; optind++)
 		printf("extra arguments: %s\n", argv[optind]);
 
-	run_devmem_tests();
+	if (probe) {
+		run_devmem_tests();
+		return 0;
+	}
 
 	if (is_server)
 		return do_server();
-- 
2.46.0


