Return-Path: <netdev+bounces-143712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7E9C3C92
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 12:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F4C1F21F73
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C818660C;
	Mon, 11 Nov 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Js7EjRbF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279015B554;
	Mon, 11 Nov 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322806; cv=none; b=loH45R6efgolZV/Aeuub1up8EJLcADQbZ2oz1Y1UnUpQZ1QZMVhbfoQ8JxibRL2itKGHDT0ZSQS42OwCsa0BRcu1WMoj7sUFu5LMk27kPsQbETFh7C0yRCvlYjXy0IwX2YT8e+4bZVkaexXUkhSJ/pDZW63R7xkcB/VsugCb7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322806; c=relaxed/simple;
	bh=WURrtf0NMt1WYhBC3LGoAw0srDrFnd+O8AWYApNJrdw=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=jeBYkIjfki7xLtSRlFUgcz9BO956fcwCmywlp7bhydWltup8Sdt2m8a1yAK4fbPg/SBZE2rjsP7lxoCM9C6oWvw8aVEHITqBkS4CieDAAKWr9ID0GqPQ2Th8FPpoYKyUJxi6JxsCWfekSNpfIQLBYcOqiLDST84y7WvacmKMBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Js7EjRbF; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731322791;
	bh=WURrtf0NMt1WYhBC3LGoAw0srDrFnd+O8AWYApNJrdw=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=Js7EjRbFCnZtwqK70iJEv1VRJ1Lc924wyrFjgr22vP3yiu2aGq4yd8HOClBBCBC5b
	 jQzKh/0DEXyrihXUwMHZV4Y4eggdjKm1Be3isZKJkzmnLmXunPJSI6W34i05SpBNu5
	 59PdbP5e73b7aF4WydM/x60kB+2J9mGTXcmPAdjI=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: SjlQqd0Lqwfm5luGlfnOgxZrdN/y7uwlSvBS70ky8t8=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1731322770t2557572
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?UnVzc2VsbCBLaW5nIChPcmFjbGUp?=" <linux@armlinux.org.uk>, "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>
Cc: "=?utf-8?B?YW5kcmV3?=" <andrew@lunn.ch>, "=?utf-8?B?aGthbGx3ZWl0MQ==?=" <hkallweit1@gmail.com>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?Zi5mYWluZWxsaQ==?=" <f.fainelli@gmail.com>, "=?utf-8?B?c2ViYXN0aWFuLmhlc3NlbGJhcnRo?=" <sebastian.hesselbarth@gmail.com>, "=?utf-8?B?bXVndW50aGFudm5t?=" <mugunthanvnm@ti.com>, "=?utf-8?B?Z2VlcnQrcmVuZXNhcw==?=" <geert+renesas@glider.be>
Subject: Re: [PATCH] net: phy: fix may not suspend when phy has WoL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 11 Nov 2024 18:59:29 +0800
X-Priority: 3
Message-ID: <tencent_4B3AACEA45FBC48A019C11B2@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
	<ZzHW4wOAH769WSJ0@shell.armlinux.org.uk>
In-Reply-To: <ZzHW4wOAH769WSJ0@shell.armlinux.org.uk>
X-QQ-ReplyHash: 3258678409
X-BIZMAIL-ID: 15323754145262448692
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 11 Nov 2024 18:59:31 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NNCgUTg3ctKTaAVBsYrRRZqyGi9zN4ZgIkn/3VDMMo5w/rEWDJNZL0FS
	OZNa6tnxlPJDPm5gTDN7EHPNzXxRilKjQxrPxqKiJw+v/LsHep/ePkQYHMZT2YgS8bn7sTv
	xNIsa6e5+LOeh2fRiMV1Bwuavd7Skx6ISSYz1b2UAdQlmaVJlLvyHsFV1oEmD9Y0URwPLt5
	bkKcv4xvo8fxtP7oScMBDWd2UjSDT0rlEXUIRz3JKUxDnnCUWTXHeIKBlsEDzIZytA0ZEQK
	dlcBADqoS6II3aG8sjqTcRew/IUTIL4mfmYdcBsLFLJDpQ1J9mfQq8bHND6hVVHOFC5wgNv
	WlN/pAghJXaF2YJ42tKd5OYeNV1fkv7RNyPLouOUUBr57QJsLe0cd4j445Mm6qYV2+NpdO4
	775xKw6TZ5ZGxGaHJcGqPCaiyE7/+hTyrFwE0c5iWsmbBS/coJA/dMFzfsCMFdywWO2Pl6P
	/jlyiBm7Rf7V3H/lHY9kANwwqaHjKoSDYvTUGvz3SzDZ+sQvwX3ZKbcv6bUec0oK/yDGwiI
	T/STWSeLMBGsgzwV/cqUTgYkgsCyD21hViZNl//HqP/dFFrx4fIh6PQBTZglTxJW7MM5Qd0
	0mV52nXcSl5L4prvw/rOYbKFpjVLXFpkO88OOdYsK+k/JngkMoT7HdHFTJGCVPTkn9gJnud
	j4Tb80lHng5LJVOUPThC9ZyaJpf3xo3/fQT0MX2EutBnkMLsrJFKt/QlBXoZV1Wjmf9XN/M
	Jn9u0WP4EdvP+WyBtU7jXWQNqS0SgxzLc+3xGsj02/d+F2Xr2AtHi6N81/wzl8YSthvhVHG
	s0/6ttJAx9LGJfUs4hamJt3bLJJc2oJHdU0oT1V4fuDLQWggST1z8xKasOnFvlE6sVrasb6
	YD0uK8bf9pe0afBk1ru5cfXUTlZvpz27yD3xWXUMRTxUPOi/lTJzf4G+/dBs8aBZC1FGUJR
	AzE8NcpJenUSwxJcmFu9nzGwaADPCXzXCYfuyaeDrDZ14LFTPBw1kacPwU7Hp/tiJl6gW1q
	jGvgJ9WAUrnqI3eyAGDfK7tMg/O9T8C/29YwCCRfSuiqzhHEBy
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

V2VsbCBxdWVzdGlvbiwgYnV0IEkgZG8gbm90IGtub3cgYW55IGtub3dsZWRnZSBhYm91dCBw
aHlkcnYtPnN1c3BlbmQgbWF5IG9yIG5vdCByZXR1cm4gRUJVU1k/DQpBcm91bmQgdGhlIFdv
TCBzdGF0ZSBoYW5kbGluZyBpcyBiZWNvbWluZyBjb21wbGV4IGZvciBjaGVja2luZyB0aGUg
c2FtZSBsb2dpYyBpbiBwaHlfc3VzcGVuZA0KYW5kIG1kaW9fYnVzX3BoeV9tYXlfc3VzcGVu
ZC4NCkkgc3RpbGwgZG8gbm90IGtub3cgd2h5IHRoYXQgd2UgbmVlZCB0byB1c2UgLUVCVVNZ
IGluIDExIHllYXJzIGFnbyANCmNvbW1pdCgiNDgxYjVkOSIgbmV0OiBwaHk6IHByb3ZpZGUg
cGh5X3Jlc3VtZS9waHlfc3VzcGVuZCBoZWxwZXJzKQ0KSWYgaXQgaXMgbm90IG5lZWQsIG1h
eWJlIGEgc2ltcGxlIHNvbHV0aW9uIGlzIGNoYW5nZSBFQlVTWSB0byAwIGFuZCBhZGQgYSB3
YXJuaW5nIHByaW50Pw0KDQpBbmQgZGlzY3Vzc2luZyB0aGUgcGF0Y2gsIGl0IGlzIHNhbWUg
YXMgY29tbWl0IDRmNTM0YjdmMCBpbiB2Ni4xMi1yYzEsIGFuZCBpdCBjb250ZXh0IHNob3Vs
ZCBiZWZvcmUNCiJpZiAoIWRydiB8fCAhcGh5ZHJ2LT5zdXNwZW5kKSIgY2hlY2tbSXQgZ29l
cyB3cm9uZyB3aGVuIEkgbW92aW5nIHRoZSBwYXRjaCBmcm9tIG91ciBkaXN0IGJyYW5jaCB0
byB1cHN0cmVhbSBicmFuY2hdDQosIHNvIEkgc2VuZCBhIE5BSyBmb3IgdGhlIHBhdGNoLg0K
DQpCUnMNCldlbnRhbyBHdWFu


