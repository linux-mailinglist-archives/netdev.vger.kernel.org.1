Return-Path: <netdev+bounces-29059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C45F7818B5
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A82281C49
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF5B441D;
	Sat, 19 Aug 2023 10:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5551C17;
	Sat, 19 Aug 2023 10:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D862CC433C7;
	Sat, 19 Aug 2023 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1692439572;
	bh=eZmjagX06AR0K5BLwB36iJyx8ATCTPYSXUB2lSow2tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oozmb8NYVD4jQQRjJEOWIn7yMeKn7xI4+shKJJU9Gu78uzOjqJtClLybhs3IasuDm
	 kLGvPYP+JmwlimLUtAni2m+A88effmA5MAIQYpNrDt8CAbIbyxRY54bhm8rFp466jp
	 R9Fdyhztw4Xcq2xFfybSOE2jDSM99pAh4OjDPwLk=
Date: Sat, 19 Aug 2023 12:06:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	kernel test robot <lkp@intel.com>, Yujie Liu <yujie.liu@intel.com>,
	Philip Li <philip.li@intel.com>, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Message-ID: <2023081940-linguist-pantomime-ebc2@gregkh>
References: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <202308170000.YqabIR9D-lkp@intel.com>
 <cfc29063-9e20-5101-d70b-62b5423d2d10@intel.com>
 <CANiq72m9ZEVkP76FMFOnPYkA8ih4Mq72HtW9AbrJ-JPy9ku3jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m9ZEVkP76FMFOnPYkA8ih4Mq72HtW9AbrJ-JPy9ku3jw@mail.gmail.com>

On Fri, Aug 18, 2023 at 01:10:07PM +0200, Miguel Ojeda wrote:
> On Fri, Aug 18, 2023 at 12:38 PM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
> >
> > Rust folks, could you please tell me if this is something I should fix,
> > or I just uncovered some existing bug in "unstable" thing?
> >
> > Perhaps it is worth to mention, diff of v3 vs v2 is:
> > move dummy implementation of __has_builtin() macro to the top of
> > compiler_types.h, just before `#ifndef ASSEMBLY`
> 
> Nothing you need to worry about, it is an issue with old `bindgen` and
> LLVM >= 16, fixed in commit 08ab786556ff ("rust: bindgen: upgrade to
> 0.65.1") which is in `rust-next` at the moment. Sorry about that, and
> thanks for pinging us!
> 
> LKP / Yujie / Philip: since we got a few reports on this, would it be
> possible to avoid LLVM >= 16 for Rust-enabled builds for any branch
> that does not include the new `bindgen` or at least 08ab786556ff? Or,
> if Greg is OK with that, I guess we could also backport the upgrade,
> but perhaps it is a bit too much for stable?

Commit is tiny enough for stable backports if it fixes a real issue that
everyone needs to address, so I have no objection to taking it for
stable releases once it hits Linus's tree.

thanks,

greg k-h

