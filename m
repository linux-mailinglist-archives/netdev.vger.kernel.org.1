Return-Path: <netdev+bounces-200575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A777AE624A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2BD19231CC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E19D28E576;
	Tue, 24 Jun 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZH/e3B8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E028641D
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760532; cv=none; b=INzEf3pWaWEV/afYzxbK1MAxy4tuVP0w5JzYlRTOB1JLmwzgsC5tAenMUJj7mL07hLQ0l/xhtS/+AjNL5t3WkmWQisWcSvp62dXncEiWthKs6DmCO052SJobsgoefBUf4XxDl6SwIGNosXRNwMOB93aYioONqcNvVR3qqgWB7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760532; c=relaxed/simple;
	bh=EAplqW2ugJAkvDa+aOJIODUp0iAnSPiEybzJg50wrII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i17thWzSgxhlLbUHK5SirLXg7y7eVZnJczXqFiV/swsg8FytAt8oMLplazIazuPSA5jeOOC6Mnu/davi2/DPsi+pRYtFCuuooxwmVVeauV9U9HO0fW+uIj6xmuZo2LcfdhhXv5O+WJmUD8fPShACJSFXqegsUGTiEWshBkGWqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZH/e3B8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750760530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBSg8EY7sp1BX+AXcNCVD/E1en0mg8rYiqbGQhd2mHE=;
	b=OZH/e3B8jD/NDnWCNQVONEXGbmYO6p9dOnUYwmkmaLJ0XXT7NaGgFbnvxrSpy4FEvweRre
	m+S2qf5mVjy9GTF2mbQNtmfC+c5ttmh1x/bQVkOwWNmWtyVKzrN/WOjeWv8F4e+HR2e0yz
	hDtw4IY3btBv/PIcuvCN8Hd9n49u/lc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-vTNLBEhDOPuPIPZB9SYsxw-1; Tue, 24 Jun 2025 06:22:07 -0400
X-MC-Unique: vTNLBEhDOPuPIPZB9SYsxw-1
X-Mimecast-MFC-AGG-ID: vTNLBEhDOPuPIPZB9SYsxw_1750760526
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ade6db50b9cso30104666b.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760526; x=1751365326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBSg8EY7sp1BX+AXcNCVD/E1en0mg8rYiqbGQhd2mHE=;
        b=KQJbcWIHfMT6RMR7E04dEofeq//PDEaTH46zv7AYrn8YF3XYkXGtPq7S0afWam4L0U
         TTACzkK/EDbzapi4i06IOonQc5XMKxqoGW9BOjoFaWBTvv2fjIx3hvOVOoJO2wDRiTmV
         hPeVL2SWHdsHFTu2dUxRiYAIGM1ZEd+mg2F4mRKXxW7TQmtuwJCW8kVnZasnLRivGn7i
         bu/e8Fl9xKRgFFvVavey6PoeGb6dc4N7Z56MNroeDLn8T18DcxyVXa4AXPZ621/1itGg
         CMNHfWh+dzGMtPkHnIi36pf3WJo7Jl38vJwxFwCXfYU5pPiPK4bCsFcXf9nfvUxwC3Lo
         wW3A==
X-Forwarded-Encrypted: i=1; AJvYcCWoqe61iZd9jLhlpK10esUd5JDBJdB6tSiA2Y2FhY90176uv9G6b5LPYieLlQATc1wSPDW6QLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDRAXoSicckm8ciHhJqLZDTh0zYunfMum26fY44eulnOCaBgr
	UGrsv3LVx0EBcglqjzxWVHU5dpoKdIzmOCeTcfzFjYDXcxw9SOOi7dZlPk2I7kHCVci1Lo3CPZV
	Pe2q1BGnbpglM+n4WYwpsUxEj0hFE0M5iw0dYdsGRZPDGHQHnZDJbmRc2AfHOOq+9HA4bv2k0hW
	rcXy8wdXW/MPq+H6w+AUZEq90xGJNKe+T9
X-Gm-Gg: ASbGncvH6uMqdnZxke6XqHzbBL0sOx/gf9FGnVeG50F0CHD9qojAwGcSi+uXE/HIhG+
	5pWcjCwL0djGWDgPM4DG0xcCnJfj5QeiiCIgKPHZ7p9WLy7t95+tBKBXCrj4+bmpviaa80O3uLo
	kFpLzh
X-Received: by 2002:a17:906:8924:b0:ae0:ad5c:4185 with SMTP id a640c23a62f3a-ae0ad5c4bb6mr127041666b.57.1750760525915;
        Tue, 24 Jun 2025 03:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK7idR9ddwSthjp78IPlVH980PF43V9ofMCipwNRyRw+Vq3cABVYLahb6LovHNST8gpasNwDNrhBfNArPnPZc=
X-Received: by 2002:a17:906:8924:b0:ae0:ad5c:4185 with SMTP id
 a640c23a62f3a-ae0ad5c4bb6mr127039766b.57.1750760525506; Tue, 24 Jun 2025
 03:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617001838.114457-1-linux@treblig.org> <CAJaqyWfD1xy+Y=fn1x8uXTMQuq8ewVV9MsttzCxLACJJZg2A2Q@mail.gmail.com>
In-Reply-To: <CAJaqyWfD1xy+Y=fn1x8uXTMQuq8ewVV9MsttzCxLACJJZg2A2Q@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 24 Jun 2025 18:21:28 +0800
X-Gm-Features: Ac12FXzfQeWK8ouZps9YTtPNR42ROlRbSB3jIfmuYcflJDxiz6fBrlpSiur_mHY
Message-ID: <CAPpAL=xgBK3qqNdaiR=OwbiMaA_5VpouE4YfaEyYghkHxJ0CtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] vringh small unused functions
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux@treblig.org, mst@redhat.com, horms@kernel.org, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Jun 17, 2025 at 8:31=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Jun 17, 2025 at 2:18=E2=80=AFAM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > Hi,
> >   The following pair of patches remove a bunch of small functions
> > that have been unused for a long time.
> >
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>
>


