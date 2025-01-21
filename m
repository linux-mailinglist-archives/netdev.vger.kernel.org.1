Return-Path: <netdev+bounces-160019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D59A17CCE
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF87C3A858C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80311F12FC;
	Tue, 21 Jan 2025 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxnD8b2s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63EB1BBBEA
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458169; cv=none; b=bfC2cjdsZtfCqAaPTNYEUvMARgIZkBrKIINyJUT6xx/2sKeLt1K/ijApzF9jXQ7TPiWfYGvxUY3quKY/Xka5esei2gniVGOxx14FOlUzgWd2pfiKdu7bNF6vfNlGzvPZuzrgtJa4cYH9P7P8X/0NnTXYIWJEp/1X5IN87BxgCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458169; c=relaxed/simple;
	bh=8NXyXgmj72dOMTLLbd9mQTnaEflcGG11z6lNzHOYKVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lt2xueYKVPE8LmZfX2KYXbPz9h5mlkkJmWc7GC6NdHdY+ee9JrEj0sG2fzl6iXd4iR9paUD3WuWDF5Xnz5H+sBUZQFdRtq+gCyJ2Yc4xPdjnjwv5vc0Prfe7edWOTOsF+N8lmkm8qRIGlbnc8fv1NSLsVYXLycns3ZK4AuflqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rxnD8b2s; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385df53e559so4223281f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 03:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737458165; x=1738062965; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQ9/vKCvteNP1p+2IIytP3er3wI3McGb3ig0DvAbV/A=;
        b=rxnD8b2sFy5BtQlee0FZhFWmMH5kSbc/m7enZK7/ywjRzVPMq3b+w3megC7VMNGKOH
         OC9R5rxae8hnECyX8b5pUvZHUoRUOU+PvYOqy2+e5UIxlsdatQCT8JldTH4noKFmr46r
         pcpG+J9x4JFDe62mvuU+Csdh4iwMVvfkbGL/aVOJugcaBvmhijeI8g7Arl6bhfUMn4nW
         c3mq6XuFiVHBtpgTFmyhgox03sgG8YgswRiz95zbzI0PbOXWmud5feZVkKDe5Q3pJc9/
         ZblwLtgzea4YuC1PpPMYWe5TjWn+JqoNIJwLHPvG90s6/56qqcqfRYpLJ1+sIMO8ofL6
         3z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737458165; x=1738062965;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ9/vKCvteNP1p+2IIytP3er3wI3McGb3ig0DvAbV/A=;
        b=KLGWD8W2U2R3ceW982SSWa414MoVFdVlsr2H2EnwJyKWG4kMlVxnLr3xq08Ndf3Erl
         RMVTDA0vJu27dvzddT6+GhPYNd1U/BD1E9rEiHiOTvWjf7VFLUp4HTiAbjcmvYM97YIb
         K5HW0fPyrc7d5OAIMxTnND7W/rcdG2oshz/6bol7EC6AOLnTfFCJtI9JzYymEHMtLeE2
         r3XRjHfusUAj2tr/yGcPJXTsP6JNTV/kWduKJ1YGyLzHiq2JRpCulZn762CRHWNuMPqB
         ZOKOPAwiBR5KZ4BPw7yIrB20KiPZeLz4hAOgKLcvfVlqwfvp807k8MkYIwAHYsOHDGZt
         odJg==
X-Forwarded-Encrypted: i=1; AJvYcCUFViuESk5Y1q6pyecpv52tGlihovgLL80WoB6w4+umVPKpddN8N65lgYyAvtkcMi+qsTUO+ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapL1nCefnyW/MJCWCUJoHutDxgwPKdrgwEgFW2FOYBjsAPLef
	GAoagGdRKDRBRY9Uf2X0m3cKatQaDsDI8oeZmtuHovU1H8RwNOGeHMk8q7z6DKU=
X-Gm-Gg: ASbGncten05Z32VXAfMwko4pvTGosp5CKDalZv6x1Lq8ECbNcm2dwrundDafKFHTKGB
	j9SCjnbjlNo5z9oTtzzsqzmyX/j9prSbhu69eLrJ2SFwvmXYGiT4J8KGptSYlZaOViGnt/Mv9Vl
	PLhmV/Sesiy83y74Cp42ILMzgm22HlZY0LiKVIl678nmm7C7G4A6iH7tlPEDgbLJjWw6XudiVlE
	9tzeu6Tz7MpiNsyxQ974VpWVMXPBXU6KiZKNbR+TFfXOigCgafjxs30rh3Tge+xi/Lmv6Oz+BY=
X-Google-Smtp-Source: AGHT+IFu5iwWBJlfMKb2qqPgPYEgPFg5JRSCPVWEsRxn/dai+wPHA1OMBL4MUFjUwRffREHT3Asyhw==
X-Received: by 2002:adf:e404:0:b0:38b:f074:214c with SMTP id ffacd0b85a97d-38bf5674039mr9683425f8f.30.1737458165132;
        Tue, 21 Jan 2025 03:16:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322aa0asm13269386f8f.50.2025.01.21.03.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 03:16:04 -0800 (PST)
Date: Tue, 21 Jan 2025 14:16:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] xfrm: fix integer overflow in xfrm_replay_state_esn_len()
Message-ID: <018ecf13-e371-4b39-8946-c7510baf916b@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The problem is that "replay_esn->bmp_len" comes from the user and it's
a u32.  The xfrm_replay_state_esn_len() function also returns a u32.
So if we choose a ->bmp_len which very high then the total will be
more than UINT_MAX and value will be truncated when we return.  The
returned value will be smaller than expected causing problems in the
caller.

To fix this:
1) Use size_add() and size_mul().  This change is necessary for 32bit
   systems.
2) Change the type of xfrm_replay_state_esn_len() and related variables
   from u32 to size_t.
3) Remove the casts to (int).  The size should never be negative.
   Generally, values which come from size_add/mul() should stay as type
   size_t and not be truncated to user fewer than all the bytes in a
   unsigned long.

Cc: stable@vger.kernel.org
Fixes: 9736acf395d3 ("xfrm: Add basic infrastructure to support IPsec extended sequence numbers")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The one caller that I didn't modify was xfrm_sa_len().  That's a bit
complicated and also I'm kind of hoping that we don't handle user
controlled data in that function?  The place where we definitely are
handling user data is in xfrm_alloc_replay_state_esn() and this patch
fixes that.

 include/net/xfrm.h   |  4 ++--
 net/xfrm/xfrm_user.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index ed4b83696c77..0a42614d7840 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1981,9 +1981,9 @@ static inline unsigned int xfrm_alg_auth_len(const struct xfrm_algo_auth *alg)
 	return sizeof(*alg) + ((alg->alg_key_len + 7) / 8);
 }
 
-static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
+static inline size_t xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
 {
-	return sizeof(*replay_esn) + replay_esn->bmp_len * sizeof(__u32);
+	return size_add(sizeof(*replay_esn), size_mul(replay_esn->bmp_len, sizeof(__u32)));
 }
 
 #ifdef CONFIG_XFRM_MIGRATE
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 08c6d6f0179f..4bfa72547dab 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -151,7 +151,7 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 		return -EINVAL;
 	}
 
-	if (nla_len(rt) < (int)xfrm_replay_state_esn_len(rs) &&
+	if (nla_len(rt) < xfrm_replay_state_esn_len(rs) &&
 	    nla_len(rt) != sizeof(*rs)) {
 		NL_SET_ERR_MSG(extack, "ESN attribute is too short to fit the full bitmap length");
 		return -EINVAL;
@@ -681,7 +681,7 @@ static inline int xfrm_replay_verify_len(struct xfrm_replay_state_esn *replay_es
 					 struct netlink_ext_ack *extack)
 {
 	struct xfrm_replay_state_esn *up;
-	unsigned int ulen;
+	size_t ulen;
 
 	if (!replay_esn || !rp)
 		return 0;
@@ -691,7 +691,7 @@ static inline int xfrm_replay_verify_len(struct xfrm_replay_state_esn *replay_es
 
 	/* Check the overall length and the internal bitmap length to avoid
 	 * potential overflow. */
-	if (nla_len(rp) < (int)ulen) {
+	if (nla_len(rp) < ulen) {
 		NL_SET_ERR_MSG(extack, "ESN attribute is too short");
 		return -EINVAL;
 	}
@@ -719,14 +719,14 @@ static int xfrm_alloc_replay_state_esn(struct xfrm_replay_state_esn **replay_esn
 				       struct nlattr *rta)
 {
 	struct xfrm_replay_state_esn *p, *pp, *up;
-	unsigned int klen, ulen;
+	size_t klen, ulen;
 
 	if (!rta)
 		return 0;
 
 	up = nla_data(rta);
 	klen = xfrm_replay_state_esn_len(up);
-	ulen = nla_len(rta) >= (int)klen ? klen : sizeof(*up);
+	ulen = nla_len(rta) >= klen ? klen : sizeof(*up);
 
 	p = kzalloc(klen, GFP_KERNEL);
 	if (!p)
-- 
2.45.2


