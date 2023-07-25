Return-Path: <netdev+bounces-20894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 582C8761D60
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861E71C20DDE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052D23BD1;
	Tue, 25 Jul 2023 15:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7F1549F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 15:29:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34141BF8
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690298956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbqsLIkGShHuil5PLSxaVfXhTRQLAs653axfRAT5yC0=;
	b=V4SQmsY9o66PCgpG/WZMB8+EApI1MQ/Vex5omGiaoS8rNWmKMiVtE+VWxxS7f5VVA1exKt
	uJMN5nrqO0vDKgVnpDCeGof/SAvdjO3hbQGvYQkoJCVFhP9DPg19r7UukH5dlQ8/iQ+P7T
	7X4crHyBmL6fgDONVLqld7oO6nc/uHo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-hhpy8Cq1NDGZylDbFVrJRg-1; Tue, 25 Jul 2023 11:29:12 -0400
X-MC-Unique: hhpy8Cq1NDGZylDbFVrJRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E0FA1C07827;
	Tue, 25 Jul 2023 15:29:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.242])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AFAE1121330;
	Tue, 25 Jul 2023 15:29:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000000cb2c305fdeb8e30@google.com>
References: <0000000000000cb2c305fdeb8e30@google.com>
To: syzbot <syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, davem@davemloft.net,
    herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
    pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] general protection fault in cryptd_hash_export
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <104260.1690298950.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Jul 2023 16:29:10 +0100
Message-ID: <104261.1690298950@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t b6d972f6898308fbe7e693bf8d44ebfdb1cd2dc4


