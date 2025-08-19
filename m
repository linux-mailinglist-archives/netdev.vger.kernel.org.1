Return-Path: <netdev+bounces-214910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93447B2BC1D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F267358700B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED2311961;
	Tue, 19 Aug 2025 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt4PjlWN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE52773F6
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592990; cv=none; b=gOAtcdPO7y/VFuYx+J6nHX7b7rWXeriVh1X3D6mBc/VAqJGFbyTM6nnyuu917SqAl0hZyD/YSD+FVroAXVHUnqwFU2OqjqBxw+LRdXRJ4GvSIm9qn5uzFSjomPlo0kU+AQMOHUcuRVwJgD6zSlzf+GuKUtwn2VoLUVsYLwm3MJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592990; c=relaxed/simple;
	bh=uiXQE0NRvooKnb00ZyDFhzitwmlzgW0GBH3yhlrAOPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COVAEO6zdBq3adN+n4BaRrHIWHCMN98+ZCmRJsl1UW9xua3PRV4EXUyLHUTgKkxqSbAYKgroFkz151HFTvYwELU49zyLzHCIeFm2E84/fes/pNaPX0+l1QTCCD0p58LbSLQnpBPo2zz/zJvnVAZ1rlnN+QqGQGg9itfFdiO2sAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yt4PjlWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755592987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nj9EkvlpuR2O71TRrkQ6effPG9eafUyoJmenDbBRkkc=;
	b=Yt4PjlWNTR33A17qSKrH/TVis3t3b//Nqh9rUTDOS1iF0b/a1nydLY1SPlMtv/z6eSECqw
	y+4KJ+KwFeWAO5a345R1WutrYy+LdLgu75ohWXhpPTSl3lTySfG+dFfc+XR6hF3nmshw9r
	iZflmXyzZTkOvfQA2c0Qm4oySpFRU2k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-zuw2onxnOkmBLGaIWbV7EA-1; Tue, 19 Aug 2025 04:43:05 -0400
X-MC-Unique: zuw2onxnOkmBLGaIWbV7EA-1
X-Mimecast-MFC-AGG-ID: zuw2onxnOkmBLGaIWbV7EA_1755592985
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109c7ad98so186919161cf.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 01:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592985; x=1756197785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj9EkvlpuR2O71TRrkQ6effPG9eafUyoJmenDbBRkkc=;
        b=JKTS1fD58aY/Oo97fGmgnAhOMxHmiGG98+q9ngzth/NdCFihdDkiHvoB4tiVV7G962
         lwigkmSCJ/iOq7QjgUba9fX2SV8vpafnufAR+/fQQWKw56FIA6JPccJS2bwK29V81bds
         0GGwQg0j8MIkPgeuy/zHCbLW7HBl1YpiTsOtZBMjwCqa4eHBGL9ejSgdH64JmrSUN2FY
         CRs3/uiKvMlSpfcUH+r86JoZJWakJW8iG6lDC4ZLQWNBrh7x4Xu4AEKBfGMsHZYeTOKt
         zgScodbel86fDvoI2B0r1dNWV93lU9CIjiZ37MHVqRUTm1+EPLopE/bXYr+WTtejOI6w
         9x0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5zyiV1XbxL0bwQN0EYqpN3WVndV25yzeZT0gCxKsT3lsSBzENvB1c/9yATpWzAZ30zSwVP7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZbFLjec+A8hDY+uksDW6RO0SUapTeBxf1csmkaBRNlMcrG1t
	3eOLs8QOwQ0karZWO01lV2CDg9fPivm6aQ6RCQ+fdY7ChjlcjSqecOtx41A3F77T4C0ke6cT1Mm
	MMYPT6BkgJUN5dmO1BaMLEtytKrh4w2TTojiVHrVQaATdoOTvMZif+5qwsQ==
X-Gm-Gg: ASbGncvZXq40kgfNtZ9PmTTx/VGAksHXIcpA1D1AwsCScfqYwUUgyWIMTbjJKxQVIkt
	D4ojU1tIl+zB3Rf9NE7y5w6596J5B4wSnqsjaEyIgxkjPbfuQ8RtgXSgqDc6OxdtqQyogylNfjp
	UBXIJrvpdmwlpWhR6sljeGXy+a3mGPBEwjwZndeTeWvKVKk/dNEbPBe0OoOMkCZZar/cUvws5DB
	+a8ZQh5KHB9WnLl1XFKXVHJsbUid28rxU7NH1+4RljJVhQfHFKcGCAI1CzYLdE69fIY0vUIXzXz
	z93bsOeUCxxouS7XAiW4kAZViCyUXotMxm9SIrXjngoArBwPOQrw7WpfDiiVLjQqv5jLridVULi
	qNVNRgBffObc=
X-Received: by 2002:a05:622a:4d03:b0:4af:1837:778e with SMTP id d75a77b69052e-4b286d9f7ebmr18161771cf.31.1755592985087;
        Tue, 19 Aug 2025 01:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw7UB9FBrpGjQ2XSRXKjMIthoW12C3rhlMGUbObj2mrt2S/t/HnOA8M/IRXI4lKNYc+qncPA==
X-Received: by 2002:a05:622a:4d03:b0:4af:1837:778e with SMTP id d75a77b69052e-4b286d9f7ebmr18161561cf.31.1755592984715;
        Tue, 19 Aug 2025 01:43:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc19631sm63346241cf.12.2025.08.19.01.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:43:04 -0700 (PDT)
Message-ID: <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
Date: Tue, 19 Aug 2025 10:43:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
To: Richard Cochran <richardcochran@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 Carolina Jubran <cjubran@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 4:17 PM, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Introduce two new ioctl commands, PTP_SYS_OFFSET_PRECISE_CYCLES and
> PTP_SYS_OFFSET_EXTENDED_CYCLES, to allow user space to access the
> raw free-running cycle counter from PTP devices.
> 
> These ioctls are variants of the existing PRECISE and EXTENDED
> offset queries, but instead of returning device time in realtime,
> they return the raw cycle counter value.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Hi Richard,

can we have a formal ack here?

Thanks,

Paolo


