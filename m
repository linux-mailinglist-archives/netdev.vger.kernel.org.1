Return-Path: <netdev+bounces-217378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3AB3880B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BD946189B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87B28C5DE;
	Wed, 27 Aug 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDWlU6lK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CA27FD59
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313626; cv=none; b=CqMvCSV2ZGyuqencANep7nrHAp+R1R9N9fYKjbZvqMMEjMauONg2fEYtHBt29UYjWEifF+lEsJHUkZCXq0dZSPikNvp3IBQS616xoF81DSpIxJmstrS3uWXsY3gvI2d7eExYBXHjEjBEXqVueTtgiLEqV+wwagbsQh2w+WKI4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313626; c=relaxed/simple;
	bh=BioUhj4QXtZRJnJ3AyEvJrk9faCU7uWqqxqZRB8trE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Etr/A4X9eC/HErpsA/fGKrN8ytwa4z6fd1e2cairzhdbYx+FL3cxgkns40rC9ZLJh78dPPujx+zvTSeWGXXJuI1v2XQWArnlECL75j1r6or/NuDYqmE1QuwwVn/Q80gDNCKvWBjpFdzVAEtVQYeXibVo1qYUzWaC5LuYzBctLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDWlU6lK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33BAC4CEEB;
	Wed, 27 Aug 2025 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313625;
	bh=BioUhj4QXtZRJnJ3AyEvJrk9faCU7uWqqxqZRB8trE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDWlU6lKTpcwuj12GJtx25qDUABKMahfRkRNzW4TYk7OcQPdVM1xdPqYMlCN2tieh
	 MJZXyd55g6q4OqfgjsQNUBHhTYmcGEleUQ19M2CGFUExBDOgQJzi307EWuCLda2V22
	 GeBb8xZEPKxXMBK/ltPs3xiR2D7d1erSIJ1TfFsNhcGapnXdozYhpK5yjLExbefjZi
	 9/WZgUsWKUdT7wKkShvxN9Frs5I48lKKxtR/mcSC1RO4mEYhSLI2TA1YZYrtxUxKNZ
	 oTDAtJD0bwvzf+6ruPpUpG+f2z395NCjx/ZJsrE+ISEPUfts2OwOCo4o/50TmgD1gU
	 81VCjGxae+OiQ==
Date: Wed, 27 Aug 2025 17:53:42 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 01/13] macsec: replace custom checks on
 MACSEC_SA_ATTR_AN with NLA_POLICY_MAX
Message-ID: <20250827165342.GC10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <22a7820cfc2cbfe5e33f030f1a3276e529cc70dc.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a7820cfc2cbfe5e33f030f1a3276e529cc70dc.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:19PM +0200, Sabrina Dubroca wrote:
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


