Return-Path: <netdev+bounces-177409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC5A701C2
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86965844F23
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0FB259C8E;
	Tue, 25 Mar 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZoqQEMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFA18BC3B
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907007; cv=none; b=EIP2+Wuw2fgj247gEDkyU7NHctcvL0EQYvpL9feY3QeUkeCIZJeAzr6kXO+ujrlnLAPJqgYLIUSVcrK/H4+t8yj1dOfmzeOdLG1905jxK2nylNvH2qMNQNDZ95x3ug9UFruthISCHSCfvINoHnvfFnQqAGPLk0jvjbOC0ciXzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907007; c=relaxed/simple;
	bh=t0/TRlZ7VWPTLrZ6ReomPcwjdl+e0kY2R3yTWe3O5cw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UD6VCxbAp53WSd32qpbk35GRbjc/S0sC2xJ18tRBQ06Jb5vNUHMtp0srv7mpeDn7Yljv9y3K7x2CCYvFakJJ0Q3Bp4Ulkne1yJqrJZpUTBV6UktoDg3EHyI2SXSY+tyQNBLmYZS2LLaUYj2Qqk6P66EmsRCMljuxwijEZM510dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZoqQEMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EADC4CEE4;
	Tue, 25 Mar 2025 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907005;
	bh=t0/TRlZ7VWPTLrZ6ReomPcwjdl+e0kY2R3yTWe3O5cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nZoqQEMecfuCcti2gTDCZ63vPx75hGqQ+HwBmJKFoBAdS589LNYfWgEP52dgt5PUK
	 U9aZ1lV/tsa/zsxBNjP5XcOTbompAec22JtSqOmuA24wTFVUtAHm7aKQjSvCi+fmtZ
	 qSSV41nJJRVhurBpRhNlVxJ6ghi7/fQKkMpXeM/fIJGbzC8vBfIv6wIdyOjZcFDr1R
	 L0dcqxunYPclUdwHuQBsUFWFQsQsoKcKuU06WPzPMMtjSlt4HriPBvPhEW8INsAy0A
	 PLCMjK8wGOmbqrpgypG8QWzkgGU4SpLv7k7Lb9K8sysxUfLSiQLlkLY6oShctoySkc
	 0qUrimInmIIvQ==
Date: Tue, 25 Mar 2025 05:49:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Milena Olech
 <milena.olech@intel.com>, przemyslaw.kitszel@intel.com,
 karol.kolacinski@intel.com, richardcochran@gmail.com, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>, Mina
 Almasry <almasrymina@google.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next 04/10] idpf: negotiate PTP capabilities and get
 PTP clock
Message-ID: <20250325054956.3f62eef8@kernel.org>
In-Reply-To: <20250318161327.2532891-5-anthony.l.nguyen@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
	<20250318161327.2532891-5-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 09:13:19 -0700 Tony Nguyen wrote:
> +/**
> + * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
> + * @adapter: Driver specific private structure
> + * @sts: Optional parameter for holding a pair of system timestamps from
> + *	 the system clock. Will be ignored when NULL is given.
> + *
> + * Return: the device clock time on success, -errno otherwise.

I don't see no -errno in this function.
The whole kdoc looks like complete boilerplate, but I guess 
it's required of your internal coding style :(

> + */
> +static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter,
> +					    struct ptp_system_timestamp *sts)
> +{
> +	struct idpf_ptp *ptp = adapter->ptp;
> +	u32 hi, lo;
> +
> +	/* Read the system timestamp pre PHC read */
> +	ptp_read_system_prets(sts);
> +
> +	idpf_ptp_enable_shtime(adapter);
> +	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
> +
> +	/* Read the system timestamp post PHC read */
> +	ptp_read_system_postts(sts);
> +
> +	hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);

So hi is latched when lo is read? Or the timer may wrap between 
the reads? Can reads happen in parallel (re-latching hi)?

> +	return ((u64)hi << 32) | lo;
> +}

> +#if IS_ENABLED(CONFIG_X86)
> +	system->cycles = ns_time_sys;
> +	system->cs_id = CSID_X86_ART;
> +#endif /* CONFIG_X86 */
> +
> +	return 0;

Please split the cross-stamping into separate patches.

