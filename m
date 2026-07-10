Return-Path: <netdev+bounces-306723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OgpkFMGDUWq9FgMAu9opvQ
	(envelope-from <netdev+bounces-306723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 01:44:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A2A73FC24
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 01:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b=oadeqqeQ;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=Mcbs+Vxk;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306723-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306723-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23F4930238F8
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBC3BB12D;
	Fri, 10 Jul 2026 23:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7A377566
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 23:43:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727038; cv=none; b=fzOSpfiiXTFHMBkEKJn7AMFyD/s4g+eFzFdSsDFIFjwK2bO81AXSAc7qHHGFZ7IP5V6M60YH7tzWfGZcoMjV1aATsUyKQD/XuvaMrjtyL54IvqHcEVXMUmX9XnHMB7JU8OaRxddoqmHhqT1QMAQue3fSLT+U3pfiw1p8iqogcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727038; c=relaxed/simple;
	bh=3wQQb+0AYOusXKBydFdAJx9qNja7ILyNmi2KVP9wfQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xy8SIx9M9qiDvWjVIS26239DJhwYB70SnA3CtqyLVa8z/s6kUDPCQ+VGPUSV6rl5doudM3pJbNNFXAkyIo+X3CoAxVVr5tHrzMfrbK6N/UnEs6am56N0WFQGvt0IMjxsraWsiaU+CgUVXC/6tgjy/vCraMAMWDemWKxsQ5bB+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=oadeqqeQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mcbs+Vxk; arc=none smtp.client-ip=202.12.124.155
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9271A7A00E2;
	Fri, 10 Jul 2026 19:43:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 10 Jul 2026 19:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1783727034; x=1783813434; bh=GKIKYKV6UeHLtr3RH2Pkt
	dAEffQps9fXEAUHHjR6r4o=; b=oadeqqeQjtR5NUTIaEPvQzDvsSgi9lw1RYF/I
	8CnOObaJUPBj/ITfcZ7o1Eg6LqAGvb+xK843Hq4yz5/+zh/KneBGPoIJNUSW8RjD
	2K8uaSje1agqFwDpxfObhr52rQ8/TrbqIJ/aGgZxiFOqVnsOq5oYwAsJky9FIJTL
	tAC70Ajl5SmkdRETPoZ7BXizziWgTydjzclBBjhAI8vpXx80KV8u6Ed1DT9F+APH
	8lMqfsYY2jZtlo3/YhNo/YaJKJdkJ0olJVeR7WP6ZV31DOF3jvDZVi3kketuhhPI
	aMTHi8h6lnfq09qa3hDm5S9Y96VLD1QwtcZ5sGPTrVoonkEQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783727034; x=1783813434; bh=GKIKYKV6UeHLtr3RH2PktdAEffQps9fXEAU
	HHjR6r4o=; b=Mcbs+Vxk/IWn4eUiuSSBOmf9VqFza6pP/Tw92gKfYue5pFOwbMs
	U0guxlSY69K6zCcKuRgev6MbY1OYrG/V7t8T5iRpq1v+Ww2B0448HNhu8VPeEbFV
	NpzfrE6JqJ0IE9ztbrXFYPQXP0wMvX9xRf6lc3HpGKCz39TejhjKlvGb5Mgb0slk
	IhYksxXfkcr8QetizUwoa6EW06o4oG16IkrUOAmNfsCjE5C5rSuAr/0eaFDrq0bt
	3fIB+DSs9emKNumTjNM2UhUNdJzbpqdp8EAL1ugZzvpni0/eiT4PNlFIqTcFY1F/
	EiQNsZyJiVnU9IoeVViH/kAyxOWThnDP2Dw==
X-ME-Sender: <xms:uoNRajA_ZbCxt5GfS0A6ox2t2cZJDuJV6Tc_EdxP7Yan5Hvrorntrw>
    <xme:uoNRagbuTQ1yYCRch0s05PzXIMuDEs_7tR97hwtv4bh1Ce0rJVSUbubDZ2L1HShlg
    1wBxetA5RjJty7XoHbOTSf5QHFHKC-HjrjPYPF4ju6S5NWWdR6Smdg>
X-ME-Received: <xmr:uoNRam5PovK4k76uT7x1x9oC8evW_EOybVjGyYeE3eHOfMZOouOn7eIOfspYcC6W9tGBEG8>
X-ME-Proxy-Cause: dmFkZTF+g2EYbqeqpwFxAE5Drwtlz0wUmeW+uHINOI7nt4t4qqPvKrsj7/KvtsdY5v7SUR
    jNlrhzMGEoeaqLjPEQxZ6bRbjkTnCoz86hcVuZztF2uo6aMJ5VCTdWwMlkFhYN5S8zB8XE
    HBqdUUNLnu8Nyqk1jpV1nhEIl/UthMRHsASZUjbEOM//KrK/2edReajtiZE6biBhfWDH1d
    UkcLL3iE3Am2uQ0XQ2fnuDEYuqXioU/874aIBsJSU1MzD/bxDOXtyndBN0rSPQP0fY0zUr
    axBwAj09fC/XY6TXZZdl/RFBXmHwCsoBBkl80/LY43Bv5FbANrMX2Cjf4DmR/E+aJ1SNpH
    44I8GRlTtVlkWJl+OrbwYZlAf1mjT+zthh8uNXNUBnhMU8sZuYeAQaMz1HLh9JifKr11xc
    Gzd2Ff3QW7keReA99jkCogm7gDX3lElon2vzrIWcaEsYpRNy+hGJKdOSPmNW9AHKcgca5Q
    KCq5AE7z7Gtps15cP6pv1rl1OHn1g3EdvfBZpLZi4BhYUh6dzr/It+720+8bmcz1dFhd1P
    QAVGq7OFqq+dzhw3UcDUly1M/gaOGwWcvaTiR0+9/56EpzWODrCnR/hysxlaaM+xruhQ1r
    w8KFGExd/6q7HVERD7+IEPM5LDQWTkbpuvWZx8mZOVR6MdjUpPLCGgApcJJQ
X-ME-Proxy: <xmx:uoNRahbQgUVGEX6Bk_MVxXMAULmrHqwBgbx5eGuoIkGEhzAFh8GuiQ>
    <xmx:uoNRalgal1af571YFBQ7YZ1cDN_RfZ3__jw74i6ArEUXjeYODuQt6w>
    <xmx:uoNRai-hHT2NgICtmXYMG0kt-7Q5M_zkJ8v9Dc5zbQjPQyiE4HuNew>
    <xmx:uoNRagoj-1MHewwBTHF6QDid-dUSEcacOb7HKhOI5fWudgAHI85SPw>
    <xmx:uoNRap4ckuWc_9SSD8xDMZX7-wdLOhMMwJ-geEzT9n9P3xcaeaTuCvBC>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 19:43:53 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	maxtram95@gmail.com,
	Alice Mikityanska <alice@isovalent.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>
Subject: [PATCH net] mailmap: update entry for Alice Mikityanska
Date: Sat, 11 Jul 2026 02:43:19 +0300
Message-ID: <20260710234319.328687-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,isovalent.com,fastmail.im];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306723-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:maxtram95@gmail.com,m:alice@isovalent.com,m:alice.kernel@fastmail.im,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54A2A73FC24

Map all my corporate and old emails and update my name.

Signed-off-by: Alice Mikityanska <alice.kernel@fastmail.im>
---
 .mailmap | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 12f3acdebd72..d790f17a553d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -66,6 +66,11 @@ Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
 Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
 Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
 Alex Shi <alexs@kernel.org> <alex.shi@linux.alibaba.com>
+Alice Mikityanska <alice.kernel@fastmail.im> <maxtram95@gmail.com>
+Alice Mikityanska <alice.kernel@fastmail.im> <maximmi@mellanox.com>
+Alice Mikityanska <alice.kernel@fastmail.im> <maximmi@nvidia.com>
+Alice Mikityanska <alice.kernel@fastmail.im> <maxim@isovalent.com>
+Alice Mikityanska <alice.kernel@fastmail.im> <alice@isovalent.com>
 Aloka Dixit <quic_alokad@quicinc.com> <alokad@codeaurora.org>
 Al Viro <viro@ftp.linux.org.uk>
 Al Viro <viro@zenIV.linux.org.uk>
@@ -584,8 +589,6 @@ Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@osg.samsung.com>
 Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@redhat.com>
 Mauro Carvalho Chehab <mchehab@kernel.org> <m.chehab@samsung.com>
 Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@s-opensource.com>
-Maxim Mikityanskiy <maxtram95@gmail.com> <maximmi@mellanox.com>
-Maxim Mikityanskiy <maxtram95@gmail.com> <maximmi@nvidia.com>
 Maxime Ripard <mripard@kernel.org> <maxime@cerno.tech>
 Maxime Ripard <mripard@kernel.org> <maxime.ripard@bootlin.com>
 Maxime Ripard <mripard@kernel.org> <maxime.ripard@free-electrons.com>
-- 
2.54.0


