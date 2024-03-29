Return-Path: <netdev+bounces-83366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE88920B3
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7DA285CA4
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065F524CB;
	Fri, 29 Mar 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9elXpTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0881E491
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726961; cv=none; b=Mim1/bcpTtJ8n12fukmSjStyekti855BkG8THeqpUMYFjUX8dhX2LS92A8sor5+dKZnmnsIvn4/dg8458LB6Ii54gnBzO2aIPBBpQ0SVOvDB5rfMSeZpMA1iJV6r9gQ0H1Tqcs6ft7lFx46KJhGvKoAXjojrtlzXmWzSuGYyWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726961; c=relaxed/simple;
	bh=cDQ06vC2AO2hdTXvL2nVcFw/pVw+7ML0rIty1NNvoeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M/9Kk9S2a6yo7W2B8pzJeXMSSExuarmL9S0mpXq2NlfWCX0aF84EnKHEMh13EuxTW+Rb07lgGxCdzsahrPrrh7yo6L1U5sg2nuIJPrQf2qiwmmHnrUHEBngjQ08GwD2pAz2ZxZKfJy9ZeZ2Ujubf2RKQNQq/PMt5iuyqFX9EOe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9elXpTd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b18e52dso25311597b3.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726959; x=1712331759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4Rf3n0ThGg2QZAaciZ/MGFx+ZUjVEIBegGBLhJw3P8=;
        b=I9elXpTdsdNewa+StcwKecW9CR/Tyvsah4F6oVIYtApcj0BxAoESpCaRQIfsHiwZ/f
         Xq3FmzZOImpR/q+rHxBJjxcSZjZpJKEJwZhlwjKuRgL6eSSAbEJG6SxPD6mBdATkg9dn
         xYdKoG7S6ONXNo+ILAgaYpksaWpRaQYL1YXIdmrqwZAV9wH+ptXX8K/hNiXJycXRE5X+
         PvQcxzAd3hO9CIpdGKvM8XuJmUQH4VXlVsL7FjYr7rOCPeiY5QcDvahPPtfh5n/oytQL
         9c1xSZd0DxVZbbHFfoPZQUrmFHGmjoS7V12qVl3wxvoVst5PpkZC5+/DD6sBvgSZLYK4
         fiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726959; x=1712331759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4Rf3n0ThGg2QZAaciZ/MGFx+ZUjVEIBegGBLhJw3P8=;
        b=vyKCL6orvjcnQL/sXRRZoC8/eYkE2Q30LhLpI/ReHpSVLt0y0V0CGrWScU+SxQaihh
         FnaVmbdFw8cmNFFCqZFkLdUjgYzkaF0MYL+z/Y8YUiKE8qvYrgS5l8QldIVpapaLM/1S
         lzuuPQ3p/MJcyAcVXauwQ53yL8vAvSi1jypVXa5enQ97ZtX+deR5c2KYAWNMFlfGHBsy
         TRtWi5wTG6Xk3ooQUE3XcTPWhvtocnSDXD1cf/Iv3hT+ojHwOHRB5DYo8xBMALFs/FdF
         tY67lUSNDBqKe7pucdELooks2okT147pJ48sQPhPhuhHWXMGHUYhxVSSQ2OJh2IO3pLM
         fusw==
X-Gm-Message-State: AOJu0YwZqWHAdruQfJexWetN5uMj+k8j6IyZvmNYSv7ZY2RdgCaFqkCv
	vWiDzVEChFEhqu60vG/Fpi+p1/sgxQ55uQMSV/AADdoDfs6Kr7p6jSjQV7UO9IMLA7K355qZNJk
	CALuBk6E4WQ==
X-Google-Smtp-Source: AGHT+IEqi7N+Kwc3DkeWAKaR1NwSZpc4syao/BJMYMJnkRVoLDXhCPAY9rGWv1wmcLmuOFFU4IYnVITfEl8Hqg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:ccd3:0:b0:614:6883:43bd with SMTP id
 o202-20020a0dccd3000000b00614688343bdmr36502ywd.1.1711726959523; Fri, 29 Mar
 2024 08:42:39 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:42:25 +0000
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329154225.349288-9-edumazet@google.com>
Subject: [PATCH v2 net-next 8/8] net: rps: move received_rps field to a better location
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 14d898f3c1b3 ("dev: Move received_rps counter next
to RPS members in softnet data") was unfortunate:

received_rps is dirtied by a cpu and never read by other
cpus in fast path.

Its presence in the hot RPS cache line (shared by many cpus)
is hurting RPS/RFS performance.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 14f19cc2616452d7e6afbbaa52f8ad3e61a419e9..274d8db48b4858c70b43ea4628544e924ba6a263 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3203,6 +3203,7 @@ struct softnet_data {
 	struct softnet_data	*rps_ipi_list;
 #endif
 
+	unsigned int		received_rps;
 	bool			in_net_rx_action;
 	bool			in_napi_threaded_poll;
 
@@ -3235,7 +3236,6 @@ struct softnet_data {
 	unsigned int		cpu;
 	unsigned int		input_queue_tail;
 #endif
-	unsigned int		received_rps;
 	struct sk_buff_head	input_pkt_queue;
 	struct napi_struct	backlog;
 
-- 
2.44.0.478.gd926399ef9-goog


