Return-Path: <netdev+bounces-40049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C507C58F8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5781C20CAF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FD830F88;
	Wed, 11 Oct 2023 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PttL7bZ3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633032C86
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:16:48 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF53B8
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mO1NJZ9QTjXfmzWezpGcDbKJ7OwJ21COSZwwOOncHcA=;
	t=1697041006; x=1698250606; b=PttL7bZ3KKaSmMJ+PD3W0NZLY9jtyI1nbBQXKN6/g78mH4X
	y1UNs+DieYNbrBTNc4jTTAkNFvVg/v4F0zN4Oe/C0cfSC9zta0RThFTBi3ua6f5B9f+Zk4Ixe5i5c
	sTooqYXn7ZW83rNtyKtIxkjNtoxCbLmYRQLA8lePHMjlADlHF7z8BE2vz2YTLuOL5vE12+GF4dfP+
	pCdMzXLLYPYveeXMankJsYxR1dzc6Fo4LlMMhpIg84mDGgV4z8NvkSfVLb8Ysduc/qCD/ZvCk0GHe
	lBGJW/gfjT3frqhbFTh2SgD2U4D0xFh5D5hl1jOlLq+Bd1+Zu1PNUnKcbS1rsmig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qqbt5-00000001z28-3twV;
	Wed, 11 Oct 2023 18:16:44 +0200
Message-ID: <9c70c71cecf19a50c56ed57c0f99660a3176d11d.camel@sipsolutions.net>
Subject: Re: [RFC] netlink: add variable-length / auto integers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com, fw@strlen.de, 
	pablo@netfilter.org, jiri@resnulli.us, mkubecek@suse.cz, 
	aleksander.lobakin@intel.com, Thomas Haller <thaller@redhat.com>
Date: Wed, 11 Oct 2023 18:16:42 +0200
In-Reply-To: <20231011090859.3fc30812@kernel.org>
References: <20231011003313.105315-1-kuba@kernel.org>
	 <f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
	 <20231011090859.3fc30812@kernel.org>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 09:08 -0700, Jakub Kicinski wrote:
> On Wed, 11 Oct 2023 15:11:15 +0200 Johannes Berg wrote:
> > > +++ b/include/uapi/linux/netlink.h
> > > @@ -298,6 +298,8 @@ struct nla_bitfield32 {
> > >   *	entry has attributes again, the policy for those inner ones
> > >   *	and the corresponding maxtype may be specified.
> > >   * @NL_ATTR_TYPE_BITFIELD32: &struct nla_bitfield32 attribute
> > > + * @NL_ATTR_TYPE_SINT: 32-bit or 64-bit signed attribute, aligned to=
 4B
> > > + * @NL_ATTR_TYPE_UINT: 32-bit or 64-bit unsigned attribute, aligned =
to 4B =20
> >=20
> > This is only for exposing the policy (policy description), not sure the
> > alignment thing matters here?
> >=20
> > OTOH, there's nothing in this file that ever describes *any* of the
> > attributes, yet in pracice all the uapi headers do refer to NLA_U8 and
> > similar - so we should probably have a new comment section here in the
> > UAPI that describes the various types as used by the documentation of
> > other families?
> >=20
> > Anyway, I think some kind of bigger "careful with alignment" here would
> > be good, so people do the correct thing and not just "if (big)
> > nla_get_u64()" which would get the alignment thing problematic again.
>=20
> I was planning to add the docs to Documentation/userspace-api/netlink/
> Is that too YNL-specific?

Oh. I guess I keep expecting that header files at least have some hints,
but whatever ... experience tells me anyway that nobody bothers reading
the comments and people just copy stuff from elsewhere, so we just have
to get this right first in one place ;-)

> diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentatio=
n/userspace-api/netlink/specs.rst
> index cc4e2430997e..a8218284e67a 100644
> --- a/Documentation/userspace-api/netlink/specs.rst
> +++ b/Documentation/userspace-api/netlink/specs.rst
> @@ -408,10 +408,21 @@ This section describes the attribute types supporte=
d by the ``genetlink``
>  compatibility level. Refer to documentation of different levels for addi=
tional
>  attribute types.
> =20
> -Scalar integer types
> +Common integer types
>  --------------------
> =20
> -Fixed-width integer types:
> +``sint`` and ``uint`` represent signed and unsigned 64 bit integers.
> +If the value can fit on 32 bits only 32 bits are carried in netlink
> +messages, otherwise full 64 bits are carried. Note that the payload
> +is only aligned to 4B, so the full 64 bit value may be unaligned!
> +
> +Common integer types should be preferred over fix-width types in majorit=
y
> +of cases.
> +
> +Fix-width integer types
> +-----------------------
> +
> +Fixed-width integer types include:
>  ``u8``, ``u16``, ``u32``, ``u64``, ``s8``, ``s16``, ``s32``, ``s64``.
> =20
>  Note that types smaller than 32 bit should be avoided as using them
> @@ -421,6 +432,9 @@ See :ref:`pad_type` for padding of 64 bit attributes.
>  The payload of the attribute is the integer in host order unless ``byte-=
order``
>  specifies otherwise.
> =20
> +64 bit values are usually aligned by the kernel but it is recommended
> +that the user space is able to deal with unaligned values.
> +
>  .. _pad_type:
>=20

That does look good though :)

johannes

