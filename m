Return-Path: <netdev+bounces-170817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF58BA4A0DB
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E37189A1CE
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5551BD9CB;
	Fri, 28 Feb 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0sA8WEGx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB21AA1FE
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765077; cv=none; b=DWWcwbuxK9FEyq2U92VYCZHBbUZgXqdGJByKYcJNA/swDjRsNpliuDHWS8SpRxcVlGm2Os0GCJtGdswsgtgXkyIfAfnQNLtE3rckiLreWSLUwugCv63du+To074ujnIw9j/rY74m3RecJEVyfDPWp76+weinAiiV7b1TmTGLOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765077; c=relaxed/simple;
	bh=i90O7/FHVyjR7MxsQSaYgobcsFdF6N1pl357JzY65Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lgzd7WtyMW9GUBomcwcrXLCH0SQ6UzdJhfsfkb1vlCDqOdb+T0H3Q2ur8p0mRR+zYnoGUMIxiK90qeeDEmwRtl4SqPdrKpqWtbxswn+nw3Cqh9kiUu7Ik1enAePZFbXeQU02L5OqkRU2lncVbPXc3f4p+FC50NeteY+22/u7/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0sA8WEGx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22342c56242so5015ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740765074; x=1741369874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i90O7/FHVyjR7MxsQSaYgobcsFdF6N1pl357JzY65Cc=;
        b=0sA8WEGxQnS/Zf3Kf02AbA1nyiQcKsrWpuxn0YAeG46x+52fEUnDypBvXGwBCYajKw
         lpJD+Mm+uqIgSjwb16aeLtKaLAY6I2ZreQgewZ3Wp6GLv+QGmEby7mFoiwGcPNX7HOmi
         44thqa63eN4mMXckS7Jwf0zN1edMX5phq5TSeulEbs1Ha3LjVk+6gMjUOBhpmuiEk9Bi
         pCs6IctbucworLfhawd06C8v0Y0ocVSU6rK/BnzULvv7042pQXhV1n2G1Y7aveuBLmlf
         VsuZy4WMR5UJ4t4iroj8Md1V1LCcvXHxeek+5oeWQyAWUWQHxR1pJhMe9KknNVGP+uZT
         fgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765074; x=1741369874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i90O7/FHVyjR7MxsQSaYgobcsFdF6N1pl357JzY65Cc=;
        b=rrTAftiDXDchqm2C1tEfhvu4hQ/HB5OLoUxFNgOEE7lSYWMMDELZ5z4I4fcO7oxn3f
         U3O/Z8ZdLTFotDFog5IRUcIQC6FaD+qtIcxeId71qVeTT395JW3g+HK2vX7VSK8syufv
         uIwv6GvWQohP+6tLv4KhHlu+tPYoeZ5NS3QEFB9rLe2N9kPzJMz0DlbafdLlUWC6IRns
         ClBsErkN0DlbFBPtSBMWQgnoabHBxbS/K/fHEUY2TrAS7J5RiEMxrBB/IS/Kg+ARmXC+
         8QJYRDbdjuDeGk+4xvOyY745HpKriEvcCsLMF7xNlWTIU6KCmUTbI94fAWnoCavgl/yv
         v51A==
X-Forwarded-Encrypted: i=1; AJvYcCUOXzlpiKf13l4v8U/uukiTuAaOtx2EcwwJD8oz9fv/nwD1kfSJ11iWtVGD8aAMk526rpdhsMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dd9flWSzFEOX+dO1Gy03AyCxGrBH/DAA+WS/htMNusRkrECd
	ER7fCSAQzxNZNYtgUjpzLBOvu7eP1FQ5+dls6fWYwbYCmAXQrvlVH/H8iuuwQ/+QcT2DNNVoE4R
	J/aTbyjr0h2EdpsoTjDdtpAnXrYSvPukZPtCU
X-Gm-Gg: ASbGncuWPOssNi9dWlKmlVHVrC6PknbVpoJkQ8N36pfuVOhDpJnLg3RKp+UUrwwpHDV
	8M15Ohkch7W7SkR4anunjXdgosccTLE18jaYqWb518kbXIGMv/yfWTL/V1Hfpr28h+9E3B2q6q6
	ocl7PG9gi+rJfP9DvN6i4hfyKkL+x7DetNSRneQQ==
X-Google-Smtp-Source: AGHT+IFIdw83qwu5qQ7M0jSYLWA4Olvd7iOt6Uf+OiCdfuQjWjOsUe1tAjJCuFfQTQUfhDBz6gbEFI54iOYT2Q9LP8Q=
X-Received: by 2002:a17:902:f693:b0:216:21cb:2e06 with SMTP id
 d9443c01a7336-2236cfcbb24mr2629715ad.19.1740765073781; Fri, 28 Feb 2025
 09:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227131314.2317200-1-milena.olech@intel.com> <20250227131314.2317200-2-milena.olech@intel.com>
In-Reply-To: <20250227131314.2317200-2-milena.olech@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 09:50:58 -0800
X-Gm-Features: AQ5f1JofnhFYf0RWrJwwbqdsiCN-tSJuCWfQ9-QLmtpIZzBiaBKZMC9Rgc5PCZU
Message-ID: <CAHS8izMCExz_8Hnz3-Hg8EdyqoiJY8viMShKeRAsRC4iqGsLBA@mail.gmail.com>
Subject: Re: [PATCH v8 iwl-next 01/10] idpf: add initial PTP support
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:16=E2=80=AFAM Milena Olech <milena.olech@intel.co=
m> wrote:
>
> PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during th=
e
> capabilities recognition. Initial PTP support includes PTP initialization
> and registration of the clock.
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Thanks Milena!

Tested-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

