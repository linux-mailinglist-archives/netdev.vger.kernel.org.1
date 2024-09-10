Return-Path: <netdev+bounces-127164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D380B974715
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F1A1C25ACD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9853FC7;
	Wed, 11 Sep 2024 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzWA2h4/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8FAB663
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726012921; cv=none; b=F3OgsJxJCXe8SGe9V4Kt/+uQEildgvsrGbVMK22YkiemLU2oGxaEAdfzTQIe75T9JycFAaL3hfAhrGga/FZbiRsas9h5UPc8GUdv9JzdmqoUFv/VZyZi2kopv7sRlZgJA6wNEOjDmb5Z7EGNVaYhor6do6GLffusJUfZpPHkOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726012921; c=relaxed/simple;
	bh=eOds8UVLh5ZbSfragv4UJ7U0Mco9tVdAJzfi5VX5hvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRv5+1H+S6WGiJQzCP0piXTzvtFdk3UEggmrx62y9dlPl1tIP8xq3JxT9BblIQGS8f3tfXzFIdolV4Scp886PJGaKYa0ryXnMs11jqZQZ7et2dz++JRIVP3Q6y+42ZJSIV/DQ1hMpvaw/es1WX+MUCU8oDj+OwLrI4jDx63s58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzWA2h4/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99fde9f1dso107393985a.2
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726012919; x=1726617719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHgrFnUEtml9QXetV74St3UODTFcAqUgPlwqbTQUgmA=;
        b=SzWA2h4/7ya9/CdmwVg5iYHv2EhvSJ1hRNYGjgeXGkgDxVlXmV4wkLOrecLQowEDnf
         EVd/obzAzyYmSn4qbxIfEEdg1UOwELDbgv4z8myKeKojhUqQb7jQm6XV5hQlda8mictN
         6xg0U0Xq+T7A5sFPFTITyPSt6JS6r3aEHIfjLSpQpRbNCObdnPVtjV2rRA59awv21cJS
         I39kBfPsdUwdLPuhK0o5Ucq+xTS5bZFn0k+drEjBt8n1NkxiGHDjBzME2BK5ihHqKbAP
         Bpy2lkW95vplL4navxWBZyiBVFp45/oejdEBFiNebka78x/FS2dxPHOPX4LXemqjDK/z
         MGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726012919; x=1726617719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHgrFnUEtml9QXetV74St3UODTFcAqUgPlwqbTQUgmA=;
        b=mU1yHRc58kEsdztVkgoUBgw2XvKuMU+hmJX3KY7EOvC/+9eubeFuBH5kI2wPYQ7/Mw
         2aW4ameHGA66iHHC2atKr92a7hueZIEf6LDjR3MY7rlmeSmt3JJj0po5rMb5Mq83Yzkh
         hrqqb0VvxXEKYSRVzO44i54LRfqEuXNCRL/bByU2HfX2IHw9HNtwlwSIOm0cG7wzt5ie
         P7rY3tg/EoUq9gp8DOVG6Jpljv0OaseaFvfeP6hLzq6ubtgBEbkzxRRYpPc6b1KY3tVe
         4tXabs7RGnxR8K+6Lyp3z4q4tZquCsxvNHj85X+3zp8Y/1/FzsGl/b48VgaRwBIe6itI
         qfdA==
X-Gm-Message-State: AOJu0YzCHH1Sa7ua0w1woAKjy8DXEP9CTrWQ84HHfKfR0pvjPwn3+L7N
	LTCgYjJpXJcOsQtA7EZQ1nV+lztNTKvUb28dpBS//3thgsTALsQrK9PYhA==
X-Google-Smtp-Source: AGHT+IFYNVdgka0fALCMzEFevf3D1y9zIVRTrP6vtNbaInBUa7Wc3S+RHsyAO/3huAB4mK+oaN0+3Q==
X-Received: by 2002:a05:620a:4592:b0:7a1:e214:34df with SMTP id af79cd13be357-7a9d3daf266mr172225285a.65.1726012918929;
        Tue, 10 Sep 2024 17:01:58 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1d652sm354705785a.123.2024.09.10.17.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 17:01:58 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	matttbe@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/3] selftests/net: packetdrill: run in netns and expand config
Date: Tue, 10 Sep 2024 19:59:57 -0400
Message-ID: <20240911000154.929317-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
References: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Run packetdrill tests inside netns.
They may change system settings, such as sysctl.

Also expand config with a few more needed CONFIGs.

Link: https://lore.kernel.org/netdev/20240910152640.429920be@kernel.org/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/packetdrill/config         | 5 +++++
 tools/testing/selftests/net/packetdrill/ksft_runner.sh | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/config b/tools/testing/selftests/net/packetdrill/config
index 0d402830f18d8..a7877819081f5 100644
--- a/tools/testing/selftests/net/packetdrill/config
+++ b/tools/testing/selftests/net/packetdrill/config
@@ -1,5 +1,10 @@
 CONFIG_IPV6=y
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
+CONFIG_NET_NS=y
 CONFIG_NET_SCH_FIFO=y
 CONFIG_PROC_SYSCTL=y
+CONFIG_SYN_COOKIES=y
+CONFIG_TCP_CONG_CUBIC=y
 CONFIG_TCP_MD5SIG=y
 CONFIG_TUN=y
diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 2f62caccbbbc5..7478c0c0c9aac 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -33,9 +33,9 @@ fi
 ktap_print_header
 ktap_set_plan 2
 
-packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
+unshare -n packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
 	&& ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
-packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
+unshare -n packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
 	&& ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
 
 ktap_finished
-- 
2.46.0.598.g6f2099f65c-goog


