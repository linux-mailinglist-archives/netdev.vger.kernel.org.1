Return-Path: <netdev+bounces-139729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA719B3E95
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505251C216D9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79711F9ED6;
	Mon, 28 Oct 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AZRkCe/w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7E1F8EE8
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158860; cv=none; b=RDrfFrg0Q5u0kgRpNFx+x6REYvfnyqBYDHdrL6oynM4Ua+6tp6O7UEBEQyOVPLj3n8Zwjn1sLtZ5sFfyFZFYP4geErZKBuZl96dFpZBotxdx36dpj2gQUnZsbCSyeIF4dsBwvGrlUbVqh182k6/axQffs/+G3gv6KLctZLsjIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158860; c=relaxed/simple;
	bh=JxZm8tFue+h4RS3xueX9NqjMx3IVkcN9YUHvCUnYZCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnNtU3UnPFQg6Z0pxzVvR2xHFb6O+Mjf0m67+ePUB9eOhFsgldHZEFfb+NNJZwKBI7POc/vS4ovo+dZeEvEtfqtV18ZnVpXtADHzuD5v2B1LrjkL1Lz3vGZEEqNLkdkg57o8mj9g6tcKWKYOmXmqg2jxD4iO6Vuw08+F5CFHqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=AZRkCe/w; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso4144059a91.1
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 16:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730158858; x=1730763658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybW9FjJisEH4l8TV+uKRPO2i8Pxbi6QqWneavCQWPU0=;
        b=AZRkCe/wPRxBu8KSTcPebUvnd7CCF3H06YkNBYAlJz5gD5HlCOyCJIgcOTgXxR+7a2
         dgmVo2uEgRjir9OFrsA6b0uOtVQoAiSa8v0jQFcdgfEo8UXSiKkg2qag/tmqX6Ke5mlG
         vXpTc8LawSboHD6fUuFEMbrq5xFaMwoSaQjl3cn+Pl1tIF7r1sDaioADuuO9w7oUJdjk
         bcj6byktosE2/w1gd8aSsksfPYAVtVrbFGWhdB+ds28loLNmKCiU5KisyHl+fEdb0mMF
         91wBrtdZi72ADQSXzRmZih8rp3fUDU5u1yl0W1CJ1PKGlkh8Qc4RUnbC9M1C17z8PJm6
         N0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730158858; x=1730763658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybW9FjJisEH4l8TV+uKRPO2i8Pxbi6QqWneavCQWPU0=;
        b=MBKdXPIno8zrpUBbUlK+LpM6VvyQD8XwXaqcTp9hiX2reL+fOznEWUZ7znWv6G1wut
         y2RmGX3GZRRUZlm+kT40WzGYpVc1uPodd0O6eWrp9UeukO16IcfEqipAbIi3e8H8kfDu
         372MHo9VAgdy8wcJ0LOReG3Olf9wcR2xw0gq7Tu2p0/kszFuvk2lbuwY0OuyeUdDXRsV
         jk9eGKXvkVf7W6J0Ar1q51VU9X6MWIoAmB7tc98WoaAXa5YhDYxRbeiD8s+U3L0Y2tVd
         WM70Puqj0iZTnLV/IKT6SAJjemZtax1wsdlMptZLAx2TWc99/FhtR9cGEJ7DgZCIfvwk
         xULQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzU6baL2ivL6CZG5Tn4YD3QQMGqaPaUmC5ZBx3vAj/0nbLtF+rzUKcLyBvNKnmGShr4GQptNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Qzctj/pRYEsNkyNA71pwFGYzo3KWvFSTwvWUDUbYynBEGXdv
	i9ulF9+0GdwZnBby95ssfJqUic1lfS2ctc8V65VbFZizGIFlYurYH+ZRyj3KUG0=
X-Google-Smtp-Source: AGHT+IHKJfVLreUgz0FhYQfyC3XWz4CgkdpZsDky2uxdFxwniUUKfUSilmsHxj99hhPy4NooyenEaQ==
X-Received: by 2002:a17:90a:db8d:b0:2d8:a744:a81c with SMTP id 98e67ed59e1d1-2e92204d48cmr377396a91.1.1730158857823;
        Mon, 28 Oct 2024 16:40:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a4780esm6405935a12.86.2024.10.28.16.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 16:40:57 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:40:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joe
 Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: yaml gen NL families support in iproute2?
Message-ID: <20241028164055.3059fad4@hermes.local>
In-Reply-To: <20241028151534.1ef5cbb5@kernel.org>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
	<61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
	<ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
	<42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
	<20241028135852.2f224820@kernel.org>
	<845f8156-e7f5-483f-9e07-439808bde7a2@kernel.org>
	<20241028151534.1ef5cbb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 15:15:34 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 28 Oct 2024 15:29:35 -0600 David Ahern wrote:
> > On 10/28/24 2:58 PM, Jakub Kicinski wrote:  
> > > I was hoping for iproute2 integration a couple of years ago, but
> > > David Ahern convinced me that it's not necessary. Apparently he 
> > > changed his mind now, but I remain convinced that packaging 
> > > YNL CLI is less effort and will ensure complete coverage with
> > > no manual steps.    
> > 
> > I not recall any comment about it beyond cli.py in its current form 
> > is a total PITA to use as it lacks help and a man page.  
> 
> I can only find this thread now:
> https://lore.kernel.org/all/20240302193607.36d7a015@kernel.org/
> Could be a misunderstanding, but either way, documenting an existing
> tool seems like strictly less work than recreating it from scratch.

Is the toolset willing to maintain the backward compatibility guarantees
that iproute2 has now? Bpf support was an example of how not to do it.

