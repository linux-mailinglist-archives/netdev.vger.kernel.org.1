Return-Path: <netdev+bounces-215323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867C0B2E179
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927DD1883B10
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449432253B;
	Wed, 20 Aug 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SglFcrPp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E69321F47
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704752; cv=none; b=Hcfud9Rhs+UW67XxjCLh2jxXP8XHKcssYIbc8DqI1dxE3LkStN90YELYEnUf7DkRRNzvtMvUpBH9VArt88bAIAoT0LH81JvXL9liwQiWV1K0MdtFAdHQBgxHxSJ7XYCVlSm1/BNYrAYQCGh/vTy1KsVqaCmhEHBl4OAh+d8Rwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704752; c=relaxed/simple;
	bh=PF7834m2zmBGeYNYT92AdeweVy9hXj/FOYFfPOv3ciI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBYsEX63bD5J2zTjEbe9AVwD3fIIt7smtrgV91Shr5yIAqH5fzDvjeyfQ+t3EKgkI1YuQ+O/dxbw0CE+jaCVdaoj1+B/VUlBL5vj5jeXl0frbbLSMD3jATVfFwtiAacwKGGjkCu/Uh8Yd5LTAgGvV+GiuoYGwMHCpl4+pQzv0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SglFcrPp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755704749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaIQl8sxIrb95R4ZFBO0Jfm8W4+5z/KA412HXcZp9KM=;
	b=SglFcrPpzgDK6BYa4iXbnLpWSFuJMe+NaorZ2C51JhmWdGi/JdPb59vkqy2sMNUSVfG44z
	gKtLVJ6BimJ36rnHx1MqeM7f4kLiOKgSwcp0ojXXsvI7d9AETP49lTlmUbOxILwsR27VUU
	fM1bJeEgG8yR6rIu3xzwZZJa1qNkuXs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-jnDLKpWzOQeciWY9WukJ8Q-1; Wed, 20 Aug 2025 11:45:48 -0400
X-MC-Unique: jnDLKpWzOQeciWY9WukJ8Q-1
X-Mimecast-MFC-AGG-ID: jnDLKpWzOQeciWY9WukJ8Q_1755704747
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9edf34ad0so29978f8f.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 08:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704747; x=1756309547;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaIQl8sxIrb95R4ZFBO0Jfm8W4+5z/KA412HXcZp9KM=;
        b=AcOh4baxyqt3+Mtrze9wUNonGV+eXyN5JD0PgbncCHzdnRIltXhRpYGhL77DGY03jI
         CM4XTSsZP3ari2osLr60a0XHHBNtLpvfm4/ZZjniwkfjyAZKVcxQKSs5LdWEorpY5U81
         9wTzFNaP55YpYeSZU7AY+H/TfyXhgXeUEP0AWqW9yrWV8x35m23d/tdAWrSAYlUGph2q
         QZSTz4MgwJD2ixpZdpHNS0RHw305wSuJv3cbUOZTefjcx//i87LFCxyxdJyc8jSOi3aG
         DAqi5RCH8+5DBMbqGdipWVmpGu1F994eiurt9SSkPlWw7odBq0tYGWSXHTiMhF215nZI
         a9gA==
X-Gm-Message-State: AOJu0YxlJyxn39GdlBHgBmkWxxXUBZALcyiddChU0l55StrNnG2dhJIN
	GCOdqk7XDP+oH6siR1SlALXxFnSpMgosJiNX/swFp4RXVScDbt24Zl5AizPjlHu19UZVW73KBJQ
	KZ/SYWmEel2354iVPnh+8N1dTfqgosh2QGltGfRnbnlxtobpHGyvqGTGQlw==
X-Gm-Gg: ASbGncujgZOR7bqoI3XPgGgGO6EojFYI3G9I5bBmNXWj1imH0cK8ygP97WGGhUd8Afq
	p8cRQMR+cBoa3AhTW/D+6bKymdqBKC3u7+iYPRbCexG8FEpwKFolgp7KvxDIDhd5Wj46i2oseam
	FgT8cRfJeM92YyQfP2YVEe3rFjA+lMMLHZYOiP3zJBwATIybeAqeQdVT7xD6d4bGv3PbW9JxmEG
	WS9CDXxj2eX1RSrflQ+AH8noFYPX2U6HM7XFgoZVNw6P7IzwnAb669h/aHAlLrDwg/RoMiZVl8+
	OfWfwnbJCNwBIKag/ogznOWDurkai+xR9gzS5RF/SNMtIPahm9KPnFHPRTkiSf6UaRR8
X-Received: by 2002:a05:6000:420d:b0:3b9:1d32:cf4a with SMTP id ffacd0b85a97d-3c32e6fe728mr2870330f8f.44.1755704747138;
        Wed, 20 Aug 2025 08:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEft7cxfwgnuC9fvgTvhd5Lg5v+e3eJCWb3Fa4JXUDbgyRD6cxdCOQrdQIX6hHvos7uCBDKZQ==
X-Received: by 2002:a05:6000:420d:b0:3b9:1d32:cf4a with SMTP id ffacd0b85a97d-3c32e6fe728mr2870305f8f.44.1755704746638;
        Wed, 20 Aug 2025 08:45:46 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c07487a009sm8151635f8f.11.2025.08.20.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:45:46 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:45:45 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, <netfilter-devel@vger.kernel.org>,
 pablo@netfilter.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next 4/6] netfilter: nft_set_pipapo: use avx2
 algorithm for insertions too
Message-ID: <20250820174545.398b2373@elisabeth>
In-Reply-To: <20250820144738.24250-5-fw@strlen.de>
References: <20250820144738.24250-1-fw@strlen.de>
	<20250820144738.24250-5-fw@strlen.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 16:47:36 +0200
Florian Westphal <fw@strlen.de> wrote:

> Always prefer the avx2 implementation if its available.
> This greatly improves insertion performance (each insertion
> checks if the new element would overlap with an existing one):
> 
> time nft -f - <<EOF
> table ip pipapo {
> 	set s {
> 		typeof ip saddr . tcp dport
> 		flags interval
> 		size 800000
> 		elements = { 10.1.1.1 - 10.1.1.4 . 3996,
> [.. 800k entries elided .. ]
> 
> before:
> real    1m55.993s
> user    0m2.505s
> sys     1m53.296s
> 
> after:
> real    0m42.586s
> user    0m2.554s
> sys     0m39.811s
> 
> Fold patch from Sebastian:
> 
> kernel_fpu_begin_mask()/ _end() remains in pipapo_get_avx2() where it is
> required.
> 
> A followup patch will add local_lock_t to struct nft_pipapo_scratch in
> order to protect the map pointer. The lock can not be acquired in
> preemption disabled context which is what kernel_fpu_begin*() does.
> 
> Link: https://lore.kernel.org/netfilter-devel/20250818110213.1319982-2-bigeasy@linutronix.de/
> Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


