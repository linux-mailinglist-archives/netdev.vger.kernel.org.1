Return-Path: <netdev+bounces-259080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC85NKmQlGk9FgIAu9opvQ
	(envelope-from <netdev+bounces-259080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:00:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5A14DCDD
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61054302F986
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E7B36C582;
	Tue, 17 Feb 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij0ThohW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3F338F52
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344034; cv=pass; b=DKQMh0wN74XaHySz0BOAe00jzNl8YJ9uWyW3dVOiTlZcUQGSCNSiNNOQFMCCUT47CDrv2bs94DraC6pnfon9s+dLASmo5+mS6nQx9a6E/JkFdZKhe1PczQAVE0oejs2wNigu3vQ4eHjh+JYrT6qyYa41VD3JvNUukJxT+yE+Vt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344034; c=relaxed/simple;
	bh=lBO6AhQqWag/0+NNJRZQvsAXIIMwJp6QA15wbRYbOcE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pj1ifApLVcoZkgNoOHCQnuYz3s7y7YVnhbcuWFZp6GJha5hEq1ZJxDCrA/Hk2monPkJxCfPBlQS3QEGy3iZCtXv0qXp5lMWzs7bLASZwHaBp+6AI7OSdxxcc7wbVGayO/fTrqBWiUEQZCxgin9WsIrw4APl58l9hlfEyqoOV3v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij0ThohW; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65a40f3f048so6894211a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:00:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771344032; cv=none;
        d=google.com; s=arc-20240605;
        b=E4otmhU+vp+USEfR0RwTcsMS/AGog5MCxPVBfoufydSDTPYpVVAue5En9vPkcIZV8q
         nVQI9+2sF3yHjAXFum0lceAvT+TVGuEzV7SRLFTu6WL49YiDrz2Sbpm5JIYuiQ5r0on+
         WyOVC9t6DYD6+3M7GabjBrd1oE4wN/GgDF1ZsBILiLsWEiy4J9yrY9FQijWiKNFxVPgQ
         CyugykRwW2c8+6cMeGNbfcKmNPZJJK2FbPGUWRIUcp7/J+cUQUJwAxLCkJMEVnkPsdzT
         +9cOEtm971acLvzQ4MGy2tuQJvoK1npstnYaN/FpmAo8e6ejNdnTWbfcmJa4Pk1KRB43
         WGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:dkim-signature;
        bh=lBO6AhQqWag/0+NNJRZQvsAXIIMwJp6QA15wbRYbOcE=;
        fh=mVkgZq4B7BOccmW0QtQ8ldz+Fp87tkq0mg2GQEVQSs0=;
        b=hbHRVIs+3X9zX3HhDfOgOx61ZP8XsPMMZtKeZM6Lj2ei7pZTD3PyuSBf8rOAEx6U+V
         uh4txH+U3RkaX5o4hIkbNC+eog3UtHHIuYX78E5Vg1mQgTGbZxoiuWB9bsBv7oDFiyKL
         meraHLS44q8v7OY9OYrQ4M8thPPsRD3uqwWQziCmT3K8IFsAGbXOKoLYZvDM/PoYLvvA
         ZcTG+/CQb28IckD7kDS3wEOgP/b8zs4keAqVhtzEjrS6OdHL2Fa7SqaCdaj3gOwwxKsI
         SQvL//7fegUBeONP2odQc8tSzQBIB7RHWMk+Z9jTNRNXcvouqHQp8UtptAwTlZ0A3cJB
         UeOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771344032; x=1771948832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBO6AhQqWag/0+NNJRZQvsAXIIMwJp6QA15wbRYbOcE=;
        b=Ij0ThohWVcfVtsLYIxefYarHxtdzXqbEJpUU4Bk8Tcg9No/tJgnYOlud6elzmm1i6c
         DegqUJHkCGvGpZSsFyt/0ypDxbS6eQolBN4fYvF1i7fc9LKXGj7G+3krEhsTIaKEn0/9
         PnUWSSfjzhtlHSElRTsTajjowbiGvev93gPn7O/SNiCqocgBCl8CL0h+t7JQHVliCtTu
         0YkG+NiDQ5nHuDFhTHYbD48qFcImtBhNCGerGmlye4cqxeMyd2umEC/7elaDbAqcr0S/
         +nFCCb+iZBo3QQQr+7T2loGf8kSykWI7PudqNzAWOkPBDDYxUMK3b2Dg6+aM3YQFN4Ha
         iRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771344032; x=1771948832;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBO6AhQqWag/0+NNJRZQvsAXIIMwJp6QA15wbRYbOcE=;
        b=KjTqN36uUQ3DeReKvFAA9D9vq0ORBupmT8HL4HvT/O8uGvvjYV/8fH80rrTzoxktid
         uAOCDwujX3OOi9xRcN4xL53Sw7+/vyLktoiKngKz90vXbNDwi1b7souJlTqiy4roGJ43
         I7tDDi/MkshhJW6MzDZte8Vu3/h1BZExi5GkHmPZxbHq1Yw4hNGEd3kFOCaUC3Z+aPiI
         MUO0jUXvo2zHC0PeVk5srB22HABJnmhFbOdHX7ftZhKQcDex1uBLaX/bfSsmL9esj1mI
         I9B2RtqjzVaiU0sUsOS5PjP9aBh93I84a8XqEtvKoyckdZ9cFc/Y9FEZR9jr/uLAcsdF
         D4rw==
X-Gm-Message-State: AOJu0Ywn+g+g8sBH7nKdi4QQk3tG/NrXZelRHVkr4loYn94nEXKLfDlY
	Jble3JrRxj0TYiLzf3gMdGeQ+8Mvu/F1K0NhHJywGdlhOz+WCkkqjg/Q40MRxjtZ3yW/3g9/R0y
	mHWArE/pTtokfYsiY3erInMid4hbJvUCqtDr9
X-Gm-Gg: AZuq6aJyFCRVSz1QParevjerBYFm6edao7qZm6906OTOV4xAFq003tbNgYxLXX638pH
	HEjiXtij9frLMbeGTQVSh+T82vNFeuZyTHQrmGOMf+VlwUqxjhEeyODeR7BsoQneJa3KiECs8AL
	hJm97NMjN3O4LUkYwwPdNT3/ts9A0yTgbwOBnTqtiyzsecnNLiF32R7nkQ737DGg80zDHkdiFgD
	v3s7Xf3ShgYFl7hzmTALzcc6MD4eMeMDLn192Q1sawRG1ldDL4D10BwsYDvCVwOY2LlaRuk6woR
	iGpw+Q==
X-Received: by 2002:a05:6402:1ece:b0:659:329a:bc12 with SMTP id
 4fb4d7f45d1cf-65bb13b7f0amr6896476a12.29.1771344031210; Tue, 17 Feb 2026
 08:00:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 10:00:29 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 10:00:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260130022705.1059214-1-inochiama@gmail.com>
References: <20260130022705.1059214-1-inochiama@gmail.com>
From: Emil Renner Berthing <emil.renner.berthing@gmail.com>
User-Agent: alot/0.0.0
Date: Tue, 17 Feb 2026 10:00:29 -0600
X-Gm-Features: AaiRm52I-Ps0aB0W3gGP80VOXo7IKX3SoIAUz1UAML5FnQLUef3qoiKkhjg5t58
Message-ID: <CANBLGczi6o4NwDF0fge0_RZ+TVX2dQ=vYD2PYMSupb5xSnabZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] riscv: spacemit: Add ethernet support for K3
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	Yanteng Si <siyanteng@cqsoftware.com.cn>, Yao Zi <ziyao@disroot.org>, 
	Yixun Lan <dlan@gentoo.org>, Zhi Li <lizhi2@eswincomputing.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259080-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,eecs.berkeley.edu,ghiti.fr,foss.st.com,lunn.ch,altera.com,kernel.org,davemloft.net,google.com,st.com,gmail.com,synopsys.com,bp.renesas.com,bootlin.com,dabbelt.com,redhat.com,cherry.de,eswincomputing.com,cqsoftware.com.cn,disroot.org,gentoo.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emilrennerberthing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7CC5A14DCDD
X-Rspamd-Action: no action

Quoting Inochi Amaoto (2026-01-30 03:27:01)
> Add initial support for ethernet controller of the Spacemit K3 SoC.
> This ethernet controller is almost a standard Synopsys DesignWare
> MAC (version 5.40a). This controller require a syscon device to
> configure some basic features, like interface type and internal delay.

Hi Inochi,

Do you have a tree that includes the dt entries?
Otherwise how are we going to test this?

/Emil

