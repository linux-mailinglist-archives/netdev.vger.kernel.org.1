Return-Path: <netdev+bounces-202745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D23DAEECE2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 05:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E110B17F4D9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5A2253AE;
	Tue,  1 Jul 2025 03:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpx/354K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2571E3775;
	Tue,  1 Jul 2025 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339595; cv=none; b=FfWDo5veUZx8oJJMszjix62NJI3G+KPxofK5y1yVagQ02t2NpxXj6kAQ0gmVaDevxAF/LqB0UFfHCLddjOh/nWUPPDvSFbvJczQ4AkAlJnMK0DdtmWQX2ei3t4/+yN92Uw4vswQ1ISwAKFkkSddJ3FS2FUVQ2byNwZt52/1C+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339595; c=relaxed/simple;
	bh=tt4xPwThColuT0sWgTtJnspBQawlBFXF7CVILAZJ2Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXg6xu1TWSH/R1qccIBqfwvqWBa+4nmx7KuaR384vJZtf/cRIfFg4YmSjXvP4OFYat7pzwMraaIC9jW8v0CNPnwyejtDDRIjZTf0++nEgIhGwbgBBkD3Wcz9n48aaMf3AD4hrXM82m3k97Qose5aldTMKYbTWcj4tDPk9DFovzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpx/354K; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2fd091f826so4503338a12.1;
        Mon, 30 Jun 2025 20:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751339593; x=1751944393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyWb1ImwLrAx81v7mjCYlqpwND105yRaO7PKd9BUXDc=;
        b=bpx/354Kv/hTvcz1wCKeYfmDuGb4jbXT2d8a+SC9L4ntdq7q3KiCQe++RJv2IjW7Ak
         G5Be3Tf6h6m2eOIq6qd89/ahlGKFiQuCjxLRpQcyV/u5ibg8pHMsMxcoc7Q0D7NrkZWl
         wxY1xCsZpI1SJq8+zXUQ0LZ/xemJnw6TkVEEe2gTpiKzltA30uVdjqz1eAbxyyg/I01i
         8hlZq8RW+qjNzTI98p6NGAR6NJLNQVJWypD0UkWzdW0nMhyuB3Jg0yoBZyVE8KltTFnz
         G0QxdmMiLnqG1O9aeuLbrsVlP5V4OGYiSciz5OH7EV+294DKcGo7yidRfe3qVASkaOP4
         RdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751339593; x=1751944393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyWb1ImwLrAx81v7mjCYlqpwND105yRaO7PKd9BUXDc=;
        b=vB8DPh4cLyczmvfxqHodzwZnfhKGBStYodmA5CN5X276k23Ronu6VR+LVOwgiPvEjp
         KOuQyYtgbiNCu1gtKVkXcNUoQIRCLMlxWJlN8taqD+UHOqnTkuOXjkztcQtpwKPgplMe
         jMuaOOtXIMFtwAA+XxUiwg50etolpxInCc+uXabg0dD8y2YsAINwe3Tyumy3/meYxxtL
         qH3RPncAJUFk+jnTLxwhUiO0QuOPSmz12uZE/hjChBFYw62U3hUlnJs/V2jQi1yfU1N9
         BnqTe1kEHQJMNbAcKYc+sZQyzNjgKDOaEBSro2a+EgyUierhp0UMh/9vkCWdOe5qdrQp
         1OFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPYEfvotXp8TyTfVOOVluaQj0tdkpd44qQL15ycmghJtkDF9IMcO8f++gOvUKCXVBTK3fwyQs5YAo=@vger.kernel.org, AJvYcCUQjn3WVucGW4iXW3DVo3Y7iy+M93exuzvfUbRYD4RJ4OEx73iTJmV2hRa26n26WcH6nP5ItNJ+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbi88b3I2eY92jWOBabUf5gVMIjlLsp8Z6mpmDiRhq8vh6Djkn
	jo8YeacAmcay87xtq6lfBZlHhfTTEEoH4AjmPVKa2OgVoCd32A1czvxh
X-Gm-Gg: ASbGncvum+nTE3JD9GZghSUotUWjtlnYuIcj5RmkZyLc8qeLEJ7x7aJHsPPU3hvPx3A
	cTD1Jz4aCMuNpwv89fkOCq1W/1HeuedemMhySljHFyOvGt/tLeuRqQbQxwh+A8V/Lsh/nCaEoNv
	2eMIgQB1/THr4dmotLHfhwHUiPjyW4yh2SH5oIetDp3Rgqj2SXBVVsLlhSdvfP4jgWksl8HIlJK
	b0KZ0mi6b7NJmbP25TJurd0OQs04wZRB7sCIsEqUj/Sdqf4drOOl3c8wk9AeQf7gFXWC6T/i00Q
	qqxHZtpcH50VjcG01HZK5vPU41znNnCBrBU1Yj0BJiq9h6VBhoAcctiE8jI+PA==
X-Google-Smtp-Source: AGHT+IEiudH6PlCzTDc0Wb1Pnkx08WHWvxpm/tc7SoxOcDxOliP4sy/UBldpzX8Ue5Iw9mAMstE6aw==
X-Received: by 2002:a17:903:b4e:b0:234:595d:a58e with SMTP id d9443c01a7336-23b355b357dmr30496235ad.25.1751339593303;
        Mon, 30 Jun 2025 20:13:13 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31c39fbsm9385138a12.42.2025.06.30.20.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:13:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EFCC4420A82B; Tue, 01 Jul 2025 10:13:03 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 5/5] net: ip-sysctl: Add link to SCTP IPv4 scoping draft
Date: Tue,  1 Jul 2025 10:13:00 +0700
Message-ID: <20250701031300.19088-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701031300.19088-1-bagasdotme@gmail.com>
References: <20250701031300.19088-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=bagasdotme@gmail.com; h=from:subject; bh=tt4xPwThColuT0sWgTtJnspBQawlBFXF7CVILAZJ2Os=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnJ/seEnfrT+NeurpAzm7cqZmdq6FOHO0sfS5U9KM9Yw vz++PxrHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiI1iVGhh2ee3XeB3ZsT4hi uGsqHcW95NvaTNOalDD1nJaH5a9YCxj+Jx86Oe0F9x+dpPJPW8rKe1bJOm3RrKtwqLjIenGzbY8 AIwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

addr_scope_policy description contains pointer to SCTP IPv4 scoping
draft but not its IETF Datatracker link. Add it.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 12c8a236456e4e..2cad74e18f717d 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -3571,7 +3571,9 @@ sctp_wmem  - vector of 3 INTEGERs: min, default, max
 	Default: 4K
 
 addr_scope_policy - INTEGER
-	Control IPv4 address scoping - draft-stewart-tsvwg-sctp-ipv4-00
+	Control IPv4 address scoping (see
+	https://datatracker.ietf.org/doc/draft-stewart-tsvwg-sctp-ipv4/00/
+	for details).
 
 	- 0   - Disable IPv4 address scoping
 	- 1   - Enable IPv4 address scoping
-- 
An old man doll... just what I always wanted! - Clara


