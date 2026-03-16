Return-Path: <netdev+bounces-268124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFzmHDLpt2mzWwEAu9opvQ
	(envelope-from <netdev+bounces-268124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:27:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F4298A7D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BAE1302768F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AC2338586;
	Mon, 16 Mar 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6Fqyz5I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV6fEPkw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4202951B3
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660260; cv=none; b=R24QNHjnT46c48zy9kan6xoKq3HocJLJKi3kYsVtPs/Lfz1zrtMHo/xq6RT3EOD2uR+HSmONbLGNPyE6oJtUjcPprBSF47hUVVzhOSSAclpegFFldqQTaGpoJ4s212BlaktQawmP7AKbNSLQDM2fqTMs7ELytTnnHdJ8LxUwUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660260; c=relaxed/simple;
	bh=vExqsQuY0TOh0C4OqHS5ONqjXZPb4O5dkQOinRtjo/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/DaW7e9OIIuPk8kHUOO8mRuU4q+jzW6CsmTcPVB2JYYBvNPjhrUu0xNYDElYvtoINctnaod81imiBj4Atv6fydGeZadLZDwJEGp3n/EkKGcLw0eF3LL7Nmqfi3F/cv3RaugOZ9qkj5TRfWqrSlsUCnc/IFnIT+p5Uo3617NQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6Fqyz5I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NV6fEPkw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773660258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9hWHpx6fXvQ6tiAS+Vx6gKKziz7E3xCqMnpnyHx+ks=;
	b=B6Fqyz5IVSt3GT1ulMlu9mvzM+CA70XjObXe+5Gd8yBnDbRV3zsSgLTfcMrhOcE/J71QOG
	Zx2eMifGvjFmI/YyF4iMbpGml7mir8HQ2GfFjhBHsP4haMNshDJt7b35DI7za79IwcDZdm
	EbzAGhVf3jD+0u46sDwYtQzxdKLcTbs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-ikMB79m_NXCFbkV0mtdw6A-1; Mon, 16 Mar 2026 07:24:17 -0400
X-MC-Unique: ikMB79m_NXCFbkV0mtdw6A-1
X-Mimecast-MFC-AGG-ID: ikMB79m_NXCFbkV0mtdw6A_1773660256
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso61308695e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773660256; x=1774265056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9hWHpx6fXvQ6tiAS+Vx6gKKziz7E3xCqMnpnyHx+ks=;
        b=NV6fEPkwo3NU6CHi+YqL3sv30eFK9RhGWJQR0Knl42QG5QcFR8RBiOI+JigYlrQ+ft
         LGQ8FC4dvwlQ3gOowpzISZ1VOIpl7/aLKeHBalDrxcaglCK55flHNEs0qPgzy661nEHQ
         z35/UnsD686/RIgK7SWhdl/mXAmJVaWLEV5LEDIot/ba+1/LUZUKjIGl6L+UjpRKWnup
         h+QRARlNlUHN0TOsmfY/Qsndq9UJT3hYuCevWZVnPTlpJWvgBzmptRdqo4KZJcNFxA7n
         fGXpt2MMVTI0W7xknSJXubk/Xxi824XhoEAacu613aezcKyhyoTGMiO0QpYEP7Pdl/0K
         ud+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660256; x=1774265056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9hWHpx6fXvQ6tiAS+Vx6gKKziz7E3xCqMnpnyHx+ks=;
        b=dtYnm+E0bQt2qbdrNNWzmesAvKw9pwhjg21BtmE4ghOC9fSNFI1mUoIEYiqx8tgMpK
         iZ/SWoLMKcZPTiMkaO9f49gwEAqPzl6xZM1aVFG6ahM1Ef5DuUkI5pOqmDyZxWeVPPsm
         DKW7IMN07DnVPSvp4GnF0lmDy4XS9JEKFusLHeyetb/Cz2S7hjFSdO2xpYa8Zy1ogaUi
         MV98bNnrnk32QhzSaCC5VPS19fYJWuWiVVdStAAqRTRE60BG3qXrpYOVSWcuNXX47yCP
         AdwHzwK4+TmSXpTnRh6r0+5WF3wEFPig/G3x68eQuEyZHQoFqeABoFIc3jNe93sEeq3K
         OBzA==
X-Forwarded-Encrypted: i=1; AJvYcCX1VtZRf6Hqiu38lIiYZRNzJv6F+NOQItyc80NiQFnzwjTnwq7cVI22K2mlSdluEgncLPRp50U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCoD+tnclLKlh7abFBmRhziP7AQTJGwTi+vN9sDtyu9gMhrr6
	0eEyjQ8OiA0XYnAm9J3saiiPaFfJ3QW1TeaLYYswBEIBsbRCnCOTqYPT+SpxNt4sZ1mLxku20B4
	Z6M9KNnR70XFr8M0B5sYXPlv4YJuYEpN900DfKUX9sX7WgSX2cKFqkj3y+w==
X-Gm-Gg: ATEYQzyA0TMkOZvv9K14d6iQhjRePlq/gOO/Ey/4ozUTUL2/xlo/musRo5urSJF1XXh
	Xt/iyZcAnq0kcYV4WCxlffsntVcBuaQABRDXX9OUcgQ0fr0SY/C9SEapqLpAAHyBNx4e97jiv7P
	NrvS6LMqFgiTqrUkeEDc/rbUJrSwE5ncmrdNlW1RGeW1xwmALR3bwhGHiHj2BOApmuP+ZRp+8U2
	Dx6diS/imI+J+5TqxpdnWkxiTHRFJimzPNNezqqSaBhJJfn41qQ6bAzd6hkR7z7ozaC7vYlu/kx
	XD/ql1qOTx4+UoRQREi4HkQWGppjZUsaTJJJu7aKky8KkEcdy8KhfH2B+PbZkM76XXR+jlCU++w
	RCipV8DWCwbEpmzu2BvvLUjiR9YZr3NetUJ+Tu0ynEh/Uw3F1RG0uo7U=
X-Received: by 2002:a05:600c:468e:b0:485:3f58:d9d with SMTP id 5b1f17b1804b1-48556714b67mr207129205e9.32.1773660256068;
        Mon, 16 Mar 2026 04:24:16 -0700 (PDT)
X-Received: by 2002:a05:600c:468e:b0:485:3f58:d9d with SMTP id 5b1f17b1804b1-48556714b67mr207128715e9.32.1773660255574;
        Mon, 16 Mar 2026 04:24:15 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm1215197765e9.2.2026.03.16.04.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:24:15 -0700 (PDT)
Message-ID: <2551cc98-5280-4a9f-8345-0a39e0e09dac@redhat.com>
Date: Mon, 16 Mar 2026 12:24:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] tcp: grow rcvbuf to back scaled-window
 quantization slack
To: atwellwea@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 dsahern@kernel.org, horms@kernel.org, kuniyu@google.com,
 andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 skhan@linuxfoundation.org, corbet@lwn.net, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <20260314201348.1786972-6-atwellwea@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-6-atwellwea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268124-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E07F4298A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> From: Wesley Atwell <atwellwea@gmail.com>
> 
> Teach TCP to grow sk_rcvbuf when scale rounding would otherwise expose
> more sender-visible window than the current hard receive-memory backing
> can cover.
> 
> The new helper keeps backlog and memory-pressure limits in the same
> units as the rest of the receive path, while __tcp_select_window()
> backs any rounding slack before advertising it.
> 
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  include/net/tcp.h     | 12 ++++++++++++
>  net/ipv4/tcp_input.c  | 36 ++++++++++++++++++++++++++++++++++--
>  net/ipv4/tcp_output.c | 15 +++++++++++++--
>  3 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index fc22ab6b80d5..5b479ad44f89 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -397,6 +397,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg);
>  enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
> +bool tcp_try_grow_rcvbuf(struct sock *sk, int needed);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
>  void tcp_twsk_destructor(struct sock *sk);
> @@ -1844,6 +1845,17 @@ static inline int tcp_rwnd_avail(const struct sock *sk)
>  	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
>  }
>  
> +/* Passive children clone the listener's sk_socket until accept() grafts
> + * their own struct socket, 

AFAICS, the above statement is false, see sk_set_socket() in sk_clone()

> so only sockets that point back to themselves
> + * should autotune receive-buffer backing.
> + */
> +static inline bool tcp_rcvbuf_grow_allowed(const struct sock *sk)
> +{
> +	struct socket *sock = READ_ONCE(sk->sk_socket);

You can just check `sk->sk_socket`. Also you could re-use this helper in
tcp_data_queue_ofo().

/P


