Return-Path: <netdev+bounces-21113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973437627C1
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55521281B23
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 00:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA374622;
	Wed, 26 Jul 2023 00:30:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9510EB
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D78C433C8;
	Wed, 26 Jul 2023 00:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690331438;
	bh=HwRJf2zxAV2y30LZeuhROoAoaYKeWsk0jz6e4I2TDSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O/Ew3KvC2OYxWejrYo1gr0rQQ3g5uQPthHMWNklJWVnh5zoMPVe9NzCIdZwAQXmLf
	 +1A+Di9DS6TD36yOmgISCSfAjdrPLh2TO7Gbf1llPGWTo3i3KCDRMNpz0eJEW06PkR
	 PILqC53xtrFUkEZcCYmGEATmmHWo2vsJnwIEiJQWQZ8e39JEEtVOjgEdF788hEV7y6
	 LbY+o2nfE+LCSAt0m1hkH+uxNWGQuJzg87s9AuaxvDlkX5mUpfPQUchBaBrAbCjAd9
	 vjYoJAQjDlA/IbWCElcdUES1bgjq+sK/7YXbIMhgjI05BqtIe16+S+ZTjck/dNyHVE
	 3UZ8A2gLfr8dw==
Date: Tue, 25 Jul 2023 17:30:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Jeff
 Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, Chuck
 Lever III <chuck.lever@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Boris Pismenny
 <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Gal
 Pressman <gal@nvidia.com>, ranro@nvidia.com, samiram@nvidia.com,
 drort@nvidia.com, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
Message-ID: <20230725173036.442ba8ba@kernel.org>
In-Reply-To: <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
	<4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
	<20230522121125.2595254-1-dhowells@redhat.com>
	<20230522121125.2595254-9-dhowells@redhat.com>
	<2267272.1686150217@warthog.procyon.org.uk>
	<5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
	<776549.1687167344@warthog.procyon.org.uk>
	<7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
	<20230630102143.7deffc30@kernel.org>
	<f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
	<20230705091914.5bee12f8@kernel.org>
	<bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jul 2023 09:35:56 +0300 Tariq Toukan wrote:
> Hi Jakub, David,
> 
> We repro the issue on the server side using this client command:
> $ wrk -b2.2.2.2 -t4 -c1000 -d5 --timeout 5s 
> https://2.2.2.3:20443/256000b.img
> 
> Port 20443 is configured with:
>      ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256;
>      sendfile    off;
> 
> 
> Important:
> 1. Couldn't repro with files smaller than 40KB.
> 2. Couldn't repro with "sendfile    on;"
> 
> In addition, we collected the vmcore (forced by panic_on_warn), it can 
> be downloaded from here:
> https://drive.google.com/file/d/1Fi2dzgq6k2hb2L_kwyntRjfLF6_RmbxB/view?usp=sharing

This has no symbols :(

There is a small bug in this commit, we should always set SPLICE.
But I don't see how that'd cause the warning you're seeing.
Does your build have CONFIG_DEBUG_VM enabled?

-->8-------------------------

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 25 Jul 2023 17:03:25 -0700
Subject: net: tls: set MSG_SPLICE_PAGES consistently

We used to change the flags for the last segment, because
non-last segments had the MSG_SENDPAGE_NOTLAST flag set.
That flag is no longer a thing so remove the setting.

Since flags most likely don't have MSG_SPLICE_PAGES set
this avoids passing parts of the sg as splice and parts
as non-splice.

... tags ...
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b6896126bb92..4a8ee2f6badb 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -139,9 +139,6 @@ int tls_push_sg(struct sock *sk,
 
 	ctx->splicing_pages = true;
 	while (1) {
-		if (sg_is_last(sg))
-			msg.msg_flags = flags;
-
 		/* is sending application-limited? */
 		tcp_rate_check_app_limited(sk);
 		p = sg_page(sg);
-- 
2.41.0


