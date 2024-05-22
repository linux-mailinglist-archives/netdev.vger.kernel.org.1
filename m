Return-Path: <netdev+bounces-97507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB88CBC9D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05A42826E8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D607E79F;
	Wed, 22 May 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTnDaJvJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50467E56B
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365090; cv=none; b=FmltbpP9ef0Xx5LE6N2na3bNHjhMGgxG9vD+m55z03TrScgxTrOaBkA3lzOi+24okCgDcKL7ghZrccDItfwDBpj+2OMziG7SyUd3227yzgIYugzfXCfxbGMlMoXLVlbAuNTM+TREedUukVLlXj57N7QFTkRAacPGMYC5Muq86Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365090; c=relaxed/simple;
	bh=0ylwNkfZakSZvZIOpHZOzWWp2JYNJ7GMyYalGfEUXr4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inK954YUSKZYJxsemKbAcEIrRwSbf6NwoQWdGcZCGyJyRo9OH++NgggEMZpuCORf/CXZuXXth6x4li6PiViRQNyzpSpbr39BGRVdTBevs5q+ncbTucJiJ6x6OxbF+mteRM47YX7cg4SahFeE1ZQp50snsDcglSyHW43goysr/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTnDaJvJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716365087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0ylwNkfZakSZvZIOpHZOzWWp2JYNJ7GMyYalGfEUXr4=;
	b=fTnDaJvJ2xsLy2zAqnmgVDdlWEHwunMljmfSWyxdQQ/2PYSCeMg84CLZ8yAyqLg9MAPrpL
	aS57jRzo9ymj9C9qqrZEGmbU928nW1B3oCA5jHkoceKe+WDtCBj+nzUG0qbAuC+IIIdYHK
	bO3g0eBCZfZeTYUXhs6t3Yc0jShynV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-fNPfDV9gPWW79NIt65BcCw-1; Wed, 22 May 2024 04:04:43 -0400
X-MC-Unique: fNPfDV9gPWW79NIt65BcCw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34d74db6f1eso1562033f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365082; x=1716969882;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ylwNkfZakSZvZIOpHZOzWWp2JYNJ7GMyYalGfEUXr4=;
        b=HAwfUb66fDsz3d5nxnD6/uPyYbxPU3hYRF7NHjghib1Fo7dAHrk3G2K0tJLW2ZjePN
         xr30YVxT54J4uIqDzOXWUv3V3Gl1W5Il3lsJ8W37NkuVQThEkM4pcbcX5DIDjEcQWCQ1
         qj9vh4OZV1ekq40eeyaobsWuqxqsJvW7C0W+z+OcF40cA/UaAyMmIYzHNf8xGqsOxt04
         o07M+fV65mIHZThccP60FX3YzWjkdUBCDo1Uh4S2r1PsdMERLIBOQ/gkWf1ZDlf9+c+P
         cFjprlpR6cgc2oE7OGG6pstP1g9WW2njeFAyCtj6eK74jvKq8jbP5P2jGghWIlshXFv0
         7/Og==
X-Forwarded-Encrypted: i=1; AJvYcCUWQbTEfCMlP75NkknqRlhlbPnFNDi+j5o+fzB0f8fZNC+GLZbyTtdQGH17LymoEdgiyUBCR5Xu6DOXmUFkJiFZ6CO4RN+O
X-Gm-Message-State: AOJu0YxwNuIqrhffSOauYfDH6aSqJQJKR0cvnGBhtpl6/vzU6BLHSmfR
	7S4G+rAKDKDpqUeKstyvg894FFG/jdHX/A9p7hcjfa38cjtLpgxQokdmVoIrF7Wt7ulQsE04udS
	apsYIrCG/8+HopJVIHpTGoG8H3ICbZ6oW5n+7peco+7hqZXx0espv+Q==
X-Received: by 2002:a05:600c:3544:b0:41b:e83e:8bb with SMTP id 5b1f17b1804b1-420fd376c84mr8463785e9.3.1716365082610;
        Wed, 22 May 2024 01:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8l3F1jRwb7AuBVBTPa+paInKsJk/sH88WkGvifJ5RhK1OYdWgMvm5pdCBrS+3PiUmP/hEoA==
X-Received: by 2002:a05:600c:3544:b0:41b:e83e:8bb with SMTP id 5b1f17b1804b1-420fd376c84mr8463245e9.3.1716365081564;
        Wed, 22 May 2024 01:04:41 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42009eda143sm422203285e9.14.2024.05.22.01.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:04:41 -0700 (PDT)
Message-ID: <e257de5f54d361da692820f72048ed06a8673380.camel@redhat.com>
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
From: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, vigneshr@ti.com, nm@ti.com, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Kip Broadhurst
 <kbroadhurst@ti.com>,  w.egorov@phytec.de
Date: Wed, 22 May 2024 10:04:39 +0200
In-Reply-To: <20240520201807.GA1410789-robh@kernel.org>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
	 <20240517-poster-purplish-9b356ce30248@spud>
	 <20240517-fastball-stable-9332cae850ea@spud>
	 <8e56ea52-9e58-4291-8f7f-4721dd74c72f@ti.com>
	 <20240520-discard-fanatic-f8e686a4faad@spud>
	 <20240520201807.GA1410789-robh@kernel.org>
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

On Mon, 2024-05-20 at 15:18 -0500, Rob Herring wrote:
> On Mon, May 20, 2024 at 06:17:52PM +0100, Conor Dooley wrote:
> > On Sat, May 18, 2024 at 02:18:55PM +0530, Kumar, Udit wrote:
> > > Hi Conor
> > >=20
> > > On 5/17/2024 8:11 PM, Conor Dooley wrote:
> > > > On Fri, May 17, 2024 at 03:39:20PM +0100, Conor Dooley wrote:
> > > > > On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
> > > > > > Modify license to include dual licensing as GPL-2.0-only OR MIT
> > > > > > license for TI specific phy header files. This allows for Linux
> > > > > > kernel files to be used in other Operating System ecosystems
> > > > > > such as Zephyr or FreeBSD.
> > > > > What's wrong with BSD-2-Clause, why not use that?
> > > > I cut myself off, I meant to say:
> > > > What's wrong with BSD-2-Clause, the standard dual license for
> > > > bindings, why not use that?
> > >=20
> > > want to be inline with License of top level DTS, which is including t=
his
> > > header file
> >=20
> > Unless there's a specific reason to use MIT (like your legal won't even
> > allow you to use BSD-2-Clause) then please just use the normal license
> > for bindings here.
>=20
> Aligning with the DTS files is enough reason for me as that's where=20
> these files are used. If you need to pick a permissive license for both,=
=20
> then yes, use BSD-2-Clause. Better yet, ask your lawyer.

Conor would you agree with Rob? - my take is that he is ok with this
patch.

I guess this should go via the net-next tree, right?

If so, the net-next tree is currently closed for the merge window,
@Kumar, if Conor agrees, please repost this patch after May 26th.

Thanks,

Paolo


