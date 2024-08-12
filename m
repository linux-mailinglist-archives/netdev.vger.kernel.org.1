Return-Path: <netdev+bounces-117809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06694F699
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8FC283607
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27D189B89;
	Mon, 12 Aug 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVjfZuEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594918951F
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487019; cv=none; b=tPN6UzJo9JcXCvUO0NGsqSFLGagmwh3CHRrE/VfRA7YADGxNmLfBdl7NmMuHBMByMYOo9YwjpRw5L8l+B2OYuUkAIVMOZVZTBbvkXlvJFqLP7YUmJMTarY0AzudRAocADGtpQQ49pVvWen6NpQ/GQ2FFlEh9OGbN+PD9dfwzXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487019; c=relaxed/simple;
	bh=E8TJrl6ilE2qmP4D4MYiqE244QFe9WbODfwmw98I7Eo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pz3ptc+sW6f9bcY9A3T9GycVW1FWvs+kjIhLDnH9cJrlLLJFlnfeHbcBrFGRTYk875xzH899fj+hjT4KvL6W8s0LMEzux8+8URE89hS+yVL5k9xE4jmXqQ/evcXZUmlNg2zBK4TaBb9/+aeaVZoavuccAViLGHGOn7ETO7jdme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVjfZuEM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-688777c95c4so110786257b3.1
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723487017; x=1724091817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZoGtt4kpfu4tzIWdzrnHODHULn34eTW/oMY9gk5DDkQ=;
        b=zVjfZuEMNs9zDvZc+KguCXxM1C9Dv6FpndwgoBfshdrl+wZoDgIBQ7lRo/9Q+lY38b
         fSZiZSGz9zW4wf8fY/f8rL+CbJgFTj+2nx9WozD+4x5D/B6SI5brzYXw6RwVHai4p57J
         DMg/wcjk0HDdJm07ne/3oa1AeTg5X7QA1VOzWP9FdxmjrC7einpSl9+lSLCwLPir80tO
         YhS85pVd6c+sIl2ikeV4DQR8heRtCuQi4LY6J6bl3/88YD0Gt5FTU5w7ciDBPKv0u51C
         TmauVQk3ojK0/Cd30Jky1w08Tj2/lfLdG5IhWs225cGMl7cedmsp2UMH+z/aHVXGf6Y5
         4S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723487017; x=1724091817;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZoGtt4kpfu4tzIWdzrnHODHULn34eTW/oMY9gk5DDkQ=;
        b=Fme0YYZ6qo22Ft6YiPeFr6gK8LLFcJ+Vl8CibpedRD/dx3OLO8/ApHfupk9v58HXCO
         zBZEi19yX2o9rrIVPmpQQZBkS81d9o0cTirCN3Wcxu6iSdCkc/eTGZMjUJ5lYRguPXc1
         iYAITlpfswBJ7/v7p8NphFh5jBEjiOakNMFIK/2WYg2s+pPIex2Fe/yHcxzxaReaAn8s
         ZOmjUQrwBIaefCJ1rtYUujFEigFgjEA6Bu2NxiatdEVYNbBg+6ovm6NJJGt1XtosBoOb
         1VGEXK6K65Ue7B2a5YTxWRPYnd/dMTMwouk5llfCUeaSKVwE39EIhIxfSd4K6RDCqZYW
         rz7w==
X-Gm-Message-State: AOJu0YxHJ0l1MR+sZmCWNQlwjgH/PXwN1Dt8RLdTXJkLw6rbuvM/63uU
	6OARdMLW8VAOD05ux5HtCcMpOqpfYIeHynkrTDuC/cz7GqCp+Jxgh/D35FBSWhfaaWpX3EoFDTm
	gvZElJSSEv6hLoQnjUQByFLvQwuuWsiBCUICJi7CtZVvY9DgFBGsA8JPPcrmvvvI7ZAjXruddYm
	iz54Vdcgr5BRC/gSedS/wdtSoW+C5MNOqt
X-Google-Smtp-Source: AGHT+IFPvG5FSfM0dHTYH67+xCZziBQqtulNLlG5gbOwJppP7A7f4g9Vh/8zPppGRQuV5wfM27/jl9fxORU=
X-Received: from wangfe.mtv.corp.google.com ([2a00:79e0:2e35:7:84ff:7613:4ab4:c176])
 (user=wangfe job=sendgmr) by 2002:a81:690b:0:b0:62f:f535:f41 with SMTP id
 00721157ae682-6a97695ba85mr411707b3.9.1723487017134; Mon, 12 Aug 2024
 11:23:37 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:23:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812182317.1962756-1-wangfe@google.com>
Subject: [PATCH] xfrm: add SA information to the offloaded packet
From: Feng Wang <wangfe@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com
Cc: wangfe@google.com
Content-Type: text/plain; charset="UTF-8"

From: wangfe <wangfe@google.com>

In packet offload mode, append Security Association (SA) information
to each packet, replicating the crypto offload implementation.
The XFRM_XMIT flag is set to enable packet to be returned immediately
from the validate_xmit_xfrm function, thus aligning with the existing
code path for packet offload mode.

Signed-off-by: wangfe <wangfe@google.com>
---
 net/xfrm/xfrm_output.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e5722c95b8bb..a12588e7b060 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
 	int family;
 	int err;
+	struct xfrm_offload *xo;
+	struct sec_path *sp;
 
 	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
 		: skb_dst(skb)->ops->family;
@@ -728,6 +730,25 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			kfree_skb(skb);
 			return -EHOSTUNREACH;
 		}
+		sp = secpath_set(skb);
+		if (!sp) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
+
+		sp->olen++;
+		sp->xvec[sp->len++] = x;
+		xfrm_state_hold(x);
+
+		xo = xfrm_offload(skb);
+		if (!xo) {
+			secpath_reset(skb);
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+		xo->flags |= XFRM_XMIT;
 
 		return xfrm_output_resume(sk, skb, 0);
 	}
-- 
2.46.0.rc2.264.g509ed76dc8-goog


