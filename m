Return-Path: <netdev+bounces-94901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4968C0F77
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FF2282D1D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E014B946;
	Thu,  9 May 2024 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHMYU350"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B514B091
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256998; cv=none; b=E3324gvSgfiseQtRBILTjZ3BaaOmdCZGe4tDlpHnsjToNUMElu2Vkm6/YQU6wL/J/0C3acshfF7q11HoAKvx5RX/4WrlI53OeSxgLSvp1wIpSCe5vvsbtnLZWvYQ+PVyOHeiVrYQrB8RJ1s7Kcr1Ep7nC96ruKKXA8ooF15mnNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256998; c=relaxed/simple;
	bh=Uu2OIiaS1VhlNNolmQ+M1AEeleFMsDc79BvljTQkKqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIJFPsM6Kz4SH9do3sn3BCedL1vsZRnDB+L8AGbYfrbo9FKUDAPYlafqJt9DeteEeYIMtasJbpLpouE/AY+W9WP9I+sZMoyE/lhGbuy1LXcgAKh3pR5vqc6OVcZjMA3ZSpFfElSuAmSNHkc9UlwmNfrUJPjAq0pxNEGKDEYJSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHMYU350; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6465BC116B1;
	Thu,  9 May 2024 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715256998;
	bh=Uu2OIiaS1VhlNNolmQ+M1AEeleFMsDc79BvljTQkKqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHMYU350oc7/2zoGcOPFsr/ve0lY+OgTC0oXuCiS+0o0xgQv06gpTlmfSBPFWXrZI
	 CK18f7O/6USZ7TsdYlJPdTpzaZHqKvjdJnNuFuiUFs7QVz2snkadZlwWQ+m0ejNUCu
	 JPE5+goKjmbIUsRGcRWXE9F5RJHHbp66SKFfoI7YBDVyZAZEdkFTdfUH+VEeb0qTlV
	 QMISrvhCkUUvPDOpG/8sHDAjUQAGIdnvI4ra4X1QwE9Bpe6BlcM75zyKIBrCrvWZyL
	 BmQz8+i2/5BL4CfE22ps5/w8lMqn2k6uxdrdLy6p23nIpye3JJVQoGCe9g/0CqYgTM
	 TEwsUC0DdHXZg==
Date: Thu, 9 May 2024 13:16:34 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 07/12] gtp: move debugging to skbuff build
 helper function
Message-ID: <20240509121634.GQ1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-8-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-8-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:46AM +0200, Pablo Neira Ayuso wrote:
> Move debugging to the routine to build GTP packets in preparation
> for supporting IPv4-in-IPv6-GTP and IPv6-in-IPv4-GTP.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>


