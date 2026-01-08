Return-Path: <netdev+bounces-248108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC13D03753
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53DB3303492A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82737262E;
	Thu,  8 Jan 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKDTlqGK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lKInk13W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E02500942
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883210; cv=none; b=PBspI5+Ds6vX6RgRejNnSrzbEPH/gyQwxeYClAWSzz/WKChAUXdsinw/qmdjnFaeT6apYFY+JNsKtDXhsRln/vrl/h4VILUzZjpWrNWmeF43jupPw9PSefPiIrd2gNDE+4kR/952wcxPtnL3zn79AXnONg/kfJaEK0I8YQTDQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883210; c=relaxed/simple;
	bh=dPmlogqSF3x91CEJq+G86ZMwTBqFlXyFWdTsnVs3Vl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blIuw8c5yCE8L4KmQmjvjYsS3od6wB+lEALNXXK8K2z0bVYhiSmq/UPSO89hfYWpDYig6e6wOp4bEER3bc49tsgjdT77gy9wrHuRvZA/hYwbLXThCgv4Z8Ypq8F9G0f/902dIirQB059Yzwdhm/AzNT/JBQ41ZttYFcRHYTVlYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKDTlqGK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lKInk13W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767883208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njA+hTMBn/k9kWyQkaykZqwF8RGh2m3Qf7ruOi453Qc=;
	b=fKDTlqGKyEXH+ULtznxe/xo21CzSIv2X19EO32B81ngHVr1WedtkAXbiYa4SgrZ5+oXn2K
	P/SMvKRSU64UnNS9x18DAlwpfC5AxIxL4vTAYqztdqJMyyOvJRQu5XHnSl95a0vqCmYTHm
	qG3lWR+WmpxTPQyNIa1o/E/gBS2qyW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-zRehFsdpOo6HQXyn1NM7Tw-1; Thu, 08 Jan 2026 09:40:06 -0500
X-MC-Unique: zRehFsdpOo6HQXyn1NM7Tw-1
X-Mimecast-MFC-AGG-ID: zRehFsdpOo6HQXyn1NM7Tw_1767883206
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso2124509f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 06:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767883206; x=1768488006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njA+hTMBn/k9kWyQkaykZqwF8RGh2m3Qf7ruOi453Qc=;
        b=lKInk13Wub/LaEm/hRLrxjv8PCaIaBEDD1Kyeeob4oIlNkMYaDYm8Gw+C/T30160aE
         QOPZi+NNGfL2Wmq7iaJyaIEh5qVxz2yrl1alvlQBjEwGIC0sDNNU62+OqlHRaHRU+dyt
         QA3B0t7qsmcFOHKeQlaBYqqY/I2uUuNEWCMFVgZQL1nXp6FqYA4dbxUeADFAlCs35WMe
         MqHCemLpiSLI9nfKgCWbOF8GtqBNHiMxKl0bimu3xYRyT0zff7RQwiwZ+w9XDoHmwhYW
         uVif4CbxoDARgm5FWz+j8mENMWdsw4bi6x6dftQs+lfalBrLSO0x+T2UjSenjo4eYyTH
         OC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767883206; x=1768488006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njA+hTMBn/k9kWyQkaykZqwF8RGh2m3Qf7ruOi453Qc=;
        b=Z3WTuujtgwmz/MQbdm6rQjbiKKXfkfyIXsofBcwJko5oKc6zRRlMCqYhKMr98L1Q89
         crtWDiigvjnkGO6w42NvU5Rlg9bk/bwscOPkvlPjMoftnv6qqx6Iw2TUMM2TaQH74mku
         5DjFtSoTNaaby0b8OcDM8QGqGFLsaVqa5N1GFAkBM73WwtZTKl+JshQE6gGw7T8YWAtb
         8ziGiKb/d/S3bInkn8siBh5c4Duxfwdja3dIKEscv60Q3dyqyJaBE5n5dHFqBeZfFToK
         IxpuEInMzCk9BPurviA6SOaPFrHyMW/6tfLuKJdXiY/y4732j+NFLpSsHn+IeUfdUk7V
         kXWA==
X-Forwarded-Encrypted: i=1; AJvYcCW2QuqiypYifEhEYdUe+fTC7v8PMw8SRp6BMC6c1MPHHf2fxzKKWTwCrdmppRFFt5u4+ulNsEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOkkHKkORScgWw4zS7IRbSy6J3+rhxl5JtXCggnk4C6E0+57J
	KbHFJ1pbMD5tq3eIIlqn38mGjhboOBZ3kld0seaZbcYZLt2sAHr5jTTNWhTGwI1mV77dCEFqH42
	qKXKpS95rtwUWv/i+WB30Gl16q0nTe5kQHA/wR3IPR9PhQUmqg8j3IXEvDQ==
X-Gm-Gg: AY/fxX5JBAL09nhOmT+KAXPwxwvTaAWVaCShAzal9dTyVCmLDpFyeIr1Ot3lH64rVYl
	0pWgr7iX4A+6oEnIBaC2aYQc5En345a6BXETL/PckI8BpTrsV6BsKOxuiIKXD42eCwW63acj5Lx
	MG8u6zHVDCcSQGgiafk9zDom9IWHTw9NP2p4bNJX/chXChvXdlxmt7cPvdCe50NENDO1rIP/1d0
	7s3Uf9Ug1NQ3G/pYj3SHPpovpAy4rmGA9+gWnRtn48Za0Jd67hr/6MIVlP0RMCyQBZGIl93nNmx
	/bjvVYDV3tcM2/0Vyp1mYa11ke5lkHdEct18kRg7b3bi2WGmT24QxwKDw9JEddDhPGfNIiIEz5u
	VFufEl7D/xCzQZg==
X-Received: by 2002:a05:6000:290c:b0:431:864:d48d with SMTP id ffacd0b85a97d-432c36282b8mr9097937f8f.5.1767883205666;
        Thu, 08 Jan 2026 06:40:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhrvE0E96qmKMPJwgFr/KgrUshlj3gNC/1jVjlfOFsD1VsRwzSKI/T+U4gkSRnW2fyKqjotw==
X-Received: by 2002:a05:6000:290c:b0:431:864:d48d with SMTP id ffacd0b85a97d-432c36282b8mr9097863f8f.5.1767883205167;
        Thu, 08 Jan 2026 06:40:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff1e9sm17531056f8f.41.2026.01.08.06.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 06:40:04 -0800 (PST)
Message-ID: <0df97c1d-aa75-4472-aad6-33eaa919ce28@redhat.com>
Date: Thu, 8 Jan 2026 15:40:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 02/16] net: build socket infrastructure for
 QUIC protocol
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1767621882.git.lucien.xin@gmail.com>
 <d5e0dce5e52d72ed2e1847fe15060aa62e423510.1767621882.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d5e0dce5e52d72ed2e1847fe15060aa62e423510.1767621882.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 3:04 PM, Xin Long wrote:
> +static int quic_net_proc_init(struct net *net)
> +{
> +	quic_net(net)->proc_net = proc_net_mkdir(net, "quic", net->proc_net);
> +	if (!quic_net(net)->proc_net)
> +		return -ENOMEM;
> +
> +	if (!proc_create_net_single("snmp", 0444, quic_net(net)->proc_net,
> +				    quic_snmp_seq_show, NULL))
> +		goto free;
> +	return 0;
> +free:

Minor nits: I think an empty line before the label makes the code more
readable, and I would prefer #if IS_ENABLED() over #ifdef.

Other than that:

Acked-by: Paolo Abeni <pabeni@redhat.com>


