Return-Path: <netdev+bounces-13203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0713F73AB3F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 23:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E6A2818AF
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BDC22556;
	Thu, 22 Jun 2023 21:11:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6820690
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 21:11:58 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF032101
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 14:11:27 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-mQt2dRz0POGbOCPVH27HiQ-1; Thu, 22 Jun 2023 17:04:49 -0400
X-MC-Unique: mQt2dRz0POGbOCPVH27HiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C2A58FE620;
	Thu, 22 Jun 2023 21:04:49 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.195.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D72A1200A3AD;
	Thu, 22 Jun 2023 21:04:47 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: rtnetlink: remove netdevsim device after ipsec offload test
Date: Thu, 22 Jun 2023 23:03:34 +0200
Message-Id: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On systems where netdevsim is built-in or loaded before the test
starts, kci_test_ipsec_offload doesn't remove the netdevsim device it
created during the test.

Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev pr=
obe")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/rtnetlink.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selft=
ests/net/rtnetlink.sh
index 383ac6fc037d..ba286d680fd9 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -860,6 +860,7 @@ EOF
 =09fi
=20
 =09# clean up any leftovers
+=09echo 0 > /sys/bus/netdevsim/del_device
 =09$probed && rmmod netdevsim
=20
 =09if [ $ret -ne 0 ]; then
--=20
2.40.1


