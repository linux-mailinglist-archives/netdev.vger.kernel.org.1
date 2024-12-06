Return-Path: <netdev+bounces-149711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D4C9E6E52
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2EA28517D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7CD2066E7;
	Fri,  6 Dec 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rd9xsiQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048F203700
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488380; cv=none; b=MwfmTDVMunCZEke+pC49wYmLDajbimbUWEo8xwH51tzUqs+rfmTe8omQR3tw4EZkhgLaInbtR7Zagv7ll/lt5DDyskFXifHFMB75MAuqpHo5AtqeTo5wW3kXhySiHgcAfR8AHpIG5WnXXgL6IiBD9OyZUqKcUGjXYk+w/cAJdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488380; c=relaxed/simple;
	bh=iupB6znwg2GMb//vGp4ZNrsZGW2q9LnmvRCao1OKqvg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F2hTp1VN+/PIjtNhnaxB+CY5v8MQGgHJC+ZoJIuIA2c3Ybp0ufK5FLQ5w6WZsBcW3ptiwEtslXPJgiXlptXdRlWXA2cnUHQZRThLwhYl4ZWYEIbtEgdPCIYPKPgk7fojsjfi/tLynz8+HFWylu3dYiffBZvlx7bYYxBMPa/Ss2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rd9xsiQA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so13499725e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 04:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733488376; x=1734093176; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRXlI0fr3FagIbalUHKd5lGtIrqnXoTSjk0ZGwUPm9o=;
        b=Rd9xsiQAzLJJB+wUCirmS8EvEwhnfHNrcxzZqWjW5CQeezmm1nDFDGWv/b1csRf0Xn
         0UKr21RTxSa1527SmbXdL3IDflgDyYy7zWXvPDtSp37OEX0bZraX4qaLpzlDFulPH7Qz
         peYn05s8YGWd6T22M8ScmnNbmRQE2WgFXJctPAgvsmrBM5w2UUi6wf8a1iHU6eJjF8S6
         ps2RlNI03qIwdXjBrCQfywoWw9PCyfYgaL7eJ5DP//844Va+Q43SLBYBbXTZvevbQNdn
         PeBMIEnG3z54drimEAvLEQ+0tqlXau1z6kJJrV9N5Wj4/3nuHtgWIAXzLfTk5fpWRHlP
         tSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488376; x=1734093176;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRXlI0fr3FagIbalUHKd5lGtIrqnXoTSjk0ZGwUPm9o=;
        b=uHSVp+49lQVb3lHAfravhej/EX35iTU/ejLcHKNi7dxyJKAcZqg37BzH+31uvV2Wt4
         9bptktHnA0bdFTVY6XIGdldfA07acAEeLo4Z0p3JFz3283qY+HodEawxHcg3FcFuJ1vW
         KM1MiLRCDvIEtAIm7JKdsqj7Y4fW4zn0nTZzxoNIY18/AZerIqsKotO6620UY3qFvFKD
         KwRvaM+08saGyZNEaSCTvXRsi4KRRtUQRWY1/rRvdwmTJrR5HUZZmXPnCLh9DavGRlno
         cz92jin9V5rOfdT2jScFO9geCM5g9zsD2+5cRMSTnYEjswcERtQo4p5yMZ4eAzVwDkLN
         w9sw==
X-Forwarded-Encrypted: i=1; AJvYcCXv6c1W14SoqDjTnkgtIGn1tEcyS2lLqpye69ce8cJwJ85rFJQYTuQWiytkP96CYaTu21OFMAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmCPnE6kT/FppheguzR7JfGfG7vTyRE3sxS9JZpNTpUlQii4F+
	OU5gemd7UUw/FDZRdBrfdJVJIMaz6yU732BZl+t6JUjvMv5HF26yVegpMoqZAqI=
X-Gm-Gg: ASbGncv8s4zqmGjiGGg+ywL2tOPqb7/LC3Y9/VTLJ+jJKZIrMDD73oPJmyBmrIPsC2q
	py/Mui+qdYL0lfLLK3qLv/mFimAj8OoGHToxEBm6e4HBxJHB+aIzYKRRmaNK2ddEE5dNXxQ9TEM
	67hSX6LhpdLjzncFCwegR/boYvZSnKy5W7MrTrI2Rjr8dyPk1NXEly5w2fxanLYd6W5UXFRlnus
	flnLvKBYr23e3OArI3RmQdqUJIUjV0exKbI/1AVP5WpAMAaFIsrnqk=
X-Google-Smtp-Source: AGHT+IGt3cBWemTT8wkdLb8l5IGKh+d2z1IsEeUgaL58GtEPpeejLYUCDHYE+XO/2Y0fbIUyObvsZw==
X-Received: by 2002:a05:600c:4f87:b0:434:a805:1939 with SMTP id 5b1f17b1804b1-434dded6738mr21714595e9.33.1733488376086;
        Fri, 06 Dec 2024 04:32:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0dc152sm55588575e9.25.2024.12.06.04.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 04:32:55 -0800 (PST)
Date: Fri, 6 Dec 2024 15:32:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cong Wang <cong.wang@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] rtnetlink: fix error code in rtnl_newlink()
Message-ID: <a2d20cd4-387a-4475-887c-bb7d0e88e25a@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If rtnl_get_peer_net() fails, then propagate the error code.  Don't
return success.

Fixes: 48327566769a ("rtnetlink: fix double call of rtnl_link_get_net_ifla()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/core/rtnetlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ab5f201bf0ab..ebcfc2debf1a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3972,8 +3972,10 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 		if (ops->peer_type) {
 			peer_net = rtnl_get_peer_net(ops, data, extack);
-			if (IS_ERR(peer_net))
+			if (IS_ERR(peer_net)) {
+				ret = PTR_ERR(peer_net);
 				goto put_ops;
+			}
 			if (peer_net)
 				rtnl_nets_add(&rtnl_nets, peer_net);
 		}
-- 
2.45.2


