Return-Path: <netdev+bounces-115461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AD79466AE
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 03:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DEFFB213FF
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0365695;
	Sat,  3 Aug 2024 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv50f3fq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1DAD32;
	Sat,  3 Aug 2024 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722648096; cv=none; b=CmF8zunohyUnKvPW74PZqDEeIvqEs+OD12tLVGFN7lztg5VYQ0bvauHTqL0gGlD+j9JeWx+ytuvontNq8EsadpNrGYcMHwHxkRAcHkBT1sMKpBhhRCEk/oEctDPkTL5WXFiRkXinWyALNAiAsiePtSKD4J5cDau0Po1LAlHPD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722648096; c=relaxed/simple;
	bh=oAUjHZHU7593Kn1TaZZsRWcf0gpNtl99/cZMJoydQ5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnSJCE4d5RefnquS9kWL9yWG2rPEtsLK5H1HjmlUw5zyBIBRDuaLS+pY7ADttPZLcWvp1uLbTeu57AS/tiLOSGn0hwY3QQaAz+W+9bTmVvXoTtbYv943xHlg6fbypwOGcoq3arIAa9W3hp7podHp3FRcL8MUA2TCgNgr2ybWecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv50f3fq; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b79b93a4c9so33308816d6.1;
        Fri, 02 Aug 2024 18:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722648094; x=1723252894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OK8R6WKVvITGMMXb99ClYH53cm1Liy2P3xPdyZF4WzI=;
        b=Mv50f3fqCDKLWNbZo7GC18nBGkxH0UsJ/8WXdRlL4mSvExnniB7qQvW9kVMk/FIUFY
         BFAYOO33d8ijTQPQrlX2Hra3xnyHY2zLB2GFLjhqIv3/o7mcKEP1KDPKQJFAo25aszcd
         YgqwQV/f/NAs8mShh3r8bpAuT5Os/UZyLI/1WTmw3VrPAn67eH6g9DKGKoBQdyRYB0yz
         8vT66NYyUFq5qKsscbKnsMNqiYBe74GOwCrctrOsXCSNOeCchWtgpvEv7IYzoNizy6fm
         mS+S3d6GxBFLLu30ceO+rmnWMFjkH72EUAvmvaRpo66dyC0pdKUI038us8S2oC1SAq8Z
         otQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722648094; x=1723252894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OK8R6WKVvITGMMXb99ClYH53cm1Liy2P3xPdyZF4WzI=;
        b=q2EQF+YGzhffQewxINFkMeybs38ekuF/LCiuFk+kD26UZ5IaTS02zGx9IJCXENvNrd
         gP1Sp4rZQxjd6WLXceIexlRiLmNdzSktthfzulEXzkY9EXDZ1SPxgVCGzLHVw9P9Zk/R
         q425GRLeG4eeZG6pQjJFPbTKSKCf2Yto1vt4vJKhOWw1O6OPCi5cLPloFHp9ESMhUMXs
         25kOvn3rdeMeMojty7/iTzpCMGv/h27NhHR8n6xfdGLxNVM8G4/vSfg+af++r60ntI01
         Nr8V3tf4d5GN5E06ti9tj1JVy0BnLWzw4DviU+0UXYG8rohl26dD7xSwk1LmpEmfIL0/
         EnUw==
X-Forwarded-Encrypted: i=1; AJvYcCUtKYvh3ZAbyOys6qGab9p+/CoonE/uVSLcEqhlmZMUAV2PUXvhkTTUKBfSMSZGif6/pbkRm0ETwkkiRw8ER9MKo7RO+OKQFv/1fLa215PeBcCZ22QPmpCzhfjdVLOmQa0osQ4K
X-Gm-Message-State: AOJu0YyXjxT6+1J5AyTkwAmeVde5z1IOJL0gS6c4Xz6C5B+eJkoqjNM0
	fw07tErrfRDC+5ryMFK1PY8a3rFs8+ldTr1X5JWLS9KmbHciHZYjLfQWIBFbKh9zQPY3Fd2LIPH
	1EwJBGTUVg67CHP3XRQodLxMOPBo=
X-Google-Smtp-Source: AGHT+IEs5qr/1OGdh5f3yXIJWBPZlp17YcBNAy/hBFJjK3i7ugTQ2RpD0VGSnquCh8VGJyegZ4mGkiQ9yDmNI99f6GM=
X-Received: by 2002:a0c:edc7:0:b0:6b5:16f3:94a0 with SMTP id
 6a1803df08f44-6bb91e7433cmr112171576d6.18.1722648093894; Fri, 02 Aug 2024
 18:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802054421.5428-1-yyyynoom@gmail.com> <e792d1b6-b9b5-4e90-801d-ad10893defc1@wanadoo.fr>
In-Reply-To: <e792d1b6-b9b5-4e90-801d-ad10893defc1@wanadoo.fr>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Sat, 3 Aug 2024 10:21:22 +0900
Message-ID: <CAAjsZQz2orPoBS-yRYQcBEv3mzUHrAiyqB-jti5RTyx39HOVjA@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: use ip_hdrlen() instead of bit shift
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: cooldavid@cooldavid.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:35=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> The extra () around "ip_hdrlen(skb)" can be remove.
> Also maybe the ones around "ETH_HLEN + ip_hdrlen(skb)" could also be
> removed.
Okay, I'll send the next patch which the parenthesis are removed!
But... The parenthesis around `ETH_HLEN + ip_hdrlen(skb) +
sizeof(struct udphdr)`
should be retained, because it makes a clear boundary.
>
> >               skb_reset_network_header(skb);
> >               return csum;
> >       }
> > -     skb_set_transport_header(skb,
> > -                     ETH_HLEN + (ip_hdr(skb)->ihl << 2));
> > +     skb_set_transport_header(skb, ETH_HLEN + (ip_hdrlen(skb)));
>
> Same here, the extra () around "ip_hdrlen(skb)" can be remove.
I'll remove it also.
>
> CJ
>
> >       csum =3D udp_hdr(skb)->check;
> >       skb_reset_transport_header(skb);
> >       skb_reset_network_header(skb);
>

Thank you for reviewing ^=EC=98=A4^

