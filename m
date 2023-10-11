Return-Path: <netdev+bounces-40052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C37C590A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231AC2828E9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC583AC0F;
	Wed, 11 Oct 2023 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vNH1mUPK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5930F88
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:21:53 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9791
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bZtFVgvbVAjM31h7NgC68RnZa/FNuu/zDs1Feq8HTpE=;
	t=1697041311; x=1698250911; b=vNH1mUPKPMnKqJ4D+4GCzs55SbVHFM/kapRwrq3koWUagYT
	qyJ3KRGhCk7YwtxCUoNu/W1mno64yIjCN9KNpQyQzMTeNGVlPCL5ykL5VdEt0Bw5QuqboVte5zW5s
	5m08Lg7qoo9dvXRKQUVoWjTQj1WZm55jjIUzUJyvtHK3mFovDLRu2yMPuA3F2rrVJSDMs1LIxfwc8
	kt1oEF7pssltqAQKcCSCw+//t1dDkU4w2Cfrw5UTWHBrOLGoKnBfCaTCk5ftzkVa0NqCwXRylKNau
	TfGQRif0Dvo/tuAPF01+Ue56LY/KnqrjwsFkQnXLpf2lnuK6OXfMAHRd8EBtoXlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qqby0-00000001zAF-2D6o;
	Wed, 11 Oct 2023 18:21:48 +0200
Message-ID: <1335ccffdaaa5a553717e42a855bba1a6f36dc9b.camel@sipsolutions.net>
Subject: Re: [RFC] netlink: add variable-length / auto integers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com, fw@strlen.de, 
	pablo@netfilter.org, mkubecek@suse.cz, aleksander.lobakin@intel.com
Date: Wed, 11 Oct 2023 18:21:47 +0200
In-Reply-To: <20231011091624.4057e456@kernel.org>
References: <20231011003313.105315-1-kuba@kernel.org>
	 <ZSanRz7kV1rduMBE@nanopsycho> <20231011091624.4057e456@kernel.org>
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

On Wed, 2023-10-11 at 09:16 -0700, Jakub Kicinski wrote:
>=20
> > > +static inline int nla_put_uint(struct sk_buff *skb, int attrtype, u6=
4 value)
> > > +{
> > > +	u64 tmp64 =3D value;
> > > +	u32 tmp32 =3D value;
> > > +
> > > +	if (tmp64 =3D=3D tmp32)
> > > +		return nla_put_u32(skb, attrtype, tmp32); =20
> >=20
> > It's a bit confusing, perheps better just to use nla_put() here as well=
?
>=20
> I want to underscore the equivalency to u32 for smaller types.

ITYM "smaller values".

Now I'm wondering if we should keep ourselves some option of going to
even bigger values (128 bits) in some potential future, but I guess
that's not really natively supported anywhere in the same way 64-bit is
supposed on 32-bit.

johannes

