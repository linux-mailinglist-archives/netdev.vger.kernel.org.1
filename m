Return-Path: <netdev+bounces-230786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1908BEF67E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 08:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5819B1883DDE
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565A2D0C9B;
	Mon, 20 Oct 2025 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UJeTlkdQ"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C31DE4E0;
	Mon, 20 Oct 2025 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940489; cv=none; b=Xnia/E8orSHNztxARRhtLttT0ZcvKXSI3bHYQd2WEg4aPlVS10lctBW3bMYC2rx/qLTVK+G7+gM52CN4miN1fg7JYXRvgMWb5BSUYKc8x1NtW7W47Bk47tP61ddC1xmiMyqZcu1gCBTUaosYYRjoWEY4S6PymqdDS2vXGmHxb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940489; c=relaxed/simple;
	bh=Dyz1W/f2zxWrT8+4+brAcC8fYyuT2aU3M1t4h4dqptI=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=KxbNvqOdb82xraO6z3OMWgbUtrrSc3OWsZDeQjD47hU70d3t1BpTlGpi2yzls3u0A0JGT0E97xbK8VYxPDdWXMrc00oaCOXUDwRM4QGp98c53QY8HhtsdctyGUlYukrnzSP3H6kKrz8DU74+V3bQaHsnG+q/rXWNXu0rdu5ur2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UJeTlkdQ; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760940173; bh=Dyz1W/f2zxWrT8+4+brAcC8fYyuT2aU3M1t4h4dqptI=;
	h=From:To:CC:Subject:Date;
	b=UJeTlkdQvCnDAxRP117WK0WJMyl4nWk6mNYw1HRuzkf9j8CNHw87VYo5ht9JLEhYk
	 1YnvJB+sIveiW581q13dp4r7KRSiduSM+wNjTlyX7Gy+2xaDufRtz7NybHL9DHDiHO
	 ZRlUrvvzWLLCt/5gH8xDbl8KwQN/s/LFOyRUEmI0=
Received: from MN2PR13MB3248.namprd13.prod.outlook.com ([2603:1036:302:4098::5])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 40B506F; Mon, 20 Oct 2025 14:01:00 +0800
X-QQ-mid: xmsmtpt1760940060tcv183mbu
Message-ID: <tencent_03EA78899E616FF00CC749FE8840EA81410A@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLCtUnA5pHCQQ1KoY191fLEtCUuYq9LdprZJqOKxrrneemYsmA/O
	 HL7+yPQfPGr7YOZd9jBV5xCAiI+GW7/Usc70Hk3JYr8hh0GYx1GCGpKT+XpPTYNk9FdjyMDDpUqT
	 9oV47eSrL9os7hq2DhTLLjnnsj0Cj0tSRIdfW1IYjfzxN5+ymwnMXTQnyR7mkNARt9DgrS3UigZp
	 2IFq6HqkaDE5DupD4LpvmzljOSIBZwSkxinVRmfEX4l6On43tXuyfphDga+ehVCJnrwSg8C0KO8S
	 Ts6uo15JNxCmxtLdruivf0r1qCX585mcGESYM+qWY2T8crNW3AFszEfoF79o2AiPkZX7mvu/L7+g
	 Zd3nz0Pf+hVo9n+J9wNghWPvUFiaYtKPtIvXYsQ8rjLQur/O/tjgp0/KirmszOAZTv6v1hStqRbf
	 68HfoB7yU10EaD/996aBqO89HkX5covQ+SaVASBC+smc+3PSj56Gev44MOo88f9P2C+zS2OcG+Ti
	 FJmCv3JhHNIW/eh1iDUeZuRKKnzggqN991O/zD2sAI5jZShg1hUvhhLYAp701dF8I7nESNnyZS+L
	 v5ciCPdEwvKKURf8hK7ywPzibcibDKBLWxQQgafdY0zM4LWhIac1kTNEJPPXwvCc58Iu28JgHulM
	 WeTRuap36bAXcWfq0X5vTO88rjE8Q4PjPgR5A4/JRAJc2/DMGpq73QX4eKZ31gzNxAUgBYd+m60N
	 sbvIo8V6yPHikfaNIdbCqVLyF5cDPYiGHRQbM1Lt1+xZ1eIKeznewsX120sScIl2G04wDNjhyfO1
	 h9BZBlpjuMb2l9Ys7zazstpXT+MgnIZfMLGcxH5E2BTClCUeOJChbkQ1EsmRp9FY/4w1wdpZ6Gsx
	 LLvSEQqJi13nDa+pnYF7Pp4Is2f5E/hwbITsmFbaULdPAYhrVhRIjCmRWi+NZIuPA84U02uh3yte
	 dsz3tTwL9eIKCWeM5eTtqwRRjiKrWHJ3W+XZtWRkBox2Y4qLR7TbOFRQMtNBrg
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: "1599101385@qq.com" <1599101385@qq.com>
To: "syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com"
	<syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
Thread-Topic: [syzbot] [net?] kernel BUG in set_ipsecrequest
Thread-Index: AQHcQYYQgL/uYpVJrEOgPG3hTd8oew==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 20 Oct 2025 06:00:58 +0000
X-OQ-MSGID:
	<MN2PR13MB3248538C05DE846BDF9C368FFBF5A@MN2PR13MB3248.namprd13.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I3N5eiB0ZXN0OgpGcm9tIDJlZGZjODgzM2U0M2NkZjVjY2RhOGJkNWJlM2RhNWQxYmJkYzY5YzYg
TW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IGNsaW5nZmVpIDwxNTk5MTAxMzg1QHFxLmNv
bT4KRGF0ZTogTW9uLCAyMCBPY3QgMjAyNSAxMzo0MDozNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IGZpeCBpbnRlZ2VyIG92ZXJmbG93IGluIHNldF9pcHNlY3JlcXVlc3QKVGhlIG1wLT5uZXdfZmFt
aWx5IGFuZCBtcC0+b2xkX2ZhbWlseSBpcyB1MTYsIHdoaWxlIHNldF9pcHNlY3JlcXVlc3QgcmVj
ZWl2ZXMgZmFtaWx5IGFzIHVpbnQ4X3QsIApjYXVzaW5nIGEgaW50ZWdlciBvdmVyZmxvdyBhbmQg
dGhlIGxhdGVyIHNpemVfcmVxIGNhbGN1bGF0aW9uIGVycm9yLCB3aGljaCB1bHRpbWF0ZWx5IHRy
aWdnZXJlZCBhIAprZXJuZWwgYnVnIGluIHNrYl9wdXQuCgpSZXBvcnRlZC1ieTogc3l6Ym90K2Jl
OTdkZDRkYTE0YWU4OGI2YmE0QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KQ2xvc2VzOiBodHRw
czovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9YmU5N2RkNGRhMTRhZTg4YjZiYTQK
Ci0tLQogbmV0L2tleS9hZl9rZXkuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9rZXkvYWZfa2V5LmMgYi9uZXQv
a2V5L2FmX2tleS5jCmluZGV4IDJlYmRlMDM1MjI0NS4uMDhmNGNkZTAxOTk0IDEwMDY0NAotLS0g
YS9uZXQva2V5L2FmX2tleS5jCisrKyBiL25ldC9rZXkvYWZfa2V5LmMKQEAgLTM1MTgsNyArMzUx
OCw3IEBAIHN0YXRpYyBpbnQgc2V0X3NhZGJfa21hZGRyZXNzKHN0cnVjdCBza19idWZmICpza2Is
IGNvbnN0IHN0cnVjdCB4ZnJtX2ttYWRkcmVzcyAqCgogc3RhdGljIGludCBzZXRfaXBzZWNyZXF1
ZXN0KHN0cnVjdCBza19idWZmICpza2IsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
OF90IHByb3RvLCB1aW50OF90IG1vZGUsIGludCBsZXZlbCwKLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IHJlcWlkLCB1aW50OF90IGZhbWlseSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQzMl90IHJlcWlkLCB1aW50MTZfdCBmYW1pbHksCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCB4ZnJtX2FkZHJlc3NfdCAqc3JjLCBjb25zdCB4ZnJtX2FkZHJl
c3NfdCAqZHN0KQogewogICAgICAgIHN0cnVjdCBzYWRiX3hfaXBzZWNyZXF1ZXN0ICpycTsKLS0K
Mi4zNC4x


