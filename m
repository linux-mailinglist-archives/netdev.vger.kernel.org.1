Return-Path: <netdev+bounces-40046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43457C58E3
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15531C20C28
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B159A30FA6;
	Wed, 11 Oct 2023 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAVOXi/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347F18B04
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26EFC433C8;
	Wed, 11 Oct 2023 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697040541;
	bh=WnJ5RCxwA0isRjaVqyBuaHpPfjrKOMpFwhtS+UV4aMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XAVOXi/1p8in8sSbJXgciObZdgdTQVurw2kzLhlRTtb3pzboL7g4HhY9paLUg5wTU
	 0Dvq3Yw0IZXr0fkXS0BAd7bADqE1N0ZGErybY7ZhslOPtDZn67J+GOxe1Nt/LLP0IF
	 m8VsDzQKbr9MMD/hYpEBESFBPIKBiq0q0i8rU5RzzPdzIq6hhioIeijgK8M88shGws
	 ep7lhA1B7g2f9t1G1ceg9oaxf/X9AUVJo/F/wyxE2cor2CQcH4wSAt7sklgwBmuLdB
	 hSBlZixkIfOO9gsb0qnUJSBrT9UBnxjQA4RC1uE0MfsYPY0x0coBdbQAYcnbPp3X0h
	 SY22PZVY1/4KQ==
Date: Wed, 11 Oct 2023 09:08:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com, fw@strlen.de,
 pablo@netfilter.org, jiri@resnulli.us, mkubecek@suse.cz,
 aleksander.lobakin@intel.com, Thomas Haller <thaller@redhat.com>
Subject: Re: [RFC] netlink: add variable-length / auto integers
Message-ID: <20231011090859.3fc30812@kernel.org>
In-Reply-To: <f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
References: <20231011003313.105315-1-kuba@kernel.org>
	<f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 15:11:15 +0200 Johannes Berg wrote:
> > +++ b/include/uapi/linux/netlink.h
> > @@ -298,6 +298,8 @@ struct nla_bitfield32 {
> >   *	entry has attributes again, the policy for those inner ones
> >   *	and the corresponding maxtype may be specified.
> >   * @NL_ATTR_TYPE_BITFIELD32: &struct nla_bitfield32 attribute
> > + * @NL_ATTR_TYPE_SINT: 32-bit or 64-bit signed attribute, aligned to 4B
> > + * @NL_ATTR_TYPE_UINT: 32-bit or 64-bit unsigned attribute, aligned to 4B  
> 
> This is only for exposing the policy (policy description), not sure the
> alignment thing matters here?
> 
> OTOH, there's nothing in this file that ever describes *any* of the
> attributes, yet in pracice all the uapi headers do refer to NLA_U8 and
> similar - so we should probably have a new comment section here in the
> UAPI that describes the various types as used by the documentation of
> other families?
> 
> Anyway, I think some kind of bigger "careful with alignment" here would
> be good, so people do the correct thing and not just "if (big)
> nla_get_u64()" which would get the alignment thing problematic again.

I was planning to add the docs to Documentation/userspace-api/netlink/
Is that too YNL-specific?

diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
index cc4e2430997e..a8218284e67a 100644
--- a/Documentation/userspace-api/netlink/specs.rst
+++ b/Documentation/userspace-api/netlink/specs.rst
@@ -408,10 +408,21 @@ This section describes the attribute types supported by the ``genetlink``
 compatibility level. Refer to documentation of different levels for additional
 attribute types.
 
-Scalar integer types
+Common integer types
 --------------------
 
-Fixed-width integer types:
+``sint`` and ``uint`` represent signed and unsigned 64 bit integers.
+If the value can fit on 32 bits only 32 bits are carried in netlink
+messages, otherwise full 64 bits are carried. Note that the payload
+is only aligned to 4B, so the full 64 bit value may be unaligned!
+
+Common integer types should be preferred over fix-width types in majority
+of cases.
+
+Fix-width integer types
+-----------------------
+
+Fixed-width integer types include:
 ``u8``, ``u16``, ``u32``, ``u64``, ``s8``, ``s16``, ``s32``, ``s64``.
 
 Note that types smaller than 32 bit should be avoided as using them
@@ -421,6 +432,9 @@ See :ref:`pad_type` for padding of 64 bit attributes.
 The payload of the attribute is the integer in host order unless ``byte-order``
 specifies otherwise.
 
+64 bit values are usually aligned by the kernel but it is recommended
+that the user space is able to deal with unaligned values.
+
 .. _pad_type:
 
 pad

