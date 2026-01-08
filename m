Return-Path: <netdev+bounces-248044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60189D02736
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64A8231C70F7
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5038E5C4;
	Thu,  8 Jan 2026 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GZL0RK/0"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057382D97BA
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870129; cv=none; b=PYIUGJg/UWSkUlWkGde100bl+TMKAQhwWuP2WqxDVaj6Ph0BXKEKCz/LApPanwa0c0rHVZj/CwXwLGkO2/JCH1KMTz5DmEiHVHyEVxM2H19fBvo/QVQitb+wcqhdW8nYtClEsNL0X7wSuZToJtQPt2CdVLfo/ccFFi+aQObQ8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870129; c=relaxed/simple;
	bh=VeQbDWPYOYhZa7ttdL1emC86pVJCV25qdkde4RPb35M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KjQlsuPdmC3q6YGO/7IGXUmpy9FG9dkCvth82OJDFgmx9J5F4KNklj0/vxuOKMUlSX/CfRC372nBJ18KTyt4ssWTwd16CaMa3J9ArgcXr0K6Lhc7+2noJzxTCTwjjAwDdvFVQYj+2wNuJgj33rH0C49SuMoZtqwONO4QIBHPBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GZL0RK/0; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=VeQbDWPYOYhZa7ttdL1emC86pVJCV25qdkde4RPb35M=; b=G
	ZL0RK/02XnKQ6gY/XL3MWWOLpWqdo4TrL0k30/mko/PWRhU8Zo6DCn62evlg5t7d
	LUX/pwHsx/oRLSLOiVYTZPO0yj7t64EkHDYec074yYqeD6xCT9Jny+WCwR48nPyU
	kzU15H2TdwHRZsnseYX2hn/fUpXqWpqZ0I4NVH7ie8=
Received: from slark_xiao$163.com (
 [2409:895b:3920:8117:f3e8:3169:1a11:160b] ) by ajax-webmail-wmsvr-40-118
 (Coremail) ; Thu, 8 Jan 2026 19:01:01 +0800 (CST)
Date: Thu, 8 Jan 2026 19:01:01 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Sergey Ryazanov" <ryazanov.s.a@gmail.com>
Cc: "Loic Poulain" <loic.poulain@oss.qualcomm.com>,
	"Johannes Berg" <johannes@sipsolutions.net>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"Eric Dumazet" <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	"Daniele Palmas" <dnlplm@gmail.com>
Subject: Re:[RFC PATCH 0/1] prevent premature device unregister via
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260108020518.27086-1-ryazanov.s.a@gmail.com>
References: <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com>
 <20260108020518.27086-1-ryazanov.s.a@gmail.com>
X-NTES-SC: AL_Qu2dBfScv0gt5yGYbOkWnUwUgu46UMG3vf8u2IMbV+Uhig/d1RsNW2NiFmny6sieDR+DvAK6dj9i48B6Y61IqIfSuPfEniWsElWo8iE7
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a4d09fa.9614.19b9d445a3c.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:digvCgD3Pzptjl9pB_lTAA--.24392W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6A3wVWlfjm1I4wAA3+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTAxLTA4IDEwOjA1OjE3LCAiU2VyZ2V5IFJ5YXphbm92IiA8cnlhemFub3Yucy5h
QGdtYWlsLmNvbT4gd3JvdGU6Cj5Jbml0aWFsbHkgSSB3YXMgdW5hYmxlIHRvIGhpdCBvciByZXBy
b2R1Y2UgdGhlIGlzc3VlIHdpdGggaHdzaW0gc2luY2UgaXQKPnVucmVnaXN0ZXIgdGhlIFdXQU4g
ZGV2aWNlIG9wcyBhcyBhIGxhc3Qgc3RlcCBlZmZlY3RpdmVseSBob2xkaW5nIHRoZQo+V1dBTiBk
ZXZpY2Ugd2hlbiBhbGwgdGhlIHJlZ3VsYXIgV1dBTiBwb3J0cyBhcmUgYWxyZWFkeSByZW1vdmVk
LiBUaGFua3MKPnRvIHRoZSBkZXRpbGVkIHJlcG9ydCBvZiBEYW5pZWxlIGFuZCB0aGUgZml4IHBy
b3Bvc2VkIGJ5IExvaWMsIGl0IGJlY2FtZQo+b2J2aW91cyB3aGF0IGEgcmVsZWFzaW5nIHNlcXVl
bmNlIGxlYWRzIHRvIHRoZSBjcmFzaC4KPgo+V2l0aCBXV0FOIGRldmljZSBvcHMgdW5yZWdpc3Ry
YXRpb24gZG9uZSBmaXJzdCBpbiBod3NpbSwgSSB3YXMgYWJsZSB0bwo+ZWFzaWx5IHJlcHJvZHVj
ZSB0aGUgV1dBTiBkZXZpY2UgcHJlbWF0dXJlIHVucmVnaXN0ZXIsIGFuZCBkZXZlbG9wCj5hbm90
aGVyIGZpeCBhdm9pZGluZyBhIGR1bW15IHBvcnQgYWxsb2NhdGlvbiBhbmQgcmVseWluZyBvbiBh
IHJlZmVyZW5jZQo+Y291bnRpbmcuIFNlZSBkZXRhaWxzIGluIHRoZSBSRkMgcGF0Y2guCj4KPkxv
aWMsIHdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoaXMgd2F5IG9mIHRoZSB1c2VycyB0cmFja2lu
Zz8KPgo+U2xhcmssIGlmIHlvdSB3b3VsZCBsaWtlIHRvIGdvIHdpdGggdGhlIHByb3Bvc2VkIHBh
dGNoLCBqdXN0IHJlbW92ZSB0aGUKPnBhdGNoICM3IGZyb20gdGhlIHNlcmllcyBhbmQgaW5zZXJ0
IHRoZSBwcm9wb3NlZCBwYXRjaCBiZXR3ZWVuIGJldHdlZW4KPiMxIGFuZCAjMi4gT2YgaWYgeW91
IHByZWZlciwgSSBjYW4gcmVhc3NlbWJsZSB0aGUgd2hvbGUgc2VyaWVzIGFuZCBzZW5kCj5pdCBh
cyBSRkMgdjUuCj4KClBsZWFzZSBoZWxwIHJlYXNzZW1ibGUgdGhlbSBhbmQgc2VuZCBpdCBhcyBS
RkMgdjUuCgo+Q0M6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4KPkNDOiBEYW5pZWxl
IFBhbG1hcyA8ZG5scGxtQGdtYWlsLmNvbT4KPgo+LS0gCj4yLjUyLjAK

