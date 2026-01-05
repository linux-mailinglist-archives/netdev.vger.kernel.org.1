Return-Path: <netdev+bounces-247013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58ECF3757
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF1F930069AD
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264AA3358BF;
	Mon,  5 Jan 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aeHukKJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA44335558
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615289; cv=none; b=aZVt7z8MaBsj2mD1DuPGRphir/8awh16xbd10iuI6z4t/epy6Y43Z1LY5SsDF4X4J7CkbplraUGX+vfRCSKnmhjusgdGrp/hTOBfKekZN27Uzgb1h0t/b58zfmyPZ6GLM/cqL877UyBHmbBryzS4398lQGYxhCqFpjlNC0Ty420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615289; c=relaxed/simple;
	bh=gpO/s3IET6M0QBXoFLb578gA5Up+AO2D0gt4GSXzoj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mngZOHdJOrQQuSCnWTh82YucCKMIYBZ5gcGWkXoLe008wmx5Gde3C4UIAPr7dcrNTEEH+XlmVJKek2sfJJwSmezJ+V80s1WyhCrU+NDDTVWeaXJr8+CvawHD9RtQqiPAWZJAXVVbaOp53xEqnsL0KRUAVK4i03/PtRIoEdJT0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aeHukKJu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so15223521a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615286; x=1768220086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=aeHukKJuFGarx2R7Afl0tb2nwo+rBLcPJHOTlCaumuMRoP8L1D79hI7rx4qZNaDdyv
         CoCT849D6mIdn4xoVFZaC05h1ds5WFEUI1QvU4yrxDNagexsOGu+L5vSHbjrIPBkOVCp
         5cRceVFnvuLEbZNivwbLu3TQT5urCASziPArvvjrtqcQsKM13n5y4KutflcgVWBmyfEr
         cQ26vai+fiaNs4JFsxfv3C2iFEalvJ9rKMJEO9VPO4YSLE536AuFmSrwd+2ZUY/uSu4o
         Ho2FPTCrDzvsc/QIXr7XRAytZ4Z/GcDzIPPywm9kvJ4vzxtQw5Tl9WUWqWMW8slc6FBS
         1/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615286; x=1768220086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=q4rOe9hVvJNbbemR+18ILBo+g+R08qJQwVTuUQ25rtGxo+Jz4wTu726xmvrxF52kM0
         5hY/Bk2vWmM1Nq8lx4m7dgri0Rmh1i1VVpzFldQnoO8J8BMlX0xSMA98sO8VLYjgtL8l
         Nj+vYherqvLKevQcmNVoyfJ1gJoZQ13ypTFe1vQ/4yVrxU7TAtTAhv+UgXlYXZaRotQj
         YwaZ5I23rwok6yzUwdJMC8PstzwvqEW8SBddn3fKEiPW/wZawf0ePOvv1zUkvzIc2Eqf
         Mcz+XbLcRjD+up8LGRkXBL7TG+8Q4Tp11BNrwikF2/klaKitqOs9sub8K+jW9JU5aGOa
         z1nw==
X-Gm-Message-State: AOJu0YxGUEzh97vvgZTBORotfFTxuGtyEwLYRppaNOpcn59s6A2GE1sZ
	EAYxtH4YkGmBanyFcaCiZEbXEADfCxmQE3hvHkgI5Wiz0c+DMUqVjq13aOrSjYM40vw=
X-Gm-Gg: AY/fxX7Vu1h2aRvz3w33jmkTnQxgNndYde5/7a43jJaDSFHA0jWYtEkVJtIsKWLcxNf
	3OsOzBFoMZBoJoNkKOctnYFOXFpvr4DtK725Iz2GjffedOHexazPcAzYaBHFHciN+RcWsXGkjZU
	nbc3i+4cyqM+vQ8vcCrtyjc9cC6IUZiW97oPUrlLRYF26mxz74Qr8MmTh25uaddC2IJbWaZ/x+n
	I3tvrT1cKGDtcqrloyKkm5EhQlROjjD12q2KkFfMuFgX1mqL18Jo9jQ0sO3ZFKD4ExQI+L+5hN9
	tsokQe5D0ipMZTyRh0g0Z2qwH24EgdMf9C0/QS+w8DawoC4fTIWFg9LyF5wakwAFvDDTbc4qUqP
	sCbXzODSWyIiJ1DPdUmiE1K5JK7OwkuD86KmHBP5w4tZLpMdks8MXEvb/4NQQGsKJKrMxh7axT+
	agvzWxyYfAOFSm/ZxYRpQaZCGDeSpS8maRXilnNS6M+6icbR1So5Px2C36Q84=
X-Google-Smtp-Source: AGHT+IFr0ZMjG7qKX7KGn3B7ISvZYjFHyjR3rkhdmPDVNI0djGeUfwpEd1bvPeKdUAQZ9v0e2vBV3w==
X-Received: by 2002:a17:907:e8d:b0:b83:975:f8a6 with SMTP id a640c23a62f3a-b8309765132mr3383530066b.43.1767615285872;
        Mon, 05 Jan 2026 04:14:45 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de0deesm5550292266b.37.2026.01.05.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:45 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:30 +0100
Subject: [PATCH bpf-next v2 05/16] ixgbe: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-5-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 7b941505a9d0..69104f432f8d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -228,8 +228,8 @@ static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


