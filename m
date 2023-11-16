Return-Path: <netdev+bounces-48247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309867EDBBA
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9F6280EA1
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 07:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4CF3C13;
	Thu, 16 Nov 2023 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761DE192;
	Wed, 15 Nov 2023 23:02:55 -0800 (PST)
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: RE: [PATCH][net-next] net/smc: avoid atomic_set and smp_wmb in the tx
 path when possible
Thread-Topic: [PATCH][net-next] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Thread-Index: AQHaGFSsV3lsEoc0T0O8PDgZDtb7pLB8hMpw
Date: Thu, 16 Nov 2023 07:02:50 +0000
Message-ID: <64c98eb20e1244b981d0db9a912ce589@baidu.com>
References: <20231116022041.51959-1-lirongqing@baidu.com>
 <20231116061811.GC121324@linux.alibaba.com>
In-Reply-To: <20231116061811.GC121324@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.22.206.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.36
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM

> -----Original Message-----
> From: Dust Li <dust.li@linux.alibaba.com>
> Sent: Thursday, November 16, 2023 2:18 PM
> To: Li,Rongqing <lirongqing@baidu.com>; wenjia@linux.ibm.co;
> netdev@vger.kernel.org; linux-s390@vger.kernel.org
> Subject: Re: [PATCH][net-next] net/smc: avoid atomic_set and smp_wmb in t=
he
> tx path when possible
>=20
> On Thu, Nov 16, 2023 at 10:20:41AM +0800, Li RongQing wrote:
> >there is rare possibility that conn->tx_pushing is not 1, since
> >tx_pushing is just checked with 1, so move the setting tx_pushing to 1
> >after atomic_dec_and_test() return false, to avoid atomic_set and
> >smp_wmb in tx path
> >
> >Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>=20
> >---
> > net/smc/smc_tx.c | 7 ++++---
> > 1 file changed, 4 insertions(+), 3 deletions(-)
> >
> >diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c index 3b0ff3b..72dbdee
> >100644
> >--- a/net/smc/smc_tx.c
> >+++ b/net/smc/smc_tx.c
> >@@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection
> *conn)
> > 		return 0;
> >
> > again:
> >-	atomic_set(&conn->tx_pushing, 1);
> >-	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
> > 	rc =3D __smc_tx_sndbuf_nonempty(conn);
> >
> > 	/* We need to check whether someone else have added some data into
> @@
> >-677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection
> *conn)
> > 	 * If so, we need to push again to prevent those data hang in the send
> > 	 * queue.
> > 	 */
> >-	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
> >+	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
> >+		atomic_set(&conn->tx_pushing, 1);
> >+		smp_wmb(); /* Make sure tx_pushing is 1 before real send */
> nit: it would be better if we change the comments to "send again".
>=20

Ok, I will fix it, thanks

-Li


> Thanks
> > 		goto again;
> >+	}
> >
> > 	return rc;
> > }
> >--
> >2.9.4

