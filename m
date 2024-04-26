Return-Path: <netdev+bounces-91674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8E78B3676
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3E41C20C4A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD2C144D3E;
	Fri, 26 Apr 2024 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jfqmAUK0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9D13C9A7
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130591; cv=none; b=iTA5hfLCNBvKN1m6LwGdLNL8hchlRWVykeJ3By0tYjDvn3mq4ZV9YC5FNX0GudEMiVkXgTm9bzctHVA79yAQlz76Ryf1sVx4LNwYw4dsKY8lDTB2n7WUmomCs6IeGrfkoJKz7z/NPeGzMzq1JzeUkCLSFPB0eBF65fQ8NevqZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130591; c=relaxed/simple;
	bh=cIieqdk7pVtNBY/gopPOPyoswEqfzxD821nCTfYUkDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phtoWSlzQib30+tYm8HCx0/yaNkHgOeZ07UVsFFo6/Ig5yBe0R6Pz1XMzYijCdl3XTgEpJCuT0fGnf+MsYpnq2FNVa+A2SKvNiPwQ3nl+HF4toifvZOrklvD1OmvVlKNKdQfmnjXV1asPZ0FUhjPiemf74MlpaDs6752fByrZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jfqmAUK0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso16645025e9.2
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 04:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714130587; x=1714735387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIieqdk7pVtNBY/gopPOPyoswEqfzxD821nCTfYUkDQ=;
        b=jfqmAUK09suzAaSqZY6lHOwzdqQPh4EopB1W6rEsO8YUS5+e3+DrdCQnd0dg2RaMml
         qNFRCb2/at1jQ/ljwObu07EWaTtZdJol3RRnvkQ48lYpqklSCtdJtqL6F5JTUPDHRSuS
         e1RFNBIjFKnKhUc08ws8G26fyWx0rTqL0XayXhG0XE16lZVCIDJwNGrezZ5U++2PIvBM
         DCoOVdlhMoLV+FqDZvGluRBFiaNRrvq61/sEfRewiwZ2e5tJ4r5uSOJmPjXrw24jDcn0
         6FxuN8ri5r9n2kromQPwdSL5ATEqQLXyGj+TSXnraVJ0snVBrRoszoysGXdU9LWL9P4Z
         CR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714130587; x=1714735387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIieqdk7pVtNBY/gopPOPyoswEqfzxD821nCTfYUkDQ=;
        b=u5QSJpAHURWTTMD3EKpqMUDUf3+MpwVLToxU5DbOPixgffSbyACjhdZwgXAZBCVR29
         RyN53Oa3+lywFeNiswu5pe7k2o3afEfqqKD8gnD0QblBDzEBQe/eWtNuOxYlA2kFsH1B
         cJyAIEJe135l3IUwCg9B6B3HunDBY7CSimlwo+sNL0yDsHLTeiWq0JW+rwgqGVH9p52U
         yfVfQ9yAqE3rs75YtXPiKc7RrHUOO6Ubt3xHF4g0JVZ04oXUECS//JDlnevRvHfrBxBR
         m/kBwQ607/QsD+SXQI7jcErwENuoQjj2awTe49x4LM1MB3pHMwoGumzrGWeb2vogGX51
         wI4A==
X-Gm-Message-State: AOJu0YxUGlVGb6bhZZMocew8/HFZfbn82Z07W5/WJaeadgcOPGoHK0GU
	D5tciWItYeAAfCYlk/srjPsUYuQBSHyJFcGY+QIkag9Vka/jtDT8ckMz6YP6ddp0Uxx8VsVrIbs
	J
X-Google-Smtp-Source: AGHT+IHe3HI7c5VsJyFD/6T4uyU9M13DPBjZBTLPo4xgqGvz0t5srYeu09GplAt0VdYRePork+cWqQ==
X-Received: by 2002:a5d:4812:0:b0:343:eb7d:760e with SMTP id l18-20020a5d4812000000b00343eb7d760emr1441243wrq.17.1714130587064;
        Fri, 26 Apr 2024 04:23:07 -0700 (PDT)
Received: from localhost (89-24-35-126.nat.epc.tmcz.cz. [89.24.35.126])
        by smtp.gmail.com with ESMTPSA id g18-20020adfa492000000b0033e9d9f891csm22391967wrb.58.2024.04.26.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 04:23:06 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:23:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Antony Antony <antony@phenome.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec] xfrm: Correct spelling mistake in xfrm.h comment
Message-ID: <ZiuOmLqOXfPXwzRd@nanopsycho>
References: <Zit-sTZoYp_JnQfd@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zit-sTZoYp_JnQfd@Antony2201.local>

Fri, Apr 26, 2024 at 12:15:13PM CEST, antony@phenome.org wrote:
>From: Antony Antony <antony.antony@secunet.com>
>
>A spelling error was found in the comment section of
>include/uapi/linux/xfrm.h. Since this header file is copied to many
>userspace programs and undergoes Debian spellcheck, it's preferable to
>fix it in upstream rather than downstream having exceptions.
>
>This commit fixes the spelling mistake.
>
>Fixes: df71837d5024 ("[LSM-IPSec]: Security association restriction.")
>Signed-off-by: Antony Antony <antony.antony@secunet.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

