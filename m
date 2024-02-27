Return-Path: <netdev+bounces-75376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDEC869A4C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257A328427D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636F614264A;
	Tue, 27 Feb 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fJJmsRjF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A6146009
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047532; cv=none; b=Bb2k39k0EVgOA0Bk92tmwC9U4pErs7H0aXzAw2Z0INIZdeX/1uLrlYVK94CTMpAVpB/6/IIoFlrfZpEhYamb89bxpLrkLK7HgvlXIPEUVB0DhqEGIWXebQGdNC5EiVaFFjDfxtbnYeGO+ksTtoUuq4FX3AKzW4I8I310mA/RuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047532; c=relaxed/simple;
	bh=17f6eAw2Q5YZ2lBTiANOInapi8qxn8g7qVdmAOj4WsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG4tuNizBKIQ2gUymewpLRBgZqlIO3jAAm9jPk78VxN+EN7HaIq68ukxB61TB5bmuHCu/4DuTdCuQjmBOd/eacPI+JqsFMKgFNqM4gS1my17upD0ABXZVH+TzAlXfkSfyszV2ZfCnZzKqgOnGyT6vy/SYRWq4K2NE8jY+bm18rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=fJJmsRjF; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso3538337276.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709047529; x=1709652329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17f6eAw2Q5YZ2lBTiANOInapi8qxn8g7qVdmAOj4WsA=;
        b=fJJmsRjFwfKhjMcbMSAq8GkD/6qZEZtcWLU2v5Sey/GJSt3KbX8kFzv7VhAZGWxthE
         0dFY8T9mGYIZgOW/IXk1OVum6jbhKz3YXe/RLgefAnwWH0pDJVfLzmJpjnN3MELNXtSS
         YyE71N5yoCv7ZKvFqfBIai1+bNisUH24GA8ILlMSMbmdA0RQCQuNeAgYgPofB442lDcj
         xMPapWTmTOjAEEVSSYekZ6bLZ/zQPfl/8Qf7T9LzZa8hQBp8mDyIkwQLASb6t8YR8+AD
         VM4cDfFxQSq/4bRSE1UQ2kQ/GngD66rDuwPx44jIDz6nj2NZw1Z63/f7hSPa0bt9UwPO
         eD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047529; x=1709652329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17f6eAw2Q5YZ2lBTiANOInapi8qxn8g7qVdmAOj4WsA=;
        b=OqPEFZ2DaZMKG1XOOQnpEMxPnZfBeNvBi+4QtXNn1qofdCvN/YkSbz+sVc8A6yBt1h
         Z2Vk3G1Fv+U41RVyKmrWNHIBCEvJBPr1+GbNjpfXYoFF19sM4Mdp4PMa6GXAAQj2+2k/
         FY4GtOLSMHWST6QwCqyHqPbHmUdB6eYVrvfbY8yWxayN/DegWM5plQxhi8gPdNIUG+hM
         BEKsRAMEiBXW5vQMXBt8kYBIo0Ks1++syeEmDvH9Zc3f7R7gJo/4/uDdhvyBN9pS83VT
         8IJBuwI0fyZTMIWSWbUHfYG4+HtYlK5PSy8mDEmRNTItWlLrkiuJePZm63yLK5q+VmPZ
         0ZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoVBYxda7Rdcu9T2amGhSKwqJcMH9HwcgBofs72tp4mvYL/9ktBD0ecPMeNZG11Llci8l7tvpcIPLMBSPGgzYkozv5f0ee
X-Gm-Message-State: AOJu0YwGQYwJWAYPvoUqp1e0KWXV8CESGRnOfrympJ214ndRZhExbpBc
	6Qw+LqFHn/0w0P2SjDb+hdoXcnoQ2iZp0VUainhH5q6qfrEccWyx4DVnBUYTXagHjTOuI019jI8
	Zn1goCcS63f958by25WRPQbAHHUyNC7tkOJjS
X-Google-Smtp-Source: AGHT+IHP2DhSduSKymMNAogcq16iDFRZWW/XuP+wAxatcB57mLpvhZ/MViShQHDoxU7k/h0yMaF3RzpGzhZ4aA0Pc28=
X-Received: by 2002:a25:41cf:0:b0:dc6:7247:5d94 with SMTP id
 o198-20020a2541cf000000b00dc672475d94mr2397689yba.55.1709047529361; Tue, 27
 Feb 2024 07:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
 <20240222184045.478a8986@kernel.org> <ZdhqhKbly60La_4h@nanopsycho>
 <b4ed432e-6e76-8f1b-c5ea-8f19ba610ef3@gmail.com> <ZdiOHpbYB3Ebwub5@nanopsycho>
 <375ff6ca-4155-bfd9-24f2-bd6a2171f6bf@gmail.com> <CAM0EoMkdsFTuJ-mfqBUKZbvpAzex8ws9jcrPEzTO1iUnaWOPZQ@mail.gmail.com>
 <3c5c69f8-b7c1-6de7-e22a-5bb267f5562d@gmail.com> <40539b7b-9bff-4fca-9004-16bf68aca11f@intel.com>
 <20240226070353.79154709@kernel.org>
In-Reply-To: <20240226070353.79154709@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Feb 2024 10:25:17 -0500
Message-ID: <CAM0EoMmL24LxsJ1VOYHuxA=X1uoH+DRhJ5Yvq-h0oPK4mO=zmg@mail.gmail.com>
Subject: Re: [RFC]: raw packet filtering via tc-flower
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, stephen@networkplumber.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, corbet@lwn.net, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	"Chittim, Madhu" <madhu.chittim@intel.com>, 
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, amritha.nambiar@intel.com, 
	Jan Sokolowski <jan.sokolowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 26 Feb 2024 07:40:55 -0700 Ahmed Zaki wrote:
> > Intel's DDP (NVM) comes with default parser tables that contain all the
> > supported protocol definitions. In order to use RSS or flow director on
> > any of these protocol/field that is not defined in ethtool/tc, we
> > usually need to submit patches for kernel, PF and even virtchannel and
> > vf drivers if we want support on the VF.
> >
> > While Intel's hardware supports programming the parser IP stage (and
> > that would allow mixed protocol field + binary matching/arbitrary
> > offset), for now we want to support something like DPDK's raw filtering=
:
> >
> > https://doc.dpdk.org/dts/test_plans/iavf_fdir_protocol_agnostic_flow_te=
st_plan.html#test-case-1-vf-fdir-mac-ipv4-udp
> >
> >
> > What we had in mind is offloading based on exclusive binary matching,
> > not mixed protocol field + binary matching. Also, as in my original
> > example, may be restrict the protocol to 802_3, so all parsing starts a=
t
> > MAC hdr which would make the offset calculations much easier.
> >
> > Please advice what is the best way forward, flower vs u32, new filter,
> > ..etc.
>
> I vote for u32. We can always add a new filter. But if one already
> exists which fully covers the functionality we shouldn't add a new
> one until we know the exact pain points, IOW have tried the existing.
>

Yes, u32 is the most "ready". No need to patch the classifier code
(unlike flower) and the dev ops exists already (and has been used by
drivers in the past).

> If we do add a new filter, I think this should be part of the P4
> classifier. With the parsing tree instantiated from the device side
> and filters added by the user..

P4 will open much bigger opportunities for DDP imo (but some people
would claim i am a little tiny biased ;->).

cheers,
jamal

