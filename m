Return-Path: <netdev+bounces-290378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDCUAdD2DmopDwYAu9opvQ
	(envelope-from <netdev+bounces-290378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:13:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1C15A4994
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8F2930AB9D6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B393C9894;
	Thu, 21 May 2026 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jglC3X2s"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80924339844;
	Thu, 21 May 2026 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365180; cv=none; b=G+YtbRsOSe8mMMvKsAVS37YvKUYxNmvC5aWkAHHp1teoX9nbQU8Kf2InQQVzTFV8nExTDJX2YAv6Xe9h8RddUZvJ9zNDPV+FvBeja5m6DkOZPAvELgYuM71iOu13wrK7akHNGIe0EOKPIgYHTxbaM+NskwvGJEH1R+o0uzMyufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365180; c=relaxed/simple;
	bh=EEY643ADvzcpTDpqhJHYrXL+kk2g71YJrmSriqpKYBc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ge7V1nOlXJmi1f00XU5+JbgXdRk+LI8Iqtd+2xsayGmJ5BjIleb2ky6BnE9AZwG2vp2etEcJqUwSnaxWbRFH8Vpy5YnWtm1ASgObPzLDBU0u7NXqVfibf5ihIFbdavoxJHy1SJucjxnYr+So4JVBIaR9P6rFBsC8TzjklZQLXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jglC3X2s; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EEY643ADvzcpTDpqhJHYrXL+kk2g71YJrmSriqpKYBc=;
	b=jglC3X2sgxzfAIocgG9eJkmmmcVRL9rkqt4oCEZGbEcif1aIEknOn38jV9IqWNjWbzo5+g+yC
	aZlihugxJXDPVdX/YlisfMIZKp1YXAI0yU54QSbrcTDbKG5oCWCmziABAaag9C1JaDN05xIEHxu
	mxSjkrs7qX2oNOubyPd6WVM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gLn4B31KlzLlSL;
	Thu, 21 May 2026 19:58:34 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 19F3140565;
	Thu, 21 May 2026 20:06:16 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 May 2026 20:06:15 +0800
Received: from dggpemf200012.china.huawei.com (7.185.36.146) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 May 2026 20:06:15 +0800
Received: from dggpemf200012.china.huawei.com ([7.185.36.146]) by
 dggpemf200012.china.huawei.com ([7.185.36.146]) with mapi id 15.02.1544.011;
 Thu, 21 May 2026 20:06:15 +0800
From: tanjingguo <tanjingguo@huawei.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chenzhe
	<chenzhe@huawei.com>, "malin (R)" <malin89@huawei.com>, michenyuan
	<michenyuan@huawei.com>, cenxianlong <cenxianlong@huawei.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net] xfrm: esp: restore combined single-frag length gate
Thread-Topic: [PATCH net] xfrm: esp: restore combined single-frag length gate
Thread-Index: AdzpGjZ59NlxNTA8Q1unEJo+/Nc3cQ==
Date: Thu, 21 May 2026 12:06:14 +0000
Message-ID: <b43087ad8088496eb18d19bfd80790f8@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.06 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290378-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:mid,huawei.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[huawei.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanjingguo@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7B1C15A4994
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGksIFNhYnJpbmEuDQoNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpJIGhhdmUgc2VudCB0
aGUgdjIgcGF0Y2ggd2l0aCBiZWxvdyBsaW5rOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0
ZGV2L2FiNGM1ODA4NDc4ZDQ4OTc4MjkyYzMxOGQ4NWM0NDg0QGh1YXdlaS5jb20vVC8jdQ0KDQo+
IG5vdGU6IHBhdGNoZXMgdG8geGZybSBzaG91bGQgZ28gdGhyb3VnaCB0aGUgImlwc2VjIiB0cmVl
LCBub3QgIm5ldCINCj4gKHdpdGggdGhlIHN1YmplY3QgcHJlZml4IFtQQVRDSCBpcHNlY10pLg0K
DQpUaGFua3MgYWxzbyBmb3IgcG9pbnRpbmcgb3V0IHRoYXQsIEkgaGF2ZSBzZW50IHYyIHdpdGgg
Y29ycmVjdCBwcmVmaXguDQoNCj4gSWYgSSdtIGZvbGxvd2luZyBjb3JyZWN0bHksIHRoZSBpc3N1
ZSBjb21lcyBmcm9tIHRoZQ0KPiBza2JfbGVuX2FkZCh0YWlsZW4pPyBTbyBlc3Bfb3V0cHV0X3Rh
aWwoKSBkb2VzIHNrYl9wYWdlX2ZyYWdfcmVmaWxsKCkNCj4gd2l0aCBbd2hhdCB3ZSBjaGVja2Vk
IGluIGVzcF9vdXRwdXRfaGVhZCgpICsgdGFpbGVuXT8NCg0KWWVzLCB5b3VyIHVuZGVyc3RhbmRp
bmcgaXMgY29ycmVjdC4gZXNwX291dHB1dF9oZWFkKCkgYXBwZW5kcyB0YWlsZW4gdG8NCnRoZSBz
a2IgYmVmb3JlIGVzcF9vdXRwdXRfdGFpbCgpIHJlYWNoZXMgdGhlIG91dC1vZi1wbGFjZSBhbGxv
Y2F0aW9uIHBhdGguDQpJbiBJUHY0IHRoaXMgaGFwcGVucyB0aHJvdWdoIHNrYl9sZW5fYWRkKHNr
YiwgdGFpbGVuKSwgYW5kIGluIElQdjYgdGhyb3VnaA0KdGhlIGV4cGxpY2l0IHNrYi0+bGVuIC8g
c2tiLT5kYXRhX2xlbiAvIHNrYi0+dHJ1ZXNpemUgdXBkYXRlcy4gQWZ0ZXIgdGhhdCwNCmVzcF9v
dXRwdXRfdGFpbCgpIGNvbXB1dGVzOg0KDQogIGFsbG9jc2l6ZSA9IEFMSUdOKHNrYi0+ZGF0YV9s
ZW4sIEwxX0NBQ0hFX0JZVEVTKTsNCg0KYW5kIHVzZXMgdGhhdCBzaXplIGZvciBza2JfcGFnZV9m
cmFnX3JlZmlsbCgpLiBTbyB0aGUgcGFnZS1mcmFnIGZhc3QgcGF0aA0KbmVlZHMgdG8gdmFsaWRh
dGUgdGhlIGNvbWJpbmVkIHBvc3QtdHJhaWxlciBkYXRhIGxlbmd0aCwgbm90IHNrYi0+ZGF0YV9s
ZW4NCmFuZCB0YWlsZW4gaW5kZXBlbmRlbnRseS4NCg0KPiBuaXQ6IHRoZXJlJ3MgYWxyZWFkeSBh
biBhbGxvY3NpemUgdmFyaWFibGUgaW4gdGhpcyBmdW5jdGlvbi4gbm8NCj4gc2hhZG93aW5nIHBs
ZWFzZS4NCg0KWW91IGFyZSByaWdodC4gVGhlIG5ldyBhbGxvY3NpemUgdmFyaWFibGUgaW4gdjEg
c2hhZG93cyB0aGUgZXhpc3RpbmcgdmFyaWFibGUuDQpJbiB2MiBJIHdyb3RlIHRoZSBjb21iaW5l
ZC1sZW5ndGggY2hlY2sgZGlyZWN0bHksIGF2b2lkaW5nIHRoZSBzaGFkb3dlZCB2YXJpYWJsZS4N
Cg0KVGhhbmtzDQo=

