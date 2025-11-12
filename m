Return-Path: <netdev+bounces-237775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC76C501DB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDAD3B1581
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137441A9FB5;
	Wed, 12 Nov 2025 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="J7iUTnwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD414A9B
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906686; cv=none; b=gK7lfnbj501NABimuV7AtoNEjSNLmbxkaW38Z/n/7jZWhmn6/yHYPKv62mhdmfBQhFhQci9O2v3+fvFLIoJOR0nBuLrHXjsPy86+1jTTjYhaNPr6pOBtpQAhmznyEWwQVueaE4JO04JXBOR1O1sKrPc7/dVyUY0uJc5q7/B9sRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906686; c=relaxed/simple;
	bh=zEf2ljGTPUqCqpRy82xujGIr/HfaUDUa7NCJ7A7kYDg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+ZBQNgMOTeRGTMlDdullkRZ1xg3Gdy7EQC28N1/IB4qUaQEE0O5VRJu8T5M+zJYy8v541kuQRsUTPtQbMg0eDnpr75rUGdbj5Wg2Ub2X+/3DkLuw3yGvQ5QEKyn9xIwbGUr3Cv+FJKdVkiDNJ9heEmNblsjnRHopThGZ52L82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=J7iUTnwQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso224713a91.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1762906684; x=1763511484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnud0AMW26ogsoeTMMZ8KH62K8kgdGPSoq19V2shzao=;
        b=J7iUTnwQR6Iopc8O9LS52bmSVghGRr59Xi6GHH+RgJpxOklhxHjC/vh0LYUK/H+LM6
         VW2ed3+qJokXguxmDEe/4jc9IcqNYna5NmqU5PDmqGQ8XPo87/ZbCP1SrUmyMcrT3K/v
         w7qOJyjTBuLjf2Lp0I2AKrjwmVoF0KAn/G/xuu8qytLhnNJrt94XYFLLO0LAv8xKxRlf
         9xV96YbCkC/zSGiEmhHtyz3+ZpctiJ2laCj8lGqUyhe6C4xQ+pH5ccGq6BuwVKH4fcDW
         +kwf20RhoNBtBGZWqY6PSvxhKpgoqEoKTTq3cw1UD4n3uQTKJwrutJxgeuTya3NTDy6R
         0zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762906684; x=1763511484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xnud0AMW26ogsoeTMMZ8KH62K8kgdGPSoq19V2shzao=;
        b=pUO3khK58rd84/ECtVYL/MqLlc7ycAuDJSDomDxy0BYRO6e2yXvmaNt+Pc7OiCx9oo
         r0FXdwZbjUtcu3Oh7ofDthw9fj5PVLpVyvn/BEUr4RE6+rClmgJZAaL7nPF6K2xqf3fW
         C+kExsumoUKyb4ymOhDSX1zpjRDypAKyV+lhhUbvyFRd/hgD5rb2MQMT7BwEz+1foJVW
         iA9Gx7GONAOOHucx4O3kmY/nxLGJjTE6EYKBoNk59H5Yr+zxwW2BcA/daVDTrxBZLT1m
         KBOSbH/k0A1fsyRz5H5HtMZGhHnsXqPQdb+chAkWbHtGEI1UG+9uzckZ/oOX34qaAf8L
         oYrA==
X-Forwarded-Encrypted: i=1; AJvYcCWT8K/7c7pvApVU8/xH9h5o7GPLau/BewsBieDXMOLDtQniTGvnPARQoCFbPl2fAuGjBKALc4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQx6Sh9jO6FA+kXNsGfTx5z7uiFVp3Arad/k+Aw9EvwX+TD2nA
	Jh8w/SnZKA2o6nACr8zdvMDlxxooiXZ3JfrIgWvzdhGMKdV3RDauS+RzJcNbK5nJlw==
X-Gm-Gg: ASbGnctyEj5+3EJFH0Y6JiB7R7KtuuhveitFKmVujoQgcwBMjsR2mcoj8GWaWmCWQw8
	yFWM9+5taXC2d0c7gE22tBy9lEzdfCzyL4drEVvL76OCORvNh5ecakMENCEFDX7k/QUjTEhnRDH
	GBjSD0HvVYBp1FuBxt9518JZ3SAP20ViyeLGEL17a8KAaI23YnbZlMDhlLHKMNT+PPAtwbeWZTE
	MP5+itk6kZhMd6F/iLNT5E7PwfxCY7cIkfOXM7ESc8f35jw+8sTfa1JEvz78+QZK9pRC2hILkez
	koWtK4ZayUrgSvFdwFOGrOerx1ZWZCTyHZKK06o0hr/3QPJqLo4hLcoW9CPqdUB6cNv24iGQcvf
	vlt1qKWi5kVT8/adZvSx4SdoFWYgrE/KsqzRw+Oo9u82jOY4501NRV13DOn1B3Kz/q7Sh71m1LY
	j88fSWnkR9A2iax+wajM72BAT2F21Z8oM6PMpBlepf7UNYGA==
X-Google-Smtp-Source: AGHT+IFcpjB8dGM768TbvG/P1qd4bl8MkzedN8Io0eSo0NYDoz5ZcLkuQXTgwcuVTm/M3WaYBE5jqw==
X-Received: by 2002:a17:90b:1850:b0:341:8ac7:24d3 with SMTP id 98e67ed59e1d1-343ddeeb524mr1252838a91.34.1762906683702;
        Tue, 11 Nov 2025 16:18:03 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:8c01:13c7:88d7:93c8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf1782bed9sm754222a12.27.2025.11.11.16.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 16:18:03 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [RFC net-next 1/3] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Tue, 11 Nov 2025 16:15:59 -0800
Message-ID: <20251112001744.24479-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112001744.24479-1-tom@herbertland.com>
References: <20251112001744.24479-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In IPv6 destitaion options processing function check if
net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If is zero then
drop the packet since Destination Options processing is disabled.

Similarly, in IPv6 hop-by-hop options processing function check if
net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If is zero then
drop the packet since Hop-by-Hop Options processing is disabled.
---
 net/ipv6/exthdrs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index a23eb8734e15..11ff3d4df129 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -303,7 +303,8 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	int extlen;
 
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
+	if (!net->ipv6.sysctl.max_dst_opts_cnt ||
+	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
@@ -1040,7 +1041,8 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 	 * sizeof(struct ipv6hdr) by definition of
 	 * hop-by-hop options.
 	 */
-	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
+	if (!net->ipv6.sysctl.max_hbh_opts_cnt ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
 	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 fail_and_free:
-- 
2.43.0


