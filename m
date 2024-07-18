Return-Path: <netdev+bounces-112070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CAA934CBE
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33FA1F22283
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612613AA39;
	Thu, 18 Jul 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MkQd7xxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837F1369BB
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303145; cv=none; b=gfkKo09IujCpoJa2E/sfoj16YZOTIaWxrvdsAJKHVQjyRH9GdhuCzSPgtcWWyaAts84JXiGFr0QNgieEJJF7cwNTR3EJtA1hAHJ5EHZF2P8ILq3MmYVKdHrwnCJyX/tx/3OJ9bvu3/teVl/osghGrc9IhplJ60s5lwOvvgavONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303145; c=relaxed/simple;
	bh=9OGPBmn7v1HT1nS9fhahCKmtj5g7KxEYk27uNk2Dx/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oblz8INMZD1Q3EWIxddh5L+PJ+7aSgw7oRSlhshUvXhUvvD4PdsjuUYaPpX3uJwIel88bSYyZ1DCGX+ZliGBu9NMGtbe6NR4WPojl/2Et9uX5VtUHgjU4IrarqUFN1PBUefi9+J+GvN2S2llaqLbUgXC/KY66qE36lpil3wFjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MkQd7xxZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77af4cd570so37523966b.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721303141; x=1721907941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OGPBmn7v1HT1nS9fhahCKmtj5g7KxEYk27uNk2Dx/k=;
        b=MkQd7xxZQy7BO1/2k57yNqJt97ibbZth6N1+FF2blJ4tkIL+i22Uad+AY9t+xb0plD
         Ela9CzJZ9Ep2UeVKtLm1bho613KEl9Yh0LYB4YH7aBphO1sJ8eHAW0R8QebTIyKO02Eg
         CScnQCo7ZqgwGD1VFgrgeiUgVi5/qJj/xiAPLC+vM8ThQorJBx2jJNVrqdToxwInLFEn
         CNgTs8XtYomkcIdfyEmtsMQH4SzONAJtkGqahsWDKdiN2l/uJYPaNiLoF6L+v35aOQPz
         BdRpSOIdBZkLtdetU+rhSbCuZgOVMgbii7F3PO4t66umlqO9KPsyT00bOcBD3kmLfYE2
         l0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303141; x=1721907941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OGPBmn7v1HT1nS9fhahCKmtj5g7KxEYk27uNk2Dx/k=;
        b=Uca6KX7FJvqyaaFiYjn64zlZ4Y9qwF9jBQr48Lirss5/ddawtL4789Gl3K6kbETy/r
         AQ2lBce7/oovwBeth/coDsj3WwzrIx1hfsbe8d94VYWHgFAm3tlTbCWu3BItZmgP90kF
         3PjH0rHAUzI7tKVdh7W3xskKX8KKdpJYj7Y+BJXLiIZkiVTVzo9tUOEDuNECr31dxGas
         qouNuY5A4wbkIzLWuUqMRbOZ+i6bvJVC0VB7r8WdxsSVuvCGJR/4NPlKImNudlOqECsW
         tG5ta7b/xNvRy1yYKW7g3OK0A7n8kaQe+r/J2v8bDJ2OEg+ZHt0KzSUm7YcpCoG60GQV
         /3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz4sHqcvXZxtYcs6gtHCunSgOzwg7g4mCIuiJKGXsn692+zdsIl0okw6JCQlNvNr72fCDF8jTXp901KwSteUnZMwGtFMcj
X-Gm-Message-State: AOJu0YziFhigYjFOg1I8Atome/LoA3x2mSpFiGIKZMOpRjthJvgw257X
	Y17xeyi8YF8k8VxA5XHDfOH7su0L0hzRuQS/Vo+3nZ1UbVhsYFevFbkeBRBGb+I=
X-Google-Smtp-Source: AGHT+IHPdu4zw1VmdZAGMAnb4mmwfuXfp/AC8jcealqbCQKkuxjd+WBHJME8aDdWWPj2OW016A3tIQ==
X-Received: by 2002:a05:6402:2108:b0:58c:7c01:2763 with SMTP id 4fb4d7f45d1cf-5a05d2e006amr4622062a12.33.1721303141413;
        Thu, 18 Jul 2024 04:45:41 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59e663e4a6esm5066623a12.80.2024.07.18.04.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:39 -0700 (PDT)
Date: Thu, 18 Jul 2024 13:45:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, michal.simek@amd.com,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com,
	Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH net-next] net: axienet: Fix coding style issues
Message-ID: <ZpkAYdubmlv0jOiZ@nanopsycho.orion>
References: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240717170043.45aaf7e2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717170043.45aaf7e2@kernel.org>

Thu, Jul 18, 2024 at 02:00:43AM CEST, kuba@kernel.org wrote:
>On Thu, 18 Jul 2024 00:24:43 +0530 Radhey Shyam Pandey wrote:
>> Replace all occurences of (1<<x) by BIT(x) to get rid of checkpatch.pl
>> "CHECK" output "Prefer using the BIT macro".
>
>FWIW the BIT() thing is a matter of preference, we don't enforce it
>strictly in networking, it may not be worth patching. Up to you.

In the past, I recall we did.

