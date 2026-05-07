Return-Path: <netdev+bounces-285197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDXAHhRZ/GlOOAAAu9opvQ
	(envelope-from <netdev+bounces-285197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:19:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 274244E5AE4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41ED031506B0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808B39C003;
	Thu,  7 May 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9dGJCEo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9Ux6+0H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333D3AE1A3
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144086; cv=none; b=VCbxZ8pkWL6wo3ApXIkBLm9boohEODlWEx3kvBeLmqYfR7OZNJzaJeTUjdPqK0SQdFd7mnTFn1hIsmu1krVmE+PBA+OVJsJ+qCacmeEjHa5Ly0geuru23CckHOK6/gDwWMjLaHVuxkYcFuWTNcItBNIyvj1t1w3Cvp0Jk7YZ6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144086; c=relaxed/simple;
	bh=xb6ZiBwLsP6jdQI3LJVb4v/501VM5gzJU50dn0+gU+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7pCI8LdHQXkswzg2zXN7aQyC166sxPPU52NTPbO/rMcSn5SA/Y9sPy04tZ1m8V8+P+zFmGtqkX6S84H3t5Yid5K+DTxPdwvzDvQ5sP53PA/PjgknPrItBvqprgRkAycuTJ+AsWCJ7AOPz08ZPZx1b27fOH0C7mu+WLqTrUgcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9dGJCEo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9Ux6+0H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778144078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cf5Hiy8Ry8GA3Jd9aF9Qx8+o0rODNaBHOnWLQ2WctSg=;
	b=U9dGJCEov351XZCVIJZJPgeUntnywvNgX0bXS4RGC48ObRnfKj8I5jV4Y86sJiKMi9+4SQ
	rmk1NLGtHODLSzfR7dZlCLlZ+I2JhNuMCVRByikF3kDZmfa1j+BD7mjpmOPV6nVl+pNNfZ
	IS8vNX61yMOdmKSXfRSp3lBhln8GrgU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-S6wU06WiNQ-b11j1lYB-Zw-1; Thu, 07 May 2026 04:54:36 -0400
X-MC-Unique: S6wU06WiNQ-b11j1lYB-Zw-1
X-Mimecast-MFC-AGG-ID: S6wU06WiNQ-b11j1lYB-Zw_1778144075
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso13292625e9.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778144075; x=1778748875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cf5Hiy8Ry8GA3Jd9aF9Qx8+o0rODNaBHOnWLQ2WctSg=;
        b=L9Ux6+0Ht5CdORY8beTbWj1Cb+2+S8TCcWboY8UyuxSGRn76je4gnHQwo8u28oxIup
         MWWpqdDIIy2XslNfsX+LI4FotkPNO3raF2y97VNBsFq7G3TziU5p3opaqhdwEAso8W61
         emzhD1aQ2dfobYmpP4hhIEZZuneVDRQ8RpbE3mCodDWAzhQjOHiFgqX5SCS4gv2YQ56X
         sP19lyPo/aW9AcKr504ogvDXeINXwnXypDk75/dByNSubr9Z8eZI2SS+oSETP6tWiUJ+
         hsRDDloXPeCdJMRjrgfAOcX2aXREVfrnxY3QmB8IRpCAamfe4jWWrkQ69jDUWA9bz2G2
         Fd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778144075; x=1778748875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cf5Hiy8Ry8GA3Jd9aF9Qx8+o0rODNaBHOnWLQ2WctSg=;
        b=gpwIcxkXnsIfkGCiH8PuMZ9B5+SJJ+7i3zGkXr+LQYjBDLpOknnO//QdJW8GvGoNwo
         Jv/BoFqM+MIHEaUvLxt6mIf8UXwOrof1CNlAq+beB3QXuSO8B3uHpJGg4JqlTxoqOtxZ
         aGkBx16igZ34MAuvDLP/Xce7vsRNyzcpoxnfYMKj6RZvRZvK/OuRye1UDO94K0iBcGwP
         5fUDlrxViWgo4vpOYGhGu8RzYy5P9YhTFjlagEQ5OSX6VnLECc8p9Gyk/mLnR7GqP3/g
         y46Y2TIGDw0AR61HsPhckIRX+sOizAXWGuJ02c+p5Sw3/4+B16+kbaB2+fqAXOs1pynU
         TjtA==
X-Gm-Message-State: AOJu0Yx7C4r6l91OHPCkOJb6gihTAV6d51Ei4itFXaiUndMHW81o32Xu
	+lsF8LRaeb3/RsSWjsM/D044/kkHTSuLCEeETjAY2rWaf7JVKNaPQFjmrU1nqQq9nPxhAGyRtkD
	op574k4fVjIR9TBrp7rFkEip7MFls+8oArblU912fXUFfhnRckra4N722fg==
X-Gm-Gg: AeBDiesRdq3M8wJ+M0UmG3q0uwLyGN0LgztRqOfO6Xpw/OMauobFzzPbyTRUJqH+mdZ
	4d0EASG2Ay8W6onOTNv4SyTfiBVKMoOtfZLnwCLj+rvHXRIZY3x4WM72YAieWfolcsCnrY1N9SC
	aTo2WcPEzZYXBAhixVbomez8VmZm7II41SnL0P9AeKJW2qy1l6vRFf7bGiqLf9eajDzIY7Pouol
	xeoP5/wN8SCWp2qcafv5CaVxvF+szuNcKDtMDE2e/Ea0RmxVjSc1+R9r8zkkLY9i1bDFwJjVtzs
	oI0wLsVRGt83hFMzaJDXhcdI6BWDxqqqNVbcXzQIrRrdmSYdv+KGXgf21q4hSAGJnCx3TjdU4q0
	xk02uWwvUqFjajYvZ+Uc1hkPNph93siNRou3O8qPOdcTRb4MHCZDhN2vLlwW8EBLFcSRmcUm/tj
	Sg
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48e5e0089e0mr31312635e9.13.1778144075243;
        Thu, 07 May 2026 01:54:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3e10:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48e5e0089e0mr31312015e9.13.1778144074746;
        Thu, 07 May 2026 01:54:34 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891163sm118910315e9.2.2026.05.07.01.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:54:34 -0700 (PDT)
Message-ID: <b7399930-ea04-4899-a760-ca1410065aac@redhat.com>
Date: Thu, 7 May 2026 10:54:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 09/13] net: lan966x: add PCIe FDMA support
To: Daniel Machon <daniel.machon@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Herve Codina
 <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260504-lan966x-pci-fdma-v3-0-a56f5740d870@microchip.com>
 <20260504-lan966x-pci-fdma-v3-9-a56f5740d870@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260504-lan966x-pci-fdma-v3-9-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 274244E5AE4
X-Rspamd-Server: lfdr
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
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-285197-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 5/4/26 4:23 PM, Daniel Machon wrote:
> +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
> +{
> +	struct lan966x *lan966x = rx->lan966x;
> +	struct fdma *fdma = &rx->fdma;
> +	struct lan966x_port *port;
> +	struct fdma_db *db;
> +	void *virt_addr;
> +	u32 blockl;
> +
> +	/* virt_addr points to the IFH. */
> +	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma,
> +						      fdma->dcb_index,
> +						      fdma->db_index);
> +
> +	lan966x_ifh_get_src_port(virt_addr, src_port);
> +
> +	if (WARN_ON(*src_port >= lan966x->num_phys_ports))
> +		return FDMA_ERROR;
> +
> +	port = lan966x->ports[*src_port];
> +	if (!port)
> +		return FDMA_ERROR;
> +
> +	db = fdma_db_next_get(fdma);
> +
> +	/* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
> +	 * values before they feed memcpy/XDP sizes.
> +	 */
> +	blockl = FDMA_DCB_STATUS_BLOCKL(db->status);
> +	if (blockl < IFH_LEN_BYTES + ETH_FCS_LEN || blockl > fdma->db_size)
> +		return FDMA_ERROR;

Pre-existing issues reported by sashiko (most of them actually) can be
safely ignored/postponed to follow-ups, but the above OOB (and in patch
11/13) access looks real and IMHO should be addressed.

/P


