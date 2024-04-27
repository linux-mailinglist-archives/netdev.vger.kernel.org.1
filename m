Return-Path: <netdev+bounces-91855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F318B4301
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 02:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E4B2847A9
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 00:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC9E54D;
	Sat, 27 Apr 2024 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Xhhec6hw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A7BA5E
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176311; cv=none; b=Q3QFGJyZ0LZvSm6HRdAyB6X01UiD46NEtu+Yvb/MNomBsVnlNQqy3uH3O1cpbgWze9NQcUyZdytLwZaM8D+OgbGHAnvUG95/49+dIAFMD0AVEGbSzQXUetvwT8ZhHhIAK6wadRJNNQU9p0ULnd9wKNUFydxcIKQuaRH8NOR+CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176311; c=relaxed/simple;
	bh=/fd/N7v3qro9nza0VrndytUPmzZi7jlSVwjA4rio/DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb85KjAldxqt8Hzas22RWgwczfdsOXaCm3/3M+S1jjiAKLRLF1GS20RERLgR27goEdN+RGJcYV0xOkU6w6MYfoZmpRzrM/udi7pGO+ev0bXbt4AZDxzPTVJCw5JJPAm2SF6bqYaQmWEfGWi1K0sOE0QfjrqRVKzc8XTuzP4hHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Xhhec6hw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2b137d666so21209155ad.2
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 17:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714176309; x=1714781109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRc2kHVSDrDvqQGDE2B5fMNzoZg6D0PSUdf9JLW6aCI=;
        b=Xhhec6hw769ekVwKoZMZZHsTFAvdFBUYSfIqexVVDLpFIgII/LrTXF5FcVb8HHrbmB
         UBbl8EBptLAhFVL4GYWCZRNBQV0xwUBitta1ci21BI5mspqzLpuYB2SD1QRXGH6WSn6h
         mvrDn6h5Y9Dv6rZn31fqAz0tH306aL90dhdC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176309; x=1714781109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRc2kHVSDrDvqQGDE2B5fMNzoZg6D0PSUdf9JLW6aCI=;
        b=Vd/igEt6LZ9zTfPzMzYQiqhhz0rPXVM23+lRwTi1O3wssTY2RbhPIGENyCrjctfbcO
         6cPy4wPkCMIvUwEQy/MypGivFaHxdVJiyVHpImpXf7kE/71RZgtUHLGFqjKLybS0IDAN
         fwvfQL++E7ROn2uSGolVvBkeqJ+se0NRGIhMMOhwPYhcPwLQWTjuJ04j4PN21hZgrAlB
         x9xIDITi8+1lzV8VIFXihTj70TNRN5RSf3Qtu2O5/UVDDT/13xu+XqXtN31Im0rVUT1W
         +msfAlqG125vcummiMQxx12HbO+kpW6RRm/D/qTj4g7iBzNC62QHy19ZmEXXq6WA4020
         czcw==
X-Forwarded-Encrypted: i=1; AJvYcCUivedB9V7EQ4Sr+3wBkbTS9swUrO5OzPahYY8ZXuYKnl6bLUkVxE1uUfhthQHkiD6M9Rgh3oIjug8CIq3q/aBYxll47kd+
X-Gm-Message-State: AOJu0YxCShWNVyqBzvESkYqC1ouWeT5ZZ213pJh6A5zI3yBJ6Rany5Kt
	37ZYQFEgetgzLm6i5IOABykdIzcpG10ew9aU3CA7C89eFjs0P85avYG9J9Ncs9A=
X-Google-Smtp-Source: AGHT+IFN27qWIbdvnvs9eKXT4KClDm7VytA2q/XzZf3cRRyIQdpg9N4Tfs4AOsINPgBeX9k7ZKTCaQ==
X-Received: by 2002:a17:902:dad2:b0:1e4:9bce:adcf with SMTP id q18-20020a170902dad200b001e49bceadcfmr5001638plx.63.1714176308979;
        Fri, 26 Apr 2024 17:05:08 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001e50dff6527sm15992243plb.269.2024.04.26.17.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:05:08 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:05:05 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net/mlx4: support per-queue statistics
 via netlink
Message-ID: <ZixBMZLq5nPl9kU9@LQ3V64L9R2>
References: <20240426183355.500364-1-jdamato@fastly.com>
 <20240426183355.500364-4-jdamato@fastly.com>
 <20240426130116.7c265f8f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426130116.7c265f8f@kernel.org>

On Fri, Apr 26, 2024 at 01:01:16PM -0700, Jakub Kicinski wrote:
> On Fri, 26 Apr 2024 18:33:55 +0000 Joe Damato wrote:
> > Make mlx4 compatible with the newly added netlink queue stats API.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> Not sure what the "master" and "port_up" things are :) 
> but the rest looks good:

So in mlx4_en_DUMP_ETH_STATS, the driver calls mlx4_en_fold_software_stats
which does the same "port_up" / "master" check and bails out... so I figured
for these stats I should do the same.

Was hoping Mellanox would give us a hint, but glancing at the code where the
MLX4_FLAG_MASTER bit is set, it looks like sriov ? maybe "master" means pf and
"slave" means "vf" ?

Not sure why the stats code bails on is_master but not is_slave, though.

> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

I'll add your reviewed-by to my v3 and wait until sometime mid next week to
send the v3. Hopefully we'll hear back from the Mellanox folks by then if they
have thoughts/opinions on the stats code.

