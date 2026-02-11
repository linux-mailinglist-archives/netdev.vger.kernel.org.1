Return-Path: <netdev+bounces-258230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIo3ExRMjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9B6122BDC
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80045308C9D0
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D88355809;
	Wed, 11 Feb 2026 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzOpDRGH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rIZ0Mbo/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC93346A5
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802100; cv=none; b=vCNJcr/FHnMfksuoXIrKbu3pJqj/RXKpiUa2lTpo26vKme9+A2JMbxf4sTX+eABc0M5YVd3LKHIOgg+xajF8UvZ+6AFz8kltFsvyfriyGbQ2H12m1m80jtkzYsxnNfBY4HPj0dVA/YIFmwHeON1nr9wwtDkUbwGKZqgBzG0tVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802100; c=relaxed/simple;
	bh=UPbB9FRWnOPN8Vn7UmyocTYgvL6IlQpeN8CZSHDQVOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2xZqW35VUoKSCHDthkA148SGUawxvbF8f/nTqw3EGla15Hu0rwNqbfx80klzUDjHgZ19ecM7PvQ0gVJbtRzLyA8NHjaJH+2TF+Q7PAN6dDf13NplHtxQm7Kbjy2pR5adFeWvJfr5COmuZHVDm4YHQ+NYM+zYs0c5fmkvHpu900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzOpDRGH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rIZ0Mbo/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770802098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwv4TmSM/nZBGEwsH7QgKLc13ylHJw1WSllP1Yiyomk=;
	b=VzOpDRGHR+hrGPwGRsySvKBn9pXQfvii0S1Q5BvdJ93p97yUcjbkLoxEIk+nuO4ceKW/qC
	S6+hZ7i4CP6iE/505MA4D+wBDsCdSKCss9HhZdkG4v9bYns6OmMkiPR0eUrcOuQ/TRLM4h
	7O93X6BlsKysDYi4gUkoKXxjn2+yVcQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-KDItMvJNMgWB4mTXTkptzw-1; Wed, 11 Feb 2026 04:28:17 -0500
X-MC-Unique: KDItMvJNMgWB4mTXTkptzw-1
X-Mimecast-MFC-AGG-ID: KDItMvJNMgWB4mTXTkptzw_1770802096
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435ab9ed85dso3234845f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770802096; x=1771406896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwv4TmSM/nZBGEwsH7QgKLc13ylHJw1WSllP1Yiyomk=;
        b=rIZ0Mbo/w8ZXDR39CIBvmeCqaSdd76JNbhzYCnPMSyjSHCx047oeFAyN+3+qcTAeeR
         DxP0ozfdkU+AK1mrwy/h1R2ABsVYPt9cSrFWg/JMPTj8eSK7CjNbHXXTg1dLaaD/JTaJ
         gbfKT5NLKonuDNhfE6EhZToQwUKA77GSEWwuSzgPfdC1S4JAzAUi28i3cWe34h7qGsH1
         HS++PQeCFFRCqT9lzAqhV6EKSMrvEXQJBDGZVV/khq8n12EuvAcbrk/7bk0QRjaeSPSx
         oah6k3XRctSRFHXwR9OGNkEDe2wFLQIMU9UurkAKt9nJsh2+406fyXFF/zbLPvA7lugV
         L+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802096; x=1771406896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwv4TmSM/nZBGEwsH7QgKLc13ylHJw1WSllP1Yiyomk=;
        b=ojZKeb1xyegUzBf6iEVyeXqMkotMLyG9Qn8sMw/ptES0Jm1aRYK2wITxi/l+rLVn5F
         BewqpChndITsP+JWrjSru8YdAbsFMjqLT/bk18sQaqa9cHgQOv9tfL4yJuF+S+K5OQxz
         o9gVpI2jxsa6iqgn5MaqbrlOxSAOfZc93WV4bwWX71l8OChcpedIywHvshIYyEdRN89L
         aPhPejglA8fqft8FCXzDABh6wqPXFZC9w6UdPps1tSsCF1LhpcYhCqjiOtUsA2t6+riQ
         eWqKMsA0ck1zXzLcw3mRGjhhK2UQdR02APB15YG2W/4/TItBmQw+orZesWVUAksJD0FZ
         +6PA==
X-Forwarded-Encrypted: i=1; AJvYcCUvpPYUI9x3bL0zxs8EcG10+cAJ7EOxiSxTrmRblbMqx4hPds6gzEH9UPUqyDHHX7HwLA0rB60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbdeKZJAPcsHKBP3kQ9epzvh9deOI0hWmIn1MOEyTxeFBUtbm
	StCO0grY9VvtHZCzg7MLHStgRodcV04XvgTBCwy/ytR7i0DYp4hIsk8LVqyk3mkEi90VY8SMIUi
	h0jblt/mFCIoxlC/8zciMi/QSuOdI1npV+NjQL23TvlwizgSzMRgEgvZWPw==
X-Gm-Gg: AZuq6aJbnFuHrVmHX7/wpTdJI0+LXjHuTBcnEH+Hyhx8AIXF6xzKDc8YlYgoKUlJ3pe
	PMI4NTiHEPAdcf8SSYQACRQnuUNz+glQzHD+QN1rRSKHzvsKH6+0QQLYZ2bb7C9crSmdcmSD+ki
	GTJCY7ybmZxnu7PiDntpSLn1cUe0pkphd8yKcbx1cBrikP7mc5E+TdNEtjiBKyeB91x/O3iHGGt
	7YrL/IO9hvM59ATpZyzEFC/dZh+WMAagmxATRRexXOOUqpqZwNU/auqgrvZ3OOJpnpjo412ISUl
	DTZH8i8zb0fkOFGpOX++HzYl9Z3gi7QdNa3mT0uQi2KDOLkwe2ss00pSvKVMw34GKy/JVNJNAcM
	i3vVmHMUNxT+YQSunAr2WwrwERw==
X-Received: by 2002:a05:600c:a4f:b0:480:4b5d:9ec with SMTP id 5b1f17b1804b1-4835b947ce1mr20546195e9.33.1770802095628;
        Wed, 11 Feb 2026 01:28:15 -0800 (PST)
X-Received: by 2002:a05:600c:a4f:b0:480:4b5d:9ec with SMTP id 5b1f17b1804b1-4835b947ce1mr20545875e9.33.1770802095215;
        Wed, 11 Feb 2026 01:28:15 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a1c2sm174681995e9.9.2026.02.11.01.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:28:14 -0800 (PST)
Message-ID: <6d00bb79-eca1-4649-ae5d-e81462c30f1f@redhat.com>
Date: Wed, 11 Feb 2026 10:28:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/5] net: ethtool: Track pause storm events
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 o.rempel@pengutronix.de
Cc: alexanderduyck@fb.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
 jacob.e.keller@intel.com, kernel-team@meta.com, kory.maincent@bootlin.com,
 kuba@kernel.org, lee@trager.us, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux@armlinux.org.uk, mbloch@nvidia.com, saeedm@nvidia.com,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
 <20260207010525.3808842-2-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260207010525.3808842-2-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258230-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,pengutronix.de];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BD9B6122BDC
X-Rspamd-Action: no action

On 2/7/26 2:05 AM, Mohsin Bashir wrote:
> With TX pause enabled, if a device is unable to pass packets up to the
> stack (e.g., CPU is hanged), the device can cause pause storm. Given
> that devices can have native support to protect the neighbor from such
> flooding, such events need some tracking. This support is to track TX
> pause storm events for better observability.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

AFAICS you forgot to retain Oleksij's reviewed-by tag from v1. Perhaps
he will chime-in again...

/P


