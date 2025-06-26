Return-Path: <netdev+bounces-201664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47283AEA456
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 19:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3821C43C57
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2A42EB5A6;
	Thu, 26 Jun 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEMr6Y1z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFED2FF
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750958450; cv=none; b=KmZp04447YK1fNBDd+zTZ7dXeVgOOUh1Qdvg51JMSX/qH6L2OOtdvy3Gy0/IQw/YH4ht7NUg4qUhGa/jqENvD9Ndp1sjm6q3KICIHsuf7TZ8y/RluO7AWXZIGY6epB923DsqSgObjy00Y7Hxtpc2QjelrKmy/n3DsuSrR9eRejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750958450; c=relaxed/simple;
	bh=aMSAolLfmWeQf0tU1idUK3AOhEygcdOkzBtnIUB+7Pw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NYublNJ7H4gsWj5c/OJq3twKIeL4eq9kaZGPuXjGEWMlV0aX7EdWt0NDsiA794tVbstZ0+P++wx9nm0c9JBiPytjBACdcYQpk4qwx0KUf8All7AfHA2c08geN5+rIepofvOKkAUMQvhi4v5mLknRZeDohNmB8J3YUrwTdc7rOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEMr6Y1z; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e447507a0so10695607b3.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750958448; x=1751563248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbc6WyUDBXxauCbeW/8qnN2McIIsEk11veYxZxgBjmg=;
        b=XEMr6Y1z5TmuOIFXtKktbPE3D2eeCVdlGANCUZ17w2MyYI/pYl9b8AWOKW7qWgKXEq
         eqNWVucw9sQxyxsC1wg+CQnmZ6Sl54CqXBnzBpi0FOR6Hs/MlmeYYQpiCjzg0MLl99uQ
         QEuFrQ+exwW+TR5R/G3TKI0R66x/dO6eB/RJ8kaNBT2MsRSmfotzNbE2+OHMcnIDFxnt
         jsh0214k1C9/cciYFz2Xfacd9bfjtEn3mqnoosS1j1ChTYjmYF2jKoD51RaP8uuKNuaH
         A6VrjlEFbs/SpbEwySjMCiqmo3i+8InpPDSUHNvFnIuBvZTR4+NyW1s7xFaZxJfl1P2J
         ARKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750958448; x=1751563248;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fbc6WyUDBXxauCbeW/8qnN2McIIsEk11veYxZxgBjmg=;
        b=R06343ssIBlxm5PQRRgi7zsxrK7bYe2pytFAq+GWBWWrnTrRUVUfIA7N2QikKfIXKf
         sIGx8AFKPpi8rhuBnTYamTH1bnlhRBQEIA0VVI727ot5TykqXhNNBsYvpKaTgqFj724C
         tEykQCoI+CBfGbYcwDBmwK5/s/HLwvp7r35Xg/QNaE4gWDd1q7OrcT97oWiiTYe5V/AK
         ajTE9jDQnw2yP4a1/T1IogaIMeqlhvRoyyt0GWWpSQyMQBJlCTcETeHjcxfAlCoiV3wW
         5HXVQhizb4GSoGWESsKQSaUnlcCr/y1RY3/J/fjJxJpcwjNNnstSW9lfy7a7Cn1mjkoD
         kiuA==
X-Forwarded-Encrypted: i=1; AJvYcCWBvZUK7CTLAZF7+wtDPkT6LrD6mzKTbIRVpUnMvp13qPiz4RVDKKIvsqrkafBHkIl4B7PBjRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzO0pm5329ES5L15wZmBoDMvEpVpxMr5LLP7xIYoZuc99M42js
	UU9yUpGNIg7YQ8uBRrxenky1/ld8R+3Nc+Zy8zxf7lqsVQMZXocK9sja
X-Gm-Gg: ASbGncueqO98+2gpf/YlHwfaxNZRgf0is5/IZJCp8XSBBGwb0NI52dyGelb3q2waX5B
	+00qjjeKn3Mxjo9ZG6WhbPmlrJOmGY0ufHZfL3M0N1E1AkEi6oFMIlCHnsZId4sWN84D0wkTQYk
	djluNIWFJfg94E/WbcB2uvQqa9uKJv77Y4/MjCdGV3GtTIqumpu1nFSMj9hDbUdH+NBd+wYDz2c
	13fnYCIy2huPzppp55L0l5O7xvYLKPDgCGH/UmoYnFG9ck1Jg+KuRjgXkFIugwhMpwY7R5BuRj8
	rssNToL7OrfqbNc/cLIJKtdRmffAffy6CLbj6GhqmCyemaLt+BROLGrbam5JD4cvc8fQb/jTamb
	/nn6iN1rRBDMkwaYsoIYQOEhJXa08u4CI1GG5b9v/eA==
X-Google-Smtp-Source: AGHT+IHTC2DvDwzOK0OxjXWn+juj6WUDyg1I+IPCQxdJDbY8QK96lUSNKuTD9MjRUk1yKB1AceDeNg==
X-Received: by 2002:a05:690c:14:b0:70c:d256:e7fc with SMTP id 00721157ae682-7151718531fmr213097b3.21.1750958447719;
        Thu, 26 Jun 2025 10:20:47 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515cb4d57sm708807b3.89.2025.06.26.10.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 10:20:46 -0700 (PDT)
Date: Thu, 26 Jun 2025 13:20:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685d816dd20ff_2eacd529452@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250626081156.475c14d2@kernel.org>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-3-daniel.zahka@gmail.com>
 <685c8c553072b_2a5da429429@willemb.c.googlers.com.notmuch>
 <20250626070047.6567609c@kernel.org>
 <685d5847a57d7_2de3952949b@willemb.c.googlers.com.notmuch>
 <20250626081156.475c14d2@kernel.org>
Subject: Re: [PATCH v2 02/17] psp: base PSP device support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 26 Jun 2025 10:25:11 -0400 Willem de Bruijn wrote:
> > Preferable over the following?
> > 
> > 	struct psphdr {
> > 		u8      nexthdr;
> > 		u8      hdrlen;
> > 		u8      crypt_offset;
> > 
> > 		u8      sample:1;
> > 		u8      drop:1;
> > 		u8	version:4;
> > 		u8	vc_present:1;
> > 		u8	reserved:1;
> > 
> > 		__be32  spi;
> > 		__be64  iv;
> > 		__be64  vc[]; /* optional */
> > 	};
> > 
> > I suppose that has an endianness issue requiring
> > variants with __LITTLE_ENDIAN_BITFIELD and
> > __BIG_ENDIAN_BITFIELD.
> 
> Right, this part. Always gives me pause :(
> 
> > > > This makes sense with a single physical device plus optional virtual
> > > > (vlan, bonding, ..) devices.
> > > > 
> > > > It may also be possible for a single physical device (with single
> > > > device key) to present multiple PFs and/or VFs. In that case, will
> > > > there be multiple struct psp_dev, or will one PF be the "main".  
> > > 
> > > AFAIU we have no ability to represent multi-PCIe function devices 
> > > in the kernel model today. So realistically I think psp_dev per
> > > function and then propagate the rotation events.  
> > 
> > IDPF does support multiple "vports" (num_alloc_vports), and with that
> > struct net_device, from a single BDF.
> 
> Upstream? If yes then I'm very bad at reviewing code :D

I then don't think I want to focus your attention on this, but..

See use num_alloc_ports in idpf_init_task. Which keeps requeueing
itself until num_default_vports is reached. Which is a variable
received from the device in VIRTCHNL2_OP_GET_CAPS.

