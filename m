Return-Path: <netdev+bounces-182000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C328A874C2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC73B5455
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED91FECD3;
	Sun, 13 Apr 2025 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7aZ1T4c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59591DA31F;
	Sun, 13 Apr 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744584745; cv=none; b=o8df/MxdgiJXZmONRwSgzI/6DHeKPMCYRXwuuA4daXf4oEMY9/yuR3c8Yas45FBaUqVhsA01H3GutNLfCevia6tQaCIrkGSsXPU140zXpACKqeyCECOpsqIsfzqAqUL4kuQsAaGagM1ujYParDykrlMEjfIQhW9eaZPL6pVyTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744584745; c=relaxed/simple;
	bh=MI85WKDTq5VPsC1xRbop6UTPrW9XCzxKzhDoX/rgML4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWlLpuDM1QHwalFVgNrST+lF/ZHnycW7YFUWOOL+psUlKKZZ5nUoqISWTTkNsvx7nKN/JnZ8d7OY724DwKrAVimW3uslpt4rtcoww9gkliI97E0n1g4TMcPP2jEEMIxlRA0UT6WL2j+bW6hJEghX0XzV5EC8CIBfCH4gg5oOPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7aZ1T4c; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3105ef2a071so9824591fa.1;
        Sun, 13 Apr 2025 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744584741; x=1745189541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zexz4z0uhB0gTpGdhc2RGOv8gF9wmocveDqMDnRCYrQ=;
        b=T7aZ1T4cHOKP6G7aR/0Sj+dEb7ouL1VPPNaOCbqppU0urU+++yQlcoarKUmkugfASG
         yUEjBcEheOERRJ/ldBxiiBoK6MSi4AtIWp/+jEqKxbS5UlsLWmnNPzIXLDK+SYrIo37m
         O8NC2tJWqqo6LfJVzQy2hRd5itTAOAGDKZQGXeR2Tvr+KZ4LV3E8duSm4W6Hh5NdC8Qw
         oey3YIDU4qy7LBIWr1fkO6e4mnQ+M4htX2bBmBxotdoOBksLh0WNHHmLgiCEnujgeLOC
         vkuVETpEg5V9MUQFiV0IopFil1Se8ZOQWW6s5g2Kughnpi06S5Rz2jj5tS4jAJ6MsmQQ
         EKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744584741; x=1745189541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zexz4z0uhB0gTpGdhc2RGOv8gF9wmocveDqMDnRCYrQ=;
        b=aPE6U4remmfAhARxTefaBpMKxWQzC/6DWxImdFkBb1ZKvQlpUIM744MOJ0XLYGh0V0
         fyDbtxmjKuxJonqQqCkGQxkOQ/J3TqftGCT/yR8YXTzSouM7rHb+l2vv5UfPZR8GCD3L
         rsHqrYzIj8tAqQzoD/FKCazsfAGXggygCiZ6I8HYlfehNJ6guhjurnS4H6CFlQRQedeM
         p/nVDrWEGvfiOTWTc4xDZCG4xjJRPyaiVV41T372XuNlWw3CkcdFtpgFosibpHpq5+UG
         xOFtBxPONIeyzQMoBaztfA4kgy9E2v5u+mSns4zMrP1QSHZhDvD3Tb97FcGIatEUJpsM
         gFjA==
X-Forwarded-Encrypted: i=1; AJvYcCWPZch8j1/e7dOmnl6JQAvkSIGVM4FGP7qpLfP+98xn5yBvreRjoxKHwjIT2HMDfvj5W1DRXMlZATR7184=@vger.kernel.org, AJvYcCXPVp+wyuo8BRICe/qohDvQoCt6z6ToENWvaNaqjFKldVlmovK5WXUv+NdfeV9FQ3ApKAOVBYMc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6UURWn8tSdifqPD3IjEMi/seZ03OPEnaqHraWFKrpZMNsaGm/
	kHJZv1kKRfy2CEYBLe5HmW7z5MVwH+SGVDXQdS7lB+XUVwZh78uFYsxjTX4J
X-Gm-Gg: ASbGncsfn0PR3Llk4TS60A8m+S1RnDCjyOiNCISGlcq5GQQG1oRceOuNLN7/0nKJ5US
	MwAxfoETAHdD0gEGA7EWIks7xaMUekZGKSXAxf9YakkRrZ5Mn8aXeMgvB1jmF1n2DmcQXFtB7rj
	/QuyX1luAVZTryK4U3upIsp9qluPUkNQBQWDcZUahGdcMlVQ8/swBgeEkwXs1G2tKFa7/Oog6b2
	lXD7mOvHt9K+pQaZ+ygJYIyQuZTdyJ8g3QC0Ga3m2duTckVuJqDtlotSyvUKk3BDrQxKHFoyhZq
	hXo4fh+4s2wbC6j2TxSoc7C3Wo+NQHKm8VEpJpnvpNl0ld0268Rg048=
X-Google-Smtp-Source: AGHT+IGfZ25nrVh9rW3T7liau1KpR1Tbdnd/LwlnYyFZGw+xLX2AIb9iu8mk4c8knAMzmcaFiTBnHA==
X-Received: by 2002:a05:651c:30c1:b0:30d:b3d1:a71 with SMTP id 38308e7fff4ca-31049a80682mr35315221fa.33.1744584740325;
        Sun, 13 Apr 2025 15:52:20 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464cbc60sm14793661fa.24.2025.04.13.15.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 15:52:19 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 53DMqFXO019878;
	Mon, 14 Apr 2025 01:52:16 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 53DMqEOV019877;
	Mon, 14 Apr 2025 01:52:14 +0300
Date: Mon, 14 Apr 2025 01:52:13 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: kalavakunta.hari.prasad@gmail.com, sam@mendozajonas.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, npeacock@meta.com, akozlov@meta.com,
        hkalavakunta@meta.com
Subject: Re: [PATCH net-next v2] net: ncsi: Fix GCPS 64-bit member variables
Message-ID: <Z/xAHeYXfFAUpxbR@home.paul.comp>
References: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>
 <Z/eiki2mlBiAeBrc@home.paul.comp>
 <20250412102304.3f74738c@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412102304.3f74738c@pumpkin>

Hello David,

Many thanks for chiming in and correcting my mistake. Hari, sorry for
misleading you on the last iteration.

On Sat, Apr 12, 2025 at 10:23:04AM +0100, David Laight wrote:
> On Thu, 10 Apr 2025 13:50:58 +0300
> Paul Fertser <fercerpav@gmail.com> wrote:
> 
> > Hello Hari,
> > 
> > Thank you for the patch, it looks really clean. However I have one
> > more question now.
> > 
> > On Wed, Apr 09, 2025 at 06:23:08PM -0700, kalavakunta.hari.prasad@gmail.com wrote:
> > > @@ -290,11 +289,11 @@ struct ncsi_rsp_gcps_pkt {
> > >  	__be32                  tx_1023_frames; /* Tx 512-1023 bytes frames   */
> > >  	__be32                  tx_1522_frames; /* Tx 1024-1522 bytes frames  */
> > >  	__be32                  tx_9022_frames; /* Tx 1523-9022 bytes frames  */
> > > -	__be32                  rx_valid_bytes; /* Rx valid bytes             */
> > > +	__be64                  rx_valid_bytes; /* Rx valid bytes             */
> > >  	__be32                  rx_runt_pkts;   /* Rx error runt packets      */
> > >  	__be32                  rx_jabber_pkts; /* Rx error jabber packets    */
> > >  	__be32                  checksum;       /* Checksum                   */
> > > -};
> > > +}  __packed __aligned(4);  
> > 
> > This made me check the Specification and indeed somehow it happened
> > that they have forgotten to ensure natural alignment for 64-bit fields
> > (at least they cared enough to do it for 32-bit values). [0] is the
> > relevant read.
> > 
> > > +	ncs->hnc_cnt            = be64_to_cpu(rsp->cnt);  
> 
> Doesn't look related to the structure above.

This is related to the earlier change of the same struct, I just
omitted that hunk while quoting.

> > This means that while it works fine on common BMCs now (since they run
> > in 32-bit mode) the access will be trappped as unaligned on 64-bit
> > Arms which one day will be common (Aspeed AST2700, Nuvoton NPCM8XX).
> > 
> > So I guess you should be doing `be64_to_cpup(&rsp->cnt)` there.
> 
> That is is the one that fails - the compiler is likely to warn about
> taking the address of a member of a packed structure.

Indeed I was confused. I was reading just
include/linux/byteorder/generic.h and expecting some kind of tricky
behaviour from the compiler (for the sake of optimisation as usual)
and wasn't aware of [0]. Taking address of such a field would indeed
produce a warning with -Waddress-of-packed-member.

> IIRC it is enough to mark the member rx_valid_bytes __packed.
> That removes the padding before it and the compiler will then assume
> it is 4-byte aligned.

The problem is that this struct is full of members that happen to be
unaligned (as the NC-SI standard specified that), it's used to unpack
a response packet returned by networking interface, so ratehr than
having every __be64 value there __packed it's cleaner to have the
attribute specified for the whole struct I guess.

Thanks again!


[0] https://www.kernel.org/doc/html/latest/core-api/unaligned-memory-access.html#code-that-does-not-cause-unaligned-access

