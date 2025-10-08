Return-Path: <netdev+bounces-228164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F78BC37C6
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 08:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3A0A4E0F3E
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1319257AC2;
	Wed,  8 Oct 2025 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sou1kaY+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A721D3CA
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759905478; cv=none; b=PDcNITSTXapYPzPbMJUs0EexttWKQOUi0ftJ6+EN1zS7JV+yvEVOu7bI8gtd8bRrM06rUwUXbuQq0oYlF8JOzSdtP+wQ+ghaNMmUEhSmFpuSTkVRXV+fFcm3YIvSa7GgxIKq2dB8SoWSHcDdsn0xlR0JLwihvTO5mBSvDzYxqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759905478; c=relaxed/simple;
	bh=8QdAdishTyYfv71tuyUdozzYHm3+rtg1rq3Cwr/XbVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LA/l+6kMMfLO+igi+cgQy2x93q7gDn3/MVx9A9kgKFjS/Jv2IpdTZLjyn6JNN9lLVuk3AKd85pzxfxUB7ZiCFZs7KroB9SyBmaazs1H71z5LqDaQz2PmPB9lnoNZ/E/tPV28sWN/eMKKkibHQ38QN3++B4y+W7+yd+ndbUeofMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sou1kaY+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759905476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCoKGJrY9ItSJhO4qZWZixqx9U2vtkKjjoaRx6SQRnI=;
	b=Sou1kaY+X8M1WYsVxAees6PsG0Gb9EoR4R8Es5qQHT9vukGXzTzQIupGLPkdJ9meBCY6eR
	4Fy5FCwg9gVFIHtkw0rFGIjZsGUrPDKsp1mt0XPs70hF0Kx3T9lHmBNK6H5vcAFyibLDiN
	jMOGtEMV/WZD92WQlyIAr6s6AoDm45U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-N_2VIMmsOtSzOhm4TchJbA-1; Wed, 08 Oct 2025 02:37:52 -0400
X-MC-Unique: N_2VIMmsOtSzOhm4TchJbA-1
X-Mimecast-MFC-AGG-ID: N_2VIMmsOtSzOhm4TchJbA_1759905471
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f384f10762so3784329f8f.3
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 23:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759905471; x=1760510271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCoKGJrY9ItSJhO4qZWZixqx9U2vtkKjjoaRx6SQRnI=;
        b=Fb97gQKeJLjcOS3vh/UcOv9H0YklrrYOpYZw48+tVCs1XSIEzc59hDq4D5YOBxOo2e
         ILTkPG7rcbMfZ1GwfERWvHw0b6iC/iK+q/f4o5nQf9rRFTcsPBhQNGL6qJfSrDUYXkhE
         SdCikF+9GtQ7QAMnCjqhsw9V8HlRgaA7XdauCG7PL5JCOWedcmt5RJIfhKtY8tctLoLo
         mJW50lfpLLA88uyMmVIpzkXTkiuUkeBuW/MeU7Xxfts0jI2tP3dk8L1LyOh1EXpg88jf
         9YjxNvOFa4lRhgCJpxpxzFOVDBqFwQSe502JadGDiS7iu+6Xy3BFdxflLtdqW4M4HgCI
         czXw==
X-Forwarded-Encrypted: i=1; AJvYcCX4HSbuo5g77rOSaO1WU2slP/2J3hJ74vC5qLA6cstztos4XXoTZLRZzf7uU3cNR5Q1uosvTs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Wcx6uEDsaM1WKiF/4T+a+TlG78WM9tMn9jktw4JMjU239KPH
	qKjq/AHsORYD7a+/zTd2MnIjqGqy27mITOOboZLTW2JM1VEQfs0U8nKlUxxeqlfdTOcT/rRTqfj
	9KWwjYVw0MziBKPnQPucOZdiD6HCsiJqvf90H3TtwTOEaTYYHPV6hPdakJg==
X-Gm-Gg: ASbGncvgt3yQbu5oqBa6/xyFNjT34ecQ+/F8CQVu9EkxvG9IL8OqMjcrgPaIR0Gk1V/
	+EPwizoC8Klmw4y39Sq/7Zlsv608dmy9XvrJXMR6jrOJuzAWL07BKd/C1Rp6Ok3ko8Y4GQIGKob
	3aEyM5OK/jHDfUep76e0B7RH3ITr7VEjWiOC1IX0j8utYysTn51vBU0oRPHvFidurB19O6krEgt
	X9ta2eSGQOp7K/U46ckJLNmurdKS7hNmYI5TsGRL7df1hzmjxaPF+dBMMP4ML5LL7g426B7mUaR
	OqOFfAGlp+QcMc06L49858M90iQFrjJ67/1FpNBtBZAXUgCBNC9+bWENFXfxdGVT+/mddTUDOQo
	1cTvxLklWrDbjOprFVg==
X-Received: by 2002:a05:6000:26ca:b0:400:1bbb:d279 with SMTP id ffacd0b85a97d-4266e7d44f1mr1140993f8f.39.1759905471471;
        Tue, 07 Oct 2025 23:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE40fep1FaR2M7WsiBVuy8GPUnFsvZIKRHeaWxSKXFe7u0zA/5qdUcEU7HRu4ahzS6I9+Q3DA==
X-Received: by 2002:a05:6000:26ca:b0:400:1bbb:d279 with SMTP id ffacd0b85a97d-4266e7d44f1mr1140978f8f.39.1759905471027;
        Tue, 07 Oct 2025 23:37:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e980dsm30821138f8f.36.2025.10.07.23.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 23:37:50 -0700 (PDT)
Message-ID: <fcd97ca7-f293-49ce-bf01-3ba0001a7753@redhat.com>
Date: Wed, 8 Oct 2025 08:37:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20251006193103.2684156-1-edumazet@google.com>
 <20251006193103.2684156-6-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251006193103.2684156-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/6/25 9:31 PM, Eric Dumazet wrote:
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085c236319705aecba8c30cf 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -115,7 +115,9 @@ struct Qdisc {
>  	struct Qdisc            *next_sched;
>  	struct sk_buff_head	skb_bad_txq;
>  
> -	spinlock_t		busylock ____cacheline_aligned_in_smp;
> +	atomic_long_t		defer_count ____cacheline_aligned_in_smp;
> +	struct llist_head	defer_list;
> +

Dumb question: I guess the above brings back Qdisc to the original size
? (pre patch 4/5?) If so, perhaps is worth mentioning somewhere in the
commit message.

Thanks,

Paolo


