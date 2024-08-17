Return-Path: <netdev+bounces-119410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B77A955804
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 15:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535D91C20BAB
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C4414D28A;
	Sat, 17 Aug 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="KbKb6G6x"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C883A17;
	Sat, 17 Aug 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723900711; cv=none; b=WtnFubBcPBYwAWcuar4IF7UrIr/iDyKHBH4/Q56Gg49oyN3+DF5u9IaROXghbtYXwhlDbPcv3Kfxbkec560jpQenbZ3GZAw9Ulyd+BGUcsSUMxftMBdUJ1ljuXg7w33sHldIXk0Ks5ECuKit6bHcmD5OOU/kXPLSXttJ5MrZgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723900711; c=relaxed/simple;
	bh=HrSfnsFtNBSL3Ll3AO1k9QGFMqtExW2Cjt6YKQfpa/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/I0Ke5hT0EmTT0tnvCu5nwXNi1YxTxg6NU9Lc4QZTx6T5XW2Q+oG+MHhKpTIHueQ7MD6EdQ5RZYqv6dHHKxh5kNQOXCtDg0MdzdtnuFqKohmjsfTKPtIUSe2f5a2w3WbZIE++9KbTN0OU4EhQNzi92pfpKa+oKJsr1eJmo591Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=KbKb6G6x; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 7A04A200BE42;
	Sat, 17 Aug 2024 15:18:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 7A04A200BE42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723900707;
	bh=aSOs550sGKXT38iGfuI5W9QA85cxI3oGMnVNHjYv2lw=;
	h=From:To:Cc:Subject:Date:From;
	b=KbKb6G6xi+Fg2lshGPww3tjKRaypIIv+LIO9Q9qFey6HJDVRaiaUTuVxHqi/kBUVk
	 TL9XaGIjZAZOVAu9GyB22FHxACh3sVrXWu2vZUv4Hq4Jhc+bsoxKk09bwVyxiSeqJG
	 MDWuPKsA69rmjTxS12ctaIKThr7WuwPKGwyDTossotBOmGPdfINm1mviXQVGRMSJhV
	 bXMS/8w4QTrX/8spBRmxVg42bpVkIfuEebjza0kshQTxlgr3ZpdN35Ws8tCptos/0O
	 ngqOtCcHThBzpBMi8uG5rgAznPzjP7udIn1FwTti+cWvhE1XRFK6NgiJtsQ+DoLkUO
	 O00exDhmkqA/A==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v3 0/2] net: ipv6: ioam6: introduce tunsrc
Date: Sat, 17 Aug 2024 15:18:16 +0200
Message-Id: <20240817131818.11834-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a new feature called "tunsrc" (just like seg6
already does).

v3:
- address Jakub's comments

v2:
- add links to performance result figures (see patch#2 description)
- move the ipv6_addr_any() check out of the datapath

Justin Iurman (2):
  net: ipv6: ioam6: code alignment
  net: ipv6: ioam6: new feature tunsrc

 include/uapi/linux/ioam6_iptunnel.h |  6 +++
 net/ipv6/ioam6_iptunnel.c           | 74 ++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 12 deletions(-)

-- 
2.34.1


