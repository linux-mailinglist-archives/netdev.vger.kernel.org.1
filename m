Return-Path: <netdev+bounces-104721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B71B90E1CD
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 05:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE4A28446E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E43611E;
	Wed, 19 Jun 2024 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKFqd0bI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71F80C
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766164; cv=none; b=hMh9/daj7obMwFKW6YoyI67RzoCZuqCguqhn0rKw9of+29tjeGcjLqBVKa+PYklzsaqjFJozJSmGEgnTAP2sF0EBpBjxdJKGVIAdJHXL56SYHxBbxsF6Vx5z+ukkynjXBrKoMW6CGXyewdJGMnQrxh/MEcxaYo6ZYaOSB5OjKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766164; c=relaxed/simple;
	bh=j9T/55gKTpCQ9GamXf/p67Raj8eZldtWscLzwaEC1k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDxSWkt1FWJv/oKAes1GMW2m8fYG6o5qnX2IoQFgUcRuWg+jr3LiIt5OtQ+1Asc+zJTeGKVrZKMFa/vYcZaZ9qqCNCpPva9QObD/QVhtcRquvAWOzu6BZCD23KP0WFqEUXiX7UFFZj3W847n2Sq38wNb7L6MJN3E3BtNj9KvMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKFqd0bI; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6316253dc2aso55868027b3.0
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 20:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766162; x=1719370962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kEnL84BRYQzfmddI+IXOSsvueIGpY8TeKXjkd9W/Y0=;
        b=EKFqd0bIy4WGe88ztWJKoz0zlllhk4eYizmDe9axPOfE8pcdYEHNyQPBxNadv4M2f3
         N1Ck6sljLd/R5ZMD3i1KtP6BGfSlK2xOwEZBsAGT0MvwS+lc9Mb1igdFYrodzPEhJuK0
         msi1DAin2KtBQU6hdElaT96SzgfZyUTci2vBPvl1qdarccKoNSN7FHLZ2e9/LD3wMghX
         neoQpQ1F6je4P9ravaETXduJ6bGk8IfWjXsdElXxFxkWmJtPIJpgOyjGNeFmuAPdy3N8
         v1ECpLvzCkOuzgy6otTsQ9+LAxvqBBfo7iU0G3Qvkpl06hYuJqaNMIDPnTnUkyrsRGG+
         /CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766162; x=1719370962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kEnL84BRYQzfmddI+IXOSsvueIGpY8TeKXjkd9W/Y0=;
        b=h1YF0Jw9gXGUDxhxI9To9VvpmNHaS0tgOYAF/OKOeq+4JHDpJpT/ah30GH5aLETZsC
         ohP4u6xpRbwOmk6MX87YzVSYp/7roGb6eO4bZioc/0Y6QiLiCDmtEBKe7lhtfMFtpi7i
         5zNA4fPYfJG0olyhqZKBupDbsXwdncd7k33T0//3vgN/Tvqx9VWT+ktpP2oWtQ9mE9dY
         R1pEqDS8nauyK2nt3wm97aIBratLVhOZahNuBWcFECMtr/MZKI+Rn14DXVW9nNkAin1t
         DsSw5DQ+3TpkXzH05og7OU6s2iXbUVUxxsoVV5VOzGJM4KGZhnvaKklU2L/eA7cH3KIS
         UOGg==
X-Forwarded-Encrypted: i=1; AJvYcCVwOh/WoxfC7YF1CpZOVRPc926CQi1FZkNVXK+dDC4V5cT47FUK9fCVzHb+YbpvQhIhEvgTnVZjxGXF8MSdiwjjDRv1Pawz
X-Gm-Message-State: AOJu0YxQ8do9Oj/nR9mG++IYUDPAmF+Tk6OSgcgtm5hAGBEBBpaES84/
	g9P5/Jg7ANSTcKxnoGYZbh3Ka0odvhUeBuTK2uOubI41I7isgzovcveWhRw/
X-Google-Smtp-Source: AGHT+IEOVqygIwoXqK8JmYPIWOCuhcWf4afSlT6kQa+VnjBZRYwZ/ZhsAohTxrAO3Vcex7qahIKvgQ==
X-Received: by 2002:a17:902:d50a:b0:1f8:6971:c35d with SMTP id d9443c01a7336-1f9aa47e82cmr14346725ad.68.1718766141492;
        Tue, 18 Jun 2024 20:02:21 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782c:cfa0:b84b:f384:190:dd84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9a38630basm12958585ad.241.2024.06.18.20.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:02:21 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:02:16 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 1/3] ip: bridge: add support for mst_enabled
Message-ID: <ZnJKODji2Jgtsi2g@Laptop-X1>
References: <20240614133818.14876-1-tobias@waldekranz.com>
 <20240614133818.14876-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614133818.14876-2-tobias@waldekranz.com>

On Fri, Jun 14, 2024 at 03:38:16PM +0200, Tobias Waldekranz wrote:
> @@ -169,6 +170,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
>  				bm.optval |= no_ll_learn_bit;
>  			else
>  				bm.optval &= ~no_ll_learn_bit;
> +		} else if (matches(*argv, "mst_enabled") == 0) {
> +			__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
> +			__u8 mst_enabled;


Please use strcmp instead of match for new options.

Thanks
Hangbin

