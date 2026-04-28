Return-Path: <netdev+bounces-282046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC91IU/58GlpbgEAu9opvQ
	(envelope-from <netdev+bounces-282046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:15:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD048A8A6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65328300614B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001A1478E27;
	Tue, 28 Apr 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KS9nSD5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7847A0DE
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400140; cv=none; b=mSVpz57iq5PEP37aKtx4BmtVylw8Z+bjPcpzocEM4eR8Cnwgnee2YVpat8KqZhe14RN/FcJaPC9vsX67aRQvSIBnQMXF4K9+jcdlzpQo9J72a9ydS3E+/shLp2Q6qz2/44aYNfO3TUss0gEsrLkU3EAqpb9h7HrjiNjDQXQ8xwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400140; c=relaxed/simple;
	bh=EyN5vPJA/nbywzGh7py3Y5RNm6LuscL6QtMuf+kzvlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUZeQyQNAlcwUxY4VSPCsbDvOHqW4+gqdyXsrDox9pt0oxyQ8R71TIehp6w5w8Q+UbP5doCnJggAhM/99O4mlTxkpeTPLTgMc2YLuMWuCMT8kg0sS432EuJj5Jt6pZD1yd7h6SgJZ2h8DxrqreZ5tziAvmt/R8s/fEbuRl+k/Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KS9nSD5c; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b788a98557so61646405ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777400139; x=1778004939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ3bVp/jIwzXIJMAxgX204FFWJfobla2UunocuNE01w=;
        b=KS9nSD5caPiQ7lnhxUD0RDefbqTG7e1zwPjYNez4FIyXZx9KR5ExWULy8CgZ2ht1Ko
         qY2yqfMQTNVUbTdpOdtfwiw4SAEi5KtiHLn3ra0+OmR7DwxmdVVx0m0iI0sps+gXGCAK
         6KwEr27MDohawWpFacFkpk9JEaavadQCEIkQw89gJTSjn7G3B0I0HDm2pEiVOVspWEQM
         EBLuaneO+mzOsYUkjrXsEiYTcQbqOVl6zGvAqC3WW7CWzWKgPn2/eCWWyu1E3ke4K/pd
         Vh7yVWvu/c87S9+HljvsulyrvR9YMKES7L2sIXmmmrCcYL4QuelvyS2hDhh101U8nsil
         WFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777400139; x=1778004939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ3bVp/jIwzXIJMAxgX204FFWJfobla2UunocuNE01w=;
        b=OM+y22zpJ62br4mDjcwRnZK2Nu8bYZb7GaZdvFxtededgQtzalFj4GhzvJjqWOn33x
         btOV3C+76xSg6z1YJvWCcZsCtKjFUbQLBB9wQRfXEU5XrhUSKNXvzKJ9j8XSRJbCVtH2
         5gUyvvjjgnG5r8NHe1ktpomTn0c3/DSXG/JELmMdwx/Wj5P1GmnkkD62oTTLmE/G6bhn
         mvsh6i0gpPjU1bnsfL2BI/I9thxq/9ZNwx/C0ySZ0T/7wxvrae2bPrftKBPkKig1hCad
         Wge8jyUHcOoXbayix+598/3QOFUPP1BTfQXEBcNSJcOtUy02UEWY+OLgT/anaDjCtt+T
         9zzw==
X-Forwarded-Encrypted: i=1; AFNElJ9bQkwPdxil0Vvaa0/wFcpOLZ9J7/73ygAAtC4KJT5s5zgS76Rhg5ZwQYuAQSGR/QYCNfcSavk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVUartpzZA3ZwRzN+bp3HjZUY40Bvbl2EBRB2YJktIjtRlDvX
	CCoI9BZ67McAuGaB2EB5mtPRwv/+hcrOVJOo3fmPTZ3Mp8Hoso9rAL0hXpC7mEcQE88=
X-Gm-Gg: AeBDievP2dnoQ8qS8IxeBfsFWKKNHZanf9SUaChMG6cXbO+e+SNL98xIKmaj0/wwCyW
	YJ1XzKgR3u0DsMhshlFPQxkdXelUeVCouz37K/gMH0cyrkLANPm3NFDQf9AHlIFdTH7uD4/+lz2
	eQwzKH6yQmmnH5NLu8j7JaaokTmeujG2KwWx/RGqASztbFI0cFlWeIhKpFYzagn9NKkrPnMcV19
	666l3njZelavOkJJZWK8am3LwB/l6WDJm62D780hckE/9aFdonwerW3pJ1109jGqAVyxqIuqRKX
	KiZVGWA4liWrMY0MA2RjIzhklsLG79yAnzUsXZTi5C3i73PXSKhhBGxa10yP7nF8n3bD3FqhmH9
	3UoRV6o1dYtIdofnTtdthJ1kSut/uKdQR0NWYZ+skxTD4nbrUMK2UeoRrOxBIbam41DLDW4Hnli
	XyqBuVWVTQoESWrkYiZ0X2/QGYtGBFdNLasFgL5Mj4qmgs5XzFcxFUfqzQhA==
X-Received: by 2002:a17:902:e2d5:b0:2b2:eae2:db38 with SMTP id d9443c01a7336-2b97c4158c8mr26339015ad.18.1777400138823;
        Tue, 28 Apr 2026 11:15:38 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b97ac7894csm32995865ad.50.2026.04.28.11.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:15:38 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i40e: Fix i40e_debug() to use struct i40e_hw argument
Date: Tue, 28 Apr 2026 11:14:50 -0700
Message-ID: <20260428181450.2622899-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BDD048A8A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282046-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mkhalfella@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[purestorage.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid]

i40e_debug() macro takes struct i40e_hw *h as first argument. But the
macro body uses hw instead of h. This has been working so far because hw
happen to be the name of the variable in the context where the marco is
expanded. Fix the macro to use the passed argument.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h b/drivers/net/ethernet/intel/i40e/i40e_debug.h
index e9871dfb32bd..01fd70db9086 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debug.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
@@ -42,7 +42,7 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 #define i40e_debug(h, m, s, ...)				\
 do {								\
 	if (((m) & (h)->debug_mask))				\
-		dev_info(i40e_hw_to_dev(hw), s, ##__VA_ARGS__);	\
+		dev_info(i40e_hw_to_dev(h), s, ##__VA_ARGS__);	\
 } while (0)
 
 #endif /* _I40E_DEBUG_H_ */
-- 
2.53.0


