Return-Path: <netdev+bounces-167244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD2EA39629
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E793D188B14F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39222CBD0;
	Tue, 18 Feb 2025 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjZ9gW5s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC21B6D11
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868829; cv=none; b=AZ8/U70b2q+GPc2mfVfs+ZlH4PkgwSgRfy7UoYEYXriVl9PYI5wFizzcbhoeEdbu4fLEYy1eJmaXFIeoFoE87JDbm08JeX/R8Hb9XGKiQcR8iRTQkDyK7Z9DqGT8n2N6uOT/jP2uLFo7kAtgRr+JcNYkTkRQD3+Yl3DNdP/hNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868829; c=relaxed/simple;
	bh=JgUl5opwg5yU2nZVF9yLHPyuaiHq0y6bQ11c/v1IZrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbx2nrJDQu9cEtY16e98bT10+Jm5BE+vyHlokLA3eDRzx+o7/4AH6Pw3dLdYldkvWk9pzDInejW5WE+fPT5zMjUcRu4flhDC+2a+plSMP11HGetJ6AlG/VF2NamCZF3zLAgygz5JPx8t87Y2DImHdUz0qzeyvXAfJD3aPCaOmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjZ9gW5s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgl6hbo92Mxnck8gT/mfLwTqmZQ8Bgs9fRBCMTuEbCk=;
	b=WjZ9gW5sO9M8ne8kfqLba7TscA45NjPcL/F97V5lo+hZPTACIUSnpPcDVa2Ezog49hPdUE
	PxFT9iMVNpumHVfT4m3XszkOWxRM7o6zXQHGwSStexNapwTs/cElRlm5Gp4qb05fDSO3LC
	R8bcCROdS5k5+Fbl39GXdKdin20X8MA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-D4mpe6bkNMqWXsX2s3AFfw-1; Tue, 18 Feb 2025 03:53:45 -0500
X-MC-Unique: D4mpe6bkNMqWXsX2s3AFfw-1
X-Mimecast-MFC-AGG-ID: D4mpe6bkNMqWXsX2s3AFfw_1739868824
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43935bcec0aso41500065e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 00:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868824; x=1740473624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mgl6hbo92Mxnck8gT/mfLwTqmZQ8Bgs9fRBCMTuEbCk=;
        b=oiYssFO3ZGJ2hmvTdsU5WUDbEi9vDhSwETUsl00+M3G0uSoa5gDj+1vjBcA8tPerVb
         Nq+BLTeGjBx4joVg08Ns8beMrkjL+f/XkddXZtmGod5UKcBsnE8dY/Hj+KSO9adhjF8Z
         cbU37dGNB4+NnXYRGVbiRwE7ih7JmprqSP0h/3F41cG9G2YXGY2IIyCjiT11ga+weYrg
         m9msYV1wTPQ3K/MLONuaVRYWsX9E9z2MrofU9wZlta3TjDcV7Knl1DCZO5HtKAmTANBU
         pZLx2G25fPU6sar26kTo9GmlfuYMv4vmmGj3PIkq3TKlkAYf4kgkIlpZAoeWWd/31tmb
         4BBA==
X-Forwarded-Encrypted: i=1; AJvYcCVAlm6SMstFyMURTv3BCw2SH34tGgtAFVysdM4s+AlbW1I3zKbZxZnC4TF2B3p3wjOBwPPbrCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Q5jmUBial63biRFrTJgNYBBGFRm5b2hdqrlHAJCQSx5dzOTh
	n43QI0273wOQ+QS2blZjseqImQSlwslALjnNapsa5iEvk2Cdavfzr8+dXhc7EGZT7wNd29NGPFy
	9xDjUO42hrQKun84zZJhOOXFKND7qmZBPNu4505CG7SpMjUKbLMR71w==
X-Gm-Gg: ASbGnctGizO9bm5hopwgGAzqp60sI+s77BYIR0V0yZLWkQv4CEH6GF1ePe1cbtSjcdi
	45jPt32jSmifeXcjPEPRBLi09Up51TSVZGhsi+sDXNgXWeY6TZYVRYqpCvmTYPXwg73lIWP2eAI
	Pv8/XPaL1sdqCA4KBe23IYez47aBscGwNQxC0pCWK0JeG5YftZLioPAcOrZX/vE8ag4CsaqLApx
	kFB3htI9HncW67wU19PDsUZ1HXBFa/J6NUcsY6DSlusptmL88WtwigZnqMzQGwubUDwQK1o31eE
	cbjgGfXdF/W26jy7MTAH52fG0pwdbqo1XA36z9A7B5ssoWVUbURm2w==
X-Received: by 2002:a05:600c:3594:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-4396e730949mr115828175e9.28.1739868824093;
        Tue, 18 Feb 2025 00:53:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/EH7ZlWD6uvJ5Pwlyx12WqigUnKIwsQAbJ+vg+D+/MCEPIKisPa5XRvbKOf+AImCMDQH7/w==
X-Received: by 2002:a05:600c:3594:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-4396e730949mr115827485e9.28.1739868823355;
        Tue, 18 Feb 2025 00:53:43 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439858741e9sm34660945e9.1.2025.02.18.00.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:53:42 -0800 (PST)
Date: Tue, 18 Feb 2025 09:53:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/4] selftest/bpf: Adapt vsock_delete_on_close to
 sockmap rejecting unconnected
Message-ID: <onmllks7lojmjjglgq6ykseapzvcka4wlhazpchrbth64udy4d@rqaronc5ppwq>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-3-994b7cd2f16b@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-3-994b7cd2f16b@rbox.co>

On Thu, Feb 13, 2025 at 12:58:51PM +0100, Michal Luczaj wrote:
>Commit 515745445e92 ("selftest/bpf: Add test for vsock removal from sockmap
>on close()") added test that checked if proto::close() callback was invoked
>on AF_VSOCK socket release. I.e. it verified that a close()d vsock does
>indeed get removed from the sockmap.
>
>It was done simply by creating a socket pair and attempting to replace a
>close()d one with its peer. Since, due to a recent change, sockmap does not
>allow updating index with a non-established connectible vsock, redo it with
>a freshly established one.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> .../selftests/bpf/prog_tests/sockmap_basic.c       | 40 ++++++++++++----------
> 1 file changed, 22 insertions(+), 18 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>index 884ad87783d59ef3d1ca84c3a542f3f8670cd463..21793d8c79e12b6e607f59ecebb26448c310044b 100644
>--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>@@ -111,31 +111,35 @@ static void test_sockmap_create_update_free(enum bpf_map_type map_type)
>
> static void test_sockmap_vsock_delete_on_close(void)
> {
>-	int err, c, p, map;
>-	const int zero = 0;
>-
>-	err = create_pair(AF_VSOCK, SOCK_STREAM, &c, &p);
>-	if (!ASSERT_OK(err, "create_pair(AF_VSOCK)"))
>-		return;
>+	int map, c, p, err, zero = 0;
>
> 	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
> 			     sizeof(int), 1, NULL);
>-	if (!ASSERT_GE(map, 0, "bpf_map_create")) {
>-		close(c);
>-		goto out;
>-	}
>+	if (!ASSERT_OK_FD(map, "bpf_map_create"))
>+		return;
>
>-	err = bpf_map_update_elem(map, &zero, &c, BPF_NOEXIST);
>-	close(c);
>-	if (!ASSERT_OK(err, "bpf_map_update"))
>-		goto out;
>+	err = create_pair(AF_VSOCK, SOCK_STREAM, &c, &p);
>+	if (!ASSERT_OK(err, "create_pair"))
>+		goto close_map;
>
>-	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
>+	if (xbpf_map_update_elem(map, &zero, &c, BPF_NOEXIST))
>+		goto close_socks;
>+
>+	xclose(c);
>+	xclose(p);
>+
>+	err = create_pair(AF_VSOCK, SOCK_STREAM, &c, &p);
>+	if (!ASSERT_OK(err, "create_pair"))
>+		goto close_map;
>+
>+	err = bpf_map_update_elem(map, &zero, &c, BPF_NOEXIST);
> 	ASSERT_OK(err, "after close(), bpf_map_update");
>
>-out:
>-	close(p);
>-	close(map);
>+close_socks:
>+	xclose(c);
>+	xclose(p);
>+close_map:
>+	xclose(map);
> }
>
> static void test_skmsg_helpers(enum bpf_map_type map_type)
>
>-- 
>2.48.1
>


