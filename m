Return-Path: <netdev+bounces-95358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF68C1F60
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162A4B215D1
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B715F302;
	Fri, 10 May 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOTgADn7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546815EFD6
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327949; cv=none; b=kErGOjKWTZSveDk+LO80NWgD9CFfr4delDw+PIdVCmNB6WRcNLwkxRLO9eJqyJoe8B3wezGQc63t27k/L6pQER4dW7LcHqByDJsLCholWiaTKm2oPFLuBJKiR9wNxeMM6SWmZ7VeACvywH+6O0jz1W+r0ws3nVD8XElP0kItqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327949; c=relaxed/simple;
	bh=WAWB3yzleGK60dlY3yyxOCYdFxCdKfys5HVFDqG/RMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwN1HR+2j3oRtF4apJictkKzVpXlTPLH5otgfOgoi/dyR4buVUJ9lVPypwNdxr3W9D+LhI5SnimZGoRSWHwRkjGi+lxSnzSY1/pvZUQ72UGofPsirNzA56svjeEotRrKOEV+jvJJKYf9wunOl74D7PRgh0XlkAe2G+yb4LFtJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOTgADn7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715327947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iBgOBqKtH65OIYY9wGqTP9jGi4IY4Vn8jlJjR1SaHKA=;
	b=hOTgADn7TLCxEGhmTHtdIB7szFP268Bh9KlMUh0tXffWMUuAYR1iXHxwlPFZMD/iRIm6QS
	TSxp3HXL26trdj86j3xUXWx4PNghEzyL3lLsxfhLvErdR9knbThG+Jj/n1S+bPDI1loCqt
	Km9/r8PAFLLVJnUWtfOVwCVyktkBGvA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-7trKwV57PHergF6djuXdBg-1; Fri, 10 May 2024 03:59:02 -0400
X-MC-Unique: 7trKwV57PHergF6djuXdBg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34da4d75ceeso192825f8f.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715327942; x=1715932742;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBgOBqKtH65OIYY9wGqTP9jGi4IY4Vn8jlJjR1SaHKA=;
        b=kAflA+qvVo74FyK29+xuIOIRTairEZhpoibP8owN00yAPoYYshuSHuiEKpNPFnPvNw
         tOS335vYTl6vWCxOFgCx6SweuNkHSHi5aFJlJa5eXevsPn2mQvZw4eYU7NnttbXzvhiU
         ECnfUBJXpYmY0qd9pZIpKSQCWN6PzBP3lInjqVGuthepclyNnCJhjlPWFqhUmytfKpcz
         KfNVjV3xC6QFHmXcX9CWwhbeT0eMJzi0BfdgBUVuVegm00RrjQThfzhMo9esk6EZe71o
         s8FdHUpLVM6TjdMRu3DBDShp5ycgi4HDGAuPJRDlp7eCdWX1lpfqPuTau4OFycOKekkj
         GhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYa6755lTMuoZr5ibkG/79fpLN/sg/o9mc+LSLiYAYFv4eRezkfpNsBEo4foOXnHKHyTwrCt2GkIa8ytjW2JgrMLXBLk5O
X-Gm-Message-State: AOJu0YzRXFkRDGxSyeBsWYsc/nmxVin5uewY3mCytsy347O3VfeUdmBC
	3+kFCbrhoMOroNW+cKsNaxcNf7sJs4Hw0pTCWchdK3rQNWQotoxTKJF89hiPsfilhF40NxCrwmN
	Q+L/DvFEVe0LXBXJLoTojTSV1iuIohrqo6wfBN5SHkEvnLu8of3Wnpg==
X-Received: by 2002:adf:a418:0:b0:34e:bdf9:32ff with SMTP id ffacd0b85a97d-3504a633257mr1107591f8f.1.1715327941741;
        Fri, 10 May 2024 00:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJwww74zZ8g8VXMs4fuj81k65D7eGJA4qrtAsliRimKcsVbAQUQ6UtC5eAhpb3TrkLIiQB0Q==
X-Received: by 2002:adf:a418:0:b0:34e:bdf9:32ff with SMTP id ffacd0b85a97d-3504a633257mr1107577f8f.1.1715327941323;
        Fri, 10 May 2024 00:59:01 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a77easm3819171f8f.53.2024.05.10.00.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 00:59:00 -0700 (PDT)
Message-ID: <f95b057fc1a8800abf2e04eb08737f198d910e13.camel@redhat.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Naveen Mamindlapalli <naveenm@marvell.com>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Madhu
 Chittim <madhu.chittim@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Simon Horman <horms@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 10 May 2024 09:58:58 +0200
In-Reply-To: <SJ2PR18MB5635CD358F818F1B06556C4EA2E72@SJ2PR18MB5635.namprd18.prod.outlook.com>
References: 
	<3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	 <SJ2PR18MB5635CD358F818F1B06556C4EA2E72@SJ2PR18MB5635.namprd18.prod.outlook.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 07:10 +0000, Naveen Mamindlapalli wrote:

> On Thursday, May 9, 2024 1:51 AM Paolo Abeni <pabeni@redhat.com> wrote:
[...]
> > +/**
> > + * enum net_shaper_scope - the different scopes where a shaper could b=
e
> > attached
> > + * @NET_SHAPER_SCOPE_PORT:   The root shaper for the whole H/W.
> > + * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network
> > device.
> > + * @NET_SHAPER_SCOPE_VF:     The shaper is attached to the given virtu=
al
> > + * function.
> > + * @NET_SHAPER_SCOPE_QUEUE_GROUP: The shaper groups multiple
> > queues
> > +under the
> > + * same device.
> > + * @NET_SHAPER_SCOPE_QUEUE:  The shaper is attached to the given
> > device queue.
> > + *
> > + * NET_SHAPER_SCOPE_PORT and NET_SHAPER_SCOPE_VF are only
> > available on
> > + * PF devices, usually inside the host/hypervisor.
>=20
> What is the difference between NET_SHAPER_SCOPE_VF and NET_SHAPER_SCOPE_N=
ETDEV=C2=A0
> from a VF traffic shaping perspective?

With NET_SHAPER_SCOPE_VF, the user can control VF-level shapers from
within the hypervisor.

With NET_SHAPER_SCOPE_NETDEV, the user will control whatever is really
under the gear of the given 'dev' struct: the PF-level shaper if the
user itself is within the hypervisor, or the relevant VF if the user is
within the VM.

Cheers,

Paolo


