Return-Path: <netdev+bounces-77213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA9C870ABF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25B91C20BBC
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8144879943;
	Mon,  4 Mar 2024 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nHlxzap5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F078B57
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580730; cv=none; b=qDiKw84R/+4HQRgMRhyNN8sty6wD3gD9YExqjidsv7L7b7jJv0V0ja5h/v9x9gnT4cvdgm/7+AGWe9B1pu4sY9rcEJ47nmk3+KjeFLFgBlOEOfhcS3OFbq9ZfLPpXQNAEm7MmD4rEnk294zrJJpCE+G2bwHcNbClhr9wZb7Sqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580730; c=relaxed/simple;
	bh=uHJy5cR+Cz7GNPm99CUukbZb3URnbaKBlxNZRwj9ETA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8pIbjfmjCQTM3XbwWqy9gZZ/vjVV+nliSL3urSuK1efPQUzL+vpqmre6opoFX3cWZPrubfBPXAJRVF/TaOse7XgiVXfGzL60CeLpbCyogf7X6ln6Z4d9vqFuIbgeJvHh+GUIkSZuPuoT1F+Bel9gF+dNOM/jEXv73aSIhjzuE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nHlxzap5; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpTNH1PqrzMvsxB;
	Mon,  4 Mar 2024 20:31:59 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TpTNG4V1bzMpnPh;
	Mon,  4 Mar 2024 20:31:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709580719;
	bh=uHJy5cR+Cz7GNPm99CUukbZb3URnbaKBlxNZRwj9ETA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHlxzap5dh7Hb3hyvCUhCG7qrZVTOpWrupgbjtYuF4GQSxXlxZw6zm491eJiOx2t6
	 tlQfTp+fGl+v1Px8ZwbvyG06lURFRrDrGInj0BWmvAipNSvmgne1XxYzGIkNa1xsQl
	 pbAVmThO6M1BHZLiDBTqIqOyh6mVEid3QuXZJv6s=
Date: Mon, 4 Mar 2024 20:31:48 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, jakub@cloudflare.com, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v4 02/12] selftests/harness: Merge TEST_F_FORK() into
 TEST_F()
Message-ID: <20240304.ceje1phaiFei@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <20240229005920.2407409-3-kuba@kernel.org>
 <20240301.Miem9Kei4eev@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301.Miem9Kei4eev@digikod.net>
X-Infomaniak-Routing: alpha

On Mon, Mar 04, 2024 at 08:27:50PM +0100, Mickaël Salaün wrote:
> Testing the whole series, I found that some Landlock tests are flaky
> starting with this patch.  I tried to not use the longjmp in the
> grandchild but it didn't change.  I suspect missing volatiles but I
> didn't find the faulty one(s) yet. :/
> I'll continue investigating tomorrow but help would be much appreciated!

The issue is with the fs_test.c, often starting with this one:

#  RUN           layout1.relative_chroot_only ...
# fs_test.c:294:relative_chroot_only:Expected 0 (0) == umount(TMP_DIR) (-1)
# fs_test.c:296:relative_chroot_only:Expected 0 (0) == remove_path(TMP_DIR) (16)
# relative_chroot_only: Test failed
#          FAIL  layout1.relative_chroot_only

...or this one:

#  RUN           layout3_fs.hostfs.tag_inode_dir_child ...
# fs_test.c:4707:tag_inode_dir_child:Expected 0 (0) == mkdir(self->dir_path, 0700) (-1)
# fs_test.c:4709:tag_inode_dir_child:Failed to create directory "tmp/dir": No such file or directory
# fs_test.c:4724:tag_inode_dir_child:Expected 0 (0) <= fd (-1)
# fs_test.c:4726:tag_inode_dir_child:Failed to create file "tmp/dir/file": No such file or directory
# fs_test.c:4729:tag_inode_dir_child:Expected 0 (0) == close(fd) (-1)
# tag_inode_dir_child: Test failed
#          FAIL  layout3_fs.hostfs.tag_inode_dir_child


> 
> 
> On Wed, Feb 28, 2024 at 04:59:09PM -0800, Jakub Kicinski wrote:
> > From: Mickaël Salaün <mic@digikod.net>
> > 
> > Replace Landlock-specific TEST_F_FORK() with an improved TEST_F() which
> > brings four related changes:
> > 
> > Run TEST_F()'s tests in a grandchild process to make it possible to
> > drop privileges and delegate teardown to the parent.
> > 
> > Compared to TEST_F_FORK(), simplify handling of the test grandchild
> > process thanks to vfork(2), and makes it generic (e.g. no explicit
> > conversion between exit code and _metadata).
> > 
> > Compared to TEST_F_FORK(), run teardown even when tests failed with an
> > assert thanks to commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN
> > for ASSERT failures").
> > 
> > Simplify the test harness code by removing the no_print and step fields
> > which are not used.  I added this feature just after I made
> > kselftest_harness.h more broadly available but this step counter
> > remained even though it wasn't needed after all. See commit 369130b63178
> > ("selftests: Enhance kselftest_harness.h to print which assert failed").
> > 
> > Replace spaces with tabs in one line of __TEST_F_IMPL().
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Will Drewry <wad@chromium.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > --
> > v4:
> >  - GAND -> GRAND
> >  - init child to 1, otherwise assert in setup triggers a longjmp
> >    which in turn reads child without it ever getting initialized
> >    (or being 0, i.e. we mistakenly assume we're in the grandchild)
> 
> Good catch!

