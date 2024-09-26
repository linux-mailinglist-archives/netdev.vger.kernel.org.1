Return-Path: <netdev+bounces-129904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AEE986F73
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A401C2264D
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098FF1AB519;
	Thu, 26 Sep 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvpbpd6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B85610B
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341234; cv=none; b=GBLF437pU7I123FB/sqOjOwB/98V8AFYHL7crd1AVtdzminEnW0G/6sWQUsq3g0GCV9qsyNoTyt50hC5El1JwTUqjMOOCQgUoD/cYIkJCKOt5vqJgZjBGgHoYn03vlNgAhCzH4S41ImIP8CUwza5iTBbXkWt86rw3Y05d/0EVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341234; c=relaxed/simple;
	bh=Ylk5SZRF9WfTas4yPB7Ltr/fZfo3RPQ+b3ki8Dz8a9M=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ShwLqyc/buWoDhfqnms1Y1y2p7GtEE+646JB3jWJ2i8VLS8KaPjNs/UWgCHgPRlb885Fa+Q9t1gq26kKn+sk6Enh4dN9qQI3AdkT3069jfNm1S6u8zyZxRLmt/m+O3Wa+9o5Jd8LpKzdIQvk4EqbWYVf6q1dbaCN0eNtTL1IYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvpbpd6T; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cb29ff33c5so6058476d6.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727341232; x=1727946032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiQhIWIX8gXL7HcEw4XjLkYj1EE3qMu2krkX0MOf4QY=;
        b=Tvpbpd6T65vhoo1GJqCZcg4TkvM2XwKMRjQyH7kzWjX1qX9/d9qA5Q8Veiaxw5L6VB
         iLiW+SHuwYqgYExw3lrsgGJKGsH12DFRn6CTOf/0Wupv07NWXmkV1CrG1SnYZxJzT5AM
         8lHp5Vkok2ApUm6zUrWEfjmmc2bW91pLaJvk1BVU66moDGJabScWCGV6Wma2BJPlVkLx
         BKrZGXdeS4vClrX31x8mMq6y+yzb9Six9+GLGgTKuIMYV25lQHAOZxP0F6BhhNignGLq
         2/Fz3LgktQugHRN61d4myGh3YdYFTs9ueB14ObDrTvFufH9Y3XfaBo5cMnWxpeEjNvDj
         1WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341232; x=1727946032;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiQhIWIX8gXL7HcEw4XjLkYj1EE3qMu2krkX0MOf4QY=;
        b=G97BQnGkzuAVfdJ6R7DjtcWf4AYlvOd928HyaM6cHoRBUJ4XJlMMcW7I9xB5yvwlxa
         mCCDtQV1bHaQqtI4zur4ZFPbw3afHbmUcuXAnFiKjNqE+OX19OucorLbg1QsBhpU4M24
         BR36HjD7oKBm1No2kusg6yX+0hM+cXhLmK7DN/1CFL0N6TXZ90RHDfQdy9s5Fw2vTt5P
         HlCNHUveB2CDMKYwR35PywQCU1K+jTvKwl6F+dL5WmCxL2XhpHWgAj1DeZCLiSL/FFxY
         Q6KAmw+8V7A4OLFB2mVFhaVh0J/o9uLq2KvEvStThX6nTAcKss/9Pk2jdo6Z34tvcFYs
         kLFA==
X-Forwarded-Encrypted: i=1; AJvYcCXCKc7Icf9+yzzyj6nczafJAVM1qz1GTdQECsfHxUHtY7UpBkxqKob2vGnb18wQ+ez1NFehMuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOGmYyFJ6dncdUsTplqjGxY5DhcQf3oBsBke64XvcbmM52G6A
	iCLKXsvaV6YWgqctWD+bTChP6inErEjZFN/C1iPNFT0PKYDfG/D3
X-Google-Smtp-Source: AGHT+IG4ka5lXgF4UBoA+k+frBMfPvwrOQ3TCMk7SbWkyNJkg7+tSCEVGzbrd5wvEDqVbJG+6X0rMQ==
X-Received: by 2002:a05:6214:5c0a:b0:6cb:36ac:d47d with SMTP id 6a1803df08f44-6cb36ace19fmr10877296d6.11.1727341232118;
        Thu, 26 Sep 2024 02:00:32 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb27cbdf44sm10680746d6.67.2024.09.26.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:00:30 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:00:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66f522ae74384_84561294f8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240926085315.51524-1-nbd@nbd.name>
References: <20240926085315.51524-1-nbd@nbd.name>
Subject: Re: [PATCH net] net: gso: fix tcp fraglist segmentation after pull
 from frag_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> Detect tcp gso fraglist skbs with corrupted geometry (see below) and
> pass these to skb_segment instead of skb_segment_list, as the first
> can segment them correctly.
> 
> Valid SKB_GSO_FRAGLIST skbs
> - consist of two or more segments
> - the head_skb holds the protocol headers plus first gso_size
> - one or more frag_list skbs hold exactly one segment
> - all but the last must be gso_size
> 
> Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> modify these skbs, breaking these invariants.
> 
> In extreme cases they pull all data into skb linear. For TCP, this
> causes a NULL ptr deref in __tcpv4_gso_segment_list_csum at
> tcp_hdr(seg->next).
> 
> Detect invalid geometry due to pull, by checking head_skb size.
> Don't just drop, as this may blackhole a destination. Convert to be
> able to pass to regular skb_segment.
> 
> Approach and description based on a patch by Willem de Bruijn.
> 
> Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
> Link: https://lore.kernel.org/netdev/20240922150450.3873767-1-willemdebruijn.kernel@gmail.com/
> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
> Cc: stable@vger.kernel.org
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Willem de Bruijn <willemb@google.com>

