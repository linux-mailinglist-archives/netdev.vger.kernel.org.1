Return-Path: <netdev+bounces-231037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB32BF4233
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC4E1346F27
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDFD1D516C;
	Tue, 21 Oct 2025 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDWeEZLk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FD1D5ABF
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761006104; cv=none; b=cVq+tvtrmQJB/4s4K8O4PbAh0si++9Q/dkWTccvgRecY2Zop9QdnkE6ndAJZbEBH0sDmKFkvVLc7xnr9XlIpwjSIeg/NuivMnh4LrKxhNeAgwtcp5JrBQWcDfJYkogHgKI6nxtMl6w1VMYgHiqEVDCN31IeoClKN60WdD6FLodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761006104; c=relaxed/simple;
	bh=yjHPLVgEdW5sJWrbNXJ3MIoDYB+QxWa40YMfzuMRRyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8Sjvu1kv+N7Y6Vmb+C2DeRRDgPNu7PW2GaRR52s9YyHkp9hjySgVbx8n24wN5azA1QVBnOd2IXGz1RJbC2PYMtkIahBqnyYiTWxJBrivWiNfrGECnKQMXkM6kBso4YWRyxXxbtjIv3tNlSNkoi795jUE45pvbma3HnWDLHS5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDWeEZLk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7810289cd4bso4763587b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761006102; x=1761610902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjHPLVgEdW5sJWrbNXJ3MIoDYB+QxWa40YMfzuMRRyA=;
        b=BDWeEZLkSVwrdkmTnB91g6L1OqHF2LRA2AkMW0JV1/t0JTYUj5gsF/tLeKeKn57zAf
         njFHX/hr6Ugh2dJkHDfs3oELaH/w3K/RMD7LCFGgd6WVSU19QaoTHUUSIEka2k6Az1cG
         H1sV6LQ/mf6QKbHQxGKPqyLs66BS/doVGya0w0BE2I3kXP36Zv57imLE29copPk/BPnO
         0VPA+YjiMJClAsKCeczgjVadZ7kpVVxeoKhQiC4D24Uxckp9xRHNOvnezU+h9IW5jD1X
         YnJ0jI8qIucmQ9+ZhBQ3STD8JrEeuoODg2Ytnrt8wKYXck9gI8EpurDrFGWNbFoQ62a7
         cd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761006102; x=1761610902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjHPLVgEdW5sJWrbNXJ3MIoDYB+QxWa40YMfzuMRRyA=;
        b=Zn35jeplRC/SUAnzqvZk7xAS9a6qDrlfVa60skGFcyghML36LGIstoXvnb5SE1kprA
         geDBF1m5pyqsM4qRs4zrrOzkSFtVCDMBS2zgHzEf8jPLoxaQcYMTsshruX+tctZcCwNs
         FFIUcPrXqkE1mI+a3ICpu01j3rCtgG4w+JrXGuSujcOCtKe1fh0mBxrg5YfL/ca1sbFU
         SbYID/gGAKQdv6Nal9/nTi6wzYsXXV8hm3InGvljHLoNSKwbveoQoR5SzwyMAESfBVsh
         ImLWfUIqBKtaHyE3bRA4iy9JFOnMY4Vl5/IlZjGGxmYz8b3atVYPknj4Yy/MkXF/j+AC
         EXmg==
X-Forwarded-Encrypted: i=1; AJvYcCUmwdZAQWxiVZiRWvGsxnawRDR2yK5qaT0uvJYegf05QVJ02GTfUN0kaejagLhMnLpT69h3tTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbRM7QghWcbW/ABvbjTUJONjEtvEWY9IvkfmkM12Y1awT+npbW
	zImlz8otVJo4uFGin7Ss8OxEdwaqFvF93GmEC+z51nNuJ7sTmbx3M7YP
X-Gm-Gg: ASbGncvKpgWjC+76nLVX9zDgmeRPDJ3m9rDaTdMDbtqwZ/R2NElr2C7mCVh6my8GrmR
	3YCCI/D6ZvXMMdFLi49JLAYVzpLLKthCmpsWMCTgOxSayU7hsYr6V4tulqDdyLM9BVq/a0W0Thq
	qmvdNggzoztA5y9tCtyxOfIsdCo0nAXu0qiZDpEDGcIo8+zUnLmFW3HQ6gLfmJXhYWFFW9wUk5n
	7I4DIsASw5yDvO2LyEjUNB9q38gLKOGYt3JghCyScMAGqo2cvmxFRZOQb/EzD6bcxfdt7OM9Pqr
	KOE9zLo9hlRXGfjLs6T3DC36fYaSsDep43uJ/cnOGo6TOWokqWHyU/VWn2ruJIQMRHi5fQQg9Pj
	B2yAQYusRIEiV5OeOvaXznWKJkdFuuOb2xnXe1lMRG9yBeSmAg155GP/ZlI3h0JMV116G3QoOMT
	9dpqU=
X-Google-Smtp-Source: AGHT+IGbji5PS2wR9+wnyLjXP7fZ55l75L4OjmPE1c9z6DFc+64aTfHdBaYLcLRVmf1fSi0fYoMixA==
X-Received: by 2002:a05:6a21:7914:b0:334:bec2:5b63 with SMTP id adf61e73a8af0-334bec25e36mr9854338637.24.1761006101915;
        Mon, 20 Oct 2025 17:21:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f251fsm9453888b3a.39.2025.10.20.17.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:21:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 676F2412B0A6; Tue, 21 Oct 2025 07:21:38 +0700 (WIB)
Date: Tue, 21 Oct 2025 07:21:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] net: rmnet: Use section heading for packet
 format subsections
Message-ID: <aPbSErGuC_FZPCvf@archie.me>
References: <20251016092552.27053-1-bagasdotme@gmail.com>
 <20251020171629.0c2c5f5e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LjzbLi24OC08S6O0"
Content-Disposition: inline
In-Reply-To: <20251020171629.0c2c5f5e@kernel.org>


--LjzbLi24OC08S6O0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 05:16:29PM -0700, Jakub Kicinski wrote:
> On Thu, 16 Oct 2025 16:25:52 +0700 Bagas Sanjaya wrote:
> > -a. MAP packet v1 (data / control)
> > +A. MAP packet v1 (data / control)
> > +---------------------------------
>=20
> Why capitalize the "A" here? it could have stayed the way it was, IMO
> lowercase is actually more common and (at least my) Sphinx doesn't seem
> to detect this leading letter as in any way special.

I follow Simon's suggestion in packet formatting patch [1].

Thanks.

[1]: https://lore.kernel.org/linux-doc/aO_MefPIlQQrCU3j@horms.kernel.org/

--=20
An old man doll... just what I always wanted! - Clara

--LjzbLi24OC08S6O0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPbSEgAKCRD2uYlJVVFO
oz1JAP92OJiXU9/4Buy/9Zrw/pTqhdMb4tVYDi+526Un+p3DxgEA7ksgvqYHKaNm
qY32OXGc7Yp4NPYMuQ7KKxncy36TdwE=
=Utyd
-----END PGP SIGNATURE-----

--LjzbLi24OC08S6O0--

