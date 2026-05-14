Return-Path: <netdev+bounces-287826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEFnADtjBWqOVwIAu9opvQ
	(envelope-from <netdev+bounces-287826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 07:52:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7464753E1CF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 07:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192EC3023507
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A4836A35C;
	Thu, 14 May 2026 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fsyf2ung"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DC29D264
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737972; cv=pass; b=sgm6uupwO7bdtRfy5Uga+HJJnw4dsLfhlcCVsJkXibVFuwvoud1DY4bR6SvDjX/XKAbS+V6LZqZ2l+xqfSmd7uX+WfgT/KRMYcobWGWZ/PQ4HgEBA1WRaRw5lF311VqMjcOUDPiKRzVcb0x05KRBS+ikEnDtXqCp4ezUuC15coQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737972; c=relaxed/simple;
	bh=jNKZ4zNOiJapN2UCQkJ7YsxiCTXnQMvJQjELnoY502w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjFfnEDxt7FJN2opYJ91JIe7cCeS0mOCtE9OwB3TxsFI5OJj9vgqCRmyJetOMlaWqQFsygq0iCABedXDtsI4CKzcNrjAYz5i7Deu9tAdc9OUjwwPJCDGh1+7I/2djgNHQNK9mx5wU0iDmNLFIx4DzOOoaYH8ch4f+dwm9hLoByQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fsyf2ung; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DLijF01490475
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=; b=fsyf2ungMeq6
	yshHRzeQ4U6BrRrLOw2m5LnpTLwWNRFjtrke7zVSXSFihlkGIGQqF9ZGo3jGgRXv
	2rFeRHThXTMGtORk281jxrE4gu3k+yTDpZgaO0RXgdCq1N5vftBndt64eqJWuKnS
	+qFgwbyeb4nBJPMKSoH2gapTvLOVcXTpgpJbzNuSuxsG6wL6MDQuJFxJqBTW1JNi
	IVV9KnN8WwJIC23O9zBqlSvbZlQqGkv8pX6J8DxJKQRvwoU15pvU+KJVRC+Shz/1
	pdRz08JIRHpjjYq3PaY5+SYfamSp6mY3XF0mgHmyOf5/MBFj0ETZ9P3+2Z1Vr68E
	ax4mD3GJvw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvnn82h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dca6ecdd85so10594586a34.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778737970; cv=none;
        d=google.com; s=arc-20240605;
        b=DVxA8JQCy62hxFsiqSKoB+Wdve1MgcDziRYR/vh98wuoAjGqLh+76oW/A231+6PH5b
         m8I20tJdjnFzPm2A5Zw3nm8n4+plEzsC8LDIRR27h/65Mt7wYYzaU5a6hQQjjpN+b7Xh
         FcDhELxLGkigntvhWbWeYxWVUQGvtxJ8CGXESCqBmy7r1+N9+azr7akdEZ3SgYavUFE+
         LJpesx0Dnat0JJQ4ZMxbIiXeVZQdudrIaopjBTS/OwxXp25Fn/FazYbRjNakXDc6vkAh
         LY41mxOqfsJyUDgfiWVYR1mAA2bEY9lc15uMmOo3Oh8SCdcgZEweb5mH3muZghqpqs0B
         /jEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
        fh=gCjYd+RjvFaG3z6O95J6QjhEnBV7K0IkMwNwXFpaXvI=;
        b=Q9xzDiE56G/JBy2jWBngizFnkm+dsmLgeobpZ2bG4GgIHrSBZB9m6GGa59A5BWdFlD
         e/t9HYFL/+BWckJHsEg0qyskb4U+xQeI/sZzjCPPZHZiTUoKV1fuSE7HTBHN5kA28ojJ
         FaH4zh7X5ZfB9aSZ9UlBWxornjuTy93b0bnHFrcL3I1LX/XRK7ZsxE/8Q5mVasQUWg6r
         KwUkllRumLo4XIhx7FR4HyluSNtdcd2Xh3Col7PFJLbym1//3mbybjoT/2PTgMz5o65N
         n0BeJwJiPUs9cD6cIeRTL9naoRLjcsqZXSG44MjnfESvNYmzy+HzBAdoPkKeMsLb0O7+
         ipYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778737970; x=1779342770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
        b=cxLRKc7xcj3pWHuYqEuixyR2ZBZfCps6iyjGk0s1lur5DKOeLbjiGTICTmWszXel3B
         G0hwi5YGzpH8JUAq+hTmpUWBacrw/rJYeCi0vUSpbLGWsY2Jcj9pre0JLZProOYvP930
         MW48ANM7uCrOW/nnxhSgm5+DEyAdMHzkt42P1/QPoc7DYQFyFJUdVsF5eEZj1YKiRyG8
         AmXEe6tmqGi40POh5WPoZKVazr1DMtPQNklwDW+1oes8myCMa8SCivEKlhvjGgOU45ji
         /T+d0Wy5zqaodhMle2F2rw7jqzVlbzpW+JvX3l9pS5bNhpfpY9DqOx0wntrTVFlm1BMa
         9row==
X-Forwarded-Encrypted: i=1; AFNElJ81IrIIWhJ1nFFCVcD4fErMb2XDSUWP3DbF4oeU7eDSFhwhsw4itgJ887wyGQ5KHjvUPeI11vI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9nqnFbHmn/33gr3Ofldk4+LaWO7xk8FjLgUNKYbkikfPtfpw8
	XGiYEzAw3d4h5uYqsdQZzrbSvP2JbYKmsdbffqXeavQmgtTm+OJXiR9nAEjDUoXi25ozSGmYm7f
	FRDrifvaI0W5RwUevX4diJ4BRsijkKg5aAAtoZg3K0c8ZVtV8g0XVhabG3U0wE3rfFxCYceBbjR
	qVE0Ri6pDhE2hQ3HEJCMLB2wgWtM0b/m8=
X-Gm-Gg: Acq92OFSqT9Ad7FjjwDgH/WI8IycI3QJHhJS4oc+DYWJS/08RithMd9frWZAntVaIp1
	eKcKxWEzh9IhcykDgmYyyQt2h3u44GnRX4ppQWuH937gbwP+yn0fBLRTmyFsV4eXMVqkbHRnmXJ
	1cRGioLxkFH5q+M2nyxLHD1wyjZMPaIVUTk2KJGV8/DVULMJkO5rAYLWzDXSaRb7k/AZq//vS2w
	Dq0f7fOISea83CFtsUNlBr4yBvVgBwQqmTYD6K7ho40QczJGP0=
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id 46e09a7af769-7e3da47a167mr4289729a34.18.1778737969717;
        Wed, 13 May 2026 22:52:49 -0700 (PDT)
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id
 46e09a7af769-7e3da47a167mr4289722a34.18.1778737969331; Wed, 13 May 2026
 22:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-2-zhipingz@meta.com>
 <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com> <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
 <20260513063141.GC15586@unreal>
In-Reply-To: <20260513063141.GC15586@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 13 May 2026 22:52:38 -0700
X-Gm-Features: AVHnY4L9mpkzt-pRZEvg5JzN0p2zqJY8w2-rDz2pv9D7N-e0Agw9sPJQbQsXATM
Message-ID: <CAH3zFs2XyXxzVwru2gYZn-9ioyvy44HMmfppf7shTn8Qop-4iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: Leon Romanovsky <leon@kernel.org>
Cc: fengchengwen <fengchengwen@huawei.com>, Alex Williamson <alex@shazbot.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: wd_AJclVAQmavGNqgejKbmBuJ-hU912p
X-Proofpoint-ORIG-GUID: wd_AJclVAQmavGNqgejKbmBuJ-hU912p
X-Authority-Analysis: v=2.4 cv=b/eCJNGx c=1 sm=1 tr=0 ts=6a056332 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=VwQbUJbxAAAA:8 a=hJXI5Qx6rLfdTxNNxg4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA1NiBTYWx0ZWRfX6z7drpj+rtAk
 N8Gfh2BxTAgPMl5UgKr3uJss42f6hiLpVq1C0Ss2a2DMMLaXrtJbA/Dtfhtst3hXQ3g18/NeAYL
 doBJGF64Ogn/1E7ULX7koqqhu9wwHk5yYOtbMLhJacA57GnpC1j5H/r9fANjRE8uwCtyrpb5bF7
 F9CHYYqVK3uwC9PH8HqD73UItqlnM/j0qlyb//1CRdIVMZTUh4uBF3A4FY2KLKJnLTjUuLYjdcY
 F47zSbZDmhSawQWnTzkCvqu/cp3WUHIX2kveWrqh507bw51FL1BoADwPlAqX3PLM67hQXMdHoOc
 ab/rDq8DMgyTHliOlIpf13Zje556rsGjA4f/5qYDEX4zjLz2YNbDPRGi+DaZuMaKYQfEZzQBnTO
 FRMbDULphD1F82+MjnxI0btOyTRSTA1tpG7ervOjMBfoteuZnzmDEQIF8swfp7ROd5kBnZSl5jw
 uU57ikoJP0Jd/Qx6ErQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 7464753E1CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287826-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 11:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
...
> >   #define VFIO_DMA_BUF_TPH_ST (1 << 0)  /* steering_tag valid */
> >   #define VFIO_DMA_BUF_TPH_ST_EXT (1 << 1)  /* steering_tag_ext valid
> > */
> >   struct vfio_device_feature_dma_buf_tph {
> >       __s32 dmabuf_fd;
> >       __u32 flags;
> >       __u16 steering_tag;       /* 8-bit ST */
> >       __u16 steering_tag_ext;   /* 16-bit Extended ST */
>
> I wonder whether `steering_tag` and `steering_tag_ext` can coexist
> and hold different values at the same time.
>
> BTW, please send your patches with diffstat.
>
> Thanks

Yes, firmware can report both `steering_tag` (8-bit ST) and
`steering_tag_ext` (16-bit Extended ST), they may differ. An importer
can consume only the one matching its width. I=E2=80=99ll clarify that in t=
he
next revision.

I=E2=80=99ll also make sure the next posting is sent with diffstat.

Thanks,
Zhiping

