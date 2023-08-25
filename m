Return-Path: <netdev+bounces-30773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54478906E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D3D281866
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC4193BF;
	Fri, 25 Aug 2023 21:36:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A81988A
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:36:02 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828A2691
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:36:01 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-677-ul1qsIGwP9e6KSAWRJpvjg-1; Fri, 25 Aug 2023 17:35:40 -0400
X-MC-Unique: ul1qsIGwP9e6KSAWRJpvjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A409802C1E;
	Fri, 25 Aug 2023 21:35:40 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB4961678B;
	Fri, 25 Aug 2023 21:35:39 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 00/17] tls: expand tls_cipher_size_desc to simplify getsockopt/setsockopt
Date: Fri, 25 Aug 2023 23:35:05 +0200
Message-Id: <cover.1692977948.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 2d2c5ea24243 ("net/tls: Describe ciphers sizes by const
structs") introduced tls_cipher_size_desc to describe the size of the
fields of the per-cipher crypto_info structs, and commit ea7a9d88ba21
("net/tls: Use cipher sizes structs") used it, but only in
tls_device.c and tls_device_fallback.c, and skipped converting similar
code in tls_main.c and tls_sw.c.

This series expands tls_cipher_size_desc (renamed to tls_cipher_desc
to better fit this expansion) to fully describe a cipher:
 - offset of the fields within the per-cipher crypto_info
 - size of the full struct (for copies to/from userspace)
 - offload flag
 - algorithm name used by SW crypto

With these additions, we can remove ~350L of
     switch (crypto_info->cipher_type) { ... }
from tls_set_device_offload, tls_sw_fallback_init,
do_tls_getsockopt_conf, do_tls_setsockopt_conf, tls_set_sw_offload
(mainly do_tls_getsockopt_conf and tls_set_sw_offload).

This series also adds the ARIA ciphers to the tls selftests, and some
more getsockopt/setsockopt tests to cover more of the code changed by
this series.

Sabrina Dubroca (17):
  selftests: tls: add test variants for aria-gcm
  selftests: tls: add getsockopt test
  selftests: tls: test some invalid inputs for setsockopt
  tls: move tls_cipher_size_desc to net/tls/tls.h
  tls: add TLS_CIPHER_ARIA_GCM_* to tls_cipher_size_desc
  tls: reduce size of tls_cipher_size_desc
  tls: rename tls_cipher_size_desc to tls_cipher_desc
  tls: extend tls_cipher_desc to fully describe the ciphers
  tls: validate cipher descriptions at compile time
  tls: expand use of tls_cipher_desc in tls_set_device_offload
  tls: allocate the fallback aead after checking that the cipher is
    valid
  tls: expand use of tls_cipher_desc in tls_sw_fallback_init
  tls: get crypto_info size from tls_cipher_desc in
    do_tls_setsockopt_conf
  tls: use tls_cipher_desc to simplify do_tls_getsockopt_conf
  tls: use tls_cipher_desc to get per-cipher sizes in tls_set_sw_offload
  tls: use tls_cipher_desc to access per-cipher crypto_info in
    tls_set_sw_offload
  tls: get cipher_name from cipher_desc in tls_set_sw_offload

 include/net/tls.h                  |  10 --
 net/tls/tls.h                      |  53 ++++++
 net/tls/tls_device.c               |  52 ++----
 net/tls/tls_device_fallback.c      |  62 +++----
 net/tls/tls_main.c                 | 272 ++++++++---------------------
 net/tls/tls_sw.c                   | 179 +++----------------
 tools/testing/selftests/net/config |   1 +
 tools/testing/selftests/net/tls.c  |  84 +++++++++
 8 files changed, 278 insertions(+), 435 deletions(-)

--=20
2.40.1


