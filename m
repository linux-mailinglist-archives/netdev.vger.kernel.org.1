Return-Path: <netdev+bounces-84250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CA689627F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 04:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB80284099
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8DF17BAB;
	Wed,  3 Apr 2024 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7XIwnIB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AB11190
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111321; cv=none; b=JxaqVRWM05BkREGHAUJqrvdV2rMO//Bctay3ivNfQecxVbkhes3Afo3wc6aPitcOGbc0OQpg0s8TZYJ0/bF6JsFfy61Er4HK6enLuVZzDspSTHbm8+EaR6CuBFHQsd4VgTgj90xkTWhhVbob7U4cfryEotgvxw3oz8PKMAZ2DqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111321; c=relaxed/simple;
	bh=pOWyvHymI7Wm1cHRXmrRTTRUlBYlbbkYT1qxFkSDcJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkudJ7/ELPmGXSyUB9o6nk4P8snk63Kxw/5F9UM99CBbXtrBRS2Zlcj1CO4kahU11Iiwsl2KOZiD+8QWbRDtUm47kIu1DDKfk1pkHfzP966foWB5xSOOZKNoPs+jAdo7JJAu15Bk50xC64Zxx//Ewdw0AfpXsx7x4fJMPz7Tnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7XIwnIB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1def89f0cfdso3870625ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 19:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712111319; x=1712716119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXqTST8P3P4he2JiSYzy69a8adKLu+fIQTZvhmCWAS0=;
        b=C7XIwnIBVZVy0l0+EkF6yNjvVI+3wAlcpRgiKvNV4CaCK1ohV6ya6paq29Ul6fH9hR
         Chk7stOSTIoGtQr3tD1r2shFG/UPsq+/dwRDWB12DkJcAH0SCH9BNOoI577ScHElTYiL
         pjaXJEWafUHXsQ0xlo9dQOELrMgjLP2jGMYQq+39IvcTnn1jzHT5SkeLMOrRyYfmitV2
         YaKuRrPXGMNSefUQ8Utg48jh+skNuAusmmGYdCNWgTAi08IjLOzn4iYB1Q6ZzWFp5MHQ
         O1kZoqwMbaaCjgumkzqRC9+EBJ2P3uB+oJ9Vfvg86TsmL0886e4pZLFd1MVx6H0xb8gP
         iEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712111319; x=1712716119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXqTST8P3P4he2JiSYzy69a8adKLu+fIQTZvhmCWAS0=;
        b=lknu9W4yEj5rhqmlSXk/FPafdcEWZTJOGjANNtqsVAtvrzqRt3FVKWf+La/TRatJ9T
         4kXbDtIrCVtXcKXu82DVeYPmva2Dr03jfkKkTlWf2NNtZMsVVK74PnVAyVQ6ocYqvOLq
         WeYD4/SUv+k74i9kduIVL5NaS4aZeiXK7DC8x0eSn4/AzX06lEo1h8bxJL7oSC9fRe7D
         T55JWzv7WGjVAFIqrCwVu5yxkUyMruul6hxFas9TxRn+eaRIsfVSNfpoz1GQtB1QU+TB
         8TmCykcMdL8SgD4hkGHWi2seROUdGgun/8V6HA7a0ElEKpmjuWLDPviyspgee1o7Ma50
         aykQ==
X-Gm-Message-State: AOJu0YwbgioOexam3OpXGz0BxQWjjhVUw9xqjqhLNS9QmUiqgGJhRpm9
	jXQE+2fZJZTnKMODjqGeFFza3HFxJzPvgnCp/8dUcEB+vZM2gJ6v
X-Google-Smtp-Source: AGHT+IGlHxCQ+NgAnWt/4KnvUZgMOv7O5RfrsEhv45ApWgna6Kzi8Fd07lS3uoYgAUKhFZyPn4GayQ==
X-Received: by 2002:a17:903:22c1:b0:1e0:b60f:5de3 with SMTP id y1-20020a17090322c100b001e0b60f5de3mr1844209plg.7.1712111319188;
        Tue, 02 Apr 2024 19:28:39 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902a5c200b001dda608484asm11877912plq.57.2024.04.02.19.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 19:28:38 -0700 (PDT)
Date: Wed, 3 Apr 2024 10:28:34 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/2] ynl: support binary/u32 sub-type for
 indexed-array
Message-ID: <Zgy-0vYLeaY-lMnR@Laptop-X1>
References: <20240401035651.1251874-1-liuhangbin@gmail.com>
 <20240401035651.1251874-3-liuhangbin@gmail.com>
 <20240401214331.149e0437@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401214331.149e0437@kernel.org>

On Mon, Apr 01, 2024 at 09:43:31PM -0700, Jakub Kicinski wrote:
> I think that elsewhere in the doc we use [SOMETHING] to mean
> TLV of type SOMETHING, here MEMBER1/2 are presumably just
> payloads of each ENTRY? Maybe this is better:
> 
>   [SOME-OTHER-ATTR]
>   [ARRAY-ATTR]
>     [ENTRY u32]
>     [ENTRY u32]
> 

Thanks, I will update the doc.
> ?
> 
> >  type-value
> >  ~~~~~~~~~~
> > diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> > index e5ad415905c7..aa7077cffe74 100644
> > --- a/tools/net/ynl/lib/ynl.py
> > +++ b/tools/net/ynl/lib/ynl.py
> > @@ -640,6 +640,11 @@ class YnlFamily(SpecFamily):
> >              if attr_spec["sub-type"] == 'nest':
> >                  subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
> >                  decoded.append({ item.type: subattrs })
> > +            elif attr_spec["sub-type"] == 'binary' or attr_spec["sub-type"] == 'u32':
> > +                subattrs = item.as_bin()
> 
> Are you sure that as_bin() will work for all u32s?
> Or just when there's a hint...

I didn't check other subsystem. For bonding only, if we don't have the hint.
e.g.

  -
    name: arp-ip-target
    type: indexed-array
    sub-type: u32

The result will looks like:

    "arp-ip-target": [
      "c0a80101",
      "c0a80102"
    ],

Which looks good to me. Do you have other suggestion?

Thanks
Hangbin

