Return-Path: <netdev+bounces-112332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4659385A5
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 19:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98EA01F21191
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D51EA87;
	Sun, 21 Jul 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaUQOpuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAA1667F1;
	Sun, 21 Jul 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721582610; cv=none; b=TLBjhwV5lrm5IfXGnrPMUiS9AJMeK/MV3NK0Wbl461JkCV0GTgUIxTaNw2are0aCkFNzNVAO0oViS+nNkyDsfm0L6CamndrBEyj5C0Im6LLOR8WqaBnm/AhtNx4B9YndIxJhZpltlUQkUrNCUbFuwWpntLB1pmehr9RKgybucUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721582610; c=relaxed/simple;
	bh=VUZ8A/kARfT+rAtWFJZkkrFOSkZKjYbiOW8tF4J2nqo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kw1TISa3JzJJNZjXsqMWgvHv6pMJP8nSINwimKGFQklnRdK73NiyYh7RX+Kvhr8LWwIeql+6+k2hXUWswwiWFVQTCQPiS+16rFe/3deLf1Dfas10zlhBq7p40q8WL++i8h3ReUwgw5hi22nfGM/QgABGiaFS2k27Ja+RRJO3Lbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaUQOpuV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc5549788eso27651355ad.1;
        Sun, 21 Jul 2024 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721582609; x=1722187409; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kLcYlZG3l6zH/0/5cJ0EZkJcj402oMLxEGpzLKtlLs=;
        b=EaUQOpuVWN7fte9wmHxAZa943wxypU7/wtw7p+JuvER/D6cjFnbWl/ih6yfU/g7kyZ
         R2iwqrFQ0XJ+sB4w258CL50q1KUvSsDwv3lNcUjkzWpxNOjqm7VkbNyjMQ6Q1IgoA84m
         XXVzStb7pfa554WAfdA99sW8c32nLM3wTDIx2hEB+4kJAEukXRRdHDwpvRPez9D0/Bxw
         KOF+ParCLiMZ5jtr5Q2DPWMJ78AoMI0poUK4/IfYlmqi+Zuh4s37z1g1NSPHENrPRrBC
         RqzBLQbtCw+aXyVjBWXhsN1930RLPYzXxj9ykvraYX59acxT3/hpl0U4nKGIOgEtXoSa
         ow0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721582609; x=1722187409;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2kLcYlZG3l6zH/0/5cJ0EZkJcj402oMLxEGpzLKtlLs=;
        b=cfOl9knXrxUrYo6f9Ao0Ck2VwrdL6vWEXc17FpRR41cniGiNtpwrY3v30gOmR3lRKh
         z5EdGjN0MnWOzh/m2SRZszgiNRJLH2PuqkZIImo5lBChoTOND6jn+HXj5RvcgxlYsCqT
         Hj5OSNRZfHsvTQmPVNdpfUQ1mxVA4Q0Mx0SRFT9jTrOS2nyCy9RA8aONLZTppLDPR0BX
         xsI3Owg6/K0hR+LY7/TwKn4x+Qerfc4yA0zt8ZCI49ECjcmSXPHncvc1yB8SsApY+dwj
         tGlxQXLjAD0Tm/TYUs4MJvgNPcfkTl9YNLVtG88nhz8L8RU6PBewUJg5ezlsFogfST0O
         EWvg==
X-Gm-Message-State: AOJu0Yz1HG7WDWnu6k1qXpbxNQf48tQYQTsXkBHeltUp/lmNi0zxK+4i
	rfghYlhmT/JrfJjtvDXUgFAz/BQbZXZ4+gcNCFs0B4c5NFZZ2G0FN5n+UkMq
X-Google-Smtp-Source: AGHT+IGzV6W4YR/MTqyyjIWevROU3wdAPIVMS8zIIlC7mC6MvRhkbnRLIYPX7fGP3dosTsp37NQRWA==
X-Received: by 2002:a17:902:e74e:b0:1fc:7309:9125 with SMTP id d9443c01a7336-1fd745875d1mr50549315ad.34.1721582608568;
        Sun, 21 Jul 2024 10:23:28 -0700 (PDT)
Received: from [10.0.4.4] ([50.35.97.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f4647f5sm38750535ad.252.2024.07.21.10.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 10:23:28 -0700 (PDT)
Message-ID: <51dec0ed-7100-43d5-83c1-e465ec08462f@gmail.com>
Date: Sun, 21 Jul 2024 10:23:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
From: Jay Vosburgh <j.vosburgh@gmail.com>
Subject: [PATCH] MAINTAINERS: Update bonding entry
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


	Update my email address, clarify support status, and delete the
web site that hasn't been used in a long time.

Signed-off-by: Jay Vosburgh <j.vosburgh@gmail.com>

---
  MAINTAINERS | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0f28278e504..bad94cfb7e70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3810,11 +3810,10 @@ F:	include/net/bluetooth/
  F:	net/bluetooth/

  BONDING DRIVER
-M:	Jay Vosburgh <j.vosburgh@gmail.com>
+M:	Jay Vosburgh <jv@jvosburgh.net>
  M:	Andy Gospodarek <andy@greyhouse.net>
  L:	netdev@vger.kernel.org
-S:	Supported
-W:	http://sourceforge.net/projects/bonding/
+S:	Maintained
  F:	Documentation/networking/bonding.rst
  F:	drivers/net/bonding/
  F:	include/net/bond*
-- 
2.25.1

