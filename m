Return-Path: <netdev+bounces-190688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88D1AB849B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D934A6DCC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF357298267;
	Thu, 15 May 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BKROs4tj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9712989BA
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307672; cv=none; b=kPXnEQD7+XB4A5dtz8z79eLWl5DPLKGX47o+whO0QkR4JVIJIgBk6QncUFW2N9qrF9spAb3Q4rVl1p0PHrxEGtggruI/PC9BjnL242av/o/qGTkij0JCDOaZ/D+jGlxPC86x04Bo+MWEnSKZT3+mSFG6ZY7bZt/McMBafXvUEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307672; c=relaxed/simple;
	bh=h5db0Famyw8YcfpNOlBx0eBv7a2sPKUnQjbHaHyaiCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6xotCFalUR8H/SjuF/W4MaH1M+M7d9VCQf8opwA+usfl5h89yn/i0BSq8YStHG0dc6uj6NDt4G+IL2l2ehslWKUi6WSLB3ic/YLWj5y/R/9YjmWxxsbl0qEOrCNPKIERKrkK7nQPE7kn3lXGAi9cdkOP+nsswxaBlwVnSbwFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BKROs4tj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so8485035e9.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307668; x=1747912468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWLLk7nzwtcDClSj9bcQjVWwN/PTaF2BsnVLOFiwUQg=;
        b=BKROs4tjRvSJL9pXPKlfY7oKF0ugYnWQbHrctcfA32OKinjpxsCYBgUiON+Sfvk0Og
         pvEFRES6Rzb9xMb+kHxXHKJoZkhX9BJ6bxRxreUYXvfT6BdkoE2UGrTpXpLE/qxEatka
         NlmthmEhDCYBgYNJXhwJK7lxHRXXZK3UF3utBV+1yA52Mb3nlNhYeicvLKR7yyZY3B1N
         9VIjeuFZBO4G3kVZsCsVYUUJCtoqnExVI5Dl6ZFPC9JDzmILoNXo3pfh/FvCSUk1+VLM
         N3wjeXTqMEUvemFFEhk/sLyMfba4ZBvYWmoPppK+yWgfnzhJ13kfymjZmc1Ru6+IX/Ql
         9eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307668; x=1747912468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWLLk7nzwtcDClSj9bcQjVWwN/PTaF2BsnVLOFiwUQg=;
        b=RNfyXwGzd8Bgo2hN3EH5kyxbhzkQWzT+KfimUc/jJva5lpuK6h2LWsvN4YFsoUx8xz
         OfmoXgX8zi67Xios3E4RiIV36gUSgHcHMo43HZ751ny4Aq+c8hzvzG9bOGvUxTnKXjrv
         3MeGk4heiD9v6Qtzt9KO5PWvTifdDYVITm1CPq6r9UfVFZ/To68PT9liNfhgGXg5D+1M
         tOyieblOcRSts3OsUwN09kPH67O+QcaDXcE0pRo6jzDU8y9GT9h9v5owuZUWBlIg/6IP
         QP85O1d0I/wsm8gI/I9gl2PEJ0ZniEEQpkq6A6TyWSgP5P5g87arQN642KfZwj15C6ge
         7f+w==
X-Gm-Message-State: AOJu0YwbdvF3I9pToc1n/4YQADEQ4DdjZbOCrEUZLBIXd8sVgILWNGH7
	iz9VJwB7phCm6KruAnDsFxMjXzTPji9gJkdMutE3c/TVo9o6EnqSZawp8DH3uwZXa18Pz3xFHsU
	jyHa5dwsQdFoU8OivNbZwoMq93pfemhXc35IPIQngjH9nRNiqi+xkgtGOurfS
X-Gm-Gg: ASbGnctwVbrjGLJz1VnID4JUSlQhsQfJkAwVNxLQbaNMYEddBfDVNeTUDBh+9M0Umgx
	QJ+CaK1yGbMa06jeZ3hZdo3u7xWqetInZnzFEekp1fMcYjPXwsoGgd8j8WIrQP6M10fOoIowBR6
	B/Ljrf8xLqa+0eZnDhnsONEWM8emqaqG9mEq0t+4pGje457PA6EaEwm6vbtFmKzSYP12mahjenP
	98c3M1f+Ke9H5d8f6cRyAmCoH2w1DoZuXxDejjdeykJE7vzKP9NRnrgMfffmtncsBDNPGoAVm26
	K500LZkCUBNRNPvgAYdQc17FUYIbcmTJ8OwD8Orei5bA7JVE1x1/6bU7nKN+v3tZdSBTtfhIXIU
	=
X-Google-Smtp-Source: AGHT+IFPb2ZdrMhGPTW2N1PqVE/+3I94b2k+DgPd6Oag38u6Q+S5mRw3ZYZ2u8G0y9uomnH6ysvCXw==
X-Received: by 2002:a05:600c:530c:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-442f2168761mr55146035e9.25.1747307668430;
        Thu, 15 May 2025 04:14:28 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 05/10] selftest/net/ovpn: fix crash in case of getaddrinfo() failure
Date: Thu, 15 May 2025 13:13:50 +0200
Message-ID: <20250515111355.15327-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515111355.15327-1-antonio@openvpn.net>
References: <20250515111355.15327-1-antonio@openvpn.net>
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


