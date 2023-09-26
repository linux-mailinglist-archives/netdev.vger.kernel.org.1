Return-Path: <netdev+bounces-36294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A17AED07
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 14:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E0A732812BC
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F0266B7;
	Tue, 26 Sep 2023 12:41:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF76FD2
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 12:41:04 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69B94FC;
	Tue, 26 Sep 2023 05:41:01 -0700 (PDT)
Received: from dinghao.liu$zju.edu.cn ( [10.192.76.118] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 26 Sep 2023 20:40:40 +0800
 (GMT+08:00)
X-Originating-IP: [10.192.76.118]
Date: Tue, 26 Sep 2023 20:40:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: dinghao.liu@zju.edu.cn
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc: "Alexander Aring" <alex.aring@gmail.com>, 
	"Stefan Schmidt" <stefan@datenfreihafen.org>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, 
	"Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Marcel Holtmann" <marcel@holtmann.org>, 
	"Harry Morris" <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230926100202.011ab841@xps-13>
References: <20230926032244.11560-1-dinghao.liu@zju.edu.cn>
 <20230926100202.011ab841@xps-13>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <38f11c6a.2d287.18ad18184c8.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgDHibRJ0RJldU0UAQ--.23767W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgIKBmURl6BBWgAAsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiBNaXNzaW5nIENjIHN0YWJsZSwgdGhpcyBuZWVkcyB0byBiZSBiYWNrcG9ydGVkLgoKSSB3aWxs
IGNjIHN0YWJsZSAoc3RhYmxlQHZnZXIua2VybmVsLm9yZykgZm9yIHRoZSBuZXh0IHZlcnNpb24s
IHRoYW5rcyEKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9pZWVlODAyMTU0L2NhODIxMC5j
IGIvZHJpdmVycy9uZXQvaWVlZTgwMjE1NC9jYTgyMTAuYwo+ID4gaW5kZXggYWViYjE5ZjFiM2E0
Li5iMzVjNmY1OWJkMWEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9pZWVlODAyMTU0L2Nh
ODIxMC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC9pZWVlODAyMTU0L2NhODIxMC5jCj4gPiBAQCAt
Mjc1OSw3ICsyNzU5LDYgQEAgc3RhdGljIGludCBjYTgyMTBfcmVnaXN0ZXJfZXh0X2Nsb2NrKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpCj4gPiAgCX0KPiA+ICAJcmV0ID0gb2ZfY2xrX2FkZF9wcm92
aWRlcihucCwgb2ZfY2xrX3NyY19zaW1wbGVfZ2V0LCBwcml2LT5jbGspOwo+ID4gIAlpZiAocmV0
KSB7Cj4gPiAtCQljbGtfdW5yZWdpc3Rlcihwcml2LT5jbGspOwo+ID4gIAkJZGV2X2NyaXQoCj4g
PiAgCQkJJnNwaS0+ZGV2LAo+ID4gIAkJCSJGYWlsZWQgdG8gcmVnaXN0ZXIgZXh0ZXJuYWwgY2xv
Y2sgYXMgY2xvY2sgcHJvdmlkZXJcbiIKPiAKPiBJIHdhcyBob3BpbmcgeW91IHdvdWxkIHNpbXBs
aWZ5IHRoaXMgZnVuY3Rpb24gYSBiaXQgbW9yZS4KCkkgdW5kZXJzdGFuZC4gSW4gdGhlIG5leHQg
cGF0Y2ggdmVyc2lvbiwgSSB3aWxsIGp1c3QgcmV0dXJuIG9mX2Nsa19hZGRfcHJvdmlkZXIoKS4g
Cgo+IAo+ID4gQEAgLTI3ODAsNyArMjc3OSw3IEBAIHN0YXRpYyB2b2lkIGNhODIxMF91bnJlZ2lz
dGVyX2V4dF9jbG9jayhzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQo+ID4gIHsKPiA+ICAJc3RydWN0
IGNhODIxMF9wcml2ICpwcml2ID0gc3BpX2dldF9kcnZkYXRhKHNwaSk7Cj4gPiAgCj4gPiAtCWlm
ICghcHJpdi0+Y2xrKQo+ID4gKwlpZiAoSVNfRVJSX09SX05VTEwocHJpdi0+Y2xrKSkKPiA+ICAJ
CXJldHVybgo+ID4gIAo+ID4gIAlvZl9jbGtfZGVsX3Byb3ZpZGVyKHNwaS0+ZGV2Lm9mX25vZGUp
Owo+IAo+IEFsZXgsIFN0ZWZhbiwgd2hvIGhhbmRsZXMgd3BhbiBhbmQgd3Bhbi9uZXh0IHRoaXMg
cmVsZWFzZT8KPgogCklzIHRoZXJlIGFueSBwcm9ibGVtIEkgbmVlZCB0byBoYW5kbGUgaW4gdGhl
IG5leHQgcGF0Y2g/CgpSZWdhcmRzLApEaW5naGFvCg==

