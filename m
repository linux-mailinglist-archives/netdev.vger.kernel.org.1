Return-Path: <netdev+bounces-296312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3dc7JrfeJWrfMwIAu9opvQ
	(envelope-from <netdev+bounces-296312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:12:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6386519AB
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 23:12:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XmzCw1SJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296312-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296312-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57793300B9DF
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA8330D23;
	Sun,  7 Jun 2026 21:12:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6529B77E
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 21:12:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780866732; cv=none; b=M6wzWCLThAzNAsMLVjbgTynhjUt/ydMh9WqvWKqfvVMbWW1cu0Y/xspmlfKVg1GuPRlOt/MpfPggZsEOYTUgLGI68QU8w6TdOPW6OUmSsMz1wRwJATOmeO9K3vBupEXIF4zaRr6C64ZNGgajkxpSma8G1fRZaIobbGRIU85timg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780866732; c=relaxed/simple;
	bh=W4FY4oqIWnrg1bm6UE7+cXSx7yUMi2cuyWxja/i1Gio=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Th+LAOWQvhBWfOtMHnpuqj/STPGTbTTocZ12Ot/KNKblyJPvCIHOWqQFCQThlZNzqIfw0sNo2sBC4hbMS2V0KcbFgeYFAB48FNUUfyOV0OF/o4hNTXyNN6zBOhTl/yQ6H3/xWkfVK0hbfoElLGbGsvKI0bBWNKJ53iN2XX/QxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmzCw1SJ; arc=none smtp.client-ip=74.125.224.49
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66058b880e9so3629088d50.2
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780866730; x=1781471530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFg0iQedcFZzrRfD8gM/EHxjuobCJKdPd87KYVJTg0Y=;
        b=XmzCw1SJLyhF896ZvoSE0/4GkYY9Q6kk4I07RVCsrhpajTHsBnappb3UkmV7rwNC64
         pH9x/14cSj5e+0XK72HGmUKX7wwEnmen7vWpPL5ACU0jq/1Tfp97v95fGDPw4gGBIIpP
         XdpFs9kfTzf79ymC4+QBBSe0yeWDDU9xrA2FLidSg8zqjndNifb8HFwU2YcVjjtHvRZc
         TnGXoaT+4nuD3eRY5p5iFOV7bDqAcUljtyzooMt4GtAkyL2s7gjz7yAwx8GA6rEM8c3G
         55gfee4niYUKu+DIHwbW9Uh5xCebS7zQpxa5j/mcfRr8mhHa0wqDhK/Dzyk5faRb13hg
         7Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780866730; x=1781471530;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFg0iQedcFZzrRfD8gM/EHxjuobCJKdPd87KYVJTg0Y=;
        b=POEKn6tvo8aMKr+ccSHb/Wxu03l6NkVoJsiUjQvcen+29WjaD7LxAraLRGRIYUqdXF
         rnGFhUOYTPsbOgvNp+IZA12bpyuyydWe5YvlZUlRetDi7g59aBYPilKWzhgkX0VUaKEN
         hwQHMIpq2D1Rf5OvIjiBEqvq5Y0jcZV2muS9BJrPopkIVaIF94d1ne1aEOq70Bk4SdKT
         uEzlBMceG2JF8vXooAacYAOhSa+vu5wRTF9zj6BTzxUwC7DWJaQS0MR/Xe6gZXQ/WdJP
         AV2CdDT8gIIAnLwjRKi6gCp6jv5Sh+7ATvtv3KNaDS/OHcmj8XQnn/1ki6GMk+mspftu
         juuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8U2kGC6Ya1SEBBR1iZ2cZl3mLboLu/q3Wx4KKtrqEHG+28YP8TRFpqkDpKmHbd7zDJPrTbvd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOijGrmceK3+2lzDgAha34PpuAlOhDL/89sLTMdt1crMt1tfa
	Ksnnv4NWdfZ0hxLruvIRj0xF1Ko2dRvxlRr8V6I4LSYwMLgsVkCf5snv
X-Gm-Gg: Acq92OGvQARTX/383VoD7TP5AV1mcez6+XTWvaeQb6K7OHw7drV5AbaBj/3W68nGmvM
	jnRqfjlMpmJ2GkzcS68gaPjlMm0MrYG3TSPCsHJen3z3MiMPdvGn3nFAjH4CjAMzBdDuOzHFt2l
	CgtNU9J5TClY+xcI93ydfOi5AEDZqoG+LNqnl22/3b7eMg8+cLeSpSqzDd2V75DQ9Y2KDQEnTBz
	jgtDlaxsc0Q5ybLfO0OcAOpAayhDqFSCyKVI/FFfmoobWrzv+2M3vgC2+fH1ES+C/FJRrqe2LCP
	uHN4TMLzVnmp7PUfEtEz1PI3PBC9FwIY8X3kM0X1R1ODutWyABWtQtUi+d9Bu7RibDagx8tK+AY
	5432ar810eEQ3HYr29zyiNcj6GhsoY6plqEjwdrz/GqfRYEA4nhHf1DUrFru/N/ravNAjx3U54x
	oRGdtzknzc72TYl2WKmwDLR7wBwCmoRnVCU8po7kzuJ2D6cBVbDN1aZKAA3uW8tZHJvkQtWCeAp
	tdmiHYihGRKxIlU8g==
X-Received: by 2002:a05:690e:5cd:b0:657:e42c:ef3f with SMTP id 956f58d0204a3-6610707c453mr8950025d50.47.1780866730376;
        Sun, 07 Jun 2026 14:12:10 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d6488b1csm8542234d50.19.2026.06.07.14.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:12:09 -0700 (PDT)
Date: Sun, 07 Jun 2026 17:12:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xiang Mei <xmei5@asu.edu>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 bestswngs@gmail.com, 
 Xiang Mei <xmei5@asu.edu>
Message-ID: <willemdebruijn.kernel.134e1b2cf583@gmail.com>
In-Reply-To: <20260607054428.3050243-1-xmei5@asu.edu>
References: <20260607054428.3050243-1-xmei5@asu.edu>
Subject: Re: [PATCH net] tun: zero the whole vnet header in tun_put_user()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,google.com,kernel.org,asu.edu];
	TAGGED_FROM(0.00)[bounces-296312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:bestswngs@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC6386519AB

Xiang Mei wrote:
> tun_put_user() declares an on-stack struct virtio_net_hdr_v1_hash_tunnel
> without zeroing it. For a non-tunnel skb, virtio_net_hdr_tnl_from_skb()
> only initializes the first 10 bytes (sizeof(struct virtio_net_hdr)),
> leaving bytes 10..23 (num_buffers and the hash/tunnel fields) as stack
> garbage.
> 
> An unprivileged user can set the vnet header size to 24 with
> TUNSETVNETHDRSZ, so __tun_vnet_hdr_put() copies all 24 bytes of the
> partially-initialized struct to userspace, leaking 14 bytes of kernel
> stack on every read of a non-tunnel packet.
>
> Fix it the same way tun_get_user() already does by zeroing the whole
> header right after declaration.
> 
> Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  drivers/net/tun.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 9e7744eb57a3..fed9dfdfcc3b 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2070,6 +2070,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  		struct virtio_net_hdr_v1_hash_tunnel hdr;
>  		struct virtio_net_hdr *gso;
>  
> +		memset(&hdr, 0, sizeof(hdr));

Alternatively clear the trailing bytes only when uninitialized in
virtio_net_hdr_tnl_from_skb. Sketch:

"
+++ b/include/linux/virtio_net.h
@@ -437,6 +437,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
                if (feature_hdrlen && hdr->hdr_len)
                        __virtio_net_set_hdrlen(skb, hdr, little_endian);
 
+               memset(hdr + 1, 0, sizeof(*vhdr) - sizeof(*hdr));
                return ret;
        }
"

But it's not trivial to very that all fields beyond the basic header
do get initialized in the tunnel case. So clearing entirely certainly
is a more straightforward correctness analysis.

>  		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
>  						&hdr);
>  		if (ret)
> -- 
> 2.43.0
> 



