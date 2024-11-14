Return-Path: <netdev+bounces-144651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CD09C80CE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21181B250B9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3454133986;
	Thu, 14 Nov 2024 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s82XxPzH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491E6AAD;
	Thu, 14 Nov 2024 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551552; cv=none; b=UB633rksODBkKxsdUpS5x5KXpjVs2iYokc8x0kkhAJDgdHJbemoahKeOnNRry+W+/UbaBYdzenTQGcgeHAntpeCzDfjy8BT9M26PsS3RWiUyspldk5Lyoa6cBrBO/2WCRdj/L7kIHu5zYUElWWcT8NIw/TqMHv0FPNYjc7rUYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551552; c=relaxed/simple;
	bh=4Rku6bOBc/6Yr7D06nrlI7xsDc5AOTONG9jeSHQxHgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtLOdMjL82gqDX7ywyBqDLuYElZhhrATsHYO0WnSykoia9T8QrDJfK0m+ygru7p2AurQONSTS2UZm9DCARgQUQe408JYLgmTA5/KpbVDMDxreopLb5ZfEyLA/BSWNLvtQFaUceXqAo1Ic9snc5ixwh5uD8bNZFQjZQJAtE7nxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s82XxPzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0206FC4CEC3;
	Thu, 14 Nov 2024 02:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731551551;
	bh=4Rku6bOBc/6Yr7D06nrlI7xsDc5AOTONG9jeSHQxHgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s82XxPzH/lhOiB+zeBvUzVGt0JrO+4HflzIyBdMeg9owlWiMO6KGreANrU9V+dXLl
	 8Js3m55lzrE9cVUlA47v2TXA6btimKMXgvinRD5E+xP9vJTbn023cwj5LVINgqFazW
	 Gjos1h0iAKRS59AoEgJlc+dgw1vX7bChgKH3Y6PU3Euh9zrIaiv+SWJ5f+9Yahpe6+
	 +uyD8tLufrmSSUeHO94SllzYK52mj0wKN07EQlx7RyVRa/HLJ+kwnV1ihgJBEFJfil
	 fjjOIsAijPlvFzeDXzH2pMUH6y/ia5p0DNDe+BUUw2/To7wmpeC1x6YS46f17yePBI
	 OIB+6IOUlOYnQ==
Date: Wed, 13 Nov 2024 18:32:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, horms@kernel.org, donald.hunter@gmail.com,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 3/7] ynl: support directional specs in
 ynl-gen-c.py
Message-ID: <20241113183230.4d908a54@kernel.org>
In-Reply-To: <ZzU6ET2KV-D9Av0a@mini-arch>
References: <20241113181023.2030098-1-sdf@fomichev.me>
	<20241113181023.2030098-4-sdf@fomichev.me>
	<20241113121256.506c6100@kernel.org>
	<ZzU6ET2KV-D9Av0a@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 15:45:21 -0800 Stanislav Fomichev wrote:
> On 11/13, Jakub Kicinski wrote:
> > On Wed, 13 Nov 2024 10:10:19 -0800 Stanislav Fomichev wrote:  
> > > -    supported_models = ['unified']
> > > -    if args.mode in ['user', 'kernel']:
> > > -        supported_models += ['directional']
> > > -    if parsed.msg_id_model not in supported_models:
> > > -        print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
> > > -        os.sys.exit(1)  
> > 
> > Don't we still need to validate that it's one of the two options?  
> 
> I removed it because I'm assuming only two modes exist (and we support
> them both now). Are you suggesting it's better to future-proof it and
> still keep the check in case we add some new modes in the future? (or
> running against some rogue specs?)

TBH I don't remember how much precedent there is for C codegen
depending on jsonschema for spec input validation. My gut tells
me to do:

+    if family.msg_id_model == 'unified':
+        render_uapi_unified(family, cw, max_by_define, separate_ntf)
+    elif family.msg_id_model == 'directional':
+        render_uapi_directional(family, cw, max_by_define)
+    else:
+        raise ..

and then we can indeed drop the validation of the arg directly

