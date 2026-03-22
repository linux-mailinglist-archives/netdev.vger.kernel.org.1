Return-Path: <netdev+bounces-270298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPvtA1GWv2k36gMAu9opvQ
	(envelope-from <netdev+bounces-270298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 08:12:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6973A2E87A5
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 08:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D89033010B8E
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A2136494A;
	Sun, 22 Mar 2026 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQZovMMh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D01A6812
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774163503; cv=none; b=VafpYoKIe2DoK+KdVP4fgNcyWiIb8z/sJz7DIVWNzygwuDQ6xcuRJbB9U/mtBs8txP4TpM9uREF0JqCAgz4jziLlwR225wOz5IrFkoG28/r/vO05VNPZh61H8GK6ML2cUPXkA1JqHWibDLg03BKrZpzoiheXQN05mx45WlzOh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774163503; c=relaxed/simple;
	bh=Kuu/KCtElsU7pIeBSMNLm9DwMD7pPN5VzQXIuJI7N1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnayWx5CtmWZGXiO6XwnvRFljka+e0jjGD75n2upVs6eL8ePlQ1TbcIZwauGVE+oOP86/Vu6nrGNt5IaRW3tAxbufl0zLCQ9FuASEPTjLJ6B6Qkj3Rp94qVHEM5RK8vjccZcSnKMVK2WfN8AQTJbDzm6OrKNqgXNvPF3YfT5CI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQZovMMh; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c107ef474fso3161635eec.0
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774163502; x=1774768302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGAsPQktqc4FZugs1UeRZbzQYPPz69mZ+0Bu64YRsnc=;
        b=CQZovMMhMwc7n/a4Pm6jdkuItzq3bOZ0CCzMlTeB/AoBTKA32VaVWpXfiRJBIF+Sn0
         ixTWYEOHbsmEW/XJFgaMzbc71jfNjXpj89Bwi1D3U50zWn1N4m3iKzfEokRc8LmXgJ0f
         2Kl1LKHSvak66OlKVTJBWIoUmxlaksE3KQI5mdizLhTwR4KewkHu3BxlHAwUxm5cbqzZ
         9xnoSmgwsccaVQmMViKdigerrpEeBiO0HNj7Vzhue/SMnnt3VCZFQUVAvj8DLA8/xXcU
         Gc86spC5QL8AVsxtiJZJyIESbFGs1h+utOQZcnO0lQEIB/bQmH5FQtdSD9ePNVMKdl7U
         eXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774163502; x=1774768302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGAsPQktqc4FZugs1UeRZbzQYPPz69mZ+0Bu64YRsnc=;
        b=E3w7lZJD8T0KHjeHZ/vNaUBNxQsSWgmlFGbDVz/36wHwph6vvVcM8WWj3G1eVn9L3v
         zjGGZvLKfsBiIku7u5sSy6GgvDEkMAzbPk95y87yM3mqZSb1fEh7mRLRBRRSqOeNVOOK
         q3y+pBPKQR+kXfecj8ZlooMqiPk0QecOMPuw01UhqKnZP6RA3AkaoNwBVkWMED9ClLlX
         gIZirfCAIsGu79Bs4q+qlP4ra2M/FCAihnZD+cUBcQUShHzsPiobQVc8u5bDjkueH7du
         T5/W/zrnWuqIA6Wf0MYuQ3DTdYQz582gW7saqW/DrVEtOwfxGI/kNr/VipSHHaoqc1UQ
         AxNg==
X-Gm-Message-State: AOJu0YzgRf6DV1PByd1NbFAY4e/MaN+fI3T37GWDeCxKppTli3lcDj8G
	+Um7kutJtVhYsjbqZt6eBixSGzU6a3T3DKpNFk2NHnsFF9M5suTjpIj6
X-Gm-Gg: ATEYQzwsTbhclNI71xodvyTmINzC11rZBxJtNaU210ydrcamPXjy0WByleXq7LzEN6B
	xJsP4L4H6dH5Md8f7CkqK2LdepoiMjSyid6qFmMsIO9/4CDWi0pOqmTfTZva/XDsT6oFSQxjR1s
	jQAYZ83DXVqblacSmis0DP7DR0OmO2ewhoRNrHtJN68v+erS+CCxc+z6K6akoCaETrWdbxaP3hy
	E30hKzwY57Pk4lFCpaNtTCN3SkUOZvxMLE55rU0EN+QYTl2zUF/5aOZL2RMfCkYY2Rc5PasmDaT
	D4WkiiDR+BB/A/i4Oh3T659i7bIlay7AEqd9ASntGZYREsn2ThBXWqLxTdU6IBT86zdwAj94HfF
	1k+o4BoU8DP31o4mdRLapBA0JNEC1pSdj69MsPhMqKDoAl4GGFKhkY02eGoRTHkfJwz8ckEesOz
	I1t0VY+SvoibqW/ZZII5u+Q56xZFMvxtZ9RoRnMC8F05K3GXiOv5pMCChZePQh
X-Received: by 2002:a05:7022:2227:b0:128:ce44:be8f with SMTP id a92af1059eb24-12a726572c7mr4140330c88.2.1774163501581;
        Sun, 22 Mar 2026 00:11:41 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::1129? ([2620:10d:c090:400::5:dc02])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14bac4sm12191223eec.4.2026.03.22.00.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 00:11:41 -0700 (PDT)
Message-ID: <ab2f788b-7214-4aa6-bfca-b33d3ab37321@gmail.com>
Date: Sun, 22 Mar 2026 00:11:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/10] net: lan966x: add PCIe FDMA XDP support
To: Daniel Machon <daniel.machon@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Herve Codina
 <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
 <20260320-lan966x-pci-fdma-v1-8-ef54cb9b0c4b@microchip.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260320-lan966x-pci-fdma-v1-8-ef54cb9b0c4b@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270298-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xdp.data:url]
X-Rspamd-Queue-Id: 6973A2E87A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> +			       u32 data_len)
> +{
> +	struct bpf_prog *xdp_prog = port->xdp_prog;
> +	struct lan966x *lan966x = port->lan966x;
> +	struct xdp_buff xdp;
> +	u32 act;
> +
> +	xdp_init_buff(&xdp, lan966x->rx.max_mtu, &port->xdp_rxq);
> +
> +	xdp_prepare_buff(&xdp,
> +			 data - XDP_PACKET_HEADROOM,
> +			 IFH_LEN_BYTES + XDP_PACKET_HEADROOM,
> +			 data_len - IFH_LEN_BYTES,
> +			 false);
> +
> +	act = bpf_prog_run_xdp(xdp_prog, &xdp);
> +	switch (act) {
> +	case XDP_PASS:
> +		return FDMA_PASS;
> +	case XDP_TX:
> +		return lan966x_fdma_pci_xmit_xdpf(port, data, data_len) ?
> +		       FDMA_DROP : FDMA_TX;

What if the BPF program modifies packet boundaries (e.g., 
headroom/tailroom adjustment)? After bpf_prog_run_xdp(), xdp.data and 
xdp.data_end may differ from the original data and data_len, but 
lan966x_fdma_pci_xmit_xdpf() is called with the original values. 
Wouldn't any adjustments made by the XDP program be silently lost?

> +	default:
> +		bpf_warn_invalid_xdp_action(port->dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(port->dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		return FDMA_DROP;
> +	}
> +}
> +

