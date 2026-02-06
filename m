Return-Path: <netdev+bounces-257576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE/dL6IFhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:15:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3653FF96D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC1A1300406F
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279CA36C5AA;
	Fri,  6 Feb 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x83.eu header.i=@0x83.eu header.b="g31INle7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCHAq9GY"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E632D0E8;
	Fri,  6 Feb 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390940; cv=none; b=itWSvPh9bglret15F+SZMxkc3WuZ5SWfZFeYLM6qpGnxSlUMpoLfmTh8biVNxgSqwOoRgRzkfwdMCF40vgTF5sP/gaZLDhLjPhBCx6BM+VuNtpfHCMRfHFT+rsaVJoxdkA5B6VvN/KgdtHli30xfi4yGD8FKsLHnXRV9LQS1R+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390940; c=relaxed/simple;
	bh=kshHsmYXg5UDz2ofCYtDQ2s4f4k+5QWhfqW6mh5a9po=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Zu3O8w/HVdk/oTIOWgJDcDDzdR98xmUNsHPCUTK3cB2q08TYUQcTFL6wbzw8p2GZpUBIlnS1stdPxcYUZQsziyytCIYWJVYBaiQoPn5Ap26CVrcyZLfh/miPXSjSrtutDv2DmTzbJzUbBqnPLN2ju+6v4FnR02yVrR/Mh71eNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=0x83.eu; spf=pass smtp.mailfrom=0x83.eu; dkim=pass (2048-bit key) header.d=0x83.eu header.i=@0x83.eu header.b=g31INle7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NCHAq9GY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=0x83.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x83.eu
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DC161D00189;
	Fri,  6 Feb 2026 10:15:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 10:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0x83.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1770390938; x=1770477338; bh=jxOUZuDNsT
	pnOvJpDm88R4KKFfQr+YssR216Ry+idb0=; b=g31INle79O+ATraC6PaBrqIfK2
	mHIRZcvKI0O8KPRgfc2m5AwBq7XA0/eQ0HaZRnFspP4lI6eEOI+GiE87dc/6ayg8
	BxqK6z/w49eev94X7kgXb4IRR75+oM4xXAw2b4uNZkvn06jFhvWIk6Q7za70Oard
	Hsk/86N6itFSUeDsEMVieSF6JkNhiihFmx/e+Kd3FGYXccpC8ho1BArv7agpWoo+
	KLszXX7bnAnJTMWorloITupRq8swWL6FjNkNAM+qkBM9FgcEfpbDo2yn4xGNWqrB
	JefkA2UAZ3h+TkgCsjxvKj6GPv5RcAVqqfEL26miXITSw8K/92+YaMA7XwYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770390938; x=1770477338; bh=jxOUZuDNsTpnOvJpDm88R4KKFfQr
	+YssR216Ry+idb0=; b=NCHAq9GYnZ4RLcH054CoCZM62hwLzMcPjAQMlSC1kGKQ
	nOIFNfcZ+tl7NonDKGw7i1aLbrVfkW9idlvnJIkpilbu6eBxlQm1ePqr8RYkGid+
	JX6doKtyRIwZJSsNal/4++62R5Jm67fpdOezaW91VJBdAco/cRDar2yr+O5+lrK/
	Wyb7tgIPednsPgy2NZbSUKR3faDeu1QbRIZ66C3REXuZSz754hhUP73D5fy1HM7N
	rzcgWuAaD4evtF3bvaQ0GqQFtshFFHGtloVYzW2MlLZrw8v/vbA4DB3+8S/tvpHu
	Z1El5nqRlo93khmkZ5jcnsrDbG8N2aiyG21kuuH8bA==
X-ME-Sender: <xms:mQWGaXFjvcc7ChpqKD8zOQY94WW76ilg6EOiLRaDDOYy7bzh6ktmHA>
    <xme:mQWGafwqvSsUrzTRcxk8HaoTACw8LHrWWEOOnO7pL-SuGDI7SifKR6-EYQI3d_NT_
    zzLBAupXw70-yXJz3L_NtrFq0oyJ6rhOk-4tX4_UJdi9QRV-X82V1E>
X-ME-Received: <xmr:mQWGacrIZEQkNIshXxGTsVQztuZnLGmhwmepDY_isZvIIFO-68KHlKWyfpnqdQegK8VHaCgQghunVsmmz4swe6FE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfvvefhufgtgfesthejredttd
    dvjeenucfhrhhomhepfdfnuhhkrghsucfmrddfuceokhgvrhhnvghlsedtgiekfedrvghu
    qeenucggtffrrghtthgvrhhnpeetveetheehleeuvdejtdeufedvhedtgffgudejgeejle
    eggfeivdejudffhefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkvghrnhgvlhestdigkeefrdgvuhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghv
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mQWGaZjgsww9KEaTTlgvoG863QOutQu6V9StBEye4m56TAEF4-duAw>
    <xmx:mQWGaZjDkYOIemJ68d5F0b6_I36ItkzOGHj2wSgbswurb21BEymyPw>
    <xmx:mQWGafgBjKC7DFNiVuxTKhowWMgltmW_jgsWiNO2DEHjCZ2w6JqOgw>
    <xmx:mQWGaZJjFzsbhb1DQ5BvCrqUBHkjN2Q86BescRe4jXa-lSxe0KRbLQ>
    <xmx:mgWGaYpKX4j2kJ7AC4UZsDbqMLE88VMzQ6pw91Yv2wbSv1c5XsrwC8S9>
Feedback-ID: i83f146eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 10:15:36 -0500 (EST)
Message-ID: <11b7567e-b9a4-4546-9b1c-bb9820bead0c@0x83.eu>
Date: Fri, 6 Feb 2026 16:15:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org, krzk@kernel.org
Content-Language: en-GB
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org
From: "Lukas K." <kernel@0x83.eu>
Subject: [REGRESSION] NFC broken on Thinkpad T14 Gen since 9c328f5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0x83.eu,none];
	R_DKIM_ALLOW(-0.20)[0x83.eu:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257576-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[0x83.eu:+,messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@0x83.eu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,0x83.eu:mid,0x83.eu:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3653FF96D
X-Rspamd-Action: no action

Hi All,

from 6.17.2 to 6.17.3, the integrated NFC reader (driver: nxp-nci_i2c) 
in the Thinkpad T14 Gen 4 (AMD) stopped detecting tags. This can be 
tested by running

sudo nfctool -1 -p -d nfc0

Looking at the commits between 6.17.2 and 6.17.3, 9c328f5 (net: nfc: 
nci: Add parameter validation for packet data) was the only one related 
to NFC.

To see if that commit indeed was the culprit, I reverted it on 6.18.7 
and nfctool is detecting tags again.

Since the offending commit merely adds some bounds checks, the root 
cause may very well be in another driver in the NFC stack.

Best Regards,

Lukas

