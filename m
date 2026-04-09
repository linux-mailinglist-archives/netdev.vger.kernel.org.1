Return-Path: <netdev+bounces-276876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPLKLWJc12kCNAgAu9opvQ
	(envelope-from <netdev+bounces-276876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:59:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D303C75F5
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72137300A59E
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048B3876D5;
	Thu,  9 Apr 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx7MZtNQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DEB3876AB
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721554; cv=none; b=o2saNjrSXnJ0Wfd7lLI/wlC/zEpUEMyFWb44+bnjJNb+xUZi5m55LO8002lws8SBXEu0aJnArc8fAHsqXtiSiykyntHOonf2OIVIpvhI6CuULuryce4i6RQ8RZ5k9aYBsLzOfrmJz4Qnw/GOyY+dMSkTBYzJrTJ1S0TLxkW7+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721554; c=relaxed/simple;
	bh=OycfU7u+U/NNYT4DdlI9EJeDZgT32WOWQNZ8vocbWHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKjWGDYHerfM0vHfw4yS+BsRKTRQgWOG5sMJ8X+hDhsOboy7zOk2PTZ2vqq4wehrQIae/Ij3nO+DCPFfLZMXTtwfCsy1Rm/euVb6w0ZAtH7/3QtWNGyF92BoQnLHe1GOrmlcbNbf4dQHaaOnil9l1HbVmuycV+aghh1MCk7MtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lx7MZtNQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775721552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRrmBnYMXTNU9GdbPVrYhlAGHmJY6Atzwlyad3mHaKo=;
	b=Lx7MZtNQFsW99xoUvOuNdOwD0xWLwEHJ7nuPvtMeaBwDlJ1W6b760JbP0kWcffrrIJV2zc
	Lglyy+MbDi1DnOroZ+JY1HMEiw0KRymK0G5VtI7iPF6WEzOt3VzK8pvDz3g174RN2uZOsI
	sQvcF0qnic/ORZQz/J+LHEGCWD71wgE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-g5s87ZHXPC6VOWTzEJ9IvQ-1; Thu,
 09 Apr 2026 03:59:09 -0400
X-MC-Unique: g5s87ZHXPC6VOWTzEJ9IvQ-1
X-Mimecast-MFC-AGG-ID: g5s87ZHXPC6VOWTzEJ9IvQ_1775721546
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97A9C1956095;
	Thu,  9 Apr 2026 07:59:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.181])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 952271800357;
	Thu,  9 Apr 2026 07:59:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: luca.weiss@fairphone.com
Cc: pabeni@redhat.com,
	krzk+dt@kernel.org,
	akoskovich@pm.me,
	konradybcio@kernel.org,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	andersson@kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	linux-arm-msm@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	robh@kernel.org,
	edumazet@google.com,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	elder@kernel.org
Subject: Re: [5/6] arm64: dts: qcom: milos: Add IPA node
Date: Thu,  9 Apr 2026 09:58:54 +0200
Message-ID: <20260409075854.308955-1-pabeni@redhat.com>
In-Reply-To: <20260403-milos-ipa-v1-5-01e9e4e03d3e@fairphone.com>
References: <20260403-milos-ipa-v1-5-01e9e4e03d3e@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[3f40000:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: B6D303C75F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
arm64: dts: qcom: milos: Add IPA node

Add the description of the IPA block in the Milos SoC.

> diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
> index e1a51d43943f..a244e136a877 100644
> --- a/arch/arm64/boot/dts/qcom/milos.dtsi
> +++ b/arch/arm64/boot/dts/qcom/milos.dtsi
> @@ -1281,6 +1281,50 @@ adreno_smmu: iommu@3da0000 {
>  			dma-coherent;
>  		};
>
> +		ipa: ipa@3f40000 {
> +			compatible = "qcom,milos-ipa";
> +
> +			reg = <0x0 0x03f40000 0x0 0x10000>,
> +			      <0x0 0x03f50000 0x0 0x5000>,
> +			      <0x0 0x03e04000 0x0 0xfc000>;
> +			reg-names = "ipa-reg",
> +				    "ipa-shared",
> +				    "gsi";
> +
> +			interrupts-extended = <&intc GIC_SPI 654 IRQ_TYPE_EDGE_RISING 0>,
> +					      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH 0>,
> +					      <&smp2p_ipa_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_ipa_in 1 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "ipa",
> +					  "gsi",
> +					  "ipa-clock-query",
> +					  "ipa-setup-ready";
> +
> +			clocks = <&rpmhcc RPMH_IPA_CLK>;
> +			clock-names = "core";
> +
> +			interconnects = <&aggre2_noc MASTER_IPA QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &cnoc_main SLAVE_IPA_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "memory",
> +					     "config";
> +
> +			iommus = <&apps_smmu 0x4a0 0x0>,
> +				 <&apps_smmu 0x4a2 0x0>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			qcom,smem-states = <&smp2p_ipa_out 0>,
> +					   <&smp2p_ipa_out 1>;
> +			qcom,smem-state-names = "ipa-clock-enabled-valid",
> +						"ipa-clock-enabled";
> +
> +			sram = <&ipa_modem_tables>;
>                                ^^^^^^^^^^^^^^^^^^

Is the ipa_modem_tables label defined anywhere? The Device Tree Compiler
will fail with "Reference to non-existent node or label
'ipa_modem_tables'" if this label doesn't exist.

The sram property is optional according to the qcom,ipa.yaml binding, and
other similar Qualcomm SoCs like SM8350, SM8550, and SM8650 don't include
this property in their IPA nodes. Should this line be removed, or does the
ipa_modem_tables node need to be added to the reserved-memory section?

> +
> +			status = "disabled";
> +		};
> +

[ ... ]


