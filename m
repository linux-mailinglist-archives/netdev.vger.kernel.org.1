Return-Path: <netdev+bounces-229514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A32BDD566
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E5424D12
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EAC2D5419;
	Wed, 15 Oct 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TC9+EexQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EDA22A4DA
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516249; cv=none; b=paQEkpuNeE2dspFDQSD6rRbQe2l69Bi2BlxObYCnITQ/VR3dZZ6M7wA6Ncz6WRlaW+JXVBzsrq/VgUXuqTDx34phDxckSl8si+fjz5Ps0sULpxokwN4Cifhlrkox4+8KFYZouw4k/sxa/MiPBOpjggKILAqJcUUeXqLFiKjaKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516249; c=relaxed/simple;
	bh=I99OPJXDwrfJDD6W3XVippOg5hLK0rl1bxc7/qIm8DM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X0Yyl9h4yUySS+094q6CL2j6lVPxjDT8wzLKjvm79EBB0G8XWQWXUvBkb03siCqgUOg5cus6k8sxkPOP1rZTuZTAnltliBetPsIcHFDxjcXOkgxQtqAhmQ2v0FSNY0Fvw9H23FaoXPVUaoi8hUPOGODMy0+6cuylFPvGbnOJYFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TC9+EexQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760516246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I99OPJXDwrfJDD6W3XVippOg5hLK0rl1bxc7/qIm8DM=;
	b=TC9+EexQaPW3GFXzQGbeaNGdnVueejXVpS1BM0XXf8rch0MRFKAEph04tYRCSqXnBnTfJq
	mHjWvTyUMoY9UM4CCPIe8n2Fuo18HRiCMT6Lng8+4aofcyZJ+1nNmgTRN39x3Y53lZnx2z
	iR8u8WMqtMJfMKu35hjQB3B+U2B3aQI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-oD22EQdPPAWHi6sLcQy2KA-1; Wed, 15 Oct 2025 04:17:25 -0400
X-MC-Unique: oD22EQdPPAWHi6sLcQy2KA-1
X-Mimecast-MFC-AGG-ID: oD22EQdPPAWHi6sLcQy2KA_1760516244
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-634cdb5d528so810147a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 01:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516244; x=1761121044;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I99OPJXDwrfJDD6W3XVippOg5hLK0rl1bxc7/qIm8DM=;
        b=PQuSZG5N4cSxqPvWqmUh3ZVHxYM0NCOsKTjYNxkzkWdZwlYcCrnV6BnnK97d0oum0A
         TRXI9jTfo7xA97QaQGsydzq0kaZAeST2+U6UJS4pqJgLGtrtI65+rpQOgQobGsXi9+jV
         2yn/ZOFUYmW7lh5Be0/7OYBId8BxBqM50oXeS+aDt9Re6o0SzIAUoRgCeJXAq3I4Qe3/
         hpSjm+BeiGtUHt9Fm7dm7/UrmPAlCPtiQ8/2azhrD7Nn5CvTwywjfXWcuWbybCf54yaL
         GIjq/zGHVsSunXj1Ny+E4jeEGHtGNuzC34KATQXVBRHmsuMSpPolWnL7Dt5yK01fTVFI
         60Dg==
X-Forwarded-Encrypted: i=1; AJvYcCU+/jGXKjAxDcH3m3HJwwtHRFqJOTA3gPX6TEUYRuuTzTRVRTLE969cIkJ9iDQDtphI1kwcA3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28ydecXlh7tEPuDVBjj51Zv4+ATRvvvEtNcSIPU+2+z5lLWZP
	CcngTwQKXSFqf479NwUqyA/WTj9YqYoHd9c8lgnNaj29z0iHcKt7WEoVQMMqyzY2F2BojycarrN
	fw88CPm9FiQNME26Us9nRRuuRoVRWrk96gVNZvphhBWFasXUt0QsSvTy2hQ==
X-Gm-Gg: ASbGncs4L0ORmRpmYkEQi14cDSZXRc4vU2NWjKA0b1hFuEkdzkk3ZO+cLKmdenVvXgJ
	RtdxYHRtImkCD5PdWu+5a3USQcrWhXkmgD07RLQ5epEPS0a1ysxDzF8aU7mFlCBXzdRKyx0w9kZ
	LM3LjKV+C6SWNdIRej1/kJQFBdSEGRcJj7ESoFwL2vmWKGryzLwPUskxCLpGCRY/OfYq3QuSBk3
	opVdKEm8OUfwNPS3ORupLmfQbQGbZAmtDiePBEqRi6X6EL5YfCmarm9XqFSRQD0eAjdTG3U6Kib
	F3o+RzmrFqEbvHG9KDShXh5F1NH+x1pSaIuir/3Bgudv9vCVTOCDF3lMd5lKpRsF7Mg=
X-Received: by 2002:a05:6402:2111:b0:63b:ec3c:ee32 with SMTP id 4fb4d7f45d1cf-63bec3cf2a5mr1996782a12.11.1760516243771;
        Wed, 15 Oct 2025 01:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOSv45wrve8A2C+IecYzA7V8NEkK/+TJh6gBW50AnVqRNjW9mGxN2Lyc54wCtXJ8whduwl2g==
X-Received: by 2002:a05:6402:2111:b0:63b:ec3c:ee32 with SMTP id 4fb4d7f45d1cf-63bec3cf2a5mr1996753a12.11.1760516243391;
        Wed, 15 Oct 2025 01:17:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235e7ebsm12700020a12.1.2025.10.15.01.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:17:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 429112E041A; Wed, 15 Oct 2025 10:17:22 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in
 skb_release_head_state()
In-Reply-To: <20251014171907.3554413-3-edumazet@google.com>
References: <20251014171907.3554413-1-edumazet@google.com>
 <20251014171907.3554413-3-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 15 Oct 2025 10:17:22 +0200
Message-ID: <87v7kgfujx.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> While stress testing UDP senders on a host with expensive indirect
> calls, I found cpus processing TX completions where showing
> a very high cost (20%) in sock_wfree() due to
> CONFIG_MITIGATION_RETPOLINE=3Dy.
>
> Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


