Return-Path: <netdev+bounces-58687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A413E817D35
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 23:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C589A1C2270C
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87DE74E0B;
	Mon, 18 Dec 2023 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYFRBDSP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35E740B0
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 22:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11DEC433C8;
	Mon, 18 Dec 2023 22:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702938191;
	bh=dFORGb2GH8QzXTTzKCVsN+Go4q1A6BLbCtyPzcMidzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HYFRBDSPOK1hRqfhGwPbe3dgNXON7sGRe7JN1nBu6DMHXLI10kqZVJ8v0ZYEMuIfP
	 kTozScKRv7jEbAinsCPYfA8N0LGxOvY54R0iys9olK+SLe9dYeZVfNqrC28IzKEE6F
	 0HHQRpU0ZKQagpq05hS5lVIsAG/867TDPhL4hbZfpIZYN6EUUnAbuzWc81xHfyv+Qk
	 X3DuFlTnOxCEnSGQqpE5QV5FF/T100gaQv5MupY7vL0hGlwae9c2FVw3Svyjmqied9
	 jzU7aH6JH1oUIdSruRkUDHm49hbnwAEuhTOvMPZufxNxlQdkhae/gORJ9W7T/g5l0N
	 js/s5qDgqju2g==
Date: Mon, 18 Dec 2023 14:23:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] tools: ynl-gen: support using defines in
 checks
Message-ID: <20231218142310.1f10f8f4@kernel.org>
In-Reply-To: <ZX1jbgQ3lgQtkF02@Laptop-X1>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
	<20231215035009.498049-3-liuhangbin@gmail.com>
	<20231215180824.0d297124@kernel.org>
	<ZX1jbgQ3lgQtkF02@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 16:44:30 +0800 Hangbin Liu wrote:
> On Fri, Dec 15, 2023 at 06:08:24PM -0800, Jakub Kicinski wrote:
> > On Fri, 15 Dec 2023 11:50:08 +0800 Hangbin Liu wrote:  
> > > -    pattern: ^[0-9A-Za-z_]+( - 1)?$
> > > +    pattern: ^[0-9A-Za-z_-]+( - 1)?$  
> > 
> > Why the '-' ? Could you add an example of the define you're trying to
> > match to the commit message?  
> For team driver, there is a define like:
> 
> #define TEAM_STRING_MAX_LEN 32
> 
> So I'd like to define it in yaml like:
> 
> definitions:
>   -
>     name: string-max-len
>     type: const
>     value: 32
> 
> And use it in the attribute-sets like
> 
> attribute-sets:
>   -
>     name: attr-option
>     name-prefix: team-attr-option-
>     attributes:
>       -
>         name: unspec
>         type: unused
>         value: 0
>       -
>         name: name
>         type: string
>         checks:
>           len: string-max-len
> 
> With this patch it will be converted to
> 
> [TEAM_ATTR_OPTION_NAME] = { .type = NLA_STRING, .len = TEAM_STRING_MAX_LEN, }

Ah, I see. The spec match needs to work on names before they go thru
c_upper(). The patch makes sense:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

