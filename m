Return-Path: <netdev+bounces-163599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42470A2AE2F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0969D16AF17
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF281A3176;
	Thu,  6 Feb 2025 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="DitYfYLt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15905235359
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860701; cv=none; b=oFFaf05vfc6pMbL04Y1UHg3fEXieC3B1QttFugOoBZB4T45hWzIwuWZ3oagWvmwiMqNh6GG+5yvorL667sHyZSIf2sb4rGsCSH98EWVP5iQ9Wn1VMrzNVGUcB3xajBWY3t/53c+DgFRL4BQ655j2RO/OTeEd3KD0D5lNE4j3VVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860701; c=relaxed/simple;
	bh=C7uZAIgSKoTeGiTKDnQ7yxruXbSRF/2IFcjaFKrPEJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sap8O3YmIzPahGGHIDYDtAbtO5gp0o3UusQTh15emi00VN8JgP8tg+ZVRvahHdVasyvRrIV4REguTGKsTWOYCxEqAYY/ScMicJMqpYxhpIshU3AoZTRK7TDNRMaoaKAToHtd6Yu9Nzuvxi+o3O0FzOkjxJyf+wFUXjvLypUi3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=DitYfYLt; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-43616c12d72so1677405e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1738860698; x=1739465498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWLfxsZQyBwYG4PJltfCoD/xQYNBrAmXgMfWeDg+aUc=;
        b=DitYfYLtYMUNeNafqzAJh74Ak5ecjpo7kezgMJDwj81asYCFz1dEvRda4zKSCPL5AP
         FDeLDboMV3BL/a8u2FcsR2YsSpsYY4AZtU9f9OfZM+UU2ja8JxSqNkgJy2KKperazdg5
         nD+O7jnfWNMRfWR8yfUT5aXDBPqrWLqxCeRnGbQzdcTVwndu8PyP/ayhfk6ceDbEQsfD
         BhXgkFQGphC7lNsssMiCNfPyB0zVZvfyA4ZsUJdjPID4JI/YsFQqSzB62yJSpqyX+o7P
         16DPHAYezopdLCdesFClgIz2guHgMyNaUHG9fTCBEnf4t9wxzoaz2itrdHYwwvRUxcNl
         5PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738860698; x=1739465498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWLfxsZQyBwYG4PJltfCoD/xQYNBrAmXgMfWeDg+aUc=;
        b=VkPeZrJ/LqWE9palj5gEWVH1BhYfCdRXpgwqZAnz4tY3Fa1Ispk97GoQbWlAcH2myA
         CnkXS8lB6WowoF9hbfv3eZiSPEDFjm4I1Nh8MTdduPtPRGBKKXwh6ijXdINFF1omwwET
         i7+QS6q3hD7kQ0pj1DWB4nQs3s8T1oav32XZWcNXFIIx98jFjv9TF/jyuLCCsmwOb+/q
         BwlE+aUB74lAexZFX9/3UxXt2nxJ6MkM1BFADCoIj9Wyqc0lJFFWYSWwwb1PCilhxfn4
         HYVDvsVGT/gGOoeeofNhMq7PGru6IJIotBC0LUE+HEU45ZPHDNpJIqLKnCOL09dUhpEQ
         2VPA==
X-Gm-Message-State: AOJu0YyHkJX5lmPzLFhLPReZyI1avyzkeZ86GluMcTTpm77Cf04YnZ2O
	7nCt+YEjExbnQ1KYHODZxxyljIAW06Mx8bmWl4SD60X/NuME1zF/9JdMY+szXK6gJrdHwHnHTDU
	yeV99yW+3S/Vq/UH1gBLLw2tcCG9XyRMe
X-Gm-Gg: ASbGnctmPqry6tJ3t88+f880Z1t1LjyszMCuo3I3zhHHaO3sGWc7TztCTL7vte9P8RE
	pnd6nGCLfm8JnKxC8dfaCUemaRRDP2m/UorFPLfdLf0B8zzV/1cSI/SaWdZlzV5Re0pHgxO9CHM
	i377wvPKfsOxMLX+k7eMRU+2RqHw4EaEgFi5X0p9/hcCHGG5PIJpPglQZbq3hd2MLxCrVw3vrsk
	zIHHVmGtSjY+i4bkjD3gDDK/rma1+zfvEW5q67o5LiMJPxwK73+VRck7YniAkQBKQFfYiv7UiJy
	7VKo7K74xSxQqst9M9K46WzTHzVy86GFUZszhR3gOV6skpLDM0T8otOHqJku
X-Google-Smtp-Source: AGHT+IEl38lSUUQgvvCOUank03kf7DqPvH6MKe2hmtpbBvJRYwvExSdw4yu79kpQbRasXKgmsDcTME3XiOgB
X-Received: by 2002:a05:600c:4691:b0:436:fb10:d583 with SMTP id 5b1f17b1804b1-4392497ea09mr512405e9.2.1738860698069;
        Thu, 06 Feb 2025 08:51:38 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-38dbdd1b951sm42572f8f.1.2025.02.06.08.51.37;
        Thu, 06 Feb 2025 08:51:38 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id D636D1CD33;
	Thu,  6 Feb 2025 17:51:37 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tg56H-00CA07-KB; Thu, 06 Feb 2025 17:51:37 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net 2/2] net: enhance error message for 'netns local' iface
Date: Thu,  6 Feb 2025 17:50:27 +0100
Message-ID: <20250206165132.2898347-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current message is "Invalid argument". Let's help the user by
explaining the error.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/core/rtnetlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 5032e65b8faa..91b358bdfe5c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3024,8 +3024,12 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
 
 		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex);
-		if (err)
+		if (err) {
+			if (dev->netns_local)
+				NL_SET_ERR_MSG(extack,
+					       "The interface has the 'netns local' property");
 			goto errout;
+		}
 
 		status |= DO_SETLINK_MODIFIED;
 	}
-- 
2.47.1


