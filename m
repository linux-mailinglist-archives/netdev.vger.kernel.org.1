Return-Path: <netdev+bounces-299139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xjaoAKErLmo9qQQAu9opvQ
	(envelope-from <netdev+bounces-299139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:18:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A0680587
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:18:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Lqssxb8S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299139-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299139-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D864A30015A3
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 04:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63CC21638D;
	Sun, 14 Jun 2026 04:18:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A7245019
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 04:18:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781410715; cv=none; b=hJCoMe6uCqCAYYArxkU4zMyXO5SgkS4fxuFk+wCpvjvQWTmQ0JWhMlDnYOQMnm06tgLgx6M/OzrKelXwFSIWtDAeRxASfa4FQlZ3A+txbYYJiVWSenCbOmSIJtXPssle8uiIann9iz7GYncXU4BFy512m1F8ORPF90a8PmRaiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781410715; c=relaxed/simple;
	bh=ge2Wly4lQzx+cVn0t29ATnqCbhqW6JZ4+KUkawXqZ/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfKaoyQk9/CxPF+mfGGr0Dv9Jvq/l0SQ2zmZJESTQCLcboSS9N28gvLYCqMIwS6tGWE1lznxHuFblGZ03QizQvs1U0uOXuyTefghkspTsIWlPqbHCwrbxi5He++PK2QkkkZxuokvLSqZaEQBNHdtWJwLsijrdAcXutpr8e47Z8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqssxb8S; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c27fc587ebso9304485ad.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781410714; x=1782015514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10pdjtqw1/JtUy9GKEnuwFPnC7XgoLYsseAIedRShWU=;
        b=Lqssxb8SVYxUI0DuiKDuPCEwu9EXY6WaUUQ0GgWMAJiqwmto8Xr/29ZrBbmpxMkql8
         ztYgUQTAPqwo5lieyBl+6kU70cVHX6n16hVXk+sTrfTog9EUOMSqRhR7YD1ghVVAp0eC
         fykwRFGkRSf552pmiQzf+LUByG23bSVva7KO6lNodt3/nFBq5GupDYTr767083gIajeT
         2xSglSpydOymyj3tzeb7D3PLgPR63wX5BhepNvLZF1q03QdYcVTbehA0Af0PXfpwzp9+
         VvOcFT+NNK2df4PRRd/XlJnUwpkzhTHo/xLiG8kuDgjAakGvoWslktKEN93GTWueS/GI
         xTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781410714; x=1782015514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10pdjtqw1/JtUy9GKEnuwFPnC7XgoLYsseAIedRShWU=;
        b=cIv+xGPGHroWnIf3gfukkiUs6HWppNlm3v7oVHc8w/Oe+TKfarAGMFhhXFWBBtqjXU
         eW4ejiJHQ/UUqrJ45i8xLnjEvByIEUTf7ziuTC4gh7AFvJZ14nms2Z8F+jSySYLmg7Dq
         6ysI9OMYG/rFO6cjHugtFD19Bta55/lm9F8IDczMrwyUKlNNdK+VsqxJU3SX8ERgeavJ
         85Ge66idvgTocCCDCoZ87JGjSGia2wgryY4DkRpzgcaKPy40bCw6yiym/vJNvn044NXt
         YU+06T/D6ookZnrMcnnLWdNL8yPC1taH+yEJHhoUwUC7u921DRk1dXosAFEt8vwlQjBE
         /B4A==
X-Gm-Message-State: AOJu0YxmLQMGkkuc+zzmVVCa7eI8eNZILGNEiWPpzsugOUzvchteibfb
	njmQ1++IRR0AK1TbVoyIHbSbuegItCBEPYuV6lGdMjUa1J6SIyHKv0ISO+2QlipJ
X-Gm-Gg: Acq92OFyO6N8JZ4cBZLbWVjFOWiwJlO/g7j9ZSMF6I/JzItXWCX+7ePauPvn/baLvaF
	GmlJLw/GBTYMhjVwS6XDwOD1msFzsfCZc9ac2gHrWRBmYfr3yNVpVOHLUq21MxfLDTOKmKqDpIb
	C//vFi1IeMCJVxKBjyxWRd7yNgyOTC88zyjanURa46lZSOW92TY2qfW3ssCkp0k4hg3PO9K8UgP
	8edLVGupz/MadII71ZJyNwhMfbeapsXFmCnk4phrqKcF4k+vQzD1yG8YufOLNgw8SdENNGhnAiR
	xdPLJoluXl34w3W8ogaUl4jhR1KIG+OAHmtRq6YYo8x8PlbG2hKJkS6ZfmslXjRrsGQ6dwMR5Ov
	kGzxrryMPzu2rVqk/IxTMAErsL9n53Kz39l/H0WSkRM21Rj472BX+U9zmiNDMmRkMpqkVsElRfr
	EkXEwOw6Tx23al4f90zaMTv8YBXIrbBAVi3d/SeTA=
X-Received: by 2002:a17:903:1b47:b0:2c0:3400:5c34 with SMTP id d9443c01a7336-2c4111b5cbemr97182875ad.3.1781410713730;
        Sat, 13 Jun 2026 21:18:33 -0700 (PDT)
Received: from [192.168.89.2] ([115.4.79.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac79fsm57407845ad.45.2026.06.13.21.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 21:18:33 -0700 (PDT)
Message-ID: <f34dfb84-3aaf-4094-ada7-b19e3449cdda@gmail.com>
Date: Sun, 14 Jun 2026 13:18:29 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 0/7] net: airoha: add EN7581 SOE ESP packet
 offload
To: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Christian Marangi <ansuelsmth@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 linux-kernel@vger.kernel.org
References: <20260614040032.1567994-1-hurryman2212@gmail.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <20260614040032.1567994-1-hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299139-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:ansuelsmth@gmail.com,m:nbd@nbd.name,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gondor.apana.org.au,secunet.com,vger.kernel.org,gmail.com,collabora.com,lists.infradead.org,nbd.name];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E02A0680587



On 6/14/26 13:00, Jihong Min wrote:
> Add Secure Offload Engine (SOE) support for the Airoha EN7581 Ethernet
> driver. SOE provides inline ESP packet offload for native ESP and NAT-T
> traffic, with the Ethernet/QDMA path used to submit packets to the SOE
> block and the PPE path used to bind eligible ESP flows. NETIF_F_GSO_ESP
> and NETIF_F_HW_ESP_TX_CSUM are intentionally left out for now and will be
> revisited separately for feasibility.
> 
> This is posted as RFC because the code was originally developed and tested
> against an OpenWrt 6.18 Airoha tree, not against the current upstream
> net-next driver. The original OpenWrt commit used as the source for this
> RFC is available at:
> https://github.com/hurryman2212/OpenW1700k-test/commit/7c1b5e662f7790b3d23ed143beadc1dcbf6d15f7
> 
> The SOE part is intentionally linked into the airoha Ethernet module
> instead of being exposed as an independent crypto or platform driver. The
> user-visible ESP offload control is a netdev capability: xfrmdev_ops and
> NETIF_F_HW_ESP live on the target netdev, and the feature can be controlled
> through the usual netdev feature path. SOE also shares the FE/QDMA/PPE
> datapath, private queues, DSA conduit handling and netdev lifetime owned by
> airoha_eth.
> 
> Patch 1 adds xdo_dev_packet_xmit() because the existing XFRM packet
> offload transmit path does not provide a hook for hardware whose ESP engine
> is reached through device-specific packet forwarding. SOE needs to consume
> the skb, add a hardware hop descriptor, steer it to a private QDMA path and
> return the final transmit status. Drivers that do not implement the
> optional callback keep the existing XFRM output behavior.
> 
> Jihong Min (7):
>   xfrm: allow packet offload drivers to own transmit
>   dt-bindings: net: airoha: add EN7581 SOE
>   arm64: dts: airoha: add EN7581 SOE node
>   net: airoha: add SOE registers and driver state
>   net: airoha: add QDMA support for SOE packets
>   net: airoha: add PPE support for SOE flows
>   net: airoha: add SOE XFRM packet offload support
> 
>  .../bindings/net/airoha,en7581-soe.yaml       |   48 +
>  MAINTAINERS                                   |    1 +
>  arch/arm64/boot/dts/airoha/en7581.dtsi        |    6 +
>  drivers/net/ethernet/airoha/Kconfig           |   13 +
>  drivers/net/ethernet/airoha/Makefile          |    1 +
>  drivers/net/ethernet/airoha/airoha_eth.c      |  668 +++++-
>  drivers/net/ethernet/airoha/airoha_eth.h      |   40 +
>  drivers/net/ethernet/airoha/airoha_ppe.c      |  606 +++++-
>  drivers/net/ethernet/airoha/airoha_regs.h     |   16 +
>  drivers/net/ethernet/airoha/airoha_soe.c      | 1896 +++++++++++++++++
>  drivers/net/ethernet/airoha/airoha_soe.h      |  126 ++
>  include/linux/netdevice.h                     |    8 +
>  include/linux/soc/airoha/airoha_offload.h     |    5 +
>  net/xfrm/xfrm_output.c                        |   11 +
>  14 files changed, 3342 insertions(+), 103 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-soe.yaml
>  create mode 100644 drivers/net/ethernet/airoha/airoha_soe.c
>  create mode 100644 drivers/net/ethernet/airoha/airoha_soe.h
> 

I noticed, after posting this RFC, that I forgot to include the
following trailer while preparing the latest patch series:

Assisted-by: Codex:gpt-5.5

These patches were written and tested with AI assistance, although I've
reviewed the resulting code and test results. I'll include the trailer
properly in future revisions or submissions. Sorry.


Sincerely,
Jihong Min

