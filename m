Return-Path: <netdev+bounces-196209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA492AD3DD7
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8664C3A155C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A310A236A88;
	Tue, 10 Jun 2025 15:44:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8B201034;
	Tue, 10 Jun 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570242; cv=none; b=nmEpNEUE/yVOmotFouDP1+BlX6fZjl5Js3f5ZxFJn4HacsURsqiJa2L/2OQUbA1PjKCYcFe+mYuOhrdNMwSn5aaGXY6s3FZXI5xz0nIwBCtSMDTEadP0m1oy63iXYb+4VSuqKbUIIjXaorn9tQNGWpwdpumzd4dRVtIyXx4PtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570242; c=relaxed/simple;
	bh=FpHd5k/WuqGkFa8AqlRyJwsexbf+fo2WnOclxAlQJgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsGmBX3dRtV8cacwhrz0t2VcbCLsBpD4VtGjz32gmRiWa6bSt3Q2MbBVAQWEjKqGCx4sfye2s/07r8YvTx1vR5peM2fxq82ZuGyhnrATQo8s+PhqAORfpAkCwlNdGI6ztao+ogB0e8fRYw162MhiTDpQWwC+kYQOs5TCCd745xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acb5ec407b1so1009452466b.1;
        Tue, 10 Jun 2025 08:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749570239; x=1750175039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuDaN3v7IKjjOwPuI92C78hEQA3//blEo1hg6ajXKJQ=;
        b=q6UIZiqG4f1V73zM6C8/7eZjhty/VQILej1SeBZrFr83k98g2lJcsFJ4cQ81sIJDhJ
         YRuxgqcIfr/srXxZZV4c1YppgfR92HWmlar89KjFOHX7NeS5ftHH6zSQRGbt0fCYXExM
         OknpoPEGT9XSyNXSJqjlVjKYV6kYorWSSi4U9Y+8WJaiQ7zfChGrZbWNJ3Afn92U1icb
         4PF3rxEp90uxBc69dcHGsshkR2raRPENbCtOaEM+jbGDKvxJ1WF9lmaw+NvTOhn1Fg8F
         tJWUauRAE+nT9JsuWPzSVdWHyeSFaRJMUMwnGEZTpgC1qXdEEZYg0Jl69P0uLxqy9cAo
         kwMw==
X-Forwarded-Encrypted: i=1; AJvYcCU+3raEqor6JcEX9mXibfjVaFqef2AjaN4j8JMvqitS9OIf8HBUf019xjcnbV/DFM3XfYmcHK9f@vger.kernel.org, AJvYcCU1qrgyQLo7BILe2oBQNQ1Z4g9DMS2aAnDttDlCs5GYMazLZ4dcx1mP+SnSRsKX/ROUee/buMo03h6b4+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16E1+ubH1FLzMm2LqrEzTqQ9iy3EeFJNiE7Bk0YHMIhh0N1vQ
	udMZqI6SzUPK8BpezXMGTWRIqZweJ+OtBvRiyqi1w0bRvmlsERv4G20S
X-Gm-Gg: ASbGncsm1OLxmRYv8t29kGGwQ5QJBWaljh+ulrzLTXgHH86v8Gb7HFrTSLz25+gaWNH
	DYmkZCmzhq71K6XSgM5XtrpEKy8/c8QDItq44KdsgpH6BSt19vSmNxLxF1VY5tVhjAnKuBF+N6a
	RIDpxYr7DITZ/S5W1P7h77j9xI7yPAVeTvKDiMrGObCx/BNKA8T5WuufXt9RYrrF8eZnahl7846
	Lg1lnLB/OQo2WZu9T8xE2yjMksAipkdFKatkjtJcU7a44jAZPgntuirMqm2cvcU2r1CLT4/VuR7
	aooCmJr1QYyb40rS7cP6LbJ3XnB5NbXR1vnZPtXOIv6YPZVXExy5
X-Google-Smtp-Source: AGHT+IH7vBoM84CZWFqasHt9KzLiG9LovQysp/riPIFgA4hZQCuVBAr5gBWic0qBZysBWtn+fw9E0w==
X-Received: by 2002:a17:907:608e:b0:ad5:c462:3f60 with SMTP id a640c23a62f3a-ade1aa93187mr1760955366b.16.1749570238942;
        Tue, 10 Jun 2025 08:43:58 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc76feesm738828966b.147.2025.06.10.08.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:43:58 -0700 (PDT)
Date: Tue, 10 Jun 2025 08:43:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Marco Elver <elver@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jan Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Ruben Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: Re: [PATCH 4/4] docs: netlink: store generated .rst files at
 Documentation/output
Message-ID: <aEhSu56ePZ/QPHUW@gmail.com>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
 <5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>

Hello Mauro,

On Tue, Jun 10, 2025 at 12:46:07PM +0200, Mauro Carvalho Chehab wrote:
> A better long term solution is to have an extension at
> Documentation/sphinx that parses *.yaml files for netlink files,
> which could internally be calling ynl_gen_rst.py. Yet, some care
> needs to be taken, as yaml extensions are also used inside device
> tree.

In fact, This is very similar to what I did initially in v1. And I was
creating a sphinx extension to handle the generation, have a look here:

https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/

During the review, we agree to move out of the sphinx extension.
the reasons are the stubs/templates that needs to be created and you are
creating here.

So, if we decide to come back to sphinx extension, we can leverage that
code from v1 ?!

> -def generate_main_index_rst(output: str) -> None:
> +def generate_main_index_rst(output: str, index_dir: str, ) -> None:

You probably don't need the last , before ).

Other than that, LGTM.

The question is, are we OK with the templates that need to be created
for netlink specs?! 

Thanks for looking at it,
--breno

