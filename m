Return-Path: <netdev+bounces-248934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA252D118B6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA9B53031643
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938734AB0D;
	Mon, 12 Jan 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcmupVpG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18C34AAF3
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210874; cv=none; b=J5IkhP1XwNQIk+O3uUCIOoI+cvhfuqwWxYLN1WjaGqXTtPsuh6wt2msitT3lN3bGJ/l8zCeMRDwkT34WbTrypaeTZmmXWzl9D8x/eS6j92ifWLTHiRxa49JpbbKFHSRdZ8fEBrSeWEPnb8mt5LfrUwjVn/Qr2tPTR183qDeI6/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210874; c=relaxed/simple;
	bh=xTW7lVbfJsgnlziO9m7HRTBaTgvYhjTEK5XGbQnoB3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHI8Mw/1fP9jQNIsecAD+wjOLbslscuQlMocQ7a/3JA8yBImWU0ST+sid1fzeO+euZk1h5yYnJr+gtdb6T8PcTQ0Y49VXBnBB4VVwi2rcMXzemHtgRcZ5hLDer5Ch2ym2Gi5z7ZRfNrW4I4Pxv/rTOVsqA6Znw5PXPinPEhNoUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcmupVpG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8722834679so66247766b.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 01:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210866; x=1768815666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=NcmupVpG3yUfEuJKyC4J5XzkgvOgSSQf0JE37JAzRCly2NVPEEjO1rxZTyr700XIXy
         CrHAuqTeAuwkQTfYdESbaXR82qnroBYGpfIKBcTcJmwuicEQ6PEyiF6SDtMWeu7DpmEt
         M/RfdExvYfpV+egXLxIh2VMUXKFp2io4r/Tqeb9KRRsbGRkcTFGwKSwCbLPZUi7AJ11U
         8EYfvpw3UazwgJ8DGVLwom47h7Pc6nM8k3ARp++vmhNZ3X7rs0vqcVavlPN6nHO9XL1G
         85caFPqPTNa6Cdj5M9QNQ9yaH7tR/7fPUTKhkziQSSfqq89iBEtcN/93RddXWKPw963X
         /lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210866; x=1768815666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=XuQvkP9cdTwIiEVRdS/oF0LKceX499ogND9lHPeWgNCxA8ACXWDn6iKWoZPKNB0gCP
         tfdVv+rgVFou8GxEnQfccmJykklkAMVvgy2PoqQ20mybDlQ4qIim+6sBRZP9/AEE0S/Q
         oOq1C4Ze5HkY6YW1ZGgKaFd0be+TNGXdFUEBPRjUitEx9jsr1/FxCKtHBjC5Jyz2W3ti
         bHenH6rbM9xQa1idShTiSx92BLg4W0ln7ZuH0gZjx9Or2oW/mHWnvbDhuWxIA58oBUc1
         llAOlLsXqXTkRkvgrnc0l+BZJUf4sffG98aocGWsxuHEmRwfwoJcJx5iaCWVANQNjTuy
         7SJw==
X-Gm-Message-State: AOJu0Yx1RUiO/eVXDYzP4SSYFlDs+RanR/I11+PVoyAkD01OB80V++4W
	pvbDjt0afaCmrIBwJJlQOnm3BY1sk42vSiDgc9uzZTBm4wSmf3OJgmng
X-Gm-Gg: AY/fxX7A1aJxzRMYntjjNffZkA3UD4usNZMmYlw2SH7MCe2OkulwcSI5LZlvMQGJcX9
	GLss/uQn0kBbG17ce4uWgo4Y4IqfsfYr3/mOqQx2Nvr9j3gZ5kSLTzVwmIVtZJbpxSTMChaL31M
	OY0/zE1DYKdgdSneaRLiEP2shcMqd0KTBwQkJLTl2tBCvB30SCsma51p7ZKhkappinz1Gc5ydFH
	GXJn1k99MyQrgiyyhZPXWEJAiduxXG54AS/y1mlwStJjEh3HNteC8Fh+ga138J4jzzzselDYhct
	zZgcl1VjHKlkG51lCZF3KiQ2zn4HYuEVZn/WrHvhAGfuJ7U2izqqEgyhIthHU+CCFaGHw6DQJ1y
	k+lnf/hDbcByBPmZZ+oO+Jam4UO3XGQyzvtNfy0VCheKU0JP//YRYoQykBBmsZiKFtoe3NRKSi0
	adbivUyCaRNUyJ/A==
X-Google-Smtp-Source: AGHT+IGsuYYlcfIswN483on6lkd9zrTHj3Op5tXVtbRnccE6HxdH76+tt4k/Vdc/GSDG184bF4lJPA==
X-Received: by 2002:a17:907:728f:b0:b87:2410:594d with SMTP id a640c23a62f3a-b8724105abfmr146400666b.49.1768210865520;
        Mon, 12 Jan 2026 01:41:05 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:04 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 12 Jan 2026 09:40:52 +0000
Subject: [PATCH net-next v10 1/7] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-netcons-retrigger-v10-1-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
In-Reply-To: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=747;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=BLduFEel2At1ZpRoHzUB/43M6t0wpDLHJLh+eokOBeA=;
 b=E0UQ3fv0rAx5q3iuk18b+VTRGt7svBbjpNHMgaJhnnV4zqLBiCrOV1pfmsu/PHSsEapXoewqN
 EHd4Be1TvTFBumN0KwyYPfZw0Mdw97XjNmlsgGi7WHQjAcON97+XOoj
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9cb4dfc242f5..e2ec09f238a0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -119,6 +119,11 @@ enum sysdata_feature {
 	MAX_SYSDATA_ITEMS = 4,
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.52.0


