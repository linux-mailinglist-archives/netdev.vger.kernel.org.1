Return-Path: <netdev+bounces-257214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BPXA+6rhGk14QMAu9opvQ
	(envelope-from <netdev+bounces-257214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:40:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A97CF4287
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9FB73041383
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519FF40B6E9;
	Thu,  5 Feb 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+l0wrVz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wdz2kcVG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BBE40B6D9
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302376; cv=none; b=YvoAZPvp4J00Nn26gVlq+vCIy8/q3anhyVYyrHhKMsIUjoFfLitrEj6RtBljI8bGaskunNTOKZnel0WijRuop2AgkorgBW83VLWfST/NgjVSVFS+cE5XASGdwL0fUE4+q/ckKo88K/O6F7Gt2YLSv2MCb4NkJZlMoBD2StDB8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302376; c=relaxed/simple;
	bh=w1d2da4uKDLcEsZloPB5/9/Nvphu7yQHza8wnaEcaic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ah//xd8SoKQq/2Qz8m7k2rJCl514evg4sejxlR6RSkCZCut/lYn1ShyiuSlHG8Km1CtbCBBU9pCHODNV4PsAnZ3qQ3NbOMmtrYnGmqPLkz06oPmOegw9gEfUU1+qx/geR0o3pM6RL6rCTRvMZTDSw/UcSomHBXTm5zluIS90fV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+l0wrVz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wdz2kcVG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770302375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzyhQ6YhgFEds9rDkWc4s/FKttUF9qWsn1wDT2X3GqU=;
	b=X+l0wrVzXMpiRjUDcZH5ummJMita5RE8pzkQ+8G/FcEgn9IptI2aE5cR9c1ySUbXCVa+nt
	9/8Q5XiutS8SlVrWeRHTjLC2/uMApHyrJwOUdwaPlSwatHxQoapAVKCKGjnzs8WektmGL2
	R6hr/kUlPSDrh/6IQhBnOUJH31OR7+Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-pHpW1fbeO_ibR2grDeR5Cw-1; Thu, 05 Feb 2026 09:39:32 -0500
X-MC-Unique: pHpW1fbeO_ibR2grDeR5Cw-1
X-Mimecast-MFC-AGG-ID: pHpW1fbeO_ibR2grDeR5Cw_1770302371
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43623cfb160so390088f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 06:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770302371; x=1770907171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzyhQ6YhgFEds9rDkWc4s/FKttUF9qWsn1wDT2X3GqU=;
        b=Wdz2kcVGVcPpxwAN3oORzTldw14yMibGYtqQTsRwiGXuvNU0P+YrcqYo3jp0r+1z7r
         JJfcZ+NdyqVfyNAkq+oSo9vG27VPoyMBxVz0QuFK6so1iA9eynMd6X4+mXlC55ai2Wmc
         T3NIQ/BZ2AQvYGumRro2X0e1fjqY6TiyrjiEiDIw7i7rxvHSyhD5ZgAtgEAFmE+ACf0j
         jkCYmPFIEXfZFwXkBzLkb79bg0MkkWgTXNd/o9tDG6JghENwROKOQZI1vr/u3gppAo3I
         JlK+ywxz92IVXgIBqu+/2ZzXh/CLFtfdSCBNsqWkaeC8wthEeOytl0lV1QwIhyfinjp7
         ioaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302371; x=1770907171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzyhQ6YhgFEds9rDkWc4s/FKttUF9qWsn1wDT2X3GqU=;
        b=cAEZQ+brhVUiDCJVLXRhl6sOF19JjVTAvfGhYvuW2b69GsSTO3BXslzRfAPViN3FoP
         DCucefZklm9w9m9L2fSgO0p6fdObRnYM6JZMWrGTM8WKbxXczIOq7mgMhvPmNQCVyCXl
         5rKrWK4rHgGnVtaHU6fcUrCRM92mRcypyLUmIO4C0QTiWa0TFz2D3LuT9n4BvOaCAENH
         kPtfDixZsavvXpXWI9Ky+Hc579Vw//iun1N+xd92i5Ls92sFm6WAQ/L7cbZVJlukw0yU
         lbIdWXxzmEGoCmtZo34EoppgWuEDtH37EQ76luu+YrhqVOGa8SyGoiekvwADKkyt++01
         Zi1g==
X-Forwarded-Encrypted: i=1; AJvYcCXZAVBalfellyzrYLFVuZcFT8V79jpVxKPkJRp6z3Z9L8RCt5VAExAI8K1uhPVG+3vwbdt48/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFA3TOUkgoGWvyOkBcFX2yCdx5T47vgiMZaDbvc5IT3sxECnkq
	5pv4wIiivWRLzhYFgnq6otzFXOi8A/VzUdnCbpGDfJzn9+O7GyR2CMEr9n/OO4W7AcxP5AaJ85S
	y4I9izo0c72LpCDr2O7e2nNkiCF7QJ09CuE5nU4Hl2kE4y4V74BlP5sDQDQ==
X-Gm-Gg: AZuq6aJ9F5MMolNf+FUbPnMmbvulBbsiOHgzqgp9LAUebDVn3MrZw77wqJDeeaj5vzK
	6mV+5bvtl0hdmivmEF8/nQdVtepaDwjkG/0nwjQvelGxaDb6Bcx31dtvsl9u220+SwjoH7OOCp4
	5sMViPx3jXonMdRk24/7uiUdwaexxi80HOF3C9JM28FvsBH3pV/wL+FM4ad4KApDUs/Hgl+n79X
	acMD8VxdkBHgWuVbSUFvxKh1dRP71ne3XYuruuzmFIvFzBjbuLdGm9aP44JGfIenJ8JvoEBgtNr
	j0qBKk1ShN5HzCvSv+lcpnm6yEe3Jz9b+zr44371HpslPNxW4U2k8CdmUVeWpPfp1Fo/AiZiKDw
	6SdVGt2xcnP/5
X-Received: by 2002:a05:6000:2905:b0:435:faa5:c14f with SMTP id ffacd0b85a97d-4361805c3ccmr10614481f8f.44.1770302371196;
        Thu, 05 Feb 2026 06:39:31 -0800 (PST)
X-Received: by 2002:a05:6000:2905:b0:435:faa5:c14f with SMTP id ffacd0b85a97d-4361805c3ccmr10614436f8f.44.1770302370763;
        Thu, 05 Feb 2026 06:39:30 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805813asm14040331f8f.27.2026.02.05.06.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 06:39:30 -0800 (PST)
Message-ID: <d4329f05-b9c1-46ef-b2fe-a078f9618892@redhat.com>
Date: Thu, 5 Feb 2026 15:39:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net-next] net: stmmac: dwmac-loongson: Set clk_csr_i to
 100-150MHz
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Yanteng Si <si.yanteng@linux.dev>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Serge Semin <fancer.lancer@gmail.com>,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Hongliang Wang <wanghongliang@loongson.cn>
References: <20260203062901.2158236-1-chenhuacai@loongson.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260203062901.2158236-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,foss.st.com,synopsys.com,gmail.com,lists.linux.dev,vger.kernel.org,loongson.cn];
	TAGGED_FROM(0.00)[bounces-257214-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A97CF4287
X-Rspamd-Action: no action

On 2/3/26 7:29 AM, Huacai Chen wrote:
> Current clk_csr_i setting of Loongson STMMAC (including LS7A1000/2000
> and LS2K1000/2000/3000) are copy & paste from other drivers. In fact,
> Loongson STMMAC use 125MHz clocks and need 62 freq division to within
> 2.5MHz, meeting most PHY MDC requirement. So fix by setting clk_csr_i
> to 100-150MHz, otherwise some PHYs may link fail.
> 
> Cc: stable@vger.kernel.org
> Fixes: 30bba69d7db40e7 ("stmmac: pci: Add dwmac support for Loongson")
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

This should go via the 'net' tree right?

/P


