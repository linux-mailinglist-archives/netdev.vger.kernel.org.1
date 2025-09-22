Return-Path: <netdev+bounces-225148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D5B8F76A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515A418A06E7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E327C145;
	Mon, 22 Sep 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Skx6qUaT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B33208
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529189; cv=none; b=TbCD06PAnGHBBczYLPLfYbgjz9xTr6bjxMPhihIZYwABd6cvTwhWWH+/W1z7nNRhalxplEaB5sDZkIPAPmrN151ZzbkpmdtGebQlDiGdVZdWmsR/ch61+TYAgpwsUNAHfUQ9Czw1zDHutUeChSTXJ2+n7wXppSG8ZGAeXyPkLQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529189; c=relaxed/simple;
	bh=K2/rQ6To9i9ckyz2T50PifW0JmcGKmlDf3QsXMOqyZY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h1+bcVb4XS4b2+9lIRpw8ta5UMYXVqQOTZAIz2q99xir0+6ooCRclQaoTZwwAO3P5lzvAKV3k19tFslejVDJ/1Hgvd9cNK49Qcuv8FG0lzk7s7VRODS+0bv1HCvznHaJyzZW7b347WgBDxRUa3fY4q3AhOp+B9K+b/uL+3VJBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Skx6qUaT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so2697631f8f.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 01:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758529186; x=1759133986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eFUoaADEJUXxpmJkZmDd+dJWMDH9tDpqU2+evv3MTk=;
        b=Skx6qUaT+Ly9VuTj8G27LqS4Rd48a17HdxHtDglpMbXNxPXCcgHloga2Xy6nB3T5AG
         etjZOSShYfkgRLBaiWACOKa0ViO5os34axIl7Z+JGkSKbxDE1m1MYtVYPkyoKbbc1BSV
         aOaMzbBa9Y694sqRx/1jVEzCCFu3Quvd6TgvObJb6SdUdOow0wQNNyqR53hjoQq4lHEk
         2zcgxgUvP5wAYbwtMbRTAlUcTbjGEyLpaztadnDJenGW62158rUC1FM9dcG/bBKqNqCx
         9YfBdYPQwpehMv+GqLtyxcbgMRco7DzjPwGf5f+NlrrM3cxe5TMaUKGqz9HXByCnSQP3
         DSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529186; x=1759133986;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9eFUoaADEJUXxpmJkZmDd+dJWMDH9tDpqU2+evv3MTk=;
        b=XT6CbAgIGGcFSqh7Ga94mLKpAzkivLUuPf4QxL+IpZeXl1IOE71vo0/aBi77Xk5T+g
         VL5fZqJppyLHi3mfm47GcbZIuxRXs+lM+lQwjRvbE6jNZJoLnO5+ZpE9bfMZmnDMbh79
         ZF04ku6XlszQm/ssEMya3lVR9ggaeJ2T9Wt0Lcu66VA6/JMFejWaTfPKMimenCBkuKQd
         i+4kDae6Col8v14eeqXW+I4Hjr3FbMyvrNxip9hbo1/IvVZ0Zd8VSu9fzMvN6DACd2n0
         hpg0iLhr+YP5uFhmnRzgEUpC9Oc2qLZR6s5+B3uiMgz/QqSmTCjGphy+HPdVc43yMlmT
         zOdA==
X-Forwarded-Encrypted: i=1; AJvYcCUIa11MXe2Rvau07UcCiAx6VktV3cu5spU9E/tPDLujnsJPQ79rqaJyGqBlyDxBkY90L193RAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWTjLicV58jCi+skrfy8o7CjIsMaMwByHY4Pv2ltXfJu7YPJC
	vomZTbdWbNsqdpg2oTdpIznFcQbBOyLF46ORIC+PFKBFqgw0U/a8M1+4
X-Gm-Gg: ASbGnctLeVCWrjMEDeZx6+RrZw8L9jt13ETwgyo8ou/OxI7xtsbVVjdmhUuDt33QT0h
	tGFEECPoCzmh03B2KKsDanP7WmEZFGeP1MyFHs8sjTZiF4Ncin2vULjks5jU0eroHvR12IkmIzE
	KZK5ULubQEMYfEut/a+3OLY+8TG5j6/HRuFW8FyfTdLb0etVpIPVmEWE9QP39dXxY8+jodQcv55
	pMhk2/Ewon1V3c7uKPXSM1Zufr2Vi+ecc1l2ybvEqXmtuWp/cmLHyCax0hw+i6gqH4o1syZTCYC
	E3DIjjxOGprbwf37xdS6Zh2VI8V3QLuL9Zu2Y76LySllnp5/4QgSm5cMrNNuTK/earOo/qbOIE7
	DoEanTF7FoO2bZfhGuxYj7yI=
X-Google-Smtp-Source: AGHT+IEEXkD/rrigPiSf7OYSZfYz+0+remElgWQOkN8iPWl4zp//tgyKK9hLccfYO7s90fsH8kGwQQ==
X-Received: by 2002:a5d:5d8a:0:b0:3ec:c50c:715d with SMTP id ffacd0b85a97d-3ee7f9d9d92mr11023945f8f.23.1758529186017;
        Mon, 22 Sep 2025 01:19:46 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ef166e62e5sm13956914f8f.40.2025.09.22.01.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:19:45 -0700 (PDT)
Message-ID: <d88f374a-07ff-46ff-aa04-a205c2d85a4c@gmail.com>
Date: Mon, 22 Sep 2025 10:19:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
From: Richard Gobert <richardbgobert@gmail.com>
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
 <84aea541-7472-4b38-b58d-2e958bde4f98@gmail.com>
In-Reply-To: <84aea541-7472-4b38-b58d-2e958bde4f98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Paolo Abeni wrote:
>> On 9/16/25 4:48 PM, Richard Gobert wrote:
>>> Currently, packets with fixed IDs will be merged only if their
>>> don't-fragment bit is set. This restriction is unnecessary since
>>> packets without the don't-fragment bit will be forwarded as-is even
>>> if they were merged together. The merged packets will be segmented
>>> into their original forms before being forwarded, either by GSO or
>>> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
>>> is set, in which case the IDs can become incrementing, which is also fine.
>>>
>>> Note that IP fragmentation is not an issue here, since packets are
>>> segmented before being further fragmented. Fragmentation happens the
>>> same way regardless of whether the packets were first merged together.
>>
>> I agree with Willem, that an explicit assertion somewhere (in
>> ip_do_fragmentation?!?) could be useful.
>>
> 
> As I replied to Willem, I'll mention ip_finish_output_gso explicitly in the
> commit message.
> 
> Or did you mean I should add some type of WARN_ON assertion that ip_do_fragment isn't
> called for GSO packets?
> 
>> Also I'm not sure that "packets are segmented before being further
>> fragmented" is always true for the OVS forwarding scenario.
>>
> 
> If this is really the case, it is a bug in OVS. Segmentation is required before
> fragmentation as otherwise GRO isn't transparent and fragments will be forwarded
> that contain data from multiple different packets. It's also probably less efficient,
> if the segment size is smaller than the MTU. I think this should be addressed in a
> separate patch series.
> 
> I'll also mention OVS in the commit message.
> 

I looked into it, and it seems that you are correct. Looks like fragmentation
can occur without segmentation in the OVS forwarding case. As I said, this is
a bug since generated fragments may contain data from multiple packets. Still,
this can already happen for packets with incrementing IDs and nothing special
in particular will happen for the packets discussed in this patch. This should
be fixed in a separate patch series, as do all other cases where ip_do_fragment
is called directly without segmenting the packets first.

No changes are required for the current series as it does not introduce this
issue or give it more exposure. I'll remove the comment about fragmentation
from the commit message since it's not entirely correct and it is rather
irrelevant to this patch anyway.

>> /P
>>
> 


