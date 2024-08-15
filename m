Return-Path: <netdev+bounces-118916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB7953825
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBF81F23C76
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993C1B4C23;
	Thu, 15 Aug 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+4zvyf7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5FB37703;
	Thu, 15 Aug 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738808; cv=none; b=U06q/IlzdQzaRbsMsbXkW6Ax/tN6lKVOJvDlJ+iiR1CbAWJVBTaa8z74F7cAm8lfALGS7fQNkT4SK2+MOIR/PJb9aV8/cTAN3xYywkALDSU+RN8P92ok+JxzuJGCFZEueDrL4WqHjJj9/LddwqN07pFWBxjfqTDQLOkTVYYt+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738808; c=relaxed/simple;
	bh=tINqSAJ3XeozQYxrCrqrG4Gnf0ia+Hyq8LR2Egz4I8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrHXEDpVKQPBUEF93hl+ms43i1lmIbBSDA8hH6vGSHsRU8Q2/1wX6dWUKA6in+kIU1rR7XKBHQKoUrQd0CUciXcafuNcsCE4HJlZp5TlIhlARU9GlKE61aLpV/KGknIEvyGNgAC4axlG8JE58hykupSz3NkUo8leODdUEXDgINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+4zvyf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C473FC32786;
	Thu, 15 Aug 2024 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723738807;
	bh=tINqSAJ3XeozQYxrCrqrG4Gnf0ia+Hyq8LR2Egz4I8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+4zvyf7Dn9bhrMk44cFgS6zC4kGy9J8vPELArVvCYQRZPdvVO6d5rq0U9x+Gr5Os
	 zlySxxiFUq6Vk5vY99XBuQrGPD8J6vGwnxHSEa3mehVjW9IGaR77xqtPZRH6OO1cIa
	 z3WnCylFV7Ua3KngAGJbeQF4g9A71qhZHdNfAHVuWQN4E21/UiyHwRzpEs/0Jq/X/y
	 zRV2P1seD+ddhctZSflVmE3TA09qZ85ad42AJ1h9BQyFNZ8Kj98IF9KqgN5t260SRQ
	 lXfkNCXliNlE1fAby9q2KIh2slIMMiC3VKWKe7OdQ3Ji/sMOcWbOBvn2SIe6yR/EPu
	 d/YUmuneot25w==
Date: Thu, 15 Aug 2024 09:20:07 -0700
From: Kees Cook <kees@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Breno Leitao <leitao@debian.org>, elver@google.com,
	andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	axboe@kernel.dk, asml.silence@gmail.com, netdev@vger.kernel.org
Subject: Re: UBSAN: annotation to skip sanitization in variable that will wrap
Message-ID: <202408150915.150AC9A3E@keescook>
References: <Zrzk8hilADAj+QTg@gmail.com>
 <CAFhGd8oowe7TwS88SU1ETJ1qvBP++MOL1iz3GrqNs+CDUhKbzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8oowe7TwS88SU1ETJ1qvBP++MOL1iz3GrqNs+CDUhKbzg@mail.gmail.com>

On Wed, Aug 14, 2024 at 02:05:49PM -0700, Justin Stitt wrote:
> Hi,
> 
> On Wed, Aug 14, 2024 at 10:10 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Hello,
> >
> > I am seeing some signed-integer-overflow in percpu reference counters.
> 
> it is brave of you to enable this sanitizer :>)
> 
> >
> >         UBSAN: signed-integer-overflow in ./arch/arm64/include/asm/atomic_lse.h:204:1
> >         -9223372036854775808 - 1 cannot be represented in type 's64' (aka 'long long')
> >         Call trace:
> >
> >          handle_overflow
> >          __ubsan_handle_sub_overflow
> >          percpu_ref_put_many
> >          css_put
> >          cgroup_sk_free
> >          __sk_destruct
> >          __sk_free
> >          sk_free
> >          unix_release_sock
> >          unix_release
> >          sock_close
> >
> > This overflow is probably happening in percpu_ref->percpu_ref_data->count.
> >
> > Looking at the code documentation, it seems that overflows are fine in
> > per-cpu values. The lib/percpu-refcount.c code comment says:
> >
> >  * Note that the counter on a particular cpu can (and will) wrap - this
> >  * is fine, when we go to shutdown the percpu counters will all sum to
> >  * the correct value
> >
> > Is there a way to annotate the code to tell UBSAN that this overflow is
> > expected and it shouldn't be reported?
> 
> Great question.
> 
> 1) There exists some new-ish macros in overflow.h that perform
> wrapping arithmetic without triggering sanitizer splats -- check out
> the wrapping_* suite of macros.
> 
> 2) I have a Clang attribute in the works [1] that would enable you to
> annotate expressions or types that are expected to wrap and will
> therefore silence arithmetic overflow/truncation sanitizers. If you
> think this could help make the kernel better then I'd appreciate a +1
> on that PR so it can get some more review from compiler people! Kees
> and I have some other Clang features in the works that will allow for
> better mitigation strategies for intended overflow in the kernel.
> 
> 3) Kees can probably chime in with some other methods of getting the
> sanitizer to shush -- we've been doing some work together in this
> space. Also check out [2]

I haven't checked closely yet, but I *think* top 4 patches here[1]
(proposed here[2]) fix the atomics issues. The haven't landed due to
atomics maintainers wanting differing behavior from the compiler that
Justin is still working on (the "wraps" attribute alluded to above[3]).

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=dev/v6.8-rc2/signed-overflow-sanitizer
[2] https://lore.kernel.org/linux-hardening/20240424191225.work.780-kees@kernel.org/
[3] https://github.com/llvm/llvm-project/pull/86618

-- 
Kees Cook

