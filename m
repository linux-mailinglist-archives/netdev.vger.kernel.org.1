Return-Path: <netdev+bounces-71947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD35E85596D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9981F2CB0E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285A4A12;
	Thu, 15 Feb 2024 03:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2z7DL7d6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE54A08
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966801; cv=none; b=KBs0tRST/3sMpAkQ/otSqic0Ncsphupfg6K4NJ6mfV/4hO/dcy1oYaUHUT8CGD538S7dKB5baXKct/xQX5AMVUaW62Smk/5id/nMJZtjsATL7D9l+jQDBlWbls3mcww1I0yoVBQGKQ85KUC6fQUlsVqg3KIZtuLyqXvWQKRPfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966801; c=relaxed/simple;
	bh=BM+hjLoJWwDID/1haY9OUoFIsZuqmJbOlck6k0VuUAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b13Pkpj7KHvJX32Rdw5NSax6Pusd+6hWJlK79fvGlAzof7wxcT0SXgFhswWE8pjhfWmFuV5zAASFSTnF3IqAhKWogq97O2ERKSudXSfsfL5bizHJIibN9YFaww6Kj2nH9xTzRQ+hDHFaxlLU94DbN3AdVReWEyHlfRaUoXvJMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2z7DL7d6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1db4cafbbebso2336565ad.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 19:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707966799; x=1708571599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvGsQG5GqBrCL1F4JQqtBoDmk02YJ52uGZ2EhlRMYiU=;
        b=2z7DL7d6hEAbyde9o6zYpmnvxSU8Y8Lvl+XPmbzUCfuB4QzazmJjYoSL+t9R3DpFvL
         hv3yQ94zAPt7iJJk/YTwmnns69g1RrKZZTwx8NRU8J4OzMl9Z7EiruvZDMltUTZZ9iCc
         jWS98w0UAvmmi61jTcL3krfoCn61jSYf6LJ9SjnhUon9+6tqGvJsj4cZ9rWebPl/GKo0
         UJUn4N6Lc3dQiP1r78qWds1gMmBtGb3MDauF9gzQ6ko9m5gNd7v3zA1HUYmGLQP3by68
         siXzMn5+e42x1sgYHAgxZV4pjkdeK3Nn1sRvWzcS0DIGGs98lJ/gr1cGJsa2SJHwOuWV
         vbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707966799; x=1708571599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvGsQG5GqBrCL1F4JQqtBoDmk02YJ52uGZ2EhlRMYiU=;
        b=cGvimxK8JmDZOUzFAk3v28PGYzLc1SqJzKo/hsGVM7QLPCNAIgxDI/i02cGdUjfa+f
         gU4rHSJVgfw51Fb3eE7NWADWXZxulb73pLBl+NItBXnRjhy1Bbx7ZXps3ouu+aiODLx4
         D/+jXZYAV2uPrzW66O15Qil/Nos5gRSici8RwaVqMOeRE6HimOJ+ux1nE/34LUIulGgS
         VToCtAafpp3ccl8LLizlnqV7dszeFaicY++GWyuCHT9oVfVdzN1rqwevUWY1UR/tNIwA
         KOjOp+Q68K8a496hq3hPo9XnNau/CK2vlLwq5pP9ZL9qVO8iw8OJB37hPNqJ2YQY65Ie
         zHQg==
X-Forwarded-Encrypted: i=1; AJvYcCWnheUwrEoAQ54TTTRSbay4EIS8+/7l2pTBuGXRtqkbnLSXag8FoQdeLb2X3II9xwoeLASPyGN/j/xhFZkAWgm75AQjAj8q
X-Gm-Message-State: AOJu0YzjcLvNJu9ZyF94J0q7ZS2c3pt8n+pRzRH6WFBcrqT/Eb2t6Jrb
	AdYBEuuXS4d8MMJCgjw3WBAPiy3F0XwMGmsg4Aqd68zM1r3Euz0viMFglbw1qbUk+6Fb7NYch/q
	m3wE=
X-Google-Smtp-Source: AGHT+IEStNSAt2v20SAHV+EfeMId5uixbwSZ3lskeg5wb37Npp7EQs9SudAbxMVyga/gK/UwjaNBRg==
X-Received: by 2002:a17:902:dac4:b0:1db:299e:2409 with SMTP id q4-20020a170902dac400b001db299e2409mr766669plx.22.1707966799646;
        Wed, 14 Feb 2024 19:13:19 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001db3bb1b99bsm162641plc.306.2024.02.14.19.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 19:13:19 -0800 (PST)
Date: Wed, 14 Feb 2024 19:13:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@gmail.com>
Cc: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@meta.com, Matthieu Baerts
 <matttbe@kernel.org>
Subject: Re: [PATCH iproute2 v7 1/3] ss: add support for BPF socket-local
 storage
Message-ID: <20240214191317.0a104b14@hermes.local>
In-Reply-To: <f808ba38-95f4-4741-8193-43e4f2a07c3e@gmail.com>
References: <20240212154331.19460-1-qde@naccy.de>
	<20240212154331.19460-2-qde@naccy.de>
	<20240212085913.7b158d41@hermes.local>
	<f808ba38-95f4-4741-8193-43e4f2a07c3e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 08:54:36 -0700
David Ahern <dsahern@gmail.com> wrote:

> > WARNING: line length of 112 exceeds 100 columns
> > #189: FILE: misc/ss.c:3417:
> > +		fprintf(stderr, "ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %u\n",  
> 
> to be clear: printf statements should not be split across lines, so at
> best this one becomes:
> 		fprintf(stderr,
> 			"ss: ..."
> 

Message could also be shortened, something like:
		fprintf(stderr,
			"Too many BPF local maps found (> %u), skipping ID %u\n",

