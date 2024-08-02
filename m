Return-Path: <netdev+bounces-115378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2C94615A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952162850C3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E51A34AC;
	Fri,  2 Aug 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Pyy5J8SQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76261A34A6
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614665; cv=none; b=tdrkD4U5Tek6VCrc8UvmabzxirfSLd7xC7Wf8kwah1XVVncRs1bfm5K0VVc2Zf8howgJdLqn6lt8kjqF8mbUUaRH2uiQ77KR3x0YUI+Of03Hdt0lFYRGAaki3hhDDKJYAZ4wAxlzNKMqRUXSSdFdeh38BQf38shOAXmY+ztDEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614665; c=relaxed/simple;
	bh=0r4FItFcMzKVjBQ9X4oQhRvuUn3PPzSKNFRWJoWlC6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKK0vH+LhPb+oKBD1tfUWhe+KrwOD3b5JS4yxhUKkbOB7CX2AsVR4NE07LRmCK9VEwaAwiNrRHr6DsEdAVO9fV1gntoLuupFjlcTtjKTCq+x1+wEWtT3lGNejEeFi4cfd5BQZKnqbztP6gDyYyp6CYcdtLq0gLj8ObPwmtNxUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Pyy5J8SQ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso10331151fa.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722614662; x=1723219462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6PFF7wxjqu4WRyp3nk6AjaCI1YCkS+a+FS1AJZO6OE=;
        b=Pyy5J8SQHmY6bTP5kg93BgzBNwd7++FGQKFD11f4C0dGLWkZbGzXa9OTXWk5EmnvxK
         IEyJFCsdICLrBZGxDVMLDJ0tLjtygggjAMQ9PU9+Y57rDzolAWqR/Zy8YTZWSRL/G1/O
         FrxhJrRsIoRmtpqMHeDiLXfCd5KkMo+OLJTgO+MYGkAhtBNsewmELse+p0Yo0jfJ/nDu
         I4JcHRGK045QJYlfUPditrVua83pJoMHz4ye2B6mi5K8b39cMYzpL+WwctkwzWTH6rgM
         9JdDQVLAfs6XGNp9MoACx0B/CCg6wCqNYbKoaTwrjDktqF8pvmwy9i1cGWa/Vfrk8YWO
         yhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614662; x=1723219462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6PFF7wxjqu4WRyp3nk6AjaCI1YCkS+a+FS1AJZO6OE=;
        b=ZoSCJXppYeBMi1AY9bChWsCi2f8JGeSjrZWRcqxFRUGaxIccRCG5D6Fiaaw/H1eeyH
         BGgqWprIxlIfmja5lD7yBNHnEai2pr9lii5bPE8yV3jcC42OyXYo7373dnZqTC4/Ois/
         g/uq5ViV0NbbKTiIR+ra+0vZCzAXyF7nIRZeNfFrj3rCIbk9M3qbYGSIeBn9Oki7iFQ1
         WOy71uCPmmXMSW0Jeq0XTnki7lscqL48zpgbmxiEUgX1DFXZgQ7WCUAWsGjGRQxkmmG7
         MqQzvSwEoG4QkVaWLhRQeSLq7FKmuYAXcv5EsOUnomhmks5vW+2iVcYYumA7rzq89ZWq
         zpdw==
X-Gm-Message-State: AOJu0Ywxowp6DCSjsXWIE/1lqm0LY9dPPxcmPZxXQz2Lup32LEUsVKeN
	0TY04AljqZkExeAEKRb1NeDErFLGq/qv3p3Ql8N01fhoAcNRWrWcOjjnbVJhaWk=
X-Google-Smtp-Source: AGHT+IF/0vfsq6Gt3EjJXq0QmXMJJx6AXG2IZqA3amvWjNG5V4bXeTLDypRMEdY4i7Sris42NC+sOg==
X-Received: by 2002:a2e:914b:0:b0:2ef:17ee:62b0 with SMTP id 38308e7fff4ca-2f15aa8368bmr28899291fa.2.1722614661371;
        Fri, 02 Aug 2024 09:04:21 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d6ce6csm38427875e9.8.2024.08.02.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:04:20 -0700 (PDT)
Date: Fri, 2 Aug 2024 18:04:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <Zq0DbogwAe6JZjCp@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>

Tue, Jul 30, 2024 at 10:39:45PM CEST, pabeni@redhat.com wrote:

[..]

>+        name: handle

I already commented (scope,id) passing to drivers. But in the uapi, why
this has to be a single u32 as well? Why this can't be 2 attributes?

[..]

