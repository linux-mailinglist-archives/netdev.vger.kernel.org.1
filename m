Return-Path: <netdev+bounces-115312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C4945CA8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E6AB21D33
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F531DE874;
	Fri,  2 Aug 2024 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Xy13Tr2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7871DF663
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596235; cv=none; b=f7Zn2Yfp8aqEMxpHt66k8lHtoSxrX6Bkpqsl+NLsPKPjz+xoRVfYmDMjEPTO6128heNCDZDTTcCUSrFi/2bqMPeI21v0/FQYTir6Vqrvcz+43SZaJUfk/KJ+xP26wbV3SbSF0ERtt8IfFXe+PsbydY0xWvJM0brYdqgvqKvrkLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596235; c=relaxed/simple;
	bh=Aaxu+4vJFANn9tDCXOO0HtQ+OhzaGvUq6lCAch9MFxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUBSquNmuJjYIyANwYfgdfiKO9qZU/+BSj/LcQkdPqdLxpN6a3aSZ0N0xDICeaUkriFa+Ts1fmEHlIgBAwYgCBVpqmtN2TRxX2abR4YI/COz0bl6JWDpsKbMZwV7XKoClQvTlufL//gurnfhdPgCdhkEXGfaI6vPLz81GdMZkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Xy13Tr2o; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso54210925e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722596231; x=1723201031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6KB8/8DxfArJzmv+5wHzMOWqk/1F4Q4bL8WzOBZgro=;
        b=Xy13Tr2otl8v1L+wSEm406sxVDk4H9LZHj6BUAxRM1Jh+h/VRAXpcmGASSLYLZyKWm
         6PwM50DqhJLebyru5N6HS0WHEwZ0nnXqB4HqRq2ziroAx3vh7Vdl5dsEEK46y8Hbyyd6
         x8G4pqWpPnlmqCXFenAiYb6GwXmESSWBdHAOPXJB1ZEuGRkGlV/jIgP9oPYOLtv09JPP
         ODH2vhNpkQk2Lj/liPg4ch3f2OguTJgpGw03ERreNrizcp5wSSV3tQVv4gjaPkEc3XUO
         iW/2Qz7T7jH9FunlBJzB+aNcP/13tWVsQvLxiS66DqchZt2lVlpNgWL8FRVzVQc2Mn0G
         VoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722596231; x=1723201031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6KB8/8DxfArJzmv+5wHzMOWqk/1F4Q4bL8WzOBZgro=;
        b=Rnb9+01+uLvXzR1hQ3k+6GsBX3e6p+H0uvjd15YCyXu7kM6o64omtaFFYWMgz0Eznx
         uXb0OIaxiq2vP8Oq5ivyAkDdrbISOWsOLsDY7Fgv2aFDIxO9L7vX5gT9XTJMvCiCe9as
         0p7xXt0XOVlQS2KNGsr0hXSpb42uLLVoRAdaYHwi0C+FNK+KuOwtqLlFlYrdRzdK5rb3
         8dhxsO1qZTgQLw+ZL/J3d3VPSb4UBESAOQKMLithSsWRxHE2h1636CQVuNrqfomssOhv
         cXLHcjNmMrcT81zxiPVZECFegWLHouzE3V2QYDfMBqmH1q/mg4Ocg+YiLv21r1s18QTf
         TIzg==
X-Forwarded-Encrypted: i=1; AJvYcCUTLlK/zPlzO/YXJOmpPPdVh4KkJdaLNALCRyHS0/vuHkJVq2FkEbLVx1UJf9v+VjNeUx0cQTOik/b+gTtSdqIxuRsbscgL
X-Gm-Message-State: AOJu0YyHzjx6hOWTz+GV81Ygb84e6TmSeP31OOIH6ENizrobpiSRRl+f
	A/QX2AyMOfCVMD8pUc1z+DEfOREK8cKX8jrCTiyWv6cnTV5xGRSSjD/0mMP+UvE=
X-Google-Smtp-Source: AGHT+IFhTEbAJ60vKVBheUvlWpBwtFAFGmQ3uOXIjaDI4/XfMQG1j0u9AKQKWDz7q3vqyPBVAkjvjA==
X-Received: by 2002:a05:600c:a0b:b0:426:549b:dd7a with SMTP id 5b1f17b1804b1-428e6b93992mr16449785e9.36.1722596231321;
        Fri, 02 Aug 2024 03:57:11 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb97fbasm90777415e9.41.2024.08.02.03.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:57:10 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:57:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <Zqy7hU0pBGoXBKQY@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <m25xslp8nh.fsf@gmail.com>
 <07bae4f7-4450-4ec5-a2fe-37b563f6105d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07bae4f7-4450-4ec5-a2fe-37b563f6105d@redhat.com>

Thu, Aug 01, 2024 at 04:31:04PM CEST, pabeni@redhat.com wrote:
>On 7/31/24 23:13, Donald Hunter wrote:
>> Paolo Abeni <pabeni@redhat.com> writes:
>> 
>> > diff --git a/Documentation/netlink/specs/shaper.yaml b/Documentation/netlink/specs/shaper.yaml
>> > new file mode 100644
>> > index 000000000000..7327f5596fdb
>> > --- /dev/null
>> > +++ b/Documentation/netlink/specs/shaper.yaml
>> 
>> It's probably more user-friendly to use the same filename as the spec
>> name, so net-shaper.yaml
>
>No big objection on my side, but if we enforce 'Name:' to be $(basename $file
>.yaml), the 'Name' field becomes redundant.

I agree with Donald, better to stay consistent.


>
>[...]
>> > +    render-max: true
>> > +    entries:
>> > +      - name: unspec
>> > +        doc: The scope is not specified
>> 
>> What are the semantics of 'unspec' ? When can it be used?
>
>I guess at this point it can be dropped. It was introduced in a previous
>incarnation to represent the port parent - the port does not have a parent,
>being the root of the hierarchy.
>
>> > +      -
>> > +        name: port
>> > +        doc: The root for the whole H/W
>> > +      -
>> > +        name: netdev
>> > +        doc: The main shaper for the given network device.
>> 
>> What are the semantic differences between netdev and port?

I'm happy that I'm not the only one in the dark :)


>
>netdev == Linux network device
>port == wire plug
>
>> > +      -
>> > +        name: queue
>> > +        doc: The shaper is attached to the given device queue.
>> > +      -
>> > +        name: detached
>> > +        doc: |
>> > +             The shaper is not attached to any user-visible network
>> > +             device component and allows nesting and grouping of
>> > +             queues or others detached shapers.
>> 
>> I assume that shapers are always owned by the netdev regardless of
>> attach status?

But is it a "status"? It is a scope, can't change. I see you probably
got the same confusion as I got, expecting that this can be attached
somehow.


>
>If you mean that it's up to the netdev clean them up on (netdev) removal,
>yes.
>

[...]

