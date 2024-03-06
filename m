Return-Path: <netdev+bounces-78136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE0874305
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF9A1F21C72
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1781BC35;
	Wed,  6 Mar 2024 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVBradPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76121B945
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765662; cv=none; b=e5lJrVUQ3bB7Utjpg2qodM9A/ZDpK5cIHaK8rZMALeZsDINuDQuCj7r/krEKPo+QSO6diml+6i33OT4W1Op4hPDkSXWttWNGhy3qoLpI2T1+WDjUDMofJ883kvUMiG1dk5feV+8rmBY2y+anz1g+CsUBDbLkdcrsvh5AP/S5P/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765662; c=relaxed/simple;
	bh=dbsVtHVNGHoUvIXKSu4+A5o+4rW9/gQG6wosuI8JQiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvaUQPnBJwAMEBLBBSu9TIPULQV1APdGUko1DMTaEwAOyLKB84kqJSRBvMMp35PUS2qcuzfwmFJyRP1QF8lY92Usraf/JyKYypgjhdiYuImqdwiSCdBUaYnSzieByqufFXKLNHAzMvbRxlnQaLNyHD268gTQ3hVhKtWhULx8wKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVBradPY; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c19aaedfdaso79589b6e.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 14:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709765660; x=1710370460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dyG1wjcG5DONnTiq/lLXMQMighwcy7bhQR6Vf6iUdZs=;
        b=UVBradPYuppwHYd9gajgapTfHpwaaqkPPgpYr5TQ99eh3CIZOoaRNlOBPd1EIN7Api
         7XaIDZ3dBAth9mmkWBPY3lRruHt9EksNwvSTQL2LZUEw26Po+omR2uQrunfvev1RUTXh
         n4xS1W98uQ0DjdrOawErmJri5Mmqwfu+zjZUJuCZOOiUZCQs3+F3h5+bS4IsCL9y5Cev
         IC4GEjrtNC6oDEu7NFY24VRWRWvfcD8f82GJCwxSslRoSOAWYR508iWSVB/1lCwS5oYN
         +Ya8WmU5E1X7A80X2SG/1hU9WA6QtKLdoio6FOsPbehgHzvByS9vcJpk2k0OkAlCRCyD
         Gq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765660; x=1710370460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyG1wjcG5DONnTiq/lLXMQMighwcy7bhQR6Vf6iUdZs=;
        b=SVQl3qqTgJMDnkoUBTGYM7oBUIfM4A134uUbfraOqwdpdzUEumx9aZ9UqAbYby+44b
         pgBa8K6Z1ohg45rEwVvYzWq2Z10d5Z+7rZoyb/dY8UAiseb86lJat0mDam0/Y3e9zF+9
         luT0IhxCHV5F/uymbLkYkKnD4LNbtvOwLKWNYDE5uzyBIBhs91ZBm2V1gK/UefnL0e5Y
         eB25fxZKjL+jXDferOFT0qWn0AqOsFFYaoTmpoUN0VhW9KFwI6eGOuJwxW1ULhdC8YHz
         BAO9C1UQjtg4vVjZ9vhPF4mxrliNMkWT4cDcMMWpJfDyhaJ0U5NaF0km8Ww98Msuenoc
         JSYg==
X-Gm-Message-State: AOJu0YxuzDD8JlTBTEtBKrRsAMCIq3R6pFIgUVNK74AzImMzgfI/UrQs
	Xd9LN0Jg+oJEhaZg+5jA5Kr2R5la1lmqaOUNTb83ZOkSvZPrORIwYRbbhSOT0iO1y7cQhsEb0Es
	bkPKQNnBAMH6Ktt4euF3gjyIOSKg=
X-Google-Smtp-Source: AGHT+IFyPTvffMe5pKsnV87Uu8AODfH4p/n3XF/NT8kQWqIwmyqdgnFlSx3h3NaAYXQ5oY7f5b8ERA3s9l1ulBZ+2EY=
X-Received: by 2002:a05:6871:8a7:b0:21e:3c57:18d4 with SMTP id
 r39-20020a05687108a700b0021e3c5718d4mr6663141oaq.19.1709765659718; Wed, 06
 Mar 2024 14:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306125704.63934-1-donald.hunter@gmail.com>
 <20240306125704.63934-6-donald.hunter@gmail.com> <20240306103114.41a1cfb4@kernel.org>
In-Reply-To: <20240306103114.41a1cfb4@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 6 Mar 2024 22:54:08 +0000
Message-ID: <CAD4GDZwtD7v_zQzeGDu93sropHbRsRANUMJ-MAB1w+CZCMyXuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/5] doc/netlink/specs: Add spec for nlctrl
 netlink family
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Stanislav Fomichev <sdf@google.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 18:31, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  6 Mar 2024 12:57:04 +0000 Donald Hunter wrote:
> > +doc: |
> > +  Genetlink control.
>
> How about:
>
>   genetlink meta-family, exposes information about all
>   genetlink families registered in the kernel (including itself).

Ack. Much better than my lazy boilerplate.

> > +definitions:
> > +  -
> > +    name: op-flags
> > +    type: flags
> > +    enum-name: ''
>
> I've used
>         enum-name:
> i.e. empty value in other places.
> Is using empty string more idiomatic?

I got this when I tried to use an empty value, so I used '' everywhere instead.

jsonschema.exceptions.ValidationError: None is not of type 'string'

Failed validating 'type' in
schema['properties']['attribute-sets']['items']['properties']['enum-name']:
    {'description': 'Name for the enum type of the attribute.',
     'type': 'string'}

On instance['attribute-sets'][1]['enum-name']:
    None

It turns out that the fix for that is a schema change:

--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -169,7 +169,7 @@ properties:
           type: string
         enum-name:
           description: Name for the enum type of the attribute.
-          type: string
+          type: [ string, "null" ]
         doc:
           description: Documentation of the space.
           type: string

I'll respin with a cleaned up nlctrl spec and fixes for the schemas.

> Unnamed enums are kinda special in my mind, because we will use normal
> integer types to store the values in code gen.

Yeah, unfortunately the genetlink uapi uses unnamed enums for everything.

https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/genetlink.h#L40

[...]

> s/_/-/
> The codegen will convert them back

Ack.

> > +    name: ctrl-attrs
> > +    name-prefix: CTRL_ATTR_
>
> also: s/_/-/ and lower case, code-gen will take care of the exact
> formatting.

Ack.

> With those nits:
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
>
> I haven't checked the exact formatting, but off the top of my head
> the contents look good :)

Thx.

