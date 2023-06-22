Return-Path: <netdev+bounces-12951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6BF7398FB
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8611C20F3D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F9913AE4;
	Thu, 22 Jun 2023 08:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0F613A
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:06:01 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91349198
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:05:58 -0700 (PDT)
Received: from linma$zju.edu.cn ( [118.248.134.152] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 22 Jun 2023 16:04:39 +0800
 (GMT+08:00)
X-Originating-IP: [118.248.134.152]
Date: Thu, 22 Jun 2023 16:04:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: krzysztof.kozlowski@linaro.org, avem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1] net: nfc: Fix use-after-free in
 nfc_genl_llc_{{get/set}_params/sdreq}
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <746941b24732655c51dee68ed442bfc14a82e303.camel@redhat.com>
References: <20230620025350.4034422-1-linma@zju.edu.cn>
 <746941b24732655c51dee68ed442bfc14a82e303.camel@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <34066cf0.998bd.188e2224e93.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgBnEZyYAJRkPGh+Bw--.12323W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwULEmSQbuIB3QAPs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgUGFvbG8sCgo+IAo+IEl0IGxvb2tzIGxpa2UgdGhlIG1lbnRpb25lZCByYWNlIGNvbmRpdGlv
biBjb3VsZCBhcHBseSB0byBhbnkgY2FsbGVycwo+IG9mIG5mY19sbGNwX2ZpbmRfbG9jYWwoKSwg
aXMgdGhlcmUgYW55IHNwZWNpYWwgcmVhc29uIHRvIG5vdCBhZGQgdGhlCj4gbmV3IGNoZWNrIGRp
cmVjdGx5IGluc2lkZSBuZmNfbGxjcF9maW5kX2xvY2FsKCk/Cj4gCgpPb29wcywgSSBhY3R1YWxs
eSBoYXZlbid0IGNvbnNpZGVyIHRob3NlIGNhc2VzLiBJIHdpbGwgZG8gYSBxdWljayBjaGVjawpm
b3IgdGhhdC4KCj4gVGhhbmtzIQo+IAo+IFBhb2xvCgpSZWdhcmRzCkxpbg==

