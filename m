Return-Path: <netdev+bounces-204593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80762AFB57D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B8D3AA6FE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3362BD59F;
	Mon,  7 Jul 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpYX9aG6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392FD2BD598
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896762; cv=none; b=CLfDFdXpIx/jccAG5dM/wnZunXeQpWC4taYDvw7TRvah2+SHkJiQfmBrjghaXizxp7Yse+952d6IQijCy+/M9EDYzjJrbydQG99CvrY8Xh6eQTseGN582iEaeAHVZzNRY1dRNSa/f4XkQ/hw3ZmZhLJ6M93Lfrjv5slK6Xq9Xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896762; c=relaxed/simple;
	bh=v3CXB3UOYbYD4y+gxhlZ92Fq6SD9d/dD1YyGjfSqQIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmKoA2gcjqNlmA7IIbLFBvo4xC4kewpwysrjCkQrR63YTSPmEIg6uLndbVxbDo2ogDyq1/+clUoMIufG46Nj6FhMVoOp0p25eV/Cexe0Zc7caMyPR+agOBjLkBxaD8Qc874uqliqgsz88V6Oc1t9GcuSRRMhZRqnYA2/s5W+P7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpYX9aG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62088C4CEE3;
	Mon,  7 Jul 2025 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751896761;
	bh=v3CXB3UOYbYD4y+gxhlZ92Fq6SD9d/dD1YyGjfSqQIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tpYX9aG6a6tGQgWgfPsBZcsuYk9kzIV5Jv3D+ffsRWgDB2uXm1R+KkZZHifHeCkgf
	 e671BlPW7lVzKHRMg9z6MMpd8sU61nJgowdsZ2QN8h9kfmeU77WsVJXWPd4ZL6MM8k
	 M/TLhyZsBcLhld74b2p1273MsIbIEHKEISW8GG/GSxqs2aq8GZP7fPZ0h+i2MV2B/f
	 rArgAU16Iz/Z9lDaVg4eHItbd5wK4TobrdY5F3t5su7mgWax7zEd9ar/CRuU2XNt3G
	 20ZcuRrHNis6JrFlgJSDEY4UzawCqGr6BRXGxtqmnTVuWGxcRquGa41wHLNGbnQCyf
	 4JXmvsF0CBUYg==
Date: Mon, 7 Jul 2025 06:59:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, pctammela@mojatatu.com,
 syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com,
 syzbot+5eccb463fa89309d8bdc@syzkaller.appspotmail.com,
 syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com,
 syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com,
 syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net/sched: Abort __tc_modify_qdisc if parent class
 does not exist
Message-ID: <20250707065919.73364a06@kernel.org>
In-Reply-To: <20250704163422.160424-1-victor@mojatatu.com>
References: <20250704163422.160424-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Jul 2025 13:34:22 -0300 Victor Nogueira wrote:
> -		if (!q) {
> -			NL_SET_ERR_MSG(extack, "Cannot find specified qdisc on specified device");
> -			return -ENOENT;
> +		if (IS_ERR_OR_NULL(q)) {
> +			if (!q) {
> +				NL_SET_ERR_MSG(extack,
> +					       "Cannot find specified qdisc on specified device");
> +				return -ENOENT;
> +			}
> +			return PTR_ERR(q);
>  		}

nit: could you leave the existing handling as is?

	if (!q) {
		NL_SET_ERR_MSG(extack, "Cannot find specified qdisc on specified device");
		return -ENOENT;
	}
	if (IS_ERR(q))
		return PTR_ERR(q);

the double conditions increase indentation and confuse static analyzers
-- 
pw-bot: cr

