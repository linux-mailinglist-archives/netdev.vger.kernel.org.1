Return-Path: <netdev+bounces-278963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOX2Hjyb4GnokAAAu9opvQ
	(envelope-from <netdev+bounces-278963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:18:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E40340B6DA
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 059CC31D7D29
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7FE38F24C;
	Thu, 16 Apr 2026 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnhxXeub";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lG6EBcGx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6237C0FE
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327130; cv=none; b=E8a7exnqudGF3jiWUZWC72GwLfX0gleQusIV3c8tEd7Pbi9esP0YxcDgixMAe7cRWJbvkoUApYCR7Nha7vAqq7id1p5HGPR2I11Z2JDBFYH47wngC2RagUYTPoGQ9lh0zaBa2hgKvrSTDxcYUnUj46FYnBY9NxwqtfDU1tB8hS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327130; c=relaxed/simple;
	bh=4Hbe4aYfPwQJCdXwR7o/DQD63W4U9iXbnSh7ROQgS9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O69VCL/nztGmKxj+Muq+OyQzUINX3WEa1JTZec9laRdzw4yKvVVH5rip1qp66yBirZ9EmCCRZ44gRK3uVEzjRraHpqrRvNeBTdmb8SoWzx/IxQWx5P9tVoyiThZJb4tJhid4gQ9zrlwcma1NBFb5qYJiGxNogFiJ9JAVvHYPKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnhxXeub; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lG6EBcGx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776327128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCw/fk1scpcEI5fTg9Hp2YTuYcflg1hd7U/WW44L5U8=;
	b=NnhxXeub6JChqPqEjWWQvlsI5lUV8SwSC3qAwubPiYoteHtgFgc0pJQEnS65/VUotfezl+
	qQXRGbBY/eBQ7KnHuLxB5DkqETZSFRczjtP5rh8EFyr9RGPWMheYTb8OTez5ClUFexaJOT
	+Tqr3dcIA+USHD3/Vtu4U6M0UTxVqjs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-cCbQbT3bOWKAk1rbO_0QJA-1; Thu, 16 Apr 2026 04:12:06 -0400
X-MC-Unique: cCbQbT3bOWKAk1rbO_0QJA-1
X-Mimecast-MFC-AGG-ID: cCbQbT3bOWKAk1rbO_0QJA_1776327125
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d744128b9so3468629f8f.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776327125; x=1776931925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCw/fk1scpcEI5fTg9Hp2YTuYcflg1hd7U/WW44L5U8=;
        b=lG6EBcGx0uv4/mvNVVBEaPQ8eQSbSZSARYoPm1rE313DYvmH2brypwjNiw9apnZTYn
         8MxWCrBrDDS7j5BftjKmHoQd8/9lFVcWf3plL3uHkntyeF3V6Cr/wv7LZUoC47edeYDf
         Ws9tEeOSc9U7kAqHiBGizdIhNo+9wxj66dAQkX7SVJHTKiqitTVWbcYqjEU2koSGm/sY
         9A8vCsV5kpZm/HhpehzDSuJP8n/nszVM7Uv4rlPtFOHzxHyu4DbxXVrus0zMrPENNXRf
         NsiMfCFENpzjfJvED/FCskaWV+uk/3stsQ4cZr3a0XSJgdCW1A42Y04jgLPWmiRHNwVv
         8ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776327125; x=1776931925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCw/fk1scpcEI5fTg9Hp2YTuYcflg1hd7U/WW44L5U8=;
        b=V7xuPlzu4UjRbolL2EZ/KILCZPjZrJN+M5J7+ZZP/fUjbvCUg8WoCZf+Ho1yP1Pmid
         VD25d0Ji05QfpX0tHeb7XoAQgiXBvXCZ+1oevMtFfEf6bi+X3qSBU2psiksi0pXjuFgH
         I4cvw7HvThvaK8rpZthG4U3hQtdwn9Dw9wUHpC9fahcoOIUgyJm2hLFm46yla0CxVb3z
         Ycuri8mM2PEwrd9Dp3HExQ5aUgjDPf1JBwZ3iYhrizySlkTAN5ms2zZJy1p3FXdOsFtA
         skXf/cWGzcrvW7i5M9mNMuZ/JeFswS+LXhz8Sru9pl/dNhvye5huApZwK9/9D4QMeF/+
         xWUQ==
X-Gm-Message-State: AOJu0YzlLT/yOP90xHJItn4qArDKJ9dIvJHWT3cI4wGXIhJNFQO+9+Az
	9AHC5EB8woQuSa0MBNVz3V318RCkyQEiVeiOi26qVK42x0kPW7/hooXvKCck1BbbHv54XFxkO0Y
	IjouCd1YsZ/vJMU/BDYCaidjVJ2uYiqoaNYKBAo6tZLLpV7PnN2qxolVnSw==
X-Gm-Gg: AeBDieu+u/iF/5Nc0z3QlMB7ZGgunarJ/fM1n0HOtoTTHmIcYUo4QBDnfZMNgoFex0P
	d4b4AGDgrpoRpflv4EuCBomEA/auE+bwrFz4TTBRbpNrFzHOG3e45xfEPEnexLJ1BZGSCnA+LdY
	yEzDSIYy5aRAIo0uJy0LfXbeloiopJphiyRUNrXcv78FJuaotDCRdiLviDfBC8jx/2ZzTfk+KGw
	FAX45BYRAKp3breDPjtC4nq7DihSB9LypQm1k2g+j+pfge5gyGGofJZtQ6x/PnvqN/S4Ruz32dn
	ArCGMIYLN/tI7OfhK84E1DK/UhruKib52821JrKtbgDi/Jx+WaP5AXj3pNIoFDtA/TIZYVk42bh
	N96NpfnuNDct/Mwl0btF1N2O/wEWJytRv9cTyES1pw4W/Ly/x833AHTRgi6fncuZibi4=
X-Received: by 2002:a05:6000:2c02:b0:43d:75a2:44a1 with SMTP id ffacd0b85a97d-43d75a2463emr24016064f8f.47.1776327124786;
        Thu, 16 Apr 2026 01:12:04 -0700 (PDT)
X-Received: by 2002:a05:6000:2c02:b0:43d:75a2:44a1 with SMTP id ffacd0b85a97d-43d75a2463emr24016016f8f.47.1776327124289;
        Thu, 16 Apr 2026 01:12:04 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5ea9sm11794717f8f.21.2026.04.16.01.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 01:12:03 -0700 (PDT)
Message-ID: <72d1b0b7-c8df-463e-a2d9-bf5ff04ba33c@redhat.com>
Date: Thu, 16 Apr 2026 10:12:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v2 1/1] net: stmmac: Update default_an_inband before
 passing value to phylink_config
To: KhaiWenTan <khai.wen.tan@linux.intel.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
 ovidiu.panait.rb@renesas.com, vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 yoong.siang.song@intel.com, hong.aun.looi@intel.com, khai.wen.tan@intel.com
References: <20260413020339.68426-1-khai.wen.tan@linux.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413020339.68426-1-khai.wen.tan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278963-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0E40340B6DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 4:03 AM, KhaiWenTan wrote:
> get_interfaces() will update both the plat->phy_interfaces and
> mdio_bus_data->default_an_inband based on reading a SERDES register. As
> get_interfaces() will be called after default_an_inband had already been
> read, dwmac-intel regressed as a result with incorrect default_an_inband
> value in phylink_config.
> 
> Therefore, we moved the priv->plat->get_interfaces() to be executed first
> before assigning mdio_bus_data->default_an_inband to
> config->default_an_inband to ensure default_an_inband is in correct value.
> 
> Fixes: d3836052fe09 ("net: stmmac: intel: convert speed_mode_2500() to get_interfaces()")
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>

Since Jakub sent the net-next PR and forwarded the trees, this patch
does not apply anymore. Please rebase and repost. You can retain
Russell's reviewed-by tag.

Thanks,

Paolo


