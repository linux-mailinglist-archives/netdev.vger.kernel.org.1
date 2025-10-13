Return-Path: <netdev+bounces-228793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FDBBD3F39
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0C9407CE5
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD24F311C3F;
	Mon, 13 Oct 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntsjXgqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C431194D
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367228; cv=none; b=ZWXG2njCG1180CNIP27XZz1h6Fs88FYHg1gCP7r2NEPDqRROF6wSoo2/BDvHg1SXJ8UbHQdirra6pU7FAK63+QPJBcogkvPJfjUyMJPDamkBRNSCBWhhFYVhABTG9p+mLi1xum89P9s93u+JcXUxYUwKwGJPMYgfA7fBS4J+Ei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367228; c=relaxed/simple;
	bh=WjwEwnVgKDmKGf0mOT4U63jLGaTZvrYbarJ0ZWgPq60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOX61uZarkOAuc9m4+8SNg7B0WV4uObEc5e53rGFSZ8qVB7DM9vIyweqOCNW58COIg6isVzmGQSkWKISOUtL+Opa8KEcKjXXoTO7/7QIUAWhAWJojnytmveQ3t5Huo3Z224aokyibwQTzW67jNS29r2mMk2GQP1aMo5Yo5PsE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntsjXgqp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46fc5e54cceso7864275e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367224; x=1760972024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0ayzy+SCb9hz0mwDQVd4KG2A98cKImsuCLT5S++72Y=;
        b=ntsjXgqpoNwGQJFY5YTI4/Sg83v1z6IxVjIk9Ia8/LPwR54LdE2pXA8Izvo+h7sNRy
         glO/mdiOExwTPNkfzNwNp0FHe3Y+AGmN7+XFES9QfAIFxaq6fQs4lt9Cq9+QGhBpNQ26
         oM6voQa1PSEzzHr5FszUTVh3Z+Q5evgmgXoj9OP+xpYStpIJ8uOfVQifZvBrdQ6NffnD
         YYIeob9os1Ds+51ZEoIZafpqhXfzBc2Whp4J0PK49IUz2RcO5wT9GirzL1rqPpuWiEMC
         jtJO8F7DytaTmx4tsbMHbEU3+OcDAQKIbsofYdp2qEiXFHIuu70cLPyNBQbnSZHDyOle
         h+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367224; x=1760972024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0ayzy+SCb9hz0mwDQVd4KG2A98cKImsuCLT5S++72Y=;
        b=L+NzEhei+ABmRRRbuM7Ow3sEmcWJrrKYM+14+sUY6/3z54RrHGdbQrR3a8BH4bfYPu
         xY0PlXWt1lgMOAGJLvqxKzM8mRo4bx6JUs8ySuADemMsmcY0LR8Dx9v/Fhjgma+Zv0BA
         xmd43M4AJR4NvMHTK6ieykNgcvjO7s87XnOP3RLEgBHaaBgZikfEll2EUCNBz/RkPIyw
         T+RaMBBACxccyRdsF8rgVJDmFLn8NLuTMVbN+63H++NHfahNT4pDDDU7KLtrmx8nOtbT
         uC2SblOOgRpiEZNZ6H70yBgKISILZ9g1iX06QBzCcnDWEDfcV/Z9LrWpD+0b77B6SsVs
         Nrhw==
X-Gm-Message-State: AOJu0YwiZJYoRzanCxdxSN+KYs27GM1rv2x3DDCqDneEd2Pe+iTg4mC+
	MzqrqYPBhx6FuxIA0xQjVQIiqzCIG9Z4eNL42YTUAiLxWhJdE4QqgVWrt/WMYBt/
X-Gm-Gg: ASbGnctSpimeEpUaEMRD/mgQBV3VI00OwAgZtq0mulY3Gauz9n75ESRu5oOaKv25mpI
	l9c9ydinskJCY77kWXv+yZAl2iN707W7rO61Y8U6xHg+zzHtd8E0OBXfYn0oEIr71nIU70NfuUP
	egRB3P9brwKbX6X9xhBwAaZZnI7dJdDc1ntQhP7DT22qWFPB2YE8Ma+PW+EzSNxNFLJDsLHiucl
	J4u8FihcnU4cLh+rLu/6Fn+DAvmA4hXlhaED81yZpdSte56BCohv+OvWuAmSCaDCAAcP+6feRfL
	X25PhQhY/fc69aGWjrigBIGnE61aEpqCkY8VYpXGbWKj/vD+FYIjKnkG8lddI0lEeRUdqxeRxbC
	Q7/or/2mq1XPqYz4wkH2uHd+s
X-Google-Smtp-Source: AGHT+IGrRvDbIKp6K6AMCw6Zdmo39z5Z8/jDdtEHlFD69lSVWOS65RcIgP2PsQY/WwDW9hF6vRZo3w==
X-Received: by 2002:a05:600c:4687:b0:46e:37a4:d003 with SMTP id 5b1f17b1804b1-46fae33dbbdmr135008035e9.8.1760367224018;
        Mon, 13 Oct 2025 07:53:44 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:43 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 12/24] net: reduce indent of struct netdev_queue_mgmt_ops members
Date: Mon, 13 Oct 2025 15:54:14 +0100
Message-ID: <707b02494c7748beb1e535eb82c77b5be8002492.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Trivial change, reduce the indent. I think the original is copied
from real NDOs. It's unnecessarily deep, makes passing struct args
problematic.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 31559f2711de..b7c9895cd4b2 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -155,20 +155,20 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * be called for an interface which is open.
  */
 struct netdev_queue_mgmt_ops {
-	size_t			ndo_queue_mem_size;
-	int			(*ndo_queue_mem_alloc)(struct net_device *dev,
-						       void *per_queue_mem,
-						       int idx);
-	void			(*ndo_queue_mem_free)(struct net_device *dev,
-						      void *per_queue_mem);
-	int			(*ndo_queue_start)(struct net_device *dev,
-						   void *per_queue_mem,
-						   int idx);
-	int			(*ndo_queue_stop)(struct net_device *dev,
-						  void *per_queue_mem,
-						  int idx);
-	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
-							 int idx);
+	size_t	ndo_queue_mem_size;
+	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
+				       void *per_queue_mem,
+				       int idx);
+	void	(*ndo_queue_mem_free)(struct net_device *dev,
+				      void *per_queue_mem);
+	int	(*ndo_queue_start)(struct net_device *dev,
+				   void *per_queue_mem,
+				   int idx);
+	int	(*ndo_queue_stop)(struct net_device *dev,
+				  void *per_queue_mem,
+				  int idx);
+	struct device *	(*ndo_queue_get_dma_dev)(struct net_device *dev,
+						 int idx);
 };
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
-- 
2.49.0


