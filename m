Return-Path: <netdev+bounces-169500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C347BA443B3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D8C16C554
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268FE21ABDE;
	Tue, 25 Feb 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXA+Q3X1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984821ABD7
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495460; cv=none; b=Q6GCQlJHK9FZ5Fr1vo5kUzeWKVtHG6miEIN4KPR59ImqL5e8kLBWkFlAlNeUTZebCQhEi96Z1VvGDCX4Np5v1h1o3Ofdb1uy8syUJePFdI7ePTKru6zYzQNS0C8ooOcXY7YKsBa50j1Nju4u7KHL7ZrCWQU7R5m8g535n2Q283Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495460; c=relaxed/simple;
	bh=CAqFA6y4JbW9w59GkEJ1gaDDvrRVrpBeLa2sBJF29/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjOTcDDescugGza+kVSxDxHP9eGqQG7GTwvVsmKb1yZj5zLPevgNPZEAstPSJNGdykfwCqroyPSF69igFLxpty5Kd3n7xmcATr321p8LZakXTb2bhReymcU3uVuqplP1kopSV4fPoJsr5hsC99RUqSAu0xlFG6IwJzFCJ0o2liQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXA+Q3X1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740495456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0eTaUyKKmwzBmmWNAWi2yw6MVmvX7OEMSCRU57SuEYQ=;
	b=VXA+Q3X1PZT7pZ/RZ0qnaCyxOia93mkexdFCzv2PSQTA6T19qavbytI7bE57+42s5CAtKV
	aUXBndemA2UZUlboR/ScaW3GYo1F4Dw+FOhtMJykA8oSibY/HGg0xS9jVTPaSarD1jd2y4
	e+y4lXVRWdThzriuvmSahwAntNuYOaI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-ePjVhSlLPGWKQVDKDlxzEA-1; Tue, 25 Feb 2025 09:57:34 -0500
X-MC-Unique: ePjVhSlLPGWKQVDKDlxzEA-1
X-Mimecast-MFC-AGG-ID: ePjVhSlLPGWKQVDKDlxzEA_1740495452
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43943bd1409so39397615e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 06:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495452; x=1741100252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eTaUyKKmwzBmmWNAWi2yw6MVmvX7OEMSCRU57SuEYQ=;
        b=typ2rVaeS3xx7BGwiXrFEYDJmD0eod//LVmOKEFz7ENBaMN2S4vU3Jb03dg6RTYL0o
         0OLY6/5Nw+v/oRryzFMl463pIisgxrJFEZ5PhGfIV3mH2Ni5pBWDt2k+8JTHT4XrAugf
         Shb0zE1y2KDS49J21sYqQoOTpgli+P/QMQMuw+uFN9bcsKDnAwqkfGO2ZpJxPnrheLw8
         PMqTv+pHwyzsqOE4PQixQeOSGqO3KStnuRZznyN0EMCgC9K23wkScHq18LaQGml7FJRN
         ta1T+Eh2T82tW1sKrd/yqqJ+1Y9zPnk9WKVa99a00rqJvAGazAINN2uPRNovFAiLIXLR
         B8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWSkZaadZfvoJOH7wvzwgXAhJGdJr6gnUWuDKBvkn/Spc/Sw8LyK4Zf9r3E8O3WNGuVSKiek84=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiow8X3chnnozojaM1Ml8LcQB6MXlB5nAF3SxkTUPlbbEYmieA
	ZB5nbnASKt319tFe+hoH5xiq4Xw/hu4s3pOLOIJlo6EQaNKLstJmbKr/HLA8mw0FhVW5LnBgm2Z
	IxSs/PFyF+MhsKetfay9MjByn+7n+hoEkc3w2BBTtAp+7H1/NntuCuQ==
X-Gm-Gg: ASbGncsJIoAevh7FsAZKiX15qu0eRyOj6TsumOZKDRCMTiOhoN7Vy5E4KYc73iLn38A
	MWWv/6BEaSi58czxGqawxUukrD8LIf6nLaABs2mulZbJEPEw977nW9bT/JMc/D44BBGEVsc71CS
	nhZL/oZd1scI1W0TPSvpcxy8UCp+T55DHhqlXtaKT6lE81V6KzWoU7uQPlmMFTBjxjSvgqtv+3e
	+6i7e0Mhlyy64aEkDkJZ3HtbB4DzG2g0zohH1qrBACEtQXcdWI4rNw7R2Qjq5L2zAEuVfCa3lE1
	9cw=
X-Received: by 2002:a05:600c:548a:b0:439:4700:9eb3 with SMTP id 5b1f17b1804b1-439ae1d7ebfmr146363265e9.3.1740495452223;
        Tue, 25 Feb 2025 06:57:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHag6x72kACft9qSE5PDVFj+2F6aFta4HPJLKaXCEcjprFXut3/OkLnYFzi5N0kqs5RS6qwmw==
X-Received: by 2002:a05:600c:548a:b0:439:4700:9eb3 with SMTP id 5b1f17b1804b1-439ae1d7ebfmr146363025e9.3.1740495451823;
        Tue, 25 Feb 2025 06:57:31 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0371b7bsm144145605e9.33.2025.02.25.06.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:57:31 -0800 (PST)
Date: Tue, 25 Feb 2025 15:57:28 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: Re: [PATCH net v2 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z73aWP2GTAfR9X2D@debian>
References: <cover.1740129498.git.gnault@redhat.com>
 <942aa62423e0d7721abd99a5ca1069f4e4901a6d.1740129498.git.gnault@redhat.com>
 <Z7sfmLG4V_kHKRfy@shredder>
 <Z7ysHMi4NociwDgR@debian>
 <Z7y4mpW3vNiy7eMw@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7y4mpW3vNiy7eMw@shredder>

On Mon, Feb 24, 2025 at 08:21:14PM +0200, Ido Schimmel wrote:
> On Mon, Feb 24, 2025 at 06:27:56PM +0100, Guillaume Nault wrote:
> > On Sun, Feb 23, 2025 at 03:16:08PM +0200, Ido Schimmel wrote:
> > > On Fri, Feb 21, 2025 at 10:24:04AM +0100, Guillaume Nault wrote:
> > > > Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> > > > devices in most cases and fall back to using add_v4_addrs() only in
> > > > case the GRE configuration is incompatible with addrconf_addr_gen().
> > > > 
> > > > GRE used to use addrconf_addr_gen() until commit e5dd729460ca
> > > > ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
> > > > address") restricted this use to gretap devices and created
> > > 
> > > It's not always clear throughout the commit message to which devices you
> > > are referring to.
> > 
> > Maybe the following terms would be clearer:
> > 'ip4gre', 'ip4gretap', 'ip6gre', 'ip6gretap' (and potentially 'ipXgre'
> > and 'ipXgretap' when considering both the IPv4 and IPv6 tunnel
> > versions). Would you find these terms clearer?
> 
> I'm fine with the above, but I also think that as long as "ip link"
> types (e.g., 'gre', 'ip6gre') are consistently used throughout the
> commit message, it should be clear which devices the commit message
> refers to. Whatever you prefer.

I've finally opted for reusing "ip link" types, plus a bit of rewording
to remove potential ambiguities.


