Return-Path: <netdev+bounces-148925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E75FB9E3790
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BC6B2D0B2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AD1AE850;
	Wed,  4 Dec 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTu10DPk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8918CBF2
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308032; cv=none; b=qk9gCM5KKkd8zGk3eCcycJISsrbksDIeM1ILxUI7pOpFkCbK555dAOaB9BGISD5KOljYvcHVO6HpRlcW1usz8/GSuqCscHJFRPbo+FOtF4y1fWuUbga/dY4FIMDQuSdrDiHL6qCOwrB3y4MTQI0/SmaZDHo6/g1IK7FGVkW0YzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308032; c=relaxed/simple;
	bh=TcvLj2S2OjDxK6FFIIsAz8V5/hiEAxoKPJXKYM4G2K4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZdGU0dO0/ZNFxQChRMVN3ViI6+TORHikndNXyhrwydg7H55WGBkDq4vZAhY4JDDjaliagy9PIGg+cjZX1rRWdfiGbvRQw1QTouJYqSK6YRJsAgrAOFqrPHGmxVML5fTMByaFTMxoLwJagduDXR6I9IAmxuTG6A6GkdIeiwPALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTu10DPk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733308025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcvLj2S2OjDxK6FFIIsAz8V5/hiEAxoKPJXKYM4G2K4=;
	b=cTu10DPkaZMuj859idm4LCfo+z+ZGb+FgCEYwILtpsq69mnr5taWzgw5qMooCIF9Blt6Kh
	XgPgkIYF3sebDr11jSseDEvxxku2jydcEhVumlyjo46caDjLrG8eTLVwYFComa3NAl7V2H
	xL9SI3JIhAZoaywsAQUjgaq4wXrQ90E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-QctEnXUEMbih85ju2TuESA-1; Wed, 04 Dec 2024 05:27:04 -0500
X-MC-Unique: QctEnXUEMbih85ju2TuESA-1
X-Mimecast-MFC-AGG-ID: QctEnXUEMbih85ju2TuESA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a96889baso37581985e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 02:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308023; x=1733912823;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcvLj2S2OjDxK6FFIIsAz8V5/hiEAxoKPJXKYM4G2K4=;
        b=rQM/+KXLoRHHiJHC6BqDkxgu8d2AsiYuzVumKd1EmOrjXS6e95T5r3eTsppcL/DTNo
         TimF/QsYYAMcaI9pXkxUMyn+GE6IIUl8dFcJhMnQ3pkLj6ynedE7ekfp2w5zljS6gDyd
         Cl0Yw/jPkCpYdhK13OdlBzp9VQVp/iI2DOSn5siTj+5lcxQ8psAtMRufoc98WuXyzbSn
         MFdPSL6OoClQVPeOeKW3eFr/aLkOZ4s4zjxfB8cVWyXyiQHNFk+CKwuRMpeJiEBu3Ljg
         yU7l5SR3gdGF/gjcQIaQEbUzzWY3jO5LMRgBb+uIavOXKkuw4eMgkU7cLPMMyG7Tclvg
         UKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLFQamo3+GTgHiU9yJKT4ZIJFo1KI2gECNS879iD5oEw6WLhayhcfJU621EcAlYxb7kMbAm7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdA4SZPwDsLp6ulcWvmWpxflFScAsgwTyumiMQqnkzQR2NYrQZ
	E5Jiu4hO94z9gXaQ6W49gmA7Q7Xn/ODplMFW5fyURLgs1eAlhSPQtAhtIcxD/3IgK+uBvyizWp6
	l4G4LDdimA677wko+YIrQwZT+tSZIyGCOzYoqPnAiXnQa66Ook30xEA==
X-Gm-Gg: ASbGncuT+nRhzAzyGqQFmbR5I7tvk6WUdT3KSd6G5rZgzE8vB94vFQdb92H8R6OSoRm
	FYXItYlkoSCd5Lh5xwd8LxDEYNryB3Xi9MYVst4po/rm8a5A65y4JnPV+zYl5HUjP3i4XpdTo3Q
	kGN631ia6u5YrlPb/75N8oRUXic80hGbXurFVxUlXrON1P30fKSiEoDpH/o8Gzsi/upuoFrbeuV
	qbXY29IltgHYmLqtHacwYlMyd9SukK5uiWDnWd6B+iKhlE=
X-Received: by 2002:a7b:cb53:0:b0:434:a0fd:f9d1 with SMTP id 5b1f17b1804b1-434d3fcc5a1mr27614155e9.20.1733308022855;
        Wed, 04 Dec 2024 02:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrwtYSrQPLjelyylTwa5mbuvmc0j1pKxbIGN9w4X2omiDFt+X87GdnSjiNK+8A1PwN0nLaeg==
X-Received: by 2002:a7b:cb53:0:b0:434:a0fd:f9d1 with SMTP id 5b1f17b1804b1-434d3fcc5a1mr27613995e9.20.1733308022549;
        Wed, 04 Dec 2024 02:27:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm19322735e9.13.2024.12.04.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:27:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0AA1416BD104; Wed, 04 Dec 2024 11:27:01 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 01/10] xsk: align &xdp_buff_xsk harder
In-Reply-To: <20241203173733.3181246-2-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-2-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Dec 2024 11:27:01 +0100
Message-ID: <87wmgfaglm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> After the series "XSk buff on a diet" by Maciej, the greatest pow-2
> which &xdp_buff_xsk can be divided got reduced from 16 to 8 on x86_64.
> Also, sizeof(xdp_buff_xsk) now is 120 bytes, which, taking the previous
> sentence into account, leads to that it leaves 8 bytes at the end of
> cacheline, which means an array of buffs will have its elements
> messed between the cachelines chaotically.
> Use __aligned_largest for this struct. This alignment is usually 16
> bytes, which makes it fill two full cachelines and align an array
> nicely. ___cacheline_aligned may be excessive here, especially on
> arches with 128-256 byte CLs, as well as 32-bit arches (76 -> 96
> bytes on MIPS32R2), while not doing better than _largest.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Ohh, didn't know about that attribute - neat!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


