Return-Path: <netdev+bounces-27389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D677BC60
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3B31C208F2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C0C15C;
	Mon, 14 Aug 2023 15:06:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA8A923
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:06:34 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2441BE73
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:06:32 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-GjxZ1CCQMCmV5C0wdFCJYQ-1; Mon, 14 Aug 2023 11:06:14 -0400
X-MC-Unique: GjxZ1CCQMCmV5C0wdFCJYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A512E185A793;
	Mon, 14 Aug 2023 15:06:13 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C98CA1121314;
	Mon, 14 Aug 2023 15:06:11 +0000 (UTC)
Date: Mon, 14 Aug 2023 17:06:10 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 3/6] tls: implement rekey for TLS1.3
Message-ID: <ZNpC4lAmlLn-5A9h@hog>
References: <cover.1691584074.git.sd@queasysnail.net>
 <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
 <20230811184347.1f7077a9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230811184347.1f7077a9@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-08-11, 18:43:47 -0700, Jakub Kicinski wrote:
> On Wed,  9 Aug 2023 14:58:52 +0200 Sabrina Dubroca wrote:
> >  =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
> >  =09=09=09TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
> >  =09=09=09conf =3D TLS_SW;
>=20
> Should we add a statistic for rekeying?

Hmpf, at least I shouldn't be incrementing the existing stats on every
update, especially not TLSCURR* :/

I don't see much benefit in tracking succesful rekeys. Failed rekeys
seem more interesting to me. What would we get from counting succesful
rekeys?

> > +int tls_set_sw_offload(struct sock *sk, int tx,
> > +=09=09       struct tls_crypto_info *new_crypto_info)
> >  {
>=20
> This function is already 300 LoC and we're making longer with=20
> a not-so-pretty goto skip;
>=20
> Any way we can refactor it first?

I guess all the actual init (alloc software context and set it up)
could go in a separate function. I'll see if I can split a few more
things out from the end of the function without making it too messy.

> I think someone had a plan
> to at least make the per-algo stuff less verbose?

Yep, that's me. Basically, expanding the existing tls_cipher_size_desc
to completely remove the switch (crypto_info->cipher_type) (from both
setsockopt and getsockopt). I'll clean up and submit those changes,
and then rebase the next version of this series on top. Dunno why I
decided to focus on the rekey first.

--=20
Sabrina


