Return-Path: <netdev+bounces-20503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D633E75FC00
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120731C20B8A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F0F4F8;
	Mon, 24 Jul 2023 16:25:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BCE549
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:25:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBA619A1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690215936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drAtcPHCS22fP7yNxW1l2FqAXXz6i9T2pfEijoZr8LE=;
	b=Jg91pGSGYDlmtxEy/KNYCvbf6jZ7TM83/B8JqKwX1TqBspnTwP6rG9bWKegR5FebiX1iu7
	ne/KK2Gwq5za6Rx2ovDsngOhjbjZ1QFB/oRRzl83dlPtA63KmGW5BnT7w9Na9YCAoDukab
	zz4EK8GE8otpPaDwZZkpzOxpeoly+nE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-v3dJyOVKPCiMh3BNUtI08A-1; Mon, 24 Jul 2023 12:25:33 -0400
X-MC-Unique: v3dJyOVKPCiMh3BNUtI08A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D3F0800159;
	Mon, 24 Jul 2023 16:25:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D754E40C2063;
	Mon, 24 Jul 2023 16:25:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000836b2805fffd6d7e@google.com>
References: <000000000000836b2805fffd6d7e@google.com>
To: syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, axboe@kernel.dk,
    herbert@gondor.apana.org.au, kuba@kernel.org,
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13124.1690215929.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jul 2023 17:25:29 +0100
Message-ID: <13125.1690215929@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 0b7ec177b589842c0abf9e91459c83ba28d32452


