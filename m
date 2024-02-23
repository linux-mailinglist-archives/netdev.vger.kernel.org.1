Return-Path: <netdev+bounces-74426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A425186140A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459FDB21B09
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DF74A2C;
	Fri, 23 Feb 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2trMfa8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06CC14B815
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698905; cv=none; b=lC+y68Uk0qfNsF+STh/BX7R6IXStHvHYq9lK4vkzaabyfsXEBy2r8PgPj7OQjAtvIwJXLM3iVyojzpa8Idnt2WO9Z/+DkILxfALLN5iASRMds9v/UK9QVA/hmQNc/9l01KXIUSYYHdKvTegTNpV5JMPDFdalRVWIDlBieY1MGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698905; c=relaxed/simple;
	bh=PGZIjJG5KApyaBPqRVxOzs8JxonVLRulA8d+Los5Gj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKGWwtgnf8uoalz1jyNHp4VFAVknk63miSeZ2N+KdMtIMoksqJkBYQG4SwVKvHmeUp6V3njIoB3Zyt1fuvEMSbt/utiVqjt5hwVI48T9S9SxDCgIF0kose8gKGpLYSJfH2I4tAQf2gKLSSE2qitAUD8tEB0lkWQYiwSzRtHe28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2trMfa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46321C433C7;
	Fri, 23 Feb 2024 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708698905;
	bh=PGZIjJG5KApyaBPqRVxOzs8JxonVLRulA8d+Los5Gj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W2trMfa8bm9wQ4mOoDRHpWt2gHXNUjeHPjrXOuiCsf0Lwi/Qw12UV8I5SsP1yLRLe
	 4UnUfcgYYPOi47V18EguWD3eCN5O4RsVIsLm2qw6H99UQb0Hdd/cQVSIk/fuSqeo17
	 pBXIZo3mZJ70w3XG+3e0Og705O3JoAFcTcqKY+M6uFEK1ZpL4XbRXxEJEql+mB6vv9
	 PXGt1hyl+lsCjI63I9oskr+m7qQiL1q6t6FMnWI8FHtfZeIMJpSfP+7HLJ8MNuw2aQ
	 HKXVC8WQt3RXxEI5Ss/PdnlhcuuVzRqaAyHCQaRCINZ0q17aICOGy6fzRkh2ypWBpY
	 Li7V2Z9tIKAzQ==
Date: Fri, 23 Feb 2024 06:35:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, sdf@google.com,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next 01/15] tools: ynl: give up on libmnl for
 auto-ints
Message-ID: <20240223063504.7a69f2c5@kernel.org>
In-Reply-To: <5ec74f4d-5dbd-4c2d-ab11-d00b0208b138@6wind.com>
References: <20240222235614.180876-1-kuba@kernel.org>
	<20240222235614.180876-2-kuba@kernel.org>
	<5ec74f4d-5dbd-4c2d-ab11-d00b0208b138@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Feb 2024 14:51:12 +0100 Nicolas Dichtel wrote:
> > +static inline __s64 mnl_attr_get_sint(const struct nlattr *attr)
> > +{
> > +	switch (mnl_attr_get_payload_len(attr)) {
> > +	case 4:
> > +		return mnl_attr_get_u32(attr);
> > +	case 8:
> > +		return mnl_attr_get_u64(attr);
> > +	default:
> > +		return 0;
> > +	}
> >  } =20
> mnl_attr_get_uint() and mnl_attr_get_sint() are identical. What about
> #define mnl_attr_get_sint mnl_attr_get_uint
> ?

I like to have the helpers written out =F0=9F=A4=B7=EF=B8=8F
I really hate the *_encode_bits macros in the kernel, maybe I'm
swinging to hard in the opposite direction, but let me swing! :)

> >  static inline void
> > -mnl_attr_put_uint(struct nlmsghdr *nlh, uint16_t type, uint64_t data)
> > +mnl_attr_put_uint(struct nlmsghdr *nlh, __u16 type, __u64 data) =20
> Is there a reason to switch from uint*_t to __u* types?

YNL uses the kernel __{s,u}{8,16,32,64} types everywhere.
These were an exception because they were following libmnl's types.

