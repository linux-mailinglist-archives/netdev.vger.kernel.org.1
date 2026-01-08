Return-Path: <netdev+bounces-248189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F7D04FBF
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36DA833A813F
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC642E7F3A;
	Thu,  8 Jan 2026 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRW1BX6J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E92DC792
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891514; cv=none; b=BRnGL4CnVBZo0h/e/Z3fcJip9ijG5HP4XlyBVJCirRTKuETgAwGht9unlvIlVJZeSpCrQTS0VUx67LD/0dh8XBCCWg2ZKDEmeT+m+yyYA7YeaS+froeTqe54jK3UoZNgxqaJClJ767d2Jqfx1w3J4mlmjkJAr2m3jKNVQ1rlvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891514; c=relaxed/simple;
	bh=MVTzGXbScex35TzesGDsimq24WTvc4nqhQnvv4OBy3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxT0SmRRLCUxxSQiJwEvCY2zqvgfaOyOIb2cfEIayzjAndf5Va7H0pVKxA+RkzJTa6Hb48h2qwFKU/SJA/1RWQnysKO6pSm61uu31mOQxtttS6DN0NiaBrxquIy5olFwi+T8sxZN++NB/vGc9l4o8FAXz46xOKCh7pxq6K7TggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRW1BX6J; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc0d7255434so1632716a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767891511; x=1768496311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIpmw3TbxuFac2rr3Ral/5NrCqmxWN0HTMSbOEZp4Sw=;
        b=DRW1BX6JIl5KubVDEoi/bLzYViOSOuIQB0Vqt8HDE5tY6ut+XRnck3d83XoYziHEWu
         vsnFlKF8tnjlsR4iMiiQ5Yly3nkCI4NmBeDGHtVL7JEqU6WPBrkV8t1uPK64vvsQB38V
         +D4Jon6ClRLavjf9AUDqo2bC1/BkRljIVizM16sKo7IG53+6kGsSZ7v7bjLfr7wimtTO
         d/gnZfOU0cY+RYznJS7mMDVJuecDDyTZkRMoSQLzCMC9D+LF3xHIz8NQNfD8o6CebUif
         tG1LvV5GlCHid6lIoWV5Rkz2oJs4XDQ87n+NWzwl0nOCFha1gtWniaV0MT/uhZDGvrA8
         BhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891511; x=1768496311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIpmw3TbxuFac2rr3Ral/5NrCqmxWN0HTMSbOEZp4Sw=;
        b=OcLvhjMYZRGpBObOsCDXlldafUgI/NJGq0jNuqr9Wy/FcRlv8b8zugJHyC8e+CDMuc
         lw37obuhmn6lo+QPx2CyA3SDwrhfalPne+AzlZyx255uE10IkmZqfi0+Yv7EHyB+gQKF
         eTTgEOGpW5Ga4qS0cbrhxeT6hHOZptbmce0PAYsZvnXsqutcPsQPs5g3YhjnWKQtPv7t
         Ao9uB4a7MkkLi3zEJdJGlIhPEOgsBaLL3sPrze0DzlaQKpk/Yj9S1YdA7D+zk6pCagKr
         j7GkarH4rODtgDqxdtgk8aJhrepPy4xsYE8jWajnsiSnhp/lQIz2ha4KgtPzdcKhI4Fa
         wfjg==
X-Gm-Message-State: AOJu0YxJb6hhuGw53HynZgCtGMHIHdHNdlzWHSlLt5RwIZSnRQte7hXu
	0VbVtBe+HRqXtXHvdxgjR7rqIqmqRWKqwhXDBM3P6qTpvp5DOpaa5HXtlcfTDiFCc/JRwEy5i3P
	r/h/UjrLnyksuTNUIxL/B7LQomLQipvg=
X-Gm-Gg: AY/fxX58Q7Eq/fNAqEWQ343/nJyYJ3lxNPEhc8OFQWyZttBw5KbmOPG06TiLezj1uMH
	lzYcZwI8C2xx8kICsxPq3ykxfKZ6yfa8hvL+3fFv3lNjpCo0XlvKRB5DxOk716CiRl2030sSsS/
	uQusmlHuGIEz8MfjQYuDeGVl1dEK6cU6Sv21+nczsF0KbmK+UmpK5pBPYyOcPjZNnATGUyg+r4d
	9VPSgD/PspY6+i9QJB/RiuYAuLm2aEZSZ+jnozWzgiqqzo16vGu3G2nCIiAeiSlzLr4le0FY+gH
	pzCob2Tf4OtUYI7f3/lfIzuvCEAY
X-Google-Smtp-Source: AGHT+IHULotT7XFOA4hDBTUJBhfsHPefC4PlHzU1kuHvxYpkrgCp4pB0H1Sx2VpJWUGOCosSRzEF1Th10/Eb/PAqOAk=
X-Received: by 2002:a17:903:1a6f:b0:2a3:ee53:d201 with SMTP id
 d9443c01a7336-2a3ee53d218mr72769795ad.12.1767891510843; Thu, 08 Jan 2026
 08:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767621882.git.lucien.xin@gmail.com> <f891d87f585b028c2994b4f57712504e6c39b1b5.1767621882.git.lucien.xin@gmail.com>
 <6c8a1f56-16ed-482f-a9a8-ac840a7aebd3@redhat.com>
In-Reply-To: <6c8a1f56-16ed-482f-a9a8-ac840a7aebd3@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Jan 2026 11:58:18 -0500
X-Gm-Features: AQt7F2r2eahRmpC-isaCgnTPZ3EtB5uQT5Ead8hHYSoe5kUDYAgbUFOe0Uminug
Message-ID: <CADvbK_d_3cF63zM6cJv0Oc5XB7ntaZozzbu4K+xmM2jaS7Jshg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 03/16] quic: provide common utilities and data structures
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:45=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/5/26 3:04 PM, Xin Long wrote:
> > +/* Check whether 'd2' is equal to any element inside the list 'd1'.
> > + *
> > + * 'd1' is assumed to be a sequence of length-prefixed elements. Each =
element
> > + * is compared to 'd2' using 'quic_data_cmp()'.
> > + *
> > + * Returns 1 if a match is found, 0 otherwise.
> > + */
> > +int quic_data_has(struct quic_data *d1, struct quic_data *d2)
> > +{
> > +     struct quic_data d;
> > +     u64 length;
> > +     u32 len;
> > +     u8 *p;
> > +
> > +     for (p =3D d1->data, len =3D d1->len; len; len -=3D length, p +=
=3D length) {
> > +             quic_get_int(&p, &len, &length, 1);
> > +             quic_data(&d, p, length);
> > +             if (!quic_data_cmp(&d, d2))
> > +                     return 1;
>
> AI review found something likely relevant here:
>
> """
> Can this cause an integer underflow?  When 'length' (read from the data)
> is greater than the remaining 'len', the subtraction 'len -=3D length' wi=
ll
> wrap the u32 to a very large value, causing out-of-bounds memory access.
>
> Compare with quic_data_to_string() which validates: 'len < length'.
>
> The same issue exists in quic_data_match() below.
> """
AI seems right. I will change it to:

                if (!quic_get_int(&p, &len, &length, 1) || len < length)
                        return 0;

Thanks.

