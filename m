Return-Path: <netdev+bounces-85714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A979989BE33
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175B61F219C4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A8E65BA8;
	Mon,  8 Apr 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QP3T5Xdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225745940
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576231; cv=none; b=Sw42G3N9Naqn7eg6BU5dNzU9IXwPvVImfMMUfWaMYj2CqZCcxaBekK1bhPDNWX+nT5YXWgF6zq7RdlHC9JDLRXga5cqldsU5FpKHxZZw8/kKaLIP1X1LGMpz1yuGntfZVd3J0wv/K4lEaWuu8p2QPUlM+0K12O26VPKDqYd5SX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576231; c=relaxed/simple;
	bh=iINuaUKCNq7mtaWLIm7uKIvUKcwCT/vZrWolmbXHP8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kkti5Cr344tEOmzEMmltcBqYvqAVn5jGweUDoJYPhrEWOOirhv2TKEEF2t3oD1dNcg0GfsznEve0sxwKdiYcYSXdEFek5yMTXzS/0Sv/ab/I5hTos4xyi91/9DHwcdMH7HP//2kUX/8H/YxWLISlBGUAjzchI3PWUIgXRjuBefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QP3T5Xdu; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d0162fa1so5028591e87.3
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712576227; x=1713181027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iINuaUKCNq7mtaWLIm7uKIvUKcwCT/vZrWolmbXHP8o=;
        b=QP3T5XduYVfIUt7CyoSE6SnZ2IUEmPPf3B5zk/ya0tVLv6D0x1kC1d7ncTMFQAKXnY
         z8Wfevfjdw0uLCix3qwZEEYziAbLQAFe+9GDCl/YohiR0f+wbYpCnPaULh2VeAhatiFv
         XoNqOZl2iUp1WmSmZ7/L59nJIBbGNCFm/LIfZkw1K3dI5gCfHuclYO47yTH/8mfYNbfy
         ptmdZzoBz1vbgAEgxh82m0vE8/yta6luyPVy+t7G/DpLSlCvsGG+Olyb/0dIYQJFGALV
         mljf4Uu8Sn1VsGqMOctHtSTNr99EZkEi+UiZtQk0taDn89DXew0+0/xSEsZUfqNMuOzC
         ORNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712576227; x=1713181027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iINuaUKCNq7mtaWLIm7uKIvUKcwCT/vZrWolmbXHP8o=;
        b=tjwGDR37z7gacMw5sOigYj7ImEhnogM6RLYDdMmpAWNVFdQjivFXZkW4ZdCtB++Lk2
         BNrXmc4bAvxV9ePLl01LXhApQkdUfNLB/EEevv3Zp1fOszHRwmBG9k136pgJ2e2AjCjD
         cnJfkZ5KiE1nUMvRr9vNsJholVRgYEiLqFvFO3vaPQZgWvDXhjH5cqaR2GvWa1mncz31
         OxW7tn6z+qfqdkdIrobu1xs0OCcKhgSVxr6g5XOdehaqEzU52iGRTxEc2FxnpWcfjP1n
         6ZGQWgcLPVStCwA2yRL3dXKCGPAfGMLFx6jS4B1mHpbAw7gThEKS+SPln37jS3V8E/PW
         5f0A==
X-Forwarded-Encrypted: i=1; AJvYcCVBiELt4fSQ4HEPqzqc/m/X0x0XZGvZiSENZWvN43YiXve3iSMmJYK4QagmLGTzyzB53SNf48HX1OlXdHrZsue+mm+X78hp
X-Gm-Message-State: AOJu0Yxh35T8DUaHr6gCjxwyLBmAzW6H6AppuXnTYZ3Hem+sYL9gOJBi
	UIwZ2uu1EBHfsgUQvvwGJDNe3z92OoHyQf0qsJLbDHsCbfGulLyyYdtLOYC02A8=
X-Google-Smtp-Source: AGHT+IEAArslfEzp+o/yxGarOJlYV2s6GBcovR6lg5JpRDG0E3O4JmQUaqXsZC+GRIs6S/0fe5t6mA==
X-Received: by 2002:ac2:5df9:0:b0:515:d50f:c6cc with SMTP id z25-20020ac25df9000000b00515d50fc6ccmr5790286lfq.63.1712576226611;
        Mon, 08 Apr 2024 04:37:06 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fl14-20020a05600c0b8e00b004166d303d6fsm3718576wmb.25.2024.04.08.04.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:37:06 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:37:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhPW3anhgMtv4Mb4@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org>
 <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>

Fri, Apr 05, 2024 at 09:11:19AM CEST, pabeni@redhat.com wrote:
>On Thu, 2024-04-04 at 17:11 -0700, Alexander Duyck wrote:
>> Again, I would say we look at the blast radius. That is how we should
>> be measuring any change. At this point the driver is self contained
>> into /drivers/net/ethernet/meta/fbnic/. It isn't exporting anything
>> outside that directory, and it can be switched off via Kconfig.
>
>I personally think this is the most relevant point. This is just a new
>NIC driver, completely self-encapsulated. I quickly glanced over the

What do you mean by "self contained/encapsulated"? You are not using
any API outside the driver? Every driver API change that this NIC
is going to use is a burden. I did my share of changes like that in
the past so I have pretty good notion how painful it often is.


>code and it looks like it's not doing anything obviously bad. It really
>looks like an usual, legit, NIC driver.
>
>I don't think the fact that the NIC itself is hard to grasp for anyone

Distinguish "hard"/"impossible".


>outside <organization> makes a difference. Long time ago Greg noted
>that drivers has been merged for H/W known to have a _single_ existing
>instance (IIRC, I can't find the reference on top of my head, but back
>then was quite popular, I hope some other old guy could remember).
>
>To me, the maintainership burden is on Meta: Alex/Meta will have to
>handle bug report, breakages, user-complains (I guess this last would
>be the easier part ;). If he/they will not cope with the process we can
>simply revert the driver. I would be quite surprised if such situation
>should happen, but the impact from my PoV looks minimal.
>
>TL;DR: I don't see any good reason to not accept this - unless my quick
>glance was too quick and very wrong, but it looks like other has
>similar view.

Do you actually see any good reason to accept this? I mean, really,
could you spell out at least one benefit it brings for non-Meta user?
I see only gains for Meta and losses for the community.


