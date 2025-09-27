Return-Path: <netdev+bounces-226891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE819BA5D37
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1AA189F78D
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD429ACF0;
	Sat, 27 Sep 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqS/ikVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0621FBEB6
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758967116; cv=none; b=tjL5IBKazx8vEbUMUZTcJfEQ1FLrYvFiNoTzgnQhSxR59yva0YJ4DsUT84J9Co5mIK10MuOHcOM+DIty9b7Wm2gq0263/2LeA+FLQX21At+lur69aPvpAvz/QGmCe9X1Cgqq6ZxuQo6lHcN2sSmN4WzrhA8fpvJVU9AgZIdoqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758967116; c=relaxed/simple;
	bh=j1bVfAj7//G60X1BtKuPnvoCRBUd9MxE1pUWvd/cWz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RqWtvI/XRsMDsf4gax0CM/NoUadVYfE3GOS5iXasEh1DkWrqS8SsGDLbHf1KQmtq1gV1cbgeBxzH60ZYh1Tr5G0eYNeimVK3cDZPeOYFLzEoX8yOaFKUltm/mDpIDi631Otx9K1Iiket4qC8BulP1NZwiManCHpSxA7wPrBsP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqS/ikVA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befd39so5435774a91.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758967114; x=1759571914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Njm2emmVpnAqBWqGCN2EyPXZXz7OLEU/Iq1X4aENRa0=;
        b=sqS/ikVAEmgql/oNbSJBOMzmmjiWSXs67v4ZLME8rUa9p90Z2MgwMl1blb2rylO063
         VDM3b13QDsJRRZqCJrylt4R/gTPuDtouDbxSA/vgmDVG/aqxS19+jJEHN+InmEFNmU6j
         VRd1YNwbcyHF+XrItiR06VcnAgAqJVfPfvIq5EsrNurOlVqUWulrDJ6y2zfoLO3PzXY7
         w1CI+mr6JfG/ZNc7GJYSQcHQUCIMVy3GQnlt6Os7u8EqaO1nv8bCEMUreyJYfJi1WGOM
         9FgzlUlr/h+7hAE4j1YpdNsgijes1IvjWro93U9OziMy6AEIUEropgq0308s4JL1pFwP
         tsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758967114; x=1759571914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Njm2emmVpnAqBWqGCN2EyPXZXz7OLEU/Iq1X4aENRa0=;
        b=vpgls8Cd+2z1cFxW269yYotGiND4ECIjuR4BRHtokGfvVLlxM4UuyL5ekagMKbUBIC
         MU6iiWLzNHB79yTzvwIlQFJP2iYtGQYIipyUWB8HqO2kTjapipaS+lZf4C0j2XzBdC2L
         C4hvYkybdYsnZWK2uqtfY+xC/9YXvtvcW1kq+szGTPWRkC6zNDbyDbNmCYHSgnPZECki
         toQd3k33zuYszwWhRQwqOh675yxu1bPLIzYkMdMJNVMn8zC6UPaVmgCkXX5SJoxA8M1H
         ILkpkom4IFBKOQf0iBaIFFPD0TamkfzYkUngyzWmPqJ00qGiDLXSvVhfEo8mbizKn/ai
         QRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb/c5euY2pF1TlsnvnyhtLLqyoFC+VNnCTGYONGGEUwY7VAGK3cptBIQsAia+67gK/h6ZF+Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSc20YmG11PgTfcNSo3w7P+5o6LFjKhSxnapkcDQsXg2mlK+Z
	Zmr1gwQdD89n5KZKG6gSfyLiLWUNIsqsvhI9aV5Ga1ZP2udTXOIkv3LF8aD7ElzkdaHUuCVUB4i
	kzwt60w==
X-Google-Smtp-Source: AGHT+IEbUbmRSCuYMB6EaCUVz6b3hzl8Vv3A+4ehpUguS/duCS9AxXBeubGQVKJKRuPxi/WTiDmEA/8jc0Y=
X-Received: from pjbaz14.prod.google.com ([2002:a17:90b:28e:b0:32d:e264:a78e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a91:b0:32e:70f5:6988
 with SMTP id 98e67ed59e1d1-3342a301f41mr9784980a91.32.1758967114144; Sat, 27
 Sep 2025 02:58:34 -0700 (PDT)
Date: Sat, 27 Sep 2025 09:57:59 +0000
In-Reply-To: <20250926212929.1469257-8-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-8-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927095832.1651104-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 07/12] selftest: packetdrill: Import opt34/icmp-before-accept.pkt.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Sep 2025 21:29:01 +0000
> This imports the non-experimental version of icmp-before-accept.pkt.
> 
> This file tests the scenario where an ICMP unreachable packet for a
> not-yet-accept()ed socket changes its state to TCP_CLOSE, but the
> SYN data must be read without error, and the following read() returns
> EHOSTUNREACH.
> 
> Note that this test support only IPv4 as icmp is used.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  ...tcp_fastopen_server_icmp-before-accept.pkt | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt
> 
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt
> new file mode 100644
> index 000000000000..d5543672e2bd
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Send an ICMP host_unreachable pkt to a pending SYN_RECV req.
> +//
> +// If it's a TFO req, the ICMP error will cause it to switch
> +// to TCP_CLOSE state but remains in the acceptor queue.
> +
> +--ip_version=ipv4

Sorry, I noticed selftest failed in patchwork while this test
itself succeeds.

I forgot to update ktap_set_plan in ksft_runner.sh in a5c10aa3d1ba.

I'll post v2 with this patch after 24h timer.

commit f4f03e74501ef4283d27716be37b5effa2b7e4db
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Sat Sep 27 09:41:42 2025

    selftest: packetdrill: Set ktap_set_plan properly for single protocol test.
    
    The cited commit forgot to update the ktap_set_plan call.
    
    ktap_set_plan sets the number of tests (KSFT_NUM_TESTS), which must
    match the number of executed tests (KTAP_CNT_PASS + KTAP_CNT_SKIP +
    KTAP_CNT_XFAIL) in ktap_finished.
    
    Otherwise, the selftest exit()s with 1.
    
    Let's adjust KSFT_NUM_TESTS based on supported protocols.
    
    While at it, misalignment is fixed up.
    
    Fixes: a5c10aa3d1ba ("selftests/net: packetdrill: Support single protocol test.")
    Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 0ae6eeeb1a8e..3fa7c7f66caf 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -48,11 +48,11 @@ elif [[ ! "$ip_versions" =~ ^ipv[46]$ ]]; then
 fi
 
 ktap_print_header
-ktap_set_plan 2
+ktap_set_plan $(echo $ip_versions | wc -w)
 
 for ip_version in $ip_versions; do
 	unshare -n packetdrill ${ip_args[$ip_version]} ${optargs[@]} $script > /dev/null \
-	    && ktap_test_pass $ip_version || $failfunc $ip_version
+		&& ktap_test_pass $ip_version || $failfunc $ip_version
 done
 
 ktap_finished

--
pw-bot: cr

