Return-Path: <netdev+bounces-35450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E277A98E3
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08EB1C21226
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0E31DA4B;
	Thu, 21 Sep 2023 17:22:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B518C38
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:22:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95D35491C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695316629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oo4GNctLz8Shf19nIoryBMjQyKRYmeTybgYDXDbksM4=;
	b=PwCzORY5We0QtRqIy4eR7RIK030z5MfL9ut7Zzu29SNKsKTBsXrDSKHu1w2NQxZODKM7/h
	fHVE5yju/otgp5UT8gSvchbSgp0e0jst5lmCIDGkLz7RU+COQ2QIHxHSEDrj6CA/umsFNC
	5XHPq7XhmhhX4eBsaob+r8T+zv64M/w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-679-hp6VtaakNtupnp-MguiVZA-1; Thu, 21 Sep 2023 11:03:47 -0400
X-MC-Unique: hp6VtaakNtupnp-MguiVZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7FF71C01EA3;
	Thu, 21 Sep 2023 15:03:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A56CC40C200E;
	Thu, 21 Sep 2023 15:03:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <87o7hvzn12.wl-tiwai@suse.de>
References: <87o7hvzn12.wl-tiwai@suse.de> <20230920222231.686275-1-dhowells@redhat.com> <20230920222231.686275-2-dhowells@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Al Viro <viro@zeniv.linux.org.uk>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Christoph Hellwig <hch@lst.de>,
    Christian Brauner <christian@brauner.io>,
    David Laight <David.Laight@ACULAB.COM>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
    linux-block@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
    Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
    Suren Baghdasaryan <surenb@google.com>,
    Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
    alsa-devel@alsa-project.org
Subject: Re: [PATCH v5 01/11] sound: Fix snd_pcm_readv()/writev() to use iov access functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <809185.1695308608.1@warthog.procyon.org.uk>
Date: Thu, 21 Sep 2023 16:03:28 +0100
Message-ID: <809186.1695308608@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Takashi Iwai <tiwai@suse.de> wrote:

> Would you apply it through your tree, or shall I apply this one via
> sound git tree?

It's a prerequisite for a later patch in this series, so I'd prefer to keep it
with my other patches.

David


