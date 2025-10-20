Return-Path: <netdev+bounces-230801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5FABEFAD3
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90B3D4E2206
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C5221171B;
	Mon, 20 Oct 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgwlOEWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0AD78F5D
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945458; cv=none; b=GJJq/U4cmQRaLJRwojSJtqN0SumZQ+jn+grRZaXjLVVB4z3nu+QuqqAsmNfGPfYqZHJb+BoitKYSEFC5fNArHlqAm2ykDBC+fCdaa2TSyqoE98hyHgEEawHyOGsrhMihKS6SsGT7U49cqvIF9KJBscSUtcZz/4ZBJEnI0NI7juU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945458; c=relaxed/simple;
	bh=Uoj+odkDWVHRyERaqWWHuPTGNKfOOO9OconxC3LLDRc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o2lzIhAmBmd1hyJ5JX5NrnV6vPoTRLKpau/VWZGfM2Whn8XkImLYT7ECrlUEhSTi/EY6BgO1IkzxZqF1HufRDp4l6VLyylKf2MVANg+46Msvjop0zqIJnVjaSa/RU7qX3/5pfiA2OOEpNKPTpcN7BNA4IUmHnAeVTuY3j2O+eRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgwlOEWu; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76e2ea21430so298168b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760945456; x=1761550256; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uoj+odkDWVHRyERaqWWHuPTGNKfOOO9OconxC3LLDRc=;
        b=YgwlOEWu2LaIu+SYEDN+378qmNm/M+uBglRCSQZYkqe5p032C0zvG0/R+qWtr1cmMp
         r5c51nkJwGA/MqoQ/Zz1Hj34HNm5+/dk1N0ub99U1ptHMKzmWwCRe8ICcKXl5sqRro0S
         o9KdB4bughWOicjHUJFqR3CJ8wN5qgpG/qSit67L6+e+7q3awIUvNLxDjwRet+jQUxPf
         K2ugDL9OrMqQRq0xXwO4VliMKjdfh4J70HOpbd5xgKM6AVfVxFozRD4AnkTyQlYll6M3
         2/k7iuzK0jt5wDRkBvQeoGE7fgDMe0GyG3tigakSQMpTT8+KGuHbPCaAh/AYLNl/QQPj
         IeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945456; x=1761550256;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uoj+odkDWVHRyERaqWWHuPTGNKfOOO9OconxC3LLDRc=;
        b=CPhe7ZREJeg7dDE284quF12lCHFRCaKAWpBouiZ/Jq2g8lcZxELdKyw+nzdfyLtLMG
         WQ0E+haiuw5UjD+NyBYiVT/MLQdsBP9RtxJtztV8MdED1qIY99ysxQn+PDo0U2lNoxnd
         7ZEXTKPiLDA68vntD6BvtrFGqTU1FTvr7axEzWJi8dr5r2p0u7vvjL+Z3Rmih54fFV2p
         pNfqJt26Qn2hKMQjbi22ydvx340rT92gtTQ7miYD7ooernsoQN283sbJ2bUrgSt931Lp
         gSiFtBGg6sQp0e9s10cUaRkUSC1BGRsXu4i/66Z959GkwKJ2BeE9Mj6Tq+SUNkhJHoR2
         2knA==
X-Forwarded-Encrypted: i=1; AJvYcCUljWGmOMNCaJdJLdLn96GSpr7fBpoEQHHL86HoeVkKgmZVeRLYZPmfeyZBstSCkMkRzxczTSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtQPRbykDLtMLD4e8RQoFZBkqfbpVEwYwRnGMqzWAU9jN7Jwb
	Z25TswzoQ2RaygUxJ4/YcLMboVhmC0A9yCKAp/iAiDa8/A7niS8CVjrI
X-Gm-Gg: ASbGncukvZ2CP9GooAJSsI+4x8SUVas8r8lDERgVI/eVotuE1jyqVLVi1WgHqGfTkgR
	+iDKgzwIURfwOVKnC6Cqc6ECf/cM61SVWIFdijhbULjpAVOZ1HoKSakObvGPXrGUXXfZnfUfoW0
	/cRlYVIIyQWA1rQOGEs3d2zzMij4nRb9LdfGxiwKDyLqeC3tbGYrmSayYG9rqlNjbSdflX1wRrO
	y+hmYZWWxUF8L9+OATSyiVF2eyC8K0jPzDrsUtZcUjKcZ1u0GXfwmeR2KsMbe4LbdGxtbkIJcf+
	4g+gKwb2kVtQBGv3NWIDZBe+EM68ym9WIyQycGPi+FKRw9A7r4Ovfe77EewwNv67B1bITKFwX90
	Vd/DVG+sW+A+TfcRje75ALHZION9gah26lK5Io5RKrrusAM1Hq0oFUs8Thc/jpA0ydisARLlcjw
	E0I++IyBLTsiNPa0eFq03MTXDHBtU3LGafv0zQt3iZtlyoi/SYTxtYeyg9ugENn52dhIk=
X-Google-Smtp-Source: AGHT+IEgGKzqG1FMj8PNDAYMIcLUNEbNxolVnHG4bXXkueppZEX67j8yB5H0KO1C6Xtw25BHXuCC7Q==
X-Received: by 2002:a05:6a00:2d8d:b0:783:bb38:82f6 with SMTP id d2e1a72fcca58-7a22044bb01mr7761521b3a.0.1760945456185;
        Mon, 20 Oct 2025 00:30:56 -0700 (PDT)
Received: from PH0PR04MB7349.namprd04.prod.outlook.com ([2603:1036:30c:c::5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15878sm7456125b3a.10.2025.10.20.00.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:30:55 -0700 (PDT)
From: clingfei <clf700383@gmail.com>
To: "syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com"
	<syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
CC: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
	=?gb2312?B?zfXEsw==?= <clf700383@gmail.com>
Subject: [PATCH] Fix integer overflow in set_ipsecrequest()
Thread-Topic: [PATCH] Fix integer overflow in set_ipsecrequest()
Thread-Index: AQHcQY7A6K9h5RR5eEO1C57qUuzCgQ==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 20 Oct 2025 07:30:42 +0000
Message-ID:
	<PH0PR04MB7349DA5D7A7A7FBEA8601353FCF5A@PH0PR04MB7349.namprd04.prod.outlook.com>
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

SGkgc3l6Ym90LAoKUGxlYXNlIHRlc3QgdGhlIGZvbGxvd2luZyBwYXRjaC4KCiNzeXogdGVzdDog
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2JwZi9icGYtbmV4
dC5naXQgbWFzdGVyCgpUaGFua3MuCgpGcm9tIGRiMjRmMDk4NTYwMGRiMWY4OGQ1ZDJiNzQyMGYw
NzA3ZDY3ZWEwNWEgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IGNsaW5nZmVpIDxjbGY3
MDAzODNAZ21haWwuY29tPgpEYXRlOiBNb24sIDIwIE9jdCAyMDI1IDEzOjQ4OjU0ICswODAwClN1
YmplY3Q6IFtQQVRDSF0gZml4IGludGVnZXIgb3ZlcmZsb3cgaW4gc2V0X2lwc2VjcmVxdWVzdCgp
CgpzeXpib3QgcmVwb3J0ZWQgYSBrZXJuZWwgQlVHIGluIHNldF9pcHNlY3JlcXVlc3QoKSBkdWUg
dG8gYW4gc2tiX292ZXJfcGFuaWMuCgpUaGUgbXAtPm5ld19mYW1pbHkgYW5kIG1wLT5vbGRfZmFt
aWx5IGlzIHUxNiwgd2hpbGUgc2V0X2lwc2VjcmVxdWVzdCByZWNlaXZlcwpmYW1pbHkgYXMgdWlu
dDhfdCwgIGNhdXNpbmcgYSBpbnRlZ2VyIG92ZXJmbG93IGFuZCB0aGUgbGF0ZXIgc2l6ZV9yZXEg
Y2FsY3VsYXRpb24gCmVycm9yLCB3aGljaCBleGNlZWRzIHRoZSBzaXplIHVzZWQgaW4gYWxsb2Nf
c2tiLCBhbmQgdWx0aW1hdGVseSB0cmlnZ2VyZWQgdGhlCmtlcm5lbCBidWcgaW4gc2tiX3B1dC4K
ClJlcG9ydGVkLWJ5OiBzeXpib3QrYmU5N2RkNGRhMTRhZTg4YjZiYTRAc3l6a2FsbGVyLmFwcHNw
b3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRp
ZD1iZTk3ZGQ0ZGExNGFlODhiNmJhNApTaWduZWQtb2ZmLWJ5OiBDaGVuZyBMaW5nZmVpIDxjbGY3
MDAzODNAZ21haWwuY29tPgotLS0KIG5ldC9rZXkvYWZfa2V5LmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9uZXQva2V5
L2FmX2tleS5jIGIvbmV0L2tleS9hZl9rZXkuYwppbmRleCAyZWJkZTAzNTIyNDUuLjA4ZjRjZGUw
MTk5NCAxMDA2NDQKLS0tIGEvbmV0L2tleS9hZl9rZXkuYworKysgYi9uZXQva2V5L2FmX2tleS5j
CkBAIC0zNTE4LDcgKzM1MTgsNyBAQCBzdGF0aWMgaW50IHNldF9zYWRiX2ttYWRkcmVzcyhzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBjb25zdCBzdHJ1Y3QgeGZybV9rbWFkZHJlc3MgKgoKIHN0YXRpYyBp
bnQgc2V0X2lwc2VjcmVxdWVzdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDhfdCBwcm90bywgdWludDhfdCBtb2RlLCBpbnQgbGV2ZWwsCi0gICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCByZXFpZCwgdWludDhfdCBmYW1pbHksCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCByZXFpZCwgdWludDE2X3QgZmFtaWx5
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgeGZybV9hZGRyZXNzX3QgKnNyYywg
Y29uc3QgeGZybV9hZGRyZXNzX3QgKmRzdCkKIHsKICAgICAgICBzdHJ1Y3Qgc2FkYl94X2lwc2Vj
cmVxdWVzdCAqcnE7Ci0tCjIuMzQuMQ==

