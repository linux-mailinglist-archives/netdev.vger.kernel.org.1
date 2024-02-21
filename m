Return-Path: <netdev+bounces-73522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ECF85CE13
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C52D1F23011
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5F249E4;
	Wed, 21 Feb 2024 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW/O5OHO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C36FC9
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482972; cv=none; b=aQ0bSLnTqrbQOBmfNhpVZ8B/ClQhkWtDrAtla4pjS4og9pVOWzZSKHi1UOto9M5T25BzvwRMJfIR5OnQqYh8h8BaM/X0YDcxw1vGNZQTkfDVBPlPyqoDODSRWRiHOWCe53DYBIyNYBpy2vpHEA50aKP9ZQEPAAbugZcEUgN2m2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482972; c=relaxed/simple;
	bh=3F20nmFNgpGQEicZnjeNg7OW2+wADQQV7oUSG5mLwNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q48KyrBj2qoqESX/bq5AxQYXCfz86MlI2ie5AimmoID2t1WDUriEgPGIohdFzOUtYjfDZrNFKK4kw82T+WBwAFxVjwA1xTbKO/SDBdM1tzxg3okZMtGVCnZs/4XGZgW61pnikdvgVKXRry3EsdvjCI6hlzMyINdth3GUTQwwCJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW/O5OHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E572AC433F1;
	Wed, 21 Feb 2024 02:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708482972;
	bh=3F20nmFNgpGQEicZnjeNg7OW2+wADQQV7oUSG5mLwNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pW/O5OHO9QPIqL15CzogaWfV1cfvM0J0bsmawjonTYM+0yjg90zlXNcBoOeicA575
	 KeoDqiyE3N7cg2d8yt8hJbbmo0lgsNE+fJ47QgQJSuPEYRYf9/YpHZfmhYhyI8GjKN
	 HzOKjbNCZfUx1OtO2Dj/cgAGLgQpfQvyU8xhgvNA3p7TQyF87m0SrkawTZ66mULxve
	 ZvxBjTHk6xNuCzNT01XmlLlO1fTkJUg8MlYIlrW5xje8H8XWNpwOSVlyCE/P8KorA2
	 59v/+gxMrM8Kb6Gf0kpCbKKhax/YnhGhTUdMejaCaG0Hot86O2wwlklstu3Eomr3E5
	 LG93YSajtzujw==
Date: Tue, 20 Feb 2024 18:36:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org
Subject: Re: [patch net] devlink: fix port dump cmd type
Message-ID: <20240220183610.5d00de89@kernel.org>
In-Reply-To: <20240220075245.75416-1-jiri@resnulli.us>
References: <20240220075245.75416-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 08:52:45 +0100 Jiri Pirko wrote:
> Unlike other commands, due to a c&p error, port dump fills-up cmd with
> wrong value, different from port-get request cmd, port-get doit reply
> and port notification.
> 
> Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.
> 
> Skimmed through devlink userspace implementations, none of them cares
> about this cmd value. Only ynl, for which, this is actually a fix, as it
> expects doit and dumpit ops rsp_value to be the same.
> 
> Omit the fixes tag, even thought this is fix, better to target this for
> next release.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

