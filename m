Return-Path: <netdev+bounces-304691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4kpVKs3HSGohtwAAu9opvQ
	(envelope-from <netdev+bounces-304691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 10:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32D70723B
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 10:43:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ugreen.com header.s=pkvm2402 header.b=dOwx+Zki;
	dmarc=pass (policy=none) header.from=ugreen.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304691-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304691-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AA61300F9D7
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 08:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7457E39D3DA;
	Sat,  4 Jul 2026 08:43:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC038F240;
	Sat,  4 Jul 2026 08:43:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783154632; cv=none; b=cFlQiNpBUTqNTooMhBR4/ksKnDmtGcfJ4Tzers4nt1VOzGWzChApWPwVJOhKgN//qyPVe3QqUJYuI9l93JThSwn5yze1ZNjfZOp3phYv7XR3MJ6tf/hfOiva7+bz6rthzMx0gcbdOycmf8OT8c/BKGXw+KeXXiVhBQd4nWs/IYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783154632; c=relaxed/simple;
	bh=qQEraKButsEB17QaARuJkvQEX9Psmgo4SyUVgEIXKwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLwmYbUjau/AV5z6/lcGu4oX9/qZEv2zYnWGMgVf/WRuLUHDwE19VZ3nfoN9/VKVKcvjZbe/BbXCeVXTgbEAo7FDZZopHmELExDVQkINNPl7gAi8qK1XK3nT8lTjTnHTvii/0G6PbDn4ywc/HCwG94FA0joQRswnNRbaWbAQ8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com; spf=pass smtp.mailfrom=ugreen.com; dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b=dOwx+Zki; arc=none smtp.client-ip=54.207.19.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1783154594;
	bh=CNH7cJsDc+JC7+eiD+qEhLe1GmbbW50fNARWvPtR46k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=dOwx+ZkiuNInhnKjuypDX9hhRrXrBGlRrKQ2HSXh1aAwRlFrzjvbgvv4F0HbaiWSC
	 eNVgrQhH5fSPGMIm0amQgbLg5Ac0EJvFCFJTR13SXp74ZZH/tPrTiEe7Yl2VXIR7yV
	 Ad3t/fUJa74wTXIJfgkyT2tW9aYG1he7bLijdjvU=
X-QQ-mid: esmtpgz10t1783154589t4efead20
X-QQ-Originating-IP: ny2Tx68rWjwWeM2TN54kyg0OpROsi16NMTAYZqJTiqQ=
Received: from exmail.qq.com ( [103.17.240.69])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 04 Jul 2026 16:42:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5595461346446072083
From: Hanson Wang <hanson.wang@ugreen.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	linux-usb@vger.kernel.org,
	oneukum@suse.com
Subject: Re: [PATCH 1/1] net: usb: aqc111: fix set_mac_address return value for bonding
Date: Sat,  4 Jul 2026 16:42:58 +0800
Message-Id: <20260704084258.3513069-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <43a0904c-de59-4b40-b186-edd130f6c0cb@lunn.ch>
References: <43a0904c-de59-4b40-b186-edd130f6c0cb@lunn.ch> <20260703073936.462231-1-hanson.wang@ugreen.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OYMEOeTae7ml/GOoCOZQyYv3nILgleh1tbqel6CNn9Es3LX2l9LHGeif
	eQ6mS51vTD9bE4xO1D1ngFzF6+p53CRplKKxSUsBjsxMsB1/9SGZl5+jBroybWvxjAy1O78
	HUADetGJ9+YxWuKnUDPGslfdcPllIF9QfUFsGVnl1i4PLqh0iM5FkHzOMZ98WaKChRp8KC5
	rJfJPx70TPuh7vJEWNM298MTqEqhNrAs2PW6UUz2qnESVxU2Rn88lsYuHm5teC8THhoWPyS
	4fQ4CncUbJSMjPlxJZ9Fp3jnjtNaUgnjtX9UNf5rbfx8N1Xekni6itoGgQfHwcp60rxc0Vd
	wHH1EbGQmXxMaasFVGo6li39b3l/Kiq8b2iQbZan+4gRXNyaJWvo/WEstDXXTGo220wLhO6
	R5vRUrU34lP7kA4mjJ/kyiOKwsNwtU1tzfevaKHZtvHLQrEICpyMUPuPnCRcue9tH39v7XV
	0CYvzPO4x8ru5htd0rYPG0IFdqay6jp92ca46FWj/dB2eH73t9c7SthPA7ft54WJQaoB6SI
	8ufoFlxxl24AQaSDsv9AWXRI11zYPnu6PC+q+L9NX0kJbODXnlHf63Akeq2x7JXBc96Isto
	2Sp/X3W9Gp7F9s061H+b1LhBSBQdubYBakzOWVPM+NXag2JVJ7zkljuK4JqL5mmEoqjPwd1
	L7WK8ihBCIfv7jJhEgm1U5HNkmaxrX+dC+GwY7zZh1Tkc2GrpI7Ve4JfPeksmOtVLCCjBfy
	mWpteP8ChNVQIeuGPnLSYbzlPtuGyxdhfYca/9avO7NbeCQkK5zYhRK0BPIJNTHuhLafQhu
	NXAMeiHGIyDZMo4DTB1wj+BAzyMoUNyVAl1YEq5+lRxOYWQFJN4IL+H7NuYsEo9GvFp/63l
	vA2j+PwBli5YoEz24592NowLv99HEBWR48EHYkVSRFF/zpPzL3lqhQOQKKeOmP3clEmKgfE
	aBcx6HTqeCvsIGduWNPYUA6HMx61lSp5abW7XozsSNd28tI/tQoYMtSmPToVgukCba/Neps
	TupgdLBgYbUSdYP+/7HhyQdOvEsrs=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ugreen.com,none];
	R_DKIM_ALLOW(-0.20)[ugreen.com:s=pkvm2402];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304691-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hanson.wang@ugreen.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:linux-usb@vger.kernel.org,m:oneukum@suse.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanson.wang@ugreen.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ugreen.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ugreen.com:from_mime,ugreen.com:dkim,ugreen.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E32D70723B

Hi Andrew,

Thanks for the review. You are right that this is not bonding-specific -
any caller of ndo_set_mac_address() (including netif_set_mac_address()
and "ip link set address") expects 0 on success and treats any non-zero
return value as failure.

I audited all drivers under drivers/net/usb/ that implement a custom
ndo_set_mac_address callback:

  aqc111.c        - BUG: returns usb_control_msg byte count (6) [this patch]
  ax88179_178a.c  - OK: returns 0 after ax_write_cmd()
  asix_common.c   - OK: returns 0 (async write to hardware)
  ch397.c         - OK: returns 0
  dm9601.c        - OK: returns 0 (async write)
  lan78xx.c       - OK: returns 0
  mcs7830.c       - OK: returns 0
  qmi_wwan.c      - OK: returns 0
  r8152.c/r8157.c - OK: returns 0 on success (via usb_autopm_get_interface)
  rtl8150.c       - OK: returns 0
  sr9700.c        - OK: returns 0 (async write)
  sr9800.c        - OK: returns 0 (async write)

Drivers that use eth_mac_addr as ndo_set_mac_address (smsc95xx,
smsc75xx, cdc_ncm, rndis, pegasus, usbnet default, etc.) always
return 0 from the netdev op.

As far as I can tell, aqc111 is the only driver that directly returns
the result of a USB control write without normalizing success to 0.

Please let me know if you would like any further changes to this patch.

Best regards,
Hanson Wang

