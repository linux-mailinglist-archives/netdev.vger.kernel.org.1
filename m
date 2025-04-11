Return-Path: <netdev+bounces-181709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A116A863E6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1ECE1B627B3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A52236EB;
	Fri, 11 Apr 2025 17:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D570221FB8;
	Fri, 11 Apr 2025 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390878; cv=none; b=RIwPshYqY1aAokDF7tSCtb8sBI3cTFIIImRPB7983eHNelcFyRwIHWI0oX1l5tV+oaNjXUd5ePM3Igwnw+TVPNfNVOHT+CdItmni1Gkwrtti/wasfx50dP/hjc3u+SAf5m3SLhDXkkm17LijjYnZifll5HZd3TfUca9IBnBHdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390878; c=relaxed/simple;
	bh=gHJ3bSUsNw2+03fX44wo5CdaZHCsae1EVtBp+WMaMGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nla5QgjgiJPQHv7xhQ+/7YIkAGMWWPSLhZq+oMJSpNyFUGxsHCQRbjtGqZwn4X6KU7Sj8//VYVnVZjj24OnwmVpYNpJJARIPJmkG2M6O2dhmjU8wBvQiuI19HEeuZbJILZlS8p+lAL5QF23rNKgDUUtt1VOBbAR6DBXBXepRvJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso4015998a12.3;
        Fri, 11 Apr 2025 10:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390873; x=1744995673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjDYrHY5UwENbrmtSlOetx7xyOap0e/fxOAuqxRiP5M=;
        b=wIvbakcjnNDp6GTN40+LZ24uor4lqWzADRYeP9TwsBHCR/4bgLCXzDeG57JR+ZoQEg
         JQsIvRKLmCSx1aF0a/7cP8U8+GgWdcx8W+fqhCuGcxNhFnBhgDQBls1IscMXtgyJrk40
         wyReLPsC9Mc1VrxGbtJpN3gcknmhhftBHnmg8wfM3tT384e6Qx8OgFV5SjheAFbFLsD6
         gEGAI2vUB/2UcwYmIiQ3A3CfKpLqL5zo97h0fY4nQDMTPcARM0gDTqekFfzCMMhw2kj7
         wedN/2M+lhhsZxGSOcFDwGjp5bRmCyAxgprlzbWdivftH3UOoHtdhAoTI/a2ATuCY4KC
         Qk/w==
X-Forwarded-Encrypted: i=1; AJvYcCXRnWKD+b8vPBm0Pr05KsVp6btJuR7mIO3bLw8JOsW4oGwElTyYSeuHe1HmOD3PJlFNEMKKcyqg6oVp1s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynKLK+iY+TPFBV1rdpG1EUS6K4ntTJlby1RtqmV4HhNWRe0V2X
	qvATRvZEE1XN1DhQu+Z/cE0XiM66uqisjfSqa4S6bijJkQXIujku
X-Gm-Gg: ASbGnctMrKSeqJp0pcAeOQsLGAR7tLvn6pkXI/p0C61WXjZpNQeWATJEyiUE2/FfaHX
	t/BNIUWwuMHLr7TsnJTIBbBU9lXUa3FVo9f47lPcgjUc1jRyPP7gEx9N8LKR1MuY+guWCzC/6JO
	7bQ/9kUfS6FMGtevTvkFSAsh2iE4owkTHrYiEpD5949B8o5zKjxNe7vGZzg6KqVxCQQNmxX1pBr
	tB2xOe3MS458QRs3w4+z8PrsPS0h4BumTa8NyRyg1J8ZlpE/gn0m0bIIob07SEcBF/JZWsByk8D
	yhGB46tQQjmK8bPYdLeRvZxuf3fDUO/W
X-Google-Smtp-Source: AGHT+IFoCRRFXyLMCddkfC5BWH1HgAoI1FkX7SZQj5v/B4EHfAEHRh1aIRh88BNMEGYdnTAhvm89BQ==
X-Received: by 2002:a17:906:6a12:b0:ac3:9587:f2ac with SMTP id a640c23a62f3a-acad352b7fdmr363835766b.33.1744390873165;
        Fri, 11 Apr 2025 10:01:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb3fcdsm474541966b.107.2025.04.11.10.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:49 -0700
Subject: [PATCH net-next 2/9] neighbour: Use nlmsg_payload in
 neightbl_valid_dump_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-nlmsg-v1-2-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
In-Reply-To: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=leitao@debian.org;
 h=from:subject:message-id; bh=gHJ3bSUsNw2+03fX44wo5CdaZHCsae1EVtBp+WMaMGA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrTdyBO+OUHDEbodYu7vr1zFIBpr/VNViQzS
 ocuoPCyaLmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK0wAKCRA1o5Of/Hh3
 bRd6D/4rqszsYbQQ5l/EPBDNUp6j2U4JuiyXHjzxx0WQaosGY+icZBEsIeifzrDlFeAa8kYhkap
 dftAjysdTZ1PlxCDroMpNuDXKWlSJPiVk2NGs99D1jgTOrlZGOhKadl82AC+QbgeULmZhZ6h8Dc
 WkLPElbBDQThrH5H7Lc8U6W1uuKYEqxZtigoUo9js9V6fY11N5IefuY66YaXUt2/ANTrz5fquac
 rGmmI3oJ2gkx8m1PQIJ5/ipj5Trv37foj+8q1MxeFNI9/8Jx8eAr3h6fWpT8mbJyfBbG1aKl0yb
 LmcK2kDZNJUVMBxAwcFVXoY4Mrqk1Zt2C3qBykcdHCxNfdTwbgFB+SJCL99X7awpP7jpurtwlCI
 eN6aM097l7nuD9Ut9kX9kzQt5IIlokri+49GtTSpDQ3QSaIqlNeVpc4JID+0QwBrrl7PlBMVXtR
 aKqWpDm+uLo/MroyZ2kdXBGwNSSIi5kXyhagYWMPwMWW47d8D0iiJNt2pMR4/7apclmGoJN3kyC
 JIfq8wCxCNkV9JrYtIRxq1hQ9JEuQp8e+oSyyVYXSdFIENiRvPK/2oEleTo1uQe45eORsWvcEOX
 +j1ZTlolt0T/8/EvmPK7DTDOiVUTUFatU2ufYvtjAfTlkmHsY5VPk6ipJJr3P8pfffaOe2fdP4h
 miDUWqoTdar2oXQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Update neightbl_valid_dump_info function to utilize the new
nlmsg_payload() helper function.

This change improves code clarity and safety by ensuring that the
Netlink message payload is properly validated before accessing its data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index a07249b59ae1e..b6bc4836c6e45 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2430,12 +2430,12 @@ static int neightbl_valid_dump_info(const struct nlmsghdr *nlh,
 {
 	struct ndtmsg *ndtm;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ndtm))) {
+	ndtm = nlmsg_payload(nlh, sizeof(*ndtm));
+	if (!ndtm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for neighbor table dump request");
 		return -EINVAL;
 	}
 
-	ndtm = nlmsg_data(nlh);
 	if (ndtm->ndtm_pad1  || ndtm->ndtm_pad2) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for neighbor table dump request");
 		return -EINVAL;

-- 
2.47.1


