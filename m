Return-Path: <netdev+bounces-129915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD31986FD1
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D3B1F23CC5
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D89F192B91;
	Thu, 26 Sep 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDy9k9+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CB13BC11
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342276; cv=none; b=L4zXT4/uW8Zy7oG0t7LcBJpOkh1eQgI2OYdHzpZcRncvbds3SuhvXuLE3dv5BiD/0n5wELP8Idyw24lKWIz4V4fYc7Ey/zwdRgLB0Gn5phOfM+X0ORDvt7Xa5JQB8CLtWO8CRWGGwse+HgyTAyueBk/BbA7WzLtk4OvHuXLnbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342276; c=relaxed/simple;
	bh=APoGCwI1ijsveaYeCbbkZyKzvH8F6xI/BZYnzZMOyP0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T2msbhKL3S2H5eaqBozmBCWDKWRN9ccq1Fmh5nMIGE5V/41H9W0+cQ/p9NqIBOvb+XZ26pZXt0lmF74yezvZp1LR3qcJUJqEIeMlGK3UzR/SBh+oFYcvgWMrULzGHF2q0xxebI7XMgwRZSiYlP7fNHuBn8McuFkheJRGG/Pm2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDy9k9+6; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb2d2a7d48so5089166d6.3
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727342273; x=1727947073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqVpda1Hn5Vmj1CfkV/Bm1IACJrSf6jpUj+jmmqfYSk=;
        b=BDy9k9+6HNP1BxNIoAt4bxxop0prV+ACgckPyTUcoZ4EwzcZGHETeBIe3c0eeGqnoB
         syQuTuNMRiqj2AZ0m1sAqC+cc9wMffukIUqjeEQzEF4ruJ45k33h45XvkMDb9rYK7Xo1
         N+Aqt9Eb6Wg2Fo2TbpAem/Yv0XImO9ZI3NeoeEUhoqo2vPrDQYWu4oxgVf+a9/PkXivU
         UAHoT4g3kExAzc2+waqrdRK2UgMMXCC5vjIaiQEpukdjYqo1rjozbNG7B/QYpUjx2nUK
         Sj6VB1sLyrV1yCQrcEaH0dm2rJzQhmRkBRv1k04Ua342mydD8zClAkiBQPprtyvYnQee
         044g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342273; x=1727947073;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqVpda1Hn5Vmj1CfkV/Bm1IACJrSf6jpUj+jmmqfYSk=;
        b=fvvxn8loN269rmjXKEREwLqTIJaxbDYm6woT6hmSJqO0Fwg1cXSUMnTNF34AhSjIbZ
         B2yMMaz41fiFv7+LsBSEfpLLTrUjZ2DoeWQsLXkLEH/3ZBUKdtOtfraU/SIndE25BDlp
         Eil3cb+OZe9GmPjiupA2uI/dVqLyw8roxdZUGAcuev0GvVNu3rWE72j88xGZCRJfvq6h
         gnD47er88H3HZbEXk2+fBp8o1oHf5jVT6wjEu7LXN58dy6zlbCZyoO0D8kgB6sQ5S/41
         0ppUe8yqq9ct/XR9e2bqPcCEzHE1gWUzx5FJxtug8BX53NVmUMtVOieq91nK97sgkTqa
         BweQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDsOfsIcZ8FvdIdN9VmFgTE0BkaSo0hg6FqBT44W/LP3qn8mdCpeTUgturVIkAm3tc62wCB/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjjc3b10/xR5s2iQTYkc82MUiF1+pW4q+AIeJ3jHuFpRLvCpbS
	zsIf9OR4sAmi+mhTy0PP+6B61s6I3LPVSrK9YO91CIlbH5CL5v2k
X-Google-Smtp-Source: AGHT+IGYRFprjwr/3w32gD593j43CNzVFLxvv09WdU9jgZ7NDLuAM8Wk7xPfq72cQPvKmjawzu8uag==
X-Received: by 2002:a05:6214:5992:b0:6c3:5496:3e06 with SMTP id 6a1803df08f44-6cb1dd1856bmr91029416d6.10.1727342273360;
        Thu, 26 Sep 2024 02:17:53 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb31882c44sm4745756d6.138.2024.09.26.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:17:52 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:17:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Jonathan Davies <jonathan.davies@nutanix.com>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66f526c06b0fa_851bd294af@willemb.c.googlers.com.notmuch>
In-Reply-To: <66f525aab17bb_8456129490@willemb.c.googlers.com.notmuch>
References: <20240924150257.1059524-1-edumazet@google.com>
 <20240924150257.1059524-3-edumazet@google.com>
 <66f525aab17bb_8456129490@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net 2/2] net: add more sanity checks to
 qdisc_pkt_len_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Eric Dumazet wrote:
> > One path takes care of SKB_GSO_DODGY, assuming
> > skb->len is bigger than hdr_len.
> > 
> > virtio_net_hdr_to_skb() does not fully dissect TCP headers,
> > it only make sure it is at least 20 bytes.
> > 
> > It is possible for an user to provide a malicious 'GSO' packet,
> > total length of 80 bytes.
> > 
> > - 20 bytes of IPv4 header
> > - 60 bytes TCP header
> > - a small gso_size like 8
> > 
> > virtio_net_hdr_to_skb() would declare this packet as a normal
> > GSO packet, because it would see 40 bytes of payload,
> > bigger than gso_size.
> > 
> > We need to make detect this case to not underflow
> > qdisc_skb_cb(skb)->pkt_len.
> > 
> > Fixes: 1def9238d4aa ("net_sched: more precise pkt_len computation")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/core/dev.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f2c47da79f17d5ebe6b334b63d66c84c84c519fc..35b8bcfb209bd274c81380eaf6e445641306b018 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3766,10 +3766,14 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
> >  				hdr_len += sizeof(struct udphdr);
> >  		}
> >  
> > -		if (shinfo->gso_type & SKB_GSO_DODGY)
> > -			gso_segs = DIV_ROUND_UP(skb->len - hdr_len,
> > -						shinfo->gso_size);
> > +		if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
> > +			int payload = skb->len - hdr_len;
> >  
> > +			/* Malicious packet. */
> > +			if (payload <= 0)
> > +				return;
> > +			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
> > +		}
> 
> Especially for a malicious packet, should gso_segs be reinitialized to
> a sane value? As sane as feasible when other fields cannot be fully
> trusted..

Never mind. I guess the best thing we can do is to leave pkt_len as
skb->len, indeed.

Reviewed-by: Willem de Bruijn <willemb@google.com>

> >  		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
> >  	}
> >  }
> > -- 
> > 2.46.0.792.g87dc391469-goog
> > 
> 
> 



