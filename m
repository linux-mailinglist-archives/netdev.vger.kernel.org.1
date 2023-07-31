Return-Path: <netdev+bounces-22893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B32769D01
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE902815B8
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF8119BC8;
	Mon, 31 Jul 2023 16:42:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB219BC7
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:42:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C31712
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690821767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ixI4MQwQdtAD2JkXFfqXO58v2WbfQeqVX+hHpJApB/M=;
	b=Tctg4csnpKuBuAojZRPtL2lvy4rDp95Xi/cu4gWyBtMEsRmMtPwnWjX05YiEuKZlMIOC9S
	HfDZdLpEcm8R1I5X5hEzMUhYps4IFMd3sALhRRNbPw1Kgy/ren/vQI9AX3out82nLt0uhd
	3E/RnbnUtOKGtyk3qMMDEcaz+4WEmKI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-fMG9J2jaPsK_T0MQC5_nAw-1; Mon, 31 Jul 2023 12:42:44 -0400
X-MC-Unique: fMG9J2jaPsK_T0MQC5_nAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C36B2856F67;
	Mon, 31 Jul 2023 16:42:43 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4147401DA9;
	Mon, 31 Jul 2023 16:42:39 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: linux-kernel@vger.kernel.org,
	lersek@redhat.com
Cc: Eric Dumazet <edumazet@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pietro Borrello <borrello@diag.uniroma1.it>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] tun/tap: set sk_uid from current_fsuid()
Date: Mon, 31 Jul 2023 18:42:35 +0200
Message-Id: <20230731164237.48365-1-lersek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

VGhlIG9yaWdpbmFsIHBhdGNoZXMgZml4aW5nIENWRS0yMDIzLTEwNzYgYXJlIGluY29ycmVjdCBp
biBteSBvcGluaW9uLgpUaGlzIHNtYWxsIHNlcmllcyBmaXhlcyB0aGVtIHVwOyBzZWUgdGhlIGlu
ZGl2aWR1YWwgY29tbWl0IG1lc3NhZ2VzIGZvcgpleHBsYW5hdGlvbi4KCkkgaGF2ZSBhIHZlcnkg
ZWxhYm9yYXRlIHRlc3QgcHJvY2VkdXJlIGRlbW9uc3RyYXRpbmcgdGhlIHByb2JsZW0gZm9yCmJv
dGggdHVuIGFuZCB0YXA7IGl0IGludm9sdmVzIGxpYnZpcnQsIHFlbXUsIGFuZCAiY3Jhc2giLiBJ
IGNhbiBzaGFyZQp0aGF0IHByb2NlZHVyZSBpZiBuZWNlc3NhcnksIGJ1dCBpdCdzIGluZGVlZCBx
dWl0ZSBsb25nIChJIHdyb3RlIGl0Cm9yaWdpbmFsbHkgZm9yIG91ciBRRSB0ZWFtKS4KClRoZSBw
YXRjaGVzIGluIHRoaXMgc2VyaWVzIGFyZSBzdXBwb3NlZCB0byAicmUtZml4IiBDVkUtMjAyMy0x
MDc2OyBnaXZlbgp0aGF0IHNhaWQgQ1ZFIGlzIGNsYXNzaWZpZWQgYXMgTG93IEltcGFjdCAoQ1ZT
U3YzPTUuNSksIEknbSBwb3N0aW5nIHRoaXMKcHVibGljbHksIGFuZCBub3Qgc3VnZ2VzdGluZyBh
bnkgZW1iYXJnby4gUmVkIEhhdCBQcm9kdWN0IFNlY3VyaXR5IG1heQphc3NpZ24gYSBuZXcgQ1ZF
IG51bWJlciBsYXRlci4KCkkndmUgdGVzdGVkIHRoZSBwYXRjaGVzIG9uIHRvcCBvZiB2Ni41LXJj
NCwgd2l0aCAiY3Jhc2giIGJ1aWx0IGF0IGNvbW1pdApjNzRmMzc1ZTBlZjcuCgpDYzogRXJpYyBE
dW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPgpDYzogTG9yZW56byBDb2xpdHRpIDxsb3Jlbnpv
QGdvb2dsZS5jb20+CkNjOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+CkNjOiBQaWV0
cm8gQm9ycmVsbG8gPGJvcnJlbGxvQGRpYWcudW5pcm9tYTEuaXQ+CkNjOiBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCgpMYXN6bG8gRXJzZWsgKDIpOgog
IG5ldDogdHVuX2Nocl9vcGVuKCk6IHNldCBza191aWQgZnJvbSBjdXJyZW50X2ZzdWlkKCkKICBu
ZXQ6IHRhcF9vcGVuKCk6IHNldCBza191aWQgZnJvbSBjdXJyZW50X2ZzdWlkKCkKCiBkcml2ZXJz
L25ldC90YXAuYyB8IDIgKy0KIGRyaXZlcnMvbmV0L3R1bi5jIHwgMiArLQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgoKYmFzZS1jb21taXQ6IDVkMGMy
MzBmMWRlOGM3NTE1YjY1NjdkOWFmYmExZjE5NmZiNGUyZjQK


