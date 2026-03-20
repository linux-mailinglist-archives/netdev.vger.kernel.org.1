Return-Path: <netdev+bounces-269926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIQgNzhWvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:14:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3392DBAB2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CDB430D87B3
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08533DBA0;
	Fri, 20 Mar 2026 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Zrubf/8o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAF394795
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015753; cv=none; b=MndESBq2qm6ST/ilpCMi0R7RJMkG+Z2mp9wmdim1QlAsJF1f5EP2aZeygCOvUQRtXS6px5kC6F9wOnhjS//Buo+/+WQTzYNU73+E6aJ5NRJwdJ1BpMAse5xRNqllTsG4a2dI5WV3IHSjC2bdmssmTZxqdECXcZJYes0FLT6JaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015753; c=relaxed/simple;
	bh=/cNqJSeM0Q3K3wgO2bQXiTGod1Lubv8zRCDQINHhrUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kl1/tZyutiV4Vs19+E78T0PBOBLjOUKIzTpfyz62LM504cUzM8MA+w6mlSmfnpbHzQ5RV0pvo6rbdMaXshCacCkfm1A18o5u+oPNpvcgTNjaWr+r1FROsfaij5age1sYjjvUtIorvggaAKgx6fIQrPWF/8w07g/Hmily8OkTA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Zrubf/8o; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-b941762394aso231496266b.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774015750; x=1774620550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxwjSfGeTmNaRug+A53Bg742e8//9a/sV8tmYJpjJM8=;
        b=Zrubf/8orN2I7kixPK/wkHgSmA0v4XxvW5f/FKGY3rTrji+1dTLu9ODKE1W++4Y3kd
         8AbdUrDI8eCNJec9ly3Jz1rBQeBnvsByORTejYlW+0VsjPGvUIhoxXc+Zmypc8cO15er
         fpZr9Df+xzpWKMWGxaETrLFR+r6BvYQuQuWTKmHT6CdODbQ/NNJptLrfnKatTK3wWQU4
         lzp79LbDhsLzdKICJbbYUCm/D8YurKZxqJ6xeIzTFeHQn/M6l49cvHi3lyw69ZGkPeua
         wVMjDYmbm3cxI0hdIfOTS6paNT79UEb88qVDNmO1euRRrlsnDjwdBk7VntgeCiNYFFmc
         1k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015750; x=1774620550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vxwjSfGeTmNaRug+A53Bg742e8//9a/sV8tmYJpjJM8=;
        b=ZRIoP2cVGp0nzwmgX4cd5bFT6Ts/vmfm1FmJChs8wN33cnW1eSF9cCKjEy17Hk9ZMn
         8EKaE6WpRtUlVAwe0+6mGgfurVjTnesEQlI4ncF+W9+qgNy5p9rBESZQv8GQZtqyMv7n
         ajIPyYJ1Ev8k8LHK9XqbyWyMhNesELunEsGfkK/u5Rw+Qz7qrOwt1LWGXDI8tNsPGcVa
         Q+X8ECZQl4CbDbjoyosyntKhTTpqn8+0njfWv4+RU26xCt1AgFAgtQ/K9gzRHGm1dBXn
         8Ol6hXKNelHkZuBr3ezQemsBQIKM6E8loZH0t5v3YdlTj9dmL1yigvA1ynE+iiipc4Wu
         8MSQ==
X-Gm-Message-State: AOJu0Yw8VYws4dsWS7NxZ3irULH1Xd1eMfr8xitCc4TMBQ447FETm70r
	0XcW8H4p8U0eMuEthaVvkg5g2zZZBP5aaeYDkxEhPQzJbUmuVj0mgtX+MMKIY86aqh5eKK8USRZ
	NUd0phXWlIT6keeKFQE/eueKQQYlpB8hP2Pmk
X-Gm-Gg: ATEYQzyJ1wH4GJ64Aj0Qn0YkHFW2NBlOqhYvfeQ72+kfj45TjW0fa6YGwqE8j8CZ4CX
	lpZ6GRzgkwkq2Agjl4ih+AN0tynjfx6Yd05cM1clGp98uVJI07/iZKhgS3RymzVm0sMxYpzbhtS
	LnAueJxd18Vp5jd2iiptNSVHS+Uxe0D8UH3gOZ4/OzA1Vz7dCkU08NA8ax1wumP5QZWyZGzkILL
	rzvA7W5IaHtdUPqWRkjR0jO/4I02XmiEsXU5So0QbaQXM4auszPl1LKnRyh08lEHUs1uNY7HXgz
	pxVT8zy21e+bNHWmqUK+oZuQhE2u5fuBYRlPIRbQZDM2ypbK1/wb26xmB70aftoE6xLW0VGXHFP
	jQ8ogpimNpk0Kr9LV+JrdETdCHIz7gLdWknsl+O4FChx/d6kgxcm/PqAHUjMOniqsIigBr6+3Tg
	==
X-Received: by 2002:a17:907:d501:b0:b98:32c1:2465 with SMTP id a640c23a62f3a-b9832c15c05mr193867566b.48.1774015749626;
        Fri, 20 Mar 2026 07:09:09 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b98332dc66bsm17385466b.47.2026.03.20.07.09.09;
        Fri, 20 Mar 2026 07:09:09 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id 66CF21C281;
	Fri, 20 Mar 2026 15:09:09 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	andrea.mayer@uniroma2.it,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH iproute2-next v2 1/3] uapi: add SEG6_IPTUNNEL_SRC
Date: Fri, 20 Mar 2026 15:08:45 +0100
Message-Id: <20260320140847.1730633-2-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260320140847.1730633-1-justin.iurman@6wind.com>
References: <20260320140847.1730633-1-justin.iurman@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,uniroma2.it,gmail.com,6wind.com];
	TAGGED_FROM(0.00)[bounces-269926-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.928];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 4D3392DBAB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rebase uapi to have support for SEG6_IPTUNNEL_SRC.

Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
 include/uapi/linux/seg6_iptunnel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
index e1929d21c0b6..993a7bd06775 100644
--- a/include/uapi/linux/seg6_iptunnel.h
+++ b/include/uapi/linux/seg6_iptunnel.h
@@ -20,6 +20,7 @@
 enum {
 	SEG6_IPTUNNEL_UNSPEC,
 	SEG6_IPTUNNEL_SRH,
+	SEG6_IPTUNNEL_SRC,
 	__SEG6_IPTUNNEL_MAX,
 };
 #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
-- 
2.39.2


