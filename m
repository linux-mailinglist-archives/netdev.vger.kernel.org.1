Return-Path: <netdev+bounces-195194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4058AACEC87
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13401899A39
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F741DF73D;
	Thu,  5 Jun 2025 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejlmw1z1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C00566A
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749114147; cv=none; b=Gck0BpAUxi9k+gvnboH24PfQuRIXmhRrgrWHoQwT6UvV6jJwZYdLXAgG9wz9T8T9zsMMud1fOqclC7YXok+VpfwQWwle774EI15nSHzQg69Fgz0xt0VZP+49rnAtaelEhLzQenhsZnyaoGqvflYkx582sGzHgUfXbhx0SuoiLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749114147; c=relaxed/simple;
	bh=0WJE63N/McTrJrZonwnqxKgnTSZwDS5NOeI/UVc/TSQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RTBPrzAOqsBiwqCybCe8y1ZpoKcjJOhSPvj3FitRqaEo5nAt/dBPV8aW4cP16N1uBPXwGOtZkYttdJ1pNvp5qKVflE1KZ2vrzkI0Wj3cXocat77SRumGmvdYjAd9q5XM0xEPzJq6YtIiu/ztYEGdOf+aSuRFLkKlvGiLkLdAmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejlmw1z1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a365a6804eso508754f8f.3
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749114144; x=1749718944; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRFRFFFZ9Ghtq+t1fBzzCHvWAqJQTSpccW5PzImmdyo=;
        b=ejlmw1z157iv4w1XRxN9BwiPsup4lX9EaCCfioJeGtGushHnbnZVHocVz90aYGlT6+
         CTUAOAyY2CBQoOttf6SXSv0QVWvRoDP9BszAl3SELXp2BD5vBP5KOS9FATIwG1SVLo+1
         DX+pymr4sHZQv601wNQQo6zZKGtJMB0kx+6kI/vnxo1ZWZzld2rRy7pXWo+ZPMz9Xaj9
         U/7pzW7JXEWNu/VzV1kxBrZbDbf4AExcHI6iirV0S8FSyH2OaRsGYI2tU6ZcihUhZA8j
         +RX4IP4trfSs/Hrivjq+MjcjJpIua/nHCA2y/JiJ5kHD1Lxy02630aAeR9GLMPOf5Z8o
         JW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749114144; x=1749718944;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRFRFFFZ9Ghtq+t1fBzzCHvWAqJQTSpccW5PzImmdyo=;
        b=Prcwf+lS6nomKq2BcVniRrXuzlJDSDFzM93CguxSNPDxvUi7dgXMxa5fthU8VP4sl0
         lh/+MCml5E3in1vdkNCgAL9bvOE2JGV8gPSqa9pp6TGDbiB2edMyw+hwq+rbF2Oa7EIl
         gEToh/YvqJGkADLZ6mgTDpExhyx029oAXXjfe/5sktjfDgcdwAXo6eXIJaTMFIgRxoX8
         NeLC2+LKc7Z9oimHbFeNngmQ/855g0K0lp28yH8kiRLtnEOFuKjOmJt3HLrhPCGCz54Q
         /bDXmm46z8kAfzi64N+EwBIdfEx2IuvFp9q2vOTm6nzchtZGqmiU2T8Z+kg2X6glVh18
         exWw==
X-Gm-Message-State: AOJu0Yxjpemt3MiTqN/0UB+NouZqaQDpN5spLjQWN2GYFqVdSWf+s8A4
	qk16ISbCUlF6Yc8+rePMDaTHsHKCIBEaosB2gOEUsJq2SmDKxxY1/WGEjKlXsg==
X-Gm-Gg: ASbGncuuq3mxUVQOdk5MuWNNpLB/P2ek7H5D6lz+Hv7BVUZNiqOEzh4V3ffDl738mb0
	FfQqN/KAerEoTSTeIdOMqyfTULyfnIk4nQzk0v0ujkuD8xlncH/sj9mxt2KfcHSGAYaFwChDshN
	NdIBOaPM0fJy7eHG7iCviVI09Gm6n6Q621YOrmzNaD4WxtYMnfkU4nceYk1NYvP0cnsfgZuKUFr
	mbd6azgPqXSLHN3wv2QRbj7L5b4Y11qIyK2hYKJApwzETlQlRoPWj/GySPGkLfnJkeVurLjHGLq
	e69amGnBRzgQkNmt3snANH2nxbNmh12Yk9S+ePQ/B/yKBZPSGM0M2V0lEkjneS8K
X-Google-Smtp-Source: AGHT+IHDbMVQRHBX2YEsmIwefOiro1wMPbXCzpRWhoXU3jkC4dLe/6Nwq+jzeOdhfH6bzavTrSmLVw==
X-Received: by 2002:a5d:588e:0:b0:3a3:5c05:d98b with SMTP id ffacd0b85a97d-3a51d8ef616mr5219978f8f.5.1749114143824;
        Thu, 05 Jun 2025 02:02:23 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e558:9e44:145e:4c8a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b89dsm24213028f8f.19.2025.06.05.02.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 02:02:23 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [ANN] pylint and shellcheck
In-Reply-To: <20250604164343.0b71d1ed@kernel.org>
Date: Thu, 05 Jun 2025 10:02:10 +0100
Message-ID: <m24iwuv9wt.fsf@gmail.com>
References: <20250603120639.3587f469@kernel.org> <m2ldq7vo79.fsf@gmail.com>
	<20250604164343.0b71d1ed@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 04 Jun 2025 10:41:14 +0100 Donald Hunter wrote:
>> This is a possible config for yamllint:
>> 
>> extends: default
>> rules:
>>   document-start: disable
>>   brackets:
>>     max-spaces-inside: 1
>>   comments:
>>     min-spaces-from-content: 1
>>   line-length:
>>     max: 96
>
> This fits our current style pretty nicely!
>
> One concern I have is that yamllint walks down the filesystem
> CWD down to root or home dir. So if we put this in
> Documentation/netlink/.yamllint people running yamllint from main dir:
>
>  $ yamllint Documentation/netlink/specs/netdev.yaml
>
> will be given incorrect warnings, no? Is there a workaround?

I don't see a workaround without some kind of wrapper.

Maybe just add a makefile? Looks like that was the approach taken for
Documentation/devicetree/bindings

