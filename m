Return-Path: <netdev+bounces-112298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C29381D1
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C4A2817D6
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDC13C80C;
	Sat, 20 Jul 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Gwhir+VB"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DF137C35
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721489353; cv=none; b=oSMw3D+PnScU57YYVfvvBSxKrDsRLFPZ4vkUxGtkk6RUUu9Pysymdf6KaDnqYyZIwPXNB9oFoOnLtc2GZqgpWCTVEdZf4ZWF9tCefk5M70fvH6j0+Ns96iyT+QqEx5KJG1JAoHouVNUs6IM52f2xdpCKmaiEZDQ4rVWFbozQnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721489353; c=relaxed/simple;
	bh=YIPVGQPbqp/b+gxzkefVoV6IK0+9SKYvEALFbZiCepQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=j3ChwMstuChi3h7dSYGmKVhDTp+PLjdMjaUsEGOcLkXkHv7FnPC7QF8Nm633QDRB9L7ikxBIANrtuSm2RwkJa+TATwVefCdYZwQlN3EGVeI++VRc1ECKTvXGNiKOQVghR8m7bUrQbe+eQhCK3PPZKeecxs+yYQP+0OirL1ApftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Gwhir+VB; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1721489037;
	bh=QOFI29HmkVBnYiESq5GsNxCNCvc/mgNcD5DvcYXvV/Q=;
	h=From:To:Cc:Subject:Date;
	b=Gwhir+VBaAh6uH1U3/FtRWvPdt3zmDhIwvVrIbjcKMMRkD47bDmvp314fcPrOA6OY
	 lfKpa0jgycbJmgLDLFLetL+N3zTT+kh9IFowxthcQgOAphHdmCiF1md4pkYBSH1UZ/
	 SwoXMnDE467w5gBOtlmdN5g8n2JEDP1ut569zz64=
Received: from localhost.localdomain ([1.83.74.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 5F017854; Sat, 20 Jul 2024 23:23:48 +0800
X-QQ-mid: xmsmtpt1721489028t2ss3hkng
Message-ID: <tencent_EFD6593E69AD867624E4518D515816F58505@qq.com>
X-QQ-XMAILINFO: N2DE1hXbKkms1sc//Kl6WrRhZSxMrjOqP1F18bk4ks+S0tx99YZq1XkTZqr+U5
	 Ffa1vSMWvTR/dstAjVz3VGfsMmK6DXSAneERBeaJeHtMsuNV0xI+h1uLbFXrdb49t8r64VyCl9yi
	 KMLnaOjDwQxzQfGJoZnO7dJxLes9HH+WG7zdOy7+SFFmsAnZZRU30sYVsqXayFEYWLCX0trSDJAt
	 vc/77QjtkRFTGpBIoZvGTcfsqJlDkkfBm+80yCktzfyV8DCf9yRsxONJUlvK+ww63oHlOrloUJHJ
	 8IS1dOOxvgoViIqLah9d8VCXzFhhhYedI6XZcvm1drUo+eGxnUY9NbGVWepZdx4rFbB1NnowqXfd
	 dzYjdCUwzi7kX12FciCxQYgmDLNNCSUdYqRrNr6exs6tMztXvg7apwOyRw1WaiZQJMIQEFvxIUMa
	 A+yVypfQXxGWr3Jc4dIz1rFZcS+lS24JciV1EbYpWm6ijeTX4/25LCqevFNjKAn7D0m7kNqJVOaz
	 u19KGCQXiFpUdaKnhehp8U4C5zgI622GemWSKNlgR+nIQ53NbXiK+2OUrh+vQe+QsHvyratG3kvK
	 8FqFLsuJmSH/CEbUXF+c8B68FePfe6hxaFL70NckhADqvpLnA2AxSDO9Y6ShDqMXeRM9cOotcg+L
	 LXbgsRGFi9GnBfo8AvrYbLX22Vlf7TrF+w9fUUnkGMIjcE8wUJrHohxB7zmaT2opx4Os4dx3di0r
	 QX53nBFRFUJ+Yx+FTSIpKxAMLxzzL6qEBMSgDVIFQcrOG6uCNHDBu7M/P5i/4S3l60ccHs5BQvqI
	 Rl3cIKNoU0nEAkin1h8Fy45zVOy1+3bPn2ESTXaMBZky3d3qb/CiyixMaCIX7cJr5S0BwJIOIO7P
	 +VLW89Vn+fQNohXvDuVhdLaseN1bhImeEY88b2Yyt972rYfJKBxFPA9XXVXI0XzuU2+5mVrDWDeB
	 lXmlUl4g3L6rWdrLh10tuwPY4gyI+OQfsZVF+Xg4YoOkORaPFxrwcFUpvZWdnSmiwd5QfqWV2SEb
	 eRoZ8dgSxxm+/ejnFfbORlNMoxLaM=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: xixiliguo <xixiliguo@foxmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	xixiliguo <xixiliguo@foxmail.com>
Subject: [PATCH iproute] ss: fix expired time format of timer
Date: Sat, 20 Jul 2024 23:23:27 +0800
X-OQ-MSGID: <20240720152327.47895-1-xixiliguo@foxmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When expired time of time-wait timer is less than or equal to 9 seconds,
as shown below, result that below 1 sec is incorrect.
Expect output should be show 9 seconds and 373 millisecond, but 9.373ms
mean only 9 millisecond and 373 microseconds

Before:
TIME-WAIT 0      0     ...    timer:(timewait,12sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,11sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,10sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,9.373ms,0)
TIME-WAIT 0      0     ...    timer:(timewait,8.679ms,0)
TIME-WAIT 0      0     ...    timer:(timewait,1.574ms,0)
TIME-WAIT 0      0     ...    timer:(timewait,954ms,0)
TIME-WAIT 0      0     ...    timer:(timewait,303ms,0)

After:
TIME-WAIT 0      0     ...    timer:(timewait,13sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,12sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,10sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,9.501sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,8.990sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,7.865sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,1.098sec,0)
TIME-WAIT 0      0     ...    timer:(timewait,476ms,0)

Signed-off-by: xixiliguo <xixiliguo@foxmail.com>
---
 misc/ss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 27f0f20d..620f4c8f 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -1516,7 +1516,7 @@ static const char *print_ms_timer(unsigned int timeout)
 		sprintf(buf+strlen(buf), "%d%s", secs, msecs ? "." : "sec");
 	}
 	if (msecs)
-		sprintf(buf+strlen(buf), "%03dms", msecs);
+		sprintf(buf+strlen(buf), "%03d%s", msecs, secs ? "sec" : "ms");
 	return buf;
 }
 
-- 
2.43.5


