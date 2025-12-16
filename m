Return-Path: <netdev+bounces-244888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19843CC0DF0
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 05:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 863BC30047EF
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C9F330321;
	Tue, 16 Dec 2025 04:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5NjXvGD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyTJx4tN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815332D7CC
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765858706; cv=none; b=l1tMkhGG5qR7oFcBQ0NKh+S2y12MOj3IVMjYv0VWxDB/f4dTD3ey0VNTI4dthv6NgoLbqk5cwKeN1DtNKsJPoNsMnR2uaqvsALZSL70bRxWLvc4rR+tKg2SsNTM9m2EJJ4Yc5yOCRD9GfVM6623+6mpXKrIdyjwFK3+GgYg3DBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765858706; c=relaxed/simple;
	bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dv2aembzJJ67MijhDlsI8K7GANE0mzR1gd5jFFtIuY3doYkglXJwuk/oJcv4YwKvC1Zsxa92JSdp6hpKt+uAzayeBBKIKkmQ4qpoM5anR2hRLX+iJ5altxrHsiXlIF8tg+K+OmtYxpRHb9RhJOPjQm4lhzkOOmf+QCMZmiHsAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5NjXvGD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyTJx4tN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765858695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
	b=A5NjXvGDLxOTN7i8uepsASxQWSK+oQpP3F8+IpOowT8SlHQppyg8ggIXB/AXVsF6wvN9Zc
	e4n+5xZo2YaMJ9Jc5jT9MTjoQYNQLN37nWLpWB/8Lxdf3qMrrFknQ+bDByT9jRse1kPp7l
	hfLB5XcwzeaHGrLpxhvy11YrzrW+NsQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-XAnYtFHqMy-RZnVde39zqg-1; Mon, 15 Dec 2025 23:18:14 -0500
X-MC-Unique: XAnYtFHqMy-RZnVde39zqg-1
X-Mimecast-MFC-AGG-ID: XAnYtFHqMy-RZnVde39zqg_1765858693
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34a8cdba421so5535554a91.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 20:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765858693; x=1766463493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
        b=CyTJx4tNG74Ha6RIouJPM7V8dlIlz+CarkHGK1SkkbKw28aNhixeIFf2AvpFoIsFbc
         XZPlzyq55NBS8U0i7TwTC86fUaGlXen5C5E9AR4nrAGxb5BeBw9sFTTs0SPFPHjLDgvO
         q8BmCMJicJOStoOzqRcDKspG21tVyoLB5lako0NbU+cfmEzV66e3gT8V4n7sU2WxPxMa
         lZvWaSmup6XnmtwIHsiOoon84bJCIaNPC4OuOjXQ1fs8/p/00PMN9tUd4ECoRnYuLWKH
         RqJZEzRdrxh3UbwZPIPmXdQfXOrtwwcGkJPI2Dd0Zv9C8a1f3imVyCqGMXBP8DmUQ645
         kwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765858693; x=1766463493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
        b=jyrv/73xEVjXJA8xSXlvwpXPdOdtUp2Wc5IlXvSHR3AupPaRfLjp1bEIDyIyy1BdTU
         PxZGa1cPZXeQjrn/awCFqDwmWhvW7fLDg/bfHGCJfVTpoCRSM66V+MuZFXpyxtAzBkbX
         OFTVUB14dlH0mY6Jm/qB5f7N4+c9ugVGm50hpQlkyogYdR4KxPskXNy6eAr7FWGnMiLb
         C4+OPJEIc3u+0RofY04b10ijqt8SMaTHT/lJR4sJtO3qEViz9L4qe4GTzbkrlezRCmK5
         ZkbKwpC0hZrsapwCsGst0MQjtXa/8uLnPCt4Uykb8i+tUmC/9HZLQ2M+OHIGvOgY8RFf
         HRag==
X-Forwarded-Encrypted: i=1; AJvYcCXK1LmH9BqExTHGH/3meAGLrXRiIVZwb/dV+rpgMyrMHTT57hs3SxU2PFFJbz/eOn1J9Ld8Tls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsP7z4vlB73wryWrYdv9CcJuGTa8UiizGf4EVBkikQOiga2LSc
	T4xxNSUufn+eJAmIxNZHCRRTDAO6ZwpoLRFTxdb5HFcwWPUtgg9qR1/ADcaIeUakzeTHV6CamNo
	DPj75f+iN9LrzlI79ZLh3uYX9bTTOm9Q3ohJQHZO4pHN3nav27yPNy5CzPpv+CauBS1sDLdV879
	gCj1s7jHZt9YqeA89G8IGmBjY6hYpSWd51
X-Gm-Gg: AY/fxX4KVCk9I6KVfWWQEtQ8aPd/Zjfz9vAH/dmO59MRWB2mURqiHuhr9jIbTvgNP1n
	Y9wq317+70O6kpB19Wn8cXKgtqNFs9/3D6UdKZuLLQ1Z8FACHSnia9lWioo+xv7j+cQJQ7Pc8cE
	seTeyHuX06VVNJqfbyz4JgVzslpSDVqg9w2aXQEW4QgW7do0L8SlA/W5oW84cKUoxacA==
X-Received: by 2002:a17:90b:2ccf:b0:340:f05a:3ec2 with SMTP id 98e67ed59e1d1-34abd81733amr14699558a91.17.1765858692965;
        Mon, 15 Dec 2025 20:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD77DQk18dayngXtbIw3fsOCk15EBfDyLwaFsEN4158FtjFJzrWxy8+rjy6tA50q0hvVxRQAeZswAuqcmTXkc=
X-Received: by 2002:a17:90b:2ccf:b0:340:f05a:3ec2 with SMTP id
 98e67ed59e1d1-34abd81733amr14699535a91.17.1765858692536; Mon, 15 Dec 2025
 20:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215113903.46555-1-bagasdotme@gmail.com> <20251215113903.46555-7-bagasdotme@gmail.com>
In-Reply-To: <20251215113903.46555-7-bagasdotme@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Dec 2025 12:17:59 +0800
X-Gm-Features: AQt7F2q1idGMqOnPlq5afbA61NEyezJumJNhfdWiFdPMuPeC3DZ1U_cOOaqg6iI
Message-ID: <CACGkMEtJt7Df5kXWex8EoKdakdB8_xLjgCXQt5pUvk0dkGzVMA@mail.gmail.com>
Subject: Re: [PATCH 06/14] virtio: Describe @map and @vmap members in
 virtio_device struct
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Linux Media <linux-media@vger.kernel.org>, 
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com, 
	Linux Virtualization <virtualization@lists.linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, Linux Network Bridge <bridge@lists.linux.dev>, 
	Linux Networking <netdev@vger.kernel.org>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, 
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>, 
	Cruise Hung <Cruise.Hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sunil Khatri <sunil.khatri@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, 
	David Hildenbrand <david@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Max Kellermann <max.kellermann@ionos.com>, 
	"Nysal Jan K.A." <nysal@linux.ibm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Alexey Skidanov <alexey.skidanov@intel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, NeilBrown <neil@brown.name>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
	YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
	Lyude Paul <lyude@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Luben Tuikov <luben.tuikov@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Roopa Prabhu <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>, 
	Shaomin Deng <dengshaomin@cdjrlc.com>, Charles Han <hanchunchao@inspur.com>, 
	Jilin Yuan <yuanjilin@cdjrlc.com>, Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, 
	George Anthony Vernon <contact@gvernon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 7:39=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Sphinx reports kernel-doc warnings:
>
> WARNING: ./include/linux/virtio.h:181 struct member 'map' not described i=
n 'virtio_device'
> WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described =
in 'virtio_device'
>
> Describe these members.
>
> Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


