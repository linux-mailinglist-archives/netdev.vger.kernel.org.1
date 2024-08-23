Return-Path: <netdev+bounces-121354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB1A95CDD1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6F0280F0E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA48186E55;
	Fri, 23 Aug 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eOEteFvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1B186E50
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419788; cv=none; b=C9gen3FdTC21ewIcoerP0/jW6Y3v/9ZCDDaSsKC7yfJ81qTTrO2AHDD5+8XHw204+bG3bGLLx0UVNE/Xqq0NEGCrhE2sD9pPThDV4puqCKy1HIvmkZUniGKV96/3VcA1QbzE95WjSE3ND5awI+gBVtEcJqaWqdWIhAo1G324mEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419788; c=relaxed/simple;
	bh=X9LwjPzhN+uJQCh4XWk9pbDdfJ5T1eZa5ETA6hy46Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM0A/xKNGmjFku3CtTTiggb2qut5zIqjWxBYEniznNATQ20aBQDayELI0Wxnlxp0nK9qJN53+rQNFd7MV8xnX03MmTOsdLYrSa2fkDmAK8t9lV5QFgtVzbRrHvLHPLOGF9oAFY2QjTZIjV58qmtTGlJoh51e6sHXly3emXRVmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eOEteFvJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so2313815a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724419785; x=1725024585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=34ePrmT6ThCSMAVDOF/08UJdMTT0ZiO9ZyonmTHuBOo=;
        b=eOEteFvJIXchlLLKTVCuVUD8iR+ApTn2Qkg7MOqd3UwTgFRQ0YMaV6yAql6HdCvn2m
         +Gfeu2eYYOa5VxOuPCuv1Jp2v2j8bMq2QbHKIHR2X8Cufg/iDVsbaGaF7tl7Am2O/fOX
         RviJ2kfq8dL75PWmpdXQTxl9u3XBWzrww1nNZj8+eDMVV/Bb8LZUDkWborE8xXwyINNA
         FBlRoWri4HdpCsnRkWQx6sMlEF43xxGK23fZ8Cu3iOas6F+6SVvsPYe+T0yZ4Go8UqcI
         FMAi0c8pjUTWeMHKtbYwqi3fjCVwx5fbG0vsdkQX/yXMhyaouBG2KHq7LvZFcKqxHTWv
         Bqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419785; x=1725024585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34ePrmT6ThCSMAVDOF/08UJdMTT0ZiO9ZyonmTHuBOo=;
        b=BIxbVMC6WE39CZd9lwX6MVQGsAkBDIs5eL/u2XQwdqO0tshjTTb4pdpDduvlHsITn9
         H92w/cZIa8DgtfpFG6iegyGaiYsNVQIf1DzkNf+x57o3qSOwhVeg7gmPGTNLaxv19FQO
         tRRM02F8VqLT3Yw5/97neD/yf0PWwczWKTaG774PaA/hwOsjINYlERw4VRF2RRRMc2oA
         bcz5YsY96pR9ttUA2k0+KIhwgDDsU8wm+7F8xCaumvv+RTfEA02lSLyjBQejYINuDAFb
         5c4uT8NM/VxW3qbB7symKC4pz2R45/3FGr1j93RZlSI208fyZwtg+++FPaKsSY5rJ3NW
         xX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWv/YActLBYdgat2onQsVrm0UtlhYR33XPhbJtEigKZReAlN7khPc05lcBSt/9kfhrOjF14m1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEKSOY3j0J4FEVSe1ekpugAJA8dk7Sg/lL5lRhU6P2AL+99Ax
	E2QM3IV1Prfif5rnqhsZKNOvMUPG/r4XcUpZKYRAO0E8R3UAnxrsOdycjkBHNV0=
X-Google-Smtp-Source: AGHT+IEYo5sFGQI+9l4/IiJwriviRXNovEkCQk0pf3xWtH80ArYe1Esf/M6ITiX8QAhka73M1v+RLg==
X-Received: by 2002:a05:6402:3549:b0:5c0:8d62:bc9c with SMTP id 4fb4d7f45d1cf-5c08d62bea7mr1232778a12.6.1724419784285;
        Fri, 23 Aug 2024 06:29:44 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a6342sm2110246a12.79.2024.08.23.06.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:29:43 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:29:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Feng zhou <zhoufeng.zf@bytedance.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	bigeasy@linutronix.de, lorenzo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v2] net: Don't allow to attach xdp if bond slave
 device's upper already has a program
Message-ID: <ZsiOxkd5KbbIIB6k@nanopsycho.orion>
References: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>
 <Zsh4vPAPBKdRUq8H@nanopsycho.orion>
 <6d38eaf5-0a13-9f85-3a5d-0ca354bc45d5@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d38eaf5-0a13-9f85-3a5d-0ca354bc45d5@iogearbox.net>

Fri, Aug 23, 2024 at 02:07:45PM CEST, daniel@iogearbox.net wrote:
>On 8/23/24 1:55 PM, Jiri Pirko wrote:
>> Fri, Aug 23, 2024 at 10:42:04AM CEST, zhoufeng.zf@bytedance.com wrote:
>> > From: Feng Zhou <zhoufeng.zf@bytedance.com>
>> > 
>> > Cannot attach when an upper device already has a program, This
>> > restriction is only for bond's slave devices or team port, and
>> > should not be accidentally injured for devices like eth0 and vxlan0.
>> 
>> What if I attach xdp program to solo netdev and then I enslave it
>> to bond/team netdev that already has xdp program attached?
>> What prevents me from doing that?
>
>In that case the enslaving of the device to bond(/team) must fail as
>otherwise the latter won't be able to propagate the XDP prog downwards.

Yep, I don't see that in the code though.


>
>Feng, did you double check if we have net or BPF selftest coverage for
>that? If not might be good to add.
>
>> > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> > Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> > ---
>> > Changelog:
>> > v1->v2: Addressed comments from Paolo Abeni, Jiri Pirko
>> > - Use "netif_is_lag_port" relace of "netif_is_bond_slave"
>> > Details in here:
>> > https://lore.kernel.org/netdev/3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com/T/
>> > 
>> > net/core/dev.c | 10 ++++++----
>> > 1 file changed, 6 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/net/core/dev.c b/net/core/dev.c
>> > index f66e61407883..49144e62172e 100644
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -9502,10 +9502,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>> > 	}
>> > 
>> > 	/* don't allow if an upper device already has a program */
>> > -	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>> > -		if (dev_xdp_prog_count(upper) > 0) {
>> > -			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>> > -			return -EEXIST;
>> > +	if (netif_is_lag_port(dev)) {
>> > +		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>> > +			if (dev_xdp_prog_count(upper) > 0) {
>> > +				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>> > +				return -EEXIST;
>> > +			}
>> > 		}
>> > 	}
>> > 
>> > -- 
>> > 2.30.2
>> > 
>> 
>

