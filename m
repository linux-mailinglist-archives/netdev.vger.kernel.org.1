Return-Path: <netdev+bounces-105479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516BF911594
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 00:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833F71C22D77
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653551552E7;
	Thu, 20 Jun 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HtLvSN0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96C153838
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921972; cv=none; b=GAkQoKvPeEW8aKNMi0Z/JEjqSaWjVQDx64lIt8U4VwFyo4NvDL/rvHP2trG1vpJYnd0lnZ8VRIdAzggbrVVwcWeBoqAACOwpHy3M3ivw9cXlcXrH72XmtKDRSUIj45CGnErQ7xoiXUandR5i+jtJvkehsd3fsBdWtkgMMFOR7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921972; c=relaxed/simple;
	bh=AzuBu/nYd4noTnvcgiEnKbx32LQxb17oyJeVJ8ndhOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYRYqPBMTJZ+EIcwi4+PG2/ba0owZhh4kQOJSpDPGK7bh7j0y/tamCXFNV1ePRoAt5ly4fEeScJq/+K8TNImuCPjFrttdA/f4FAyVohj3nACS+YAW6dnsRnfEzHKQmf5DHZFEuasDpCkDBdsRh7e4WaszMBZfb/egkhFrPMbveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HtLvSN0k; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-797b24b8944so139164385a.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921968; x=1719526768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5407+z82JKtvMOrobuAn0ratWMuTj2tNIkXM8wd5dc=;
        b=HtLvSN0kZiZXE+JFmxRY6iFK9eTRGriwaSfVKvUbqKH/77dcW3jOYqrOGVl1Se/S4/
         ykpF23sXHvepgwQlxeWEdrOtBn7kBt3W+weZG5JptvKINIo8U0AzJMTZeXoVXfplDqUG
         y2kwz7dDkXCwSlzh8jidcVYK5pQaRvB+Z/GQtW/Xc3/iBNkVcGJURTizb5GypurA1+g7
         MrsamVqDuDS2E05B6xUN8hCcB6HtZxEJ1duQ+YqQ7ryLiskkaB1m4alP63zASyj9rLMk
         oUox0b2qJi8bg27fBV0/KNahtmlXWZ5JDtGiOhlJuDfLspp9rD4gSNeZj/Bj5rkyyze1
         ZYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921968; x=1719526768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5407+z82JKtvMOrobuAn0ratWMuTj2tNIkXM8wd5dc=;
        b=Z0Sh2D/dKXhuvwm1DNeVA/CBszNe4/4kSBRkKOBHonPr56arFbqBlAqg53WGshFTJZ
         BoP4DR5SmOOGXU83ajf1l2UPTWUIsibKvWgJdi/hYzC5zUAkBblV1gxcG0lzkMhgdjJN
         MAvMMhMe3TEMLM2bTaNaHm1QA2JN8rD8evNH9qatdiFw/BWwMFezjgKsQpY0ACixHifU
         OVk+ckXrFjFFDei1XL0FDdwWidsBJI6YX63fFAsz1Vk7/H9E7wL47AeRzti1kA63ZcxW
         /7v+SNb3PplVy0xiPh9GCrBuZ0dV18pgC2F+N1wKi7BT87Ib+1KAzgxLP8Tp9WRr/XSN
         zdrQ==
X-Gm-Message-State: AOJu0Yw2VDeSf9s86gXFUknCXiH2CCCwJczkCc94EiXEccVtfGJdf6ok
	CjWlxW+qGDC65BkntXWqWyqHrqfiihRIHYgHCav9n3K9BAivnel/8Bu30VwlTYJfmlPydSlKh0z
	vob0=
X-Google-Smtp-Source: AGHT+IHgBBxlD+qDZaVaOqDtQcbNvXT8j2u4+YOx1AyLUR2YCxxWQ0XJoivZxNhP3Jz56mudjlNUSQ==
X-Received: by 2002:ad4:57aa:0:b0:6b0:738f:faf1 with SMTP id 6a1803df08f44-6b501e3f1b4mr65791656d6.38.1718921968099;
        Thu, 20 Jun 2024 15:19:28 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe6d9sm907396d6.11.2024.06.20.15.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:27 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:25 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC net-next 6/9] veth: apply XDP offloading fixup when building skb
Message-ID: <b7c75daecca9c4e36ef79af683d288653a9b5b82.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718919473.git.yan@cloudflare.com>

Add a common point to transfer offloading info from XDP context to skb.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 drivers/net/veth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 426e68a95067..c799362a839c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -703,6 +703,8 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 			stats->rx_drops++;
 			continue;
 		}
+
+		xdp_frame_fixup_skb_offloading(frames[i], skb);
 		napi_gro_receive(&rq->xdp_napi, skb);
 	}
 }
@@ -855,6 +857,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	xdp_buff_fixup_skb_offloading(xdp, skb);
 out:
 	return skb;
 drop:
-- 
2.30.2



