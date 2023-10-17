Return-Path: <netdev+bounces-41804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAAA7CBEB9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4E11C20998
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874223F4B0;
	Tue, 17 Oct 2023 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92838FB3
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:17:02 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4758E
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:17:01 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-Os0hwS-iOcqWslJTLSvOeA-1; Tue, 17 Oct 2023 05:16:58 -0400
X-MC-Unique: Os0hwS-iOcqWslJTLSvOeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B80B85A5BD;
	Tue, 17 Oct 2023 09:16:58 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B75ED2166B26;
	Tue, 17 Oct 2023 09:16:57 +0000 (UTC)
Date: Tue, 17 Oct 2023 11:16:56 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net-next 08/14] tls: also use init_prot_info in
 tls_set_device_offload
Message-ID: <ZS5RCPqxlJtTgL_4@hog>
References: <cover.1696596130.git.sd@queasysnail.net>
 <6da95c0d469415ee62cc23ce72227f8d058400bc.1696596130.git.sd@queasysnail.net>
 <20231013142307.70af75d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231013142307.70af75d6@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-10-13, 14:23:07 -0700, Jakub Kicinski wrote:
> On Mon,  9 Oct 2023 22:50:48 +0200 Sabrina Dubroca wrote:
> > +=09if (mode =3D=3D TLS_HW) {
> > +=09=09prot->aad_size =3D 0;
> > +=09=09prot->tail_size =3D 0;
> > +=09}
>=20
> Strange, tail_size doesn't matter because HW doesn't support TLS 1.3
> but aad_size?  Is it overwritten by SW init or something?

For RX, yes, tls_set_device_offload_rx -> tls_set_sw_offload ->
  init_prot_info(mode=3DTLS_SW).
But aad_size is not used in tls_device_reencrypt, maybe because (for
both GCM variants)
    TLS_HEADER_SIZE + cipher_desc->iv =3D=3D TLS_AAD_SPACE_SIZE

For TX, it looks like tls_device_fallback hardcodes TLS_AAD_SPACE_SIZE
where tls_sw would use prot->aad_size. tls_device doesn't use either.

Actually this patch is broken. If we set TLS_RX to TLS_SW first (for
example because we disabled tls-hw-rx-offload with ethtool), and
TLS_TX to TLS_HW second, that will set aad_size to 0, but RX needs it
to be set.

I'll send a fix to drop this hunk completely. Thanks for reviewing.

--=20
Sabrina


