Return-Path: <netdev+bounces-203241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D40EAF0E46
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638E24A1B29
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927423BD01;
	Wed,  2 Jul 2025 08:44:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522CB23AE96;
	Wed,  2 Jul 2025 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445847; cv=none; b=B8CzTMLONLlx3v7IJkV9iOB+gbts4AcBeDmSlTTAWE9plTPM51uNuWCfOK3r6UqdFF2YLGqesM/YN2twSJS+9MAc9cVHUWw/DlCZZKzdidTWdGT2TeEWRGhpVgcxYRzhvKivSU18JtcJgDFYnGEUwaznlJOa7WvLRl6p5p5PSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445847; c=relaxed/simple;
	bh=Zus0B39HdcK8fM6qwczDQhZP2KPHRCHS1rXI3WaslCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gkdmy7daq4QwuTVUN5sED87QhY1qBVbVRl0E5LKnQTRXcepvpqqDwBt/vR3oPpZhqQgtzff2BRvv7TCM4+VCWKeXySn4OSsZ6Hd0WEEdncPYUPGVLwK6+UFAtaHRM1Ab2XPVZ9U4Bu+Nt4eFEamziK+TzwryEfaa/U4EDbYI34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.197.243.13])
	by mtasvr (Coremail) with SMTP id _____wB3cH888WRoRSHTAw--.16197S3;
	Wed, 02 Jul 2025 16:43:41 +0800 (CST)
Received: from linma$zju.edu.cn ( [115.197.243.13] ) by
 ajax-webmail-mail-app2 (Coremail) ; Wed, 2 Jul 2025 16:43:31 +0800
 (GMT+08:00)
Date: Wed, 2 Jul 2025 16:43:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Eric Dumazet" <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, mingo@kernel.org, tglx@linutronix.de,
	pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atm: Fix incorrect net_device lec check
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <CANn89i+OJTG6YT1paZRigUuPB9gggL7p+sPym3_rZywKCaYqzQ@mail.gmail.com>
References: <20250702033600.254-1-linma@zju.edu.cn>
 <CANn89i+OJTG6YT1paZRigUuPB9gggL7p+sPym3_rZywKCaYqzQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5b5551e5.8496.197ca4e31c6.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zC_KCgAnToUz8WRo9iFTAA--.10787W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwAPEmhjuY4KnQADs2
X-CM-DELIVERINFO: =?B?hQF2xAXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHjeUlN/wNeQBhT9FIlu3pf6/1K6m8mf9f20HFv7BPk3UYsqEH+yo8VGXizWSxqp0ZbEr
	dPFW/bVI38OBulTYCi5EmSIoSdQDUT44KFT7+xqFQGKNllFEeyyn+z9QulQdLw==
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUQYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48Icx
	kI7VAKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2Iq
	xwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0V
	AYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU8rcTJUUUUU==

SGkgRXJpYywKCj4gCj4gVGhpcyB3aWxsIGNyYXNoIGlmIGRldiBpcyBOVUxMCj4KCk9vcHMsIHlv
dSBhcmUgcmlnaHQuIEkgd2lsbCBwcmVwYXJlIGEgbmV3IHZlcnNpb24gbGF0ZXIKClRoYW5rcwpM
aW4K


