Return-Path: <netdev+bounces-262647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJL1K/qLpWmoDgYAu9opvQ
	(envelope-from <netdev+bounces-262647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:09:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 526DB1D9800
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91BC73003632
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A153B52E1;
	Mon,  2 Mar 2026 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="I49+4W+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F26383C6B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456952; cv=pass; b=Mg8I27vbG6TWSIuL8MI+YgUR3YyFfLfjjPDBo5GLbp4dEkddf53SgaunRlPwjUndHaU86cPjEx8KIZIn0g78wTtouyQya4UgqJLiXSXu4OoPwgQb0Se1SRk9bOxxMoTYfhinFnT3ko6J8v27nF/3EpmELuwEUukIUFMkzOxBiU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456952; c=relaxed/simple;
	bh=AXkmsR7ZBoHxpbOwLmqOU+xWVUc36k5CuxoMdy/D9aw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5DYgp8g7IKhs81FMLFJr97EAwp1pFPtsDoJh1Dh6MJyjWf0w6GkIo8oRo+fieO40D5lQiSH4PqciC2LMyIP54H8eM0cjzwux7UIc7qiDW0E6xrXxrSxuX+KJ0g0oYf3IC8GifAmvhnyCvyhq6qnH7NegcB/AjRfDaiRwDK4s6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=I49+4W+A; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ABECD40006
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 13:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1772456942;
	bh=/ECnSn+s6d8RzhavbIFJQEnGNDdcB3vQZ0KecCsizik=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=I49+4W+Ab2x+4ZdPUFs9STW9xcFgMw8YgZgl8zxAIbTWXOdvF0wfhvEZ/MxTdIzRg
	 K/md4a3aLpI/F9LYncSvlnHi2BUXprfB7g2B4+NbcQK8AWmDL7Wv1MdhZBDzx5+Bhd
	 KLn9tfiIg9BBHsWkqpIkQPGArAnE+sJRhA7/MhwMnbVPOpAuz9bBnl0AZcx0byDrRR
	 Nkfr6V5usv4p7KzItQvE1hKGHeu87zIW7tZG5rzvmYOvGZT7T1Icyz4m0fdexBS8wQ
	 /SEEB7Ppk42UUx0UxfgGZY+PVmP/35dkFuEa3QJmRuytNXSBArv74HQhYqHs+L/fdI
	 ZuIhidBmppOcMpK4cQvxqzRxtTUWgeHTe+RJLeyDw2XXlLLJEMTwBuXIlvEKhhSI7X
	 ifjtKO0v5ovCTkUKf/i5rx+umDz6aY4ytU4e0Rq2SYu4VUWC3/4RuZdRO+mDWRmza0
	 +OF9Rc7TwR9utGrIDSJSCG5Rf9bTOI1dv6BQmUxTgnvRw/radfJeLdM7nBEAlCApV5
	 YP9WYPUUAzRulEE0lrTOpDpZdV40JJSLgXrcIuNBhRO2mUFda1uUEGmiZP8etWrZ0u
	 Msp5OX0wCrHsRTPMe5vgC+UcvrfcPPpsA6pHGD4SzLygD1ja4k43i7G1j5HO07IOMR
	 jBNQpyPH0gNcGbH1I9v3M6Ac=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b936b6b4473so418881866b.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 05:09:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772456942; cv=none;
        d=google.com; s=arc-20240605;
        b=JbMmBLOTxKd4h3BqeS4/YboJdAVMS0uz8sOgUaf2wr3Pml1iif+KAYTnVu5MvzOZId
         PBURP+mNRYsBaWUUHNfIpHMp/MKXvKwDXKmK/rBYee97/xZGx/gkO76emyyjaI6R2/I1
         JKpEpJWVcFeoaZcfJFKjrjBujqnaMz1DVmutY/7U/u3zwepICWvrMyGBV9a7zavhNXoq
         q8RJk5Gp1QZ+xDaPqPeIWw941OAzabueDNsQWM08taSYpp6cfbZCYHtly4Dtp8hDSplN
         AwicVQFHzcsYh4bU4LVVq1u4KOVFSFm4RaNZF12aCZP8YH+52b8BKCeF0tNwfJLIBFI7
         Hp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version;
        bh=/ECnSn+s6d8RzhavbIFJQEnGNDdcB3vQZ0KecCsizik=;
        fh=t6564fCwgO+aMrZYqmAlo9yi38hgatjrdVJKFIKZAuE=;
        b=jUOKOujokWyuU4n5uYNnBD8/VN+IfOxIwoQAEzrrCiAcg5vdc84TyViFYBomDgZ/Ic
         DdSCYD5DeTNKmABp20c3bU7tOZ48tsdAWgLNHNMoEj4NrG88pFw7PzUVe90CThIt1BeS
         8Z40IyKYF5DnOfhjvFrcF7rKv/6qrPpt2eHa5prtri9qZ1UuEdf3wUysobgPk2+7uOOd
         rPArZvCKQu6465LT4sYFVRu+LC4R4Nx5NODQbvkXuB4408SQ5i5O1cbG5dH9HzdBPaq1
         Ol6AlFJRjzKlK4n/f0vG4Om2BcLgtD/V/xT2bFwYHukniPe57sU927SsIWElWi1BVsUC
         /Anw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456942; x=1773061742;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ECnSn+s6d8RzhavbIFJQEnGNDdcB3vQZ0KecCsizik=;
        b=T0bSb9YTg7YlsQABaIwZ1UJ5rOurcplDMQS9MQXzkIv6ymVF16WulAmVkEkBpCMHWo
         DJn7BMP37H8Dep3zLBrT4VIm98iBQjSXMqswf+isKPfxCQzekBplU4eeVO1vzCRuYpPK
         eYIqBBJzRFLklRHq3c3skd2egGIK+AwbY1bl+0k9Na9UZffXqUxYkCUz8UMU8Qy9bseO
         ZdpfIHJzuDkxUKhxKsdPEMM0Q2l3MolIWwhZodbjELZvu1CU3ySvx6X+a4FDqIg02aVv
         NEhr3ssY8eFeqdsZn2xXu7TcRzMlC3sn2D07sxxOnKdLJ0WgIqe40OSuwXZ26VHIvyJp
         8Qog==
X-Gm-Message-State: AOJu0YxdFUDu4tSuBPUWXWcIbrfZytHottw+VwRUxqzwHTJCAW+fOi8q
	rhkbXmqDubq9HhZ60Ce3ANUf4leEVI8ba8ww8qCkqNYz2wVHYkdMHS3TpoRVQZpyfoYsd1KnwJV
	zVW3t7PwwquMcbm52CwHf76NA9/tW4Apr6ko6CBWEme6cH4dHYlJ4+7iSE7xMvHoh2+ZVEiqBYD
	lZw+9KcQztCWHqqP3WW5u2XgJOv3g2nq9Tgtm1TMwcgoUnxv1q
X-Gm-Gg: ATEYQzx9AfbU9yUxOnDOkaX6oq9g1Whz3Qd2EBz6okk1lHkQOqay9k9JweG3YVKe106
	KphWyKoc/vQCK2vx1B/KMnP9OqyAIIv9Nwsep1qLvEW7EHkoihCDHTFsMcPfcCOGLXlNtrWrbVH
	8WBTHaiaXaG6W4M/4CSQoDRIV2rSDAKzUjVAkKY9i/eDE0O4AaA94sYcooguNcRWKmUDyTpC9Ii
	0T6
X-Received: by 2002:a17:906:9fc8:b0:b87:efa:8786 with SMTP id a640c23a62f3a-b937657d99fmr789094266b.55.1772456942091;
        Mon, 02 Mar 2026 05:09:02 -0800 (PST)
X-Received: by 2002:a17:906:9fc8:b0:b87:efa:8786 with SMTP id
 a640c23a62f3a-b937657d99fmr789091166b.55.1772456941578; Mon, 02 Mar 2026
 05:09:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Mar 2026 08:08:59 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Mar 2026 08:08:59 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260227075718.2243818-1-inochiama@gmail.com>
References: <20260227075718.2243818-1-inochiama@gmail.com>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Mon, 2 Mar 2026 08:08:59 -0500
X-Gm-Features: AaiRm52b-jdW2UNX8CSDWuKrreJ-aGAWnKXn668LfKMnXa2Ks1b4qAF3c1WKw8E
Message-ID: <CAJM55Z_soPhC9P03edfq_A-GN07PbGqu31aHgE_5kKhkQwkMmQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/3] riscv: spacemit: Add ethernet support for K3
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Choong Yong Liang <yong.liang.choong@linux.intel.com>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	Yanteng Si <siyanteng@cqsoftware.com.cn>, Yao Zi <me@ziyao.cc>, Yixun Lan <dlan@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262647-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,canonical.com:dkim];
	FREEMAIL_TO(0.00)[armlinux.org.uk,eecs.berkeley.edu,ghiti.fr,foss.st.com,lunn.ch,altera.com,kernel.org,linux.intel.com,davemloft.net,google.com,st.com,gmail.com,synopsys.com,bp.renesas.com,bootlin.com,dabbelt.com,redhat.com,cherry.de,eswincomputing.com,cqsoftware.com.cn,ziyao.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.renner.berthing@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 526DB1D9800
X-Rspamd-Action: no action

Quoting Inochi Amaoto (2026-02-27 08:57:14)
> Add initial support for ethernet controller of the Spacemit K3 SoC.
> This ethernet controller is almost a standard Synopsys DesignWare
> MAC (version 5.40a). This controller require a syscon device to
> configure some basic features, like interface type and internal delay.

I don't know how we can accept this when it can't be tested since it still
doesn't come with the device tree nodes. If you don't want it to be part of the
series, just share a tree where this code is working. There are plenty of free
public git hosting sites available.

/Emil

>
> Change from v4:
> - https://lore.kernel.org/netdev/20260130022705.1059214-1-inochiama@gmail.com
> patch 1:
> 1 Apply Rob's tag.
> 2 Adjust clock description according to Russell's suggestion.
> patch 3:
> 1. Add set_phy_intf_sel() and get_interfaces() hook, suggested by Russell.
>
> Change from v3:
> - https://lore.kernel.org/netdev/20260128072931.875041-1-inochiama@gmail.com
> patch 1:
> 1. fix the uncorrect compatible string postion
> patch 3:
> 1. add "CTRL_" prefix to all ctrl register definition
> 2. only use delay config 0 to calculate delay code.
> 3. fix typo in the comment
>
> Change from v2:
> - https://lore.kernel.org/netdev/20260121071315.940130-1-inochiama@gmail.com
> patch 1:
> 1. remove not needed compatible for select
> 2. drop empty line in "spacemit,apmu" properties
> 3. add spacemit,apmu properties to required.
> patch 3:
> 1. remove misused phy_fix_phy_mode_for_mac_delays.
> 2. use local tx clock instead of the clk_tx_i in the dwmac.
>
> Change from v1:
> - https://lore.kernel.org/netdev/20260120043609.910302-1-inochiama@gmail.com
> patch 1:
> 1. remove phy clock
> patch 3:
> 1. improve comment and include something special about Spacmit K3 dwmac
> 2. reorder the included file
> 3. fix wrong delay macro used in spacemit_dwmac_set_delay.
> 4. add check for maximum supported delay.
> 5. use DIV_ROUND_CLOSEST to calculate best delay configuration.
> 6. use assign for the ctrl register initial value.
> 7. fix input when calling of_property_read_u32().
>
> Inochi Amaoto (3):
>   dt-bindings: net: Add support for Spacemit K3 dwmac
>   net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
>   net: stmmac: Add glue layer for Spacemit K3 SoC
>
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
>  .../bindings/net/spacemit,k3-dwmac.yaml       | 103 ++++++++
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 226 ++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_platform.c |   1 +
>  6 files changed, 345 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
>
> --
> 2.53.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

