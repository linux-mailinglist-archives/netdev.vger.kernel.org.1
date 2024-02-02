Return-Path: <netdev+bounces-68453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F432846F56
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADCFB2CBB0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86A013E223;
	Fri,  2 Feb 2024 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ+Bsfub"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD01946F
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874142; cv=none; b=P7gInFRcF098mAapT9eUHy0we7dawsxEx+KIbktbWHxl7dR87iawavZt8T5FdV23BW5iwYijTg62dpNA0J8cZTGAm7NKEXtdMl2kz5sBvSEK8k4mxwadMgKeKgh+Smt/zSHrT7qWUUGtXeFFfkRyRC+Wq3U0Gau+KCp1ko+nD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874142; c=relaxed/simple;
	bh=0Uz+i8MjJSenirZh0mUrgqQNJWmb68i5QhXBdv2XStY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K/Vw2UzFekVQyNei6Yq4SJ28xDGpUiBcZWXXume6bsi5Urip0VRw7/HC6prOu85OvV05F1QYr/AR4tPtkP7oBSpyX9S34ETzu1vknk7pu+sv9QgKTaSPawRKmkX7ix4BKC6hgMwuy/A9tELcl/owStvuthr6PF4XZQNUCHiloJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQ+Bsfub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706874140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Uz+i8MjJSenirZh0mUrgqQNJWmb68i5QhXBdv2XStY=;
	b=jQ+BsfubP0ep4trMVUfL/KnumfGOkkfmDIREu2uFuwBzxl2FC2/2xLzQaA42uWO3tGXdqc
	YJB/c+7F0ZfqcV+Nf1noXJT0MghP9ZxvrC6hj2vMPL8l5ITAG8PjaSyghQGpHXpHDGKvCD
	kLMHfYf2QjGwQx9NK19UVDhTRg5Q+Bk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-bRc-0n-DMkyPuzG0vzf14w-1; Fri, 02 Feb 2024 06:42:16 -0500
X-MC-Unique: bRc-0n-DMkyPuzG0vzf14w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2c4e9cb449so139386966b.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 03:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874135; x=1707478935;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Uz+i8MjJSenirZh0mUrgqQNJWmb68i5QhXBdv2XStY=;
        b=bDKPlWZEXcCGyh4nDpEBNmfItgUI3ymR5835AGAVWLIyR+GM2t5+gSpICLKUbNDDmO
         KqvlHi1NCdwbfUUoSSj41vqp8P3s50QknGb6MJbEfSN5c3cVKSgDB1keewv2uIh2WUt2
         WX0A0tcGBNiS9L9xCyRBPYDKaXSY4L1gYVHUuirOHZhtiKzgOKvXCt1QVo8TUkRVLDaP
         6kVrpvsZwaFZLVcGwEUAgTmiG4iJ1CtoFqPi2ow1y5VSJPk5y7Iv8t6b3rrKD2o4PIoK
         CWuRIan/zLEV2/SZ2YW3PPeQmXgMYO8/H0OktfhiyMJFhIDKdooyvMaRXeuQ+wvvTECZ
         nB6g==
X-Gm-Message-State: AOJu0Ywwa3coaD5VhbrjnH2yG5En8IHIptLHhrD0mMGtDUaPgOAh7Cqc
	QJhfmxgHCVSGsi5ugdHl7LqJbi9uW0C5bdPkhllA/lzUzyq5dhmqQpEXdJxW2Uf8+6/SjqGnAjZ
	6jIWmlHS73ZTaUBjh0+opzqOOljOYdx7OSnCyvox+2KSnuCFtIJzLHA==
X-Received: by 2002:a17:906:2e87:b0:a34:adce:b5be with SMTP id o7-20020a1709062e8700b00a34adceb5bemr6466433eji.1.1706874135630;
        Fri, 02 Feb 2024 03:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE0Q9OhxrbEM9zN9VXsMVO/3rEJNZuM7N92oHBfjcS4SBq2/nYTkciBJ+OdsCi6sR/PYcpaQ==
X-Received: by 2002:a17:906:2e87:b0:a34:adce:b5be with SMTP id o7-20020a1709062e8700b00a34adceb5bemr6466382eji.1.1706874134305;
        Fri, 02 Feb 2024 03:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWgUQiW0qmIr+l4Jg9ciixIdW/YmYCKOhjgS3IH3EzAuLSRKebUrBBhFWPpGuLvnehbdToaj/HGLwWybsB27JZNTmrBqVAY4EU11wL4+wEoH3+4Lzp7Ku3Ol5jJRTq3ogo6tWH/p+oz5SaklMvHG/J4cZz7dFsPDOsoisrh5GbweO1+YF0+ZL7ZU4RIEZFQ5R9suQ4vBXTuJM/VXlv6N1qTGA0MeViXTSqI4xpy02YI32F/gGhsch868eu4XBJp71HYWW5+CYFjSdRptV2i2xEwKNWW59cJSHOSvF55C8GWh0sd4L3NgXaGDaDKB73tlbNPXK5zDkgIbQoJAfzQ0iqe5YhPHGIJZlG7er252Gj+/ZSv20Y3UfJv6PVjES6wr0Qacy4cJCiPtnWLm6L9Zpo1ktCFPjc=
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id di10-20020a170906730a00b00a34ae71e58dsm798363ejc.147.2024.02.02.03.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:42:14 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A0116108A839; Fri,  2 Feb 2024 12:42:13 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com
Subject: Re: [PATCH v7 net-next 3/4] xdp: add multi-buff support for xdp
 running in generic mode
In-Reply-To: <35486ef21c3a74931e81b5e9c604734781ca1213.1706861261.git.lorenzo@kernel.org>
References: <cover.1706861261.git.lorenzo@kernel.org>
 <35486ef21c3a74931e81b5e9c604734781ca1213.1706861261.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 Feb 2024 12:42:13 +0100
Message-ID: <87plxfxfca.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Similar to native xdp, do not always linearize the skb in
> netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> processed by the eBPF program. This allow to add multi-buffer support
> for xdp running in generic mode.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


