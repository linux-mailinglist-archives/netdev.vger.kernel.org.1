Return-Path: <netdev+bounces-306462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rjPrHWatUGo63QIAu9opvQ
	(envelope-from <netdev+bounces-306462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:29:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A65738793
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:29:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VqIRJa49;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306462-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306462-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85228305B99F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AF3EFFCB;
	Fri, 10 Jul 2026 08:26:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCB3EF650
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:26:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671967; cv=none; b=hgnt6It/6FMK8UD4BZhuUAV3WtuNGAoE2a1P84dLGZD7wzwUOcAxSXYECPQ0UZ03u6DHurY2rPs6Fk0peYx3P6CKl5DInW38ymTIcH/fXMh70YWwWrWhBkt5lVE/3tgoL2Y4T0QKqqCj7ADaicSeTsrUNDowO7wm29u1Pp9z788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671967; c=relaxed/simple;
	bh=rhDkZKzNOPti8An0YJh9Wp82NZEV0D9oY3dxS79PLSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLXhqYL7RWp63Q5VIHa13h0+rQcNNrTdbF5AGrFR70fpr2TiMswrKsTdvEXdLh+PdjeYUMdw1UsBhAS6FaiXfrFXBFEtr5E4GBlhaC0htl/fw4+sB3TR/GKiswDh5FrhvBb6l54V54YqoT+MM4yXogVtK7XoLkoLfhlmv8k5VGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqIRJa49; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47db714766aso912939f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783671964; x=1784276764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nUW4377iFNCldOqNyU33KDwovGokuGogAQ9Aa2VUBDI=;
        b=VqIRJa49QVWQHGXvuNfaplao0NPpTwtgRfAzNVmnOTPuzDyEnaV4dm6mT7HPQ3uXCp
         8xHp/blEU2OI9v+GjZqdDu1gfH4UcgCj8XzYaP89cBXzR1fSXiuuIRQXhAz8Tl+IYpfq
         1EDyyd8Z5RQNbcfVr1fsOLpo6dkqlVcN0KZH5DI+tOa9s5jDrRQmEdN/UCuPFjeB4Ffc
         Nywej0WzMssDHf+g3RuYF4e2RRnhSsbXGZAlOmW9GUZA0vyJ0bcXCegXwPxqzvYfb50Q
         Z5UIOWPNQ903yFeQfA8Z4Wj4f5Ca4tWW6XUULmE0aFPqcNYBeKefYyyqaWP/PAYspO+y
         y4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783671964; x=1784276764;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nUW4377iFNCldOqNyU33KDwovGokuGogAQ9Aa2VUBDI=;
        b=ew5NeK49Aac94RSXgjBF82X+JjOst1KJbq5dpbu8nbM7tNZqHyHrgv7OGW3m20b/Uw
         A/ndu7bSQ9ySYuwU3PqtuoCaOvk4mMG76lnqqAHdgGzgOmKK09vw6CnaRpVE7XaRZ1/D
         E79BOOmdq8mgUm9FjWEWG9dgc6PSjcMNsZL2Ku8LOZZXzsGT+yUBX7GPUqRFxdGoO8UE
         henDMfv8h7+CSOl5J9ASApMuzxM/HadIawZ1A7yoLvXBmsihNtXtQ9Ns/TgKhebhkqrP
         O3itkmb5v4u1dNsTYZmZDXQ9ntnQwUYevjAiAhzoFfWzN8O5XUg0Q2/PgYgYK50FtF9n
         8XLg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7nM5fYMOCWABoyaUsgWW56es7ME6SqgK4/k8PbYZqipcNT4Mm0T80h48t8Qk7CjX0uULLJI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLdE0aRqdKHES+0G9ZPS/UV8dyVc6W7LcjA4nogCbY87FM9Ll
	NPuFiwyOITx9oXdH2tuVZinRAEkEdCL4utmmOi/h0gYyoseMtGLYDRl7
X-Gm-Gg: AfdE7cniLbelUa+PeBWGe+KxR9ACezgHrf5Qi2P4L5oKPCtq0ll7/bzHYf76eujLtvk
	QmuJgC2ULCwCl9+2qCXXnZEk1CV7GaVhmxayRAhgEjBlzjO4mSive0ZKmJWV6asqZhz/MIl3puZ
	Dgs5lhQZgq+HnNzeszvL0f7xRD3aVmZu9kS1wHoscNAIIgDFQ8XlLKqc6c4IwjFyx+xANIGzgeO
	pLVYVT56rCeRWYQhZzGI4KRJgswIeirhEy88GgmPb3MxcYbBdd3az9PwdTimqtHX3G8UguoQOQ/
	+9DjM6qnUS5SOV4E5I6Dut7kQGHOMqnyXPRDYUkzbNG4+uF1+SgeKOsGIcDdJm3N8kCLu7Dx+/Z
	RN2V/K+nKCy4+t1kNZ3L43ZVpqelQU6SDrkXbQFkSu054GxLhWe0C9YwcwlYW84bbbYeoJgbTOc
	ghOaKAc0yZ2kXVqxBKfBV4mA9JjxZ5I0OQ3QROwqBiRSB6nQ==
X-Received: by 2002:a05:6000:614:b0:47d:f681:b74a with SMTP id ffacd0b85a97d-47ef6990c8dmr2683692f8f.26.1783671963936;
        Fri, 10 Jul 2026 01:26:03 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm62016911f8f.7.2026.07.10.01.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:26:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:25:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v2] sctp: validate stream count in
 sctp_process_strreset_inreq()
Message-ID: <20260710092559.40f37700@pumpkin>
In-Reply-To: <20260710010718.20318-1-blbllhy@gmail.com>
References: <20260710010718.20318-1-blbllhy@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306462-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,microsoft.com,linux.microsoft.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pumpkin:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19A65738793

On Thu,  9 Jul 2026 21:07:18 -0400
"Cen Zhang (Microsoft)" <blbllhy@gmail.com> wrote:

> When processing a RESET_IN_REQUEST from a peer,
> sctp_process_strreset_inreq() derives the stream count from the
> parameter length but does not check whether the resulting
> RESET_OUT_REQUEST would exceed SCTP_MAX_CHUNK_LEN.
> 
> The OUT request header (sctp_strreset_outreq, 16 bytes) is 8 bytes
> larger than the IN request header (sctp_strreset_inreq, 8 bytes).
> Generally, the IP payload is bounded to 65535 bytes, so the stream
> list cannot be large enough to trigger the overflow. However, on
> interfaces with MTU > 65535 (e.g., loopback with IPv6 jumbograms), a
> stream list that fits within the incoming IN parameter can cause a
> __u16 overflow in sctp_make_strreset_req() when computing the OUT
> request size, leading to an undersized skb allocation and a kernel
> BUG:
> 
>   net/core/skbuff.c:207         skb_panic
>   net/core/skbuff.c:2625        skb_put
>   net/sctp/sm_make_chunk.c:1535 sctp_addto_chunk
>   net/sctp/sm_make_chunk.c:3695 sctp_make_strreset_req
>   net/sctp/stream.c:655         sctp_process_strreset_inreq
> 
> The local setsockopt path validates the generated reset request size.
> However, for an incoming-only reset, it accounts for the smaller IN
> request even though the peer must generate an OUT request with the same
> stream list. Such a request cannot be completed successfully by the
> peer.
> 
> Reject peer IN requests whose corresponding OUT request would exceed
> SCTP_MAX_CHUNK_LEN. Also tighten the local check so it does not send an
> IN request that would require an oversized OUT request from the peer.
> 
> Fixes: 7f9d68ac944e ("sctp: implement sender-side procedures for SSN Reset Request Parameter")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Closes: https://lore.kernel.org/all/20260707203215.2752-1-blbllhy@gmail.com/
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v2: Add the OUT request length check to the send path, as suggested by Xin Long.
> 
>  net/sctp/stream.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index 5c2fdedea088..34ffe6c945a4 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -308,7 +308,8 @@ int sctp_send_reset_streams(struct sctp_association *asoc,
>  					goto out;
>  
>  			param_len += str_nums * sizeof(__u16) +
> -				     sizeof(struct sctp_strreset_inreq);
> +				     (out ? sizeof(struct sctp_strreset_inreq)
> +					  : sizeof(struct sctp_strreset_outreq));

Does it really make any sense to have a connection with the 32k streams
that would be needed in order to send a maximal length request?
(Or more likely a user requesting the same streams be reset multiple times.)
So an initial check that str_nums < SOME_CONSTANT_JUST_BELOW_32K would do.

Looking at the code I'm sure the kmalloc() shouldn't be done in the
'str_nums == 0' case either.
In fact it is probably worth doing the kmalloc() earlier to avoid two
scans of the array.
I even wonder if it should be possible to allocate the chunk without filling
in the data and then put the values in afterwards (freeing the chunk if there
is an error).

Then there is the code that reverts the state to OPEN if sctp_send_reconf()
fails - nothing check that is the original state.

	David
 

>  		}
>  
>  		if (param_len > SCTP_MAX_CHUNK_LEN -
> @@ -639,6 +640,9 @@ struct sctp_chunk *sctp_process_strreset_inreq(
>  
>  	nums = (ntohs(param.p->length) - sizeof(*inreq)) / sizeof(__u16);
>  	str_p = inreq->list_of_streams;
> +	if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq) >
> +	    SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_chunk))
> +		goto out;
>  	for (i = 0; i < nums; i++) {
>  		if (ntohs(str_p[i]) >= stream->outcnt) {
>  			result = SCTP_STRRESET_ERR_WRONG_SSN;


