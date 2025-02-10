Return-Path: <netdev+bounces-164549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11116A2E2C2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 04:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502E47A2814
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 03:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5452E81741;
	Mon, 10 Feb 2025 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC9Ld4PY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131B6F06B;
	Mon, 10 Feb 2025 03:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158188; cv=none; b=rApYyumUKmFVRd2rf9357lUQQBl3ntvTJf/fWoBDms63nx2BJl3vW8AMmvjUNiVyZtZLLtCeounWV3iM9G6VdU/l6BWPV+qxet5MpDNhmjRgWWl9t3yRjkbXgiR9faaXrtQxbjaG9heUyzOksCk28RLSV8BQ6KeGGFZnatv07eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158188; c=relaxed/simple;
	bh=TiMs+0GrXPhBIQlJ+sK/2499r3p2U33LMuvdPUGAmFc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tsWoKQVxMJmUpH+0x9h+nVpsgisCWAd5pcSene5Rh5jVM3v2hQSVKb/lHmIx+FZNFo6eXRi+rXGSb8T3c1jEHZ7otiSDIR6/f4c561tJDGbS6Ua5nZ/CufT78PHtpwBCAPuQMcshFFcaRfxSW0knHXOxEj0M+uQwJezWvxlY6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC9Ld4PY; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c056bba58dso115070985a.0;
        Sun, 09 Feb 2025 19:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739158184; x=1739762984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4D5SKtJkUhMyuF1JqdYDwxuISgefMnQMQ1RNK2WMIw=;
        b=mC9Ld4PYlGMEIpw24lu0lA6sojFNp/vSweb9pUM+yeGUcpoO3tFuLSv8/5azG22Ptf
         9pI1Aya7dLjpjLC+DDmrubgQxMZDHxNjShjrHx4ypQm7f2xiB+3jZwuVSFc7bwJHQiwb
         /GOI4dwrB+ZKw6XdEz7oq4xxaIyVT+hL5Zd1hkP/Sfl1HIeJg0qLMozAzCGH1YikBz7S
         kr5OOvFt//5H6IbjraehlzWeVG2u6CzjWCexGTNzC3GXA6sXpcYzDUIK+FzstcNaAA81
         k5Mxp3cLxUfhEOPxZe3JBFbEavnaFCm5hpig2Bsml/UfGn0EjrcoghS3RZcOJsPOI2yW
         VRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739158184; x=1739762984;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s4D5SKtJkUhMyuF1JqdYDwxuISgefMnQMQ1RNK2WMIw=;
        b=RaiM1bN5IowIgf8GSGdwUsrP+f1Q+19mCfPOxOll3i35pTzh5rrLC/pHF5J5ttD/Bp
         PLPH/4J2FzZk8isPlUv8BNEa5J6GZMc7Hh+ToFapOm5Mc8Ebnq5uXC1d379HYJm1YRdn
         vG332SkRtAmX/HPCM8AbGdr4R73KeYDhgVfPjnsOoHfNswj3/L+uAQ5ShXvNaZ39vD9M
         qfAlLvJtZVCQ9zFZQ3seezeuWS2i2EaS6VwzYPeUDrhIE0BY7Fk17K7RUNDuGt5LAnQb
         koQCcz3c9C/Dom+yKrL6+VJAHuuKi5uqHptqLFSoA4xlIeCq+iBD/FDLvBDC9CdpnwBZ
         3boQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBmJOWHdUnk8BE1388/68fd2V0wrzr649YGmfW5Zfclkg1yD48/IikhNmDEoIobeEGXVKM4hMiVF8G4SYoIhg=@vger.kernel.org, AJvYcCXBoNlUrKgY/iGhU16NTaqdxJw/D13aDaph5ZGZ+Y9AIoN5aKrGAN/9KiEETCUDM9uVYXoSNWhF@vger.kernel.org
X-Gm-Message-State: AOJu0YwfnjIcGJw+NSVTFUxgtzhr1nfesMbfS/BP2XO2gYCNJOW3b5mj
	adNxA3zTZuQNPLMAvYzACXjMYbL8H8nQ8wGpif/Z771vimyrfAGq
X-Gm-Gg: ASbGncuct/0mDwVdEPo2sJHm7PWTDWUlfN7jfhMT5Gy6EDckc+tHkhre8Bc0d8oEB8u
	5WpicbztGjKv6+CPxng6YrQ4dwRjAxNnyhlkpKYxJnlEEECo1zbvhP+tBgYi87dX+3hRqvE42fX
	5KDXk5cvUSXiMIlmG7AKqy8dSKRrvXw6XoEY5lW0N6r7DL8KH9Us1OJi+0KGICzSOo4wJHhSLgP
	qKFuqoxwXCgL7uuYm8912ArmkCXTGd/w3dJHMEKJBUJ8NYnARszK+scYhYoMNibahDMkQvBALa4
	8nGvK49r+j+YrKz+K8BOkFFESuWl+yzT6yNA06pXewtgrnY/WE7uVWihvIGijUs=
X-Google-Smtp-Source: AGHT+IHCyj0ldJK2CFpEeHdNhyisVpPeHuY6R9c2tretRFYcMqDQD1GjE9j4WDmHNH/+jmnfnkvtTQ==
X-Received: by 2002:a05:620a:25d0:b0:7be:72e2:90a2 with SMTP id af79cd13be357-7c047ba4b07mr2052025385a.6.1739158184242;
        Sun, 09 Feb 2025 19:29:44 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e1388asm477780885a.61.2025.02.09.19.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 19:29:43 -0800 (PST)
Date: Sun, 09 Feb 2025 22:29:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, 
 linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <67a972a6e2704_14761294b0@willemb.c.googlers.com.notmuch>
In-Reply-To: <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
References: <cover.1739097311.git.pav@iki.fi>
 <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
Subject: Re: [PATCH v3 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pauli Virtanen wrote:
> Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timestamp
> when hardware reports a packet completed.
> 
> Completion tstamp is useful for Bluetooth, where hardware tx timestamps
> cannot be obtained except for ISO packets, and the hardware has a queue
> where packets may wait.  In this case the software SND timestamp only
> reflects the kernel-side part of the total latency (usually small) and
> queue length (usually 0 unless HW buffers congested), whereas the
> completion report time is more informative of the true latency.
> 
> It may also be useful in other cases where HW TX timestamps cannot be
> obtained and user wants to estimate an upper bound to when the TX
> probably happened.

Getting the completion timestamp may indeed be useful more broadly.

Alternatively, the HW timestamp is relatively imprecisely defined so
you could even just use that. Ideally, a hw timestamp conforms to IEEE
1588v2 PHY: first symbol on the wire IIRC. But in many cases this is
not the case. It is not feasible at line rate, or the timestamp is
only taken when the completion is written over PCI, which may be
subject to PCI backpressure and happen after transmission on the wire.
As a result, the worst case hw tstamp must already be assumed not much
earlier than a completion timestamp.

That said, +1 on adding explicit well defined measurement point
instead.


> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  Documentation/networking/timestamping.rst | 9 +++++++++
>  include/linux/skbuff.h                    | 6 +++++-
>  include/uapi/linux/errqueue.h             | 1 +
>  include/uapi/linux/net_tstamp.h           | 6 ++++--
>  net/ethtool/common.c                      | 1 +
>  net/socket.c                              | 3 +++
>  6 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 61ef9da10e28..de2afed7a516 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
>    cumulative acknowledgment. The mechanism ignores SACK and FACK.
>    This flag can be enabled via both socket options and control messages.
>  
> +SOF_TIMESTAMPING_TX_COMPLETION:
> +  Request tx timestamps on packet tx completion.  The completion
> +  timestamp is generated by the kernel when it receives packet a
> +  completion report from the hardware. Hardware may report multiple
> +  packets at once, and completion timestamps reflect the timing of the
> +  report and not actual tx time. The completion timestamps are
> +  currently implemented only for: Bluetooth L2CAP and ISO.  This
> +  flag can be enabled via both socket options and control messages.
> +

Either we should support this uniformly, or it should be possible to
query whether a driver supports this.

Unfortunately all completion callbacks are driver specific.

But drivers that support hwtstamps will call skb_tstamp_tx with
nonzero hwtstamps. We could use that also to compute and queue
a completion timestamp if requested. At least for existing NIC
drivers.

>  1.3.2 Timestamp Reporting
>  ^^^^^^^^^^^^^^^^^^^^^^^^^
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..3707c9075ae9 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -489,10 +489,14 @@ enum {
>  
>  	/* generate software time stamp when entering packet scheduling */
>  	SKBTX_SCHED_TSTAMP = 1 << 6,
> +
> +	/* generate software time stamp on packet tx completion */
> +	SKBTX_COMPLETION_TSTAMP = 1 << 7,
>  };
>  
>  #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
> -				 SKBTX_SCHED_TSTAMP)
> +				 SKBTX_SCHED_TSTAMP | \
> +				 SKBTX_COMPLETION_TSTAMP)

These fields are used in the skb_shared_info tx_flags field.
Which is a very scarce resource. This takes the last available bit.
That is my only possible concern: the opportunity cost.

>  #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
>  				 SKBTX_HW_TSTAMP_USE_CYCLES | \
>  				 SKBTX_ANY_SW_TSTAMP)
> diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueue.h
> index 3c70e8ac14b8..1ea47309d772 100644
> --- a/include/uapi/linux/errqueue.h
> +++ b/include/uapi/linux/errqueue.h
> @@ -73,6 +73,7 @@ enum {
>  	SCM_TSTAMP_SND,		/* driver passed skb to NIC, or HW */
>  	SCM_TSTAMP_SCHED,	/* data entered the packet scheduler */
>  	SCM_TSTAMP_ACK,		/* data acknowledged by peer */
> +	SCM_TSTAMP_COMPLETION,	/* packet tx completion */
>  };
>  
>  #endif /* _UAPI_LINUX_ERRQUEUE_H */
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index 55b0ab51096c..383213de612a 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -44,8 +44,9 @@ enum {
>  	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
>  	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
>  	SOF_TIMESTAMPING_OPT_RX_FILTER = (1 << 17),
> +	SOF_TIMESTAMPING_TX_COMPLETION = (1 << 18),
>  
> -	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_RX_FILTER,
> +	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_TX_COMPLETION,
>  	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
>  				 SOF_TIMESTAMPING_LAST
>  };
> @@ -58,7 +59,8 @@ enum {
>  #define SOF_TIMESTAMPING_TX_RECORD_MASK	(SOF_TIMESTAMPING_TX_HARDWARE | \
>  					 SOF_TIMESTAMPING_TX_SOFTWARE | \
>  					 SOF_TIMESTAMPING_TX_SCHED | \
> -					 SOF_TIMESTAMPING_TX_ACK)
> +					 SOF_TIMESTAMPING_TX_ACK | \
> +					 SOF_TIMESTAMPING_TX_COMPLETION)
>  
>  /**
>   * struct so_timestamping - SO_TIMESTAMPING parameter
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 2bd77c94f9f1..75e3b756012e 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -431,6 +431,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
>  	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
>  	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
>  	[const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] = "option-rx-filter",
> +	[const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] = "completion-transmit",

just "tx-completion"?

