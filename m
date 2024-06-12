Return-Path: <netdev+bounces-102903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D7590562B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE6F1F25025
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24A17F4F4;
	Wed, 12 Jun 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDj1WfsB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECFC17E90A
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204478; cv=none; b=AsjtCvrlTEtGYZeSpNn4yzmXUhuPKTWESfbx12QZPxXDka+ibZ7fOhv85bEjM1pRc/BwJSHoQwA7DpXH9iIAX/qMhiKqCEKV+m3yNpWE7A4jZIzc/DfWlmo9HnN8zS8Pms6FQRcRmW3eTat2MKcwEe/Lkagt1FkBmHC/eLlT8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204478; c=relaxed/simple;
	bh=99ZGerARksGUGdw+E23Lcu8HvgTTG9/x1SmFsKpGl20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H04ruVfu5h4mhW1YDdnv8o4RbTA807wB1wtEifDF5Kukn+o9lD0zKyP6QVkMuNr5zccdTVUZEJJCkxCVHyUE5ETDU1z+Jqq4J+AnR4AWXV9/OmE+rxAkOIXk/Qhg4ZhBwFd5DN0bJpQFFHE1wyzh0y7lwlEvRHU8Da+cXKKulD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDj1WfsB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718204475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AK7Qzf/MhUoQm7mnY6EWFd26DeQUWTNXILgKlaTUO3c=;
	b=QDj1WfsB2sdRk4686bgM+Z0fQaKmPA9J1VMIqZX2ikjbT+ZDIPtSKDUhfi9GV9U4P1GqtI
	oEG+5Gdm4Eg26yhrx//TyyrA+V2jx8tqflB4alJa3WAH8rIAXyCRYMAtZJ9w2t7z7dFvOX
	y6waXPtaiGpNUg7AEdnXINn1UPdwfts=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-XXqtnTALNr628rlA0TYuow-1; Wed, 12 Jun 2024 11:01:13 -0400
X-MC-Unique: XXqtnTALNr628rlA0TYuow-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ebf7a0ed89so12806291fa.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 08:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204472; x=1718809272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK7Qzf/MhUoQm7mnY6EWFd26DeQUWTNXILgKlaTUO3c=;
        b=Yegrr2dYyavFXgBDhj/wz6rOTV3DFF24QvwhEuf9yjXk9s4U3FXV/2SrpEIYOia6rw
         7dH6xqYA2kYX81OyipBZGW7HPZLywFb77h7aH4qrzUh/NEyQR1j9KQub1rI+SHsqwwS+
         8jT2ENpTYUDPKezwF9lfMFwgbjNPZnlC2Em3SkegaT9BZZUkxQEQVH9da4qUIXAB/2Av
         FqDuljqk+26p1zZkYdg9SOfbui+9K87LPV31fqmpdO1MBMgwzIvHZ7zrLsk3rccLhHiD
         RJHnWM6YqXCpe0Ew+K0iIw3ETy2sMdIc/uwlhkJzHCX+7S/fihBpYlnEgEQ6rldTjy6N
         AxGw==
X-Forwarded-Encrypted: i=1; AJvYcCU48fgFDh1I7Ssga89yJYddlSLldref9f/VbeScwsFzoJSwFULEdLmdp+YNFA9WXcahE19apd2cKCtXUGID7e46eNo1func
X-Gm-Message-State: AOJu0YyYm1bX/RMvou5u0kfa+LFCkJSw3sBiR5b6nsOFdpFAykazwiwW
	5an9m3/qXRPs7dCtLkUCWMoLBnupQDUlcqvU4hlA32ID3Zw89w/rgHRnlk94H1ualWrpcXhY+c9
	LcweIDofWAqLiCjZWonarKWJdZCvyMjQWR6cwm6R45rt0iG+rCAfsqQ==
X-Received: by 2002:a2e:99c7:0:b0:2ea:e98e:4399 with SMTP id 38308e7fff4ca-2ebfc94de35mr14250811fa.36.1718204472176;
        Wed, 12 Jun 2024 08:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTuPBgbKAFLkoD5DUY4zQdrl9+ofAljCO8M4EqUgORhCBOFn2MvAE0KtkNSgtX7OadYbchrQ==
X-Received: by 2002:a2e:99c7:0:b0:2ea:e98e:4399 with SMTP id 38308e7fff4ca-2ebfc94de35mr14250531fa.36.1718204471700;
        Wed, 12 Jun 2024 08:01:11 -0700 (PDT)
Received: from localhost (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f26578176sm7756461f8f.11.2024.06.12.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:01:10 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:01:04 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/9] net/sched: flower: define new tunnel
 flags
Message-ID: <Zmm4MMX_WFFEfLFd@dcaratti.users.ipa.redhat.com>
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611235355.177667-2-ast@fiberby.net>

On Tue, Jun 11, 2024 at 11:53:34PM +0000, Asbjørn Sloth Tønnesen wrote:
> Define new TCA_FLOWER_KEY_FLAGS_* flags for use in struct
> flow_dissector_key_control, covering the same flags
> as currently exposed through TCA_FLOWER_KEY_ENC_FLAGS,
> but assign them new bit positions in so that they don't
> conflict with existing TCA_FLOWER_KEY_FLAGS_* flags.
> 
> Synchronize FLOW_DIS_* flags, but put the new flags
> under FLOW_DIS_F_*. The idea is that we can later, move
> the existing flags under FLOW_DIS_F_* as well.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  include/net/flow_dissector.h | 17 +++++++++++++----
>  include/uapi/linux/pkt_cls.h |  5 +++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
> index 99626475c3f4a..1f0fddb29a0d8 100644
> --- a/include/net/flow_dissector.h
> +++ b/include/net/flow_dissector.h
> @@ -16,7 +16,8 @@ struct sk_buff;
>   * struct flow_dissector_key_control:
>   * @thoff:     Transport header offset
>   * @addr_type: Type of key. One of FLOW_DISSECTOR_KEY_*
> - * @flags:     Key flags. Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION)
> + * @flags:     Key flags.
> + *             Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION|F_*)

^^ nit: there was a typo in the original line above. Maybe this is a
good chance to put the missing '|' before 'ENCAPSULATION'



