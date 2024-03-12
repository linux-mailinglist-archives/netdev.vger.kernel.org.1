Return-Path: <netdev+bounces-79498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7303879882
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 17:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D88C1F23F9E
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC37BB08;
	Tue, 12 Mar 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHSXA6rB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD52628B
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259509; cv=none; b=mBOxQfyHbHNR3GGwZ31M1RbzP1fs82QowtNyxVwp/wAFoGPwcG+zWvwxhhOfRTE7snGcDVoG7eBewIURJazqMkAW7oF2zTHR/bAPt4a9qh7chmZjp4fJzusjzIucJat5ABLAaVfx+F9IiieNvVsd5+YAPstyvfq/ataX0RzUFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259509; c=relaxed/simple;
	bh=kvNCfE4Ip1bNQByF3R3fMSTa289tLd7cXl2ogyc0Jyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlOUrEYidhlKvF0OanOoz7XVm6H4RawlQI1Pbs3eKODIBkDoqUO/zbqS5jfi9EPi06wmnoua+fPm5365r4tQuzGQbgKOzj4K6IaEjb6LMSVPRKckehdRnizgK4IyiFWO1qjXE1uztzZbeqb/kOQ6LmSkHp962X1fW9TCkpdqTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHSXA6rB; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2204e9290f9so2505526fac.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710259507; x=1710864307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tXlwm30yQJgE2SRn6xyA1g4z/QrquF887B5OAKW8GqI=;
        b=cHSXA6rBqxt5gMsFhr7XVyKQlaKNJbjVbLEX/T7naXlN5kNlmUbZG+Lh69UXZU/nMi
         tdyKtr+cSxLyjFdb6pDfL+3q+pEPi4x4BDbzCGa8uJaClT9D06uykEvt/GLho0v5HfZx
         +6tU1Xct4cfputlm/90DaBSAVLytTtdkMmwWmEMLU5Hdk5tsB/52kA+f/cmb8tNJNd8f
         aM7JJ+HLoniEIPQte7Z5hCx3eYt35kR7H4jXlMFUSCmqLTzDtJC5qS74tc8EmY2G9bx6
         z4mbfWS8y4k0/ITnpdtXpUPmCjXQrtficXPzxTxuRPIi7ncgjZ7Q9K3dVkzmRiGb6ekO
         cjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259507; x=1710864307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXlwm30yQJgE2SRn6xyA1g4z/QrquF887B5OAKW8GqI=;
        b=L0WLLaK+e5CSo7Yu1TmZTGJhAAn+wapUoVHIp7YHHIsT6rdDsA/2bRxchqlI0DABHa
         04uwIukG1Pg3vf33f+0jrMh/XiBKekDExjfJ67SZqqYqe0SfPj2kcl+/wOSSHwQ5Q4+e
         ndoW0QiEXtev6bYUC5bN3d6VyrCUF3040Y9OWWdYQA2VW9Rvq96CGqxDgagMwMp/uOtW
         Hbo+0pgERvPqjCuxzHYllYnMiKUlvHhxb+2f3Z5z4hit7C7KfrFfJx0dpMi+CH1E81BZ
         VJNqkWVA8eliqreHn4LljqGCN4qYy+lMgp4DSlXOFw9jjhM+mu9bvZ7FtfAjvHeYNSf1
         nVZg==
X-Forwarded-Encrypted: i=1; AJvYcCUFNs92aL31r4EidXYpGoxNcxgg3Gg7oK8n0eOXhVwevGFzhcs1oQHBW3Eotypnc42ecT5Cm5u9wT9h5jY4h0ej5JBknEp4
X-Gm-Message-State: AOJu0YxXgUdfzhcfZhGvMDTDIOPvdRmqmcHnyc/g+0HNzmrH4NcwuAMP
	Rn5zpLBOMRUtRM5RaGsKLPxiS/yubpm/WGEkiGVxZSKJOwZEsfJuYdjBO036OwxiQJomOeBjHGy
	Z6mVLfhOwhGUjgPO062nfG8gdoEY=
X-Google-Smtp-Source: AGHT+IGsY3u4Imz+aLaDmsLB3bgotb4y/fhGI5TySjC/cgRJisx0ZwLclbKb9t2jN8KQCNopbkVMOH1N/gY1r+9rnKI=
X-Received: by 2002:a05:6870:c0d2:b0:21e:7156:a6ad with SMTP id
 e18-20020a056870c0d200b0021e7156a6admr9232560oad.48.1710259507425; Tue, 12
 Mar 2024 09:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfApoTpVaiaoH1F0@Laptop-X1> <ZfBGrqVYRz6ZRmT-@nanopsycho>
In-Reply-To: <ZfBGrqVYRz6ZRmT-@nanopsycho>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 12 Mar 2024 16:04:56 +0000
Message-ID: <CAD4GDZwxS1Av6XNkKnC-pmOWTwuc_u7JRLRkCXO5kJyy6wvwkA@mail.gmail.com>
Subject: Re: How to display IPv4 array?
To: Jiri Pirko <jiri@resnulli.us>
Cc: Hangbin Liu <liuhangbin@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 12:12, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Mar 12, 2024 at 11:08:33AM CET, liuhangbin@gmail.com wrote:
> >Hi Jakub,
> >
> >I plan to add bond support for Documentation/netlink/specs/rt_link.yaml. While
> >dealing with the attrs. I got a problem about how to show the bonding arp/ns
> >targets. Because the arp/ns targets are filled as an array[1]. I tried
> >something like:
> >
> >  -
> >    name: linkinfo-bond-attrs
> >    name-prefix: ifla-bond-
> >    attributes:
> >      -
> >        name: arp-ip-target
> >        type: nest
> >        nested-attributes: ipv4-addr
> >  -
> >    name: ipv4-addr
> >    attributes:
> >      -
> >        name: addr
> >        type: binary
> >        display-hint: ipv4
> >
> >But this failed with error: Exception: Space 'ipv4-addr' has no attribute with value '0'
> >Do you have any suggestion?
> >
> >[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers/net/bonding/bond_netlink.c#n670
>
> Yeah, that's odd use of attr type, here it is an array index. I'm pretty
> sure I saw this in the past on different netlink places.
> I believe that is not supported with the existing ynl code.
>
> Perhaps something like the following might work:
>       -
>         name: arp-ip-target
>         type: binary
>         display-hint: ipv4
>         nested-array: true
>
> "nested-array" would tell the parser to expect a nest that has attr
> type of value of array index, "type" is the same for all array members.
> The output will be the same as in case of "multi-attr", array index
> ignored (I don't see what it would be good for to the user).

I'd say that this construct looks more like nest-type-value, except
that it contains a value rather than a set of nested attributes. It is
documented here:

https://docs.kernel.org/userspace-api/netlink/genetlink-legacy.html#type-value

You can see an example of nest-type-value in the nlctrl.yaml in net-next:

      -
        name: policy
        type: nest-type-value
        type-value: [ policy-id, attr-id ]
        nested-attributes: policy-attrs

It has one or more indices that are stored as nest keys, followed by a
set of nested attributes. Perhaps this could be extended to support an
attribute instead of the nested-attributes ?

> Other existing attrs considered:
>
> "nested-attributes" does not make much sense for this usecase IMO as the
> attr type is array index, the mapping fails.
>
> "multi-attr" also counts with valid attr type and no nest.
>
> Makes sense?
>

