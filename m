Return-Path: <netdev+bounces-261984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CExsA1AVomk0zAQAu9opvQ
	(envelope-from <netdev+bounces-261984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:06:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C71BE74F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A3A304CCFC
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C0035A38C;
	Fri, 27 Feb 2026 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omrz0+QR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D4286889
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229865; cv=none; b=HvPQD7S4he62iDQZ00lnyj7WlVPbCbXNrOk1ox604dfiivX7xCCUrE5NnX4WuPMTJ7buNg9/WIT91GxSCJNmZkH6In8rHe28yx/n1ZxO7UT7rBJNdiSM/a27KLe+FZVLqjXzfT6v0AZmqlJcXAc5CpXCCCNHXa4ORLM9B7wXGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229865; c=relaxed/simple;
	bh=afYbN0bLl7UQUK2UZl5MgtTo1ezluiqN0TbnCFL5K68=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=B3lh8GQv91AeNHdTup3dCHHG6azlblditER6vzse4Ijc0UKt2EAJZX4fVFz5WQmfGijlj+i3yQ/sT37ji0htzAk9zvqgbVDeqs+YpvQCOAy+JM9/7l6fgbu001D8l3LrgUvzPjmoXFXsQEhqwlul98VThlXgyv6kz5S8M52OjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omrz0+QR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483487335c2so22473925e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772229863; x=1772834663; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVfPsCA2OK6Z85Pl+Kr2PB4L2dU5L7lwidBtqxykE3M=;
        b=Omrz0+QR2QX3JUo7hpvlhAFZFqsX7DFvYHgMnjo18pTI5bwpkthRxAtWEjBK9WFLJ1
         K3b3ufnmh7hzMkHbwxR+2UdhUq1JoLxKDUUhAvTTuzOWG6nTdnAVL2Q8QLoqK7Kvmqtw
         FdAHcUXhWAuAKdLSIa7kpA1WXluNyuDbwwE31W3LWg2ultxlVzjnQRXuy581s9VNRKfV
         C5oMBYDD+HQi9Kw97p2/VtCjBqfHs9CfBKf1JLYReg/FThXNlP3+00IWTxrS1J+IlTUE
         9fwl4T8Z0oHYgSVrpaFVPOyQdMKsKk8va9tBv3WdlkPCoJmbnONKdVmwv3RUZqehQOPO
         qrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772229863; x=1772834663;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVfPsCA2OK6Z85Pl+Kr2PB4L2dU5L7lwidBtqxykE3M=;
        b=Hu/47gv/ELsIv9mH6UZHedQGdzTp3AILLmyj7ySiPwEZwuLfIyOhfV7m8H+o/9Yanl
         qDjpJT/vDER7zySLFyIOAkGqz2sGG1YFp3Xf7ip60oRsxP2b+G8KCzoGo9SExrHqmAra
         UfWiHJqJI7c38UR9sr47qGSqrRbcahiKyxChVc740BphbxaUYwZ9FL78Kv0R2L9lnBJc
         YAN9eMBz2rgZfKxXKEXRp2OyCWBeKSjH8iGGtXEY+GRUUwtubivpkqIRChfSiqrQUmGU
         5AFB/cUS+eB0fa1u/6l8Nda00fs5mBDhil1nneTQUgKsRHDXzUudHPHiHUq5vLT+G1Hi
         M9Hw==
X-Gm-Message-State: AOJu0Ywl4l1XqHRETQUVBTnBRmcOsmm3AhWsGJGFWV2w1bOxsXdD1D9Y
	Q41vTDqEV7ZtwtccaaoLF2iGdXOdVUUx0I+ZEcQEDSq7sgnSe6b0S+HvZK5pVg==
X-Gm-Gg: ATEYQzzPR2VExNIzXklLMpLdKnsSy90MtuxG48+BMjYpeKE7/qOP/BZXcjtx+OIwLuf
	vKc/kGdff+jWdeMS4kXyAoT8QBOsOudC5rHMrIaNvhd3H5yQj7EJ2JelokpH+AgvbFhmlvfJtBg
	epiU+QoecocAWX2wbtWWAgTnFQPxlkVP2YKwD4HLO1QEeXeISbF9R34qf4MJnpZEoSvljBHYH2q
	+I+M90XER4ryNrWfUxhaplX6fm9CVwlDkOcoIwH2MbecWFfsgf/CnroF/uUZwyjkK2kPcpigIsR
	oIOmlj6ybErFFWTFFNOW6j6IAalwdXTCRvDaU3jBwHBIHmcKFguHnIIw8c2grunS94nzpow1Pqh
	sNy2Vmvfqn/rI8Q0Dwlwho30dgWBHX4GRLM6BvWeH42IyF0Dev2N0lXp3EHyP26nvl2eYkCLymB
	jqn3ZRsfAG00OsOgAFDgL9E9sxcAfebmOH5rtE56r5d/PPpz1b+K0KYfcNDJR39rCiyRBqhpShd
	Lr26DVY5V86DxW56bh7BFQoqBiB9xJRPejy/CDMjQO7qxzE9AK1F8e8j2XsKbX5uQ==
X-Received: by 2002:a05:600c:190c:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-483c9ba7fd9mr64400025e9.11.1772229862568;
        Fri, 27 Feb 2026 14:04:22 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb4f8bsm177062645e9.4.2026.02.27.14.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:04:22 -0800 (PST)
Message-ID: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Date: Fri, 27 Feb 2026 23:04:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/8] net: phy: improve stats handling in mdio_bus.c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261984-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 671C71BE74F
X-Rspamd-Action: no action

Improve stats handling in mdio_bus.c.

Heiner Kallweit (8):
  net: mdio: extend struct mdio_bus_stat_attr instead of using
    dev_ext_attribute
  net: mdio: use macro __ATTR to simplify the code
  net: phy: consider that mdio_bus_device_stat_field_show doesn't use
    member address
  net: phy: avoid extra casting in mdio_bus_get_stat
  net: mdio: constify attributes and attribute arrays
  net: mdio: use macro __ATTRIBUTE_GROUPS
  net: phy: inline helper mdio_bus_get_global_stat
  net: phy: improve mdiobus_stats_acct

 drivers/net/phy/mdio_bus.c | 124 ++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 78 deletions(-)

-- 
2.53.0


