Return-Path: <netdev+bounces-160286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D97A1922B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0214B7A191E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D738C212D82;
	Wed, 22 Jan 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOQHT1fZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA672212B0B
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551815; cv=none; b=QMESApqJzKbcgu3xOO6qpyxZAJjxbgJ569VgwRVUa8OV2C6zAShseL+DGNSdWBYvNpyi4FRxKzqDRfPtDytkKfNH1XUUGdfju8hRrkzEW9/guD+9tMM+vA+NFdEJVsA/wqaypqwU8j6Ek2SnqqYj9jjXAEYr9qLw1l9j01O60lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551815; c=relaxed/simple;
	bh=DWKxfGtdDnEJNfWzdodQTMjGMuetNikzJMTfOHqZBvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lp2yGmHyLn3WokpZNRmmi9bH1HCXhj2Riaz3fJglb47OFENxFMl+OPBghw3bszTbEuMzh4jiACCov95LmhZjKNSt3I26Vh/6jjBjZVWcSR/7LAuWU+6FVnQqxQOYutGEjL5Xr6BCyKh7sg6P4WrTtFJd9/loBdlBDJuZS2f+QKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bOQHT1fZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso3654627f8f.0
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 05:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737551812; x=1738156612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx+Dg0/2wgt6aXCibSfZ5DxfPLu9lE2aXQ7E5VZKwxk=;
        b=bOQHT1fZilCyAvx8V+N+ILjbYyOluyPOiw9OdKJN5Nj9UorYGQRVt9PttXtk2B0zPv
         ptup0HuuhFlp2+DTW8jZ/vFFtHMhfIfzJ42HzX2EHlQ18AUCpBFBbyeR7Tvnf2rE9Dy/
         VnldZa0+ZvhjJJrLexEbJiyuQBX/gQBlN1D6tWB58ydh7BnnvCngxkARwBlc42Cwj1ZH
         VoveZOcGE/PrYL3dOCyCa950T4DDYpX5XvBSur6ybWNjSRrrV5iAdUj1Xu1ZIY8+7GVx
         fRr6isTr27i1EN2KRDIvZzfDVqqsGJiRv17rPW/VOlS828gk7fVoBuogkdFYy0snpWt6
         fCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737551812; x=1738156612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx+Dg0/2wgt6aXCibSfZ5DxfPLu9lE2aXQ7E5VZKwxk=;
        b=IJ252DcaSAD/M9rPIiriQtHDTzmZFpptQnU+B5vFdUDzvuA/8zEZh8+t1RhaLLe1/l
         hIGB6XO828F4LWIdZ7z6j6mH4q5GNHifzwioqolIepKOF5zwXkvnd2qg9rmQ4MW9Bwzm
         O8FsauxNm4sMuDK6ArcYTGFYtYnUkcRJbFmOdTYQjzR0XcAlvd8Sq1i5KZ4lmedSEqI1
         AJrl53HX5HbUAAeXlQ+jxsGM/jzfF5HKjYArEO7TV/C4bWJuOZQhghLBaZo99T5LPRoe
         azdL54+0sARCqH40pclpp25lZHvGTruHqPpeaafJouEcrsnrRXIpKslbXhBQMuythVNC
         uScw==
X-Forwarded-Encrypted: i=1; AJvYcCUk9Mz9vK/tlU3h7q+YHAJ6LtGpr5khustEobvF6dW4pCjYrHtD1ovFaC9q+5G89OM5n275xkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykh3C9sarystS1XI9dJ5N4lj97x3XE9PsMQZwsOfnDdvGQ4fTm
	sn35aPR83wA2d3B6LrUQXBWy9MBsjYA6dkUYOQIJwq6xZdJ5ku9gn7X00E2VAqs=
X-Gm-Gg: ASbGncujlSTZyBZ4+cTVrwKDGHlzb1VStZOaJZxzUQMvxjlokPP9gZiqwr+ZWP1+UAw
	WAcOm/ROsLiAz1wCp0W3gZQaoMbOdX0N2EAqlOSZGU48mIpHst2Fj/H5uSuyNoLA4TWzSfzuNPp
	tf0eYKhIm440ShDteRAHwcl3nEXTkT62O3WCj1+MfDama5llV9JSKBHeJojxTkG3bDRzN1/F6p1
	klG1Q/GvLETEPhOVSnGNFVhjGwo9ZAGs7v4XFD7AbT2E7EIHKtpru4Glo+4wRM+hiVR0ymBpEs=
X-Google-Smtp-Source: AGHT+IFSn+3wPftEB8UAF5kskDXu9ZJbWPFzAuDQYj4uSbPpAuu0OUcPx+Wt6bjxDA5BpU/7SRNmPw==
X-Received: by 2002:a5d:64c2:0:b0:38b:da6a:8a02 with SMTP id ffacd0b85a97d-38bf59effcdmr19439134f8f.47.1737551811961;
        Wed, 22 Jan 2025 05:16:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318c1a2sm25149765e9.7.2025.01.22.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 05:16:51 -0800 (PST)
Date: Wed, 22 Jan 2025 16:16:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] xfrm: fix integer overflow in
 xfrm_replay_state_esn_len()
Message-ID: <670272e2-a4b2-4bdd-95c0-26d1e7c65816@stanley.mountain>
References: <018ecf13-e371-4b39-8946-c7510baf916b@stanley.mountain>
 <20250122123936.GB390877@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122123936.GB390877@kernel.org>

On Wed, Jan 22, 2025 at 12:39:36PM +0000, Simon Horman wrote:
> > The one caller that I didn't modify was xfrm_sa_len().  That's a bit
> > complicated and also I'm kind of hoping that we don't handle user
> > controlled data in that function?  The place where we definitely are
> > handling user data is in xfrm_alloc_replay_state_esn() and this patch
> > fixes that.
> 
> Yes, that is a bit "complex".
> 

I don't have a reason to suspect xfrm_sa_len() but if we were to write
a paranoid version of it then I've written that draft below.  I stole
Herbert's xfrm_kblen2klen() function[1].  Also the nlmsg_new() function
would need to be updated as well.

https://lore.kernel.org/all/Z2KZC71JZ0QnrhfU@gondor.apana.org.au/

regards,
dan carpenter

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e015ffbed819..ca7a8152e6d4 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1015,6 +1015,8 @@ static inline struct nlmsghdr *nlmsg_put_answer(struct sk_buff *skb,
  */
 static inline struct sk_buff *nlmsg_new(size_t payload, gfp_t flags)
 {
+	if (payload > INT_MAX)
+		return NULL;
 	return alloc_skb(nlmsg_total_size(payload), flags);
 }
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 08c6d6f0179f..ea51a730f268 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3575,61 +3575,69 @@ static int xfrm_notify_sa_flush(const struct km_event *c)
 
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_SA);
 }
+static inline unsigned int xfrm_kblen2klen(unsigned int klen_in_bits)
+{
+	return klen_in_bits / 8 + !!(klen_in_bits & 7);
+}
 
-static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
+static inline size_t xfrm_sa_len(struct xfrm_state *x)
 {
-	unsigned int l = 0;
+	size_t l = 0;
+
 	if (x->aead)
-		l += nla_total_size(aead_len(x->aead));
+		l = size_add(l, nla_total_size(aead_len(x->aead)));
 	if (x->aalg) {
-		l += nla_total_size(sizeof(struct xfrm_algo) +
-				    (x->aalg->alg_key_len + 7) / 8);
-		l += nla_total_size(xfrm_alg_auth_len(x->aalg));
+		unsigned int old_size;
+
+		old_size = nla_total_size(sizeof(struct xfrm_algo) +
+				          xfrm_kblen2klen(x->aalg->alg_key_len));
+		l = size_add(l, old_size);
+		l = size_add(l, nla_total_size(xfrm_alg_auth_len(x->aalg)));
 	}
 	if (x->ealg)
-		l += nla_total_size(xfrm_alg_len(x->ealg));
+		l = size_add(l, nla_total_size(xfrm_alg_len(x->ealg)));
 	if (x->calg)
-		l += nla_total_size(sizeof(*x->calg));
+		l = size_add(l, nla_total_size(sizeof(*x->calg)));
 	if (x->encap)
-		l += nla_total_size(sizeof(*x->encap));
+		l = size_add(l, nla_total_size(sizeof(*x->encap)));
 	if (x->tfcpad)
-		l += nla_total_size(sizeof(x->tfcpad));
+		l = size_add(l, nla_total_size(sizeof(x->tfcpad)));
 	if (x->replay_esn)
-		l += nla_total_size(xfrm_replay_state_esn_len(x->replay_esn));
+		l = size_add(l, nla_total_size(xfrm_replay_state_esn_len(x->replay_esn)));
 	else
-		l += nla_total_size(sizeof(struct xfrm_replay_state));
+		l = size_add(l, nla_total_size(sizeof(struct xfrm_replay_state)));
 	if (x->security)
-		l += nla_total_size(sizeof(struct xfrm_user_sec_ctx) +
-				    x->security->ctx_len);
+		l = size_add(l, nla_total_size(sizeof(struct xfrm_user_sec_ctx) +
+				    x->security->ctx_len));
 	if (x->coaddr)
-		l += nla_total_size(sizeof(*x->coaddr));
+		l = size_add(l, nla_total_size(sizeof(*x->coaddr)));
 	if (x->props.extra_flags)
-		l += nla_total_size(sizeof(x->props.extra_flags));
+		l = size_add(l, nla_total_size(sizeof(x->props.extra_flags)));
 	if (x->xso.dev)
-		 l += nla_total_size(sizeof(struct xfrm_user_offload));
+		l = size_add(l, nla_total_size(sizeof(struct xfrm_user_offload)));
 	if (x->props.smark.v | x->props.smark.m) {
-		l += nla_total_size(sizeof(x->props.smark.v));
-		l += nla_total_size(sizeof(x->props.smark.m));
+		l = size_add(l, nla_total_size(sizeof(x->props.smark.v)));
+		l = size_add(l, nla_total_size(sizeof(x->props.smark.m)));
 	}
 	if (x->if_id)
-		l += nla_total_size(sizeof(x->if_id));
+		l = size_add(l, nla_total_size(sizeof(x->if_id)));
 	if (x->pcpu_num)
-		l += nla_total_size(sizeof(x->pcpu_num));
+		l = size_add(l, nla_total_size(sizeof(x->pcpu_num)));
 
 	/* Must count x->lastused as it may become non-zero behind our back. */
-	l += nla_total_size_64bit(sizeof(u64));
+	l = size_add(l, nla_total_size_64bit(sizeof(u64)));
 
 	if (x->mapping_maxage)
-		l += nla_total_size(sizeof(x->mapping_maxage));
+		l = size_add(l, nla_total_size(sizeof(x->mapping_maxage)));
 
 	if (x->dir)
-		l += nla_total_size(sizeof(x->dir));
+		l = size_add(l, nla_total_size(sizeof(x->dir)));
 
 	if (x->nat_keepalive_interval)
-		l += nla_total_size(sizeof(x->nat_keepalive_interval));
+		l = size_add(l, nla_total_size(sizeof(x->nat_keepalive_interval)));
 
 	if (x->mode_cbs && x->mode_cbs->sa_len)
-		l += x->mode_cbs->sa_len(x);
+		l = size_add(l, x->mode_cbs->sa_len(x));
 
 	return l;
 }
@@ -3641,17 +3649,17 @@ static int xfrm_notify_sa(struct xfrm_state *x, const struct km_event *c)
 	struct xfrm_usersa_id *id;
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
-	unsigned int len = xfrm_sa_len(x);
+	size_t len = xfrm_sa_len(x);
 	unsigned int headlen;
 	int err;
 
 	headlen = sizeof(*p);
 	if (c->event == XFRM_MSG_DELSA) {
-		len += nla_total_size(headlen);
+		len = size_add(len, nla_total_size(headlen));
 		headlen = sizeof(*id);
-		len += nla_total_size(sizeof(struct xfrm_mark));
+		len = size_add(len, nla_total_size(sizeof(struct xfrm_mark)));
 	}
-	len += NLMSG_ALIGN(headlen);
+	len = size_add(len, NLMSG_ALIGN(headlen));
 
 	skb = nlmsg_new(len, GFP_ATOMIC);
 	if (skb == NULL)


