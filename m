Return-Path: <netdev+bounces-82751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABB388F91B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC92A1C233EF
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790323768;
	Thu, 28 Mar 2024 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSfc0UW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0412E78
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612242; cv=none; b=FZdeKq9QhXRuKggz0fFNpR3suVHIsaNfDPCaEx1i5spkPue29j5Lea1LaRCHb96AeaWzdJyMU9+YNqVKD0USQbnmM9VdFAwtgYDHWLiPUGYXHXG/UsMWc3Qg6hAVa8ed1R/JyA4hAIRkTvHuIj+Z0663G7MNp3/8GjB0EOWEI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612242; c=relaxed/simple;
	bh=e4DSPjWVbFWB4McVqFlgpsCxOHKyRjYk4ecnMe6JQB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcrYJMU5whDog3U6/cBXTGP6slRvXfhksX5MJk0BQtfUChRDYEhSQlaiDS9RAnAKVxPMf6KbItJjTp/cGBEIU1z0TU9cmLuxfVOWq/kFU7zL9kFS30VIq+gzoR/ot/XyEuMClQ/nLk/HSYk3FqBYJ6aPpWdumBlgqW4UOmLHYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSfc0UW1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso496564b3a.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612240; x=1712217040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mj4026en4e00Ww7BnqI3u4Dr7QTfH9Xt3XBnhSkhYno=;
        b=cSfc0UW1/vmTx5IjikWJjK+sCeq6SPINHkNOLqu/fX7MIUjN/FHfnMPMTZPRT0BFAK
         ZzDvmFRIPB7c9Zu+1esYvP835I8MFbO+CHgvd8aymnaTYTRMqjTRI/X1MBjOeIP5Scda
         glt1y/F56+XKE1Map2kMhFteiphhG7vO35FukCKENhV7H2UR4oyEEhxR9HhfauRC8YmU
         clYoGp4zddkqAwqiY93ly0MwiKXKR0yUJP9Sbv4exO/lpkdmZ/PgJbTtNfPXgcPRLxu6
         wJwK+yyH4Iz+Uwc3kAY8h0LwvgkYdJeVUcW5zmWL8LXvi6Ixbvn6fNb3vYOga6JL4HQA
         75Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612240; x=1712217040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj4026en4e00Ww7BnqI3u4Dr7QTfH9Xt3XBnhSkhYno=;
        b=vRajy1qKjmAB40sborLLqSAo36MroVHyidEGWJX4XVWcGuvhJzeeFxm173l7DuokQU
         Jki8egih8XL6u4eKe7XFCBju30xSjiBMAuxuFBwCInR2AMlA/Kjbcly+FLkVgW25nUyV
         gjoFNJhqJ3EwTtdJXDdRjuosux+vgJLM+KeEbje847CLm8hFE9rTnOkjoNlZc5b4g3CQ
         adS5Nn9TkGuELdOoz9CokyqfxngCLnkjL1PaqHUaOKKwpey7AuxCY61566k57Y1wyARX
         koRkCW6/uflqXEyOQtcHJcBh+nZuJSJjPgB0G6Dgpd/iY3XzemYccnjr3IlxfSDPoWat
         TmgQ==
X-Gm-Message-State: AOJu0Yz1Sdm1tBtAtbDSSdSjihRbqOs300CUTyxPkes6CJqHNmOWzO43
	fGyfed76qnZzecDvo+neQ8Uhs1tJMPKaZJac+BLkcpfTazKs2qv/
X-Google-Smtp-Source: AGHT+IGq6J1oQ83BMwyrL/pjCWA+OcMKvtn55pwQRu836uPfCJf3zyzNr9j0JB0qr81GWUOYDcYx2w==
X-Received: by 2002:a05:6a00:1484:b0:6e8:a703:d911 with SMTP id v4-20020a056a00148400b006e8a703d911mr2634883pfu.1.1711612240258;
        Thu, 28 Mar 2024 00:50:40 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7810b000000b006ea90941b22sm755149pfi.40.2024.03.28.00.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:50:39 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:50:35 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next 1/2] ynl: rename array-nest to indexed-array
Message-ID: <ZgUhS8_Yno2dAyie@Laptop-X1>
References: <20240326063728.2369353-1-liuhangbin@gmail.com>
 <20240326063728.2369353-2-liuhangbin@gmail.com>
 <20240326204610.1cb1715b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326204610.1cb1715b@kernel.org>

On Tue, Mar 26, 2024 at 08:46:10PM -0700, Jakub Kicinski wrote:
> On Tue, 26 Mar 2024 14:37:27 +0800 Hangbin Liu wrote:
> > diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> > index 5fa7957f6e0f..7239e673a28a 100644
> > --- a/tools/net/ynl/lib/ynl.py
> > +++ b/tools/net/ynl/lib/ynl.py
> > @@ -686,8 +686,9 @@ class YnlFamily(SpecFamily):
> >                  decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
> >                  if 'enum' in attr_spec:
> >                      decoded = self._decode_enum(decoded, attr_spec)
> > -            elif attr_spec["type"] == 'array-nest':
> > -                decoded = self._decode_array_nest(attr, attr_spec)
> > +            elif attr_spec["type"] == 'indexed-array' and 'sub-type' in attr_spec:
> > +                if attr_spec["sub-type"] == 'nest':
> > +                    decoded = self._decode_array_nest(attr, attr_spec)
> 
> We need to make sure somehow cleanly that we treat unknown subtype the
> same we would treat unknown type. In this elif ladder we have:
> 
>             else:
>                 if not self.process_unknown:
>                     raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
> 
> So we should raise an exception if sub-type != nest.

I agree we need raise exception when only support nest sub-type. But
what about after adding other sub-types in patch 2/2. e.g.

	if attr_spec["sub-type"] == 'nest':
		decoded = self._decode_array_nest(attr, attr_spec)
	else:
		decoded = self._decode_index_array(attr, attr_spec)

Should we remove the exception in patch 2?

Thanks
Hangbin

