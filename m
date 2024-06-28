Return-Path: <netdev+bounces-107790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F091C5B3
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B381C22FE1
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DEC51C5A;
	Fri, 28 Jun 2024 18:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB181E50B;
	Fri, 28 Jun 2024 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599548; cv=none; b=g2J7rl7kTNJm1wjS4HbP2r3oALqesFEcJ2fv6YGsPOmOHm/fHcr6Xva9ptf9KgglIKrgy/a2UWrUW9vjtRZlShAZDxWM8iMKqCBKiE1bUyHRNTmsCNbG04wFPvvjrDyfo5NEqlPaMhj5alAv2F+9Tkh0gqmBnHBQxwf3xsuqiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599548; c=relaxed/simple;
	bh=xmAHf1q3wfr6LlUw9tXkd1fc2eHakw/YNd7upQANybk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwRfc9RbteTFxbX7J4EMsvuUrClXVU6+6rnroqMlwZjf4Qhfq+vOItpLOYLiIdmGCkVXkjalzNEpE3R4C9thpBkaKSk9pkPU2sUppqynXZ6DO0rwmQxaCL82HQLLXro6zywyo/04QzvrrcYbOlKi0jTi64Mn7cekaolQf32nQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2938DC116B1;
	Fri, 28 Jun 2024 18:32:26 +0000 (UTC)
Date: Fri, 28 Jun 2024 14:32:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Randy Dunlap
 <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook
 <kees@kernel.org>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
Message-ID: <20240628143224.6fb67dfd@rorschach.local.home>
In-Reply-To: <20240628-mindful-jackal-of-education-95059f@lemur>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
	<20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
	<202406211355.4AF91C2@keescook>
	<20240621-amorphous-topaz-cormorant-cc2ddb@lemur>
	<87cyo3fgcb.fsf@trenco.lwn.net>
	<4709c2fa-081f-4307-bc9e-eef928255c08@infradead.org>
	<62647fab-b3d4-48ac-af4c-78c655dcff26@leemhuis.info>
	<20240628-mindful-jackal-of-education-95059f@lemur>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 10:52:37 -0400
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> On Thu, Jun 27, 2024 at 05:51:47AM GMT, Thorsten Leemhuis wrote:
> > I thought it was documented, but either I was wrong or can't find it.
> > But I found process/5.Posting.rst, which provides this example:
> > 
> >         Link: https://example.com/somewhere.html  optional-other-stuff
> > 
> > So no "# " there. So to avoid inconsistencies I guess this should not be
> > applied, unless that document is changed as well.  
> 
> This is inconsistent with every other trailer that includes comments.
> Currently, there are two mechanisms to provide comments with trailers:
> 
> 1:
> 
>     | Trailer-name: trailer-content # trailer-comment
> 
> 2:
> 
>     | Trailer-name: trailer-content
>     | [trailer-comment]

Where do you see that?

Whenever I do the second one, it has nothing to do with the tag, but
what I have done to the patch/commit.

    Signed-off-by: Random Developer <rdevelop@company.com>
    [ Fixed formatting ]
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

That is, if I do any modification of the original submission, I
document it this way.

-- Steve


> 
> For the sake of consistency, all trailers, including Link, should use one of
> these two mechanisms for "optional-other-stuff".
> 
> -K


