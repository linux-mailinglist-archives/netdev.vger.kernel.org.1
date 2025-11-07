Return-Path: <netdev+bounces-236897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 958CDC41C85
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 22:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E3794E142B
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94502F7AAA;
	Fri,  7 Nov 2025 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPNfiNRa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699E212566
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762551976; cv=none; b=bAFyjra6j7asRdbqtHvWbxoyGuc77x/ZQgY3/vmJvct3vmoXiCcGmFQB+cug69dJz3+5b74g4inHEc/nDSZ0Fs+hQdyURrhTHDjoOKPPZeCu8VR21n/udsY24Klj8O81wviiKQTJwOqJ+0mj4BQgN5pTKsMEEgdBi9ioHsnRsag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762551976; c=relaxed/simple;
	bh=o/XjDTrIKcD9cXUbXOkROCsm+PPweOk83uGSZqOW1os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bzz5eet5w7b0ex1MeMYxsL5ZloHSTGYtXMIwX3ATUjlSmY16YbFK0+Q9wA52UNInaJ5QwKpe0It/Z06JgYRca3mF1NWU66nOW/0usURCUPSqtEnn6ZHe+cxRaumbmpKziz3kxHh3y59C0r89pmQo+25a3DUHSnRbYerapxOPvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPNfiNRa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29470bc80ceso13098135ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 13:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762551975; x=1763156775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7ysPX7lKLPYYmuRKLxAOql9k80PD9eyd6jH7iEqB3k=;
        b=BPNfiNRawjiToefrhbq59NX9ceJGi9vBM37Lx3nb6m8MBiJqeV1uInfyGPmEyoKi05
         hgfqzV0G5j8ZAEcc0oqrDitbGMgE9QVNOzaTOPytc5KF0nNyh08HzjHNwb/Nmg4h4uK2
         j41jk7ubKc/Dtp+t9G2xqnzOKy/TXW6MUUi4H/FZuB+iqjf36ja6lUwKAbapaY1MmDiA
         HJg/oyIyxVGa2DzHBhe8WEj8pbGVvGb+CC0VFea7vrc3MdJKTIlKsYMBQdyIcXObYOrf
         GjZJTaxvhWknYX9yKiqjJ9WFBwI2JSPjCogQirpx/wEZRhoD+G2uHayDIzC4jU77+OIp
         XdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762551975; x=1763156775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7ysPX7lKLPYYmuRKLxAOql9k80PD9eyd6jH7iEqB3k=;
        b=fNCHrwd9JouzEVSYmE8L4/guwjBE5JcNXTUd9OEI5jTrvE2gV0KnB5K8UyxwZ9oNER
         YxtG+SOqc/7VuIKBzxOhc6vNh8GVRBnDJMHJ9Xk3QwYQDS/TJPGulraIjq5+PTQvk0Kk
         jPnRuxLjRIETKl3wSLZspUOun4Vh7/UqdyITHxfJakLQ5FkyqGPysRMhtrXwkhjYoeyW
         Nl0A3tAvQ/qsrz+9/N0tZyTvbnwranAMvv6wDIxSfYzCWoMFNlTnYhVPYYSqvSk4qfaO
         m2msjqWbHWL336HZLsk4fZXeIWeLj7iMW+3ZwJNT0Tl0Ao83K4qAPaZ466++NI6BLM3P
         eqYw==
X-Forwarded-Encrypted: i=1; AJvYcCXJX8Dn808QB6qxbDdiQ0nSD5auaed68NDTiJmaiossr9aph8O2rlyYOofU7t1VWlu8T7Wt/yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGGm7mlnzJQiKVE9AiDHBMmSZ6SUmoEhGXP61sIBL3FVD9dB6
	5bo+ArNomMfC8tAHLwQX2NS5yzwEW2+mjhXWdvMAQgH86xIgbSGexQE=
X-Gm-Gg: ASbGnctYB3PN2Vgl/4nZiakq/v44xJWtBPASW0/Dm41rziwE1K4k06FTSGm6Xo0jR/k
	RJ2wSMZm5yZcjOFycLqgt4cNN6Q6J0eAB17cXr6gfRhwZkIUeWWqwwd/3k6anthrZMgdT+0taw/
	YpLLIDX102l/FEZ9+x9VUi+s2ZgZIIyvFugpNtRiE3hVE3+E7M0XpLKRJHP1ZpAcftBtWJ6d3/C
	SqXMxX0H6laop2RLtV0u015fLKMTOHUbbeaJ8YSy1hF0ztPCWTZXG+4ZPgIw5v0zs+TOUAuB8ow
	gxbr7UG3xHTiWd/4PXwbatv3omx3jPDV2pSQbouWij9ZqdEUrF6Zf8J8KHeBTvUnN7aENBzcIYM
	Q2O9zfiGznQRTg5WvT3jQuLaYUazELqLuALdrkeI9+mmweoyxWpcFgoyepVZ4PAq3bxrsEboQpw
	Qc3ymOeg5rjKBrG/D7YID1V3k/FhAz4OuTDejFoUoXYkIT2MsN0SjMF85gdEEf0LGqScL2sC6xk
	QRzCpNXJoBzYBtinPc7E5Bu6xCh5F6EkSCSsv+t7F1TxDhjmg+cIsBnYdUN3POrjYE=
X-Google-Smtp-Source: AGHT+IHAwPgOFwS9AAPjfN7rd9q/i4mvUY1ODf5jMWB5W9ZL1hzjooluoJ4w8TGCr/rYug0tqsrsZQ==
X-Received: by 2002:a17:903:1a26:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-297e1da7480mr10497715ad.10.1762551974419;
        Fri, 07 Nov 2025 13:46:14 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1b8csm71244705ad.85.2025.11.07.13.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:46:13 -0800 (PST)
Date: Fri, 7 Nov 2025 13:46:12 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, sdf@fomichev.me, joe@dama.to, jstancek@redhat.com
Subject: Re: [PATCH net-next v2 0/4] tools: ynl: turn the page-pool sample
 into a real tool
Message-ID: <aQ5opHKbwoFzSPvZ@mini-arch>
References: <20251107162227.980672-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107162227.980672-1-kuba@kernel.org>

On 11/07, Jakub Kicinski wrote:
> The page-pool YNL sample is quite useful. It's helps calculate
> recycling rate and memory consumption. Since we still haven't
> figured out a way to integrate with iproute2 (not for the lack
> of thinking how to solve it) - create a ynltool command in ynl.
> 
> Add page-pool and qstats support.
> 
> Most commands can use the Python YNL CLI directly but low level
> stats often need aggregation or some math on top to be useful.
> Specifically in this patch set:
>  - page pool stats are aggregated and recycling rate computed
>  - per-queue stats are used to compute traffic balance across queues
> 
> v2:
>  - patch 1 was applied already
>  - [patch 1 (was 2)] use kernel version
>  - [patch 2 (was 3)] Makefile cleanup

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

