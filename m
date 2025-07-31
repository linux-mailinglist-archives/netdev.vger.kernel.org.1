Return-Path: <netdev+bounces-211144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8FB16E21
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEA7561AC7
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09B28D8E1;
	Thu, 31 Jul 2025 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyGkjBmd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08CB1E231F
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952880; cv=none; b=Av125SY1Jt/ILhCQJQ036ZgU93lDRVidaOVUqsJAVcOLbHPTg2FWUD2On7jH7d/uI/3enZL2LEJxE526vttcO/je5Ua8LP+8lt+1IL/umnlYEIKo2nPr/0z3L4LShAvWN/0Nx09IRTd4Egvd5LoQPmiNgjQkxBLBsVuxYL6xELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952880; c=relaxed/simple;
	bh=yEK4AMqOp+J5XY7duc/7m+8Az7VEwc/OeM52p4k7Myo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZwNxds/jL5vR3qANpPGEGtxOU0I5MufxsTgE9tZrr5zmgW4LlmTpA6GaGRnLJEohNgVzpg5kpA8iuD9D4ImsqTb85APtpmDGauvCAMSHRiOi0ENQPiDMV7l8kpiwvnY107VR/ISJiKpmhsEnAKfiaL9AzIoJPjUgDDNmUYGQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyGkjBmd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso1295655e9.0
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753952877; x=1754557677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66N593Z0nuoZIAGdEj0IM2jhkW2Pf2fhdI8POkfcCgA=;
        b=DyGkjBmd2OHzMkuWLU1aYufLXdIcEoF2+8pDJsUJxdqudwalw8gRUmtKHGeBgNmp2M
         Y7OCJyDqKmCza4gijWElJsJxCWVF15/1GYV/H6e2ocE6PbFLTnEqD4H7vTp/J1ree7Yw
         6LJMuFVbqPXf7iOQ8FVsjN7oPP9/YYQfrU+iQv2h9ayu0WRkK8sR5IuS4Mac3oX3wqfQ
         Zh9EUfLZuCUIemYfVFFfGuQ/eDd3CR8+AqZrXRvzqlHd3kUeBodvk+LIqO1mKX8+nniU
         komQm9Z2oZbIvrePmv3uzzIYQoW5WH617ShywV5GBsxUMVJjlJ8wb/k11Bsb/+zzfMWM
         Yopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952877; x=1754557677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66N593Z0nuoZIAGdEj0IM2jhkW2Pf2fhdI8POkfcCgA=;
        b=qM7gbnAp30e7CkbCvNr2SF+dPqLvvU4zO1yD3HIbf1OJBsNC7/1dah2V9aHC8pd4xM
         gcyltikl6WsC0UYqUsnS8bEB98Ss4UdwBN4K7VUDiX7r3k7Zk9OZsdTr0n4O+COm0vhY
         7cNCewFp9Vj/6etV9JHkUEPPceES+rTSQVSBPF5iOMdtnDPatddHiYW+3umDOfPvJBjR
         M0pVx0FM4X/EefKOXIs/bkkxhJ9Vg0l61Xz6anBL3rWctdSyYImDO1FP/8cd0ScatcN2
         eWNzcfPBJeOoTCYpsTchHIlXgJVd1WFkxpSZvRiCplbTm4hOvz5okAUTw9Cmb64ThEjk
         Z/nw==
X-Gm-Message-State: AOJu0YzldDAChMnHMrMxqPfX+izCu9O8EaKR1SXzNmFhZLjoYC8ok75A
	WtZilcwFFCOVEV7q9p4DjJTaAUrm9KpB2XmmU3PMFAizpgL+IY+ya3pBvppC/LIW
X-Gm-Gg: ASbGncto4xMJc7MU/tO1BGj6+j8/INaobBSA7EG8+9v7KMvV3HSNmajLVIQ2/J04jsh
	dqP3jS63o9VzS3Xa6xPc5ppDEF++54cv+3mlclHK6eQXfdS1XAzj/q1+P6OkcizTz+iu8RsLOTT
	eaKp8tIf2X55qPdeqvJtF2c4YyaIGORve99RKqWceyOlD5cSnLygFwzD30+Mwaok5JGktb0MF3L
	T3n2c57OfI/eAdUZ1TFTn3Lmih+qZxNgHwh+6KMXDKl48uz5frbj6sLrr16A39gpul3bZ7fNyRr
	nuxtzVdi/W4Q3GDOMT/tfN/OQZk1bfhwH32sk2JBUtfgcLwkNQV3JOmD/JZ+/fz2DreRGoD4VUF
	kbmuiQILECeOKCA==
X-Google-Smtp-Source: AGHT+IH5b99dvld3S+07jN5Pmj9XZf4fM0rvcAs1w0vfhckHPH0X1aawyeE9WAUaI1bWwxB/nmSj8g==
X-Received: by 2002:a05:6000:2383:b0:3b7:91b8:1eeb with SMTP id ffacd0b85a97d-3b794fc1336mr1935504f8f.4.1753952876620;
        Thu, 31 Jul 2025 02:07:56 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:97a:e6c7:bad3:aa51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c470102sm1704033f8f.53.2025.07.31.02.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:07:55 -0700 (PDT)
Date: Thu, 31 Jul 2025 12:07:53 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: validate source trunk against lags_len
Message-ID: <20250731090753.tr3d37mg4wsumdli@skbuf>
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>

Hello Luke,

On Thu, Jul 31, 2025 at 03:35:34PM +1000, Luke Howard wrote:
> A DSA frame with an invalid source trunk ID could cause an out-of-bounds read
> access of dst->lags.
> 
> This patch adds a check to dsa_lag_by_id() to validate the LAG ID is not zero,
> and is less than or equal to dst->lags_len. (The LAG ID is derived by adding
> one to the source trunk ID.)
> 
> Note: this is in the fast path for any frames within a trunk.
> 
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---
>  include/net/dsa.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 2e148823c366c..67672c5ff22e5 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -180,6 +180,9 @@ struct dsa_switch_tree {
>  static inline struct dsa_lag *dsa_lag_by_id(struct dsa_switch_tree *dst,
>  					    unsigned int id)
>  {
> +	if (unlikely(id == 0 || id > dst->lags_len))
> +		return NULL;
> +
>  	/* DSA LAG IDs are one-based, dst->lags is zero-based */
>  	return dst->lags[id - 1];
>  }
> -- 
> 2.43.0

1. You need to add a Fixes: tag, like the following:
Fixes: 5b60dadb71db ("net: dsa: tag_dsa: Support reception of packets from LAG devices")

2. The problem statement must not remain in the theoretical realm if you
   submit a patch intended as a bug fix. Normally the tagger is used to
   process data coming from the switch hardware, so to trigger an
   out-of-bounds array access would imply that the problem is elsewhere.
   That, or you can make it clear that the patch is to prevent a
   modified dsa_loop from crashing when receiving crafted packets over a
   regular network interface. But using dsa_loop with a modified
   dsa_loop_get_protocol() return value is a developer tool which
   involves modifying kernel sources. I would say any fix that doesn't
   fix any real life problem in production systems should be sent to
   'net-next', not to 'net'. This is in accordance with
   Documentation/process/stable-kernel-rules.rst.

3. As per Documentation/process/submitting-patches.rst, you should
   replace the wording "This patch adds" with the imperative mood.

4. Please use ./scripts/get_maintainer.pl to generate the recipient
   list, don't send patches just to the mailing list, reviewers might
   miss them.

