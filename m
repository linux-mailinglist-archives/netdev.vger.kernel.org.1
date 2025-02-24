Return-Path: <netdev+bounces-168871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F87BA412B2
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 02:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37F33A911B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59E282F0;
	Mon, 24 Feb 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfN7SlaO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30150DF60
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361034; cv=none; b=jwIMuG5puQMd0//0w7lN+i0Mlhrl53MeAf2Wk6hjBn7AUU3134rXyxqy+jqO+4JuiBUyoBB5WN7XBYZF8jN4FE80ZVVihVOMWei0qkzHbITydd4ggbX6flsfvaSZMkT8gfBSstcyTlAj0FNNc0ASvcq8R7uWp2N+cOG10Tztoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361034; c=relaxed/simple;
	bh=DDKUEoznc8DiQSa7ZxGO5iBmi1tdihrjqHIjWG5bkvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nl0truYJKs5R4dVDnPzpTucIL5hMyKF49qmdJnusopAa0s05ktm9UA2ZJYdmx/gkwrIb6LuTscrFz4KKKDKkdQz4nVOpnh0SaSlARisA+fEi5R+EbNOUekETi+gao58Da+QWoCxz4mCDWcSnc1RxihP6S6qFM9r8CzLvpowWzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfN7SlaO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDKUEoznc8DiQSa7ZxGO5iBmi1tdihrjqHIjWG5bkvE=;
	b=BfN7SlaO9AVWCpDb0a8RQZOpw4cHvj3xpMrvFcbOUmj8P4Bn7Md14G32g+82Vdjc3Wqm6J
	jzlTRy4O497hWti3rtRIZaH1I17ZS1Y07/azxGqbq50AoHcr3m5azNB/KnBqWa1xhLupG6
	zvFjV9fznR+XhvE2FwX1/rqMk9aoXT0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-cWob6nuyNFK5EaEK8FmLVA-1; Sun, 23 Feb 2025 20:37:10 -0500
X-MC-Unique: cWob6nuyNFK5EaEK8FmLVA-1
X-Mimecast-MFC-AGG-ID: cWob6nuyNFK5EaEK8FmLVA_1740361030
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220d8599659so73891765ad.0
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 17:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361030; x=1740965830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDKUEoznc8DiQSa7ZxGO5iBmi1tdihrjqHIjWG5bkvE=;
        b=QRLWyH7fjWGjUc2pyKb70ZWagYNGWjTFT+IfNBqyOcgggcAhWP9gCNnn1hspB4vGiq
         fCqMbjpPSRRsn5sy42EwKxWPODYwGJ8XiuNNHaiv2kp544KtY0D5TlRzmBjrRb8u1U8r
         Rs2EUXxZ37EutkNVo51padfSfPQ33phg5KwsfyFEUgDFxhsgW130MgH9X+VsrlGzqvbB
         pXmsh/WjIdAOWAGNkTRcwQMcM0UQu/nrj7AkZi4JhKq2DoJ7UlgwpBGbpYZfk6cxcatd
         fFUeKQ5YIikZNK1S4+YnmijrJ+22VY/myys6BKmxuHHGdcLH9OwUXkaMGwknEfbvV1kt
         mLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVlPB+RlCuV8cOigbGJoSxZ0nvmAV2xwxmTw2MdVSqfzw8xilRBmHDDl0rvrSGWnxYMXexg6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfdKDOYffHirbXUtEql/OYanAmLbxhwdeUcdqSUEX5wnbj+ri
	T+koCFsc2uGhuhh3LCaxHUwOkYtzfvtw3qtxbqookZx/bJiv6DFo0DtvPej5RTXWzqFWjL+qanK
	Y7MmM+m4YdKyZLSImZmU6T0r469lPBHmDUtsg1LUon5DLzFWSVl1e3HIzr8FUyUxPB0Tg0jdYXr
	yiPXgSGcnPgjz/ksiqP9/ZyGZXoy2j
X-Gm-Gg: ASbGncvEb3TnhV0Bq0sl2RvTuiAwJ/Dqs6o7k9vsnB/cVQGn9tHHdBZpPn79oJZ6Fry
	2Ea1riD7up1vZP6MhlN/MyA+Gzq/pk+NwOkWxINhvi6hg6/ELVDjmb2LTlqQxU+kQISxfIn63iw
	==
X-Received: by 2002:a17:902:da8e:b0:220:f869:1e6e with SMTP id d9443c01a7336-2219ffd270dmr177749665ad.38.1740361029789;
        Sun, 23 Feb 2025 17:37:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOeXKHHqb4Fy7D0duuUsqaBjQ5JEjIFblCv4/RR6Cjx6kySGlfKNdzXcRttM48rlOR+pU3OSFf2tpAQIg5Gho=
X-Received: by 2002:a17:902:da8e:b0:220:f869:1e6e with SMTP id
 d9443c01a7336-2219ffd270dmr177749415ad.38.1740361029317; Sun, 23 Feb 2025
 17:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-3-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:36:57 +0800
X-Gm-Features: AWEUYZkUhaSykDfVeHI8T77xwBRzCjQxyzGy4NNFOVme4_LjDEohqSIX-n4QmYY
Message-ID: <CACGkMEsmX7v8ta4D3vgzi3S=G9nzjmTs3pG3FBou+2mNa__vpQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] vhost: Reintroduce vhost_worker to support kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the previously removed function vhost_worker() back
> to support the kthread and rename it to vhost_run_work_kthread_list.
>
> The old function vhost_worker was change to support task in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> change to xarray in
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


