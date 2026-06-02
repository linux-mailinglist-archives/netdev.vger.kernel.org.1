Return-Path: <netdev+bounces-293952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIqCF3s6HmpriAkAu9opvQ
	(envelope-from <netdev+bounces-293952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E61B6270E3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 977EA300A329
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439133B6CC;
	Tue,  2 Jun 2026 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab6aXmc3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F329BD9A;
	Tue,  2 Jun 2026 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365945; cv=none; b=MswBAcQevQXob1d+U3qMLkqwXlviL3YPEFnjz79+oW2vS9rm7c7URSBaEcp2SmfdTeQdA6qHLFMNf63F8XDTbi8gqz+fHNe/+5KSqfwkRtPoOnVJkndlyQ1tAe70Q0qNj/lYzfhuPKiIExwnr7cCkm5JTXvfSwzXCHk3546gPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365945; c=relaxed/simple;
	bh=w7M5+j6fJiAOKd5dxDioY+7cIY443e18YGMg4MDNaM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vg21Bj/f9/vFNiyxVlqhUCD5gIuac1IA/jaKgoyFvvBc6Ar2ydf2lYNvtXA1OG54VN9cdvNEP4Dej/OfnVv9cqAnHPAEhwfqahzXkYV/DPrux32jX87fsnLbfzlFDnn7/yytji0fx+OgjqEXPl28dbDHTYNA2fb2FFEh3d0/4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab6aXmc3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069701F00893;
	Tue,  2 Jun 2026 02:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365944;
	bh=4AjsROMV02U/yvIBd08KPpw+N48FHKFpRq2b7ZoH1hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ab6aXmc3kNpZ/JPb6d5/ueMOt9kxuRgk3W+cQ57XapKwR9VpZGQ8fIMwo15CWgZzd
	 KgSS/zKPVvgQukE4LjLg88xEwxVXvWDi0aHRfFLAw12IaJrp9FuBNo6HD6X2h5LAaN
	 qnfM32TbkiwbrIEPorNazHW4EtURDbtfVw7SRKl+StYeMutrOjLMQMGv8e0cSzU38d
	 410TD/5eFuaU2Re8kp7WZzsUz+2UPLSloOOoZErPRdt8g2iq3lJR45xTLKZOEcMbaV
	 ae/lwZdmfuN0XaP3EaKWX2UiPl7bBh0wCnsth258v/Xn5OV0rGiabdQc53kPoVfo/q
	 ayzBTG7rUG2sw==
Date: Mon, 1 Jun 2026 19:05:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, Yuxiang Yang
 <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, Xuewei Feng
 <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu
 <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH net] vlan: prevent unsigned underflow in VLAN MTU
 calculation over MACsec
Message-ID: <20260601190543.33d42ef8@kernel.org>
In-Reply-To: <20260529062135.70490-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260529062135.70490-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	TAGGED_FROM(0.00)[bounces-293952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E61B6270E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 14:21:33 +0800 Yizhou Zhao wrote:
> +	if (netif_reduces_vlan_mtu(real_dev)) {
> +		if (real_dev->mtu < VLAN_HLEN)
> +			return -EINVAL;
> +		max_mtu = real_dev->mtu - VLAN_HLEN;
> +	} else {
> +		max_mtu = real_dev->mtu;
> +	}

Does not apply, please rebase on net and repost.
-- 
pw-bot: cr

