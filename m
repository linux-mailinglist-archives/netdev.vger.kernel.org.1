Return-Path: <netdev+bounces-91892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89318B45C3
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 13:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C8DB212B4
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 11:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39964C61C;
	Sat, 27 Apr 2024 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBtbGc//"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2764AEEC
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216403; cv=none; b=nVV1MyEA76AAafxKpoIaXaeq2uZmW6XLSl858iFh9qI0bJrMxpLDiqGA4gvQz49H/QKF77066R310d769kJRtp+WWZCtYarM4naWTrQHP1UWC6WeuBFj/9Pyt1HAudQ0aBzKnQ68hlzRHKkgt4ED9n09zeRKVkUp7QY60Y/qM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216403; c=relaxed/simple;
	bh=IuBrXeOF7Thzw+hEQpwVsJ9JtF8BFUiSTrcS7sknv3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnjg1n6eYa9F9j7Ad4mDhTA4KKO3qUWaGXWp7P60YaCOqo6O/lDGB3Ki0pjy8sN4syqP3+DnVo6ugpP2L1D0tkX9aBzddUX7iXfa5XINMRUKMPr2tIfLx59NhbL+qxdEUerq6NGneEIl5e5tkXjpaULi92WNRmZZd2Wgz1X0+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBtbGc//; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-222a9eae9a7so1496688fac.3
        for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714216401; x=1714821201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IuBrXeOF7Thzw+hEQpwVsJ9JtF8BFUiSTrcS7sknv3Q=;
        b=YBtbGc//z0IBixWHcVvaCr524WR9P4vKgDfluJdUuKsWe+FpOjbQLRQ0t21Mx2HJRl
         6JR7x3gJczwRLJamaJfKdq7aSRGd3GMqZMii3E/RXDGKmA+eWXR/anHbyTKT+pzv8who
         6sacmGbc20T8vKEe4LoY22mdEBsiSUv1UcLxDo6Nb1tQzbkYlRNKZYyMXWHnkMtHL8h8
         wYXSgKQnZq5Gpklotp7gFyoXZ7GVoEpF/ohhN0hhDYjq8h4mrLxuItiFCdnuc42qm1ps
         naSJ6MAXK0jzMe6leyEqG9Fy0KL/f8ziqj7ir6vrQ3NPIxOjnjQVyUKnHhpoTFAqrwVL
         IdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714216401; x=1714821201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuBrXeOF7Thzw+hEQpwVsJ9JtF8BFUiSTrcS7sknv3Q=;
        b=LxolgVTkZhem0PciGJ096XFDCedBHop9CZg8v5tzvKYTU53SuFJWDilreFcvVJkk+g
         CniAhvJkIe1UPMbxHI03L2wosRvhziKDMyhrmh4wMhxu/ypjxi/wiby7hnzqLbbxyBU7
         nCtO+9UNGhQzw8XDSCxRECI3fBHlFFJ2Tk12Ol+Bi6/TKbFjZf4Caj1fvGc65KxyDzNq
         FdlcVPHtWmoXnJdrYbdPeaWalggTRzIi8BRb6F+nzaarEN+Ve9DcUWzLix02EHn4f3fv
         6tk2t1rmP6HTNS3SngkoejuCynnMz80votZXf9/QWv93aLM51pNN76FbgZnXN0q8MwdC
         sNbA==
X-Forwarded-Encrypted: i=1; AJvYcCVvDReOLIpdmvCW5ET46NJmF0qym5RPuoZTWTvt2BdGyp3EMi2LYOauc8qVrqXuVO14645B2UFfEPCrrZNG8m1uFPLFA82I
X-Gm-Message-State: AOJu0Yy4kKdaZZdX+9kiOSfwimOA53xtYXsGDUHdkAI3x9TCgjW5rVzm
	497fnsmZPoGX9hJpyF360yIJCSyWQdF0SibQDvXYFqGijIuvh4KDwGpmMSw/EY5+Vm3uRTVzPbb
	1IE0KgZs9yDbx8HMO5pGq91OgVVI=
X-Google-Smtp-Source: AGHT+IFat6dHR+3jWNQ5mzItz6pd4OdeCwAcAKQzB4b4c2bsDR99vvFqB+RN5zmauU3+Jl1vl+h8ApBPeugTL44Hn5k=
X-Received: by 2002:a05:6870:3288:b0:23c:493:fd29 with SMTP id
 q8-20020a056870328800b0023c0493fd29mr2048172oac.52.1714216401376; Sat, 27 Apr
 2024 04:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424183759.4103862-1-kuba@kernel.org> <20240424113836.4263927d@kernel.org>
In-Reply-To: <20240424113836.4263927d@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 27 Apr 2024 12:13:10 +0100
Message-ID: <CAD4GDZxGiV0fjMhXR7nUMTmmRoN5OiaC2ej0iuktc+5YPo1KOw@mail.gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: add an explicit entry for YNL
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 19:38, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 24 Apr 2024 11:37:59 -0700 Jakub Kicinski wrote:
> > Donald has been contributing to YNL a lot. Let's create a dedicated
> > MAINTAINERS entry and add make his involvement official :)
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Adding the CC..

Acked-by: Donald Hunter <donald.hunter@gmail.com>

