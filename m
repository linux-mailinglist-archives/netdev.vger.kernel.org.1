Return-Path: <netdev+bounces-124710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586796A7F3
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CFC1C23E6B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E349926ACC;
	Tue,  3 Sep 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSTbpfxw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3451DC73F;
	Tue,  3 Sep 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393684; cv=none; b=tgYc10S2YXLt4E0LJwJEDwhJLss+0dDdhVhYv9eOVRzWN5hDSEps7M8rXuuU4o5ZYs6GTJ4YRiIGSf/NX63XhtS7jmxTv3z8Gxmc9XTNXmhlnA0F6K3QbqRx4h78Hrywbo0dyi8lrQ/KFiZGYbCltnyGx2cTcU3M7UKozl9avY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393684; c=relaxed/simple;
	bh=8XsLINzNSNLzMorCtVi8NF1DbzSsl9OmwppWRjRJkLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0B5sEG2ZBgQXLwHgFFtDu/Vd6TfrILscNIj7khmW/ID9IYNE6GFcLGh1CiWQVPqdrmuF+aUlIlWsaoSCmvlJNuilDrHTyL4jOyMJtoYDzxcHAa6juZeyIerCMrr/Nepaw0Hu1NWCbFUNkufheCwBl8ssjJDKjTv9t9wQ+i1+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSTbpfxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CA5C4CEC4;
	Tue,  3 Sep 2024 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725393683;
	bh=8XsLINzNSNLzMorCtVi8NF1DbzSsl9OmwppWRjRJkLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oSTbpfxwCzILq3Jp+hW+cXj8CHN+lFwB5Uv6lHkch2BcvrQPHWxPa48ARrLu0XInJ
	 oCBi39HOZBgCjyT51htyvSNz3n/T6QEsB5seFbNjFL0LuSTxroq3lT+4yq8NmeJE+v
	 Y9cWzwND+0oY0zwrUtWCgQYBjzd1NAtrTsgMYUWVoxJ8Nbg+j4XvoGYc7lNF5Zyp1b
	 nLtJjpPgGugMSHhnTfdgIZQyxxbGN9S0C/fUUTEiFOxEazzXQ7a/Fuve8rNPVDl4oz
	 vsEENemsgCcN0rffx4XfVTmu56hlTNK21zOfcQGwxI5JF3WraYffUoQXc0uWBYDfk6
	 tCqtY5ESMjykA==
Date: Tue, 3 Sep 2024 13:01:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, jacob.e.keller@intel.com,
 liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Message-ID: <20240903130121.5c010161@kernel.org>
In-Reply-To: <m2mskq2xke.fsf@gmail.com>
References: <20240830201321.292593-1-arkadiusz.kubalewski@intel.com>
	<m2mskq2xke.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Sep 2024 10:51:13 +0100 Donald Hunter wrote:
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

Any preference on passing self.rsp_by_value, vs .decode() accessing
ynl.rsp_by_value on its own? 

