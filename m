Return-Path: <netdev+bounces-88053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD048A57AA
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44934B23700
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A8A80C14;
	Mon, 15 Apr 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NjTu9WG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C87F7D3
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198344; cv=none; b=lu7l9rsfeFrX/NE45dUbqW+4tZknlwJK7udiOoc9z33K1tHwrqrByc9U7rpepis4t9P5//kuHu2RoVHXD6q6hb220NKKaZLfYwP2C1M1+fqJaf0Itd0N7JJ2JELYF2W1dAtWllftBNUOfL/ElUf1FZqgc4iiwHDc9J3T/RCsMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198344; c=relaxed/simple;
	bh=j2PzpeP++wEtCimj6PizZGaulOFqRwTLU39GbwROnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPBxog9Lg1sirrrHl287qQickn95kCh7eXS5FrnbS6ok+zrb3Y1CXl2yXVZw/dcLIvcgZw85uL08qw8M4jrBF6cLBbRiCYo1jS3Syv2cy+XnvIYDLvgr9FTNaUjwmNwDsVCunNimP5BU4+ylvZgZEuuDRCc6EC+ttst2AAlWj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NjTu9WG+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso3569708a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198342; x=1713803142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX/Tsfwpe953mO8yyC/qEHw3fIQWpZrg0eDPY2EH2gg=;
        b=NjTu9WG+Z+nHN6++zW0ynpQa+Zlz6QDaXTNQ16//Xa7nBSgsGPAqT9bAHS8CyFu4Mm
         Nq5sOGKSgMf7Fu6f4sbUw7JSr3qMyepwuTR8m0t/LpM0342hZsovyTF7JQYhP4uQ7eut
         XAHz+8Xt5lgiFQlvruYY2KfYPfOxqybbV/s2XNHSxgE7bWpVj+FMCnUap/QiBh9Eo5MZ
         W2ajLKa6A9jsXhw+0t5qGiS0ELadnCfjcx7Nhf2xn0Y8+BJ0rJiqLnJR2ZG6hffGpGpL
         Oim6zmM/0BK94VPmPt75wPiKrKgmDW53fXGB5Q4DBkY6ZMs37yjl/w6/zhH+nS4eH94D
         KKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198342; x=1713803142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX/Tsfwpe953mO8yyC/qEHw3fIQWpZrg0eDPY2EH2gg=;
        b=JFr+jdtgfcRNIVnzAbSsLBzkUOB8A7Hos/igSc72Zl8DLT8B0nXZCd7LMxJRpKnYME
         Lt5PozAjBay5Sr/ql5zrA/UHmaGiYYnn3yaK5+hf9es3+1QI8P6C4z0R5CoioQ7G6uEt
         6U6/sPP4RHNHLkf19FoiByEsHA8U3G8/ZSUlJj536KGccFxgKBfX+0e0rze+Ru2on+ZI
         JZRRQ8ptU/3PvT2yrCxRVoX6oVPa4agV5mlzz/Tj5kkhcAmFxUiiChbBZSEeJNAbeWBR
         CFm56BROoSsAHbQARyHbJEyfltc0inYgDshBBCqrc3L3CSWOx4GK2hyCfq5xW6BDOBOh
         paHA==
X-Gm-Message-State: AOJu0Yw+fPqjrdlEBHd8TTrV3IRzjI5/crvaocu9UajtTEiXLOEBNZ6l
	ui0eEnCv+F/pKKGUUS9KjeCXPLHzNkRBNcxkKVlXjvjTkYJ54URhOvRGYIvwpgA49q3wAl+tNDg
	3
X-Google-Smtp-Source: AGHT+IE3qEYePTUANR+0lWo36Ejjsqj0/fD1LifZooLG26Irc7ZuYxn+NRnblHf3EFxVGbz2a6489Q==
X-Received: by 2002:a50:9506:0:b0:56e:77a8:93d6 with SMTP id u6-20020a509506000000b0056e77a893d6mr6698185eda.3.1713198341676;
        Mon, 15 Apr 2024 09:25:41 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id ck16-20020a0564021c1000b0056ff510c327sm4381535edb.94.2024.04.15.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:41 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next v2 2/6] selftests: forwarding: move couple of initial check to the beginning
Date: Mon, 15 Apr 2024 18:25:26 +0200
Message-ID: <20240415162530.3594670-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415162530.3594670-1-jiri@resnulli.us>
References: <20240415162530.3594670-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

These two check can be done at he very beginning of the script.
As the follow up patch needs to add early code that needs to be executed
after the checks, move them.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 4103ed7afcde..6f6a0f13465f 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -84,6 +84,16 @@ declare -A NETIFS=(
 # e.g. a low-power board.
 : "${KSFT_MACHINE_SLOW:=no}"
 
+if [[ "$(id -u)" -ne 0 ]]; then
+	echo "SKIP: need root privileges"
+	exit $ksft_skip
+fi
+
+if [[ ! -v NUM_NETIFS ]]; then
+	echo "SKIP: importer does not define \"NUM_NETIFS\""
+	exit $ksft_skip
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
@@ -259,11 +269,6 @@ check_port_mab_support()
 	fi
 }
 
-if [[ "$(id -u)" -ne 0 ]]; then
-	echo "SKIP: need root privileges"
-	exit $ksft_skip
-fi
-
 if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
 fi
@@ -291,11 +296,6 @@ if [[ "$REQUIRE_MTOOLS" = "yes" ]]; then
 	require_command mreceive
 fi
 
-if [[ ! -v NUM_NETIFS ]]; then
-	echo "SKIP: importer does not define \"NUM_NETIFS\""
-	exit $ksft_skip
-fi
-
 ##############################################################################
 # Command line options handling
 
-- 
2.44.0


