Return-Path: <netdev+bounces-105746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6081E91294D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182151F21025
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FD482FA;
	Fri, 21 Jun 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY06G2OA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D9228DB3
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983147; cv=none; b=pPaJxmxKkXXhAuU1TmxfzwDo82wf4F8SD3fGLm5ImcoOVLXzT6l+cOrnfbdr4Y7pLsL0mMNoNzCgsHofSYvMjE/DhspmIdCEh8AcB6Z293LneoDiGr3+gxGKzxbPgCj5RZDdkJdllWtC3JojKh9m1U9d48OjBbJjJ5dtOLDrlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983147; c=relaxed/simple;
	bh=wz+afc2gxKrziS3ZUul6umAmjb7muSe9xZNGZ7ywM2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L562TtqkcJXNz3JeznslNOkshd5BVaLLSaSdAhq27KkwKC8yZapMMRjZ3M7IPHa+L7TbF46Hp0SsR55Hu3fHp6xfmtJLPbCsI47o6KogJ2NbZGAgOqC+UKvbgOzVi7ZrDIUOgVBHMySagkQ4cSxG5kbw/UroOnPmlYU4TiwHqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tY06G2OA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ABEC2BBFC;
	Fri, 21 Jun 2024 15:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718983147;
	bh=wz+afc2gxKrziS3ZUul6umAmjb7muSe9xZNGZ7ywM2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tY06G2OASrzs8kEe5BsGpDHwIESNucLOyE0qmxeJ8fdqn7+j0HG3QrPmLMvbTnWTS
	 WWqWAh0GB128zt05VV0qHYz2DtHY37mKR/kePXLUCkb6Jtuamxb8Or2pndeKmih///
	 SSgozPxFQR9Szwx9thZtSgXvAB3ano0Qu2DDNVrWSCszxFksPqKa8f0xFnerUkZ18c
	 P8OX5K19M+pze3xjs4zlXFyuQKqnrAsCwPp2IkRNGb1F4FIBa4M4+Cksw3wJAXl4ew
	 89ozUsNnj7jUyQxDuqt8n89ytTbEQZDKClYwRo3aqBqRqY9+dAJy/Fhb/HF5sWx10Z
	 YjhgwyCmDISOg==
Date: Fri, 21 Jun 2024 08:19:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: Netlink specs, help dealing with nested array
Message-ID: <20240621081906.0466c431@kernel.org>
In-Reply-To: <20240621161543.42617bef@kmaincent-XPS-13-7390>
References: <20240621161543.42617bef@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 16:15:43 +0200 Kory Maincent wrote:
> Hello Jakub, Donald or other ynl experts,
> 
> I have an issue dealing with a nested array.
> 
> Here is my current netlink spec and ethtool patches:
> https://termbin.com/gbyx
> https://termbin.com/b325
> 
> Here is the error I got:
> https://termbin.com/c7b1
> 
> I am trying to investigate what goes wrong with ynl but I still don't know.
> If someone have an idea of what is going wrong with ynl or my specs it would be
> lovely! 

You're (correctly) formatting your data as a basic multi-attr.
Instead of:

+        name: c33-pse-pw-limit-ranges
+        name-prefix: ethtool-a-
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: c33-pse-pw-limit

use:

+        name: c33-pse-pw-limit-ranges
+        name-prefix: ethtool-a-
+        type: nest
+        multi-attr: true
+        nested-attributes: c33-pse-pw-limit

The indexed array is described here:
https://docs.kernel.org/next/userspace-api/netlink/genetlink-legacy.html#indexed-array
it has an extra layer of nesting, which uses the index in the array 
as the type of the attribute.

