Return-Path: <netdev+bounces-245035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA2CC5AFE
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 02:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27BBA301004F
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 01:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3687A242D8B;
	Wed, 17 Dec 2025 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBv19nhH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fO0GU2oV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAB1FECCD
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765934540; cv=none; b=j41idVTcUD5XRrTu0iizD42wuNdfk3GrVy2hKSSkkH7becqAt6xgcEA5KRUthpY0vFgWH/+5AyhGAPot1OxXgZPJlNghwTsROiHTy1Me9bs20eyV4eISoGzTYyBxXTXYOL7Sit2lwRwR8hbWJssL+Z/IR6tAmSLfF/6fiEKk1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765934540; c=relaxed/simple;
	bh=9boVk68kYNusC+MXtLi8MSVwKnke4dYwoVkCzCoc7c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/3TzrZRrFYt630BZ7udIxAxBwZLvIkEF8Nn2YUwfjoFa+4VB5ue+80zF2v+GSAUyI+R8bLKbGw2SHBBY+tIzDGDIwmb17KOe3IjujD9/glcE73r9KpI+0sGR9cvqDz2OOYfJlLK4Yuii5SghLPijM2kJ2G9edr+BwQHugfHJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBv19nhH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fO0GU2oV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765934536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9boVk68kYNusC+MXtLi8MSVwKnke4dYwoVkCzCoc7c0=;
	b=GBv19nhH9XZD9S4AyCb2S7hWhUKjBC93AwewvhJVD2qEdlj685TSmoT8JrRwrhVzw7UbTQ
	ZpdWGbOvX17s4evzCK/nKl2zsGo4KDU2GKe5vNfFTUrJyslPr8lzL8DMQpffzJDAhu3hCg
	QFOidVOu/k5DM1A9ocUj7AWbW3FVyok=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-7JquKrlcMGmYAKMdQuL-dg-1; Tue, 16 Dec 2025 20:22:13 -0500
X-MC-Unique: 7JquKrlcMGmYAKMdQuL-dg-1
X-Mimecast-MFC-AGG-ID: 7JquKrlcMGmYAKMdQuL-dg_1765934532
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d7865e4so4902274a91.2
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 17:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765934532; x=1766539332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9boVk68kYNusC+MXtLi8MSVwKnke4dYwoVkCzCoc7c0=;
        b=fO0GU2oVZ6FKjAkZU4V6va5pvqEWW9thNqJn8WH6C5UCjKAiapP9v+8j4pbYnqQpnN
         vP/vsCYmLxpFjBh89w3QdEv/Vt1fzQgsTiyL/Bii/ZXAQ/mDhz1RLs8ld4X9rQqk+gPY
         pYYf+5AzHoPWFgng9SFYjHQ7LEFfzf2yv9fok10G/6k4Gm8zHWkfJvyyHLdwROzKxQiS
         AQX/CRVORfrxBErAhf5WFFwLHCj7G1Da3nJ0H+wa8HRkxp3mrr/IOuFyauZboEDUnVbl
         jJ6C10DfFZkNk+5MGcm3zn2QuxbsFcp8KpwXpmyyqWtfUhqjpU3o98ZIb6QKJrSsZelU
         oOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765934532; x=1766539332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9boVk68kYNusC+MXtLi8MSVwKnke4dYwoVkCzCoc7c0=;
        b=TG5K0qdCQUCnJOUyVN9HtBm6FSTbytLVTJDH+o7Dr4jPP7sZRev10iQ4iRJWeiQdxO
         VUJwcuNbS6axmyZM66w1Ob0tMAqzTHf90xO8y9/eUTvGRoDt4BIdqJvHbOx5k6AJ/hpj
         cJ9t1gYd/9n8vRZr0jpTVFE6MfPs+TSJ3Iz53Yxs96LQ7Wq9FHRcUe3Hp4R02+4G3rBn
         xVcoQeAiL4PDqiVjQ8qiMr67SDlpClu84GW5qfDUYi+CS0MHkb0MmHJ/Q7H1eLwuNbHd
         V/xUU5LojidepuPW46tN+frRtQ0k9urqQxNMELfrvCjd62LFawYE4VKFzCAP7bz5TOKf
         MgAQ==
X-Gm-Message-State: AOJu0YzxK1t8SBmlylozBv+tR7Mu/oig/GwlNi3SVaIVXNuyUgWAMg/k
	jtgcII8qfkwYYWC8gix/nuxBuAZ041y15mcw9FzX9iVq+kkntaTlmjBaEnwqu5Ju+EKGVKf07+Z
	tp67X0+Cwvx+mUuRiZgBekOBPnt83bcP99gmI580e0xyS7s9j6NsdNcy5cnoqq/G8szm4auzOoh
	fX8IZGG4Y9vMCkgX64zhpghOJN+Job/o9z
X-Gm-Gg: AY/fxX6Mnaw5fEJR4elWdTwadsSDZKcTs+SDJmkf5fpXZhkPIBHFn4Ga7r3E+xP0EKc
	OMiaYXf5AsvqytbgAID2UWnDcTahvMv83hsbcJIyZdCRYTJ9X+WEyr7qr6RGKYw4S3Mf53C7udM
	7I9dFOCb3iMUWPPJfKhDFV/xcXP+LP5ZAaSLROhqc7W18JfehtSgl9AZJcjz7E9Dyayw==
X-Received: by 2002:a17:90b:1345:b0:34c:fe57:278c with SMTP id 98e67ed59e1d1-34cfe5731d8mr891200a91.34.1765934532501;
        Tue, 16 Dec 2025 17:22:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2Qj1MjAZsaJatY38cVNtUzo65vJvXXqfgYjDc1M1txBuTCxEU1f06oaF/Mba6iW1H5lOe2BX+sqswTaGgyuE=
X-Received: by 2002:a17:90b:1345:b0:34c:fe57:278c with SMTP id
 98e67ed59e1d1-34cfe5731d8mr891185a91.34.1765934532113; Tue, 16 Dec 2025
 17:22:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216175918.544641-1-kshankar@marvell.com>
In-Reply-To: <20251216175918.544641-1-kshankar@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Dec 2025 09:22:00 +0800
X-Gm-Features: AQt7F2p59SvA8jqbLDZpsRBclL2mVEfHsYjkaUO7M68_TRk-7vqIcAO9BWf3AVs
Message-ID: <CACGkMEvgA-A=aZc06kc1o68Em8AeXmWPeRa-S=ziqWencpSk3Q@mail.gmail.com>
Subject: Re: [PATCH net-next ] vdpa: fix caching attributes of MMIO regions by
 setting them explicitly
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, virtualization@lists.linux.dev, 
	eperezma@redhat.com, kvm@vger.kernel.org, jerinj@marvell.com, 
	ndabilpuram@marvell.com, schalla@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:59=E2=80=AFAM Kommula Shiva Shankar
<kshankar@marvell.com> wrote:
>
> Explicitly set non-cached caching attributes for MMIO regions.
> Default write-back mode can cause CPU to cache device memory,
> causing invalid reads and unpredictable behavior.
>
> Invalid read and write issues were observed on ARM64 when mapping the
> notification area to userspace via mmap.
>
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Btw, I think this should go with Michael's vhost tree.

Thanks


