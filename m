Return-Path: <netdev+bounces-142062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C49BD3D4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA4F28401F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79371E3DE6;
	Tue,  5 Nov 2024 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="o2Lx1fHu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF41E3796
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829433; cv=none; b=dXvF7YqZ41XXG0RJeWT23/pfOSxSiF8PI91lzEyEFiLLROSHpAPXoiWJ3bYwMcyYDqQtSYPZVmA53PpyJZSewsin3AYnutH44GShqDoohMB/VQw3pHGMDTDKZC2SmlQfvOk/epVQhQYZjxeRnIXd8gtLN+YM9hoaG5xwfipVvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829433; c=relaxed/simple;
	bh=lI6Cvmz35c+RRQPDM4nQbYhgF2mFm63vJTkHrvli67Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdrRT3xc9dQfdwVdr4WQSwa5xD9A4gAja2UVp5Nb3fI+ibTdcOXfK49/Ph0pGSvL+udkwFkBIPKQWxSNwVSXU54w5MbG13vLcq0qEhhTVwwl5v2dpLNWUssTq2oie2GheLBJ7CBzzsk9fw66HnRol5eCvzG/S8ugXNdprm+8hlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=o2Lx1fHu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so49156a91.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730829432; x=1731434232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq7q3zsR5CyhS7BrsMhgjqKSqADIzDIIYZpbrb/zwLA=;
        b=o2Lx1fHuvXd2mBk1BOnmAIZEt2HQgV6bgxv6IhCyILhmwshUOLPu8/OQ1OH8u1OHXp
         GQIum1rkGaspWgAQu/Oxm16PgQ9P7BtFUMBZBAoSCnSQ02SS20PVNmz+HNRoxYuksd4r
         n83tbgHEGvDBZ7TWJ4+FGo5voani+sMhXzWEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829432; x=1731434232;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hq7q3zsR5CyhS7BrsMhgjqKSqADIzDIIYZpbrb/zwLA=;
        b=Z/dZTUYcq61aqInKFQMK2phpxuCxQtzNwo19wbx+ImGhj03hMHzSP55rrRmjbuz7ma
         cQzRhM2LHOv6BRMCEX7oD27N5F88JR9LvCQdaLwadzPZ34WRgox4kIjXj2f/+6G8v9uf
         on0fZ4mIQPRH3rETgsq/T+8bK12xhxqRGbwkA4RmIgCdc7Y9vnbj/FN0OjeDjFjWXinP
         TN/+/xYF386KGZqR9qvA4pYEfFwjDMu390GCNMzRptbQKifvwQw9vCyWp4JA983/8TDv
         YDpgQ5zxOoEU6qulcV/vql09K+aEAXkike8yei6IW4ExROrGCFUuyvw3uTZsL6dBqcCZ
         N2xg==
X-Forwarded-Encrypted: i=1; AJvYcCXciT54/pFP9IAkDvDNyxsx0bkEgR6fHex0DfbA2h/0K1VNrSn9TKQ5SPCe3/DCtZgC2NJWGiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTdgmDMAQJmyUSJqxO61XqvhQbr8PYJpV9Ic9evl+ppwGm0BpS
	49FSaRzENOMcnq1fj8GTou/Xub8BhD/hL/s3D4dJkCpp8FDmaSmRdv8Vcgty62w=
X-Google-Smtp-Source: AGHT+IGL6n+BzG3xEpM6uM7RFwatUDWd9Th9mFOTVgSjl8wDMVahg6HBe83hLnzp6+zCgfXe+e3I+Q==
X-Received: by 2002:a17:90b:3147:b0:2e2:b94a:b6a9 with SMTP id 98e67ed59e1d1-2e94b7c6439mr27425744a91.0.1730829431583;
        Tue, 05 Nov 2024 09:57:11 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db17b0dsm10034272a91.42.2024.11.05.09.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:57:11 -0800 (PST)
Date: Tue, 5 Nov 2024 09:57:08 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/7] net: add debug check in
 skb_reset_inner_transport_header()
Message-ID: <ZypcdOZ63uDcn8I2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20241105174403.850330-1-edumazet@google.com>
 <20241105174403.850330-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174403.850330-3-edumazet@google.com>

On Tue, Nov 05, 2024 at 05:43:58PM +0000, Eric Dumazet wrote:
> Make sure (skb->data - skb->head) can fit in skb->inner_transport_header
> 
> This needs CONFIG_DEBUG_NET=y.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skbuff.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

