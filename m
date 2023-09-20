Return-Path: <netdev+bounces-35238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF67A8148
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F2D1C20C4F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3528E23;
	Wed, 20 Sep 2023 12:44:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40330FA0
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92C9C433C7;
	Wed, 20 Sep 2023 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695213841;
	bh=gOKur9zUz6+c5LnaTDY10PlwXsB3Y4TfCJ5DJMqIXUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFKSnM5E4LAnQwhEcFQQyX03qyNIowVVCL96c3kV30iDpyuHHQPoIICL9NAtscXxE
	 bkHHp7Y22+wtCSKwue6U1w/KFXl65b6zpdum68xiiehjpOhNMMC+OkgeW4b5KrILAq
	 0kaBx8YlP02UX2rZDDjpgB2qG0599wPpHsZUj4PWTERSDh39VtfmQPqFGItOCJpKkF
	 J1pN/4vLaJ1JMGcu5RlUYlqQD6N3p/Kaoplns5yD6jGAK55LHWk1f2xy0Zd6ZdkPDH
	 LZEOep01jbDc1LUseG3WZfSXnJPHIVHNqBasl8aCxDZUcpAyzD5GX++WoIxaliCXY2
	 YssPEmAuAIEdQ==
Date: Wed, 20 Sep 2023 05:48:09 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, quic_viswanat@quicinc.com, 
	quic_clew@quicinc.com, horms@kernel.org
Subject: Re: [PATCH V2 net-next 1/2] net: qrtr: Prevent stale ports from
 sending
Message-ID: <kzl2n3jo4x4eicfnorm7ozxvyzyrrhjgvnqir52uxovo5wp5n7@xtvecqtxepyl>
References: <20230920053317.2165867-1-quic_srichara@quicinc.com>
 <20230920053317.2165867-2-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920053317.2165867-2-quic_srichara@quicinc.com>

On Wed, Sep 20, 2023 at 11:03:16AM +0530, Sricharan Ramabadhran wrote:
> From: Chris Lew <quic_clew@quicinc.com>
> 
> If some client tries to initialize a QRTR socket during QRTR
> init, the socket will become stale after the ns(namespace server)
> binds to the QRTR control port. The client should close and reopen
> the QRTR socket once ENETRESET is posted to the stale socket.
> 
> There is a possibility that a client tries to send to the NS before
> processing the ENETRESET. In the case of a NEW_SERVER control message,
> the control message will reach the NS and be forwarded to the firmware.
> The client will then process the ENETRESET closing and re-opening the
> socket which triggers a DEL_SERVER and then a second NEW_SERVER.
> This scenario will give an unnecessary disconnect to the clients on the
> firmware who were able to initialize on the first NEW_SERVER.
> 
> This was seen when qrtr-ns was a separate application, but there is
> still a potential gap between AF_QIPCRTR socket register and when
> qrtr_ns_init binds to the socket where this issue can still occur.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

