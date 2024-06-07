Return-Path: <netdev+bounces-101807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BCF90022D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4950B22777
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17115188CAE;
	Fri,  7 Jun 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dFV+W9/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327519067D
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759842; cv=none; b=qnTCcXhUdQpofFJnumovqEr6O2sKoktjIbOpLrrSZnV+sIQ7VSaRDJUcAKd0jHKFP6UgBRzzksZE67udGxlq0JUP3fgEwLD9A4fBbThRj1KUVfTMoN0GtoFajkIKreaIPf4YEcyVqXGf2Ac1a1mdzkEErnTQDegVrawAaw0r1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759842; c=relaxed/simple;
	bh=/GkQzN0Yw4pM8zJN92jqJL3nkLY2pjxmco0QKYcFhLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpCzXzTnUDNDFz7aavFqlydZ2KwSjWGswcohQlD8DyQAyxYchWtQxfsDbPTHFsuJdmY8TD5c7cWqrE5yxS4IaZbppE5qruNLnd7BtBpU4uN4Qwgf6WGE09YKeqUedotKPiK8bUhHIS1v7diXko52P4+hCl22p5czkztshjzeixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dFV+W9/B; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35dce610207so2295629f8f.2
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717759838; x=1718364638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOXwqQ83h5Kg+N5Bh2pU7Ruq3Lq9iEdcIxS2DbZLb2E=;
        b=dFV+W9/B3Gj8DBH2EpLaA1Ve0mSFc1WWAFMYcSfmGMmFJpCpnJuYzUY/XflU14JVO1
         9C2jFsD1mKP/pLKZQl9I9zR+UYZajbGGsgN/LocIch4gfaBP6FBV9t0h00I8HpudZnFZ
         QRgVf46fBRxLdJjdSt4s3Si2pHv+Ea1OyQebrYQttKImZC9eyeSJMHD5Dyfzr6QR6oNu
         44BdnUN46CU6bU7KpljAZtpbu7NO9+eDgfHjEiqQUy0jNOHIXj9/lVOJ1mtIgrC4yHKw
         iJfvkgGweCbxKOg1kzIqmqS0zTFxmd7SftHEThDmTo+tDPLWdWYD2WMu4z3qsQyOYcjf
         7NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759838; x=1718364638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOXwqQ83h5Kg+N5Bh2pU7Ruq3Lq9iEdcIxS2DbZLb2E=;
        b=SEgueJwzHnjs3GEW9PfKvPIfqMry9nN7Mv03IxVxkhWCXd5/SW3A635SVL8qi9fCjh
         jb5PyIRPSEInZJeNqS1r8RBPc8K6BaqeG/j093ItW5JSyrHudV4/0YNZHO7SF/niL2ra
         EpOZuDux5tmoX0Tdm6IHZVSKbv8wADnqM2WlNLSWl3DQUPSuyx8kfLAS0k4whQCtvZTM
         2tzWDn2kgmgtqGoTFApx79BMRaj4kQy1mVrnzI7TO80c2TvRh5vbaNjChZEIgZjbByGn
         ixr8t0cU5R+Jk0YSidhYNEWUEfqYwXriLG2fHQeSAdGrvDQx65Buo42lw2BfUXSOp8ab
         aJkA==
X-Forwarded-Encrypted: i=1; AJvYcCXosY8/m0aEjUdbzAPYj3JdIgt3XWjiNC7ydi4lNWlL0404GOa9jEJD44FhDVTtfxxa75qRG0vObR+XrfEe418rBtLkhy5w
X-Gm-Message-State: AOJu0Yyxm2D8o0zLmi71ZQ8c7DxTq6KVnwW+V+GI1zy3Qj+jrlXv/ej5
	Pcp4PUzgcdivwXMxD4slFNfePvidVuyZqKm0/gF22JAoCurjkyVeUwA/BtzAD9Y=
X-Google-Smtp-Source: AGHT+IE8lHafUaMDrYxlZG0COcQKoeOCBgEik35FcvgH6ReHvmbxC5vBjEJQu48X0kNcnKp7Om5Chw==
X-Received: by 2002:a05:6000:180d:b0:354:e0f0:2943 with SMTP id ffacd0b85a97d-35efed617f0mr2186873f8f.37.1717759837884;
        Fri, 07 Jun 2024 04:30:37 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc0f29sm3833277f8f.105.2024.06.07.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:30:37 -0700 (PDT)
Date: Fri, 7 Jun 2024 13:30:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmLvWnzUBwgpbyeh@nanopsycho.orion>
References: <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
 <20240607062231-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607062231-mutt-send-email-mst@kernel.org>

Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
>On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
>> >True. Personally, I would like to just drop orphan mode. But I'm not
>> >sure others are happy with this.
>> 
>> How about to do it other way around. I will take a stab at sending patch
>> removing it. If anyone is against and has solid data to prove orphan
>> mode is needed, let them provide those.
>
>Break it with no warning and see if anyone complains?

This is now what I suggested at all.

>No, this is not how we handle userspace compatibility, normally.

Sure.

Again:

I would send orphan removal patch containing:
1) no module options removal. Warn if someone sets it up
2) module option to disable napi is ignored
3) orphan mode is removed from code

There is no breakage. Only, hypotetically performance downgrade in some
hypotetical usecase nobody knows of. My point was, if someone presents
solid data to prove orphan is needed during the patch review, let's toss
out the patch.

Makes sense?


>
>-- 
>MST
>

