Return-Path: <netdev+bounces-137819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765E39A9F19
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CCE1F22AF6
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A71993AF;
	Tue, 22 Oct 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZlNoM27"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E40194125
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590497; cv=none; b=V56lynBtE694JqSZ82UU6dcv08V/bhrJF7sF9z2840uLIiPM56q6+j08pkkMKsNCgmMTIftQBTihqP3hWPxED6I+rxATCvYlMEwaMQlnD2iezU7ait8yweKsDAHeZ12kEF6JSk91vdje2aZPfihR2q4v5mH+fL7oK9z7uocD9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590497; c=relaxed/simple;
	bh=XaUkaBK+hpUOhDIkRzlJiXdM8vvSHQhFMVP4rVVVKxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhyQYHeSeQAWKNxxpNKiATeQ6vulHnRhvsb2Bb2AV+hKN5Y4cU4KQGvjLZZF7RuvXwPaNy5tbUJgbKG7IJtH5HLCLVIuheNJC5sGlClTiPqc4jx8jChOPhFB89vuHW0l9JQkjytKPntc81xnBxelFHWjgaM/4OyLY5oZ8VihF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZlNoM27; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RRFmx311mMt/tUUxO+VS5JQIohMmBJqc2TBlvbHmV0=;
	b=iZlNoM27KMj78kVfoI0ZvoogOzngZ+taq0gTx+14q6sNoAfLC/4xzlgSDHVrYvDmw6A68X
	fiv1dFpW5hUIOgpBUqmF67SG1TpsTEL2BEDGQYd8vG9z3I9inux0aEYA76TwqQWnJtD0if
	GPybt3c/Nszut0vwPQz6S74HADCkn+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-QLMKZ41AMymZIpG06cZKIw-1; Tue, 22 Oct 2024 05:48:12 -0400
X-MC-Unique: QLMKZ41AMymZIpG06cZKIw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315a0f25afso40505105e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590491; x=1730195291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RRFmx311mMt/tUUxO+VS5JQIohMmBJqc2TBlvbHmV0=;
        b=bxQxL/7aSElSu1yhoGjYQRC8MQnmjq9+ziqtZGGAy75erGZcTmn4QqY0k7Y1iRo30B
         R0eK7EIfBbbesFWwU7Z4oxRjlq3GQ5IjgMB+59yQ0XLT54R1IAB/rDns0jy6fBanhyiJ
         cYVdvid2MymKYKtwYJoLcYOo21b500jqU4VZEI5V0M7+EwhUMHHnCMF1MzoiLxaB281C
         ihcDO8nAdZwoz8TyPwZFbqmsHOVafCAhmI0cdCVnFHBHYMTSJDmJvSau22XVUDg7ExgD
         ABkTVkbLfQ95URxPO/1vdl0oF1sH1+TagwYtVfI8TREXqHe60Vc8s8TzRSg+pgtGL8yk
         kJLg==
X-Gm-Message-State: AOJu0Yz1xSPtdFC6hRna6vNa3KF3/AXsEZQFUfysSppKYRm/lLoDKQMq
	07CGvpNqpCCVCQ23/M68F/PEiY0H2V4z5DmeF03iBOJdN4FffqpE+hMiODOZChS2mjkhFoE/BsK
	zgg0jALGuG0GcKQPQ2PggSALLB81j06i9KnWnX9kJX653k0hg94O3eA==
X-Received: by 2002:a05:600c:3511:b0:42c:ba1f:5482 with SMTP id 5b1f17b1804b1-43161691c49mr89435555e9.35.1729590490891;
        Tue, 22 Oct 2024 02:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3HFc2Ycx3O98VJk7U1x4wnReHs1+f18GY8AglBDnWfBFY/0L61+Uw/Chfj+L3qrRMcF4N9A==
X-Received: by 2002:a05:600c:3511:b0:42c:ba1f:5482 with SMTP id 5b1f17b1804b1-43161691c49mr89435315e9.35.1729590490426;
        Tue, 22 Oct 2024 02:48:10 -0700 (PDT)
Received: from debian (2a01cb058918ce00b54b8c7a11d7112d.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:b54b:8c7a:11d7:112d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb15sm6238565f8f.99.2024.10.22.02.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:48:10 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:48:08 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/4] ipv4: Prepare icmp_reply() to future
 .flowi4_tos conversion.
Message-ID: <61b7563563f8b0a562b5b62032fe5260034d0aac.1729530028.git.gnault@redhat.com>
References: <cover.1729530028.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729530028.git.gnault@redhat.com>

Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
dscp_t value to __u8 with inet_dscp_to_dsfield().

Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/icmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23664434922e..33eec844a5a0 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -445,7 +445,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	fl4.saddr = saddr;
 	fl4.flowi4_mark = mark;
 	fl4.flowi4_uid = sock_net_uid(net, NULL);
-	fl4.flowi4_tos = ip_hdr(skb)->tos & INET_DSCP_MASK;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip_hdr(skb)));
 	fl4.flowi4_proto = IPPROTO_ICMP;
 	fl4.flowi4_oif = l3mdev_master_ifindex(skb->dev);
 	security_skb_classify_flow(skb, flowi4_to_flowi_common(&fl4));
-- 
2.39.2


