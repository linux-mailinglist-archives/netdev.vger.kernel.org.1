Return-Path: <netdev+bounces-83853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B1F89493C
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5F8B20D29
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 02:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381FCDDA9;
	Tue,  2 Apr 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yusuke.pub header.i=@yusuke.pub header.b="VN6RoUyK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8308F7D
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024189; cv=none; b=u3uuBFZ9aQg0nKUS/dhdQjlCjhVw9Aac6mhl0DUJeEE6g5du3idmJlBayxCCF+dGF34fxoM4CvQm2EzeXPMWxBgK17nGInEgxESdsBqfdDQ4VJ61vPlpMaB5JD0x6DJylL683tmpuSME0jEL0Zlz7ne91eu74YqSfv2G4LvYvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024189; c=relaxed/simple;
	bh=HGojBAfZ/kVaEw/jsx5X9Idsci7dXsMzQBtLRNfaU60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnR70PNVqHqfXfmS10AU1YkbLsoxab01+gNQGfGW/C3UYUVKPkX2iPzWv0gX+GQN+pKnmIVI0a/JifFqtXjIQKldzffvUs6MZBeQs+9NUNT8plpLMlrgCBOhUYjFxa5r7lH6KrcgX3giGyIt5t7KN6gmDmtsEZjnpCE5eMTUVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yusuke.pub; spf=pass smtp.mailfrom=yusuke.pub; dkim=pass (2048-bit key) header.d=yusuke.pub header.i=@yusuke.pub header.b=VN6RoUyK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yusuke.pub
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yusuke.pub
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e2232e30f4so33300225ad.2
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 19:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yusuke.pub; s=google; t=1712024186; x=1712628986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bhsYmO2kyE8uMpg/pH2YO0VgDaC7NWwsX99551gZjc=;
        b=VN6RoUyK7+7B7lRNX3Ib1ZLMHNSRvTA7GQHoatbcNQ8MKdhwmEYwZJqGrziO/bBESo
         TobFet2ntd3l8XiaU0fIdnbJhhHOgabUzyDJBEXTuVfLAAIDPYtSbzq/OcvUKFbUJm/o
         bt6siqrrdnZeccz5CKlrkDx0TzjDlTtq57y+xAHdzbNQDEQy7Mjs1VzSJ8tpatpDK1cr
         WMqhlcQl5gxGje97KlP5+PHPkcPOIEZ+A7cXTdiGA0N289TlcnGTUH6DTKE52XDStnQd
         c574WT+F30Dh6zX0aJ0YQj6w4wYQZowt/G+4ayZEOhMq5ITax+dVDCLIq+LSe9pXTPmG
         U6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712024186; x=1712628986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bhsYmO2kyE8uMpg/pH2YO0VgDaC7NWwsX99551gZjc=;
        b=G4C7pBlQ7RH8IAxTBpUZQgoknPU+s6sZJGXMQdsJE3ve9ny8PNiVvTHGTtMxyxP1Qo
         lDuuPC+9JOaBctjAtjkRGPFa9Is8KL3pkDfXC3uPS6dcbPdbOMaHPRi2bHTOXVIrDb1l
         67BkZTgFHxKJt6fQltymAu8gWJaDppmMbhWKdhT3fXOKnzm9UtDAlF5e5Nlcf+4ivoR0
         Q39FrxSrP+IFWqBmxDORyxgJDzmYwDt3ES15T5IJZA0k/H1PiKM73lq4P9rRWlWv+oLL
         iiPyYGgCFfoa0hPvfH9j5Yw8ldkWJCsDg9OxDJzilFcL4oAkJvAXRiEih1An9tPJ6Zsn
         4xLw==
X-Gm-Message-State: AOJu0Ywftny8v9q5fxV7zoN5kUXrK6jqGzP1zZTRWzP31HpB1wEgNiXl
	RJvfowoAVoC5Ooic6qzH/0paKrWCCbJQejN93ltlNvmF2ynZXMYNtp6j/NVuB2JGyH0Ev9e73pm
	3XRI=
X-Google-Smtp-Source: AGHT+IEpXGNcGIWP6Evez0p/ewdNFChuzKaIbDutAd0+dt6UwzIOPRMwTsCmAnmZVBkk091RJvWLuA==
X-Received: by 2002:a17:902:b18a:b0:1e0:2a5f:d1d6 with SMTP id s10-20020a170902b18a00b001e02a5fd1d6mr10123832plr.63.1712024185849;
        Mon, 01 Apr 2024 19:16:25 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:d88:2800:e9c6:ca83:6c5c:a180])
        by smtp.googlemail.com with ESMTPSA id p2-20020a1709026b8200b001dc05535632sm9699654plk.170.2024.04.01.19.16.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Apr 2024 19:16:25 -0700 (PDT)
From: Yusuke Ichiki <public@yusuke.pub>
To: netdev@vger.kernel.org
Cc: Matteo Croce <mcroce@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Yusuke Ichiki <public@yusuke.pub>
Subject: [PATCH iproute2] man: fix brief explanation of `ip netns attach NAME PID`
Date: Tue,  2 Apr 2024 11:08:17 +0900
Message-ID: <20240402020819.28433-3-public@yusuke.pub>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the explanation as it was duplicated with that of
`ip netns add NAME`.

Signed-off-by: Yusuke Ichiki <public@yusuke.pub>
---
 man/man8/ip-netns.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/ip-netns.8.in b/man/man8/ip-netns.8.in
index 2911bdd3..2e12e28b 100644
--- a/man/man8/ip-netns.8.in
+++ b/man/man8/ip-netns.8.in
@@ -98,7 +98,7 @@ If NAME is available in @NETNS_RUN_DIR@ this command creates a new
 network namespace and assigns NAME.
 
 .TP
-.B ip netns attach NAME PID - create a new named network namespace
+.B ip netns attach NAME PID - assign a name to the network namespace of the process
 .sp
 If NAME is available in @NETNS_RUN_DIR@ this command attaches the network
 namespace of the process PID to NAME as if it were created with ip netns.
-- 
2.44.0


