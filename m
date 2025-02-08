Return-Path: <netdev+bounces-164262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A587FA2D286
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670177A4E4C
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309391DDE9;
	Sat,  8 Feb 2025 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKeEeqdd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC98479
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977354; cv=none; b=rGpMQE87lNL6h3f7BB35KD7thUz0eVpLcwvul1zcivkKP6RUs0KL2LVjLR9VUZF0ha3Ymxp0sPAcY528xbj9LGvm82zJJS2SAtXGZKRmRWWV22gpVnUHxUvtA6LDZ29l+voPh1laUOCQwqq7sL2OP8qMxZGppwsCDE5oFnyYTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977354; c=relaxed/simple;
	bh=9wYGXBhltOm/4FPs8/YWKSnGVJc7G1tyCGhW6D0yf7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZoHMDxlgEvbkMSGt1AO97g/NDRYxco4CL0w6jjt4Qb57XtSiGWDMEjZtEGTlz1delT6ws7y4bpaIqcdIa57ksJLfmO2GTSfaZuFyDIeIS474BJgdylB8L1V04nNg17feL6Se4+OrlABCSi1KEnAvjOlrHidqcFCUojW0V4xSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKeEeqdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A49DC4CEE2;
	Sat,  8 Feb 2025 01:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738977353;
	bh=9wYGXBhltOm/4FPs8/YWKSnGVJc7G1tyCGhW6D0yf7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iKeEeqdd80xZ5HLbH2AeQJJKXARnf+4ozYL79Jz0eZVvzMkop98S0hQuqzqHj5tmz
	 DtWlYxpah++oue+usvfaKJjPVXeP3VZaRiSMrDXOsMKLM1EBgcWI/yIWhK2qPfSDeq
	 s6CfLXyR0Es+QwyKyM8KP2bhb/8eW31biqzh/pCGXRxS3NfRuerDFu0lEVJLRxYmCP
	 W9NnlaQU4bKRBZIWAU8W2sky2rYw/D+Bv8PA25gXjvs8xbJjU554C1dmPLpgs27Ne5
	 NosqJqvBrJRyk9Htc+4unt7fzYoRtXNHd3DpnZ+g+hWJ8sgUzgEoJ7XyllIL2+vcdK
	 PQSzTs6L3cCgA==
Date: Fri, 7 Feb 2025 17:15:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: mengyuanlou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v7 3/6] net: libwx: Redesign flow when sriov is
 enabled
Message-ID: <20250207171552.35446145@kernel.org>
In-Reply-To: <20250206103750.36064-4-mengyuanlou@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
	<20250206103750.36064-4-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 18:37:47 +0800 mengyuanlou wrote:
> +			vector_reg = (vfinfo->vf_mc_hashes[j] >> 5) &
> +				     GENMASK(6, 0);
> +			vector_bit = vfinfo->vf_mc_hashes[j] & GENMASK(4, 0);

Can you add proper defines for these fields and use FIELD_GET() ?

