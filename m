Return-Path: <netdev+bounces-139741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0A9B3F4A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DB71F22F1B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B307464;
	Tue, 29 Oct 2024 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0vYn1wpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0C2F2D
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730162628; cv=none; b=ey9k4ff0dbNUEY1f1rSU1b8gDSB8SUQ5Zo+nzT8reTzxwePt6zyanLR1S10mmzW0C6K8fomWvFmZ5OpnAHXxwSKLyGMKaSHym7HZEsFZ6k5a005Plk7/W/qDswbp5FPZE/0gKomMeQTCv0oTourA9Y6YgkC9sCBYI3MPX1N8Now=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730162628; c=relaxed/simple;
	bh=9tLhTfgxRgnrd5vX9mTfIqZ9z5AVnT23+5X7TAIHcDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnmGt/+MpCK87Z5zpvlSW8y71XSKIhFPsAwiyeBeLTo0uLgSsZOoLRBYZpHpfhudiM+MsyJ+gE/i8HyR3I1B6BwYxSP94/eRudN4pBtk5lMmTG/IVkrqYWyEBmx6WQfufLNoQ48UudHw7iFdAAMlo7AwJqfaKQSyvRT88JMi12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0vYn1wpP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so3906325a12.0
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 17:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730162625; x=1730767425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiAsJKZg1EU97tnI6fvYW6oLoxKOdv+aNsWdM3iYDcc=;
        b=0vYn1wpP4vA8HZaOUPP0Ausx71c00e7M44qU6vLRSnk5fF8s0aHN0oC0yNP+EtqYhW
         bYsRVUN1EzyRgs1hx7G6vy5nFhriF+9D9t9MIUxA1lkO8oWHwMvBzlnxHOBos0hFgrHQ
         DhcBKPRUmGSSfFNIgu11G6MvZaCUnGYUxwphU4oZoMXMJhdJfvdv+Pf0oT6hGVpbHSBV
         4m0CgrPKTWRU+LeFirYjh+Ho5ruRtvRlsB4Apptr++8tUtkacLFpYYTGIGngn0uBQ6mJ
         0ciQi7CfWxWOI2TJekXhOa7cvauPbgmy7S+A8w32CAhhA/pwCtXk4w8p/jC1f0KEIjgD
         EGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730162625; x=1730767425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiAsJKZg1EU97tnI6fvYW6oLoxKOdv+aNsWdM3iYDcc=;
        b=sx6xLEbO0w/H34grC8E75MxRG4hzWnbD920kLxLvt0ZpgPMRSMvDzP/g09Mmmf66Aa
         hVXQjyf/sQuqqcjKICf0BQjfx+eYS0uFhRs2VDGKsifT5GfRgO1zqhgg4Jl7xvLC9YK/
         e8rvYWX1KylqAzoHxRVwHYTbRqIZ3EznvKhlOAWvSHydj3VeYfvKlxUfO3iSaMiTcs10
         8TT6Mx0lTZvCAohff+1IaqwjY+NnhloTwqdE9j+LVRGFm5Clh/uuUoscv3sDqkNOg2NL
         qmLpVJO9Xb4FXZJGq2HsEYxeR4GGAa9sG1NmTdpBrGtHi8/+OuCu3cbfaNtNcm0Cx0T6
         X32w==
X-Forwarded-Encrypted: i=1; AJvYcCWsUwSyBUSN5PDLnwmFhtDRi3Y6tD36DDF6HIAheZeAYBAgVReKBiG1F5Y3rTAz0gu5vg8rUkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyglqFgdLxHdHOMixcxiS3sK9v7GnStlsimTabmemYjF7N3GIDN
	KoDH3bGDoDe2wi0ilnUZTGPA9zlmdIXM/Aj0YsY5MAYUhufk3LA8qKnwVtuJXVQ=
X-Google-Smtp-Source: AGHT+IGSFEz43zl4oICFw5iQCavM4lqBlhdY0ns0gE6YQL3oxk2WG8t34NxBHamOVfnTx46vUBkyrQ==
X-Received: by 2002:a05:6a20:7a11:b0:1d9:c753:6bad with SMTP id adf61e73a8af0-1d9c7536c47mr5539518637.10.1730162625607;
        Mon, 28 Oct 2024 17:43:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1fb5csm6337996b3a.159.2024.10.28.17.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 17:43:45 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:43:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joe
 Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: yaml gen NL families support in iproute2?
Message-ID: <20241028174343.0bc36cea@hermes.local>
In-Reply-To: <20241028170647.65357d64@kernel.org>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
	<61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
	<ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
	<42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
	<20241028135852.2f224820@kernel.org>
	<845f8156-e7f5-483f-9e07-439808bde7a2@kernel.org>
	<20241028151534.1ef5cbb5@kernel.org>
	<20241028164055.3059fad4@hermes.local>
	<20241028170647.65357d64@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 17:06:47 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 28 Oct 2024 16:40:55 -0700 Stephen Hemminger wrote:
> > > I can only find this thread now:
> > > https://lore.kernel.org/all/20240302193607.36d7a015@kernel.org/
> > > Could be a misunderstanding, but either way, documenting an existing
> > > tool seems like strictly less work than recreating it from scratch.    
> > 
> > Is the toolset willing to maintain the backward compatibility guarantees
> > that iproute2 has now? Bpf support was an example of how not to do it.  
> 
> The specs are UAPI.
> 
> The Python and CLI tooling are a very thin layer of code basically
> converting between JSON and netlink using the specs, so by virtue 
> of specs being UAPI they should be fully backward compatible.
> 
> The C library is intended to be fully backward compatible, but right
> now only supports static linking.

Right but now you can update kernel and CLI tooling, and not worry about
running on older kernels.

