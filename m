Return-Path: <netdev+bounces-177133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905DEA6E030
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17D03AB230
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C87263F20;
	Mon, 24 Mar 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxh3QdHT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CEC263C91
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835054; cv=none; b=UZn1aFxZoCdPWMbauX+WRDakr2Qo8RePjzK+9j81jFIk/KSYvtCLqIa5jkGXZwFnKp1PZLdwTDpvY+HD4iHgPTd2he2ihyZEBKC0u30BlepCqoas1FMI7oIBfksbWXQcsLLOAPKAeawI2zlWyiuWkFoFDoODsn7Mibigsrzf6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835054; c=relaxed/simple;
	bh=HabEANQWI7CUOsbqrsvgFJXj9BRdlzz/K5yIdcHjB7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVz9u+OcVm+v1rvasr6URTVRK4cLLV9f5w9NI0mG/flnod1uX52wquQ6Bk71Prlo7ov66YSrRRCriZ5ZO0QigisTzCgUotWepocu/a4aawvzGMQQi3pqDXYvgoIKGtbx9P4EPG2Ckfyykk9kNQKr6lVuBweIzXd2fwnukkAMbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxh3QdHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92859C4CEDD;
	Mon, 24 Mar 2025 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835053;
	bh=HabEANQWI7CUOsbqrsvgFJXj9BRdlzz/K5yIdcHjB7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hxh3QdHT5lGrfegiiY3gO68vnWne8KMHe6ib8RswohJzCcL1xbIT8W3oBRdaQlKci
	 aRxuyVj+M5k+C3uSgPyhjBWtA+5Wt2qM62GatxXL91HxexuDN/oaytlXu8ddrKKtx/
	 n0rPETwF0AClLxL8azSFpOrbLPpZkAskq6f5bFzdCFA7aJpewB00SV/D1diuV4waU+
	 QXxi+pkmB/zR2PSjm2MrLhAdV2iJkS/CJOmPOTElWRjK31KGQTigfbsWyIstguz3JE
	 KozBWBQl2bRSLrkIi2KKD7K8SJRXR5S1FCKq9mfCMLAXGuo/73I2z2WCfIcNYNSTHa
	 5E1MBw6mbrS3g==
Date: Mon, 24 Mar 2025 16:50:49 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	osk@google.com, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net 1/2] bnxt_en: Mask the bd_cnt field in the TX BD
 properly
Message-ID: <20250324165049.GG892515@horms.kernel.org>
References: <20250321211639.3812992-1-michael.chan@broadcom.com>
 <20250321211639.3812992-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321211639.3812992-2-michael.chan@broadcom.com>

On Fri, Mar 21, 2025 at 02:16:38PM -0700, Michael Chan wrote:
> The bd_cnt field in the TX BD specifies the total number of BDs for
> the TX packet.  The bd_cnt field has 5 bits and the maximum number
> supported is 32 with the value 0.
> 
> CONFIG_MAX_SKB_FRAGS can be modified and the total number of SKB
> fragments can approach or exceed the maximum supported by the chip.
> Add a macro to properly mask the bd_cnt field so that the value 32
> will be properly masked and set to 0 in the bd_cnd field.
> 
> Without this patch, the out-of-range bd_cnt value will corrupt the
> TX BD and may cause TX timeout.
> 
> The next patch will check for values exceeding 32.
> 
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


