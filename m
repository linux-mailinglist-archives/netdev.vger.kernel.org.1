Return-Path: <netdev+bounces-32469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6C797B7D
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7DB281741
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7713FFC;
	Thu,  7 Sep 2023 18:19:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79007134DD
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:19:02 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6BB9D
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 11:18:41 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575--HTpF7cTMtuTFiLqEw9h4Q-1; Thu, 07 Sep 2023 09:56:18 -0400
X-MC-Unique: -HTpF7cTMtuTFiLqEw9h4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6705D101CA84;
	Thu,  7 Sep 2023 13:56:17 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6484B412F2CE;
	Thu,  7 Sep 2023 13:56:16 +0000 (UTC)
Date: Thu, 7 Sep 2023 15:56:15 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
	Vakul Garg <vakul.garg@nxp.com>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 2/5] tls: fix use-after-free with partial reads and
 async decrypt
Message-ID: <ZPnWf4xIxrT_176E@hog>
References: <cover.1694018970.git.sd@queasysnail.net>
 <aa1a31a25c2d0121e039f34ee58a996ea9a130ad.1694018970.git.sd@queasysnail.net>
 <20230906190529.6cec0a3d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230906190529.6cec0a3d@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-09-06, 19:05:29 -0700, Jakub Kicinski wrote:
> On Wed,  6 Sep 2023 19:08:32 +0200 Sabrina Dubroca wrote:
> > @@ -221,7 +222,8 @@ static void tls_decrypt_done(void *data, int err)
> > =09/* Free the destination pages if skb was not decrypted inplace */
> > =09if (sgout !=3D sgin) {
>=20
> This check is always true now, right?
> Should we replace it with dctx->put_outsg?

Ugh, I noticed that when I was debugging, and didn't think about
replacing the test. Yeah, I'll do that in v2.

--=20
Sabrina


