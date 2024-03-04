Return-Path: <netdev+bounces-77128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BAD8704DA
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6CB1F22DB4
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B6846B9A;
	Mon,  4 Mar 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Qpuanx+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BB45C1C
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564941; cv=none; b=aR1wDtoBN9CDPfGJbS5M23oHmJv8XyJdneovlMcpt+6RYhpJZRwQh0S7xUnxjKseZwJxwnZMt9Noabo+rUTogI25KT2fmQVC+lClTwyc4O9NUq7bj/wgiDGocgoTd0TFaYayHVGMFBfC9faBuxCC3rJpnkU+mqTz00dnf4o/N6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564941; c=relaxed/simple;
	bh=/WjEtJXL3q/EHzsH0jwxigGQNTG5ruzeQTPLpsZJHpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYCaPSDQryYTkpXgs9KUy+mv+7Ga97A/Sis2ciTm9m6ZoYUI+dIbd2VEe8mtVSXVbxtPe02IwNiUhhRPWJlGIk7x6U3E0KpC2LVyZ8cIN/hygH6369SFp8nvSq3GgaPhr5Nt32nSolMmqelMTqSBrr69kCMZFKMrEYLy7UdWIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Qpuanx+Q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso6667750a12.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564937; x=1710169737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeZip6bVqDi4Q7tR2I/YzBpTDMakgH8z2EVh1FjDKpg=;
        b=Qpuanx+QfyX6IBc/J9k2EriTbWfhhv2xj+hg6lh4SugTDdZRZV8BfnUAcqu8awGncg
         OMusjzT8CdfblC6NskQchEJd9POmAm3qpD9pZ4sNe8c4M9smLU1xJo0t5OMLlkjWDy97
         Z9Y7CoDS0sHD4nba3GeRP0JG7ZaFxaGHx8U+bW4J1s2jXJR+6RUca6VfaOWV07LPOa/6
         ckgC6jibr5VNeDfmKVIrsASBALdoft59PkFiJjuLmCXFZSTkt++7eiSiunLyhK8YAnul
         Bs6YNTFhip4uXl1kOCcpg3pTEJ6YwIXsQu3QmwZ96leg6if3YYEk+Q/wQQyu1dm0vNzn
         69rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564937; x=1710169737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeZip6bVqDi4Q7tR2I/YzBpTDMakgH8z2EVh1FjDKpg=;
        b=J2eHs1W6QYBCOwCredGkzsv3EaPEScVmz1/OmX2it7nwCqTqqZ0BMacO92ZXT4QPTX
         GLSLNkYlyIMXUSFAwMG17jeZJM7xAWAEMxipIUOxRL3nD+UbpIQqDuX6einhLP3di5Dy
         ANkXoo5c7e1otdJeTQ+50+rHwxJSe4TsIFDgGQWo0GXeE8WSsIXv3iRmbAL3gxS16GDq
         EHis0APoPLqyPU7mxv8cxeSWJSiJSDbMkU4obz9IJHRho/S0aNUTf15uSy5qi5wQsnxy
         xrCWu6ftl5LLYt6b8u+lzriSQ+tIWHc5WLtBlakqWLg1UA9ZC0z7PEEB9OzJ3VIBxA7i
         A/aA==
X-Gm-Message-State: AOJu0Ywx/Xqa8zoTNvz2cdzPIFoS428aOncjlkN0l60Hw3F4J/D83il6
	784IYPXKjMSByispL4BdQNQfjdyZOMpgOdmtKAj7XeCH0wtBiRnL00vyzk/IPNa6LtI4LZZp8eF
	Gbbc=
X-Google-Smtp-Source: AGHT+IFczBz/lV8N90uJ8sbMftpatDtIlj9KXfkP5bhaIgVfb00fqPgH1Aph62tPN8J726yMHnSL+Q==
X-Received: by 2002:a17:906:ece8:b0:a41:2f5e:f9b4 with SMTP id qt8-20020a170906ece800b00a412f5ef9b4mr6239973ejb.59.1709564937267;
        Mon, 04 Mar 2024 07:08:57 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:08:56 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 01/22] netlink: add NLA_POLICY_MAX_LEN macro
Date: Mon,  4 Mar 2024 16:08:52 +0100
Message-ID: <20240304150914.11444-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to NLA_POLICY_MIN_LEN, NLA_POLICY_MAX_LEN defines a policy
with a maximum length value.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 include/net/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index c19ff921b661..0b741f62b266 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -464,6 +464,7 @@ struct nla_policy {
 	.max = _len						\
 }
 #define NLA_POLICY_MIN_LEN(_len)	NLA_POLICY_MIN(NLA_BINARY, _len)
+#define NLA_POLICY_MAX_LEN(_len)	NLA_POLICY_MAX(NLA_BINARY, _len)
 
 /**
  * struct nl_info - netlink source information
-- 
2.43.0


