Return-Path: <netdev+bounces-88805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFEB8A8947
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686ED284A59
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A8171644;
	Wed, 17 Apr 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="k1ujupkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62317107F
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372364; cv=none; b=CVdYRh0sRHgHNr04zy3AxENzgYXu/Ye6ffeN5vMmCYkVQcOqIR1KglQX45K6FZfOaFcimmrv7rxiBJheUzx9vqQdXtb4hg/iX5WyQWAjNFNMRtKHBhiCVWF1D68ren55BQrR1vXKfDxY2SrHOrGaG2IL7GecHZcuMtoiObQ3nrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372364; c=relaxed/simple;
	bh=PcbDhpd6BnODpMOwqMAwtZG4dOefUKnbanAitXMinJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqYNB5l/vd2Z8qW8cmYjV/SZPzZ9VEmi2lp3BfciysCOr+rPWpnV//4G4WAzjQe/6IOjmeT8JUM8JfOV7WxStCopDZ/WoLmR/6bj57jxRwUHGNjwobgAWY1xmFVut2d8bJKcUVPKUK+hqufGd5r3Znxwwph2PHM88T6led30yI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=k1ujupkC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso6453237a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372360; x=1713977160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxLxMgGy2MXM/swv+tfB8dexSsgyjH3G44Q6iWAtDNs=;
        b=k1ujupkCMYETr1+fzf4jbX0mz22faOD376f+2jAN3VLyUlJ/zv+u2JKXCztradFeyl
         jZYCAULq7LTrdqVNn2nrHjDaSxC/wSZZ0C2UJjJStL6owVIQleUl1Znq3gHdNCr9noFk
         sPyXvAGaaeO5LbrjldjBt2309LIWO7692P0+Mv6n1vu0c+99SxGHelt1jx8BahkG21Xh
         s+uEo5wEnGFlfEwtd71aXODfggmIq3baJbQuKwj9DP1h2N0Hfx1Sdhf7zB6kYkFvAvmc
         anujt1ibDMTFc5ULaK3eP9+BdMIVYaMmf4Xi3YtjpsLri2GuSdCr1bOaYiMY5MuMRd+8
         zqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372360; x=1713977160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxLxMgGy2MXM/swv+tfB8dexSsgyjH3G44Q6iWAtDNs=;
        b=YhXuwj0NulnXcjB82YeXtFU7lNHWFRUcbz6nA1AUowqFsg5AHfUah3vV7/9QLZ9Ivt
         0A2wNqO5JaBg5HirTVLaAb81boCEiIDfwFXr4hZkuFs5+/b7HkTKHTyuT+BvJlscR3FA
         Mn5WIWyFUafhNeHUp/Ew2yfb/5krPpw5oxet6HdWlyW7sxSyWrDFIPDatVIB5x/iZ1Xm
         grCto9sdE8Mu8Ind+CghdCVqGLKY7KKWtrklvtoe616cCOlE7Ev5xZwk1d21NsiW6h84
         kR60CeX3MpBAoFCwBtlzxyHqByNLmyAGrverUnMAJNdBmg6pij7ztUjj7QKNC0DuL281
         aDQQ==
X-Gm-Message-State: AOJu0YxSJvLYdNbVYm0wZ6YuHhYjUejGqx0Tot1GkMf5Eoa20mcZTXDF
	/a6bsq9gvZ7fE0mKh1naux3umQLuyEbc0Cb3llkW45U7I5UBS13CLrYh2vQ7KTEY+HxmWLVMs0G
	F
X-Google-Smtp-Source: AGHT+IFkVraWXUhT1L9urSkAmtQ2ZYqLl6CkHWvRgjNYeqKxUh5RvxFXQWBk/gVZZhnmdXBrETcE0Q==
X-Received: by 2002:a50:9f43:0:b0:570:5215:d29c with SMTP id b61-20020a509f43000000b005705215d29cmr112439edf.4.1713372359844;
        Wed, 17 Apr 2024 09:45:59 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id t6-20020a056402020600b0057030326144sm3381448edv.47.2024.04.17.09.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:45:59 -0700 (PDT)
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
Subject: [patch net-next v3 2/6] selftests: forwarding: move couple of initial check to the beginning
Date: Wed, 17 Apr 2024 18:45:50 +0200
Message-ID: <20240417164554.3651321-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417164554.3651321-1-jiri@resnulli.us>
References: <20240417164554.3651321-1-jiri@resnulli.us>
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
 tools/testing/selftests/net/forwarding/lib.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7913c6ee418d..2e7695b94b6b 100644
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
@@ -241,11 +251,6 @@ check_port_mab_support()
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
-- 
2.44.0


