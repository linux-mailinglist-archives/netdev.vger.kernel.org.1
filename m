Return-Path: <netdev+bounces-211536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098FEB19FC5
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2758D169FB3
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53D2459DA;
	Mon,  4 Aug 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4hWao9q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01F1EDA1B
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303725; cv=none; b=JRjrSz/qBtcN91mjbwEmTtRK25UC8UR0WBaweChtddom07RhtIJwUOCddt7qvDBHvbAvRTG7H/FjTVKR6UZUmlgYAl+flOqrTR73cvbg5yAanvyw95POYjvLbF1mLoeNZdZ68Sg+KQcw6qWQcw4kwub8q4W45EdID7grKqXuxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303725; c=relaxed/simple;
	bh=pe954wgmmEumejGnwBHivOYRG/9KnkTNzBgkDVd/euQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WKJalYVIINBQYMNLB247lV9b9IXL0ZMY/yrkQnkNWNdnvtHxxu1yPTY1vRbVz3tbr8A4eKSlem1cjyG45pgaKkgIGHiDZuCiyqf9C0HAvf0AAoCyRDozMa0zibFv4ZGnSZhUgtfteKeQF6Vn2dhamF6tUfq2A8RT9LtM2Lf70Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g4hWao9q; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so2209438f8f.1
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 03:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754303721; x=1754908521; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVsZnKEppNL82Tx2ebT8ir6qzuWebnepuASOH0OHUpg=;
        b=g4hWao9qdifWhoIOEf49FFbDYg9Hx2tkcT5zZx3GFLRDx7nPAKten8/SESE+WOJZCQ
         ld3cDcnpRANfnMExQMwu7ORGa0AUkWAYZd78C92Bhb5iLrVU7J0Mkel+UVisiiROfxdf
         4kgDVHzmNA6yxYMNrFKuxFTu7V84iHm47bhJwOkkwGTuAPs2cDtB703aHOalWhVmnZRi
         ENQw6ofUzLhuw9aT4hglaiftC5G2RmyRqviLOSnQ971iK0z4Pry8QQ5YTYuEPwyryGJ6
         0xsVrBQCHpSmFE27+wS24yjSxSNSapRNp7F7otLJf65jvQWxR0sycLFzNuHrEpEOXzaa
         HdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754303721; x=1754908521;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVsZnKEppNL82Tx2ebT8ir6qzuWebnepuASOH0OHUpg=;
        b=vPAfHEQn2P9kWgnViOxb+F3+MNSBf0jVc20hmeYJ9rfnMsqsdszkAD94qLV+jE82Br
         pV9yr8xpsLwZMCfkAJWMDF6m03PaZhk1e+wvW1fLVPylvBGQFd+xjbl274xXI5RRL0E2
         kXpnZ8UmhGDU544casYEEd1eUrHOkDWvMA3CorCL5iDlHJXs8X2K/gM+2h9yn2oWLXnI
         TzOzn8lwrk3zbLIqV0uoWUvaoS7WlPiwM49g8V8TBnSlsa45c0PIHmZ8iPDaqlXnHh8g
         gxJUg9WxO4x0y7bIyHhstI0KKrOhNXCU3WDRx2pQD4qdI5L1QrdvBKaM3A0PLnGj2Mb/
         Q6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXHxmEFU+rjFXnZ2eh8qNp9+DGDVEGh0g57fgfTmfgAgs1sgsiCVA/muawi5b2QBXZkSB/SgMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSrL5yoRTkKDQy140wrhGXKs1ouJ5OKtHAD0xCYigg22R+yec
	Ik08pA6kdLb+bhrbCIWnVOPWqsDAFxRqwrDrddof7CObQsKeHz9ssekULFktXaoiM9s=
X-Gm-Gg: ASbGncuXyoniqOk8HNcJ4Quc8HFnS5YZG3032eOBAMyM8ozt8Ix3B6KHStjD8/AXIit
	032GD+NTKkflyIk4oYQi6T2KQvmsqY+uocZ8BM9w+vr30vaXZCeVU0YjHCIXdNNVonyD/LS02Q7
	4sKx4xlYSHHO8l1GGrZOD0dIShkWhuqrdQtc6LaHwKjasbqB8TD5XFm82RQ2tCAD2Qe4RW+9xyN
	lK4YjAaqR9o1XrGa/JIFEf7tsY2mlL3ZEBe5vh7IA3AIGO2k/P0i+t++nzxpR1FgmjglH+sJCU2
	ds6ORDJ8PbmFB8XaJzuKR+VpOgOb0HtvBt2SlTeijbKEoBSO/F9EPVVdxa0n0H6jYyCSom3GNUh
	BpGwY0nKscknpY5BbnRPr+HvkVHk=
X-Google-Smtp-Source: AGHT+IFxnCtzMP77QQqIeHFAiFOez521/A3SRrlULlSKZYQx0zCUMF1RLl0DCGN4eVqJHy2LDD7DZw==
X-Received: by 2002:a05:6000:26c5:b0:3b7:8473:30a5 with SMTP id ffacd0b85a97d-3b8d9468519mr5415292f8f.8.1754303720554;
        Mon, 04 Aug 2025 03:35:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c45346asm15189488f8f.39.2025.08.04.03.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:35:20 -0700 (PDT)
Date: Mon, 4 Aug 2025 13:35:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lance Yang <lance.yang@linux.dev>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] netfilter: clean up returns in
 nf_conntrack_log_invalid_sysctl()
Message-ID: <aJCM48RFXO6hjgGm@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that these look like error paths with missing error
codes, especially the one where we return if nf_log_is_registered() is
true:

    net/netfilter/nf_conntrack_standalone.c:575 nf_conntrack_log_invalid_sysctl()
    warn: missing error code? 'ret'

In fact, all these return zero deliberately.  Change them to return a
literal instead which helps readability as well as silencing the warning.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/netfilter/nf_conntrack_standalone.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 9b8b10a85233..1f14ef0436c6 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -567,16 +567,16 @@ nf_conntrack_log_invalid_sysctl(const struct ctl_table *table, int write,
 		return ret;
 
 	if (*(u8 *)table->data == 0)
-		return ret;
+		return 0;
 
 	/* Load nf_log_syslog only if no logger is currently registered */
 	for (i = 0; i < NFPROTO_NUMPROTO; i++) {
 		if (nf_log_is_registered(i))
-			return ret;
+			return 0;
 	}
 	request_module("%s", "nf_log_syslog");
 
-	return ret;
+	return 0;
 }
 
 static struct ctl_table_header *nf_ct_netfilter_header;
-- 
2.47.2


