Return-Path: <netdev+bounces-13847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D908773D582
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 03:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6201C20404
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5427D7EB;
	Mon, 26 Jun 2023 01:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42670628
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 01:21:26 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net (zg8tmtyylji0my4xnjqunzqa.icoremail.net [162.243.164.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC270194
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 18:21:23 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.48] ) by
 ajax-webmail-mail-app4 (Coremail) ; Mon, 26 Jun 2023 09:20:57 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.48]
Date: Mon, 26 Jun 2023 09:20:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, simon.horman@corigine.com
Subject: Re: [PATCH v2] net: xfrm: Fix xfrm_address_filter OOB read
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <8a80ec0b-154a-4e6c-8fb8-916f506cd26d@p183>
References: <8a80ec0b-154a-4e6c-8fb8-916f506cd26d@p183>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <55aca58a.a2c0e.188f54a2741.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgBHTQr555hk63x8Bw--.28789W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwISEmSYV+MGPwAAsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGVsbG8gQWxleGV5LAoKKHNvcnJ5IGxhc3QgbWFpbCBqdXN0IHJlcGx5IHRvIG9uZSAuLikKCj4g
Cj4gPiArIGlmIChmaWx0ZXItPnNwbGVuID49IChzaXplb2YoeGZybV9hZGRyZXNzX3QpIDw8IDMp
IHx8Cj4gPiArIAlmaWx0ZXItPmRwbGVuID49IChzaXplb2YoeGZybV9hZGRyZXNzX3QpIDw8IDMp
KSB7Cj4gCj4gUGxlYXNlIG11bHRpcGx5IGJ5IDggaWYgeW91IHdhbnQgdG8gbXVsdGlwbHkgYnkg
OC4KPiAKClRoYW5rcyBmb3IgcmVtaW5kaW5nLgoKQXMgSSB0b2xkIGluIHRoZSBjb21taXQgbWVz
c2FnZSwgdGhpcyBjaGVja2luZyBjb2RlIGlzIGp1c3QgY29weSBmcm9tIHRoZSBmdW5jdGlvbiBw
ZmtleV9kdW1wIChuZXQva2V5L2FmX2tleS5jKSwgd2hpY2ggbGlrZQoKCWlmICgoeGZpbHRlci0+
c2FkYl94X2ZpbHRlcl9zcGxlbiA+PQoJCShzaXplb2YoeGZybV9hZGRyZXNzX3QpIDw8IDMpKSB8
fAoJICAgICh4ZmlsdGVyLT5zYWRiX3hfZmlsdGVyX2RwbGVuID49CgkJKHNpemVvZih4ZnJtX2Fk
ZHJlc3NfdCkgPDwgMykpKSB7CgkJbXV0ZXhfdW5sb2NrKCZwZmstPmR1bXBfbG9jayk7CgkJcmV0
dXJuIC1FSU5WQUw7Cgl9CgpJIHRoaW5rIHRoZSBsZWZ0IHNoaWZ0IDMgaXMgb2theSBhcyB0aGUg
YWN0dWFsIGNhbGN1bGF0aW9uIG9uIHRob3NlIGxlbmd0aHMgaXMgcmlnaHQgc2hpZnQgKyBsZWZ0
IHNoaWZ0IChzZWUgaW4gYWRkcl9tYXRjaCgpIGZ1bmN0aW9uKS4KCj4gU2hvdWxkIGl0IGJlICJz
cGxlbiA+IDggKiBzaXplb2YoKSIgPwoKR29vZCBxdWVzdGlvbi4gSXQgc2VlbXMgdGhhdCB0aGUg
ZmlsdGVyIGxlbmd0aCBpcyBsZWdhbCB0byByZWFjaCB0aGUgbWF4aW11bSBsZW5ndGguIFNvIHNo
b3VsZCBJIHNlbmQgYW5vdGhlciBwYXRjaCB0aGF0IGFsbG93cyB0aGUgY2hlY2tpbmcgY29kZSBp
biBwZmtleV9kdW1wIChuZXQva2V5L2FmX2tleS5jKSB0byBjaGFuZ2UgdG8gPiBpbnN0ZWFkIG9m
ID49ID8KClJlZ2FyZHMKTGlu

