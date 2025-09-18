Return-Path: <netdev+bounces-224443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27098B84F12
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06A317A168
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146571F63D9;
	Thu, 18 Sep 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYgJcslS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E821171B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204079; cv=none; b=c+unOFNmcliXVPVJKL1zJl+LzufG8asLy18VjabmIw6/wl+Ps8KIK8UnH+5/53XgF9tPK8mcNZEsqj5cb8A+QpCz/UxLZnuNBfKwR8XSqN5j3ccHnCPLmpnViRHnYYE39XhWlHhqOCm8Hf426hMwbz0LsZd5NyoYL3sxmRlqe8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204079; c=relaxed/simple;
	bh=nQXbNFRGteQ5sQcKTS+R+cIbFxjMYn75rSXxx/muXvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVLHX1sCts+ywhaLmeqXstc9jCcEP90UBNl7AxFifAg2ZA0l479orpxW5GkXMupWx1RKUQ1f9Vz3sucEpomIMOM/dpc7qF2H4LWY+rzF6TyFSkXTeX4xwbiUoHzEmBlZWM6s4w9mcQ/N1KbFwN4lLAmSXd5U7jDbeC0Tv867Z7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYgJcslS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45ed646b656so9994885e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758204076; x=1758808876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaWUgxon+Xb6FrjH6O0C9Bi3oSkKAAwiP/2JQApbLis=;
        b=hYgJcslSxCvnZQtTddvsA29OtOhIJcTzb/4Ib8LZWr/H4tTqaQmaQdKiW6FKMj+e/0
         a/8nr6QgjgKdM+iylpNS1u3bhIp5m8DIPxKouBtxRmvrmHj+8dyfbim3TaYdIF61lW0/
         oZE8WOVVuVu7BAbmzosyfC2tLDMUm3Em+TKF1zMNXEs80PizFBvCFXHxxUychtLdgqlA
         5PFccquZBnYoSsj6Z2/4QZoQNYIXkD1x33Bw19gYffDBc6Vmy+j02pNaPCdsE8lr3To6
         EkAU+k1cCgvBo1vNxMb01Rw1GihZjz2WiblX7iSxuYnooWuO1v681LUA8XjDL8jQ2hpv
         xDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204076; x=1758808876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zaWUgxon+Xb6FrjH6O0C9Bi3oSkKAAwiP/2JQApbLis=;
        b=ZB6qFlBbNc5dhG4kT/MY6YKjbEDJT9vFBGBBo0jJOp/4hyaHVNw4jhLD9ZLPJbIY2e
         hMBtoNOrvECIzy7ql9draDJIOdeGU1UxlMopvibCwajFtZEJ/xnPKxJQ3UobIorrFUj7
         cPDqk1grhGToeOdpusyOOAb6H8e1zxbNQlPeMgGd+xi7SxQc88/STJ/WmEvt4rm/yg/U
         RYB44bCspI6CefvMB2+SaiKDks49IpvGaDb6N48W2/EuejMIiVdhC0qh61HQd4zMOnFM
         pj4JNM4neMpa4QYZ/MiE4jVvTeeueTQwRgyBVjiyfyFs4Hi9qTy4TtFDi6U5yMbf4Qf/
         G2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWizIa6XEuHo2CR8kXi8Lzg4iCJ70ZHfGZfDILckh+OlNiYpVWJ8PjAYYMuVyeD+aELjqnw/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV5i6pD5V3qElkExCYf22TNcLPpSRDtt7kAvDA71fjlZtOGTqy
	6vFnh4Ij/1r4aIkmTEQp3Ki4ea3sc/KZD9m09kQHjXZ9UUmQlykrSdYJ
X-Gm-Gg: ASbGncu+reHEwGBPY6A0sqQqFo3fnudZOpDYHMSaUG9JKem5hhGJEuduWPiJURrVHTz
	L6PaVScpDM6VkHBVrCKze9rZMt0LThIogjia24pmbca0XQauRwbwzYsENZIyE4EpBAHA/dEg5jz
	ICLtJKAapAWEOJIV9TMQG/aclFsMu3DjUxRIawYNJ4DARoV69KJ+PwDw7T9+bcFkOPeXet1ibiD
	x4LGESfv2Fqr9osGQQFOCpuhv072ErYncc+GfWgP0fYvNgzIH6qHjmhrMJ79+gNpwIvC4TwOnZV
	b17Ba+IdxjD9MZqfq3sruc91vrFDCJzLkpMmh+Q85QVdVJqFC5iKnxdUyO7w0GBv6rQMovou4kR
	EGxB2SLSBslEA5o3QPUqgiFOfIKSrAnXmfquS7ljHZg==
X-Google-Smtp-Source: AGHT+IERhi0ttbTQo7U5CDSJQlptbQTdHlo+lnabNgzEp0i9XMu8w6gt9JnH1CQDgn2GAUpwL99/Jw==
X-Received: by 2002:a05:600c:350d:b0:45f:28ed:6e22 with SMTP id 5b1f17b1804b1-46202175f42mr59095015e9.3.1758204076009;
        Thu, 18 Sep 2025 07:01:16 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461eefee9f3sm77154855e9.1.2025.09.18.07.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:01:14 -0700 (PDT)
Message-ID: <84aea541-7472-4b38-b58d-2e958bde4f98@gmail.com>
Date: Thu, 18 Sep 2025 16:01:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 ecree.xilinx@gmail.com, willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-5-richardbgobert@gmail.com>
 <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 9/16/25 4:48 PM, Richard Gobert wrote:
>> Currently, packets with fixed IDs will be merged only if their
>> don't-fragment bit is set. This restriction is unnecessary since
>> packets without the don't-fragment bit will be forwarded as-is even
>> if they were merged together. The merged packets will be segmented
>> into their original forms before being forwarded, either by GSO or
>> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
>> is set, in which case the IDs can become incrementing, which is also fine.
>>
>> Note that IP fragmentation is not an issue here, since packets are
>> segmented before being further fragmented. Fragmentation happens the
>> same way regardless of whether the packets were first merged together.
> 
> I agree with Willem, that an explicit assertion somewhere (in
> ip_do_fragmentation?!?) could be useful.
> 

As I replied to Willem, I'll mention ip_finish_output_gso explicitly in the
commit message.

Or did you mean I should add some type of WARN_ON assertion that ip_do_fragment isn't
called for GSO packets?

> Also I'm not sure that "packets are segmented before being further
> fragmented" is always true for the OVS forwarding scenario.
> 

If this is really the case, it is a bug in OVS. Segmentation is required before
fragmentation as otherwise GRO isn't transparent and fragments will be forwarded
that contain data from multiple different packets. It's also probably less efficient,
if the segment size is smaller than the MTU. I think this should be addressed in a
separate patch series.

I'll also mention OVS in the commit message.

> /P
> 


