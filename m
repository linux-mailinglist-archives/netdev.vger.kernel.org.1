Return-Path: <netdev+bounces-79272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643EC878905
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E3C1C20B0D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1DD54FA9;
	Mon, 11 Mar 2024 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="w4AtlwYL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6C40847
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186008; cv=none; b=PObEQOAEtet5RSv7l6QXXg4b1NWAnBzjp7wQbQwcyXVaAhdcFf6bkx5uJGyC0/yKlcr9bnSh1ZtkuiCaizJzZVqfDBz6l9cMCJXM0bdx4n2ZLNlFLWHfg17f/vKLoIwpXXR78okUJwaM5qvsdH4GWHREBW9UQy5u/F56cNXm8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186008; c=relaxed/simple;
	bh=O9VVRULAjwcUhvDhUqr00ZKxfpoT6Ig2yEPT0Jw08uM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+q0ljObVu9ym7mbkiKEcFo871jASjC5DuMuTllPjCfb93wmWc/bCqLiPMmn7ToiCNYEFebBR2IpILhAOsUXEffVYMCaHAk/AdzVsuZV5tF01a3GaNOqq/P00RIMnAXdklD13TV8K/Ab9PVrS6QbkwwAZp2E/FJ+2exNrFbRlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=w4AtlwYL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dd9b6098aeso10905495ad.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710186006; x=1710790806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QW4qrF3dYJC9Jt83dM4tJZJpWXSN0XPQWbIDUth95wk=;
        b=w4AtlwYL8TzLatDz5RD/xsf+SwNlCrMnopZAL3Mp/sdI79wJElO8YG1OE2Z+quRkQB
         9WZ7Lko8XHXtReYglalwkKS1C/Pbvw4iFJDV0RMt+RxgRByhjhWIe/zuO5sRMUazSuJJ
         l9R1qrZhtGoseMfAVekL+hjXimkLRHwdiZOPKlLN1qQi3AScInbH63YMZWnBk7JgElLE
         XfsRYznSNeZ5lmJg9VxsCQ0xkv4jhQJ4ucsLODmxq+kYvFkWq3iRwjHqjuXL9gDkw1HB
         5d6O0YbhvWDNjmE/CDhaXoeZsHsZLa1gDyotu/XfqwUMn/U5C+6n1zab/Mn20iWnvTlJ
         de7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710186006; x=1710790806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QW4qrF3dYJC9Jt83dM4tJZJpWXSN0XPQWbIDUth95wk=;
        b=xMPCR4m1DBLm72SP8JipAWqRFfW5eUBbN8GvCRlkuO+FOkZorTEqsQvPLS08TuPEcP
         06xNRE/sAPr2u2BvEj9bfsqnLpCdDncb3eNbHJAk4vpA292sLIwi2dbmkX7wIjvik/9d
         p64OB6szI5vDUDRiPtUvnXDLikOqPzDvJLzGuGAHoxBLPUA2W6YWXorMrPONccAfr5IY
         JZ9U8PM6ZcFbXt7uRiD+lw/SdhS142E6QxcnRGW84CVlyGtqIXuXTDoXAhQNXIN30un0
         LTdeVdNX1Bg9ryVOGUQ/4RklLXryQisEDJ+nr1jWt3wixfQBON48Hi8bDQc0dsO6r9Et
         CQ1A==
X-Gm-Message-State: AOJu0YwPbD5gqDIroeUMaCqFjvHBc/RcdwZqJZa648m99J4ikGUOHwLH
	oeYnEQWnOTQI0vA/Ul7KHQNDtbpT4uHcDFG+7k9IEkcUqxww0GjEapEFpXlQVfU=
X-Google-Smtp-Source: AGHT+IGA4aBvqBuQuowmadkSQkyYejGUXNJyFF57lHzrMmXGadO042nWtM7AFKFDnWH0uSFSdos0tw==
X-Received: by 2002:a17:902:ee4d:b0:1dd:2b9a:a1b6 with SMTP id 13-20020a170902ee4d00b001dd2b9aa1b6mr8084753plo.25.1710186006099;
        Mon, 11 Mar 2024 12:40:06 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902e85200b001dcfc68e7desm5063506plg.75.2024.03.11.12.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 12:40:05 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:40:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Max Gautier <mg@max.gautier.name>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] Makefile: use systemd-tmpfiles to create
 /var/lib/arpd
Message-ID: <20240311124003.583053a6@hermes.local>
In-Reply-To: <20240311165803.62431-1-mg@max.gautier.name>
References: <20240311165803.62431-1-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 17:57:27 +0100
Max Gautier <mg@max.gautier.name> wrote:

> Only apply on systemd systems (detected in the configure script).
> The motivation is to build distributions packages without /var to go
> towards stateless systems, see link below (TL;DR: provisionning anything
> outside of /usr on boot).
> 
> The feature flag can be overridden on make invocation:
> `make USE_TMPFILES_D=n DESTDIR=<install_loc> install`
> 
> Links: https://0pointer.net/blog/projects/stateless.html

Why does arpd need such hand holding, it is rarely used, maybe should just not be built.

