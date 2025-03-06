Return-Path: <netdev+bounces-172475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01052A54E61
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397DF16564F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B3F188A3A;
	Thu,  6 Mar 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM/zAHdE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6021422D4;
	Thu,  6 Mar 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272969; cv=none; b=SlNj1FtrrI6iR6Bvf7MT+nZP1xc9e+GVQRxnlFRszLjWdTI/sPusd4hLvAuTKRXDCQAXIqehfCXUgoy2nGsfY/qvLHiNI4wcqZzpC5ukcwKi50vOLqtt5zKVw8T9FQYt5hO/aPIhvt0fIMunn4/Lq3cH7VG6exZ2wmVzkOQ0kZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272969; c=relaxed/simple;
	bh=Tta3VqgGtG5tjSQmnuXO2bWvdx8BeSrt22ZyhUAdVPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEOgKElw5SSDSGI6o6h03Uek/7U8VyGaYsE1in5blRVXB164XXYiD9zJreOIALuz5OcunYN8tEEegQG3ClVUWi/ntymcpPQ2Av3EsKg+G6mURmcdEQirDBKZBixdsJYfPOpEqSy3wJg8iNTqVcxDCahqtUOhVWLas1LKeqTQ4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM/zAHdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93896C4CEE0;
	Thu,  6 Mar 2025 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741272968;
	bh=Tta3VqgGtG5tjSQmnuXO2bWvdx8BeSrt22ZyhUAdVPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RM/zAHdECIC68QPLpcMKenYhJ6P7pl74SVkoA9HtoLMucO1c5+1DAyiw3nKEV0z2J
	 xO25jLaM7KGyXZPX/zysHF9HPrcm0cDFeImzd7vlbv+WQyTG9gvEjoHDSPpVS4x5wA
	 Yq9M4teX9bLFbo/lBadypbEQylaD5CXc/zfz6YHqJxBvaH+Jnol1z5KysgpSnXP0EZ
	 eyEaACFwGkL33UDulkJEqv1WKTmfo1e8c5jOSuOyB2kRAjxuMEpF/9deVXbTQaD4BL
	 G35X/DJA5/+a/hZr+XaSGsyMqeB7Nr60PlqfuV2IM82ceK7bZslX7oEodibwBFUrGA
	 QCg/kKX66Mqnw==
Date: Thu, 6 Mar 2025 14:56:04 +0000
From: Simon Horman <horms@kernel.org>
To: satishkh@cisco.com
Cc: Christian Benvenuti <benve@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nelson Escobar <neescoba@cisco.com>,
	John Daley <johndale@cisco.com>
Subject: Re: [PATCH net-next v2 0/8] enic:enable 32, 64 byte cqes and get max
 rx/tx ring size from hw
Message-ID: <20250306145604.GB3666230@kernel.org>
References: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>

On Tue, Mar 04, 2025 at 07:56:36PM -0500, Satish Kharat via B4 Relay wrote:
> This series enables using the max rx and tx ring sizes read from hw.
> For newer hw that can be up to 16k entries. This requires bigger
> completion entries for rx queues. This series enables the use of the
> 32 and 64 byte completion queues entries for enic rx queues on
> supported hw versions. This is in addition to the exiting (default)
> 16 byte rx cqes.
> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> ---
> Changes in v2:
> - Added net-next to the subject line.
> - Removed inlines from function defs in .c file.
> - Fixed function local variable style issues.
> - Added couple of helper functions to common code.
> - Fixed checkpatch errors and warnings.
> - Link to v1: https://lore.kernel.org/r/20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com
> 
> ---
> Satish Kharat (8):
>       enic: Move function from header file to c file
>       enic: enic rq code reorg
>       enic: enic rq extended cq defines
>       enic: enable rq extended cq support
>       enic : remove unused function cq_enet_wq_desc_dec
>       enic : added enic_wq.c and enic_wq.h
>       enic : cleanup of enic wq request completion path
>       enic : get max rq & wq entries supported by hw, 16K queues

nit: please consistently use "enic: " as the subject prefix for
     the cover-letter and all patches in this patch-set.

