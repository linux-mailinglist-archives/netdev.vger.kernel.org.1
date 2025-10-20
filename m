Return-Path: <netdev+bounces-230781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110ADBEF633
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 08:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DF3E0622
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 06:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123329A9C3;
	Mon, 20 Oct 2025 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="u0FRH+Lu"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194301A7264;
	Mon, 20 Oct 2025 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940212; cv=none; b=WtxVwYyR//p0GtVyK8ZN5uTJtIFKrjzOG+1VcmRo0QpRgLfzPeSyLCoS2zmKjHFzazc9b3TOUPg9EVGBllK9IMw4BHjZ/OidExABlooksayq1NTuFojZdx6vha9AvDPeOpFQV5oiSXyFN+E99pSZDJpPMx1JPHfZjUIycxNs1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940212; c=relaxed/simple;
	bh=Abf/juTFHekFeCdZgzz+/03QcOuFUx77qS6NIgXzclk=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=n0PuaBlnAwQ04qYsFZFcwZWXqcgoSECYEdgQytUxp+yGwRQOoRtI0qdVuUj3QogXmJJc28fSB8crg2bQdSQQ3lDjZzT/bgzT9CjOrFjsRWhaHguGRlnXuz0ZQUyh/68g6d2dnMrEZkz8dCpMt7viLt50mNRhmufrQljsEDyvYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=u0FRH+Lu; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760940204; bh=Abf/juTFHekFeCdZgzz+/03QcOuFUx77qS6NIgXzclk=;
	h=From:To:Cc:Subject:Date;
	b=u0FRH+Lu9Yq4OU7LEF03Wei96EhA61mVThzgW+DZmWmeiHP2BxkEzdvpFsuiElKEB
	 0oMpit5MeeRbYiJ24TcwLOFUuE/qaoyAQcPkVXZ6kwLJGYeqPwVk+qq1lNHH8SXltv
	 nHNzlaGPXYCMzvUo5T1Txdrkw20snqbawH572YpM=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-XMAILINFO: MHyJd5qrf7Bo9Fu1oZ6VJcYHvKX3J0IffFPrtHBqdnufzIpFJ9f07dOgqE/4XS
	 1ZdZKdUwe13cQ/C25Xc+1isucXp1h/kibjkp7MwjpOmFOvOOL9PJsV9IiyR8nlpj01HJNf9d/Wc73
	 zU1ilDZDQFWMvH2yNC3efBJ7fvYfZyAkfqiIoNq3cKqfutQSen7aA39YsDQ2bxJs5DxLfJYn9Pysy
	 CeW2Y3sq5Ma3/LYSeVhKQPglM7sIUFnB80BA2PG/L6hdTZU7wf7HmU82gTRirpHkw++jgkis8V/ll
	 IN0H70TbLXaT833oGjQ8e2KI7arXjSAkpNTB97Oij7hR4l0Il649FnJ9tIxATGBqWfkypZJdVB8v7
	 bEWprzfW4jmE5EKqaDgU6vPVZFN661NQpcm/hGW7d9yg+alcGyHQbcbaB6nef/JDrUatr17nLvFWY
	 qhtlC5GUCb+0VuV0tyB/aVwNS2fnt/gG93YSuIEEAOqgdvQICani4aZMnbfb1avtSxS0DeyAmkWro
	 UGhM4e2otqnkdG/HR6xgflB/p5ccc6fLB+05xMG9UvvagELDYczDmuQkp9rld2qdXRL612wYSV9/F
	 sNBz8APRrcTbUwk8xQMcZVGnGGDkiYVxIqB+iAxl7Xpe18xh1D2sM1pg2o4h/dyaxcmxPgggJdxqG
	 k4BGqImiFU2Xk/35BLZKY7XtAW5v8PGpG6EVNv8LmzHrKIQwavP5Barbc15/FdkxUd1CiM0ze809u
	 HRwH1QJ6vqod+nxF0qSl7g8HlvhQVOo9RQUcGM+/FndRe5OHuFXpD9kwXiGgn659s+0CopJXzFLq9
	 Ba+8t55lCys8pmqt6yXe5MlKHGxmHJt4Xt3zOTapYU668lZdFdMlESfGK+ZlF+K2Iz2C+ztciQJAM
	 UI2GF6qihFqec+NKhd/rd3S7IR288GaUL6PnfVLgBlWWvZqpIUCeAiyYupVviyfZ74JTpL43N+nSX
	 PvxgAtMjFdmwfzpfeH1ZiCUGx7PuxlMS7zdd9qVLl6n1Ts4SqBKV9HnRqOtxiYaNh4sTMwAaNTIcb
	 buzhd0uMEx8RZCG4=
From: "=?utf-8?B?MTU5OTEwMTM4NQ==?=" <1599101385@qq.com>
To: "=?utf-8?B?c3l6Ym90K2JlOTdkZDRkYTE0YWU4OGI2YmE0QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20=?=" <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
Cc: "=?utf-8?B?ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA==?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXRAZ29vZ2xlLmNvbQ==?=" <edumazet@google.com>, "=?utf-8?B?aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1?=" <herbert@gondor.apana.org.au>, "=?utf-8?B?aG9ybXNAa2VybmVsLm9yZw==?=" <horms@kernel.org>, "=?utf-8?B?a3ViYUBrZXJuZWwub3Jn?=" <kuba@kernel.org>, "=?utf-8?B?bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw==?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2QHZnZXIua2VybmVsLm9yZw==?=" <netdev@vger.kernel.org>, "=?utf-8?B?cGFiZW5pQHJlZGhhdC5jb20=?=" <pabeni@redhat.com>, "=?utf-8?B?c3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQ==?=" <steffen.klassert@secunet.com>, "=?utf-8?B?c3l6a2FsbGVyLWJ1Z3NAZ29vZ2xlZ3JvdXBzLmNvbQ==?=" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 20 Oct 2025 14:03:23 +0800
X-Priority: 3
Message-ID: <tencent_72742A444FB03378AEE31E7F4C216DC00409@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezc37-0t1760940203tkp45n9ve

I3N5esKgdGVzdAoKRnJvbcKgMmVkZmM4ODMzZTQzY2RmNWNjZGE4YmQ1YmUzZGE1ZDFiYmRj
NjljNsKgTW9uwqBTZXDCoDE3wqAwMDowMDowMMKgMjAwMQpGcm9tOsKgY2xpbmdmZWnCoDwx
NTk5MTAxMzg1QHFxLmNvbT4KRGF0ZTrCoE1vbizCoDIwwqBPY3TCoDIwMjXCoDEzOjQwOjM1
wqArMDgwMApTdWJqZWN0OsKgW1BBVENIXcKgZml4wqBpbnRlZ2VywqBvdmVyZmxvd8KgaW7C
oHNldF9pcHNlY3JlcXVlc3QKVGhlwqBtcC0+bmV3X2ZhbWlsecKgYW5kwqBtcC0+b2xkX2Zh
bWlsecKgaXPCoHUxNizCoHdoaWxlwqBzZXRfaXBzZWNyZXF1ZXN0wqByZWNlaXZlc8KgZmFt
aWx5wqBhc8KgdWludDhfdCzCoApjYXVzaW5nwqBhwqBpbnRlZ2VywqBvdmVyZmxvd8KgYW5k
wqB0aGXCoGxhdGVywqBzaXplX3JlccKgY2FsY3VsYXRpb27CoGVycm9yLMKgd2hpY2jCoHVs
dGltYXRlbHnCoHRyaWdnZXJlZMKgYcKgCmtlcm5lbMKgYnVnwqBpbsKgc2tiX3B1dC4KClJl
cG9ydGVkLWJ5OsKgc3l6Ym90K2JlOTdkZDRkYTE0YWU4OGI2YmE0QHN5emthbGxlci5hcHBz
cG90bWFpbC5jb20KQ2xvc2VzOsKgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVn
P2V4dGlkPWJlOTdkZDRkYTE0YWU4OGI2YmE0CgotLS0KwqBuZXQva2V5L2FmX2tleS5jwqB8
wqAywqArLQrCoDHCoGZpbGXCoGNoYW5nZWQswqAxwqBpbnNlcnRpb24oKykswqAxwqBkZWxl
dGlvbigtKQoKZGlmZsKgLS1naXTCoGEvbmV0L2tleS9hZl9rZXkuY8KgYi9uZXQva2V5L2Fm
X2tleS5jCmluZGV4wqAyZWJkZTAzNTIyNDUuLjA4ZjRjZGUwMTk5NMKgMTAwNjQ0Ci0tLcKg
YS9uZXQva2V5L2FmX2tleS5jCisrK8KgYi9uZXQva2V5L2FmX2tleS5jCkBAwqAtMzUxOCw3
wqArMzUxOCw3wqBAQMKgc3RhdGljwqBpbnTCoHNldF9zYWRiX2ttYWRkcmVzcyhzdHJ1Y3TC
oHNrX2J1ZmbCoCpza2IswqBjb25zdMKgc3RydWN0wqB4ZnJtX2ttYWRkcmVzc8KgKgoKwqBz
dGF0aWPCoGludMKgc2V0X2lwc2VjcmVxdWVzdChzdHJ1Y3TCoHNrX2J1ZmbCoCpza2IsCsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
dWludDhfdMKgcHJvdG8swqB1aW50OF90wqBtb2RlLMKgaW50wqBsZXZlbCwKLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVpbnQzMl90
wqByZXFpZCzCoHVpbnQ4X3TCoGZhbWlseSwKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVpbnQzMl90wqByZXFpZCzCoHVpbnQxNl90
wqBmYW1pbHksCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY29uc3TCoHhmcm1fYWRkcmVzc190wqAqc3JjLMKgY29uc3TCoHhmcm1f
YWRkcmVzc190wqAqZHN0KQrCoHsKwqDCoMKgwqDCoMKgwqDCoHN0cnVjdMKgc2FkYl94X2lw
c2VjcmVxdWVzdMKgKnJxOwotLQoyLjM0LjEKCg==


