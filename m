Return-Path: <netdev+bounces-73884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 298FE85F0BA
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 06:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC153B23C52
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 05:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928177490;
	Thu, 22 Feb 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="mMo6qVO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF279F9
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578530; cv=none; b=KHLCJ0AURoGxtq0CJELgoDAanuTciwPvAWjtkWrP44F3QPnmfTh4WY3CjCDojsoVGIqYsVmUgUwvysTUof4MnLayzktz83szErfvP9Up+rMekmbq6oReRLMOZSQKuDfbHF3Yx8PWC9Iga5iZneT1LfBdjj4K0q1eWVV/UP+qswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578530; c=relaxed/simple;
	bh=CurFviOw4itoUtMNe+SZx2bpR/RLLa/WZSwhPDY8PZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThI60OrnOtDlOOE4urF70l+cNqcB6FAmTx9w901AvbH1eV5EwrlYaIy20uY23P08mJn6M2XwVfBJA0jMozqmZhiV15ZIE5vqaUDs2AUMhAs6g8Z8sT4tQbJmO7yK/3yVp2Zjy9UEiPgMKJGM+Hsb+3tFbpSJhDau+btAd54WkNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=mMo6qVO3; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36517cfd690so4013275ab.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 21:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708578526; x=1709183326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9USVVGat00F5jJQj+wUn/U8TMoSCdZw7GREj2Omev8=;
        b=mMo6qVO36xYJ5Y9UGefp9ARdKc9hlY5/RhFCK10CBbyutb7ukHh7yOcbFhduokx+of
         JZ5VJNU7sD0xrLyu/hZ4wYQHoHTTEUVyeIzsO/MY1ffVhZ+Rm90bfTnJykUSbyzxnxp+
         W19Dwu+RvNkYN7aBApzrm93PPqYssOuKYItXBR05e/voLkKETK4NOxQ5mkWjlalBUwGi
         5NXZ9yp232wCzSRr5MxwAaKUr9ZVfuHuO30Yuvqig33yZTT/QGCSwhTSgc/1192TB0rf
         LEFgNwrKiu3z2bHnrykToqR+kegkADcFjHwYW+S38bWOHAJiyIU1IMxJk33lVK8CmGzq
         Ug3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578526; x=1709183326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9USVVGat00F5jJQj+wUn/U8TMoSCdZw7GREj2Omev8=;
        b=eMpKRqjEUja1gAG8bhWRCmpNpU0oKDDwJV3JejC0D+Zcdq96/vZy5DP8smgwhR1nbJ
         W3sQBCfrug0YQrMv/bJdCn5tZ21shhNGI2X/u9f8HEfLq4mV5PCqcs33cjCXNNlJYdEL
         LJ3RQsM3JGGGUaMCNMzWBGYd/DQ78KEazKbPoTxfjT5zkbHcgYMdPcj7Rej82H02XXTJ
         wlooEaf08yg1zeARJrdS+WSGvFElflzKTQvzLcCgri8ONkXf+ETXGjrk1bkoKE+oatM5
         FyYeAUrpb+7gMPbdFrhRBcJ9J90cflpTc3/08FK3dmUswVdUpu4vBZTqH4Ja7uRogKv4
         cmcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkbEzIXb5IKSJZvXsx7v7FC+f307q6VxoLMvbuAZj4TROPikCxCwoo/QmKNmvrXMvT07T5v9R2YCFf4iRc8Q8OtX8YGg74
X-Gm-Message-State: AOJu0YwC5JCBzpIz3ODAJ1HsQCQf9Zupj6SAELsJt5+JaNBczwy3eSN9
	3BdWm0pGfBhXJ+yZu8IACEN6lfb41IULMT+dnwgXFAGbyvClLDg/gd/Exql0YII=
X-Google-Smtp-Source: AGHT+IFKR4PUttuWoh69U5XDCWvToR6hffbetROxwoSdmdrykF8LZrcVc3cVwgwQm+Lggo+rPa6Xzw==
X-Received: by 2002:a92:ce03:0:b0:364:ff2d:8989 with SMTP id b3-20020a92ce03000000b00364ff2d8989mr17030890ilo.31.1708578526531;
        Wed, 21 Feb 2024 21:08:46 -0800 (PST)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6-20020a631946000000b005dc4806ad7dsm9376754pgz.40.2024.02.21.21.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:08:46 -0800 (PST)
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
Subject: [PATCH net-next v13 4/4] netdevsim: fix rtnetlink.sh selftest
Date: Wed, 21 Feb 2024 21:08:40 -0800
Message-Id: <20240222050840.362799-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240222050840.362799-1-dw@davidwei.uk>
References: <20240222050840.362799-1-dw@davidwei.uk>
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
2.39.3


