Return-Path: <netdev+bounces-24632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B4770E50
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA7E1C20F0B
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B964524E;
	Sat,  5 Aug 2023 07:18:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9081FA5
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A903C433C8;
	Sat,  5 Aug 2023 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691219925;
	bh=nnZAHqsc7py9qR/waP2wKKOMRczL+4yYrtw97PjAbuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qp9XTeZcnlA50SuqrUVjefukQXpyy0R68S/iDRQV/ofD0GE0vU/fHz7aveNNUOIwb
	 BbEqAaOYO4/pTZjlj2tYel9ISmvVuRAi9KqWiJRsHOKdNSABM03KQ+dBRtqRyC/6W6
	 cNNEVWN0pr5g79z1qnTvglfXSGZfp3he8kUlFqzz6o9uXXpKGpETPgmzPQ7Zz5p/6S
	 y4Pumzlux8PWk8N2L+UcXuCXrMmn5hvWEh00HI2w9ucPLOrcl7fztEx14ap6k5B7kJ
	 QwVd8vSUTPlSG8hMSvfeapejz9V5rELQ6Vby/F3tkK8kMUSQZugRHz4DUcVZs8hHQd
	 Lv2CLZ0iV6lpg==
Date: Sat, 5 Aug 2023 09:18:41 +0200
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
	danymadden@us.ibm.com, tlfalcon@linux.ibm.com,
	bjking1@linux.ibm.com
Subject: Re: [PATCH net 1/5] ibmvnic: Enforce stronger sanity checks on login
 response
Message-ID: <ZM330WW6aHIQsb5y@vergenet.net>
References: <20230803202010.37149-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803202010.37149-1-nnac123@linux.ibm.com>

On Thu, Aug 03, 2023 at 03:20:06PM -0500, Nick Child wrote:
> Ensure that all offsets in a login response buffer are within the size
> of the allocated response buffer. Any offsets or lengths that surpass
> the allocation are likely the result of an incomplete response buffer.
> In these cases, a full reset is necessary.
> 
> When attempting to login, the ibmvnic device will allocate a response
> buffer and pass a reference to the VIOS. The VIOS will then send the
> ibmvnic device a LOGIN_RSP CRQ to signal that the buffer has been filled
> with data. If the ibmvnic device does not get a response in 20 seconds,
> the old buffer is freed and a new login request is sent. With 2
> outstanding requests, any LOGIN_RSP CRQ's could be for the older
> login request. If this is the case then the login response buffer (which
> is for the newer login request) could be incomplete and contain invalid
> data. Therefore, we must enforce strict sanity checks on the response
> buffer values.
> 
> Testing has shown that the `off_rxadd_buff_size` value is filled in last
> by the VIOS and will be the smoking gun for these circumstances.
> 
> Until VIOS can implement a mechanism for tracking outstanding response
> buffers and a method for mapping a LOGIN_RSP CRQ to a particular login
> response buffer, the best ibmvnic can do in this situation is perform a
> full reset.
> 
> Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> 
> Hello!
> This patchset is all relevant to recent bugs which came up regarding
> the ibmvnic login process. Specifically, when this process times out.
> 
> ibmvnic devices are virtual devices which need to "login" to a physical
> NIC at the end of its initialization process. This invloves sending a
> command to the VIOS (virtual input output server, essentially the server
> that this client is logging into) requesting it to fill out a DMA mapped
> repsonse buffer. Once done, the VIOS sends a response informing the
> client that the buffer has been filled with data.
> 
> If the VIOS does not send a response in 20 seconds then the client tries
> again. If this happens then several bugs can occur. This is usually due
> to the fact that there are more than one outstanding requests and no
> mechanism for mapping a response CRQ to a given response buffer. Until
> that mechanism is created, this patchset aims to harden this timeout
> recovery process so that the device does not get stuck in an inopperable
> state.

This sort of information really belongs in a cover letter for the patchset.
And in any case, it's nice to have a cover letter if there is more
than one patch in the series.

>  drivers/net/ethernet/ibm/ibmvnic.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 763d613adbcc..996f8037c266 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -5397,6 +5397,7 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
>  	int num_rx_pools;
>  	u64 *size_array;
>  	int i;
> +	u32 rsp_len;

nit: It's preferred in Networking code to arrange local variables in
     reverse xmas tree order - longest line to shortest.

     I know this file doesn't follow that very closely.
     But still, it would be slightly nicer, at least in this case.

...

