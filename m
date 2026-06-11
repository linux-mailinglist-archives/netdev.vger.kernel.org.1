Return-Path: <netdev+bounces-298393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e9VOOxY9K2qr4wMAu9opvQ
	(envelope-from <netdev+bounces-298393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:56:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848A675BAC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=FDSJxjU9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298393-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298393-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BF25326F5A9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C72384CEC;
	Thu, 11 Jun 2026 22:53:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598D36B067
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:53:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218427; cv=fail; b=sQtMv9Q9nwQEMyBniV28UxAtuv6hroRfdP/gXavalPto3AJN8HXL9QxTWj/3DSMb+hzZMteiTjOe6+34/jbat5PUfnLGVKWlb4xCJdsGZDyiwUvVVbo3s1M8Gdyw0v1ocRWh2QATadF+riJYpspSeOsmkCRSCRmHS9+CTfPiuCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218427; c=relaxed/simple;
	bh=PxRZuLlxPed7g3+uVJRSQh6h+tl2QKNm0St8ryyYUCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhZe9cI0zxH1OFHBGE3mp6xFQ6etTAweLs1/E7N9WUItjtwRX00hpvrCSUqoB/lmVxAPBPP7D7xykKs/A1nqUGBmDnMklc/wqxcOP2JNMu92rbaANbOI1JEoz+n8MyETbLBqoKf9DkyDZGEa1otRhPRa3OquCyUaxcZIW/ZMIFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FDSJxjU9; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BLA6Pj160967
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PxRZuLlxPed7g3+uVJRSQh6h+tl2QKNm0St8ryyYUCM=; b=FDSJxjU9lKGB
	zYwQmQEO00hYYEJ0A/ovopPo9d7CqKqD1XADgRLIn8Vqp1BtdkAsscjzjFBtTOm5
	diVk99kItK4XNYmeAXC4rJxohR1w4XfXN9Bp6eaanw4NKiAW4gyJmERZSpkYpCSp
	omOvIhSNxK+sDVYMbPZyhsgC+FkoO1ml34CzJ/gxKRcU8wmkmA9aQAC3EODqW0kl
	lDxIU9Q+19d3J+fSdA/QNT4u7oggrCXALTCFp2seGU1YuaR3sFJx91cwBUas6m4P
	Q7RVyD542fkWdg5hhoszqMfbGG+JSljRyZ8BmrK8G5dKPiI9D7qpr9eZb7kxJzyG
	Yl+tOZEnCQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7899er-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6e385508bso525309a34.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218422; cv=none;
        d=google.com; s=arc-20240605;
        b=gWrEzaA8zF0gIUvSnU3PPyJ40K9xfAZbXzni0yT1pwVdIQOjLMD35qfEqL+ATph/Uw
         9XH25c72EbPvheWVB1rTOQonJmlXzw2Qjc+Kmo6cCAH9TecLYux701MznESe4PiMXiPS
         gzUAKADrgb8vJNHeZzlu3EbV6wIF8Z+DfmOIlB6HxKrFnaqcRJHLiuXlOfqwKF9p4c05
         a4O2FkYnjxiPABLVwR9yVRPrBuZocu5iBG1f/f5/9u2xvKsE5nrwzASUCyppWMkU1S8e
         kCt1eHz6uayZmJsMFr0n0z62SPbep1vN+ifk+E+5lrm8V47qSAjZQ2epsjhO4rqj+xoW
         VG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
        fh=Qd6/WXCoSpQDEaqdBLfyYHvEHYfX6LVJcWL9LberUNc=;
        b=GQiQ4hfgoEz0S2BbI8r49dRDXgzETycSB/dPjxxCXQeW6b7fAKSD5z1xK/k7kXWhUK
         XD2UKUcZCYKjaiAttVWe7twynr8KshG1HGfcOpUmgF0I70yqycnkSs1O1kf1Vf3ROjcm
         Mxzi5kC6CpGWGXd2balXJycYvVMhEU79Go7T0EvUtHUqGzEp+DEDu1jNA3THny091wkB
         U07WLoANxxKAMOUDmHylKT1+hYL1dRMzNODkVXkUpiTW+wNSox3egjAGERgxaq8h2Vdm
         fbH1sS+6W0/hGe+InPkM6V7jSyzHNS9Zc7gbYClTVlN8toEwsqiQ0RqgyhAcsF93or9e
         NpxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218422; x=1781823222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
        b=oOihNq+9m79TYTHDOzufZK950vOCuo3TtSjw5UUpypRUUW59vDlyWriP5EBjmBBP35
         Q3k4+7fbelT098zKcyMVtrjD6mPNdR13BYLYrlouPpDpBvugidmPrDrblv2KkJRt2HRR
         SjILmfVs9oNxasF9CKaR8hKViZm+fFQggNmT++RvWz9XocYQN6V5H0wYgg0q7hgLur9R
         gyMENgYk4P6W31WYoXFQKdvqOs2tdnhEzon2nFFl4y6uWMpxMPy4+aquA4UO7jINVNiX
         NUPRodz84WHfu8C9PlUll+qvz/dT0nUbaOdh10YrKPOBXzqQuJKDfl5R0PTKveuVSpFp
         7iBw==
X-Forwarded-Encrypted: i=1; AFNElJ9TvCvHCCZ6BxsnKNafq9kFrJJST5jMjzG9T9pK24XiPsKmKdjtsyaCWF4IU9lL56Go6e0wCgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZdkqCyl2V1D5vx8G8NZ8dwffogOT8mnHOwAhbxG2QtGhBP/1
	BirEsOXl8Vo2cOlNqovPAdOyen7/RuPNiSRhZ6wfXrBRczi4GXAKuVfjELzA+//HOvxcqOS9341
	JjnaHze7mSl4YRRtid55a+dsT9Gq4Nn6ydfZ5iCNoDRCp0bITqL1ZF+TtiQGrlT58lxD2tPKmHQ
	+Vdug2qGwcesOdSSNMZ+hUTar0IPPZRI0=
X-Gm-Gg: Acq92OFUUOoSlP3LpwT2zzogMn80Cwb4m+uzjH3ma9/tK8m65i/LvgOLbu7Uvj5ZFlU
	3G3u6lrRZtL9uaAsY7QJtSHYPRXuzp/8TmIeUDRsFdTQgfQ+U8epnbqVVOVDxqS6lorzO97+dpR
	IUsPrB6QYfZ5ttR4q0jrY6i1k+rEVR6NfeZ5ywR99Wj8mD0A9khrDV8s1v7VkHCAQuUJjO0O/aR
	niQqkJPKLl1aC5bI/0Kew==
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id 46e09a7af769-7e7847e1560mr60108a34.22.1781218422498;
        Thu, 11 Jun 2026 15:53:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id
 46e09a7af769-7e7847e1560mr60099a34.22.1781218422119; Thu, 11 Jun 2026
 15:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com>
In-Reply-To: <555912e9-818f-4906-a883-6f14e0790672@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 15:53:31 -0700
X-Gm-Features: AVVi8CcTcZoIZDdh8OjH1IktxPjhUF1A0IE6AmeFSJNyea8GfNww1HwPJ1RCIPA
Message-ID: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfXwLXSXope4+Y+
 WTpIZZDMwLlvsa1x5HgjcwuoZlyNLY91YhHN0pMQ8kvRNvvrXQnXfDOPr+vuMVoHknxP3isYzgw
 vYQPOlgQhTxvn1+UAP54E7vfbaCqYwA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfX9/XnvlzCFrGx
 gpF2lYWNACLqRLV5nMmClZHP3VItf1z9ptWskPYim8/+ASEHeCRwGiZlTh9Q6NWIniTwzvRWUbW
 lnx0b+Z6Ll5qsH3VHxRr8lp9/aTIVKQDWMNg8DfQu2IdxCO2kiW8YX40uG8tkQqgHlc56bBOG6e
 +k92rkC4vDEDJZmKoXvICrQe59Ohxj6mJrstu3d0H5+VjAv5DbMH3aRFXa7t5lSIq5f+/QE+8tZ
 pmoQuzuUqz5zZPzffrRXGhUYb9xUYD7q45IXEEKKfBVuOKQtqrBvhZhmWN8dqwclVx1VXQy0m67
 aHmz2d+lh8dpS6xCITV86jPIt8EPcO0ody03XzYlnmbncW9RO0RqTLGVT6BDuZ9hfCUqS+5q/s1
 ApwjXkCFkLjEHQkkzIX/PrWG15fdK/g9Y7+B0dPalYOJ7rNrlBWT+yQ51Lr3ZJ15PWe010pxPkV
 Dsba1RElYNSEPGAItZQ==
X-Authority-Analysis: v=2.4 cv=etLvCIpX c=1 sm=1 tr=0 ts=6a2b3c77 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=zd2uoN0lAAAA:8 a=VabnemYjAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: LmDYRQocFQe4gArxTHEuCaKEPSQIVgF2
X-Proofpoint-GUID: LmDYRQocFQe4gArxTHEuCaKEPSQIVgF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-298393-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amd.com:email,vger.kernel.org:from_smtp,meta.com:dkim,meta.com:email,meta.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4848A675BAC

On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 6/10/26 21:31, Zhiping Zhang wrote:
> > When the last reference to an ST table entry is dropped,
> > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > therefore accumulate one struct mlx5_st_idx_data per cycle.
> >
> > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > struct matches the lifetime of the ST entry it tracks.
> >
> > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> Since this is an obvious bug fix I think it shouldn't be part of this pat=
ch set and go upstream completely independent.
>
> Regards,
> Christian.
>

Sure, Michael replied that he has made a patch to fix it, i will rebase on =
top.

