Return-Path: <netdev+bounces-68817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EBB848677
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 14:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DF4285FC1
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 13:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A55DF03;
	Sat,  3 Feb 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwKImRee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7DD5D918
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966179; cv=none; b=A+RJqKSbBa8UwTa4Qok4Hk7kJs3N5rraIFKtbQjflbHv9ZhMQmN5ebwAfXSIJbCBaXDnBADszRbfoHluYhpox+Pla5r2ysmzKUDUgQiybqznaU3QO/Jt028GMpUELITIlLIf9xxpJqKbATIGMl+Hit616vwYyBgfQ/EdIaDUMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966179; c=relaxed/simple;
	bh=SufO4SisrqdNuAdlQSD8f1+t+sqzLesB0pkVm3vdQLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eI9LaUDmfPXoLbRys75laOHNfgyq3VGWKWBlwBQtd0rOymauCDP9sxHvd4vyEsyeA5kqv5RkSwt8e4s5HIKXPqAeelJ/ABTde8STZqexYTLk/JaRpOU7X78Wf08LGQOAc4BoMGYGG7Frzj38hhliD+zvMjXFw6g7+j868PVZjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwKImRee; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fafae5532so25933465e9.1
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706966176; x=1707570976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jtjHJmf8NGfxI/AeQqH21JUkyak3vq/9nte9PtORp4=;
        b=fwKImRee3sn61UgRoX7Mc5rk9aBazrUMZsJeBUEB02rIgu6YH45ri5xtXuabB+wa2t
         XBAV8RFNtwF6r7Ng8cVqSBYYvnMyfQzHjW/fk705BqIbJK/baYhbDHqth90mMe5qEWGw
         gkhaixGp6nk1bFiof0G9dLgy+CQ6vrKxYmXQkgRkaGYJLisFhGbNWagEyC6wBhm/IJRD
         cql7eIupFyx1M3BJEhxVmzDvjQuO2jHmE8ewoKo12vh4BdNQIZpf/w0JzFfPNxkXxih2
         oo6TLYy76DmJv8rUG54RAe1K2VIab6ppNGhlJ5W3Nw+8D6JFnWDK1Co5V+/BZmSdvMqq
         2ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706966176; x=1707570976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jtjHJmf8NGfxI/AeQqH21JUkyak3vq/9nte9PtORp4=;
        b=g+c+eEhYr87VzYM1T5X7bFFsEZNvTRedRyIZxlEV8jquAXxZV9ZOEqugyIhIIaIyvw
         dGlAPEyWOiRizCk/QivbDwOk6kCkE6vOX4AilsR7qV8OIZ6jwl6EFJfwXHIIwXGh5f3p
         LTZJwpOntpwxhydb6REsQ8KKSCPYn9isi8cQCkP7S/NqKlBH62qxGQocy2nM++6amZ3K
         +Bz1Z5H3i3yF2EfbgtId7K+Baan4Bcf5OY5yusuPuTv8pYfaEARifawsF+6m92hjtlvm
         laRFYNJBtvf/rV+g/Xsh074VUq3/VGoqPRQigAg2KHF62WecDc3hNbgP7nAqAsTG/s5a
         BLHg==
X-Gm-Message-State: AOJu0YxOi9dRbLHwT0/pB/kJ7FKzHTmO/hvNwHYWnLogR1ToJJua06j0
	9oS0eABgTcDZpErHNPA/QoMKyBtwr02lJ32h/Xu5hCC9s1lXXL6a
X-Google-Smtp-Source: AGHT+IG72Zih5bY/2VGy40TD7eZeToDE9Nrc8IybRfk5Gd6s+2vc2w3VQd3W3FqDp7Cb8i+iP4TEBg==
X-Received: by 2002:adf:e7cc:0:b0:33b:287d:412c with SMTP id e12-20020adfe7cc000000b0033b287d412cmr1974182wrn.43.1706966176148;
        Sat, 03 Feb 2024 05:16:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1yfytZxAH8wy98zm1vv7f66Nxw4j5ol2AK+MfIvdA/poB9Mz0wkqU2zumXX8Kt6CFpXxkcP5T+fVxHByWbuPO0z2N9ejnr8zW9VkFQp6QD5mOM9PEh1Xb3wWPwc05qMmmFYVjxLYo8X9BGzlT4sZP1M6TLIqiu27lF5Cp+7itvimZANYJ1m/WXMsPHKQ+kdB3utlFMnTGCSM4kNNW76PXCyxgoxwZ6lH/LIBVVSpLjzZichm9slTzOX7dbe/YU/uhF4f12mgoohIYZh8+w1TUeEwRfR2zC1TPV9ApWdCJAwDQreB6VGSzf9Qc+ApnQ7Z1m0YqeMdgAfDRuCHVpHhBjg8AfUMvrw3l
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d554a000000b0033ad47d7b86sm4036456wrw.27.2024.02.03.05.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 05:16:15 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v4 net-next 2/3] doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
Date: Sat,  3 Feb 2024 14:16:52 +0100
Message-ID: <0ba5088ea715103a2bce83b12e2dcbdaa08da6ac.1706962013.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706962013.git.alessandromarcolini99@gmail.com>
References: <cover.1706962013.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add multi-attr attribute to tc-taprio-sched-entry to specify multiple
entries.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 4b21b00dbebe..324fa182cd14 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -3376,6 +3376,7 @@ attribute-sets:
         name: entry
         type: nest
         nested-attributes: tc-taprio-sched-entry
+        multi-attr: true
   -
     name: tc-taprio-sched-entry
     attributes:
-- 
2.43.0


