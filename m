Return-Path: <netdev+bounces-189281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FD0AB175A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DEE7A71F0
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9C021322B;
	Fri,  9 May 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dHgz2b5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341221B9C6
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800867; cv=none; b=fdurjCIeXWwl2XQLZ8FDdm4BwVbMDKFYZOrQLls5kNdaYOm6q0Xe3UnyLLd7+F3ss7dXgIuvCHEYFDdd5NbHMIciFBkuEuziL7MlB9LzsF0oUrCLGHZ6MSnsX9JeYIB8cerQJWjf8d6IcEwBaIDMTpx6GOnfnBGIPkcWHRTx3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800867; c=relaxed/simple;
	bh=h5db0Famyw8YcfpNOlBx0eBv7a2sPKUnQjbHaHyaiCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT2zqE9qlpxXAu+GTcwjDj/NwqPDZvhO7frSVcYQZ0YfVm+DafB1sM5Jx4lWc2BJpqgk6KS2XiiKmHEoaqIilmaaSeV+mwxXKYE0qPMrMaj5of8hcX0r1EtkNZ8okdhFubDfltnD1mNy+9+/6McZ6K+lIG/kTNTJ0l63Fbh9s6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dHgz2b5Z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso20358095e9.1
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800863; x=1747405663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWLLk7nzwtcDClSj9bcQjVWwN/PTaF2BsnVLOFiwUQg=;
        b=dHgz2b5Z04kMDUY5dcIjTp8sIQ8K+UNuiGxxbhXQHNtn/AKmJnTOzBnohgfWQjM9DR
         TfjGNjaFh5yfPdlpbIluox+Z5/Oo8gPU9MjTzFhgiOeLXq0pf6Vb1WbNZ1rrvcstLBh3
         tynO7dUdIbUpl2ryCCA3Wjb/sSg0D/ry3vgHFDH7ZvSiI20B4AiZnIiIV/Qzr6dGV4oy
         S9Hyp4vjUJUohqH4w9E9Olu/pq7exWwRzwH4Qg7KNvP5n16906rXzQOci6r8LzYsqlLg
         9Z+DIhWvHjaPuGvZkexSlW4aAy6aF+dGkB0JfisDEVa/yJ8bwP6Jixlg8GbV7f/TWi8Y
         U1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800863; x=1747405663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWLLk7nzwtcDClSj9bcQjVWwN/PTaF2BsnVLOFiwUQg=;
        b=knk7/ZwtGVIkH73Jkhhem0kh9YBv6CTNZ9DgQ8frsCHbbncoff2O7p4ta26pdzY1v/
         alBKMbCjmF/Gb4PeoHA1NSis0vocL5j1STtFBwvKIp4VIvfR/z6nHDyeHjl+15NscSCn
         6Llw7syit1IHOuWMkZfdNWbfX4SOIZCi5KNDL03Bt3w3+2ZISxg5vCUWmluCtq9YediD
         SahNOHZ37ciWL/Iet9symncgvPqla50moL2qfJwnjCK0tB/oPLhfScJ2utL+tXnIqLFo
         j3pMH5ZCVCjwA3kZomcXCuscvv9tBcNlOv1jF2hn5cS2CFGOeQGCpqkjKAjhn2N5UJfH
         vV3w==
X-Gm-Message-State: AOJu0Yzz4NnSmbI168PkVHTguRTFnWWEGOeXIOhaosZIZPqcG95S3J5K
	6doqZPygtv9ztuWNd7k1nZ85O2Tousdd1+UkCemKCetjxhrtGyyk2RFtl9z/0DgMiQuO6MQlIMb
	eHfzoE1gs3QTHoeOv4xe9sW1FHJ99SOtN+iRXT54iWH7QSsy5qpIHrftL9PAb
X-Gm-Gg: ASbGncuRiIUR8LcS5GqalfxIzjj47WMWVfgoLDhs0w653oujcrqgOAYkeLVzusparwH
	yt3hQNDGcTVWjGoRfRgIRRDAs5FhDPWnehb9NKFbnZ04hz51UJdju9DlDr1oSFDfulOz+KnjLgL
	Lr7sncssulNEXvX8psyqCYcKOC3QBrsrAv/SGCezWzolvbaARDXRACm8OXbMvEYd3ugvyd4yuIr
	oaGjRoxSRWkfcoLHXXWtuW3AJH+MgLJGfe9NsuO9HulHdow3S/ODXJ6Df+5//F9mj/vM1vmuFYw
	AjUSxneslTP6A0aXSq4zlnRE5s8/g7iPxehjG5UFAxyIsDG0dKXGEzX+8MlloPZj9dS6lqwRRg=
	=
X-Google-Smtp-Source: AGHT+IH16xHkcKF0LxfOBJYiN/L/dgcGbXu0njcFdlK7pU8VRBB/qvhZKk4BPs+ctchqmLqLLWYqhw==
X-Received: by 2002:a05:600c:3b84:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-442d6d44b30mr33196005e9.14.1746800863066;
        Fri, 09 May 2025 07:27:43 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:41 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 05/10] selftest/net/ovpn: fix crash in case of getaddrinfo() failure
Date: Fri,  9 May 2025 16:26:15 +0200
Message-ID: <20250509142630.6947-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

getaddrinfo() may fail with error code different from EAI_FAIL
or EAI_NONAME, however in this case we still try to free the
results object, thus leading to a crash.

Fix this by bailing out on any possible error.

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 69e41fc07fbc..c6372a1b4728 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1753,8 +1753,11 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
 
 	if (host) {
 		ret = getaddrinfo(host, service, &hints, &result);
-		if (ret == EAI_NONAME || ret == EAI_FAIL)
+		if (ret) {
+			fprintf(stderr, "getaddrinfo on remote error: %s\n",
+				gai_strerror(ret));
 			return -1;
+		}
 
 		if (!(result->ai_family == AF_INET &&
 		      result->ai_addrlen == sizeof(struct sockaddr_in)) &&
@@ -1769,8 +1772,11 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
 
 	if (vpnip) {
 		ret = getaddrinfo(vpnip, NULL, &hints, &result);
-		if (ret == EAI_NONAME || ret == EAI_FAIL)
+		if (ret) {
+			fprintf(stderr, "getaddrinfo on vpnip error: %s\n",
+				gai_strerror(ret));
 			return -1;
+		}
 
 		if (!(result->ai_family == AF_INET &&
 		      result->ai_addrlen == sizeof(struct sockaddr_in)) &&
-- 
2.49.0


