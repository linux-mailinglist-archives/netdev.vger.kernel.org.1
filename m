Return-Path: <netdev+bounces-56977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D24B8117C2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB61F286115
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF908534D;
	Wed, 13 Dec 2023 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="mREbFX7l"
X-Original-To: netdev@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED1B2;
	Wed, 13 Dec 2023 07:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=7//ZdDSj+QqrNUi/Q5v5UfWHhwMOn9RO8A+kW7pJWZQ=; b=mREbFX7lEogiXaaRoZFSpgjtu4
	U2kQQSMGEIdblZxPKwD9cRXFhIxlM3PuImXIBkKgc3rSQr+G3fGLW5bDqTRmQgrcyrjaXM9DbVHxP
	88/e6AhC50j/6S0VHchBBxbzoO0OvkCptkHWsT86VZ1poIfwRi2/XqbH4jhQXEKlnTUefh9K0tZ+4
	zCh2KVyTjAFhw0Y0MHa8bA7ZFGWcbpf/+7jNYTHG0ENXa7IV3keFu2ApRDOAzXCNGr4Q1yFWndahW
	rBC8hinUHvTkMz+mcSreDQH0rpgbV1GGrpkLiKCMT8NjBYOtXY1iTk69JU4K4pWRSTCGtVW6TdMT1
	a2UIsAykP8NsCkVNzYnyKoSUWwNv4ft9or7ZIBjDQGFWYYiH/1kLHBQRzkDNmJYWzfWMgxmpTlVUI
	ePj/QII0KBGj42bsJLngP8YuA/P5i3BTF7q1f8/lKfivAycXf7SoR/LxQqh5ghWGGKNf7jtW/EirZ
	Uo5gEb5Jrlc07sOFDpGn9jIUNEqOv+diInVfAzlFEAd+C7CPOduxkhfokH6IyEozwa3voZ152z8Ry
	BlqMDUHL3OdAcOGmk4zT4Mx6CtZdMh3d4aheBcTdcfkh5d1kMTSJ7NEC0JkUyJIQ188GoYJ+aYml5
	4fTneTZgDYIsW3C8FGbVlAXu47ughRBAS2T0PTGZ8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
 David Howells <dhowells@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH v4 39/39] 9p: Use netfslib read/write_iter
Date: Wed, 13 Dec 2023 16:39:54 +0100
Message-ID: <189166113.2PRW8NTP99@silver>
In-Reply-To: <20231213152350.431591-40-dhowells@redhat.com>
References:
 <20231213152350.431591-1-dhowells@redhat.com>
 <20231213152350.431591-40-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, December 13, 2023 4:23:49 PM CET David Howells wrote:
> Use netfslib's read and write iteration helpers, allowing netfslib to take
> over the management of the page cache for 9p files and to manage local disk
> caching.  In particular, this eliminates write_begin, write_end, writepage
> and all mentions of struct page and struct folio from 9p.
> 
> Note that netfslib now offers the possibility of write-through caching if
> that is desirable for 9p: just set the NETFS_ICTX_WRITETHROUGH flag in
> v9inode->netfs.flags in v9fs_set_netfs_context().
> 
> Note also this is untested as I can't get ganesha.nfsd to correctly parse
> the config to turn on 9p support.

Do you have a chance to test this 9p patch with QEMU instead maybe?

/Christian



