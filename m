Return-Path: <netdev+bounces-210307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AFEB12BDD
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B287AD642
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90116241103;
	Sat, 26 Jul 2025 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBcPl5h+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB201FECB1
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555065; cv=none; b=ZlBnX2XvBSEcN2RgQi8zjdh6tvOOWLpvgjupr3Pu9/AcnceXsszuF02cn66jq43bRheQHlmb3GVy2Jz2WG/IfNtykXqw0Ja8cQC3eXhYsG3GWiIgKDfXBV5LXm4yDhddTxBV7YK1NaiuOawbMRSUMtLC7gnZ+0HCv4JbbxTgb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555065; c=relaxed/simple;
	bh=dFR2IghOZNT9oMB/oIolwar6aF1ojFW7GUupKk/zzWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqXOxqkG5zK92SzjznTJiBoRpbi0DXN62Ccq1kOfC6qLH+X6GTPCYJe8KE7R6tQyZGHevUnRdBcMROX6HoXu0UW6iPN2kVQB5/+/EceJYLTC/wlFWbs+RFrnMDuYgFal6PEqk/HT5JXUcJpt8NmXJjQRhIOEzeKrqKtd0bKbFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBcPl5h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E0C4CEED;
	Sat, 26 Jul 2025 18:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753555065;
	bh=dFR2IghOZNT9oMB/oIolwar6aF1ojFW7GUupKk/zzWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RBcPl5h+V1fK5eYwaVz3jZUQLJMY20CCf7JcY157nMQv3aBRwfOywi3XCVAJh2kzt
	 b58/UzMEc51+tfpW6pP04UcJOn9Lf0nLilrKnDho8JLdWunygX8vce7mRmlrqKhDSD
	 PWNrQQMzAPRH6vud3vrRgcOpsdr9f9J/AKtft+dVhOVZxOfSleZMJWztkw9qHMq+vM
	 MW2jVT8aleu4Cdi0qXnpvv0e0v6JK+h9NlBCbeW3pYlt99zwv3u1XIEDRrrlHbWuoW
	 tMBp8XnfCVSBQaEzt25Yg7fI9Q6F78HRqqmMLTeZTRw7qPzqBG5u5eau3r97EcqXtR
	 sr9r1a8OHxrBg==
Date: Sat, 26 Jul 2025 11:37:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, <netdev@vger.kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 <takamitz@amazon.com>,
 <syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2 net] net/sched: taprio: enforce minimum value for
 picos_per_byte
Message-ID: <20250726113743.0e9aad80@kernel.org>
In-Reply-To: <20250726010815.20198-1-takamitz@amazon.co.jp>
References: <20250726010815.20198-1-takamitz@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Jul 2025 10:08:15 +0900 Takamitsu Iwai wrote:
>  #define TAPRIO_FLAGS_INVALID U32_MAX
> +/* Minimum value for picos_per_byte to ensure non-zero duration
> + * for minimum-sized Ethernet frames (ETH_ZLEN = 60).
> + * 60 * 17 > PSEC_PER_NSEC (1000)
> + */
> +#define TAPRIO_PICOS_PER_BYTE_MIN 17
> +

unnecessary new line

>  struct sched_entry {
>  	/* Durations between this GCL entry and the GCL entry where the
> @@ -1300,6 +1306,11 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
>  
>  skip:
>  	picos_per_byte = (USEC_PER_SEC * 8) / speed;
> +	if (picos_per_byte < TAPRIO_PICOS_PER_BYTE_MIN) {
> +		pr_warn("Link speed %d is too high. Schedule may be inaccurate.\n",
> +			speed);
> +		picos_per_byte = TAPRIO_PICOS_PER_BYTE_MIN;

for the path coming in from taprio_change() you should use the extack
to report the warning (if return value is 0 but extack was set CLIs
will print that message as a warning directly to the user)
-- 
pw-bot: cr

