Return-Path: <netdev+bounces-279037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCDYDn/X4GlymgAAu9opvQ
	(envelope-from <netdev+bounces-279037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:35:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B37AB40E486
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A40903077E39
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A0E3B8944;
	Thu, 16 Apr 2026 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0lWgpDC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48C3803DE
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342740; cv=none; b=XJ0HprPln/Ezeg4P10AWyqkX9TzQ1s7NIrxrLaC50jSHPEABPtOV1wWbEqNncaxsnIv2XHxBY9B2eoVkqFc40p+Bv05OS2u/9FgIlSSQfacwZ73+BFB3t6ZjuzuCcYjw/DZonEQeW41C+74kBfv+y32KezUlajv+uS/eLAdSBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342740; c=relaxed/simple;
	bh=ydAOpVCxaRGkSIoafmuBHFbulVKKEekBMag+Ywm0+ZQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p71TDvo48zZvF3aJLase8Z+S3XNz9sw6AWHNgb0Oh20Xsaj209QYK91pqWCKRKcygiZoXBp4ZlgPIKtrtiJObyhgBz/jVowa8FYdDtOWfiC+Eyd0vGcPlO/A2gUrLFhpwNJ6t48d5OR16nIGUDIpBGkCCUb52aJKbJKGMRBZ6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0lWgpDC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b41fdf9de2so29850047b3.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776342738; x=1776947538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cynS+faVTPFVRdqWHrSyVI/SVlDQMOa5TP6GL64bMWc=;
        b=i0lWgpDC86BgdDo2jVoVzTjLVHmICOY16xDo9g/PF2qC/ZA/HrhemCoKLYgIpekUNh
         5m8FYqtMsaO51BJXwaciJAUknGa1c4qV815pWJa4/fDgnC/O9ZYhiv+IvptB6WMBWeZL
         MAgc968SIfqwZHDe6UkdSIOUANlDu/BtQLyuu+ZlY5J2nslCailSPB2ZRFEKFLDy5bgf
         HgoBqYUFGTjWgU8T7ogzm1wjzQ6OASJpd+ml8hSZlBoa565IM3FSi27eH6Ho+bzXPTwD
         70+6M292UMahgrsfnyTP18kG6+Kbj8oU7W8WpD9WzbvwS3Ex6oiAL8l7lD7Gj3yUmEGn
         FsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342738; x=1776947538;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cynS+faVTPFVRdqWHrSyVI/SVlDQMOa5TP6GL64bMWc=;
        b=RxfWCl754/UxIbYVRLa2JOkaHTfGp1OrQ+KDEBZ9sDZj11vStzmQSx+93t4hCwipkV
         uaEF0KNtETxTJhR65qqKDKPfObmW2YOVJL1Ina25UUE/RgDtCIJTsqtMUg+xmUhnAmwc
         cTvg31HLoAZXUsFQ9tpDknaMKx56cGD62S9FJldVTR2JI2MSp73STIq0MhCbg8+xgZJh
         xcreRlncT11Z4pW4Vq2SQrwZ6Bslc59Gzkb6Nz5vDMeb446yBbKXp64DPETkR69U2SGN
         B1gzB4I1MJcQ3q7pu4Kxyrsl9zlYeMG7Exv9yqtokg0AymbspDFT470er9zI5sx0L0He
         2ngQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ABiQ2LrETqE83urQyekPgwrp/sw27uPXB/NF6hPjHHrXJgxKHx3aBX7pFcqCjcnVNRNMZQUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wg11IQM337IMVvqh5xbl9hh8ARaWZshORo7fRqVIDyOvc5F6
	M347Y9kXETkk5/zd1u6scAPyCPO41uHaebk8H0SS8oTzZ7UqAxcpNCEV
X-Gm-Gg: AeBDievFw883weoDlTxmNHZK8NkatVQTOg9PYGCEkQJUMNGGT99D6nRv25R5u3PmR8R
	f4nn1/CWyJJmr7zT3DDMgeWasAkippuati72+4d9NoQKVi9fq9JPgCW2xhhXHiV0rFsAScrijrG
	nhkJm0De0Ac7mThkAhZ0Tv3WVz1NU8dc8WCp6Kq9n7bpreEb3iLeHlEmO2Y6MWrw70TNGZZ6QG5
	JsJH5U+pa7he/74c5j5CJA5g5qsL0Qb1PGM+ZDHb4IPi3O/NNXWhee72DXvYgHu9rXMo5nOyjjL
	KoCQXebfJT18aU4wXGuYVR1umOjb6cCyKbmBWm8TMF/Jz78BCJk1PU9HnUF61BzW0Z8sSrDA/i4
	MWnwMql3M4kEPKPlMNF0c3GAmTCKZs4cfwcShxNPm52N8/CF2tPcrWr8rfCyOej5+3jtbDO6BXK
	R8gbdanAoMCci1UtyuvlgBsHWhbtjYl7WX/S5OyTEDlZk//Tc3RTRF0iVrRW1xZQrZSbdeD9rCY
	S8osrUlfg/2d+U=
X-Received: by 2002:a05:690c:6987:b0:7b6:de92:adb5 with SMTP id 00721157ae682-7b6de92bb2bmr84653277b3.49.1776342737764;
        Thu, 16 Apr 2026 05:32:17 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b769411295sm21733707b3.42.2026.04.16.05.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:32:14 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:32:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.30d031033dc61@gmail.com>
In-Reply-To: <20260416075514.927101-6-nhudson@akamai.com>
References: <20260416075514.927101-1-nhudson@akamai.com>
 <20260416075514.927101-6-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v4 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279037-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B37AB40E486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
> according to the decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6
> 
> When all tunnel-related GSO bits are cleared, also clear
> skb->encapsulation.
> 
> Handle the ESP inside a UDP tunnel case where encapsulation should remain
> set.
> 
> If UDP decap is performed, clear encap_hdr_csum and remcsum_offload.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  net/core/filter.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f8d43420afb..e113ae2f3f14 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3667,6 +3667,44 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
>  
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM);
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_GRE |
> +					      SKB_GSO_GRE_CSUM);
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
> +
> +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +						  SKB_GSO_UDP_TUNNEL_CSUM |
> +						  SKB_GSO_GRE |
> +						  SKB_GSO_GRE_CSUM |
> +						  SKB_GSO_IPXIP4 |
> +						  SKB_GSO_IPXIP6 |
> +						  SKB_GSO_ESP)))
> +				if (skb->encapsulation)
> +					skb->encapsulation = 0;
> +
> +			if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
> +				skb->encap_hdr_csum = 0;

This field is not used with UDP_L4.

Similar to remcsum, I'd ignore it entirely in this series.

> +				skb->remcsum_offload = 0;

Why still include remote checksum handling?

> +			}
> +		}
> +
>  		/* Header must be checked, and gso_segs recomputed. */
>  		shinfo->gso_type |= SKB_GSO_DODGY;
>  		shinfo->gso_segs = 0;
> -- 
> 2.34.1
> 



