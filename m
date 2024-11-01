Return-Path: <netdev+bounces-141015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1408C9B91A4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3E11F233FF
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABADF1A0716;
	Fri,  1 Nov 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZb2NAQq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83E19F117
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466824; cv=none; b=cXJchAIhR8Dh6awSIvuHDgyqhBiY33LCEGcbb7HRwKSQ/KilGpSEfsGH2lOjduYrq/dcazUhSAbwkK3GoLgLkJ5ko/w4nBocWip16m03T+H+0yTkOI7A+b0gbAVfenWnCyUNBQQ3qQeGFGyAjzjJgey8TpnmEe55j9YOmz+AP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466824; c=relaxed/simple;
	bh=L5CVurix7+30nzpI9IV03X7MQodXDpgxTJqDlhMhtTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g9sJyQwxWLqhjr/f7cJQYB0Y4qnIzT0rIO6ObP3XXldjc9tg41UAsl5aCGduy5oUFtDnOUBjadHzhOiHzGnDZAWCfFWiLhldwwrQRqVKemzPYofNSLf4gLEAM564CT8fg3VA4WocNXw1NRvH/rOrgX0W9nHNT2sOFxZwFDKu7TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZb2NAQq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730466821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5CVurix7+30nzpI9IV03X7MQodXDpgxTJqDlhMhtTg=;
	b=OZb2NAQqVjHRDYY146OgFD/O62WkQRlNqOyuVObjd9ExK04YWhe3hRQZ+vpUkWWaGcLHlD
	ih6jRfaYcVekN/wNP3XBtzGTSAdTEgYZEZtQqsTBagJK83wgEO3qBtKBnLgmYeojhSjKvR
	u9MJlAvKTTtr+X6T4s3d+kWcSp8xcgk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-lsP4kQlINTy1IjQHFJ7BxA-1; Fri, 01 Nov 2024 09:13:38 -0400
X-MC-Unique: lsP4kQlINTy1IjQHFJ7BxA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99fff1ad9cso162342766b.2
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 06:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466817; x=1731071617;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5CVurix7+30nzpI9IV03X7MQodXDpgxTJqDlhMhtTg=;
        b=oDuV7COB6/SKkyHgH5VNY6ZbeNt7cHgwveDYrQ6OrB4Sq/u485YsLnuKnQgVGT0DCN
         Eus/zWmnR9p0CNO6FxZNCf3hAvJWVDimCcfR5dLfVypWaMhxQlvrkkI3+FM1weCt7O6c
         OjuPUtJVd9WyBicmQfKBqIPkN8N/dNeFc42xrNsaCG9bDtYIZKsuKjx4ijBktBMW297h
         AXX+IF2cyGz58OmnvZv3qm4CzV9Dm2mOc6OysAPgiII1IMJHGVZaWpC/TFfMKouKjq/D
         uV2wSDlkRdytApRXmHNY1B2PGhJrox4F098dFo8uIIwj1SMb4leLtFuLc5ARReM5n/Mv
         d4yw==
X-Forwarded-Encrypted: i=1; AJvYcCULA3+5b+MXo5rDGBKXbbKKEZpU1E60Ya0966HMa8eS5aoEUjD6CM7H7YUaoys1TSQR1xrp4FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0z3aA9BXebbdeavgGCLFaimmlyL/7zMc19AggW3gUagiTgER
	0K8pBqWAj+/n9r+MwQaFWNtXmYwkAnzRTvIoOMVRnAxg1CdR7xERXNdubYg4dvZ6X09Q7bpI44Z
	pFDCOY9wGlgTn+b0cFrSjI5a0HDcHWr+/Qf9v9yr8cJCQHPdan01DJA==
X-Received: by 2002:a17:907:3f99:b0:a9a:bbcf:a39f with SMTP id a640c23a62f3a-a9e3a6ca281mr1084509066b.43.1730466816962;
        Fri, 01 Nov 2024 06:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuHAS1/AYRkBTQXHwF48y6LdOUW+QPelszDi8D+myCfGJMI1eTs1lFcGd+BkSBw+5Z+W4uKA==
X-Received: by 2002:a17:907:3f99:b0:a9a:bbcf:a39f with SMTP id a640c23a62f3a-a9e3a6ca281mr1084504966b.43.1730466816491;
        Fri, 01 Nov 2024 06:13:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e098asm178704566b.132.2024.11.01.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:13:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E7766164B965; Fri, 01 Nov 2024 14:13:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 10/18] xdp: get rid of xdp_frame::mem.id
In-Reply-To: <20241030165201.442301-11-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-11-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 14:13:34 +0100
Message-ID: <87ikt79jwh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Initially, xdp_frame::mem.id was used to search for the corresponding
> &page_pool to return the page correctly.
> However, after that struct page now contains a direct pointer to its PP,
> further keeping of this field makes no sense. xdp_return_frame_bulk()
> still uses it to do a lookup, but this is rather a leftover.
> Remove xdp_frame::mem and replace it with ::mem_type, as only memory
> type still matters and we need to know it to be able to free the frame
> correctly.
> As a cute side effect, we can now make every scalar field in &xdp_frame
> of 4 byte width, speeding up accesses to them.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


