Return-Path: <netdev+bounces-188531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C6AAD374
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB29A7B50AA
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526B19E96D;
	Wed,  7 May 2025 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtDI7ySu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA119CD17
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585756; cv=none; b=WZCeQYOUvUVCUXUUMnFdm/QuuRTI0otju2VnMsJFhy81D4cTsj8IihTh+MGxKFn6lkBo4VzZFJKF8bK9V7sSeUUR9Ows15kkKhTsXZIN2TK54XIDNpgdmg3rJlvsHaBs55HVVrWesPhtuSxY7mMTfxbhOSc1bIWzPXHQcns9VMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585756; c=relaxed/simple;
	bh=lAq9yIKhRHBS6ucsXSBzhwMxirvfuMJXM1IkDbFnBS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puZ4YEqzbSowF9ezxtiPs9YQNsWHRn50pcIbKAXAnOCtdWnKLf76WpVGQZayvyjaXswNRgHx/2aiw3ldvoNbLW7HaBQCuDU726Eml1588OHZ1l+e+uQhquLjTSJ2bKhm+dBdsDDAkejW/T5sRhpcViQDRcIrXu2BJ5g7GvAf9kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtDI7ySu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8991C4CEE4;
	Wed,  7 May 2025 02:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746585755;
	bh=lAq9yIKhRHBS6ucsXSBzhwMxirvfuMJXM1IkDbFnBS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rtDI7ySuy7BEsyjfe0WMJAGbW6PsLNOdAh6oTqjIwVGfzqszZzUK4mXhAz3BUrFW6
	 2fdX9NhExSzlGUWGezx+Yfo1eKnc/JJu08E+6r/dng/wgXsn+vQQ5CHMhxoOY2FkRQ
	 wgk38yXI1PLJF+tLG3C+fzgZuflYVPBiWpmn3J+bTGWaH+OWAMXpo6lfiZDjX+YoGS
	 daZGomfo2Aqf/TlrFSK3xqo0Z05Xi/6WHWrBj8P5SkSQfP6Ivq/KnE0rX1LKT+B8Hr
	 2UPwB8hVLWNUBN5vSy7gp7JeUZeADg9p1oRa/01OAa0ASh/Qlf9a5TlfbNt/8dJghX
	 PseelF8S7PBjA==
Date: Tue, 6 May 2025 19:42:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 almasrymina@google.com, sdf@fomichev.me, netdev@vger.kernel.org,
 asml.silence@gmail.com, dw@davidwei.uk, skhawaja@google.com,
 willemb@google.com, jdamato@fastly.com
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250506194233.281fa76d@kernel.org>
In-Reply-To: <aBpJ4GDED8cu4dKh@mini-arch>
References: <20250506140858.2660441-1-ap420073@gmail.com>
	<aBpJ4GDED8cu4dKh@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 10:41:52 -0700 Stanislav Fomichev wrote:
> > +		mutex_unlock(&priv->lock);
> >  		netdev_unlock(dev);
> > +		netdev_put(dev, &dev_tracker);
> > +		mutex_lock(&priv->lock);  
> 
> nit: this feels like it deserves a comment on the lock ordering (and,
> hence, why this dance is needed). The rest looks good!

Agreed, and maybe document the ordering and what is protected 
in struct netdev_nl_sock ?

