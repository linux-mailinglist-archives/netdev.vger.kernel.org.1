Return-Path: <netdev+bounces-59441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F037E81ADD4
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4C11C22AB1
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FA6522D;
	Thu, 21 Dec 2023 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="A8DXw7fR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51C8F48
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-35fc16720f9so1752025ab.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 19:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131032; x=1703735832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q8HY+10Q0F7aYu1nHlk9ehZOwWTmpbZYMvc295P+v0=;
        b=A8DXw7fRq8vocRVOElHKg4Ery7Wji9NWFwPZS2TuoSgl63u2aY/1hUiarFGr6Q8M3J
         mdLD7kQk+zVfxRMCikMNuGIaQmqBd3unWbm0q5Sze9jNSaCgNOuoxJVVfrFImUqWbHJx
         q7fWURmwMRKrz8cbUl6VAmEDyvND9ZidE0xkCLqJrMT4hXXeEM2EGnolpVnVGVUZVkyc
         gUbQqrmKbewkTCHmL1ldVL76B3zyTm+hbomBZWZkzsB6fvqhbNl3rhfb72+/EoR9y3oI
         sqeBAc1nnu4jTz13+HxYnqaAUjyQaMlZrkrE+IFz4JGrHOqJqEBCrxXxZkEE0/hbECmZ
         BBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131032; x=1703735832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q8HY+10Q0F7aYu1nHlk9ehZOwWTmpbZYMvc295P+v0=;
        b=M9AEdLe68gdDNkot0Poa5ozBCZGjqOfuKId3EdMoJt7aNs0EBaxTcIQ3oyjvp8gv4J
         fAD+fR6dD6CfZfQ8XcmYWcFWLm+LjnEK/HdNayrSSADi9Fyux1fwVAwtqQVosexz43ug
         ssbxdveYgZsb3y9JwCsKlyv+wpChPEsRFB3VEGDkhowOB4DlFrR/yIiTTa8M9fpoza2k
         N+DRxEJ+R97NMdhgHL7No8ajRAxi/vo/1QCBa0AhZSbFT5ph4a9kn28RXwhcwHlsKuFm
         4+nzJucqXgctKjaAovRdAOQOh6oeSmu5T+R2PNue8AiFqZoo6WzaNLDQJn4oWhIDBHiB
         xesQ==
X-Gm-Message-State: AOJu0YztsS+zFTaUxNZNe2IeS5/iBRyodQ71hucI8zzs/hfued8EtoNP
	oN5Sci/E/49FO81mK61Ib9h8lw==
X-Google-Smtp-Source: AGHT+IH6Ht0U7E2BTcL5T7fWM0Zbux1/n/jRSutybd2asggTKjqSaGbzl9wM65TDVhAEZfFsfiSw3w==
X-Received: by 2002:a05:6e02:1646:b0:35f:754d:fed9 with SMTP id v6-20020a056e02164600b0035f754dfed9mr21065820ilu.37.1703131032474;
        Wed, 20 Dec 2023 19:57:12 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001c9c5a1b477sm498572plz.169.2023.12.20.19.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:57:11 -0800 (PST)
Date: Wed, 20 Dec 2023 19:57:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 01/20] bridge: vni: Accept 'del' command
Message-ID: <20231220195708.2f69e265@hermes.local>
In-Reply-To: <20231211140732.11475-2-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-2-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:13 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> `bridge vni help` shows "bridge vni { add | del } ..." but currently
> `bridge vni del ...` errors out unexpectedly:
> 	# bridge vni del
> 	Command "del" is unknown, try "bridge vni help".
> 
> Recognize 'del' as a synonym of the original 'delete' command.
> 
> Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>

Please no.
We are blocking uses of matches() and now other commands will want more synonyms
Instead fix the help and doc.

