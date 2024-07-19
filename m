Return-Path: <netdev+bounces-112167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A939373F2
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52563282154
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659E3F9EC;
	Fri, 19 Jul 2024 06:17:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300F2C859
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369820; cv=none; b=Yc3iWyv/whAW3poN1V+V1W44NvCGI4zyNYsDhjcStDMPU/0MooXcy2cc3MKk+KW2h8AN4OE6E64xqzEn9HNHjZdPr8DZlzgyKfbJc0WrWkK5uBR1HagjADcJL2ppC9QngMZsW0EcegmszlfprEIX3ds6UPBDYLIrR+x8uVCkN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369820; c=relaxed/simple;
	bh=Wrx5UQBYefDmCOLtOFNdFYlqVCgHE3hig0iSNBGjSzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxuFLuDQ47/cNqQCYsc1YvP2CoB0srv1hQ1xdjFtNbGUZO3YHtZw5/co4musr+UHFRgFyEeCzH+3fmNlmYTv4gcGRz6huEAECLHdRhry8U96bORkxpfzJkBVpSYJT6Wf9gnKTGMm/ctleoFmOe/hibyasQXBWRNMr9lysjrWddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sUgvH-0007iu-F4; Fri, 19 Jul 2024 08:16:55 +0200
Date: Fri, 19 Jul 2024 08:16:55 +0200
From: Florian Westphal <fw@strlen.de>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 08/17] xfrm: iptfs: add new
 iptfs xfrm mode impl
Message-ID: <20240719061655.GB29401@breakpoint.cc>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714202246.1573817-9-chopps@chopps.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Christian Hopps via Devel <devel@linux-ipsec.org> wrote:
> +static int iptfs_clone(struct xfrm_state *x, struct xfrm_state *orig)
> +{
> +	struct xfrm_iptfs_data *xtfs;
> +	int err;
> +
> +	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
> +	if (!xtfs)
> +		return -ENOMEM;
> +
> +	err = __iptfs_init_state(x, xtfs);
> +	if (err)
> +		return err;

Missing kfree on err?

> +	xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
> +	if (!xtfs)
> +		return -ENOMEM;
> +
> +	err = __iptfs_init_state(x, xtfs);
> +	if (err)
> +		return err;

Likewise.

