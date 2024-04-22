Return-Path: <netdev+bounces-89990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A08AC75D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71078282E90
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E75051C36;
	Mon, 22 Apr 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdH6kATk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29550A72;
	Mon, 22 Apr 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775624; cv=none; b=bPbYMkzU5Ly9lw55tSG434gKYfI9lSrHoRmneiv51P20CpGFAISXeKV2zyIkUdI5uGpa29heAg8AT6sKHEl3Fo4uMFmBBcXHBRujIGALFeyGDIpw9ncBsNQ8TN7IdTNAm9kOER7jkJj8GqLwnRK68u7Xq2daSmhb+LkvTbRBVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775624; c=relaxed/simple;
	bh=BPjsR/H4bAhpP8TjaRt6U4VR0hx9e8E2U+ccLfYrPTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaVjwErBNLpn254czA9fCHfJJdlJc9u8N8gNF2NQcwQEIYyzBqOhSQzBaMDJYJdrxTXYOY7ERmqE1PaGPyGjG9SVIKFxek8T5f+JDj/0IKrGezSW9/Vm24VdJk9dCaPat6CH/FMUY9I45A9MUGjn7MQ9DtmnwC/urGxqABHc6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdH6kATk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417B7C32782;
	Mon, 22 Apr 2024 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713775623;
	bh=BPjsR/H4bAhpP8TjaRt6U4VR0hx9e8E2U+ccLfYrPTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mdH6kATkYUmRLnW9kpZE73BhvAEaN1JH5KCWUcvVkSPjujoo1Ei1Ip+a5HPUaPj7s
	 AaJGAPVVqkl9TNeCOgtmmBB92JvYjWV8f8AqG/sSFaXoJU1u1cGr8/xiIisUcRMr8f
	 c4QegdrhrNS1jys1kk0GYpFlRZ1dEGkGf15s7vabwn0M86wu7ZzykQaK37uDPASZ/s
	 02XSMZWP2W5Yif3e6LWwe3QQN+BzPohN7gcj8JhOyjzFFiNx/CcQAErXQG97lnzIsB
	 yH6uR0hciUEEI+qFIKkn/WF4O5ST/BaEAXW+z0SXeSLv/b3II6piUSy9dxlpU1bYjl
	 qTBo+pewtDB6g==
Message-ID: <4f492445-1fe3-44af-bbaa-bb1fe281964e@kernel.org>
Date: Mon, 22 Apr 2024 10:46:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v7 1/7] net: introduce rstreason to detect why
 the RST is sent
Content-Language: en-GB
To: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com,
 dsahern@kernel.org, martineau@kernel.org, geliang@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 atenart@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240422030109.12891-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 22/04/2024 05:01, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add a new standalone file for the easy future extension to support
> both active reset and passive reset in the TCP/DCCP/MPTCP protocols.

Thank you for looking at that!

(...)

> diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> new file mode 100644
> index 000000000000..c57bc5413c17
> --- /dev/null
> +++ b/include/net/rstreason.h
> @@ -0,0 +1,144 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef _LINUX_RSTREASON_H
> +#define _LINUX_RSTREASON_H
> +#include <net/dropreason-core.h>
> +#include <uapi/linux/mptcp.h>
> +
> +#define DEFINE_RST_REASON(FN, FNe)	\
> +	FN(MPTCP_RST_EUNSPEC)		\
> +	FN(MPTCP_RST_EMPTCP)		\
> +	FN(MPTCP_RST_ERESOURCE)		\
> +	FN(MPTCP_RST_EPROHIBIT)		\
> +	FN(MPTCP_RST_EWQ2BIG)		\
> +	FN(MPTCP_RST_EBADPERF)		\
> +	FN(MPTCP_RST_EMIDDLEBOX)	\

Small detail: should it not make more sense to put the ones linked to
MPTCP at the end? I mean I guess MPTCP should be treated in second
priority: CONFIG_MPTCP could not be set, and the ones linked to TCP
should be more frequent, etc.

> +	FN(NOT_SPECIFIED)		\
> +	FN(NO_SOCKET)			\
> +	FNe(MAX)

(...)

> +/* Convert reset reasons in MPTCP to our own enum type */
> +static inline enum sk_rst_reason convert_mptcpreason(u32 reason)
> +{
> +	switch (reason) {
> +	case MPTCP_RST_EUNSPEC:
> +		return SK_RST_REASON_MPTCP_RST_EUNSPEC;
> +	case MPTCP_RST_EMPTCP:
> +		return SK_RST_REASON_MPTCP_RST_EMPTCP;
> +	case MPTCP_RST_ERESOURCE:
> +		return SK_RST_REASON_MPTCP_RST_ERESOURCE;
> +	case MPTCP_RST_EPROHIBIT:
> +		return SK_RST_REASON_MPTCP_RST_EPROHIBIT;
> +	case MPTCP_RST_EWQ2BIG:
> +		return SK_RST_REASON_MPTCP_RST_EWQ2BIG;
> +	case MPTCP_RST_EBADPERF:
> +		return SK_RST_REASON_MPTCP_RST_EBADPERF;
> +	case MPTCP_RST_EMIDDLEBOX:
> +		return SK_RST_REASON_MPTCP_RST_EMIDDLEBOX;
> +	default:
> +		/**
> +		 * It should not happen, or else errors may occur
> +		 * in MPTCP layer
> +		 */
> +		return SK_RST_REASON_ERROR;
> +	}
> +}

If this helper is only used on MPTCP, maybe better to move it to
net/mptcp/protocol.h (and to patch 5/7?)? We tried to isolate MPTCP code.

Also, maybe it is just me, but I'm not a big fan of the helper name:
convert_mptcpreason() (same for the "drop" one). I think it should at
least mention its "origin" (rst reason): e.g. something like
(sk_)rst_reason_convert_mptcp or (sk_)rst_convert_mptcp_reason() (or
mptcp_to_rst_reason())?

And (sk_)rst_reason_convert_(skb_)drop() (or skb_drop_to_rst_reason())?

> +/* Convert reset reasons in MPTCP to our own enum type */

I don't think this part is linked to MPTCP, right?

> +static inline enum sk_rst_reason convert_dropreason(enum skb_drop_reason reason)
> +{
> +	switch (reason) {
> +	case SKB_DROP_REASON_NOT_SPECIFIED:
> +		return SK_RST_REASON_NOT_SPECIFIED;
> +	case SKB_DROP_REASON_NO_SOCKET:
> +		return SK_RST_REASON_NO_SOCKET;
> +	default:
> +		/* If we don't have our own corresponding reason */
> +		return SK_RST_REASON_NOT_SPECIFIED;
> +	}
> +}

(This helper could be introduced in patch 4/7 because it is not used
before, but I'm fine either ways.)

> +#endif

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


