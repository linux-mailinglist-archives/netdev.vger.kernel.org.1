Return-Path: <netdev+bounces-228252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB1DBC59B5
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 17:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE783B0093
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF44F29D276;
	Wed,  8 Oct 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvqN+Pt9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4529BDB5
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937416; cv=none; b=XRadr4XY+/un2Hj7jw3/X2B3WnWXNTAisodtQjSuNBWDvMh4k2tgvx7DGvuER/S1tKqRiBfUpDcp6ns/SpUT1Xdm15gWcSpkDCuOaOSHgbUnzdGn0fZYxdnHOTE3TmvXSDL/syFlF8tGvjDxkTPabZK5lqttrf1Ogcw45Y63nPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937416; c=relaxed/simple;
	bh=w/VEFyxmLLN2A5352uuXicO+LqJKeLrUcoP9viKobSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C893iT7CFY6GFP3yM03YcxaSA3b15qgqB1MSJlATR/kV5JRAKwPYpmB8gbkxHlqIcMMbqJxKBZyHDri1A91wkKh5cVpEGy5FlByKatBzRHNW4dtC0Vt4VQPAhKtzLDy6yZ92Rg4Yw+rPC5fyrfxY9OH35TPe7MIHy9ug/jFf5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvqN+Pt9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759937414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6UioTYNvKZxdyVBmKfGPE6EGuoULDF/QHzmdxt36Bg=;
	b=GvqN+Pt9Hc5axShp9/ostNV7cw58IEvxjm8onpf/B4BS9mR0amt0ESA7yvfNSbPcywaEsI
	bHB8trjHWQ/f1qjFll9ho5g7HB/eCXtsBO3QzNC5mrYr0VWaCXM1fGVivkxCX4MjXEsFZl
	/9OI19Q+PQ3aRRl8uoK/xHMdImOKb3w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-NPcGaSu9OwqcPg_j8WnZZg-1; Wed, 08 Oct 2025 11:30:10 -0400
X-MC-Unique: NPcGaSu9OwqcPg_j8WnZZg-1
X-Mimecast-MFC-AGG-ID: NPcGaSu9OwqcPg_j8WnZZg_1759937409
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e509374dcso33103925e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 08:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759937409; x=1760542209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6UioTYNvKZxdyVBmKfGPE6EGuoULDF/QHzmdxt36Bg=;
        b=xEOiZTzOhyUeNN9fIbJAm6lsYH8K1/vVr36hInBz9mAjRpuA3q0rLuGs/nBI5j2kIX
         LbCmkcR5YGQ41NbSMGwpfJ+uqKCah0o8hygRwAAWyNf7/CCrVb/aMM7ddJdrTvGohPV+
         RLjSvBvXRxNjF3F1FlwPgjCLDD91Vis4rLS5OQXO+sSkyEu6VUO4R8cO6lP7xBfZI5hA
         HxbKz1/b2+yqmMrR6OSDj0SsxypSJeu+H5HHQrGwFnJD3TMNgSGebIKmY5WpVD+Sml1H
         JhfLWGlXnsALULZY11WkHn44Y0/i0Px66pWafDt7kZFGUlZLcFyG83wl0Q8luF+KT4Ds
         G7/A==
X-Forwarded-Encrypted: i=1; AJvYcCUO3wpFbF8Ha1ivhLGN1bJ3pv7DVPRFgTljrKjdGk0MCNneDrVjyHX8klY4IGHSZyIDm90c3X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzryDunNgs3nVe54wTnp5eyJ0zCScdG/T+cQK4RrOWbFS36u+hK
	NCY40kAyAI9xGLa+qKu20dO8HCI/MohD098xHlNsvxzPp6DkW+INTE7a0FeH5Tbhll2UdjBiMq6
	lYTkZvNpHcX9AGkFwa1EvlfLI6uHtqUIjLTLv24K76uUVTCtW7EAOugGhAg==
X-Gm-Gg: ASbGncvEQTFQjycZP9WYmJX0yeKsBLAZpMKbj03e3O9tTIjdv7zHyg5HmDwdslRf7PO
	vabdyy07JD/qJfWQ3RlcVJXgmDXuRmfba3MKKZTFmHsl7vAxGL+Oq6U4WLovAAgR3cIyy3Thow0
	R5+CMDlDls4u6w2epfh7JVRetVltfgTXGhPrka9S4jBXnjFWTHCqV7xGK2PEZRSumBi2nGqVEqi
	0p8l5TubGo4i1rFerY4pb7wZ8eeABG5LOWvQ+MIQZeen7mg+n0wVe79QIChBy/Vto7CtUEp4ltJ
	rcIx3d/A5IQzNznJRvqx6g7/lQ1U5ohUxlz214iCOeai0oyni8H2nh5UAAQJF05Dcon7aWYA88l
	6+fqeZv0Xx/ZoA99CIg==
X-Received: by 2002:a05:600c:4690:b0:46e:3dc2:ebac with SMTP id 5b1f17b1804b1-46fa9afbb62mr26981025e9.27.1759937409472;
        Wed, 08 Oct 2025 08:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5q+MhSfmuawxbxLjnG9Ywry6mQ2ilQKjaJeT0WQpYI9QfBOsaQn3GijlyrlyNxXP8jAkp2Q==
X-Received: by 2002:a05:600c:4690:b0:46e:3dc2:ebac with SMTP id 5b1f17b1804b1-46fa9afbb62mr26980805e9.27.1759937409033;
        Wed, 08 Oct 2025 08:30:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3703adsm16407195e9.0.2025.10.08.08.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 08:30:08 -0700 (PDT)
Message-ID: <eba94a12-299a-46db-adf1-5f37f1b9b993@redhat.com>
Date: Wed, 8 Oct 2025 17:30:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 4/4] net: allow busy connected flows to
 switch tx queues
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251008104612.1824200-1-edumazet@google.com>
 <20251008104612.1824200-5-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251008104612.1824200-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 12:46 PM, Eric Dumazet wrote:
> This is a followup of commit 726e9e8b94b9 ("tcp: refine
> skb->ooo_okay setting") and to the prior commit in this series
> ("net: control skb->ooo_okay from skb_set_owner_w()")
> 
> skb->ooo_okay might never be set for bulk flows that always
> have at least one skb in a qdisc queue of NIC queue,
> especially if TX completion is delayed because of a stressed cpu.
> 
> The so-called "strange attractors" has caused many performance
> issues, we need to do better.

I must admit my ignorance about the topic, do you have any reference handy?

> @@ -1984,6 +1985,14 @@ static inline int sk_receive_skb(struct sock *sk, struct sk_buff *skb,
>  	return __sk_receive_skb(sk, skb, nested, 1, true);
>  }
>  
> +/* This helper checks if a socket is a full socket,
> + * ie _not_ a timewait or request socket.
> + */
> +static inline bool sk_fullsock(const struct sock *sk)
> +{
> +	return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
> +}
> +

I'm possibly low on coffee, but it looks like it's not needed to move
around sk_fullsock() ?!? possibly sk_tx_queue_get() remained inline in a
previous version of the patch?

Thanks,

Paolo


