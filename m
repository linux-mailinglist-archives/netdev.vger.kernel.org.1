Return-Path: <netdev+bounces-285213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB1iAJhe/GlWPAAAu9opvQ
	(envelope-from <netdev+bounces-285213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCF4E62D0
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A7CB3004067
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E303BF685;
	Thu,  7 May 2026 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6ZXSnRz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnpPsYZB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD823C4542
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146956; cv=none; b=IWYjodfKUr1dgPuI0EkpYWmztySemzHDraIlamrT4LYQbIK81Nd9CxzQWv9s5ztQ87HhscM6T5+zt98ggVZ2kbMQZQOJcCpFFOWCSArRHEwt7izBpz8BXTg92er+xh/iq+vWwlovpusD/uHmxRqZhnJ8xcB5CGn0AIEL2KJp/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146956; c=relaxed/simple;
	bh=JKeHjw5d+vS95B0gqhrrMQ08nSofzwyMUDvN6S3xMYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/4uP8bRwzWlRFrwUUxiMHhNK6B+HWrwtC9Czq9sfj1eI+u+dBH8JOjPM45w8D6Dcbjz/kZmfr7X0QVMETh0UApM3TAljeBXl0KYfGzt4A875Y08VeqvFAhbi5WYrb57gLTzNVqeqRqvlCSiiaW76iht62ypaNOcxXka+W9vtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6ZXSnRz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnpPsYZB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778146954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0bzjHNwg/4dsgcGNIVawkmXretC17GVDXq9ice+Mi4=;
	b=b6ZXSnRznVTmLnm3c61UgV+tlHmixko3dThW3HKSmXJWyUTrsTj+MtzZFaFeB3B3e2tTpz
	UHv/xCZoyQVkOS2FI+xeKsIrG5tOp1tS9TLBS5X38WjqXyUjZZwDwyZc8FPCiC5kSN2ufV
	Jm1eFiGZPRX3OaxBe7byHIdAzNF9K1Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-2DmAgZyDN5Wy1TM4bPo73A-1; Thu, 07 May 2026 05:42:33 -0400
X-MC-Unique: 2DmAgZyDN5Wy1TM4bPo73A-1
X-Mimecast-MFC-AGG-ID: 2DmAgZyDN5Wy1TM4bPo73A_1778146952
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44a52d5e572so386398f8f.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778146952; x=1778751752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0bzjHNwg/4dsgcGNIVawkmXretC17GVDXq9ice+Mi4=;
        b=DnpPsYZBmVBhZ4FEQHpizHlahQEuoX7d7byKXdU292DlgmZXBSGE8I4ZBxGD7qiDlL
         nqzHe2cc1NyBGZNhjd88Il//7WgNuopiMo22ehL3E+YXhOiWVlPS6D/tKt0L+4LWMPHL
         SCxuZ2W9qlSFp7J5EfkWIdB4rz9F1Q1w79pg1I0D23RJrCGCRVB9HhwhX4/8Fk8LHl/Q
         0D6v+MrJkeB5bFIskJUv75t5BGD88UGG9nbLGBeVhMjLRpEAZ3BIElxrGB4Zjq12DPYc
         SITtQsOrlgKfT6u6WFudY/tLLgDt8/P4BnhL2Tqa21dg7v74ko8d5vYmD+Q+/1t1+PA2
         oDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146952; x=1778751752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0bzjHNwg/4dsgcGNIVawkmXretC17GVDXq9ice+Mi4=;
        b=pjGMYfGaOHQsPyFOiJNRtdXEjPz4C5WVq95T+1xLxqxMXf372klRmeOjUTolGg6Hza
         +zZH6OCRmcu8/+jMkEc6vi2TXUdp8khdlzihk3Znf42jt5dr4uPozQlokCtOOD9k+dHy
         8CNJqxO9I9pLXGiRryWBVqfnMeNya0XFkae2ijsONYL2b3KWbWCavDecPLb3uV24Hv7/
         f3kzaIUJh14Ytdh9/f3ALvJjDBwaM50K3fLWbfIpvr4mlJrLq+rnydfwc6LRkt1QSU3x
         rdrghCvf8psrt2+M8LdxfwxAXGCzgiDxiWebjBubb8ZUYVEeK29ASLEECuLOX7nKloSE
         EYUA==
X-Gm-Message-State: AOJu0YzpMllhcBUfUB9ZtUM5+We7uKpUshJ02JTlBrP9O/S50HQSD7gH
	bxTAqBOgN+9orjw0fEOndOs7p8g7vkSXgm9kHWUrhhoFxsc/Ucuv5UDSPXnz0gs6F9bN0r+KmBN
	GEPeBAL1gsgkDCSDs4m3ReN5tb28VPOT1aMxkwOI/4Gc21M2a/wQchgIMjQ==
X-Gm-Gg: AeBDieuVgibDXiV0r2CioWcNyNDQ5pAClbQm3QfhDem7UfV+L5av5d/AYZeic/Jr9ED
	HJiWVjpFXM8TXZ4ofCPvHb0HZRq+GkCJlx3ttLP6E87fK/hzLRq3GC5Aa1QtCsZg9xIB4+OvAAx
	hTxxyPPpludcFaabeGc9E5jJJ3/CeWVvAUhj431FxzSnNEVmYFcHDMN228YICY9BL3sRBrskAgz
	UmnsiTKwWzkANCwh1FV0RyxsUQogz5EkcLhmn/v8pKDo1bq/yosdwIicDIjTjq2/DbNocJ3bYrb
	WBArPw19hjGPOZCgyO1K3948L3d/fHzeoJgiueAN3icKUX/ahGaOqHDq6/YJHg7LnY3SL3nQVKK
	H9FCTiGp9q78JOGIVsjNWAU0pFvTcavV5eYD6d/vf8r/zXX6qduOXuQA6VlOtDTeKoQ==
X-Received: by 2002:a05:600c:b8a:b0:48a:56de:d620 with SMTP id 5b1f17b1804b1-48e51f32ac3mr119824605e9.14.1778146951912;
        Thu, 07 May 2026 02:42:31 -0700 (PDT)
X-Received: by 2002:a05:600c:b8a:b0:48a:56de:d620 with SMTP id 5b1f17b1804b1-48e51f32ac3mr119824225e9.14.1778146951416;
        Thu, 07 May 2026 02:42:31 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fad5fsm121570435e9.10.2026.05.07.02.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 02:42:30 -0700 (PDT)
Message-ID: <2b583f22-4f34-4c7b-99c4-ade2431070b3@redhat.com>
Date: Thu, 7 May 2026 11:42:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/10] enic: add admin CQ service with MSI-X
 interrupt and NAPI polling
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sesidhar Baddela <sebaddel@cisco.com>
References: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
 <20260503-enic-sriov-v2-admin-channel-v2-v6-4-0af4fbc2d86d@cisco.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260503-enic-sriov-v2-admin-channel-v2-v6-4-0af4fbc2d86d@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 20CCF4E62D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285213-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/3/26 1:22 PM, Satish Kharat wrote:
> +static void enic_admin_msg_enqueue(struct enic *enic, void *buf,
> +				   unsigned int len)
> +{
> +	struct enic_admin_msg *msg;
> +
> +	msg = kmalloc(struct_size(msg, data, len), GFP_ATOMIC);
> +	if (!msg) {
> +		enic->admin_msg_drop_cnt++;
> +		if (net_ratelimit())
> +			netdev_warn(enic->netdev,
> +				    "admin msg enqueue drop (len=%u drops=%llu)\n",
> +				    len, enic->admin_msg_drop_cnt);

Failed allocation will splat dmesg; no need to added additional error
messages (here and elsewhere in the series).

/P


