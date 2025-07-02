Return-Path: <netdev+bounces-203147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75EAF095B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C113F7A324A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E41DD543;
	Wed,  2 Jul 2025 03:44:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41282374EA;
	Wed,  2 Jul 2025 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751427897; cv=none; b=CSWTMpdMwhPXwBTciPXgRLc3cNEvw3QU+DlV0FwhLWNfaz9BmE7eOl8RX7cgLNqrXaNxhiTu41fyUlOSaYinqFFCrCriiUicBhabNFYTZuZxfBsZlMeq4wqffLh68q6iVT9i58VW0lyT39iNBGRZ2dd/aOEI4FU27YhC9G/DOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751427897; c=relaxed/simple;
	bh=WMdTLlgEmYXJn42Md2+RAiIMmctVOthM4Z76RUekRBY=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=UaJZipkk8cfy7JQ84/2vzIss9fvVeo1RYziJs5biEA/QYINuBZlSCvljvRjgvPTeQF/Acxht31GhytKIwNOKnedcr9B+nas+mrf5JNe7NHiyH7735RPPDVShBOH9uW8MyhIgKvayWm+K20DPY0pFYHHHQt4sOsFQSlXzqWytib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.197.243.13])
	by mtasvr (Coremail) with SMTP id _____wDnOCwhq2RoYenQAw--.7425S3;
	Wed, 02 Jul 2025 11:44:33 +0800 (CST)
Received: from linma$zju.edu.cn ( [115.197.243.13] ) by
 ajax-webmail-mail-app1 (Coremail) ; Wed, 2 Jul 2025 11:44:31 +0800
 (GMT+08:00)
Date: Wed, 2 Jul 2025 11:44:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, mingo@kernel.org,
	tglx@linutronix.de, pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atm: Fix incorrect net_device lec check
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <20250702033600.254-1-linma@zju.edu.cn>
References: <20250702033600.254-1-linma@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7ebd4e0b.7b84.197c93c74b1.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgBXF2Ifq2RoOctTAA--.12406W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwAPEmhjuY4KnQAAs1
X-CM-DELIVERINFO: =?B?z8iDYgXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHjeUlN/wNeQBhT9FIlu3pf4LNuu1YKU3/fDomEhaaFQTVrdHfrYENqm1lgz3qTF75UVO
	0ChPZAmyJb/o1g9t2s4U7KlY6GRyn4xzPOZbPst1UJgiMxk0OLeryKixdVGfTQ==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xw45tryfGw4kAry7KFW3Arc_yoW3GFg_ur
	1Iyr97Ww4IkFnIgw4UJrs0yF9agF4UtFyxJw45Kr1xt347XFWUurWDZF9Fvw17WanIkF98
	uF1jqrn3Gw17KosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbPxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x0EwI
	xGrVCF72vEw4AK0wACY4xI67k04243AVAKzVAKj4xxM4xvF2IEb7IF0Fy26I8I3I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJwCE64xvF2IEb7IF0F
	y7YxBIdaVFxhVjvjDU0xZFpf9x07jjQ6JUUUUU=

SGVsbG8gdGhlcmUsCgpNb3Jlb3ZlciwgdGhlcmUgaXMgYW5vdGhlciBzaW1pbGFyIGJ1ZyBmb3Vu
ZCB2aWEgdmFyaWFudCBhbmFseXNpcwoKYGBgCi8vIG5ldC9hcHBsZXRhbGsvZGRwLmMKc3RhdGlj
IGludCBoYW5kbGVfaXBfb3Zlcl9kZHAoc3RydWN0IHNrX2J1ZmYgKnNrYikKewogICAgc3RydWN0
IG5ldF9kZXZpY2UgKmRldiA9IF9fZGV2X2dldF9ieV9uYW1lKCZpbml0X25ldCwgImlwZGRwMCIp
OwogICAgc3RydWN0IG5ldF9kZXZpY2Vfc3RhdHMgKnN0YXRzOwogICAgLi4uCmBgYAoKVGhlIGNv
ZGUgYmVsaWV2ZXMgdGhhdCBfX2Rldl9nZXRfYnlfbmFtZSgpIG11c3QgcmV0dXJuIGRldmljZSBj
cmVhdGVkCmluIGlwZGRwX2luaXQoKSBmdW5jdGlvbiwgaWdub3JpbmcgdGhlIGZhY3QgdGhhdCBh
IG1hbGljaW91cyB1c2VyIGNvdWxkCmhpamFjayB0aGUgaW50ZXJmYWNlIG5hbWUuCgpUaGlzIGJ1
ZyBpcyAiZml4ZWQiIGluIHVwc3RyZWFtIGJ5CmNvbW1pdCA4NTYwNWZiNjk0ZjAgKCJhcHBsZXRh
bGs6IHJlbW92ZSBzcGVjaWFsIGhhbmRsaW5nIGNvZGUgZm9yIGlwZGRwIikuCkhvd2V2ZXIsIHRo
ZSBzdGFibGUgdmVyc2lvbiwgbGlrZSB2NS4xNS4xODYsIHN0aWxsIGNvbnRhaW5zIGl0LgoKU2hh
bGwgSSBzZW5kIGFub3RoZXIgcGF0Y2g/IE9yIHNob3VsZCB0aGUgc3RhYmxlIGJyYW5jaCBlbXBs
b3kgdGhlIGV4aXN0aW5nCmNvbW1pdHM/CgpSZWdhcmRzCkxpbgoKCgo=


