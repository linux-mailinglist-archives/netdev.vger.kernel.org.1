Return-Path: <netdev+bounces-197494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51369AD8CD7
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCD83AF102
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE1A126BFF;
	Fri, 13 Jun 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0HvrRJb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16B86349;
	Fri, 13 Jun 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820252; cv=none; b=Fr7qx/eHawBvr6dYFCimAeSLb6U9UNj92YrqI1TkiVRz4FlFCpf03q8x6I0jr1BZ35mzd0sKo/kYhXV020313NlsmC1g+aJKFGOVEf04OTOW0aErtv/k6w5yVEo8Bnj0UngghhXubr6D2i2YI0QcTvB4HO2DuBKu+gXGlIgMGAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820252; c=relaxed/simple;
	bh=bighsJukvHCmbsxtrGb5PYuln7NuXuTra9dKT6j4s1c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=lwZjbzG7LNuRKF4KU8kuT4QLwZGM072TYG/keytSop1HHlWxJdGBY4kCDoN34KhrVecht441HJFleF6nIypfHjDhcjHDmBwYN4BB5o6AIFguvSolLjo8avda4PsTawgPRmPwlHa3YCxIm2IBDBtcjUZSOaUFmPeBe76+cUuuGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0HvrRJb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so17073095e9.1;
        Fri, 13 Jun 2025 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749820248; x=1750425048; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLilsl7/9YCC/BIaIFPuFIBhon3SF7Um1puCDANK0WU=;
        b=Q0HvrRJbqVopDXVPrXr5ITlLYfTLWIX3RKrAjtBbaxncr75NvI6L/KSvTl+Yg8Ba8j
         ZlHML0kn+v8bo+J/svOiEkx25EgYMNrsX2WsXUwenybzgcj/+0lXIDwstrUQ1o2ozh4v
         cXI7jelz1Vc6bv5vi1hyK5p5SKqBxSNHehGF2Uk3QEK/YINDR9MOA9ctCs62fSvMeOiy
         JFl1yHP5YpLqFNpLYTAoKb8trmKErOaD9yjMRiYcPjchxaLa997PMQb8HXBoKna900hz
         TVO5AvmbwUV8EK/XO1zedahMEPn8/y4zeCliDMVKmnB/6ClAXCm1DvbnHDocbgTLSkcH
         c4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749820248; x=1750425048;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLilsl7/9YCC/BIaIFPuFIBhon3SF7Um1puCDANK0WU=;
        b=O5EkMBqqrj4yeiBnINe5PAYSCktTEM88XkU+txRE6LUl4Efk1Mxt2dSuXNl4cfCWsZ
         9MY/KXJ6HAlSAu9BHzcK4bbUSkOx9jMOf65eCIyfXlJdjCiC/uWqgifH9x6cmiZ5Ns6L
         BifgMq/hLFcL9+X0wugxeHTBbci0OkGhefmmd9hA3Z55YbEmMGcxG2mJofjEvbcH6Ur/
         Sz1Giik7shC9p9nohG8pF77Uwn3fIi9yaBlI2K1d8l7Yy5fyBMNWfpth1OKeGeQYJsOt
         e6LNZqkn7188Sc2Q2rq/5jInGjU02/Ig3klgYrxMeXxS3AUqSWTOiCUwoismsMxRef8k
         o5kg==
X-Forwarded-Encrypted: i=1; AJvYcCVXWstr9yKOBiHMBIAHkAP00buhxlbWt+NmCURxzvLW7//JAfNjazkqrqLrJuf98jt/+ijR4IEjfuNFBp4=@vger.kernel.org, AJvYcCWsLuNYVzHG1QSyGZOfkpMHTIOb48t1MiaF58PBgQTm6YEx8yBDCQK6uk+QxtEEEFU0eTB1bpNX@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDqZxSs51r0DM489hfdVb5ZrvTnN5HlF35jTiWyKvHdlSaLo3
	GBydFz+EcBEKdkH28l5eT7mlqOzwAGc4pdzFix8iUIQe19WEmhGNyb6y
X-Gm-Gg: ASbGncsIReij2lOAEBcuGJMPUa63Rhxe5Q2wANaE5tGcVpHVL3Rq+B1f9AsiM3GJZYR
	UmcMN7IUrWTqED7j5ilB1EMCKF19DFavtPHkPOn2ThHh/ixZNV8xo5ZpbEDbrSvZurvZp6X8EMJ
	AVzRy9J3jsuCg8866AuAOhwYm3AFZ+kWOWI2CRehzE14LMnViE5LMk31TfUk+x9aWHwRFBjw+kS
	rJ0Z0A0bTtJNw54gXew8ntxmdeKz4n7pqAdiOSxTTEe6r4kbEXkPAkCIb6ikZhlVLLV8c9aZDIA
	qIRLUtBCEtD3JBcW4iGyGj6WeoCWbGSNUZ7MdDf3PZrI4xllhodesdYphFl1yG3EfJzgmKpkLNk
	=
X-Google-Smtp-Source: AGHT+IGfVZFiAggq9Aw6BMb9XwyEivoymyFHVpaowGl0cVCFRIr9NgEggsMqUnBqGZmFMU5CQmtjhA==
X-Received: by 2002:a05:600c:5908:b0:453:827:d0b1 with SMTP id 5b1f17b1804b1-4533b235e16mr6682555e9.2.1749820248270;
        Fri, 13 Jun 2025 06:10:48 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:75e0:f7f7:dffa:561e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2384cesm51114175e9.16.2025.06.13.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:10:47 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v3 13/16] docs: conf.py: add include_pattern to speedup
In-Reply-To: <62f2de3a195dc47ba6919721e460a8dd7ae95bc3.1749812870.git.mchehab+huawei@kernel.org>
Date: Fri, 13 Jun 2025 14:02:55 +0100
Message-ID: <m2ikkzlrpc.fsf@gmail.com>
References: <cover.1749812870.git.mchehab+huawei@kernel.org>
	<62f2de3a195dc47ba6919721e460a8dd7ae95bc3.1749812870.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Now that we have a parser for yaml, use include_pattern, adding
> just yaml files from the only directory we currently process.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/conf.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index b8668bcaf090..60e6998e49e1 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -222,10 +222,13 @@ language = 'en'
>  
>  # List of patterns, relative to source directory, that match files and
>  # directories to ignore when looking for source files.
> +include_patterns = [
> +	'**.rst',
> +	'netlink/specs/*.yaml',
> +]

It's unfortunate where you added the include patterns because the
adjacent comment is specific to exclude patterns. I suggest rewording
the comment to be relevant to both.

> +
>  exclude_patterns = [
>  	'output',
> -	'devicetree/bindings/**.yaml',
> -	'netlink/*.yaml',
>  ]
>  
>  # The reST default role (used for this markup: `text`) to use for all

