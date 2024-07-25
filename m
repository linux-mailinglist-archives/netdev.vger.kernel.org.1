Return-Path: <netdev+bounces-113054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D593C849
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580F01F21A79
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 18:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E51F959;
	Thu, 25 Jul 2024 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="LMzO8+gq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D120DC4
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931649; cv=none; b=qsc/e0xy9DPbTyfV9HWOrfITD1J/ghfraHz2G4soLS/axjpkbpG8CMH0IHyZcwMd/QhCATX+RSjI+ZLPBomHPXWK1o/U3l4hZEySM+iWu6gpPGV+R2I0Vi2LdJFdBcaFO17mZ+ptk0wZqsu0giber9XToSMZjrOVGmqr9R6TAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931649; c=relaxed/simple;
	bh=WGIBlAnM7VjH2trUu0d+dkks6ICkIsUhz9I4xr10nxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcpG+VC2chjfHpQB2kZb1EPEQ/4myGp1h+ctp+uFsCQCZvWVRGUcPYs5vp2QoxPE4GfteL1zC12taXfmdFUVx+158ESIjYOjBUJLbWR9Jf5edxWrVhlOWwI5l4pkXXi+vvYRMUFMMUGJ2gQcYJTjrmiA9NyYhs286LiJO2HynIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=LMzO8+gq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso89791a91.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1721931645; x=1722536445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OU9HNdXliu6dHLhzcX85lB2YrM9E7RdnuKT6rLKar8=;
        b=LMzO8+gqmF1fNXRtMjDBYsJnaXmKFrzXLDoDlcRe6SSbtW0XrC6sENN9fKUYiXTzk+
         oRoFsKfvhbodmuRKVFlgPOlBpTOVxS+zvxq+8PeIDWy6vW++KeggiDqyiV/wFEM6gY3R
         hVGVq2NX3LtrF0t40H6GrHRalSLJd+44XE6ttXdL/HxWjn2Ee4Jz+yhidvknKH0AvMFj
         5KDl3OgCgfcLWRb+A3Z3PYYkots/NkV7LC5molk7ebX6kNinfFUo0hq0uFiv4+UjFkDa
         0/OM62NWsjyDHyWqP+Nh6BzisXjgd8n47s+l03e9f9YlL5vaB1eIuMrITIKWAWrEKIyG
         70VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931645; x=1722536445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OU9HNdXliu6dHLhzcX85lB2YrM9E7RdnuKT6rLKar8=;
        b=c6VyRuC85sgjXz75I44Dn8joqWG00OcQ93XeQ+lxTkDDdxZYdxfPuo2T5I7p/CmVip
         TEGTFhdAem+oazwtQnMnCSsChTpB82THBwwifwPkptIpeVUpGco+BgfX/NEP2SOdrrL7
         PlCmAo262kv0KXNzFjYsmmMgHFWPizlfSGUdIO//yF34JY15GGPVRv6sSUBrgTIP/Gsy
         LVDyfnBLAYM+L+Mmc/KiaGjyBzmbfwPDoTmtgBHLzfGJx24qEInRtFs7QQQFS1tix+av
         5geTziD3J4+28SqmtM9AVNTnk6NDHo7D6auUBhNhfuqC/ZJxXcgHb13q6JdmCaSTGmCK
         hQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCUYjZPBjqKwzgtT/vpro10wz9w9CV6RXmnd3/glqmzMX2z8jTg/07ddDNCTYBGGdNO0J3VvEubENgVQGnAOkRL8EqSDBY9k
X-Gm-Message-State: AOJu0Yw96QvQEL7RCT+c4Hgc7OyFGydAYPq/PAZ+UpnGT8l9RTsBO0Nq
	+j7SIReUQvYwurtAu9911j6sVN/aOCoAOEiHaAFQy6fss0opfG93Cob71oGmeNQ=
X-Google-Smtp-Source: AGHT+IFlaxsMAtDeoChFztGJYkCgwZziGkfSpBN0IYzZ/jUl6sjTmugj+FDh0CGjRJk6H9wzILRkVg==
X-Received: by 2002:a17:90a:5d11:b0:2c9:63d3:1f20 with SMTP id 98e67ed59e1d1-2cf21f4adafmr6271049a91.18.1721931645092;
        Thu, 25 Jul 2024 11:20:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28e3f67csm1835929a91.53.2024.07.25.11.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:44 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:20:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Adam Nielsen <a.nielsen@shikadi.net>, netdev@vger.kernel.org
Subject: Re: Is the manpage wrong for "ip address delete"?
Message-ID: <20240725112043.5077ef9b@hermes.local>
In-Reply-To: <m2sewezypi.fsf@gmail.com>
References: <20240712005252.5408c0a9@gnosticus.teln.shikadi.net>
	<m2sewezypi.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 11:33:45 +0100
Donald Hunter <donald.hunter@gmail.com> wrote:

> Adam Nielsen <a.nielsen@shikadi.net> writes:
> 
> > Hi all,
> >
> > I'm trying to remove an IP address from an interface, without having to
> > specify it, but the behaviour doesn't seem to match the manpage.
> >
> > In the manpage for ip-address it states:
> >
> >     ip address delete - delete protocol address
> >        Arguments: coincide with the arguments of ip addr add.  The
> >        device name is a required  argument. The rest are optional.  If no
> >        arguments are given, the first address is deleted.

That part is just wrong. Went back and looked at really old system
running 2.4 kernel and it failed there as well. Probably something
that got changed long long ago, and no one cared or noticed.

> >
> > I can't work out how to trigger the "if no arguments are given" part:
> >
> >   $ ip address delete dev eth0
> >   RTNETLINK answers: Operation not supported
> >
> >   $ ip address delete "" dev eth0
> >   Error: any valid prefix is expected rather than "".
> >
> >   $ ip address dev eth0 delete
> >   Command "dev" is unknown, try "ip address help".
> >
> > In the end I worked out that "ip address flush dev eth0" did what I
> > wanted, but I'm just wondering whether the manpage needs to be updated
> > to reflect the current behaviour?  
> 
> Yes, that paragraph of the manpage appears to be wrong. It does not
> match the manpage synopsis, nor the usage from "ip address help" which
> both say:
> 
>   ip address del IFADDR dev IFNAME [ mngtmpaddr ]

ip address allows address before or after device name. 
Both are the same:
   # ip address delete 1.1.1.1/24 dev eth0
   # ip address delete dev eth0 1.1.1.1/24


> 
> The description does match the kernel behaviour for a given address
> family, which you can see by using ynl:

Kernel ynl is new and different.

