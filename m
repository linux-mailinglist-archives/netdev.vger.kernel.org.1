Return-Path: <netdev+bounces-244017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7182ECAD6BF
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27A7730248BE
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6D329C40;
	Mon,  8 Dec 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XugyTRx/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBF0zTRd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276D3329C41
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203655; cv=none; b=sC4KHEOu1OtARrouq9Gr6w+CYRVJbUHv0GwVMtFJENaRseeAO5Qe12vak3EW84eQRY2Btelu6xZNUgh/yDT7jBvwE5HVZdPESccJzCqx3yfqhwBiDA3+LWnU7Aav7GeqlcS89CgaOkWFmpuBxrrSvDFYocZKp9P1BNZ30g7z/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203655; c=relaxed/simple;
	bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sui4x36Zt8eySKoYGx7RXJQL09VucCmdvW0CVV0VGCTiyl5BbRW1BhUwMwX8ZOfHU3Qdk/Qi1qPIVqeTxMMOU8PL0BZvOHUty7AO6LIpzq525Hqa3m+xeV4ITkxRh/T255FXlaA4aztouV7RL2jl96bPY490DB1z9K3HmsKJ4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XugyTRx/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBF0zTRd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765203653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
	b=XugyTRx/bRpddOSPl3zS3vweTWcL12tpa5Ru276jbJf/KRNEDADA5MGF0biqi/FVHoELM+
	a2/e6Hq1sdf83Nl+YGAYisL3+FXN+fAg0ZfdgX/KLbhUBxBpRyDZ4xrEHdM0n+xpx9C6qX
	LjpE4T6h3fDNRZE3hlZrrpmL85LSXD0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-YM30RlG7PsSPwPigyE37ww-1; Mon, 08 Dec 2025 09:20:46 -0500
X-MC-Unique: YM30RlG7PsSPwPigyE37ww-1
X-Mimecast-MFC-AGG-ID: YM30RlG7PsSPwPigyE37ww_1765203646
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70b2a89c22so536664066b.0
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765203646; x=1765808446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
        b=cBF0zTRd892NkDsjeVWIrrUVFn4iDvAPTOO6YKNRxcX6C8UgBzbbM2pW8V6fi5Uilx
         IJH9H1TqGdMMSrkfr4hIqfNKEhsYtHxSSMQqTN5nBLsISDnZ02r/2tBX+j3qZpfntbky
         OyL9JJxDXwjYkpdMQ/9VHWGebMPaHdwweebf3gGUBvWba4yMD2rjnYa720cRzpd4THHQ
         xCeq6UaHJgepVvVqojiuceWH1y6kEd7eGtdQ6aR/v8H+1/fKrmg2NU0kZ3Nzf8yE0hnB
         gi0NlBRbEfNW0nRfgNnftiDUOcCoHPOlq91mFgiyw7fmv2u1g2f3cstqcHGEXboKFd3z
         AfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203646; x=1765808446;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
        b=sNW85eA5Tkp+sy1RhXP/ElKjSRN909QvLzW1Cn3LUY4fD0hE79O+QV73h1J7LIo4F4
         BPVrD4wOhUrzxFXCP/F5Z3hIPHP2BiGLj8r/uQe1RYZouz7aHApWGaTqJgPZg7LviAOn
         alZ3QE1bx/dxInYMzpC2+XECyUEYCUm06qhrMLt7T/54n+xc5XprBmfpkMYsZ3j2f90g
         D2hnhqqE+NWRdn+mB1CVzQZsxx58tHGK2xkwRLi/MMqlthVDqEwkm3lJ3Yfk5JIBUNCn
         vAEeqOKQVTYMOBoUuV0LSzeJMbAdp9Rrb02O4oLPK0S3cNvKuRxvEsV/GNMtYMrEt6XN
         7ANQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3qwa21TSHjiny7u+u/MSfirgEGYMA9y0KMt+AxJtqieZ8c87d6SvHNd5Vxn/YTql1hh1xRgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYZTS8vqFlkPTb3c5lEDEWDSpW+V/1APKu/xzNz3a25qtn5Pe
	Y5I564LjluPy7Xvq0+rcO0KhoDA4NyJf0V2Buv2J71XCwVU0rXk+DbSEOnsVc9V10pGxm5+Cbmd
	MH3UHd8c0STJSUyVox8gU9ZANSmTPpB8kolpvSWEQ8rQSDvCz8CD4OnwVBQ==
X-Gm-Gg: ASbGncsA5NJeOXMRqatofCwseBAm4ZrC/BXfHmgf/4gke1NT0zUnbtx8VhJ3x1mvdr1
	7fNMCKwzE3Eg3aWi5DX2kq3/GfxKdbhrstUXieK2BvQMJ/5xZQ2yy7UFa9X1AZd/i69jAl57GHG
	Rp1TEUoxX8ZH63HiFLqEUTJv9G3ZavEGK7W76eU4OpC9t5H6bmM+pL2Nr1ehIuMXjLkrWG+Htew
	HzdfwthxSyNBmHKuv1NrGAiwa8M2L2T0D5yIs+YuAww+j9hikCotNT8h69RkQlIM95pSrtumoXl
	AzB/fOpvq1m60ElMNp3M9Z6U6xJiWfKaz/CK1IKjgQHGJaRgUSQUiG3EfJMgMy7+xsXkFbeZvWd
	crpjb1CekoXL+TtbkbtwbZP4WFwBDk8fZBg==
X-Received: by 2002:a17:907:7ea9:b0:b76:4a7c:27a5 with SMTP id a640c23a62f3a-b7a23b38b5dmr792475566b.23.1765203645752;
        Mon, 08 Dec 2025 06:20:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeICR9a9Zyl705kBwz+fQ+K9zHYu4wc7uwPWOV2osX2dj4Awtr08onWyj57fv57pFb+ioxow==
X-Received: by 2002:a17:907:7ea9:b0:b76:4a7c:27a5 with SMTP id a640c23a62f3a-b7a23b38b5dmr792473166b.23.1765203645298;
        Mon, 08 Dec 2025 06:20:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f426413esm1142503666b.0.2025.12.08.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:20:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0BE593B25D9; Mon, 08 Dec 2025 15:20:44 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kohei.enju@gmail.com,
 Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add tests for attaching
 invalid fd
In-Reply-To: <20251208131449.73036-3-enjuk@amazon.com>
References: <20251208131449.73036-1-enjuk@amazon.com>
 <20251208131449.73036-3-enjuk@amazon.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 08 Dec 2025 15:20:44 +0100
Message-ID: <87ldjd6on7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kohei Enju <enjuk@amazon.com> writes:

> Add test cases for situations where adding the following types of file
> descriptors to a cpumap entry should fail:
> - Non-BPF file descriptor (expect -EINVAL)
> - Nonexistent file descriptor (expect -EBADF)
>
> Also tighten the assertion for the expected error when adding a
> non-BPF_XDP_CPUMAP program to a cpumap entry.
>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


