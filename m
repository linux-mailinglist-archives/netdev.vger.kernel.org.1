Return-Path: <netdev+bounces-173574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F73A59902
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F69116EFFA
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EF6221550;
	Mon, 10 Mar 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPuwbNIO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578F15CD52
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618835; cv=none; b=gyKcb6BKaffW8TiAQn9YwPkRFVFr5rNiVHrgOsx348a6d6IQnM2StMMDexEr+QVKXlZ7TTFxjkOE7vT9fTnjC7X6Ndh81yMcPOf2OiizjLomlBMi06oxWLAyx5fvEL1jpAch4mTl4WEsXbeWt7vdbLuZ0u8CxdKaE8O0KPTulaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618835; c=relaxed/simple;
	bh=/x0ON/WedsoRMVzH8RSYa4VIPg/Gp3T7mT9f9BJjDFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0l4O3/B6OQoeG3VUQ28L+bxqeWjB88rE1iB2/PS7fJa2yMyX3y6U1CVn/jfppqdIrimxjWDCkaDDK1IUDdta5FUmHZkbO1dzYyFuydVy+hiwfDuDA/Cy3kuetgRnHNOqulH7R9OtWqvfvUCQbsRPZzSe4rGqwgrPSTsLug9a/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPuwbNIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741618832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KH5i4IywbihOjouVmIrniM68yK+cO1l8JI4w0Ofv3s4=;
	b=aPuwbNIOgeL73cReVhrCh0Wkw/3PJ9FAhc/Nz8q0XsN9bBUvA9td/CTTMP8ki+ZiqRiEig
	3Dv72xZ8GBdFs64noOi6+diiSwv/oSPIBLDBtZLYtFq89kjBEnJ0bi8DMGHUroHAn7DoUc
	jr2ToM3XFqKBBzG++oPxZJ6thLx9VWM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-Pj_F5bs3NV298lj8-YsKiQ-1; Mon, 10 Mar 2025 11:00:30 -0400
X-MC-Unique: Pj_F5bs3NV298lj8-YsKiQ-1
X-Mimecast-MFC-AGG-ID: Pj_F5bs3NV298lj8-YsKiQ_1741618829
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5495851a7a9so2614541e87.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 08:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618828; x=1742223628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH5i4IywbihOjouVmIrniM68yK+cO1l8JI4w0Ofv3s4=;
        b=jN9nIKMwQTvvKNVhtMzYdJXlXX6C8t+kqCcsMhor5JhF/C9ryQmZibcrYTZ/pczdzr
         h4I0wAcZrayE7fZwuYgCMjP+GqBpRuGXSMlMGSWUriLyuZPf3c1iOeyVQCE5AYqXjkWs
         hESHj+Ao8gpKyvvB0kF2c/cGaoLhN+Jx81G8HUnbug4iw52lgWAmR9DIxP62p/Pdj7sA
         qeBNGPwYg5VXRLITLA403O6KWaLHyDuewvM8I/MFA04N/oteYaOeloMrs5WL3dH63xQF
         0Ip67ixS7I8+jL6C4cPR6gkfFKRbmhctL/NGbLUqy7Hgs9iqAgZaPi54qsPqA77d73px
         MULg==
X-Forwarded-Encrypted: i=1; AJvYcCXmAQl/MgOhEGzVBXZQBUGPROHGJvM+p10MI6Wg93vUTnAdEjUQczg3pYQ6h639LbjEtTk2pCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjfdBP35VTQkrOgjVEZ79WnJqxaH3h/4WtZj6OXpwampKMM33
	KW/WHg4GIWtYRec6gPtSygvGdoJfRywqwSuMCecPkv/MuRQanFkdU6zUBPZtbG8luMSfemcrNi4
	MucM+oS+RQNeJ13LAds3vvSYMMkIliAS1a7meRMLjr4YAdCHDR8FHcSHQe08LGg==
X-Gm-Gg: ASbGncvzmkbI8PWq19fKAR7BqInDbzgw/f6DNUhYWVM3unzpeeub/X/OPIMttxxTB7+
	iz+w3SB2xHGLJbT/cS1Hmdnw2ACfUtdTvCS+sB9UdsL01JXHzgTAjzYrFMWP6mn+ZjfvWMPP2/C
	Mz2bBS0pkSpsclGFL6vubllxrH5gnPpZ6lYTR1gHPVM0xfiNF4J0Z5VvW2AYYmv2U6q8n4Cwntr
	6pGk/KFYoJ9Byd9Wb8iW+jeanyyb4/E+isPWLBEsugESUKd8G9w6wnIes/r8xASKojxIyFNw1nj
	yfMJ5S5J47jRk2UZzjk9Zpzm2oPaJkMz5BAp7IHCOfmCFRC0M6ZEur/7puvX3icy
X-Received: by 2002:a05:6512:23a4:b0:549:8537:79d6 with SMTP id 2adb3069b0e04-54990ec8eb3mr4831995e87.48.1741618828509;
        Mon, 10 Mar 2025 08:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGROxIODA3vj0+f3Hfn/vpKF5UrA5a5CTMt2ch2nftnuA6re4mbmftFp/dC3MyfFmuS2rop3g==
X-Received: by 2002:a05:6000:188c:b0:391:2f71:bbb3 with SMTP id ffacd0b85a97d-39132db782cmr9143318f8f.46.1741618814406;
        Mon, 10 Mar 2025 08:00:14 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceba8d727sm78011015e9.25.2025.03.10.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:00:13 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:00:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <thza4ufhxxdy5lggglgqkzjtokl6shweszs3cqmdkxlhsg6wcq@6l6jn5samgsu>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <be935429-2125-4fea-844b-abce83f7324e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <be935429-2125-4fea-844b-abce83f7324e@rbox.co>

On Mon, Mar 10, 2025 at 12:42:28AM +0100, Michal Luczaj wrote:
>On 3/7/25 10:27, Michal Luczaj wrote:
>> Signal delivered during connect() may result in a disconnect of an already
>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>> been placed in a sockmap before the connection was closed. We end up with a
>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>> contract. As manifested by WARN_ON_ONCE.
>>
>> Ensure the socket does not stay in sockmap.
>>
>> WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
>> CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
>>  sock_recvmsg+0x1b2/0x220
>>  __sys_recvfrom+0x190/0x270
>>  __x64_sys_recvfrom+0xdc/0x1b0
>>  do_syscall_64+0x93/0x1b0
>>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>
>This fix is insufficient; warning can be triggered another way. Apologies.

No need to apologize, you are doing a great job to improve vsock with 
bpf!

Thanks,
Stefano

>
>maintainer-netdev.rst says author can do that, so:
>pw-bot: cr
>


