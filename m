Return-Path: <netdev+bounces-267941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMWoNfTitmmkKAEAu9opvQ
	(envelope-from <netdev+bounces-267941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:48:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B6291872
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18E273006D5A
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102ED372695;
	Sun, 15 Mar 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJzziPHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77D36F435
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773593327; cv=none; b=BFjI1uROhRyYa/Ca6WwM6jMN4+A+2zPlPXCOQ3imsyrUg7PVYUd6GF2IgkzYqrT+NKduKt68ytjwFn7+F1bQLCGDFCLF6Pub6gXTyFl7dO5tx1+gCIjdDw6bpptF9ACoDqXVeEXmGqU688ndWN11Z4mWVolWQkbtxxyiqNjJzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773593327; c=relaxed/simple;
	bh=dJcxXwUqtx1lCNUOj6ycFw8wkqRzo+3nWPXy6YrZhtY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QMQmaTJLXfJfM2QAictUm4PlW63UcfCXF2gYzI0ScBARh2OJZe5xvVK5CL1eslVKbBrQ7SfnlvhmJ4swE0akkuDGB/9iN4/wReqnRtCN6aTmOswOx3aKUFQeLnzd2k8Bm9Gy3oiY8jJrIibmtjwGZe2V6+Sywq+B1E6eiEyvAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJzziPHd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b40003d13so378835f8f.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773593324; x=1774198124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BrN/ck32NLsqkg4P4cpT5msAlPWmkBDFPzdOJO+ujCs=;
        b=jJzziPHd8XA2E7F20zQLSZctdADf13/gnYy3nxzkTMtkYh8AitHdBjqpFrHXlQOfgx
         M3BMjymTg0FRR+zmAlFdm2x+RM7rpPxz/A1AJsJqk2lz4XeR6Sju0QtKwRBfK3Z3Y8Tw
         Gz4qJ+5epscFPxaSf7SXbIogfE+K9e2RbMOtMfP4eTUFfJQMfsyWvKcCwQnr70uAkALq
         SewY67n2TDkvBt7A3J3/MXU+W+a8nJMYgqZz6ne5yAAWk74NtcI1/1djxQUSs37ds5f8
         d6I/GJSjZr1iSkGJbEFnKrOCQjjz/pSgen2ZvMnFIvQ52opX3eWXHt8/vR+NgOnRn5Y+
         CtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773593324; x=1774198124;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrN/ck32NLsqkg4P4cpT5msAlPWmkBDFPzdOJO+ujCs=;
        b=MHBq1t/omLCXt3gfIwSK2yHvGMdlF9e0gwgrtkm6vct98llCFT8kNS6yDdxAWerpAu
         sRcVmC6vQqT8ubqSXMSMrMX/5nHLKAV68hlt8SHy5e0/8U7ZvyaZpSaVLdoeQGm+pi1J
         DQ5HIy/DfPdk2XFoKl0NEMja6CK9bqX1eRcUAdpAefNvolOwBGAcuAhi2w+XooDXFaKj
         v1jQbF4GLpjrz14Hv1HLO3Y6+hRwzvDkYfi3f8sB/KyBm5SFhEllLrBl1zPXhUzpuNwO
         Nxag/XE/6I3bqjdZUbkXKEiyIPWadoXIcqVqbtmFraryhL0QKcLLUqFLgQr2JdHlRkfJ
         Gshw==
X-Gm-Message-State: AOJu0Yyf/PapgKZzBEwyJ5KF8oV65ZegDqpmquk1endf7in5znPtm9E/
	0F2GeQGWvm3Vh8qiyPk65UybTGKcWlaALumGsxGManq20FqbB35/mQIX
X-Gm-Gg: ATEYQzyZc4Gpcj/eAPnGQBhuJ7eTJgIbZLhLvrKQj1sEzKe7wXjAz/BOMathouDVjfb
	+H22W3p46gcbFVdWL88jXV7VOC62WAkPH9qsKZy20DAA/Tgy2MYwLjKjHkgXNK0pTQRKI7g0HH9
	Nhcsx3tla8u5o8lpYLrXPvvXAgBfZHVsavmpqrLZFk+YiJARPLLMQfek+ScAlmbgb2hyLkyrzht
	V1ZhjfMLViRjyp4RFVbVXKHLHetsfgZFstzpsym7WQaxLGJV+OQxQy6cecZls6WjaxecgYNguIz
	x7P0Igi/2Sr35pc/4t4qpGhuGRWI4UikbxsnTBwhIWGHOQTps/gPzFoDMKCYnQyrF4lhZkuNYXC
	czUKDWmVkqPUWIVfwnj9+/DRJWolwk2JgpASsC9alduiPOqFa8MfvAVcabRzXbsvQQvXTMN+b/A
	svaIrEQ59DJravPwUELobq5JYH7baLPnak3D/ZoGHTSykyw6+2VuYwz2naIPySn1RKUMqPLMKn9
	BI0DqCR57Kj9BIp6L+qaStF6NIxrA3ZrCUVtISi0aJQeuqMhOBnQ1hheuZk1VgZUw==
X-Received: by 2002:a05:600c:4649:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-4855670e828mr101710105e9.30.1773593324036;
        Sun, 15 Mar 2026 09:48:44 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45? (p200300ea8f19c4005d7d7d8bdc1aae45.dip0.t-ipconnect.de. [2003:ea:8f19:c400:5d7d:7d8b:dc1a:ae45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563903bbsm116493805e9.0.2026.03.15.09.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 09:48:43 -0700 (PDT)
Message-ID: <a21a3b3e-272e-4c61-986e-48a2cb3421d9@gmail.com>
Date: Sun, 15 Mar 2026 17:48:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] regmap: mdio: make it depend on PHYLIB
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
References: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
Content-Language: en-US
In-Reply-To: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC0B6291872
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MDIO-based regmap is the last user of config symbol MDIO_BUS.
MDIO access needs a MII bus, which requires PHYLIB for the provider part.
Therefore make REGMAP_MDIO depend on PHYLIB, what allows to remove
config symbol MDIO_BUS in a follow-up patch.

Note: After c5a219395b4e ("regmap: Move selecting for REGMAP_MDIO and
      REGMAP_IRQ") switching to "depends on" should be fine, w/o risk
      of a circular dependency.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/base/regmap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 06d7eb2aac1..3c76a5bf67b 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -56,7 +56,7 @@ config REGMAP_W1
 
 config REGMAP_MDIO
 	tristate
-	select MDIO_BUS
+	depends on PHYLIB
 
 config REGMAP_MMIO
 	tristate
-- 
2.53.0



