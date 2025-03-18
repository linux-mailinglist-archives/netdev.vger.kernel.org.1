Return-Path: <netdev+bounces-175622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C012FA66EA5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0804F18871AA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA461E8344;
	Tue, 18 Mar 2025 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjX3c6Ck"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9B85260
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287354; cv=none; b=beu7qDd6Nv10Tx8pJuQMeCnBelDpxHxsfwEWsKwc7OhVm5W0SgG8mOzqmpQZUBsNNLyUqmf3LShB/pzgR4kge7MPlxE/X+LQIo8JafB7NkmWngVzUZbalPOIg8Tl/MoJyIshqk9XC+3ATFnKbzZo2Ji7dGSRYc0qVMRVEDzAy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287354; c=relaxed/simple;
	bh=ItI8ZxLJfUZ05BJCakPQRRPtMO8OcjwuFiRZBPHPWno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sesZ4ayQA2uOpVRRpl85j0yOUMnPl/6ktuirnnaKM/OKZ3e1a2laF1RtUQNS5FdG51bOsvOr9MsB8BW8gL4p+cod26oUZJ2/BMvC0xprArgzf824po8hzB+nV99gRVY53U8y6CQHdB8TxAlCVysGq0EA+YKFwaOfJoMaO/TBv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjX3c6Ck; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742287348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItI8ZxLJfUZ05BJCakPQRRPtMO8OcjwuFiRZBPHPWno=;
	b=QjX3c6Ck5Sc66xQu4NppBScvcuftQy/HcaY2aC5GQAhzzAAjcZMc8c6JN/PzkwY6e527ZW
	HyfgK4W38dXy0cl0mhXDSwoELErD/4gGXAuyGyzSiI0+tkupFFUuUstoDbXO5qa08kfb6u
	uPHytkbKxTGEfCVu7fH5kTROzOEz3Wo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-uIxILiwdPISL_j6Yyk-e_A-1; Tue, 18 Mar 2025 04:42:26 -0400
X-MC-Unique: uIxILiwdPISL_j6Yyk-e_A-1
X-Mimecast-MFC-AGG-ID: uIxILiwdPISL_j6Yyk-e_A_1742287345
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so25764525e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 01:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287345; x=1742892145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItI8ZxLJfUZ05BJCakPQRRPtMO8OcjwuFiRZBPHPWno=;
        b=Ugp8PtwNHRKXghr3N4NtZdpdTNGpiXjJq6E5sacBePMVTafzm8o98GTWvY8ZtZ+CZc
         8AQIxxAmff9M+Len1EzNpFOqqd91jT7rGL3MeSWKEpNWH2FiP11VAJWWFK5phiFQtLhN
         YBD3kMpBj2mkSkCfEqrACS4e454tyMyHnXsQFnllIu0PQA9UAAFQ8cZNuQTCu/oQ5Cpk
         HhRxAKwCwma58fntwJ5GaaBrwUs9e9AmCE5II87yZT3+QgH0SS6ovKUKIzZwjehiIzzq
         rmyrQTgKBj7pDVt2xe74OyQlwaM+XyL6rJ9M4mlMNgiUqWIuLbBWJbIsJ6S+r80ntKXU
         OHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+PwXO7CIZUb43WxUTmD5TrcYSaHToTKGre1YIePOz2/ZParnB73Rai1Q2t4qdjCzK/AqQwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNI4Cnc4ShoYQbBYBUqj/JvqWsKWPrGjqooaVOHwoTbM1MrZT
	/d6jkAX384pDzCq96Lxq23VgeExXvVTn1YeHyTUzAsjne54Q/1M4HFZp3D1ASV7AoaGeAM5pQbj
	26hCpoiWfj7OwqogjeI7uYGawLoNs4K7u479DDb7F9BXQ2c5Q4fqYoA==
X-Gm-Gg: ASbGncsWwLz66aTOJ7P1wqoRPVdxn0xCLfCbEW22qN2cu0pfvaMEITTxaTwoYH7q1Qd
	sEodc5gsiAQaHOAat6/QS6eutxd7DqfXNI6YF6LYDs6bi/+HiVgg0GvUfCt0J+chAOlWSADjnnQ
	n+hF0co6R/ysfgfh2Q+7NMBG2fK6S6Lpsw1ZUq5sbRPtj5p83D9Cbt3bbj2ZuFnrrtbAHILa0Q3
	5fEJqQxiVOJMUZ02ZnDBMiUNQrym7ECrV3UUSwV51skp53H9qdyxeUnwTfObR9Fm4sUa3sGdqyO
	52gnKONwJy/WeynFXg==
X-Received: by 2002:a05:6000:1fa7:b0:391:47f2:8d90 with SMTP id ffacd0b85a97d-3971d2399f7mr13243002f8f.20.1742287345156;
        Tue, 18 Mar 2025 01:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhzzf67mUvz/FcN47bVjgtNi8OCE+41icTw+PdJofM1i+tw0XCUVzzh2OjwceAbkj8Ddci4g==
X-Received: by 2002:a05:6000:1fa7:b0:391:47f2:8d90 with SMTP id ffacd0b85a97d-3971d2399f7mr13242988f8f.20.1742287344846;
        Tue, 18 Mar 2025 01:42:24 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a32sm17733812f8f.33.2025.03.18.01.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:42:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:42:22 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <3obwl27u7cmgl254v7wdvy7zm35t6vluh4vn7zrtjbz4dp7vc4@sonxoa3mwdjx>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
 <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
 <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>
 <4pvmvfviu6jnljfigf4u7vjrktn3jub2sdw2c524vopgkjj7od@dmrjmx3pzgyq>
 <90a758f2-e079-4148-8d47-ad2ec9161a13@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <90a758f2-e079-4148-8d47-ad2ec9161a13@rbox.co>

Hi Michal,

On Fri, Mar 14, 2025 at 04:22:20PM +0100, Michal Luczaj wrote:
>Perhaps my wording was unclear: by "wait for you to finish" I've meant
>"wait for you to get your work merged".
>
>Sorry for confusion,
>Michal
>

Don't worry :) feel free to leave comments or test that patch!

Cheers,
Luigi


