Return-Path: <netdev+bounces-32542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C850C7983D5
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 10:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B600E1C20BE4
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EAE1C39;
	Fri,  8 Sep 2023 08:15:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6A1C35
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 08:15:52 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123E01BD3;
	Fri,  8 Sep 2023 01:15:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D265168B05; Fri,  8 Sep 2023 10:15:44 +0200 (CEST)
Date: Fri, 8 Sep 2023 10:15:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Hildenbrand <david@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Peter Xu <peterx@redhat.com>,
	Lei Huang <lei.huang@linux.intel.com>, miklos@szeredi.hu,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Boris Pismenny <borisp@nvidia.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-mm@kvack.org, v9fs@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: getting rid of the last memory modifitions through
 gup(FOLL_GET)
Message-ID: <20230908081544.GB8240@lst.de>
References: <20230905141604.GA27370@lst.de> <0240468f-3cc5-157b-9b10-f0cd7979daf0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0240468f-3cc5-157b-9b10-f0cd7979daf0@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06, 2023 at 11:42:33AM +0200, David Hildenbrand wrote:
>> and iov_iter_get_pages_alloc2.  We have three file system direct I/O
>> users of those left: ceph, fuse and nfs.  Lei Huang has sent patches
>> to convert fuse to iov_iter_extract_pages which I'd love to see merged,
>> and we'd need equivalent work for ceph and nfs.
>>
>> The non-file system uses are in the vmsplice code, which only reads
>
> vmsplice really has to be fixed to specify FOLL_PIN|FOLL_LONGTERM for good; 
> I recall that David Howells had patches for that at one point. (at least to 
> use FOLL_PIN)

Hmm, unless I'm misreading the code vmsplace is only using
iov_iter_get_pages2 for reading from the user address space anyway.
Or am I missing something?

>> After that we might have to do an audit of the raw get_user_pages APIs,
>> but there probably aren't many that modify file backed memory.
>
> ptrace should apply that ends up doing a FOLL_GET|FOLL_WRITE.

Yes, if that ends up on file backed shared mappings we also need a pin.

> Further, KVM ends up using FOLL_GET|FOLL_WRITE to populate the second-level 
> page tables for VMs, and uses MMU notifiers to synchronize the second-level 
> page tables with process page table changes. So once a PTE goes from 
> writable -> r/o in the process page table, the second level page tables for 
> the VM will get updated. Such MMU users are quite different from ordinary 
> GUP users.

Can KVM page tables use file backed shared mappings?

> Converting ptrace might not be desired/required as well (the reference is 
> dropped immediately after the read/write access).

But the pin is needed to make sure the file system can account for
dirtying the pages.  Something we fundamentally can't do with get.

> The end goal as discussed a couple of times would be the to limit FOLL_GET 
> in general only to a couple of users that can be audited and keep using it 
> for a good reason. Arbitrary drivers that perform DMA should stop using it 
> (and ideally be prevented from using it) and switch to FOLL_PIN.

Agreed, that's where I'd like to get to.  Preferably with the non-pin
API not even beeing epxorted to modules.

