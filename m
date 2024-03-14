Return-Path: <netdev+bounces-79866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB387BCA7
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 13:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA6D281FDB
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459A76F53E;
	Thu, 14 Mar 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIDZDitp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48D6F50F
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418853; cv=none; b=QR1Qy8sfflJ+YyFcSRPzgGZyQ57eTtunwnlbl8iMmY8B7vXXUGumu8qVSf5rv8+F+aPW0DD8rZ4zY/hP5rQfnklg/EQhY89jadM2bE1JcUkl2h+LLEXruFvG6KwOepsoJnGDyLibB3TdXSuTNaQ4LoBsPwRHmYzJFICarQ+w0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418853; c=relaxed/simple;
	bh=kgLPRbes/esgGqKulNuuuS/LHdMvrus0zdxqg/j9628=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gQmDJB2doF82nQIzVpU5JTT0yJ8VnF6y1dvk2XJ4i4v86FpxPAOL1UFV8qzCNzaGAHghj83OXHAsuy1vHO7ABM07ouXfvlfYArSOnXxkul8vv1nwiZ2kWsIeK9S1T2n4s4f0Gy5ER6hDVuiCqtIA8KuuDxLIYAtdE6KePlNiIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIDZDitp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso340945e87.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710418849; x=1711023649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=coptFJTkWoMsdJwPTovlU2GK/ve8AhWveR5JVL9/UQo=;
        b=ZIDZDitpJuhQ2aK7YF4SsKpu6spsw9kiNna59v4x9+0CSfWobGeWkILs+sC6XdtUaR
         wR40q9EmMbUvHAKDqOEyifk42OAfXPgi3qgbwCnBo86phQTlpT4JxGw6cPzv0FlX3SFa
         imdIwoxg5iTKKyaU+2FRjtvZb8ExUBqeIhtPvPdg+w10hVKhxG24yLH11uFvBJ1gN53R
         yOKYe822dc1SxxgrPbro18pEaAifB01IpZubgISoMf5E/4vpcyPyx+080uD+LKG/aFyO
         BmI3KRObi4VYhSH8CjwfIjORVrmV6lFxq7rYOm8M2XSapdAYMPnAh8xOatRLUL8c5BsL
         cJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710418849; x=1711023649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=coptFJTkWoMsdJwPTovlU2GK/ve8AhWveR5JVL9/UQo=;
        b=ULP/tYoOQiF6ExxSLmWkexQPCs6F/PtlGhi8hJ/cbvHLt/gB5vMq9OoZYXYf3GUSBw
         buSKx/MQm3Joi95Zh36yxY9cD29NxwtnoFc+aQtnGO1jm+eppPufCNpOjX3DmuHw9lOd
         HSEhNk1cE6Fm1TYud8R8B+jXCkEtFbLGeMpfyidPbDOyrs6DSGTPjoEfNexfrt6nRIk/
         fJD+d+dDWMeYFh7il8AE670BBNN03jjKtYqPZUurZC8cRxA2UcP+Rn+eoIkVLjxBLXIa
         YeFCc7mHq1l4T5KCCRmdfLAquhV2I6xOa0klN4QQe5wcjQiKLGHx/G1JN3gCP9z91881
         eIFg==
X-Gm-Message-State: AOJu0YykNNVbTeW/ed4C+FMOSA3iCVfpEkk9ONiPoPWewLPrgUpnTAEN
	x39PR9RBK0fB6nek+E4TMtdawb6mmSXZhPIv1zskRhZRX4N9AOz+
X-Google-Smtp-Source: AGHT+IFj/rIZbndTnKH2OzpoqKGKgzObJ6wSrAvhi6WB3fO3+czKhqvqEvrWQkG00rs5y+d2EMOcyw==
X-Received: by 2002:a19:e058:0:b0:513:c27e:4aec with SMTP id g24-20020a19e058000000b00513c27e4aecmr753918lfj.6.1710418849127;
        Thu, 14 Mar 2024 05:20:49 -0700 (PDT)
Received: from localhost.localdomain ([83.217.201.225])
        by smtp.gmail.com with ESMTPSA id i30-20020ac25b5e000000b00513ccb6e086sm251138lfp.38.2024.03.14.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:20:47 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2] ifstat: handle strdup return value
Date: Thu, 14 Mar 2024 08:20:40 -0400
Message-Id: <20240314122040.4644-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_nlmsg_extended missing the check as it's done
in get_nlmsg

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 685e66c9..f94b11bc 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -140,6 +140,11 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
 
 	n->ifindex = ifsm->ifindex;
 	n->name = strdup(ll_index_to_name(ifsm->ifindex));
+	if (!n->name) {
+		free(n);
+		errno = ENOMEM;
+		return -1;
+	}
 
 	if (sub_type == NO_SUB_TYPE) {
 		memcpy(&n->val, RTA_DATA(tb[filter_type]), sizeof(n->val));
-- 
2.30.2


