Return-Path: <netdev+bounces-171549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BA9A4D8C5
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDB03B00DE
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DBC200126;
	Tue,  4 Mar 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+IKMAdH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE41FFC7D
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080669; cv=none; b=ULGlTFJS9TxVoF3lHfONjVVaYpecS0B0wDkppDH/HYu+rDyLWsYewc8BUPGnWC6730mydRv9xzoDwDGhXOyL6jKxhlVq3rRB1zclXah8GrccYrBc0D6wChYCXDr7G/3Bj5nal4mdOjGZrdgrWQKvISL1iW1S4u7gVxAYh8zWqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080669; c=relaxed/simple;
	bh=KfgdtkUe9Ld3YiFZ+5uLKSPVI/DPDNsZowoXD930AZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYVmwsPnkdBEwFTFfbQly45AZZCP3VOW5MrKg1sTDDl44nzG9w0C9++Vu6BMlVVB6PTBXOAivIGLrJrfY5z38QjbhpIQb9/Sr+Z0W1SrlQM6OHtaDvqBca3Y7VBop7y7R/ZgTHXVl2KbzvKsg2Mw5xImz7i+Oi4j86hfKN+O0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+IKMAdH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741080665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZMdD5x7r0Q82/d4L8C6y43uagkDVSSt8m6qokozWb4=;
	b=H+IKMAdH95gl/c63I5ZvBGfCUC4Zu0ZrqGKippzOnewb3YPyV8vEihToE0alZJ7O5m14ot
	9mPPnOwLwj+47AhFDXzEz709lj2WHLBTca+0mtwE/BSzYVJeIGcy54qn6hj8XrO+TYi0eI
	lnwZv+8SlRConInxIfSsPA6xfMZck4A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Q_j5cdG8O2uhEXwY8x24Dw-1; Tue, 04 Mar 2025 04:30:48 -0500
X-MC-Unique: Q_j5cdG8O2uhEXwY8x24Dw-1
X-Mimecast-MFC-AGG-ID: Q_j5cdG8O2uhEXwY8x24Dw_1741080648
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bc1aa0673so9139625e9.2
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 01:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080647; x=1741685447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZMdD5x7r0Q82/d4L8C6y43uagkDVSSt8m6qokozWb4=;
        b=oTyeJ+F4Bk9Qg4jio7o9dnfsZ8ZYK2Mjw0rDsc8n2XGVJuj6K797Y1kahR5427mduS
         vPOnyIUAo+VInLr7qWKQpLEeL5CnhZ+brgVNJahk79xu834rhKFelmgGlVJ9eVLgT4tH
         wlK0a6acGXCcFDOBH9JWWdzX5TqBeWBcJAMdmTJIzKw3v5pxemWjY/ebfN4IKSfwchZC
         f+RWLVhb1nxWVtjYoJRlrxFNXzG/gP2sf/WUKI00l2PgnL37eRsck98GRDFueE5bw+CI
         RDhWvvMes6BQ006tktw7qKxyTXSoOVKbHDs0VcqQZ27w/V2vh1CSx2tfYg9CMgB/AEn0
         BKEA==
X-Forwarded-Encrypted: i=1; AJvYcCV+8Ey4zjN5I2gXC6lmJgtshezuprPkvgAr7U8OdAOnXtqRUBoguI9pxNbesf7/PM1tlrdovLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Xf0bDxtiWmm2gM9egyf8r6cKL2qJTw7PEzzCROSMSq5nu0k0
	9e4GMsz8JPWtEblps0RVyhPyH5HKp+ZmD59qjUdO1KUQqt0QWf1ifSJksC/7GiGAY0SeFf5EstC
	3H8sNhG2ahPIjnof48Tp63VLDPH0kRMd2mkqM6md0PIWn9hMVaXZz2A==
X-Gm-Gg: ASbGncsc7jMtZOj7o3VHgS4nMg4qOdE5ntIBCRDL5nZp+M+zNsGYPZob3HNMMzlh3OF
	59jtRewLrTO1U8eL+1KhRLmJfiAHV5FYsJI4t4Z5MZDnTqz7rrAods3TUByvjPWfcR4UA6QDcgw
	TTIeex5B6YqCn03hba82JgAbNbuMgfd2jlR5LzmacFR584XuTxkl0wd98HjArXHUbw8Q+CvnqAl
	+kDi2HKFAQOhU95dAGffjeh9h/pD+rtPb8o0RRuVI/Cvv2ediBTIkx5R94yDxFxgWXVYiJaCrWV
	jO98lONBMpJFRhfpsR2b1k8NHQKf2oN6VMmEDDHoRPU9kw==
X-Received: by 2002:a05:600c:1c95:b0:43b:cad1:46a0 with SMTP id 5b1f17b1804b1-43bcad14869mr20550935e9.14.1741080647552;
        Tue, 04 Mar 2025 01:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwVGJhG3LClhBH2gAIqvGg6sSkPzRuS7dTplCKfBFEiuEd9NOsvF6NXcj7TUVWOSoUqn5vfw==
X-Received: by 2002:a05:600c:1c95:b0:43b:cad1:46a0 with SMTP id 5b1f17b1804b1-43bcad14869mr20550575e9.14.1741080647161;
        Tue, 04 Mar 2025 01:30:47 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc732b6bsm13453975e9.21.2025.03.04.01.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 01:30:46 -0800 (PST)
Message-ID: <7759fdfb-1aee-4a62-a2fb-33a22150ca9b@redhat.com>
Date: Tue, 4 Mar 2025 10:30:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: hsr: Fix PRP duplicate detection
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, MD Danish Anwar <danishanwar@ti.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
References: <20250227050923.10241-1-jkarrenpalo@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250227050923.10241-1-jkarrenpalo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 6:09 AM, Jaakko Karrenpalo wrote:
> +int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
> +{
> +	enum hsr_port_type other_port;
> +	enum hsr_port_type rcv_port;
> +	struct hsr_node *node;
> +	u16 sequence_diff;
> +	u16 sequence_exp;
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
> +	sequence_exp = sequence_nr + 1;
> +	rcv_port = frame->port_rcv->type;
> +	other_port =
> +		rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B : HSR_PT_SLAVE_A;

I'm again surprised checkpatch did not complain WRT the above. Please
reformat it as:

	other_port = rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B :
						  HSR_PT_SLAVE_A;

Also, please address the other things mentioned by Simon.

Note: you can retain Simon's tag in next iteration.

Thanks,

Paolo


