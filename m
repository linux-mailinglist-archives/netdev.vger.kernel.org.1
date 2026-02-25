Return-Path: <netdev+bounces-260876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK1lC/HVnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:58:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F95196204
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35E86302FE4C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A2F3939CE;
	Wed, 25 Feb 2026 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9eYSS4U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549802D0C82
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017133; cv=none; b=eL17sosyxcRuIAdhCNBKqkuHUXufJXjmmiqW24/S8NyRivMRr+7S7fcRucIuN3HHmDd9l9wky9BNGhLfBeZlRNpmfEvZtGwWYfGVDlj5ChgWTAcmFGRlkryGfa/WJPZlUG9jluSQ+MNekgKAF7rnqCmVFM2+beqK5187bgNgYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017133; c=relaxed/simple;
	bh=DPQ/B0yNcFKdxTDFMr/6BjzBWJxZRyvE01ySyp+G1Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT7TomzjWZdeVNdl/8oiQHJx/FaJ77KY/p/UkgdRSK8zGzpWtyXg3RqpvKKx3GixwC3t3a5E7lL+ixaDMGF3FaqoyFe43fqbS7cCcw8jEoaLg7skOvteLVDg/X17jeYt2NQVZad6g/m2jhrEk+uMn+/s6IL+ug4yaxKb0OXDinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9eYSS4U; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4377174e1ebso4967137f8f.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772017131; x=1772621931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIdRCk7t4GWQocuOik2n76ea1IYJUFZ1loDMZ8piecQ=;
        b=J9eYSS4UQR9nKC5YqxSoDnYWv4R+Js1MrQTKqQl+nxqfu4TFgr9RMxWJMChmAcjVOS
         fJ+cjdTHDymKhI/mOxhDAgPKrnsEHpwpGQn+z2/qpx4o0BeOrURhq7pKCihYIq+X17zW
         49doZq7qi3sRQpl9reqrDU2ygAD1llJcG92iVfD0YPqdTs61DwcADxk+sTAuO7QQdqDP
         UUbmPd9LwqS8NGRGHLDQ1kcQUVS2kOEwTVyt/PTnEwbKRIPI0V2YwoScdvOFIYKv2zBQ
         QI5mDZ/JSRfuNYuesWiC4sFMeJ3SG5mJoaHKHW6a2YhbtDM2PnNCLZTsPyQVPXWbuI2r
         42DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772017131; x=1772621931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIdRCk7t4GWQocuOik2n76ea1IYJUFZ1loDMZ8piecQ=;
        b=Qm6zmJtMUlDBEmwH5SgP3Hmi/qFko068RlAMvYn2+iboENJSWWUSMuNVOrR/w7yO23
         TPm9Cbif7r7xdMLWb4KqJfa4QXLAGokUqlTY/NfHgEBYJdB5FSridAM4UJWAcTUFYgJM
         UuD5GbLRzCW5AUrAM0soAE9efncy3GzuPT3MVP+zT5sPkEhVXBVyE2IwkxA71cpOgFHF
         jT6I1d2+GVUUEt8yyPz+9bfyw6iGBfXWBqjkUJLFCuLSHMqVprF+WNRHQI5eniBaHhhv
         YprTPT0dQc93ebeYQZQ7MgMgLcNElEV0EpdQgNSus1knU8lFHVbzQj5z/HiVxsijFoK1
         ICWA==
X-Gm-Message-State: AOJu0Yz/TCrQpHwi0kc0cQdtzg80CLs3xFei//eXB5PbFS6LdnPvIFIH
	ORhAeqIfyQBgzRPtjo+kFGql71RHECfO5sAqIMNyGdMKiKiDt7LpJ69wK9FBNwy61/U=
X-Gm-Gg: ATEYQzwmkPmff7RbJzJTJsV5yv/1eOvTycPQtlbhF3XiJHxp8t5XMhNRcPCK8O51Qre
	D+E664rg+aAv2GnNtZC5o97b1Hmj3OkwVIbNh1Aofye+litz2oRfmwPzrRB3G1hW2TxY6/UbjvJ
	2wRu83t6BmuCm24A47CrIvWZeVCLnAAnDBNGBehdqWqVA3ilJvkxpXYk5rmQbBANwUXfRUL45n4
	EDkzQeYUgtapyCepGhaELygSvqOu/ykXmiZNF889F9KK+wX/d+XlWDXhCqfeBxbNoh87uXsWvAL
	FJgjqyxTsWo9W/bTA6joECg11IAdxWxaHqqYnLidszVlI+TVqXvGDYqdTqz04mHB9ZjeZMrgAtA
	9Z6f9C5sXgA6VzVw9GxIAwSA70B8RBVQn7r30FU6Mftb/Tkxo9o84DQPJu/ARBzYmPyadhiMWtY
	cv9w24Z/QLGQX8I1v6vMeeOoQ7xY4=
X-Received: by 2002:a5d:5885:0:b0:439:8f9f:4994 with SMTP id ffacd0b85a97d-4398f9f4d4bmr2551757f8f.0.1772017130528;
        Wed, 25 Feb 2026 02:58:50 -0800 (PST)
Received: from localhost ([41.210.147.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c95dsm36546719f8f.33.2026.02.25.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:58:50 -0800 (PST)
Date: Wed, 25 Feb 2026 13:58:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
Message-ID: <aZ7V5b5ZplD4B9i1@stanley.mountain>
References: <20260224044648.243578-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224044648.243578-1-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260876-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,72e3ea390c305de0e259];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: C3F95196204
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:46:38PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
> This issue can be easily reproduced using the syzkaller reproducer.
> 
> In the ATM LANE (LAN Emulation) module, the same atm_vcc can be shared by
> multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_vcc).
> When the underlying VCC is closed, lec_vcc_close() iterates over all
> ARP entries and calls lec_arp_clear_vccs() for each matched entry.
> 
> For example, when lec_vcc_close() iterates through the hlists in
> priv->lec_arp_empty_ones or other ARP tables:
> 
> 1. In the first iteration, for the first matched ARP entry sharing the VCC,
> lec_arp_clear_vccs() frees the associated vpriv (which is vcc->user_back)
> and sets vcc->user_back to NULL.
> 2. In the second iteration, for the next matched ARP entry sharing the same
> VCC, lec_arp_clear_vccs() is called again. It obtains a NULL vpriv from
> vcc->user_back (via LEC_VCC_PRIV(vcc)) and then attempts to dereference it
> via `vcc->pop = vpriv->old_pop`, leading to a null-ptr-deref crash.
> 
> Fix this by adding a null check for vpriv before dereferencing it. If
> vpriv is already NULL, it means the VCC has been cleared by a previous
> call, so we can safely skip the cleanup and just clear the entry's
> vcc/recv_vcc pointers. Note that the added check is intentional and
> necessary to avoid calling vcc_release_async() multiple times on the
> same vcc/recv_vcc, not just protecting the kfree().
> 
> Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68c95a83.050a0220.3c6139.0e5c.GAE@google.com/T/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  net/atm/lec.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index afb8d3eb2185..a5b80d6df603 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -1260,24 +1260,27 @@ static void lec_arp_clear_vccs(struct lec_arp_table *entry)
>  		struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);
>  		struct net_device *dev = (struct net_device *)vcc->proto_data;
>  
> -		vcc->pop = vpriv->old_pop;
> -		if (vpriv->xoff)
> -			netif_wake_queue(dev);
> -		kfree(vpriv);
> -		vcc->user_back = NULL;
> -		vcc->push = entry->old_push;
> -		vcc_release_async(vcc, -EPIPE);
> +		if (vpriv) {
> +			vcc->pop = vpriv->old_pop;
> +			if (vpriv->xoff)
> +				netif_wake_queue(dev);
> +			kfree(vpriv);
> +			vcc->user_back = NULL;
> +			vcc->push = entry->old_push;
> +			vcc_release_async(vcc, -EPIPE);
> +		}
>  		entry->vcc = NULL;
>  	}
>  	if (entry->recv_vcc) {
>  		struct atm_vcc *vcc = entry->recv_vcc;
>  		struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);
>  
> -		kfree(vpriv);
> -		vcc->user_back = NULL;
> -
> -		entry->recv_vcc->push = entry->old_recv_push;
> -		vcc_release_async(entry->recv_vcc, -EPIPE);
> +		if (vpriv) {
> +			kfree(vpriv);
> +			vcc->user_back = NULL;
> +			vcc->push = entry->old_recv_push;
> +			vcc_release_async(vcc, -EPIPE);

I wasn't going say anything, but since it seems like maybe you're going
to redo this patch anyway.  Changing "entry->recv_vcc->push" to
"vcc->push" is obviously nice but could you do that in a separate
patch?

I use a tool to strip out the indenting changes:
https://github.com/error27/rename_rev

So when I review a patch like this, I want to pipe it to my script and
just see:

+		if (vpriv) {
			vcc->pop = vpriv->old_pop;
			if (vpriv->xoff)
				netif_wake_queue(dev);
			kfree(vpriv);
			vcc->user_back = NULL;
			vcc->push = entry->old_push;
			vcc_release_async(vcc, -EPIPE);
+		}
  		entry->vcc = NULL;
  	}
  	if (entry->recv_vcc) {
  		struct atm_vcc *vcc = entry->recv_vcc;
  		struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);

+		if (vpriv) {
			kfree(vpriv);
			vcc->user_back = NULL;

			entry->recv_vcc->push = entry->old_recv_push;
			vcc_release_async(entry->recv_vcc, -EPIPE);
+		}

The renames are nice but now I have to check things by hand.

regards,
dan carpenter

