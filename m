Return-Path: <netdev+bounces-171623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D305DA4DDFD
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7451782B8
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C61200B99;
	Tue,  4 Mar 2025 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VkRhwj8h"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C561FF5F3
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091605; cv=none; b=lz1KY9VZeaLwJpEku6LRWecj+sAxnGpUc8ml1dDWaRSkfZnCcwlTwCqkV0s8AWeahZQml4AVBSfwkncVzT6P1RXRcoT+jZWcbMQPNSrxmgNeysvTOz6M4LTCM/ngVCSjLsnhX1OSzxMD3oNyt1SXiTNOShfTVQnjfjBfPBw1NjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091605; c=relaxed/simple;
	bh=3YlAxAE2YbWWJgC7s273kR+6UMcvkOwkPhMJ4M16UsE=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=babem9nud/CGgURueOmgXTn3mdQ2X1/c6jjX8UvY2hJzIO6lTFTpBa82hSCuEEHcxVV51qFOUFKAv68sUuj171f5YkhaBMQpDrzCw6loAdUMiQLNmb/IwvRVkQLByX4fvM3QTLJZlld0xrPV1lb16h9PZmOBi51fjlEQh7PIBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VkRhwj8h; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741091600; bh=3YlAxAE2YbWWJgC7s273kR+6UMcvkOwkPhMJ4M16UsE=;
	h=From:To:Subject:Date;
	b=VkRhwj8hdle73Ia6fl9FIHsXLKzfF7fp+jafQxL0qpROXw3zr5T3ymctRVYhqsFau
	 8yjpWLf6xgAYhNp6EkSYDu4X/xcHvux5ovVoOydu/UUEICqgsCxMSgW8E+vxZ2UiKI
	 zEvEpFUx7w0ZYtNpMFVgZb8C4/sGVo8K96SJ8Yms=
X-QQ-FEAT: oHWrrGTW1dCni6VLWI7Xi3lwP5c1dnPf
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: MFuljud3PUW4EHVQZqpniSQ=
X-QQ-XMAILINFO: N6tmAlkxtqcd1RYE7ZiLzY7Lw6tRdpXhVk9+Hz77o1EVYTKrnqC6hUqHe2CZh1
	 C6Zrom9b5pps1iDsmsJpAVXvUET82apKru9S7YqrNm4/BMD5dt85BFCjuFno+IqKTfLYl/U1dAX/R
	 +TcrQCxibq1CvqQFcy8WPooIbI9eCvANi3rwO7h0baIgtrfHauNVltdQ0us2Q0ETeMAF8spFJGQUj
	 I2STjzrQXTwgNqNrEKWZluMA92/4CjrUKIFNvUMO/i69YJHk/tf0T3RexRirrIbRYRxhEDsAjPDn+
	 gB0OagWGkRAC2YIl1ZSdRSIaMuiI+mChGsCWLO1Tn/sSRXD6mu0Xs7AiPJs395Dth/WcIzgG50PFd
	 ocACv4SI7+38GhFyXJmLMpwRVPaPE3+IIivtxZF5ErKldVEf63hInfI9HWwFQi7RPEyuBjexcFZE0
	 E4cRIlfg2UBE0OCgLDdxm1O3IVqx64q2DIoa2iYrOkOyidCXTveOMvpaW6uMHXcaVaUiHnpgKeRDh
	 LSqCkmvQQnxxIED+7s9U83K+y+yR29tcMs+80DHMOAh0zI3q+8OuzhkunmHArLXL7w+D21APrDfqJ
	 tYeHrO9fJEbTFX7/+BT2mMo0kdcrIfioGUCUWxgEhRVO4yufczcvwPI8YkeUlhFK+lPb9UVTKKuxd
	 fG/JSPtEMUZNO/G/HON8EpenWq+57LVDFsUU0Ko8KOZ51SVAReIP0xNiis5npZrq/ch2XdovuftlJ
	 2ecEdDrFlkVaWMAsnMNHnkV1yYB96KTob31lYLg+StQ2asByiITbbb2l5mulMuOACyVIwgvHk1UTw
	 ECwW/U3AbcOJyWHNcgS9101KDr5SJURCfVwGL56ff+heovlB6FW0y0HjdTT1HeWWTkpvMDH6rn+Si
	 1dRJZTUOkbQKvTQJRCnjSwdJL2LLkkQarZ9mQfBjCAC69Mmo0J59x5GJquSdeOaaQvLhnvnMZUQTO
	 wQxKDTI2jtpsfh5PpLaGx78mfmOUTg+fi6hNhEgDH2RydK2i3gLlqkVFRsUdA=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail284t1741091598t3256532
From: "=?gb18030?B?ZmZoZ2Z2?=" <744439878@qq.com>
To: "=?gb18030?B?d2Vuamlh?=" <wenjia@linux.ibm.com>, "=?gb18030?B?amFrYQ==?=" <jaka@linux.ibm.com>, "=?gb18030?B?YWxpYnVkYQ==?=" <alibuda@linux.alibaba.com>, "=?gb18030?B?dG9ueWx1?=" <tonylu@linux.alibaba.com>, "=?gb18030?B?Z3V3ZW4=?=" <guwen@linux.alibaba.com>, "=?gb18030?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?gb18030?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?gb18030?B?a3ViYQ==?=" <kuba@kernel.org>, "=?gb18030?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?gb18030?B?aG9ybXM=?=" <horms@kernel.org>, "=?gb18030?B?bGludXgtcmRtYQ==?=" <linux-rdma@vger.kernel.org>, "=?gb18030?B?bGludXgtczM5MA==?=" <linux-s390@vger.kernel.org>, "=?gb18030?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?gb18030?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: =?gb18030?B?QWRkaXRpb25hbCBkZXNjcmlwdGlvbiBhYm91dCBi?=
 =?gb18030?B?dWc6IKGwS0FTQU46IG51bGwtcHRyLWRlcmVmIFJl?=
 =?gb18030?B?YWQgaW4gc21jX3RjcF9zeW5fcmVjdl9zb2NrobE=?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
Date: Tue, 4 Mar 2025 07:33:18 -0500
X-Priority: 3
Message-ID: <tencent_DB489820B9DDDC69F6AFCC12649BDADE7808@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x

U29ycnkgYWJvdXQgdGhlIGJ1ZzogobBLQVNBTjogbnVsbC1wdHItZGVyZWYgUmVhZCBpbiBz
bWNfdGNwX3N5bl9yZWN2X3NvY2uhsCBpbiBteSBsYXN0IGVtYWlsIGFib3V0IHRoZSBidWcn
cyBzdWJzeXN0ZW0gZGVzY3JpcHRpb24gZXJyb3IgKG1pc3Rha2VubHkgd3JpdHRlbiBhcyBi
Y2FjaGVmcyBmaWxlIHN5c3RlbSksIGl0IHNob3VsZCBhY3R1YWxseSBiZSByZWxhdGVkIHRv
IHRoZSBTTUMgc3Vic3lzdGVtLg==


