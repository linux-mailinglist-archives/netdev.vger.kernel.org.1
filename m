Return-Path: <netdev+bounces-169418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CB8A43C83
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1944E3BA8CA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136362673B0;
	Tue, 25 Feb 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I909IC6l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AB2676F7
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481120; cv=none; b=VH6PfFkAJ/N5Ae3zetzQ0tUeBqAhYbE5PoyVBgsXB20U4QexegtlXacf6G2jWFWpfahre9MIWiEi3end9nLestkuOU9u9lM4EWDOM24j+nvqJSrXlmkpL57cJp1VGg/BzSD/2scXsHffw6A2TEWCPxyY4D6KBlPBDPb0AY2CsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481120; c=relaxed/simple;
	bh=5GKjhMSdIGtaB9fefiSAWEdXX8hW8ZSY7qvcXDzuaj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6RJqRcjuwXIn8fVBn/yFYt/FIXYcOH106A+3mlnujTknNk/OnnM6mrVRzvo5m2/H3tYaAsUTCaSaXsbCBJY/m6OXLDLDHYf3IWssOytftJSHTIyBv44kzC2XhdD2xXMmRDNL8llVLqdLabqG/iemApbUwTPYLPwW72LKyULvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I909IC6l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740481117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEth7nzYvrjkKd1whpPyCvFueH4OjZj2aRFsP1dAlyY=;
	b=I909IC6l3SlgUno7UixkyS35JhQpEzBGlxveZPmHZlzJVIIi1Tj1aC5rnBjV1wMthNSRBG
	80o7nXykv3tnyASKnhm6yGrXIOW9LrKu6PKkJ5+riSCVYHgWdvt2HO9dOZS9uiyAnPMlFR
	Zc6kykqsyTeP0GlIti7ww6vtQqWgWl0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-AD23naUMPX-B8lSxedzrDA-1; Tue, 25 Feb 2025 05:58:35 -0500
X-MC-Unique: AD23naUMPX-B8lSxedzrDA-1
X-Mimecast-MFC-AGG-ID: AD23naUMPX-B8lSxedzrDA_1740481114
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43998ec3733so27514845e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481114; x=1741085914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEth7nzYvrjkKd1whpPyCvFueH4OjZj2aRFsP1dAlyY=;
        b=I2vO6zLZzd9LKpn8hL+JMHKEI+DqnxE2KxOhLfBNzUz9oXBiu8aNYLmNUXGZz9cdx/
         pYct0P+6fusnTXKqZsp9oOd+XIuh+IBuS9DZTF3RH/2bMi+GcyGL0ZgtpXbvSw19ALZl
         H0HCL6HFi2ZCJ17sFY89TpVqWLfDU/K6En93qyq9L4OdTTsgrpETgQd0G/3eaCyImp1U
         9syyukNY0uZiNjQrz69dkwHJv5x/XVzzX0ci+VYlh4TY+0zgDwWW4HdPcL6h5DZSeF0a
         3+CvcJWYmunYIQihJZtkUlVh/lrdRH3G6+rLo5xNglnH/4BaJMYIzdQBu97NY43RrXNw
         0Ofw==
X-Forwarded-Encrypted: i=1; AJvYcCXuHw2p0HPi161Zsvr6tO5LZcnKF2TA+V5dLzN5dtcDtsojTNDZL/5cubBqwvCtiHUNUbLxYyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEWUqV0wLspgKdGKqHJRp+iOXyS7xRKMplLM2TWK1RIZRbLbW
	KQd6+fE5y1wZVjUaA+J5AujOWa7nhmjV1NxQ/q1qNFpP1M2AThzGYok+BHtL9evwiftmKqgrMi+
	2MpBCwI5jwn3SS+2CGwWJvEWss2bPEDo01xBGohSHrQMFnUU+YEsaBQ==
X-Gm-Gg: ASbGncvynPWTqnsZ1jDn/hh/a5ZYVDqCy8w5pP82mYxS/lIClwujDO3PPZqk70aHsln
	5BaDlxoDrRuYvgN9i3eTlOnk6AQHK3eDmHv0bOLBBV7PVFE8EROoqhxZwM10CrtBtWqwD5gAwFa
	XsGLOnfWju/ysnSxSgNGMtlCIwHphlmBga6Qsc4GdkRUrrXxAmHsecUt8aQnVC2vFwWGJWbB5Zw
	mnnWZPnn9j5Cj4eYvEEECZ6v69a2SJfNAbyGpPdzM/53OW4baPyQhP9G7CEsNQ6DRqJrKyn8U/I
	5lohWxW789aOqFXjD3ymuhp0CKZBH9Fb/zTihlqHTho=
X-Received: by 2002:a05:6000:1a85:b0:38d:e6b6:5096 with SMTP id ffacd0b85a97d-390cc605129mr2312130f8f.15.1740481113925;
        Tue, 25 Feb 2025 02:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjdQiVvavRaSoN9CRp/mwY7qApYqPB49bwDzGzkrUN+Aiu2HiyMMYaSQ12oZibePy8ox8MLw==
X-Received: by 2002:a05:6000:1a85:b0:38d:e6b6:5096 with SMTP id ffacd0b85a97d-390cc605129mr2312090f8f.15.1740481113525;
        Tue, 25 Feb 2025 02:58:33 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca0asm1912961f8f.32.2025.02.25.02.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:58:33 -0800 (PST)
Message-ID: <af7de03d-6d31-4659-b1f0-e571fbc77cb0@redhat.com>
Date: Tue, 25 Feb 2025 11:58:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: hsr: Fix PRP duplicate detection
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, MD Danish Anwar <danishanwar@ti.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
References: <20250221101023.91915-1-jkarrenpalo@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221101023.91915-1-jkarrenpalo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 11:10 AM, Jaakko Karrenpalo wrote:
> From: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
> 
> Add PRP specific function for handling duplicate
> packets. This is needed because of potential
> L2 802.1p prioritization done by network switches.

This is IMHO a too terse description of the whys. I don't see how
prioritization should create duplicates. Please expand the commit
message. A cover letter could help
> 
> Signed-off-by: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
> Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>

Just one of the 2 ;)

> ---
>  net/hsr/hsr_device.c   |  2 +
>  net/hsr/hsr_forward.c  |  4 +-
>  net/hsr/hsr_framereg.c | 93 ++++++++++++++++++++++++++++++++++++++++--
>  net/hsr/hsr_framereg.h |  8 +++-
>  net/hsr/hsr_main.h     |  2 +
>  5 files changed, 102 insertions(+), 7 deletions(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index b6fb18469439..2c43776b7c4f 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -616,6 +616,7 @@ static struct hsr_proto_ops hsr_ops = {
>  	.drop_frame = hsr_drop_frame,
>  	.fill_frame_info = hsr_fill_frame_info,
>  	.invalid_dan_ingress_frame = hsr_invalid_dan_ingress_frame,
> +	.register_frame_out = hsr_register_frame_out,
>  };
>  
>  static struct hsr_proto_ops prp_ops = {
> @@ -626,6 +627,7 @@ static struct hsr_proto_ops prp_ops = {
>  	.fill_frame_info = prp_fill_frame_info,
>  	.handle_san_frame = prp_handle_san_frame,
>  	.update_san_info = prp_update_san_info,
> +	.register_frame_out = prp_register_frame_out,
>  };
>  
>  void hsr_dev_setup(struct net_device *dev)
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index a4bacf198555..aebeced10ad8 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -536,8 +536,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		 * Also for SAN, this shouldn't be done.
>  		 */
>  		if (!frame->is_from_san &&
> -		    hsr_register_frame_out(port, frame->node_src,
> -					   frame->sequence_nr))
> +			hsr->proto_ops->register_frame_out &&
> +		    hsr->proto_ops->register_frame_out(port, frame))

The formatting is quite inconsistent and hard to follow in several
places. I'm surprised checkpatch does not complain. Please align the
condition to the relevant bracket.

[...]
> @@ -482,9 +486,11 @@ void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
>   *	 0 otherwise, or
>   *	 negative error code on error
>   */
> -int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
> -			   u16 sequence_nr)
> +int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
>  {
> +	struct hsr_node *node = frame->node_src;
> +	u16 sequence_nr = frame->sequence_nr;
> +
>  	spin_lock_bh(&node->seq_out_lock);
>  	if (seq_nr_before_or_eq(sequence_nr, node->seq_out[port->type]) &&
>  	    time_is_after_jiffies(node->time_out[port->type] +
> @@ -499,6 +505,87 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
>  	return 0;
>  }
>  
> +/* Adaptation of the PRP duplicate discard algorithm described in wireshark
> + * wiki (https://wiki.wireshark.org/PRP)
> + *
> + * A drop window is maintained for both LANs with start sequence set to the
> + * first sequence accepted on the LAN that has not been seen on the other LAN,
> + * and expected sequence set to the latest received sequence number plus one.
> + *
> + * When a frame is received on either LAN it is compared against the received
> + * frames on the other LAN. If it is outside the drop window of the other LAN
> + * the frame is accepted and the drop window is updated.
> + * The drop window for the other LAN is reset.
> + *
> + * 'port' is the outgoing interface
> + * 'frame' is the frame to be sent
> + *
> + * Return:
> + *	 1 if frame can be shown to have been sent recently on this interface,
> + *	 0 otherwise
> + */
> +int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
> +{
> +	enum hsr_port_type other_port;
> +	enum hsr_port_type rcv_port;
> +	struct hsr_node *node;
> +	u16 sequence_nr;
> +
> +	/* out-going frames are always in order
> +	 *and can be checked the same way as for HSR
> +	 */
> +	if (frame->port_rcv->type == HSR_PT_MASTER)
> +		return hsr_register_frame_out(port, frame);
> +
> +	/* for PRP we should only forward frames from the slave ports
> +	 * to the master port
> +	 */
> +	if (port->type != HSR_PT_MASTER)
> +		return 1;
> +
> +	node = frame->node_src;
> +	sequence_nr = frame->sequence_nr;
> +	rcv_port = frame->port_rcv->type;
> +	other_port =
> +		rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B : HSR_PT_SLAVE_A;
> +
> +	spin_lock_bh(&node->seq_out_lock);
> +	if (time_is_before_jiffies(node->time_out[port->type] +
> +	    msecs_to_jiffies(HSR_ENTRY_FORGET_TIME)) ||
> +	    (node->seq_start[rcv_port] == node->seq_expected[rcv_port] &&
> +	    node->seq_start[other_port] == node->seq_expected[other_port])) {
> +		/* the node hasn't been sending for a while
> +		 * or both drop windows are empty, forward the frame
> +		 */
> +		node->seq_start[rcv_port] = sequence_nr;
> +	} else if (seq_nr_before(sequence_nr, node->seq_expected[other_port]) &&
> +	    seq_nr_before_or_eq(node->seq_start[other_port], sequence_nr)) {
> +		/* drop the frame, update the drop window for the other port
> +		 * and reset our drop window
> +		 */
> +		node->seq_start[other_port] = sequence_nr + 1;
> +		node->seq_expected[rcv_port] = sequence_nr + 1;
> +		node->seq_start[rcv_port] = node->seq_expected[rcv_port];
> +		spin_unlock_bh(&node->seq_out_lock);
> +		return 1;
> +	}
> +
> +	/* update the drop window for the port where this frame was received
> +	 * and clear the drop window for the other port
> +	 */
> +	node->seq_start[other_port] = node->seq_expected[other_port];
> +	node->seq_expected[rcv_port] = sequence_nr + 1;
> +	if ((u16)(node->seq_expected[rcv_port] - node->seq_start[rcv_port])
> +	    > PRP_DROP_WINDOW_LEN)
> +		node->seq_start[rcv_port] =
> +			node->seq_expected[rcv_port] - PRP_DROP_WINDOW_LEN;

I could be too sensible, but the above really hurts my eyes;) something
alike:

	u16 seq_exp, seq_diff;

	// [...]

	seq_exp = node->seq_expected[rcv_port]
	seq_diff = seq_exp - node->seq_start[rcv_port];
	if (seq_diff > PRP_DROP_WINDOW_LEN)
		node->seq_start[rcv_port] = seq_exp - PRP_DROP_WINDOW_LEN;

would be better.
	
Cheers,

Paolo


