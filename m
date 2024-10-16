Return-Path: <netdev+bounces-136076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508C9A03FD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D5C1C2A98C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FFB1D0F5F;
	Wed, 16 Oct 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e1t3Ajo7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934704C8C
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066642; cv=none; b=p5dxDc6PsMIVUgrxW3hLK4MxCHeME7Wnp3J4uhp6Xxm78hsD8ZYEbqD8bEFFhO8/DB0RzTR9suqP4EG7ujRBOUkZhJGF7eYOm9QaHOIYsKpO0zE67syVz2rRQiHCwi8ZCICIVgDYH+OPMBDzHcj134lDJFKmvIa8YkZi1GZwNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066642; c=relaxed/simple;
	bh=ZL5mlBP+qHkZzh0UJdUbcXObrSK8IIL0bmSB2IkLiUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuaVuSWLPcrYxb70o6D5r8tbjFpWU5UsIf9LuOXvUS2hf4PuJSFzNrJB1/0I7dhfehsL+vwF8wWcGVnb534sXodJX1a/aWPVIl4hglJojR3UGglatUa+amy2nVnn6dsCb7XD12IOx99UJJhWpSxivW/RsbEdz79dtRx1qKslwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e1t3Ajo7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-430576ff251so54432315e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729066638; x=1729671438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tiIcPbVpgkm3vItrevKV80hT8yzWWkcV6bsqfy5TGjk=;
        b=e1t3Ajo7/uoHAQ4CA31kc7K55ZWICV/JeF0lYkTQe8qlyG1AJ7iNRzcOLZXNK/tWvE
         pr/l5v6IQqUb5SqKbRBH4G4ptLCK0eOA0plcakWp3Y1In0befLTB8IK8sehwF+SR6T8D
         c2DNptTrtQCr6bj42xvarqYogh+fDZKVKntyiYfZUGKItp9VvWUPUUTsUHqVu4L7pg7Q
         QDtAQ6S9QfQlImYWPvkTWILvG2WGFU/i+QElaTL+uh5mmj19Majj6KBGH5EmSlCJRPB1
         6uAqQ9OjNrBdSs1bxmimfqjA1WAaYe+QH28D1FYAghK0ANRbh056tii2AQedpaZFgAxT
         0goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066638; x=1729671438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiIcPbVpgkm3vItrevKV80hT8yzWWkcV6bsqfy5TGjk=;
        b=RFff5i4YqGrBrgouV4wG7K4//0E2TVfhETdlVOBblyEY6mFWiXrvHAQRdwEqk6rZUh
         KfUp7iHGACb+DcnF+aaN/V9o/TrxqN4iXGr3bk5IZW+Mp4kd33kSBwywHOwXDY95zbuP
         fL50k95lqEPtZd5vYN9exk0tijwAz35gZGvZLllNVZC5JSAOMVHpibcMnnAmTcgm+EmI
         jpepmLw1V3qMjXFfBTfr53/qsZ+T/Q98wqhKxYlsD0vvnBs7UU3rWjRRmqDlz23EWJ98
         MU23esmfM0tWeoraQcVx2mChdggW5r2iv1fWpkiV7ZRyW9eWW0rmDLRumwNPFjuTF1pj
         Z2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPTuGm0qAre8xsvrJtQ6hTRmPZJ80yo73ydI83KBLtU2EvrPt5YmN6QYYx7mpXfxza71ZZ3Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YykulrhI9IPv1igL1390FAo2il4G95tk7OnKo3pzvGVR8eGjAp8
	OgOH6ndq3Fm5EKpIa9O5CojR4CPO12lpH5rhuY9DkQiMUU/bYdup/VeeCTnwDb8=
X-Google-Smtp-Source: AGHT+IGZ6pLwdE3OFiD69ZsBTKLR3KHljqXCybBvV2v7DuGkhuozI2RBVsvUs+vryGktYLqsWPp2hw==
X-Received: by 2002:a05:600c:5248:b0:42c:ae76:6cea with SMTP id 5b1f17b1804b1-4311ded433dmr158248115e9.9.1729066637709;
        Wed, 16 Oct 2024 01:17:17 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc11ff7sm3652597f8f.92.2024.10.16.01.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:17:17 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:17:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	donald.hunter@gmail.com, arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <Zw92ibTX0kLzFFrS@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
 <2ec44c11-8387-4c38-97f4-a1fbcb5e1a4e@linux.dev>
 <Zw6Cg1giDaFwVCio@nanopsycho.orion>
 <7934306e-08f9-478a-a218-1b03dbfa8a3b@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7934306e-08f9-478a-a218-1b03dbfa8a3b@linux.dev>

Tue, Oct 15, 2024 at 05:01:12PM CEST, vadim.fedorenko@linux.dev wrote:
>On 15/10/2024 15:56, Jiri Pirko wrote:
>> Tue, Oct 15, 2024 at 04:50:41PM CEST, vadim.fedorenko@linux.dev wrote:
>> > On 15/10/2024 15:26, Jakub Kicinski wrote:
>> > > On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:
>> > > > +    type: enum
>> > > > +    name: clock-quality-level
>> > > > +    doc: |
>> > > > +      level of quality of a clock device. This mainly applies when
>> > > > +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
>> > > > +      The current list is defined according to the table 11-7 contained
>> > > > +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
>> > > > +      by other ITU-T defined clock qualities, or different ones defined
>> > > > +      by another standardization body (for those, please use
>> > > > +      different prefix).
>> > > 
>> > > uAPI extensibility aside - doesn't this belong to clock info?
>> > > I'm slightly worried we're stuffing this attr into DPLL because
>> > > we have netlink for DPLL but no good way to extend clock info.
>> > 
>> > There is a work going on by Maciek Machnikowski about extending clock
>> > info. But the progress is kinda slow..
>> 
>> Do you have some info about this? A list of attrs at least would help.
>
>The mailing list conversation started in this thread:
>https://lore.kernel.org/netdev/20240813125602.155827-1-maciek@machnikowski.net/

What's the relation to ptp? I'm missing something here.

>
>But the idea was presented back at the latest Netdevconf:
>https://netdevconf.org/0x18/sessions/tutorial/introduction-to-ptp-on-linux-apis.html
>
>> > 
>> > > > +    entries:
>> > > > +      -
>> > > > +        name: itu-opt1-prc
>> > > > +        value: 1
>> > > > +      -
>> > > > +        name: itu-opt1-ssu-a
>> > > > +      -
>> > > > +        name: itu-opt1-ssu-b
>> > > > +      -
>> > > > +        name: itu-opt1-eec1
>> > > > +      -
>> > > > +        name: itu-opt1-prtc
>> > > > +      -
>> > > > +        name: itu-opt1-eprtc
>> > > > +      -
>> > > > +        name: itu-opt1-eeec
>> > > > +      -
>> > > > +        name: itu-opt1-eprc
>> > > > +    render-max: true
>> > > 
>> > > Why render max? Just to align with other unnecessary max defines in
>> > > the file?
>> > 
>

