Return-Path: <netdev+bounces-36101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F2B7AD3BB
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 10:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EC66028161B
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C31D134A2;
	Mon, 25 Sep 2023 08:49:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6B10964
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 08:49:28 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 470F3103;
	Mon, 25 Sep 2023 01:49:25 -0700 (PDT)
Received: from dinghao.liu$zju.edu.cn ( [10.190.70.223] ) by
 ajax-webmail-mail-app2 (Coremail) ; Mon, 25 Sep 2023 16:48:53 +0800
 (GMT+08:00)
X-Originating-IP: [10.190.70.223]
Date: Mon, 25 Sep 2023 16:48:53 +0800 (GMT+08:00)
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
Subject: Re: [PATCH] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230925102919.356b45ab@xps-13>
References: <20230925072423.24772-1-dinghao.liu@zju.edu.cn>
 <20230925102919.356b45ab@xps-13>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <42b77efb.28ab5.18acb86f1c3.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgDHibR1SRFlXhL4AA--.21623W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEJBmUQRiAzPQAAsR
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgTWlxdcOobCwKCj4gPiBpbmRleCBhZWJiMTlmMWIzYTQuLjFkNTQ1ODc5YzAwMCAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L2llZWU4MDIxNTQvY2E4MjEwLmMKPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L2llZWU4MDIxNTQvY2E4MjEwLmMKPiA+IEBAIC0yNzYwLDYgKzI3NjAsNyBAQCBzdGF0
aWMgaW50IGNhODIxMF9yZWdpc3Rlcl9leHRfY2xvY2soc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkK
PiA+ICAJcmV0ID0gb2ZfY2xrX2FkZF9wcm92aWRlcihucCwgb2ZfY2xrX3NyY19zaW1wbGVfZ2V0
LCBwcml2LT5jbGspOwo+ID4gIAlpZiAocmV0KSB7Cj4gPiAgCQljbGtfdW5yZWdpc3Rlcihwcml2
LT5jbGspOwo+ID4gKwkJcHJpdi0+Y2xrID0gTlVMTDsKPiAKPiBUaGlzIGZ1bmN0aW9uIGlzIGEg
Yml0IGNvbnZvbHV0ZWQuIFlvdSBjb3VsZCBqdXN0IHJldHVybiB0aGUgcmVzdWx0IG9mCj4gb2Zf
Y2xrX2FkZF9wcm92aWRlcigpIChrZWVwIHRoZSBwcmludGsncyBpZiB5b3Ugd2FudCwgdGhleSBk
b24ndCBzZWVtCj4gdmVyeSB1c2VmdWwpIGFuZCBsZXQgY2E4MjEwX3VucmVnaXN0ZXJfZXh0X2Ns
b2NrKCkgZG8gdGhlIGNsZWFudXAuCgpUaGFua3MgZm9yIHlvdXIgYWR2aWNlISBJIHdpbGwgcmVz
ZW5kIGEgbmV3IHBhdGNoIGFzIHN1Z2dlc3RlZC4KCj4gCj4gPiAgCQlkZXZfY3JpdCgKPiA+ICAJ
CQkmc3BpLT5kZXYsCj4gPiAgCQkJIkZhaWxlZCB0byByZWdpc3RlciBleHRlcm5hbCBjbG9jayBh
cyBjbG9jayBwcm92aWRlclxuIgo+ID4gQEAgLTI3ODAsNyArMjc4MSw3IEBAIHN0YXRpYyB2b2lk
IGNhODIxMF91bnJlZ2lzdGVyX2V4dF9jbG9jayhzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQo+ID4g
IHsKPiA+ICAJc3RydWN0IGNhODIxMF9wcml2ICpwcml2ID0gc3BpX2dldF9kcnZkYXRhKHNwaSk7
Cj4gPiAgCj4gPiAtCWlmICghcHJpdi0+Y2xrKQo+ID4gKwlpZiAoSVNfRVJSX09SX05VTEwocHJp
di0+Y2xrKSkKPiAKPiBEb2VzIG5vdCBsb29rIHVzZWZ1bCBhcyB5b3UgYXJlIGVuZm9yY2luZyBw
cml2LT5jbG9jayB0byBiZSB2YWxpZCBvcgo+IE5VTEwsIGl0IGNhbm5vdCBiZSBhbiBlcnJvciBj
b2RlLgoKSSBmaW5kIHRoYXQgY2E4MjEwX3JlZ2lzdGVyX2V4dF9jbG9jaygpIHVzZXMgSVNfRVJS
IHRvIGNoZWNrIHByaXYtPmNsawphZnRlciBjYWxsaW5nIGNsa19yZWdpc3Rlcl9maXhlZF9yYXRl
KCkuIFNvIEkgdGhpbmsgcHJpdi0+Y2xrIGNvdWxkIGJlCmEgbm9uLW51bGwgcG9pbnRlciBldmVu
IG9uIGZhaWx1cmUuIEFuZCBhIG51bGwgcG9pbnRlciBjaGVjayBtYXkgbWlzcwp0aGlzIGNhc2Ug
aW4gY2E4MjEwX3VucmVnaXN0ZXJfZXh0X2Nsb2NrKCkuIAoKUmVnYXJkcywKRGluZ2hhbw==

