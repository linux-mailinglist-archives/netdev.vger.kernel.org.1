Return-Path: <netdev+bounces-257152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ9YOFOMhGl43QMAu9opvQ
	(envelope-from <netdev+bounces-257152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:25:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA166F2704
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 340573012CD9
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B373D3D13;
	Thu,  5 Feb 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dq8Atzid";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="em4AP3n7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480A3D3326
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294308; cv=none; b=mFgCKlv0iCjfpzIjWP1pN7Dy08KNSnutR9MiU3/Jloz1UMJA4spvE2cXEK1wPBzAEdEIqga9ddRAjdgh8+r99Dp8QGq++CPhYqrB1dEhWyuRpTLZ6QWLPfrdrDp7UwUq1t4lBkPLMt1Qfz3zz4hhxwbAqeXF5VQW2ZHVGGaKBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294308; c=relaxed/simple;
	bh=UCT9T7RFoRwwIxz842UJQcni7KlvNWG7p1c22wQ0zEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ppe3dUzAl16RBnEixR8dgTbxaGI3gvK+UCxoyoqdCpyKSQ8lgzeKmFdvoL2FHEBY+spjuQGwgVf1v+0k/ewpc4Pe+mCHJ9/A8RwB3cqeuIaajc2JawPmTB1f1QwvDkOlKNPGG8IMJ5Sw5VXymYOEG/eg1vol8VT4wGeEN4L92do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dq8Atzid; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=em4AP3n7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770294307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZydmCav/dU/SGy4dKWuJfqtm/aEsCFJ9lYpqcb2R4g=;
	b=Dq8AtzidUR9tUu5FbjKj5AbrvHmG21u7PJ2IM3+Nopvg6cgXGt8r9oPyd6Q3XXJibFauzt
	YWnRnfDlxwXGYmsOMBUWVGoeV4Hplr7lg42FXSJ2ws8xLqepKacS09iPkQPiKJ5qkqKXEd
	01OrJXbU8eJjoJFy3yKY/SB+SmeKtIU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-hj2RTA_bOqqI7CNkCHc1JA-1; Thu, 05 Feb 2026 07:25:06 -0500
X-MC-Unique: hj2RTA_bOqqI7CNkCHc1JA-1
X-Mimecast-MFC-AGG-ID: hj2RTA_bOqqI7CNkCHc1JA_1770294305
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8db12d8c65so182240266b.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 04:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770294305; x=1770899105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZydmCav/dU/SGy4dKWuJfqtm/aEsCFJ9lYpqcb2R4g=;
        b=em4AP3n7cS/MFFgaQT59Evd/GgySz7tnCzMKZfD1ngETv6LkXeM2+mGlZGCbLVMGP4
         Iqoe9khHGr7P/Hr6gpxAghEqXPBt/1j/U7J9FQQ+d3Vm9CFLDJ8sqdCRuKwTXyhiw8mc
         zfpQ7ehwFCVXCwJTQKTeuqi/ihMYROe2dhos5TB60pA1jfu9xD/+dcgb4aGTaDySUWDd
         p8Clpd4tEa0gzHqXoGchedogE84XO5cGl/2aHKpgepya0W5HYqcEWOb9wJ+lxXGGw7Bm
         htTzPztPfUXB6uqa990GrKMISD41F4klY77pWl651J2szLxDJCMjKPx4Re7ebjU4TyDB
         8Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770294305; x=1770899105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZydmCav/dU/SGy4dKWuJfqtm/aEsCFJ9lYpqcb2R4g=;
        b=KmbPwh46sifPibScbE54EnKU1ryl60856eJM0x9cZFfUG/p/L9tOaA21hjL+ZePEkZ
         SoAnrZpbV/n/NmVQl8Lic2TnRowOeX7au0FfVs9BK7Rj+2fp+yg+8BK2ousADwRQJeKP
         C5IzEOMSJcCiEWm93aq8+eCSAEI1ijpKxsjSqJha/5ACV3V0klC2JYrNbhHCbv3rkIGU
         WaqBRd9NgvhFH+c8Gau+au3IRPxARYVkqD+CvxQTCiX7OgK4pzGtinbJaJG86MVvmmNP
         PevMFpfA1M4BZD5+tKL50LWe8sra4U4sK/Q3zp38Ikx6LHKyofFPWPmSY0Jvfbr23eyG
         dBQg==
X-Forwarded-Encrypted: i=1; AJvYcCWSezxUTRhHGF8NVAoi0XXiaXl2YJJbNL/LmsMbEKl8Z8Gccmz5wRUXBqWSqQWWTCWJxWGCK8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzomMwtMeb92h7LcLFe7R02iFUk0aJTCn+7j96yjnOf4l/pvnGk
	7yNGAtrcIiT7GKhjDfKzVaM5A9m3JyRpa/5mbGBba77u4g3x8X24XWqL5LWNqdgkcoI6r9/ps/e
	rueOiaueQVErIqtCj90rCFGLfNznmI127kIHPn+9dJ3v32uUKEPsiZ04NTQ==
X-Gm-Gg: AZuq6aKY5CXre0igt3fDAjnzslv5/aYz69mgbt3VVcnLRjnF65d9UbNav0u1wYcY5MQ
	nAFDsSdRWv8laMmljySoMjFCU5iY2DtSe9kmQnAjAZqSRbjZHLSLuS7Kd6IRPE9UwOeDZv6Bwlw
	NBZXDsdN15EAdo4we+THUKCh22OlSO7+yF8wb/kvBfg3m/tl1nzbzHkgGzAtzQn840xrg8waaEH
	OyUsE/8blrRVK5UKw2DawxBYJU7VA/1bRKNpwrKW1iGCtUkoCJfUW3GjU7USgYOSJtJmzYSMEFt
	Wjiu8TdXI0JDJ1L8y6iVYWZh/4iqJbq/i8HZjHWTMin2qq0v23tTVzSL2rBtJbEDBMvxFene4HR
	yBlAbalsRXff0
X-Received: by 2002:a17:907:9345:b0:b75:7b39:88bc with SMTP id a640c23a62f3a-b8e9f443951mr377656666b.58.1770294304678;
        Thu, 05 Feb 2026 04:25:04 -0800 (PST)
X-Received: by 2002:a17:907:9345:b0:b75:7b39:88bc with SMTP id a640c23a62f3a-b8e9f443951mr377653566b.58.1770294304124;
        Thu, 05 Feb 2026 04:25:04 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0073117sm217890966b.71.2026.02.05.04.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 04:25:03 -0800 (PST)
Message-ID: <ccad3f52-e46a-46b5-9113-153a31b3ddd3@redhat.com>
Date: Thu, 5 Feb 2026 13:25:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/8] hsr: Implement more robust duplicate
 discard for PRP
To: Felix Maurer <fmaurer@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, jkarrenpalo@gmail.com, tglx@kernel.org, mingo@kernel.org,
 bigeasy@linutronix.de, matttbe@kernel.org, allison.henderson@oracle.com,
 petrm@nvidia.com, antonio@openvpn.net,
 Steffen Lindner <steffen.lindner@de.abb.com>
References: <cover.1770041682.git.fmaurer@redhat.com>
 <d767a756f426b8906ea12e411a97cf2ba04182c5.1770041682.git.fmaurer@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d767a756f426b8906ea12e411a97cf2ba04182c5.1770041682.git.fmaurer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA166F2704
X-Rspamd-Action: no action

On 2/2/26 3:19 PM, Felix Maurer wrote:
> The PRP duplicate discard algorithm does not work reliably with certain
> link faults. Especially with packet loss on one link, the duplicate discard
> algorithm drops valid packets which leads to packet loss on the PRP
> interface where the link fault should in theory be perfectly recoverable by
> PRP. This happens because the algorithm opens the drop window on the lossy
> link, covering received and lost sequence numbers. If the other, non-lossy
> link receives the duplicate for a lost frame, it is within the drop window
> of the lossy link and therefore dropped.
> 
> Since IEC 62439-3:2012, a node has one sequence number counter for frames
> it sends, instead of one sequence number counter for each destination.
> Therefore, a node can not expect to receive contiguous sequence numbers
> from a sender. A missing sequence number can be totally normal (if the
> sender intermittently communicates with another node) or mean a frame was
> lost.
> 
> The algorithm, as previously implemented in commit 05fd00e5e7b1 ("net: hsr:
> Fix PRP duplicate detection"), was part of IEC 62439-3:2010 (HSRv0/PRPv0)
> but was removed with IEC 62439-3:2012 (HSRv1/PRPv1). Since that, no
> algorithm is specified but up to implementers. It should be "designed such
> that it never rejects a legitimate frame, while occasional acceptance of a
> duplicate can be tolerated" (IEC 62439-3:2021).
> 
> For the duplicate discard algorithm, this means that 1) we need to track
> the sequence numbers individually to account for non-contiguous sequence
> numbers, and 2) we should always err on the side of accepting a duplicate
> than dropping a valid frame.
> 
> The idea of the new algorithm is to store the seen sequence numbers in a
> bitmap. To keep the size of the bitmap in control, we store it as a "sparse
> bitmap" where the bitmap is split into blocks and not all blocks exist at
> the same time. The sparse bitmap is implemented using an xarray that keeps
> the references to the individual blocks and a backing ring buffer that
> stores the actual blocks. New blocks are initialized in the buffer and
> added to the xarray as needed when new frames arrive. Existing blocks are
> removed in two conditions:
> 1. The block found for an arriving sequence number is old and therefore not
>    relevant to the duplicate discard algorithm anymore, i.e., it has been
>    added more than the entry forget time ago. In this case, the block is
>    removed from the xarray and marked as forgotten (by setting its
>    timestamp to 0).
> 2. Space is needed in the ring buffer for a new block. In this case, the
>    block is removed from the xarray, if it hasn't already been forgotten
>    (by 1.). Afterwards, the new block is initialized in its place.
> 
> This has the nice property that we can reliably track sequence numbers on
> low traffic situations (where they expire based on their timestamp) and
> more quickly forget sequence numbers in high traffic situations before they
> potentially wrap over and repeat before they are expired.
> 
> When nodes are merged, the blocks are merged as well. The timestamp of a
> merged block is set to the minimum of the two timestamps to never keep
> around a seen sequence number for too long. The bitmaps are or'd to mark
> all seen sequence numbers as seen.
> 
> All of this still happens under seq_out_lock, to prevent concurrent
> access to the blocks.
> 
> The KUnit test for the algorithm is updated as well. The updates are done
> in a way to match the original intends pretty closely. Currently, there is
> much knowledge about the actual algorithm baked into the tests (especially
> the expectations) which may need some redesign in the future.
> 
> Reported-by: Steffen Lindner <steffen.lindner@de.abb.com>
> Fixes: 05fd00e5e7b1 ("net: hsr: Fix PRP duplicate detection")

I'm sorry for nit picking, but it looks like the current quidance is to
avoid fixes tag for this kind of resiliece improving refactors:

https://lore.kernel.org/netdev/20260121171051.039110c3@kernel.org/

> @@ -526,18 +613,21 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
>   */
>  int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
>  {
> -	enum hsr_port_type other_port;
> -	enum hsr_port_type rcv_port;
> +	u16 sequence_nr, seq_bit, block_idx;
> +	struct hsr_seq_block *block;
>  	struct hsr_node *node;
> -	u16 sequence_diff;
> -	u16 sequence_exp;
> -	u16 sequence_nr;
>  
> -	/* out-going frames are always in order
> -	 * and can be checked the same way as for HSR
> -	 */
> -	if (frame->port_rcv->type == HSR_PT_MASTER)
> -		return hsr_register_frame_out(port, frame);
> +	node = frame->node_src;
> +	sequence_nr = frame->sequence_nr;
> +
> +	// out-going frames are always in order

Please use /* */ for comments.

/P


