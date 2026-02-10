Return-Path: <netdev+bounces-258106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCgeKJlKi2mWTwAAu9opvQ
	(envelope-from <netdev+bounces-258106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:11:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DD111C4FF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D1B30086D6
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A03366DDA;
	Tue, 10 Feb 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioMhoxXZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/CnvC5H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922431A545
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735994; cv=none; b=UgQBnxfXQaFBBKE0JMHiGYmam2ik2VseWulfKIIC9baEogXrcdMVoTng1Hn/O5PmE/AfZAbCj44OrD5DnwpzNOqCyvXbzVTBk10Hg1fkIeGHTTmyafNPO1kwf3fZ7KexomW/9IZG5spMVpjLVnFwFAV0AFbK1GjBO1fbuyY2YUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735994; c=relaxed/simple;
	bh=jCgQrHdndYbRHvch+HSK6fr85wEuWYJLUBJMG22268U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePdN0wTFWNkZhv3DY6Ub+LYBIW5Y2DFgKJiCNuJ5PNMuVc0Olo/0IXN7Bl49JZxFSXq552dEvY7lFr5WrMTaOeZ0VEw1N8TaWaGusg88YPVxGSICw2lWuvPquJFAghCU49YEx9URELt4u9vQervR3V5ndiwxe7tqZTcZpxF6Eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioMhoxXZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/CnvC5H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770735992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIYPGwfOoEaEyqnciztuxGtw1vWvuiq5QQc4XTYgyEo=;
	b=ioMhoxXZiSSRjU214bTfOGXo9/S72xBTXZTnc0PG7Dvj/SS+ZwyyxMp5PbeqlGW+igjvpD
	te3ZnEDgQzDLhBR4mzOsp9Y/2wdHFo2R2grTZwrJHiLV5thzvQqGGgpN9iPI50BGPauEQz
	AuLEdO1zozS9CabGVhg4aaDb49EsvbE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-6htP5-eFPyK1pokd19-03g-1; Tue, 10 Feb 2026 10:06:31 -0500
X-MC-Unique: 6htP5-eFPyK1pokd19-03g-1
X-Mimecast-MFC-AGG-ID: 6htP5-eFPyK1pokd19-03g_1770735990
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4803e8b6007so7921225e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770735989; x=1771340789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIYPGwfOoEaEyqnciztuxGtw1vWvuiq5QQc4XTYgyEo=;
        b=C/CnvC5HEZ0/PzIPhE2t8H+5gu8mxxZP/8e5R6JlizJWDzUW77AqBCqVE3qJV/HLo1
         wPE4z94PM1cLnKzENjxoS37LYJUg3wBKZw4cvhPPz6SisQ7+bPr0Aicf0y+GDfs7J3JI
         07r/vghhDxFiazYZn/h+CqWBNDPXbqe0Qh/4FqpmJSsniAbSPYbIYliKUHTgphgTcPnz
         5N3+9mlcfIG8c+vcBeZKWfG7/3gPPWF7XXQEl44jZEvtRGPWqPA2/8YiiHpkdbrtwSCa
         e0Enif9g049hshCSAqsLWRrycozr4apCbkBlzYTEyCuhVowQqPrTfLtvZQV8PvB+NM9C
         1+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770735989; x=1771340789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIYPGwfOoEaEyqnciztuxGtw1vWvuiq5QQc4XTYgyEo=;
        b=Ol+rKUh5m53PnpK8spy84JS8THkRo7Ze8hugP8P1L++I/w62nFT2V2hzfBXJKn5ObE
         1juy09tLaKt/xXHVJpV7vLnL1/mUOAOkF17rHJIPIC/0vZq98a4WPCRIxnSwryaFY04M
         Ni9aXA7cLLJzmNFKd352Ixp8/H3GxeFfZaGdu4nf7fYhEeIf23mip0BfkARFDBqNknDi
         7fEA2TTuhe6BWKXvdcelwxboZdb6QQN2UcAoY9E5EwWwef34CL9Q1GP76I2uKDlPaCWU
         hAasDwheFO2Ge6XXcWaGoIFdIn2qVbD7GvIMavCsL/cHgEsVjlheOO+o0omUlTdjZgbO
         zNRA==
X-Gm-Message-State: AOJu0YxLOrGI9Q5WS6HRChq2YITcmjHo1TZaNQh63djDnByftH+Cy/1W
	wJJedsnhaYOvfMV6IQ1TMEFiCcCIACpoVx8ngr3o20sezuU7Atb3WDvp94VQ9VLa5C+5T7sAMnW
	Ldxz6nvtzjHWjo0rmad58WoHgci+xHoSfHAer/XeXyBZd1dtcUJe2jfpccA==
X-Gm-Gg: AZuq6aKMjZnbQ2/pI6XBOADy8CfWsfEFtgUpAdzpRWsgN9+b/Z7YpJR/EnaW8IdET7T
	CPMtYIE7I19Jvj6LmEKuY4pstAkkoVoL/4pl8xAJQxajuYWZSDZIU/7QJzyY3rKyZ//gFaD5u7D
	3ZFb+s0nnhXWADEE/tDV4G5kvP3cDoprLFHqL9ldqByK47QZFah6cMM3MXWtFq3PcOoJarChI63
	zMzj8EIikMMrcHZ6bjPHnhNdKOnYp+goTPpk/2v/Qs0MQmDLu0BWmr6tGtyHn9kaIphYF+zkPiJ
	eSpSnp4HcZCNS3opkS3DzJgVGt8Y8zQX0qv/WFN69ZF4KuL3BTFKQCZ/zGIbD8JB5kLYLdSUUH/
	yBqlcYsr0/G3TFW6lpBFCB60=
X-Received: by 2002:a05:600c:4449:b0:480:32da:f33e with SMTP id 5b1f17b1804b1-48320216075mr250117135e9.17.1770735989482;
        Tue, 10 Feb 2026 07:06:29 -0800 (PST)
X-Received: by 2002:a05:600c:4449:b0:480:32da:f33e with SMTP id 5b1f17b1804b1-48320216075mr250116695e9.17.1770735988987;
        Tue, 10 Feb 2026 07:06:28 -0800 (PST)
Received: from [192.168.88.32] ([150.228.25.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7d55c9sm62697045e9.8.2026.02.10.07.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 07:06:28 -0800 (PST)
Message-ID: <e806861b-acd4-4615-aada-577e0275bb5d@redhat.com>
Date: Tue, 10 Feb 2026 16:06:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 3/5] eth fbnic: Add msix self test
To: mike.marciniszyn@gmail.com, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Lee Trager <lee@trager.us>,
 Dan Carpenter <dan.carpenter@linaro.org>, Pei Xiao <xiaopei01@kylinos.cn>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260206154246.814-1-mike.marciniszyn@gmail.com>
 <20260206154246.814-4-mike.marciniszyn@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260206154246.814-4-mike.marciniszyn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258106-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,armlinux.org.uk,intel.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00DD111C4FF
X-Rspamd-Action: no action

On 2/6/26 4:42 PM, mike.marciniszyn@gmail.com wrote:
> +/**
> + * fbnic_msix_test - Verify behavior of NIC interrupts
> + * @fbd: device to test
> + *
> + * This function is meant to test the global interrupt registers and the
> + * PCIe IP MSI-X functionality. It essentially goes through and tests
> + * test various combinations of the set, clear, and mask bits in order to
> + * verify the behavior is as we expect it to be from the driver.
> + *
> + * Return: non-zero on failure.
> + **/
> +int fbnic_msix_test(struct fbnic_dev *fbd)
> +{
> +	struct pci_dev *pdev = to_pci_dev(fbd->dev);
> +	struct fbnic_msix_test_data *test_data;
> +	int result = 0;
> +	u32 mask = 0;
> +	int i;
> +
> +	/* Allocate bitmap and IRQ vector table */
> +	test_data = kzalloc(sizeof(*test_data), GFP_KERNEL);
> +
> +	/* Result = 5 for memory allocation failure */
> +	if (!test_data)
> +		return 5;

Instead of magic numbers you could define some macros, or simply return
a boolean success/failures value (as the caller ignores the error code).

/P


