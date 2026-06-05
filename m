Return-Path: <netdev+bounces-295603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ivbYFgk+ImrVUAEAu9opvQ
	(envelope-from <netdev+bounces-295603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 813AE644CD3
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295603-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295603-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7934B3012775
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 03:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E13655E3;
	Fri,  5 Jun 2026 03:09:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF434382F27
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 03:09:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628993; cv=none; b=AwjPcgvot3QHrLO73v3Thi9dbmsFzCx9Rqo+t2F60YybofZVq8K209+X9As1b4V4WjJ8QE378lVHPScuyJb2QNqHuEEMYjN8KCjRdkAp5mQ+zAxumd7ughhx/T+ybssjIglFUsmR4QiCn+1Wvw5zfliqw9of4CzAM2wYJdT80yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628993; c=relaxed/simple;
	bh=+I+u2qzLW0n3JK14fpvGx2YvjF2ILHylyAmsRhXzCto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WMgRmFiSd8P5y+3DEIa5Qjp69R+mi1BAC0Xa1xINzhkMDf0U0IVAxS4EycpOm7JPcXeeV9529dQLk30EqkT95h2V2Mr1NxpvrDUdHdAj/izDR3s2XdzmZAUY3cTOHnNHu0V37/qF1CmleJVDiXAqiUjYxVnOhnGuxRHeLDeoWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
X-QQ-mid: zesmtpsz4t1780628941t5ab1b94f
X-QQ-Originating-IP: F6yyBS6bLkTGbI8pdo2hd8bN4EOulayBnnBBW85i7/Q=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.207.111])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jun 2026 11:08:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16919765469182753366
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 0/3] net: txgbe: fix module identification
Date: Fri,  5 Jun 2026 11:08:47 +0800
Message-Id: <20260605030850.17796-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N1K0mG7Aq3SE7WHiTKiwMGSMFfZJ9o+vNzQHPOzKIA4cidJH5IEU3/X9
	Fh0u3kyfEM0A6XaG1r0Xt7jZ5IAPhjVKGCbeRaSIfbTX+UJvs6LuVfVqC4xYSuY0ORRZCKG
	XZ5i0nMbg4ES8WCDbSb80G32ub1DRN4KdK7eGNIToFKZUkYzyPxH3Okm20V52ADusnFH3tH
	krPBAR5WusMLQZIO15zjcahgIofiZTf2w5f+Uf3pjeujyBQiTP2kXCerOXewKfVt6nhEfBF
	6ItiykaIHIimA4OeH/vv3sg00q1BfEOlo9QPeAGOsys88FxRS3C0v6auNMumfcOtidOwE+J
	Nb0eHtL8BdHFwb4Gs4XdLWvEXyfxYDs3AelJYSaVI2eHehFbUq9Nu0lXoSWq5Um4maq7cMx
	kugfx8yhQaJsd8/4y9NO5O3zW0o6yu6o8dGpcK7Uc2BiyRkr2KHaPW6aeMVEdc7tSFve4SU
	B/qTph0JRTOUbnM/wFZgvDqAjL1Ds17vnrrd0czqOLt0jYCY4+Oe2OlNH5+K+KbaQ2yGq9q
	hDtFnlEKipJTro37yfqrJB86qfI2lWX+bzfL7ycmAjkNntX4e6BPZXv4ZWMAI6Iv1y7xI4+
	0S2BoQjBLFEoe1Fpfr+R+ORbvJd1FM1q4krLRjXr10H7S8xJc5AE6X0nvFQf7orpPemTC3X
	nlWJwGsOyPiQRmvjD3gZil0gQxeQzOzYmH+EoYzYo98uZ0ceGKtVG9CQaMIFsxTldSMHDQh
	Xj8k09WVuZ28jj1Y7ueJ+cTL6cnFwQlPKZc2wHlkgn/aYEXkjLOVMbSLNhCoCERj/g0yT+i
	LvcWD8bFl8KlrqMK6i4TTOeCnB8vHeUJBj6hKNSLmFmZZouVwqBm25xzWu0BsTXpVFJRtRc
	jIyv+uejyb3C1ArMNTbKxj/Auw+9ppcJFyy3PY0eP0JeSh2loYC/lm8JtcGoFy3A62a0cHp
	WxTiveVmjoJGtVx39/pyU25tohwS07080WP/nW/v+IOneecydFNmjoaP66zNUDLRdVFwUaL
	9CEcoN9MIxO+PesjNW5V71Ku6XI99eSoM/5AAi6nHqzyNdoxFg1NUKDp92GcXLTZDW4YQas
	e3hzQjF9jJnb8soVFwUnnuzd/AY61jTaw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295603-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustnetic.com:from_mime,trustnetic.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 813AE644CD3

For AML devices, there are some issues where the wrong module
indentified then configure PHY failed.

The module info buffers should be initialized to 0 before the firmware
returns information. And DECLARE_PHY_INTERFACE_MASK() does not guarantee
zeroed contents, so explicitly clear the temporary interface masks before
setting supported interfaces.

Rework txgbe_identify_module() to validate module identifiers through
explicit type checks instead of relying on transceiver_type heuristics.
When using the SFP module, transceiver_type could be a random value,
because it was read from an invalid register.

---
Changes log:
v2:
- Split the patch into 3 fixes.
- Change DECLARE_PHY_INTERFACE_MASK() to empty array.

v1: https://lore.kernel.org/all/F3DA1ECDCE0A1E9E+20260602025443.332456-1-jiawenwu@trustnetic.com
---

Jiawen Wu (3):
  net: txgbe: initialize module info buffer
  net: txgbe: distinguish module types by checking identifier
  net: txgbe: initialize PHY interface to 0

 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

-- 
2.51.0


