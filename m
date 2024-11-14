Return-Path: <netdev+bounces-144975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E37439C9043
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF47B29224
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ABA18C35C;
	Thu, 14 Nov 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cS4oQUap"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07A1850B5
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599003; cv=none; b=Nk4yp8hywKQs8J/iLv98eUYFh+8bbZERMsGjBoPUc8T+3KDKh4lxsiwMFQV138hQk4wRpConfOdgJC+0eXF8fF+wfFwiCi6B4rgLEoi9J8PTYuY5A76qJeVhf2kdkyKF3yAaQ4mxz0u5/D8SI36bITJbDcG+ViirJTn+zUq+qPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599003; c=relaxed/simple;
	bh=cpkpvcI4nnZ6IoTG09tDrpa0CY5qnKUuAFVyTovamKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6Kk7gElyYsgs1bjFRyAynj4GnRvFwdfeS8PNRi2Y63EzDtEpHXQxaH75zPQJCcR3RcO7LKEd2fZ4/T0Y4Vaohe74JF+1zUDAOE7jZaxXtQiPS/h7uCJNH7lJfcVhmkfFW2Z2+NXLUvgrmsTRBwDTmx8i7BvB8lFkpnVTn4oEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cS4oQUap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731599000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXhPhd6T64qopenKzDTr2VAsOd523bKkU/nV0+x9Uek=;
	b=cS4oQUaphP6oXO4Z68oq2PFfqmvaLwgfQinOQme+9Wvjg0FTu0QnJNnr9va+NYWQDZs4dg
	gl/B1IBLnvmGXPm5cEv/l5Ye5k5zNUIHBDHYwjAznnkHu1bjXPoVh39dtUuowTKvnrVAYT
	vNAoU03Xn/5hAah0gp/FyBEzcE4MTxs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-VndQnvGlMsOTcWCudlfI3A-1; Thu, 14 Nov 2024 10:43:19 -0500
X-MC-Unique: VndQnvGlMsOTcWCudlfI3A-1
X-Mimecast-MFC-AGG-ID: VndQnvGlMsOTcWCudlfI3A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38218576e86so469172f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 07:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598998; x=1732203798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXhPhd6T64qopenKzDTr2VAsOd523bKkU/nV0+x9Uek=;
        b=CnsMyUnCp2hMzt/8Vmwxe7EABdShKqn7SqJ28K/Zq7I1zz2eEve5IG9zZK6nRgG3ob
         RaRLCJ/FXPUmYOGXWIO/iYu+/yOX7oA4mIqYQIR7c0kcWVNBr31wccODtcHKvwyyIqvy
         VxsOOioAMtg0oMnY9loG8NBbLvrv+sS/eMK4cTKendKxAbgFKR/zGn4W4oz89O1gEVZa
         KWspfXIsSqqGAH49/isknzZ6lB1HbeWqiNCqFdPpnt6xtb6DlKFBzCgpdH5bSfklYyM/
         bknuShTqGaPYqLLTo9FohxTs5IvMoWKk7fPoUbuYYFK98dE5XoD3ChcVrTleJkYFhqQc
         4clw==
X-Forwarded-Encrypted: i=1; AJvYcCXE4tRiKW2gy3UY6wrU7xT9ciA9ka9fYjxbHQqbg0Glbg03/hUxQPiig1fTs+RZlCf2IwOLv0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy358v0vI0PXcLjBSKMrrGIo0HDcGE1CjI8dARH3RAYq1+w/y4f
	Ao9CkjUWLiJGuzBhjuuuLsK88gzN7FsNq1WDEi5o/i8SFsUXsjER5YvqrFrIUWdCrITpfcpbRLZ
	7c3YdOTZnu/RNcpQHxYx+zkjTklD+TnW82Vsu+S65qE0469UxhyXvcA==
X-Received: by 2002:a05:6000:184f:b0:381:e771:e6dc with SMTP id ffacd0b85a97d-382140752femr3138943f8f.28.1731598998151;
        Thu, 14 Nov 2024 07:43:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoMlXHEHIIIf/8vuBedCySo4LpdsmnKwwPgZlfZJLBlokpUPY1g/zGswFuAox/GMsDltKRSg==
X-Received: by 2002:a05:6000:184f:b0:381:e771:e6dc with SMTP id ffacd0b85a97d-382140752femr3138917f8f.28.1731598997736;
        Thu, 14 Nov 2024 07:43:17 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7206csm24235755e9.7.2024.11.14.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:43:17 -0800 (PST)
Date: Thu, 14 Nov 2024 16:43:15 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-omap@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Pekka Varis <p-varis@ti.com>
Subject: Re: [PATCH net-next v4 1/2] net: ethernet: ti: am65-cpsw: update
 pri_thread_map as per IEEE802.1Q-2014
Message-ID: <ZzYak49k8fQC76/+@debian>
References: <20241114-am65-cpsw-multi-rx-dscp-v4-0-93eaf6760759@kernel.org>
 <20241114-am65-cpsw-multi-rx-dscp-v4-1-93eaf6760759@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-am65-cpsw-multi-rx-dscp-v4-1-93eaf6760759@kernel.org>

On Thu, Nov 14, 2024 at 03:36:52PM +0200, Roger Quadros wrote:
> IEEE802.1Q-2014 supersedes IEEE802.1D-2004. Now Priority Code Point (PCP)
> 2 is no longer at a lower priority than PCP 0. PCP 1 (Background) is still
> at a lower priority than PCP 0 (Best Effort).

Reviewed-by: Guillaume Nault <gnault@redhat.com>

> Reference:
> IEEE802.1Q-2014, Standard for Local and metropolitan area networks
>   Table I-2 - Traffic type acronyms
>   Table I-3 - Defining traffic types
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/ethernet/ti/cpsw_ale.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index 8d02d2b21429..9f79056b3f48 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> @@ -1692,26 +1692,34 @@ static void cpsw_ale_policer_reset(struct cpsw_ale *ale)
>  void cpsw_ale_classifier_setup_default(struct cpsw_ale *ale, int num_rx_ch)
>  {
>  	int pri, idx;
> -	/* IEEE802.1D-2004, Standard for Local and metropolitan area networks
> -	 *    Table G-2 - Traffic type acronyms
> -	 *    Table G-3 - Defining traffic types
> -	 * User priority values 1 and 2 effectively communicate a lower
> -	 * priority than 0. In the below table 0 is assigned to higher priority
> -	 * thread than 1 and 2 wherever possible.
> -	 * The below table maps which thread the user priority needs to be
> +
> +	/* Reference:
> +	 * IEEE802.1Q-2014, Standard for Local and metropolitan area networks
> +	 *    Table I-2 - Traffic type acronyms
> +	 *    Table I-3 - Defining traffic types
> +	 * Section I.4 Traffic types and priority values, states:
> +	 * "0 is thus used both for default priority and for Best Effort, and
> +	 *  Background is associated with a priority value of 1. This means
> +	 * that the value 1 effectively communicates a lower priority than 0."
> +	 *
> +	 * In the table below, Priority Code Point (PCP) 0 is assigned
> +	 * to a higher priority thread than PCP 1 wherever possible.
> +	 * The table maps which thread the PCP traffic needs to be
>  	 * sent to for a given number of threads (RX channels). Upper threads
>  	 * have higher priority.
>  	 * e.g. if number of threads is 8 then user priority 0 will map to
> -	 * pri_thread_map[8-1][0] i.e. thread 2
> +	 * pri_thread_map[8-1][0] i.e. thread 1
>  	 */
> -	int pri_thread_map[8][8] = {	{ 0, 0, 0, 0, 0, 0, 0, 0, },
> +
> +	int pri_thread_map[8][8] = {   /* BK,BE,EE,CA,VI,VO,IC,NC */
> +					{ 0, 0, 0, 0, 0, 0, 0, 0, },
>  					{ 0, 0, 0, 0, 1, 1, 1, 1, },
>  					{ 0, 0, 0, 0, 1, 1, 2, 2, },
> -					{ 1, 0, 0, 1, 2, 2, 3, 3, },
> -					{ 1, 0, 0, 1, 2, 3, 4, 4, },
> -					{ 1, 0, 0, 2, 3, 4, 5, 5, },
> -					{ 1, 0, 0, 2, 3, 4, 5, 6, },
> -					{ 2, 0, 1, 3, 4, 5, 6, 7, } };
> +					{ 0, 0, 1, 1, 2, 2, 3, 3, },
> +					{ 0, 0, 1, 1, 2, 2, 3, 4, },
> +					{ 1, 0, 2, 2, 3, 3, 4, 5, },
> +					{ 1, 0, 2, 3, 4, 4, 5, 6, },
> +					{ 1, 0, 2, 3, 4, 5, 6, 7 } };
>  
>  	cpsw_ale_policer_reset(ale);
>  
> 
> -- 
> 2.34.1
> 


