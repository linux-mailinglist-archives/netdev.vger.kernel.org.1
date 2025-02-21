Return-Path: <netdev+bounces-168628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5EDA3FDF1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019F5427545
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636424FBF7;
	Fri, 21 Feb 2025 17:51:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CDF36AF5;
	Fri, 21 Feb 2025 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160298; cv=none; b=KTE72FtX3NQjPi9V/pAMnLJBJdr1oSNDCxpbPWi1XSMeF/Ycw8iRTsYOkFTg+DpYYGqOMfg3cvNdGg3c5XcQT2FhGkC/dPmDkQEuR7o1jn5EGQZqcYcmzMp03rJwV3V3bPIPf7GZQZB/ZbcuThMfUuLE9/EjW5ZVkWgBzoUW3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160298; c=relaxed/simple;
	bh=y8JOWFlcKlRL/xItMQwGuALZ+brY3FmxUzxUvjwziu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WEdo0E2W39zXrADv8zJhIzuDW2KBZhtjWe/+akITTZ8QklMKubA818rw/mJW4kqKjTCSB6Xk8N/vmcQkwsuWA07BCEesKILY9wc5VUS/QYkLLElxMLPPi7/BP534Ae3geh6KMcV+EfcB+159Jc8Nn/pRVMhWC7FgY8T/KxMnbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso420850266b.1;
        Fri, 21 Feb 2025 09:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740160295; x=1740765095;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+9QldxJW0IqP6a4oCK6OLGUXE4hkp56gGwvn/eRJp4=;
        b=KgeLHQpCsRHMk+d3PGqKvut8kBv1v0TGj3hKVdb8BMbDAS1e0GJmkxG2IkfmwTVHQT
         MYgSccesgUb5NWIosLdUl/dCsIMTwHPO44e3DzrmFYI/yWiv0/fC2ylOK4bEQAoAuTF8
         PyUw+c1y205ePEWgZJL+mehxzsSVvuT/KJbuvVJHsD3kr0uDwpZ4FYdf5dlB+mKZvlVu
         3PoWV/rUJ1zqS0a4QCaV2IxPA1Xed5wD2MJg97GzYqGQjYYDl2oCYyio7/3/65R3Sr1r
         /CwO/bZnPbXdMUq2uV7qg9rpexoeaSDcXkoe7GErcilqRWo2RTB3mLMLDWIEAzVyyS11
         fWcw==
X-Forwarded-Encrypted: i=1; AJvYcCULfN0iVPGIpwoZkKck8JZFifxZi9iOe4iLHpV973T3QmAQY1FQVZqmh5bLs0DRr1eEznKohbegPvU12Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDLADsReT+zI7bAOXV/CskGE4uDQOyY7tYRH+0K5h2dGRLcIj
	ltQoARRiRQftGh+9Z9MbQyZZIbWIZbPmsuhklUz+w/0v1Add5Me+
X-Gm-Gg: ASbGncu/nfbucCtzmVyrl61onI8JGEVxUSNWlKp/+TPJHNjMFfCbwbhK6Wr1i7tb0jA
	Y+hC56ki/GwQKDdUE/bNPTnMZyU8NNg4Yqj9z8yxdkkrVY//lrvTQGVD31wUxgd/doN1LsUi4+i
	FVRRPR58FJpIfsYvTgm3E43Pd+HkDsg2iqYXVDPyi3ZA1FmDkdZ1bfu5lFIUMqRfJ/MoyaRCRvs
	c4Nip3s4kHRJrGFQM2lKFQ4HQiQZkoIJ+MUU1pT9zK+1YEukL2PZXQDewxNSFbb2GhbioG2OdBA
	yL6TW56yfbIGtA+W
X-Google-Smtp-Source: AGHT+IGYLJh7w1anpQnxC4OGPpeD5+o88IWTi19oeIwm0m7RMhONixihj+fm9H0mSYLLGRLcJOebVQ==
X-Received: by 2002:a17:907:d2a:b0:ab7:fc9a:28e1 with SMTP id a640c23a62f3a-abc0de5a487mr400273066b.52.1740160294328;
        Fri, 21 Feb 2025 09:51:34 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9faab9f1sm954428266b.49.2025.02.21.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:51:33 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Feb 2025 09:51:27 -0800
Subject: [PATCH net-next] net: Remove shadow variable in netdev_run_todo()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-netcons_fix_shadow-v1-1-dee20c8658dd@debian.org>
X-B4-Tracking: v=1; b=H4sIAB69uGcC/x3MQQqDMBAF0KuEvzaQDNS2uUopInGss5mUTGgD4
 t0F3wHeDuMqbEhuR+WfmBRFcnFwyNusH/ayIDlQoFsgil655aI2rdIn2+al/D3TGO55fFCkJwa
 Hb+VV+pW+oNy8cm94H8cJP+e0pW4AAAA=
X-Change-ID: 20250221-netcons_fix_shadow-e2607c682129
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=leitao@debian.org;
 h=from:subject:message-id; bh=y8JOWFlcKlRL/xItMQwGuALZ+brY3FmxUzxUvjwziu4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnuL0keDLdEUqOMqti3Ip7Ok7dZB4VTvINdySSK
 vU0SccifXeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7i9JAAKCRA1o5Of/Hh3
 bS9ID/49ZmHa4XYMc2QOk+FBzngsRBTzHh7YZE74Ros/HsqhI3dDEEr1junleOxCeTp94GRv/t/
 llSzo3u43FBhqhTpa2lCMSGOwprFs0hEumzZdM7c1+I+MIQQXGjJq90XCQ1ileaoGuP8Nt8NZo2
 htSGS75cSt4KeaTrR1jVBAGHDze3NbQdjcQsQnSbF2J7L1pXwKoOgIerWWYwv1W5d1BiqxOBrNt
 wuqk/h/Mmtffk1m1pjsC+llzb009cTjaL5g55IBR6e4wYg579RBIt4uwlEbJAd89+Z57U2sRWtD
 IVAEcEvlBskcvjZfrROKXEm3HGxGj0qVOC29WVppVFfvpQ17ikd2FGhgVn2w9bEkv4BPFRq2PdR
 9EyT/7uaIc575JiJPzAFCFGmwfYlDufqweSt+VDlbIdQTKT03mDuWsNMU6AvpbJEh3v+jsrIaqN
 C3nx7p9w/bgm1tpTpUs62kVr1gTswwxB7K07gqIxnpMLC5NFa/jmlgDLKaodhpLAySDRbATdi/E
 Fvk6NsEwiYZ3VfecH4gNnKYBRNkBAuYYnPCVh3JGsxdrXzQvwJSDhd9+YiQf+1FkFG+tz8XW2nM
 /fx4Tnuc2Z+zVcPdLR+5c302nYP2CGTnjCv5aBhJbZ3AtT/dhgepsh3hL7sZbaZ+AvNQSM/n8G6
 vPrgnf+4wreS+HQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a shadow variable warning in net/core/dev.c when compiled with
CONFIG_LOCKDEP enabled. The warning occurs because 'dev' is redeclared
inside the while loop, shadowing the outer scope declaration.

	net/core/dev.c:11211:22: warning: declaration shadows a local variable [-Wshadow]
		struct net_device *dev = list_first_entry(&unlink_list,

	net/core/dev.c:11202:21: note: previous declaration is here
		struct net_device *dev, *tmp;

Remove the redundant declaration since the variable is already defined
in the outer scope and will be overwritten in the subsequent
list_for_each_entry_safe() loop anyway.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Sending this against `net-next` and not using "Fixes:" tag since I don't
think we want this to be backported to stable tree.
---
 net/core/dev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 18064be6cf3e3ae0949722a4ffffdc25fdd16b2e..c36b9b05364bab117ce51f3cc6ea5839245fd182 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11208,9 +11208,8 @@ void netdev_run_todo(void)
 	list_replace_init(&net_unlink_list, &unlink_list);
 
 	while (!list_empty(&unlink_list)) {
-		struct net_device *dev = list_first_entry(&unlink_list,
-							  struct net_device,
-							  unlink_list);
+		dev = list_first_entry(&unlink_list, struct net_device,
+				       unlink_list);
 		list_del_init(&dev->unlink_list);
 		dev->nested_level = dev->lower_level - 1;
 	}

---
base-commit: bb3bb6c92e5719c0f5d7adb9d34db7e76705ac33
change-id: 20250221-netcons_fix_shadow-e2607c682129

Best regards,
-- 
Breno Leitao <leitao@debian.org>


