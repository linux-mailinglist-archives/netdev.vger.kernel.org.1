Return-Path: <netdev+bounces-52616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C067FF7B4
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1DF281D62
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D775F55C1E;
	Thu, 30 Nov 2023 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlikIAiZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2C3C694
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 17:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338B1C433C8;
	Thu, 30 Nov 2023 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701363910;
	bh=RzSKagrT+3ey649/vwouXJ0AF6xcU8DgN3n3RI/4R9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlikIAiZ77eoCBeIlQzItIdxQjiV+b12uuExG4flotNXT8cuMmfPWLyx5UUnYklte
	 OGG4bJASBOXmpvtI3tuDqOYUoKwIwbCWQ7b8a6veFVz4ocY/KJmzHYJHQuZozE8+Pb
	 WHogpEHylw1VQ/4NjKJg1RH4eRBddNWor7npy0BZbSds+OOBSbiwPXJoj4u77J40d9
	 ZUjJ94E7/Mx98Diq6OQ4JFRw1CoKCBpPG2VTgzdUtbmjZ4sjZcoWrfYn5oD2rqRqt2
	 Ptac8iz8+ApSJCNJr/kwb8GP5boq/hRrkEDAOzSbY9BPMey3tiJGHpJi9P0G8isjNB
	 8+aLH8h1kuUnQ==
Date: Thu, 30 Nov 2023 17:05:06 +0000
From: Simon Horman <horms@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
 for the measured external offset
Message-ID: <20231130170506.GG32077@kernel.org>
References: <PH7PR03MB7064CC413965BFE5E005B273A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB7064CC413965BFE5E005B273A083A@PH7PR03MB7064.namprd03.prod.outlook.com>

On Wed, Nov 29, 2023 at 03:48:05PM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This change is for the PHC devices that can measure the phase offset
> between PHC signal and the external signal, such as the 1PPS signal of
> GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
> the existing ptp_extts_event so that application such as ts2phc can
> poll the external offset the same way as extts. Hence, ts2phc can use
> the offset to achieve the alignment between PHC and the external signal
> by the help of either SW or HW filters.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

...

> @@ -228,7 +230,10 @@ struct ptp_pin_desc {
>  #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
>  
>  struct ptp_extts_event {
> -	struct ptp_clock_time t; /* Time event occured. */
> +	union {
> +		struct ptp_clock_time t; /* Time event occured. */
> +		__s64 offset_ns;         /* Offset event occured */
> +	};

Hi Min Li,

if you end up respinning this patch, please consider correcting
the spelling of occurred.

>  	unsigned int index;      /* Which channel produced the event. */
>  	unsigned int flags;      /* Reserved for future use. */
>  	unsigned int rsv[2];     /* Reserved for future use. */
> -- 
> 2.39.2
> 

