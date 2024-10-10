Return-Path: <netdev+bounces-134064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625FD997C11
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6996D1C23AD2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61D19DF8B;
	Thu, 10 Oct 2024 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IH2fxrGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2A19D8B4
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 04:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536350; cv=none; b=tro/R0lKgbvqw70weP5zj/nX2wE5MhmUAWZS1ud4QpqeN0Yi2jwp+crkB6l1EHdMd7rZbxatkQ05JPk8zPMGlVKNObYELnA1Rm69x5FEXMaGR3JgBB3CvzqT73IZtbK7m4tZxTdnaDiMaF1hF3sJPmXOSouQUmRaVFfffDEWW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536350; c=relaxed/simple;
	bh=zJXI2DYez1X3sci0YkGbrgs+5tXVO2AmBbY6FOY3sbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z88MR3JBu5uAjwcKzuaxgj7e5UKAHQ9pxCUS3HcoXhF8fbT+GtIfh/Mp0oH+smsDzPA/AfOahGicFJB0uImHyL7s06lAtJOUkYDQMn+KOog+nZso0t0SDMil5IDSXdG/9omiaegzgusa/MEJ6ARAT3v2SNZYPcVSl0bvxTF6gEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IH2fxrGI; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e03f8ecef8so289381b6e.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 21:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728536348; x=1729141148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VoU/x6ussxWWJbQQRe+aak+n5cu3oteZEAGlAAF1Mng=;
        b=IH2fxrGI8TvWnBEZuqTKDd2AZ1YZnCmrpCIOwtHx6IU3qrgaQXR5IFx5qkk+UVEIgO
         qmuFjAgGCBBIh8pFYNHzR5lWd33gioRqSDgOA5avDaVvcdVFwpHseTDpNwVi/V6W/CPo
         WZNxBBdpg2BG90zBiP1dpSKmbP4l4fevwZLtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728536348; x=1729141148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoU/x6ussxWWJbQQRe+aak+n5cu3oteZEAGlAAF1Mng=;
        b=Z8/t4LppE22+7qWUkZUc+/DTeEbyblPhxrRy0k+lkKmGPbTu3UBREkkJIux94B97RW
         5d5CAqjiVDvoIpTyVNGZzWSXo8ISbnbqZ4PgOEIEVybYoIt8uy9+vrup++jGZdKNLJAJ
         7nVDPyqnXLVv2mAwSMjwjAbd/HSTin8FeTZeSzWeo+GDLk1AX2vKUk9XviGaEE8ZImY6
         CZHj3GiKW3vkBbnjuv0kLLx1wTVTG+hJ3ztLFa3FE/GK6uFtKsOHAyT6cdFmyZUxocoQ
         WCTRPjIzyqYM1hUQx9nPN65FGXdynLqGJRxqs7LIBsEckuDcutgAjJ1H4qpdtHabmcmS
         bqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ3KIydpmW/DoBqnfGZ6K11weGdA9cBTRr+dGz8aYZYlM9aabYKKV4AE4yfXlv/5ORX9iaKws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGNcGIFbV4yHEAeqnb4/EdFKMMCI72aZROGKPqc3lgp/u68a8
	MnyN3/zyNEzFetPpjZhiAXyV1uGm44PlQActXApSXKAxLRpYkeIz0HDACeLSWss=
X-Google-Smtp-Source: AGHT+IEv0O7Nb5eais5i8QxwOLcaw9aRE9xxut8kOh2lLhxTp3ohXV68TchdcBO6zQkEqoEbPW8kbw==
X-Received: by 2002:a05:6808:1918:b0:3d2:18c1:bf35 with SMTP id 5614622812f47-3e4d71beaddmr1948457b6e.33.1728536348313;
        Wed, 09 Oct 2024 21:59:08 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496690dsm278239a12.77.2024.10.09.21.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:59:07 -0700 (PDT)
Date: Wed, 9 Oct 2024 21:59:04 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 4/9] netdev-genl: Dump gro_flush_timeout
Message-ID: <ZwdfGOnyjhTtdR0s@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241009005525.13651-1-jdamato@fastly.com>
 <20241009005525.13651-5-jdamato@fastly.com>
 <20241009201440.418e21de@kernel.org>
 <ZwdZQa3nujo7TZ1c@LQ3V64L9R2>
 <CANn89iLNuzv7hr19FF0u8TsJwDbGcxrs24FqKhmvxMxLPUZBbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLNuzv7hr19FF0u8TsJwDbGcxrs24FqKhmvxMxLPUZBbQ@mail.gmail.com>

On Thu, Oct 10, 2024 at 06:45:11AM +0200, Eric Dumazet wrote:
> On Thu, Oct 10, 2024 at 6:34 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 08:14:40PM -0700, Jakub Kicinski wrote:
> > > On Wed,  9 Oct 2024 00:54:58 +0000 Joe Damato wrote:
> > > > +        name: gro-flush-timeout
> > > > +        doc: The timeout, in nanoseconds, of when to trigger the NAPI
> > > > +             watchdog timer and schedule NAPI processing.
> > >
> > > You gotta respin because we reformatted the cacheline info.
> >
> > Yea, I figured I'd be racing with that change and would need a
> > respin.
> >
> > I'm not sure how the queue works exactly, but it looks like I might
> > also be racing with another change [1], I think.
> >
> > I think I'm just over 24hr and could respin and resend now, but
> > should I wait longer in case [1] is merged before you see my
> > respin?
> 
> I would avoid the rtnl_lock() addition in "netdev-genl: Support
> setting per-NAPI config values"
> before re-sending ?

OK.

> >
> > Just trying to figure out how to get the fewest number of respins
> > possible ;)
> >
> > > So while at it perhaps throw in a sentence here about the GRO effects?
> > > The initial use of GRO flush timeout was to hold incomplete GRO
> > > super-frames in the GRO engine across NAPI cycles.
> >
> > From my reading of the code, if the timeout is non-zero, then
> > napi_gro_flush will flush only "old" super-frames in
> > napi_complete_done.
> >
> > If that's accurate (and maybe I missed something?), then how about:
> >
> > doc: The timeout, in nanoseconds, of when to trigger the NAPI
> >      watchdog timer which schedules NAPI processing. Additionally, a
> >      non-zero value will also prevent GRO from flushing recent
> >      super-frames at the end of a NAPI cycle. This may add receive
> >      latency in exchange for reducing the number of frames processed
> >      by the network stack.
> 
> Note that linux TCP always has a PSH flag at the end of each TSO packet,
> so the latency increase is only possible in presence of tail drop,
> if the last MSS (with the PSH) was dropped.

Would you like me to note that in the doc, as well?

