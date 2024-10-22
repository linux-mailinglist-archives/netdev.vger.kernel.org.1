Return-Path: <netdev+bounces-137824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE229A9F2A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA01F22C28
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE458199FC0;
	Tue, 22 Oct 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0ccslYX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E41991C2
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590596; cv=none; b=oTITtHMqiK8oEzDT/2nB6u/nYfvezSayzwXHiHZMiD/u7fyrwjiTBmUq+rrGW6XxxCUAHDKXpIzzRA1Wdm9kGiCkR6ay6MsIGP3ltgxFM3SkhosEFE+KiAGTeomndbUhNP/9o9KqFKB8R7LNjbnoXko/uEMQrNtYmRjSWT2HXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590596; c=relaxed/simple;
	bh=FHDMCQSj4bOSnFGm64uWhd8NfaqRwIffME40ECj3VBk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q9xaeFgeuFdHswSJAM2wZD4+LzkSYue7Hgr/xhTj4gUUPfBatc6jZS3JNLqDkO+JWxwIBl2eI1bgX8nru6SWHDGOm42RHQaxdVXFUt+3we2QLY0vBN5+zeN+IdgPlmVCL02e4XKrR+sy2vnWg+s10eDzPgdAYwQHYWNxMxJkJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0ccslYX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHDMCQSj4bOSnFGm64uWhd8NfaqRwIffME40ECj3VBk=;
	b=c0ccslYXT1Jvr5bfvIpZnLGgoYJXQt8jyPMqYh/lOVn9mdHEp9iAR0diAnVPYqR+TNq+Nf
	XyAhSrHk5BMwI9Mbkt0NMHTZyo/dX5j4AFfFM+L8igqIm2LwM3BR+iL9weRObJ4/05/Xi1
	a5MwUBsH6c0QpY1qHdlhnYY4tPy+4Js=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-J8-EEBbXOnynvIYd4QbA7w-1; Tue, 22 Oct 2024 05:49:53 -0400
X-MC-Unique: J8-EEBbXOnynvIYd4QbA7w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d533a484aso3144250f8f.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590592; x=1730195392;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FHDMCQSj4bOSnFGm64uWhd8NfaqRwIffME40ECj3VBk=;
        b=RBxwdOHjeP5PnHLk/D/J9OXEEqb0z5dRtI864KOoMJA6wBeG1wtH4KlicxqjiKquBt
         TfKEsrPihjlSq5mM/9yPLpyWPixiLdjURm2TzyTNi1yyP/e9bks2HkO9I2QAT1E6dpYj
         f4nnpwfQjRNPcZBtF/pwzrPxZvzx/yb3fvV3Jl7BAXp8dTgK/sB2MIl9TOHiNMVGhAqD
         LkWG1qNGrjaLPz5DqiIFlo6laHmJrlR0lRSOT+6b7Hh1oDbJ2kVTfInJNDjxLzq9FYtQ
         A/G33Xtr0FJomLkGcaOVgaftq6uFzmfcqwAfT6nivTWnXs60XmxSlzzd1H2UV+1NweQD
         hZZw==
X-Forwarded-Encrypted: i=1; AJvYcCWTSi0WsG/rh/SPOFCxYnqKnq6NN5ZHdkenhFecT/tZxioKHkMoTQCQyGFja/NPPjbLAOxpHhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbDd6bcdQZzTfY8hnq/BhhG2zk6BLkK1uj3Kqdu/CjLPAGO8c
	rsnVwpiC7iVZclOIEYY7BhW2ZPl6to6rmwVG3pVvVhznGXgBkg657IFkRwwzz61/wDjSMWQhVE0
	y9Or63v9nlLXd0N2lfdiYD40AT2ZzvamWGRWrcLFGj2WxZP1iN5CGNA==
X-Received: by 2002:adf:b186:0:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ef13cd752mr1751560f8f.29.1729590592130;
        Tue, 22 Oct 2024 02:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIEHKao3U/XFI7bzq9Kj6t6RyZxy0cnLw5nrYDT+Cbr6tQg8AZS6TySYFQBcdNzKRVWndUxQ==
X-Received: by 2002:adf:b186:0:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ef13cd752mr1751544f8f.29.1729590591777;
        Tue, 22 Oct 2024 02:49:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcc8sm6205364f8f.107.2024.10.22.02.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:49:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 84B08160B2CF; Tue, 22 Oct 2024 11:49:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Eduard Zingerman <eddyz87@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Helge Deller
 <deller@gmx.de>, Jakub Kicinski <kuba@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Puranjay Mohan <puranjay12@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Shuah Khan <shuah@kernel.org>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/5] net: checksum: move from32to16() to
 generic header
In-Reply-To: <20241021122112.101513-2-puranjay@kernel.org>
References: <20241021122112.101513-1-puranjay@kernel.org>
 <20241021122112.101513-2-puranjay@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Oct 2024 11:49:50 +0200
Message-ID: <877ca0ii0x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> from32to16() is used by lib/checksum.c and also by
> arch/parisc/lib/checksum.c. The next patch will use it in the
> bpf_csum_diff helper.
>
> Move from32to16() to the include/net/checksum.h as csum_from32to16() and
> remove other implementations.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


