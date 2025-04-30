Return-Path: <netdev+bounces-187094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDB5AA4E6A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256063ABEBE
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14955248F6D;
	Wed, 30 Apr 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC5Z9VX9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FF25A358;
	Wed, 30 Apr 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023038; cv=none; b=U+Noyq0k/Ym8PaQSi7Ke0XYG0KwC6sv2O0D4FFhfs5TG6CQV4BTfzFeGQsO++N8m9UtfFMEsvpfAIBsjDT2ZmKKiRl7UMb6LJvZxE22pTshPUnsRDUGCX8DM/idtN8HrM0Ppn0zEOnbItGqrS0+f0nccb3SouuQG11O4UQW6lr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023038; c=relaxed/simple;
	bh=vQpNCpwfOnTdaIvqCMKnbeo0O+wpS7K3veMYLY+EfWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbJZeIrJKEpZX+IZlwZbdsXNDJcAsRrq2vzPa1CgkbO5tYWEfpocCNthP1wi6P6sbOV38seTvkrhDR2eNMQZbdpw6D0sq0DL2+x56/cU2+WSy0X/1vQMGi+p/rQvTtDooIejoXRo/iieTK6m2MsVp/YjwN5gOBXtCG69XMWUrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC5Z9VX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66969C4CEE7;
	Wed, 30 Apr 2025 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746023037;
	bh=vQpNCpwfOnTdaIvqCMKnbeo0O+wpS7K3veMYLY+EfWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WC5Z9VX90xfRhxGWOo8Xadmqx7sGi8dbrZF6iW4f+7hbRseUJtcOvjbNTOh4wG0Jp
	 VJ+GZ+M/EMpiZT7/sLJ7I2j1xeHwFwjYLN2gzc09JEpZPig0tvGzY9Doc8+ePLycjP
	 yWinWX56NUkR+QsPn0YQrVwkYQpVqxwuu9/UVcDYKbjYxlZteFTC/IbMS5ywdLnQJD
	 MddFwPIPeUxhYe06Qmvrsw01Z0AkNKSEoPCCy0N96OWvz6h4+cNY+Ms9Zj4eRPKs2Q
	 CFF0EiMWQwt54mrMj1BxiiNtIvucqFvYUMZ64J6QhwhssByFiredm/sAxvCZRT8bCj
	 RE7Vqc3z3Ubzw==
Date: Wed, 30 Apr 2025 07:23:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni	
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula	
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki Iwashima	
 <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor	
 <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v5 04/10] ref_tracker: allow pr_ostream() to print
 directly to a seq_file
Message-ID: <20250430072355.73a79f55@kernel.org>
In-Reply-To: <98d797ae3a65fbe5a5cc586ad43b74655a9ba109.camel@kernel.org>
References: <20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org>
	<20250428-reftrack-dbgfs-v5-4-1cbbdf2038bd@kernel.org>
	<20250429162704.4729a76a@kernel.org>
	<98d797ae3a65fbe5a5cc586ad43b74655a9ba109.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 19:18:01 -0700 Jeff Layton wrote:
> On Tue, 2025-04-29 at 16:27 -0700, Jakub Kicinski wrote:
> > On Mon, 28 Apr 2025 11:26:27 -0700 Jeff Layton wrote:  
> > > Allow pr_ostream to also output directly to a seq_file without an
> > > intermediate buffer.
> > > 
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>  
> > 
> > lib/ref_tracker.c:316:12: warning: unused function 'ref_tracker_dir_seq_print' [-Wunused-function]
> >   316 | static int ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~~~  
> 
> The caller ends up being added in patch #6. I think the only thing I
> can do here to silence this is to squash this patch into that one.
> 
> I kind of don't like doing that here because I think the patches are
> conceptually separate, and it'll make for a rather large patch.
> 
> Let me know what you prefer.

Would it work to make the fops very dumbed down - return an error 
from open. And then implement the seqfile output as the next patch?

