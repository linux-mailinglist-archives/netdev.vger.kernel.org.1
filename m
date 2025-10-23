Return-Path: <netdev+bounces-232262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 403F7C037A9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B73E134ADA1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FEA2D3739;
	Thu, 23 Oct 2025 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3FdWqpU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4052C1780
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253237; cv=none; b=gaurVZXJF/QT4SQpTxDI7/fDotDs0opfaPXee96m2taFM/HZNZZ2njnusDN6iCm4Khp/6vTBA4F4tc4VbjtCnNwWS28rWDdBXRvJDMc9yo30YW3kPu7MeuNUtZMWsbTutkk2lma3bI3swr1/jHdH1kUsHhg+Fvtmzx6FYK4Aavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253237; c=relaxed/simple;
	bh=1YaM8Gl2RC8oqmYjWIDWFTPbTKaqfIddmif0TMp102s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g001mfqZwhYomU8FMvLnucA1MJMG8zizJfgeg7UMNEm0XwPeizkkWTTBUysIrlzYNbp8SFc+yWUqmIcSxWGFfH1bbC6K1xt6B1Ratity7Ynn7HysiclAKzIFa1uLO7mN5RR6U5fc7Q8qWQFag8JHR9TRPm40unYjm0Oqrrt++2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3FdWqpU; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e336b1ac4so2240545d50.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761253235; x=1761858035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwlreoE9kQbwjOXFtM8S3Npqc7qKt2aCVWyGonuNkt8=;
        b=I3FdWqpUj7+feu6qm2JSxV5+sjT0xb+6YO32dVbt5i36hBclfQ2hjD7QnDsSv3Jx6y
         KTeucP7EB3TRMf3/NVQfvv883opG2fdq08oQ0W7WZlKnTk1eLGvppC7Pud1iwqhjTgbD
         ofyQei7h7CJwyRycQyQwxbDqvN+ZoVHTXQ5NBnUymoiRMZ1X4WHPdbwW//wm1kTU+3FL
         gfQURzmDGlAce3nT4fSqcnkct3fDQ82ho+HT/f1od2Wf8nNcw/MBG8xt2E3Jtyiclg2a
         K+d0WU0iNvcizVskMfRlU35jHaXJeHYRXo4vBzmkShTTDQBoivr94SAsqvqzKekWXxqj
         gBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253235; x=1761858035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwlreoE9kQbwjOXFtM8S3Npqc7qKt2aCVWyGonuNkt8=;
        b=Jrg3G/RJ7AQTX4bcLoS+ulfsuaRwzu+Vmo5mK4ypz3d6gD7QkJBwTavY2CTb3Ntz+Q
         GRY1qptdVACWMG4Bd5KMhMuSVFm46YXfS3odCNTrSmu4vaTyaPXiJ6TdoplbQqigtQA9
         9W+eg6bE5EK+r3kdvRvmPFuXSimpOQfsOJPPAC8t7FjMcZJ+sFpQPpn9IWQsGhhsCsl2
         reOvmZij85rri7rRap855OfnWcxdlp18pLSV+0BgEXHKr2/v91y6o0Kuh9WLtdTxwCtF
         p4iq2GT2BLZZBAIZQZZKQuqY7Ib9rdiJNAqbCysCVTmRgByIm+LG+1ZElnR2sI4btPfP
         liFg==
X-Forwarded-Encrypted: i=1; AJvYcCWOo/N59VDex02wOZPM0IcLtnBPI8uz2HtsSRmG9iqft3jhtHvYniYgpK94VLRLYEzRgPVpJOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1sb9Fgv4al28V3Xaje95Ixah71MQMr/Ee7qwQ0nSmjHAODoV
	hFvsyqCY3Lw4C5B9XYPAaPGbC32ZhPe1+gXOut9Ok7AOatNIDqcuPrnz
X-Gm-Gg: ASbGncvMahLqSD3MpKfScIr23i5UWLQhewetkzaO5ZB0g5AQ0M+7p4DDtZSIRPddy0P
	5zIHwGq06pwho+xhtjI62hdPU3jo87rcsNSGLMyh5s7mxOGpG+yp7elGznkoBkZOI9fDU/8RiCp
	FyPXJsdubPwYC1prKdV0w1RKGSrVKmb/k3K6DEoViE4ljbpGO0G5s4403x+3k/iP91NQzo/XfnZ
	KeTROuIUfQ6nT7DHOaDi8s7FHff8nQcKHs1yICMF5JSnP5qdJYJhE10A9vTAdfrlQSkrtxsPBSZ
	eQSxlEneGrm/HBVWZoMUZoIu3uzenAYAFf9nrdu3HhVOYkQwfWeHlygLVklvMZR7wU/nM6xGxDZ
	DUKXUV9j2XOgbEwmweBgZzltcNXWFkI08/0xX7zRz23RbJTOcbhkK1VAAvQEuL+jV0FGoraU09/
	OgYe7gJ0jOijI=
X-Google-Smtp-Source: AGHT+IEBIum988zCRistEInnTerl8FyEqMWMxIcD25ZwST/CVAmNRsjUTKijGwb/OAf3K2YfFky7uw==
X-Received: by 2002:a05:690e:150a:b0:63e:3bd4:9db4 with SMTP id 956f58d0204a3-63f42a57a2dmr264565d50.0.1761253234759;
        Thu, 23 Oct 2025 14:00:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f378ef9d1sm967513d50.9.2025.10.23.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:00:34 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 13:58:23 -0700
Subject: [PATCH net-next v5 4/4] net: add per-netns sysctl for devmem
 autorelease
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a new per-namespace sysctl to control the autorelease
behavior of devmem dmabuf bindings. The sysctl is found at:
/proc/sys/net/core/devmem_autorelease

When a binding is created, it inherits the autorelease setting from the
network namespace of the device to which it's being bound.

If autorelease is enabled (1):
- Tokens are stored in socket's xarray
- Tokens are automatically released when socket is closed

If autorelease is disabled (0):
- Tokens are tracked via uref counter in each net_iov
- User must manually release tokens via SO_DEVMEM_DONTNEED
- Lingering tokens are released when dmabuf is unbound
- This is the new default behavior for better performance

This allows application developers to choose between automatic cleanup
(easier, backwards compatible) and manual control (more explicit token
management, but more performant).

Changes the default to autorelease=0, so that users gain the performance
benefit by default.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/netns/core.h   | 1 +
 net/core/devmem.c          | 2 +-
 net/core/net_namespace.c   | 1 +
 net/core/sysctl_net_core.c | 9 +++++++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9ef3d70e5e9c..7af5ab0d757b 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -18,6 +18,7 @@ struct netns_core {
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
 	u8	sysctl_bypass_prot_mem;
+	u8	sysctl_devmem_autorelease;
 
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 8f3199fe0f7b..9cd6d93676f9 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -331,7 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		goto err_free_chunks;
 
 	list_add(&binding->list, &priv->bindings);
-	binding->autorelease = true;
+	binding->autorelease = dev_net(dev)->core.sysctl_devmem_autorelease;
 
 	return binding;
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index adcfef55a66f..890826b113d6 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -396,6 +396,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
 	net->core.sysctl_tstamp_allow_data = 1;
 	net->core.sysctl_txq_reselection = msecs_to_jiffies(1000);
+	net->core.sysctl_devmem_autorelease = 0;
 }
 
 /* init code that must occur even if setup_net() is not called. */
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8d4decb2606f..375ec395227e 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -692,6 +692,15 @@ static struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
+	{
+		.procname	= "devmem_autorelease",
+		.data		= &init_net.core.sysctl_devmem_autorelease,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
 	 */

-- 
2.47.3


