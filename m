Return-Path: <netdev+bounces-179816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A1AA7E909
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C891178E92
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65B92144AD;
	Mon,  7 Apr 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8Q8/eIP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617E4A02;
	Mon,  7 Apr 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048252; cv=none; b=bbtaupTqT/brSrQZ+hEGLbcLWLCgB3L1z2l3+j5+29EbA6qG5TjA0+AFVIrGpquHG1GrHYOCAN504K24wGrHgP//01L4vkpX59thWgRDmV4fJVAMbavdCE2j/1SfGCgiIEzczN+Wzffn8xQTI2hOfwByxYmALPqSh4G6KBkdTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048252; c=relaxed/simple;
	bh=rXVwFrugrxokQycM4a9ebHzsyPZ14gJZKf3lXGIzVpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk5SLtOyDGnHncMbcXmuk9aQ0jOtEwZdiV77pM7O43jwuc7mjC3GwaC6rIPqPbKIFdORObRPktDAPD6RJYusoR/C6EsBEWhfnr/75e3PoScn8EphHy1jmy0NqsaNm6vrMWnEMMwsE8xS2eGrfxMV5SqI8LIKkdZrpO6CBSeB3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8Q8/eIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44E6C4CEDD;
	Mon,  7 Apr 2025 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744048252;
	bh=rXVwFrugrxokQycM4a9ebHzsyPZ14gJZKf3lXGIzVpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8Q8/eIP/TDIZeLQg6iF6LA+dmhLoQR7hsg57sLiWgmWESKlDqK4cRYvrxrwMlctF
	 URE7icx5ykRzTdJ2SZTiyE6TmkKTk5ruW43AbE1jJwSD3s9FEaSyNwjHdXoV+rBz08
	 gAmal0v7MjnpSEDVnXMuw4eAkpnkouf9uB0UIE2dSNVHOdjAbl0wI7MNdf6tIDK6Yl
	 Wl5oviMmtzYC71Gtf3EnJEZgk7sY8IyKSQnUoXqPwaB7E27YLilQ3t/0TQ4z62acDm
	 blhySFhsKTJaoivl9jplDfCfGK/m4/7uUcNlJK+Avi/UnlyJ6mL361yTq7JWleyykY
	 b7MTEW5kWlldw==
Date: Mon, 7 Apr 2025 10:50:48 -0700
From: Kees Cook <kees@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 10/28] lib: Allow modules to use strnchrnul
Message-ID: <202504071050.4D2EC7C@keescook>
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407173149.1010216-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407173149.1010216-1-ivecera@redhat.com>

On Mon, Apr 07, 2025 at 07:31:40PM +0200, Ivan Vecera wrote:
> Commit 0bee0cece2a6a ("lib/string: add strnchrnul()") added the
> mentioned function but did not export it so it cannot be used by
> modules.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

