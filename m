Return-Path: <netdev+bounces-75948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40EA86BC24
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090B31C228F6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496F72901;
	Wed, 28 Feb 2024 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nGmpc4XD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB172938
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162585; cv=none; b=CHhxHY/YcBfb0Qxvi0t9J4UbQVCAKxLWko3o3wpMWNsKuHLe+IqIxCik/BMa/ZS5Ky/9nUE51yyo7T2xC0756W9OCFSmcLPzU2u2STymX7tkJuq0DIoSTc1xij2mrElKljqhSMtpPq3hvMEDc1TmFcODiCya/ggdrJ6yIG4C4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162585; c=relaxed/simple;
	bh=gWzmDNpH4ymuh/z0FtOSGtL1rvV/ao8PcM2prYv6Y5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVVfNCLOW8YQ1yhBxO+N+XJSYIsljOhJgLs4jqduB0YJne9j74BP2l7FIm5PaXz6dWrroaAxGhBaeCos7LXSAftwV8lp6kyRWnJGK641jpUt7hSzEPVVf1oMPjeQ1/HWprCgBlpPReD/9QtZlQ6OF3tNXnwza4pMGA79OmGytcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nGmpc4XD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607bfa4c913so3422847b3.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709162582; x=1709767382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUXTQwpf8JAkFjPlBQzq5/ttlnpw3bhhsVqVvNgnTM0=;
        b=nGmpc4XDsk5Ja9En50/Y+g1YlkYOzKDAYUUP8y9bZjgp6aTfEB7OPdzlXh16hrY3TH
         T+sqG/A092ygqShIFd1JJ0HU+Vcb2b14gPlB9HRyFpUcorYDeBINEriltVWCIqK4xxqK
         1jcNY0zbZbhQ1GvnXbvqgwksb4tL2R5/CajX5oLAKUzO1DgkuUanXuL8hRiIRNpgKUOT
         SUkWq+cfOxshJU1PtGTkMTZvCAhX+HI0TAjrFqHmYeLvj9Gcax9ifwSZ1RJnZTAyGFsj
         Yno3u0UAbbHGONINSgLHGor1/GEPTANpe0V11rmxN7xsUzvR4ziye/P4P7qcASUcKrL2
         5nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162582; x=1709767382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUXTQwpf8JAkFjPlBQzq5/ttlnpw3bhhsVqVvNgnTM0=;
        b=Y0CX8X36NC3iXV8LrmYyMEtmn5EecIqwPyv6OQMbaOl3pSCFZD9gmrD/zfVgqUNzil
         KMtxQkZZ9HHlg5t4rmq4MVLAW/blb3AbEM1bSEpwQcwOE2a6vunWKKysWQqn8pRn9+7G
         qm5tcC61Ddl/w1eybpKG0fi1Scf+97a4AlS3U1NSbscZQrwBrLv/PTqBaLjSNXoEiQUx
         h4CPeLGvM5cVmhamTfmKrfl6CuVBtnoyJ81F1AxAe9H3UAsg6D+xUgrx/1LXuGO+c84o
         ord3s7TbMhx0H3r21r55htRhNvPg65UPQGWNiXAXFi90jEnK6NRcJjzoF9CrONYXlYIa
         8WyA==
X-Forwarded-Encrypted: i=1; AJvYcCW2ItgWE7z3w+r7JxuO+eYNExsaAOGpZpKWMeXYRvbJLfB7/Nd1Tmhzp/avEdrKRTb3XuinMU65ObFS/5ShK95PaZnC851w
X-Gm-Message-State: AOJu0YxXafLtm254HuzUbpDG4/Cgcsd/ofN78iXPuWM36m/MrckpkiUn
	fxICYmTIQ5LZqUYFoymK3aOrjslgWxVqmeuy86t/yLIVtlHqywnp2JYtuFKNEKQ=
X-Google-Smtp-Source: AGHT+IELWkpUghELm1lyMVKivm0RqxtoSTDbvVieqEJ+k0VG/HUMFe9+EWEIRvneJ3ba1nj4JfwlVA==
X-Received: by 2002:a0d:d48f:0:b0:608:b64a:1517 with SMTP id w137-20020a0dd48f000000b00608b64a1517mr553680ywd.19.1709162582010;
        Wed, 28 Feb 2024 15:23:02 -0800 (PST)
Received: from localhost (fwdproxy-prn-016.fbsv.net. [2a03:2880:ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id n17-20020a81eb11000000b0060487d30610sm29625ywm.45.2024.02.28.15.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:23:01 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	maciek@machnikowski.net,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v14 5/5] netdevsim: fix rtnetlink.sh selftest
Date: Wed, 28 Feb 2024 15:22:53 -0800
Message-ID: <20240228232253.2875900-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228232253.2875900-1-dw@davidwei.uk>
References: <20240228232253.2875900-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I cleared IFF_NOARP flag from netdevsim dev->flags in order to support
skb forwarding. This breaks the rtnetlink.sh selftest
kci_test_ipsec_offload() test because ipsec does not connect to peers it
cannot transmit to.

Fix the issue by adding a neigh entry manually. ipsec_offload test now
successfully pass.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/net/rtnetlink.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 874a2952aa8e..bdf6f10d0558 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -801,6 +801,8 @@ kci_test_ipsec_offload()
 		end_test "FAIL: ipsec_offload SA offload missing from list output"
 	fi
 
+	# we didn't create a peer, make sure we can Tx
+	ip neigh add $dstip dev $dev lladdr 00:11:22:33:44:55
 	# use ping to exercise the Tx path
 	ping -I $dev -c 3 -W 1 -i 0 $dstip >/dev/null
 
-- 
2.43.0


