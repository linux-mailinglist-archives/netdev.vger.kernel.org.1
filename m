Return-Path: <netdev+bounces-202622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C778AEE5E6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4002217E779
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064928F95F;
	Mon, 30 Jun 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbQuXh/C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9348BF8;
	Mon, 30 Jun 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304824; cv=none; b=ejSnvdAc3v6qP6BQJY5u+OUpPEBMU+e4HBmN3c2gVJhuUQAly+IcTrbn2fuHuypTfhxPL/66CWV4cKAmAn4wiNf9Yw2Ivu/eR605glUwaOnf0PWmgNngv/EKNzLUm9A9BR5Ul/aPwwhO2WRm3wGqlqbwWGz9oCBxR+pWBPRY1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304824; c=relaxed/simple;
	bh=kJ5bREYguj3nAd9Wz5lWj+IXItcoVGjyv8NbLSrd7Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W//G3fstwsLfGI25eySu5YaQ0ELT22ryLB+cAHGCGBzEr2Oaj4cc5CyUQl6idDU9FwEqDJh64E/MAgmi8X5VXLbEukieRXkIBdcUvyljQqtPzJdrqnQBx0aNDIg1xb/Y3JupprHVZRY98/BV+1x+kCF43glrJSZDsASVKI9xh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbQuXh/C; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso1238335a91.1;
        Mon, 30 Jun 2025 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751304821; x=1751909621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbxVGgcvP6OMrt/mkiJLM3OwkDNoJLobRkyzsMgrhcs=;
        b=BbQuXh/C/k4/pebJ4q5WQrE4YLST9Sd2TdvMQLLjyMAZ+IKM/YWJ/YWNObS1CAVtb2
         aFWjQpTDYxkRkbaf1VBoOOGDnl24EP4gcnzGvspkFsWqvtDI/6qcqbikQWYkeYQJZK/0
         xBlXcf9hjW+ypEdofNhGz1SHDl+Z6pkpoPFx+7DH35bfN+WBNO0GcNZt4ODwIKgCSfy+
         ub94fE1egMW0GUkCz23czFf0c9EoT/Ex1D/vVevrli/nekH4oVQ6clzuXnhNcouMDD7+
         2miwWnOACr6KIK9pu77ZBojyyS7bpNxBk4BF+BPBTUTgeV2oi/2cIfCoB/U3wrknLgSh
         cGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304821; x=1751909621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbxVGgcvP6OMrt/mkiJLM3OwkDNoJLobRkyzsMgrhcs=;
        b=oKHQUSoFyq8OhcPwNPkNcMFRPiScCgSbUSSEeFMOMSQ1+elugx1j2B14LskHV4u+8p
         EahYiPICGK0pypqsWv6oDCLtQzBjMXfULsgfei4mFnI0/AhhBTQmQ+nWJevP+FFa6Xag
         fkq6c0UTZgllZqxBCTu0S4gf2qo08uSwklItBmbN4vTFyqj55+5nRcYtsv1VOKIuvhaj
         0qrj/mFuhod5XH4oL0GLsFcf0J1H4N3jMZmEla1t/ZUDgAhp/NOr5Q1zVy6jzleeu7Bx
         85OT1BVQZnX4gDnXfqLSVxEKRiJ4oo9iXmeScEubAVR1AcC5TC4dcuYZ1MvtAKM1YaAp
         XWoA==
X-Forwarded-Encrypted: i=1; AJvYcCUwMDrQNyew1x9aZJQMCLI4kw2/YudDzlaZMfAwh1lWule7nqSGwCuSemy8C6RPPZQUE33wCcZ0qiZ6Pq8=@vger.kernel.org, AJvYcCWhsie3JjItjbeX9ySn+QaC2zX64ReKwC6v1qJFBVANJomG1nmBiiqYc8Xm50voQoNSSTpcLETi@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEBdsY6UqQ6ViOv4Z2Ev6x3fieCsvxb0N6KLp1ts1SfzcA8Nw
	gZXSjzVj9YcGyYkkspdxo2n2UISvhnHBAPJB4WGbM/sqU+2SVIsaIXKB
X-Gm-Gg: ASbGncu1N2IaRsjOccU76QDjzH2pBmcaeh/q3gd4H0mk6m3Ppv0qqs4D36BJAJyB8Ay
	/FwAKSitp/1ItHxXK0mhkSn1mHut6MpHNTcCxYhBgcUSMeejVOnNB22E6a1rl54j/z6GT1xJImF
	8ruQ7/DWSJUqz2J4mnz4LSt3UXWQlVWyfYQEIcc2ZS4gfegW+hEweVsxYkjwdzSAPnsLUrZNBfa
	WwE70x5lmYDCAE1gBrwRCRsYuHDCPV43qtO8tS3iTUeBd540HKuu0xBJhZSVOg24zKIrhlfUJfg
	x8hMzx4/J5+Bp+IXCJtECSzrs+iJFyT8d5tkA/fElQ1/j/8X43vGREJP9Xc8qky6BsYH8FnJ
X-Google-Smtp-Source: AGHT+IHxwfs1tneuBNRJHj9AainQycwiHovhSKVrs9FnHQypaUW4br4XdYSWpdOhHL9jUZJPzIIlyA==
X-Received: by 2002:a17:90b:2c83:b0:315:cc22:68d9 with SMTP id 98e67ed59e1d1-318c927f2e4mr19601212a91.31.1751304820832;
        Mon, 30 Jun 2025 10:33:40 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3193a5d7e8fsm74846a91.1.2025.06.30.10.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:33:40 -0700 (PDT)
Date: Mon, 30 Jun 2025 13:33:37 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wireguard: queueing: simplify wg_cpumask_next_online()
Message-ID: <aGLKcbR6QmrQ7HE8@yury>
References: <20250619145501.351951-1-yury.norov@gmail.com>
 <aGLIUZXHyBTG4zjm@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLIUZXHyBTG4zjm@zx2c4.com>

On Mon, Jun 30, 2025 at 07:24:33PM +0200, Jason A. Donenfeld wrote:
> On Thu, Jun 19, 2025 at 10:54:59AM -0400, Yury Norov wrote:
> > From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > 
> > wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
> > function significantly simpler. While there, fix opencoded cpu_online()
> > too.
> > 
> > Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > ---
> > v1: https://lore.kernel.org/all/20250604233656.41896-1-yury.norov@gmail.com/
> > v2:
> >  - fix 'cpu' undeclared;
> >  - change subject (Jason);
> >  - keep the original function structure (Jason);
> > 
> >  drivers/net/wireguard/queueing.h | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> > index 7eb76724b3ed..56314f98b6ba 100644
> > --- a/drivers/net/wireguard/queueing.h
> > +++ b/drivers/net/wireguard/queueing.h
> > @@ -104,16 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
> >  
> >  static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
> >  {
> > -	unsigned int cpu = *stored_cpu, cpu_index, i;
> > +	unsigned int cpu = *stored_cpu;
> > +
> > +	if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
> > +		cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
> 
> I was about to apply this but then it occurred to me: what happens if
> cpu_online_mask changes (shrinks) after num_online_cpus() is evaluated?
> cpumask_nth() will then return nr_cpu_ids?

It will return >= nd_cpu_ids. The original version based a for-loop
does the same, so I decided that the caller is safe against it.

If not, I can send a v3. But, what should we do - retry, or return a
local cpu? Or something else?

Thanks,
Yury

