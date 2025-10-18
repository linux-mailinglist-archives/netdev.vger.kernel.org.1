Return-Path: <netdev+bounces-230681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2963BED269
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D22C19C45D2
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427B22E3F0;
	Sat, 18 Oct 2025 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BXU+rz6r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B20226CF7
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800689; cv=none; b=VXKjyCKaWMJcrhdIrE73f8cvphlJwPVIwfcZ8RVgZJbUfLlkumWD+ZjC2i7y48GjWnZWwMq2HJwd/1bvXe8Yq60oi+cCTa0TsFMyPXRTwLShFcD3+npHlBws9Opj7/p7bp+jYgNL1YG9uUd5PbuGIxe7QGliRIPqT5EdBxXkhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800689; c=relaxed/simple;
	bh=JhyO9XvNDW+35nBiw4rGks4IugYKd7xQ0UiDyIaZ/c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W34T/mdL8S+xiL3Xji1/2nSy3aIW4PEw+4RNBguUxkGZ7VMbe3dnub5aq6oxBW8L9w26eqXpt8BEKf4u8Uaf3pcz/tbwU4kUDOL81ir5lrqolyRJ0+WgE+rJWFJDilh3ETZz0bRXweFwGSbuTdT6zTL9ldK+1w60qCmTYQCs764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BXU+rz6r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b50645ecfbbso573675266b.1
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760800682; x=1761405482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tBEUnZekJ5PrNAba7jx8QPCcLmqbNQY6xjID2I+xCI=;
        b=BXU+rz6rN9cmkwHCf4jx6DBYv9HsLnOkhu5zOrzYYO13Vhs1K3lulsmIxUpkyaEeE8
         FXaFo9BEPOZxmjcDcQcWrKEwCOXrQPR2Idl1xnaFW/RWp52oEeX6/RkRZ1EhBlwmFIx4
         MkjLz8KEO4mGSs4Hdy1GyTmL15l9ubSYjvz4mj3u/bP2XuPCBj5iNtI0HUZf5mmzaL6o
         k1PSuBqK9TnIA4A5xFUm6XeaCAeUly5L0Fml4fTLWWJ02ZwO3bs06pe6WdblVJaCI4ek
         cQM2B4Of+Aatyszz8zSDKnU2SnmjEbae5jSqQepxpKqmGbuoZ2chWmQU/rZ9UpkSvy2U
         MyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800682; x=1761405482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7tBEUnZekJ5PrNAba7jx8QPCcLmqbNQY6xjID2I+xCI=;
        b=RABBnpk9MbMcvSebA0d5jTEkr/hfjTTJ1Z2RITRLb18yTEqe4C1x3quuPXHB5QyiKD
         DMwWQsKOFzXScK23LpqLlo1Ixnz0adUaSy/koVxCmH0sr0elfKNxAtVLYfdmFf71KGa0
         X66uhfG8/70mk9O/oenD8rNUcR/EHQJf0ekDif7n8w4xmaXPyho6IMCYpl+67Xnkb8ey
         S9p/qr8V5oMTO1uB/mTfwjAsr/AmOE+R8waEkmSPtx3uD4wj43zHG5HZYQk6nWJkJ8eU
         JDbJkhF4jNT6HVcgGyxJUhxtfTp14Pb06J3AZINN+vlEzn5TbFkBPW/EIe/TmsgQvlnr
         ODWA==
X-Forwarded-Encrypted: i=1; AJvYcCVc9JWtAWO4iRoOPIbCuQicPXNl8gwUJPj03xwBwl4Avp9y6K3JKTOfbmx7nfcsznWOp3wJ1fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqzVd2/puF+fQtY9e1OsJ1APH1IRkvWfBQpd3ra/qVAZl43mz0
	Rma/DLWCvHNtQ3dgXpNjyif60edLGy4dyIxYcT0ChHJSHji/B8sx0xhb
X-Gm-Gg: ASbGncueQSc+SbcfzoK8iLDFvgkeWJb83xNnuXXVAM4PrtHfOgnoAVQLxyl4umUo6gp
	Z2cPSSUbPWtLO+0IjSC96gS3YQe4VKIQArpw4Owg98kMXcL0iNnBujQppZ+yO5lFaTZIup3rk9/
	jQyozzQ3dUgHzLTDvU/YBBpLY7mE4Mxe+Kp8HizWwRdy4ISEChtrCRnLnpfEyFLD+TwT3KqNWCE
	T9084f7dEhR8fhsNkvUujwq3p7Ylpl1Sn1CQLpY0E1Wj0UWP4+0jszb0bBkehdRjeZdTutYAoEC
	uHBF+zLH+rR6zQeZ5Z0QtXXPuMWglSDolJFXUKPGhmWs1WO8CZAr3Dds+91XkMH9K06SPfYyGbt
	9RCjXa1X41WgdmVfy1wR9vmrXF+oNErWBgwhLyF9LWQ+ns/aUbWAIeEWJBWbEb0NWwlvW1pS6ds
	IAvM15o+PTCuaksORyqbA9ERes2Udi36JpybYFecKasQBf1YTnVl/OqAKgozM2rkazUgIZn8hIH
	w==
X-Google-Smtp-Source: AGHT+IFubBcvDe/p5FEnyUxV3Cks6QoQioHs5yaIMVYObE6b3U3QQzbJ5CaDHU8R8IMyAEZnxXnS+g==
X-Received: by 2002:a17:907:86a2:b0:b41:2209:d35d with SMTP id a640c23a62f3a-b6472b5f887mr740065766b.1.1760800682144;
        Sat, 18 Oct 2025 08:18:02 -0700 (PDT)
Received: from tycho (p200300c1c7311b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c731:1b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm259983366b.54.2025.10.18.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:18:01 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH 2/4] tools: ynl: zero-initialize struct ynl_sock memory
Date: Sat, 18 Oct 2025 17:17:35 +0200
Message-ID: <20251018151737.365485-3-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018151737.365485-1-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory belonging to tx_buf and rx_buf in ynl_sock is not
initialized after allocation. This commit ensures the entire
allocated memory is set to zero.

When asan is enabled, uninitialized bytes may contain poison values.
This can cause failures e.g. when doing ynl_attr_put_str then poisoned
bytes appear after the null terminator. As a result, tc filter addition
may fail.

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 tools/net/ynl/lib/ynl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 2bcd781111d7..16a4815d6a49 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -744,7 +744,7 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
 	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
 	if (!ys)
 		return NULL;
-	memset(ys, 0, sizeof(*ys));
+	memset(ys, 0, sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
 
 	ys->family = yf;
 	ys->tx_buf = &ys->raw_buf[0];
-- 
2.51.0


