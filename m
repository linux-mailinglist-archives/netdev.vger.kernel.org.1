Return-Path: <netdev+bounces-39985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086577C5504
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AE91C20DC3
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6EC1EA8B;
	Wed, 11 Oct 2023 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iG/qXQk1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092791A27C
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:11:25 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C4B8
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=42tnqTom3lqnbtnAUV2jklMcZP8YtoRpkftaoZuprnM=;
	t=1697029881; x=1698239481; b=iG/qXQk1pqdGX34TbjHgz4PoanUoh41B7AwnUyMUMJHkniR
	eu6q7Pu3ggkH7rUaC7lLJkCdYvocT1Z7+M68CwBMYvub69ayqLqfY+aEZhF5BIPpWd6+dCK3XCKpQ
	AvsIYZ0aaRkjuP0ZHp27jwkPh6Rcipl20SxPfFobmhJMQjl+3XeZgWZbthfhkBVPRNIJbtEm8sUUA
	hoAVBo+XLH3l024v2HJhseyTMBd7VdFMOISsZ8fU9ktV0ZCepgcNc/lPmlpYRJRwDXAOYWORF/1JU
	+Pmh9BL4wsp71hdT96YOmsYuV1XpDTpZG0r8F3QR5eC4x5dNq3Y8iHXXgGrpDTrg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qqYzc-00000001sD5-3K8M;
	Wed, 11 Oct 2023 15:11:17 +0200
Message-ID: <f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
Subject: Re: [RFC] netlink: add variable-length / auto integers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com, fw@strlen.de, pablo@netfilter.org, 
 jiri@resnulli.us, mkubecek@suse.cz, aleksander.lobakin@intel.com, Thomas
 Haller <thaller@redhat.com>
Date: Wed, 11 Oct 2023 15:11:15 +0200
In-Reply-To: <20231011003313.105315-1-kuba@kernel.org>
References: <20231011003313.105315-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+Thomas Haller, if you didn't see it yet.


On Tue, 2023-10-10 at 17:33 -0700, Jakub Kicinski wrote:
> We currently push everyone to use padding to align 64b values in netlink.
> I'm not sure what the story behind this is. I found this:
> https://lore.kernel.org/all/1461339084-3849-1-git-send-email-nicolas.dich=
tel@6wind.com/#t
> but it doesn't go into details WRT the motivation.
> Even for arches which don't have good unaligned access - I'd think
> that access aligned to 4B *is* pretty efficient, and that's all
> we need. Plus kernel deals with unaligned input. Why can't user space?

Hmm. I have a vague recollection that it was related to just not doing
it - the kernel will do get_unaligned() or similar, but userspace if it
just accesses it might take a trap on some architectures?

But I can't find any record of this in public discussions, so ...


In any case, I think for _new_ attributes it would be perfectly
acceptable to do it without padding, as long as userspace is prepared to
do unaligned accesses for them, so we might need something in libnl (or
similar) to do it correctly.

> Padded 64b is quite space-inefficient (64b + pad means at worst 16B
> per attr vs 32b which takes 8B). It is also more typing:
>=20
>     if (nla_put_u64_pad(rsp, NETDEV_A_SOMETHING_SOMETHING,
>                         value, NETDEV_A_SOMETHING_PAD))
>=20
> Create a new attribute type which will use 32 bits at netlink
> level if value is small enough (probably most of the time?),
> and (4B-aligned) 64 bits otherwise. Kernel API is just:
>=20
>     if (nla_put_uint(rsp, NETDEV_A_SOMETHING_SOMETHING, value))
>=20
> Calling this new type "just" sint / uint with no specific size
> will hopefully also make people more comfortable with using it.
> Currently telling people "don't use u8, you may need the space,
> and netlink will round up to 4B, anyway" is the #1 comment
> we give to newcomers.

Yeah :)

> Thoughts?

Seems reasonable. I thought about endian variants, but with the variable
size that doesn't make much sense.

I do think the documentation in the patch could be clearer about the
alignment, see below.

> +++ b/include/net/netlink.h
> @@ -183,6 +183,8 @@ enum {
>  	NLA_REJECT,
>  	NLA_BE16,
>  	NLA_BE32,
> +	NLA_SINT,
> +	NLA_UINT,

You should also update the policy-related documentation in this file.

> +++ b/include/uapi/linux/netlink.h
> @@ -298,6 +298,8 @@ struct nla_bitfield32 {
>   *	entry has attributes again, the policy for those inner ones
>   *	and the corresponding maxtype may be specified.
>   * @NL_ATTR_TYPE_BITFIELD32: &struct nla_bitfield32 attribute
> + * @NL_ATTR_TYPE_SINT: 32-bit or 64-bit signed attribute, aligned to 4B
> + * @NL_ATTR_TYPE_UINT: 32-bit or 64-bit unsigned attribute, aligned to 4=
B

This is only for exposing the policy (policy description), not sure the
alignment thing matters here?

OTOH, there's nothing in this file that ever describes *any* of the
attributes, yet in pracice all the uapi headers do refer to NLA_U8 and
similar - so we should probably have a new comment section here in the
UAPI that describes the various types as used by the documentation of
other families?

Anyway, I think some kind of bigger "careful with alignment" here would
be good, so people do the correct thing and not just "if (big)
nla_get_u64()" which would get the alignment thing problematic again.

johannes

