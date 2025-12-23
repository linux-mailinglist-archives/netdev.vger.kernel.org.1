Return-Path: <netdev+bounces-245812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B53D4CD85BC
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 08:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A82B73019E09
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 07:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B82ED87C;
	Tue, 23 Dec 2025 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7GV3DE3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKMpl4wt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8923C8C7
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473719; cv=none; b=Lmj46xuQrEYoaauaolivV3xQfhNyPAq3YF069Udlvx6bahP7QKslUgQIzcbvF3BjpE96P0CGicUBqep91EkjTdRlY5VgbevHrbtEgDKVUH3v4mkkwX1Oee1t1zarucSIf5cNYz28f8z9Wx0sQoY/UTI+mDyAQk/u0thkiSwYJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473719; c=relaxed/simple;
	bh=Ot1113sdR4ICLww8kH8UrumoMzAywen+S30YAGh6fWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1YW2L3+HQjIKdMrUAC7G858uZ/8R9NAcLQsTeVn/6bCUIsG0mHYMvKXaq2wYyv64gSaxyBJeopc+D9IjthmL128+4e4LME0px0/H/Yfcn4NXW6Df1nYkCYj34PffjGk5UPHFVIPxjdXzr4QRbfH3HaehxSIC6tuRXjA9VSs6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7GV3DE3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKMpl4wt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766473716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10niOhLQWj8MZ1UX89LR/k7WodLz7bBsvamkj7DQNao=;
	b=G7GV3DE3JkWFfSxx6NxuQRh44CwDl8g7r7P1511ECE5e8p0f0moW6N7N+3bPNTKR27jgok
	Qyg7WeKODvPL8SaoGby30Z3ozmqN3uq/G56Ta/SoOS61LdAQwvLzBAVEh/8y+v9RlV8CV1
	j9FnYxC95LaYtxtjrV9VRQUDAFaXvcQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-9BAJ4wtdMji4XIVWkSWpiQ-1; Tue, 23 Dec 2025 02:08:34 -0500
X-MC-Unique: 9BAJ4wtdMji4XIVWkSWpiQ-1
X-Mimecast-MFC-AGG-ID: 9BAJ4wtdMji4XIVWkSWpiQ_1766473713
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43065ad16a8so2210001f8f.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 23:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766473713; x=1767078513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10niOhLQWj8MZ1UX89LR/k7WodLz7bBsvamkj7DQNao=;
        b=XKMpl4wt2llCEackzl4Gv+41R48CAiCr6zmCjEPGhh16oCWA6odVpYZ6WD2WsbfTrb
         xbXxFsk9+s81DT7qYUCUviOtafZuPoPLTTBjCq169NZ+nIAAplIE0e2OSqq00tvDDW5R
         IPmL8SJWHvS7YZ5tnDDBehPAWGwuBsxh84iXeuhtmtWbtrgnDSlfbwjwZ7NfFhkwsMK7
         mIe6/CFG6VXAzcQ2YxoS6q66Wy9KYCSJ0jqZv5fOmywuCbmrio/AJO0/LKIFEXMU9HsP
         g0S65bNnMnvEltZ2Y/4jxCUN2KE30D4TNnzu0Eq2O1nbZuhxCsmzXJRbWtAWK978L4/N
         ahTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766473713; x=1767078513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10niOhLQWj8MZ1UX89LR/k7WodLz7bBsvamkj7DQNao=;
        b=CczHqJkBA7kotJsQTQ/J2eWrpr7FSu/vZ9Kup2tY5njHnruwyi3u0shdpKirWMpXla
         6i0b34egADuuMfM0gEi306hmGEStWJywi0TxCVLeUF7gDLNQq/HzqBLdrWPzFDxnf/iw
         +sT1upRcyTwtSq1BY6DPSmdF3SQkOQul2N9cl74mxA5nVGaxk7iQ2vKAmxe5deqHlbsp
         FgLb64Dbw3VVZ995U2kZ5ODs7aLAPfiLZhVwypRCnoLJZ5WhN0hqkzhkDKk9onwAadu5
         ppGkpIHNBKVPYW7EWasdLpjo/HSAUCAzYLNefoCCBP706SL5Y57SrygD1c6pkDftWHqc
         V1aA==
X-Forwarded-Encrypted: i=1; AJvYcCW/j+rpQ+0knSAyyAgFFSJeo1YNs8xraYi1JsGcsCZ4l85OSJwzZRPeKE4fTY40f0rKzGK+Ajc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6Vu3PnjeuseeblkJHskm7R/Yj5JpoU2BBJ3exEJRbZ51mSOC
	KJyxocfmDO3QGFGjO/6WK1zqvrxh+u+gMyOtBALPBVL/8gBP9L7lXtIWSwi7hdMvz1HSVW0sjBT
	Xe8w1FWHaP7yfmPwtp2Mrhew7JbdA0MNabkFKbE4prbT2blg0u8ODq2uxIw==
X-Gm-Gg: AY/fxX60BQ50DL+1kDkGmtNgjNqC+CAWjosU+k944o41VxK8/bMTeioWWIRA0od7Bb+
	JMX/P+o9ao+w6nB4mF6HsoGkzxKd0JfM63Nr8tVwHx50kJ+J6n9JO9mzmvpElDVNu/+ERJKh2MQ
	yGM05BLE4SupccpmssY2DdwBocBAMew5npHcJjXk+Z2H4y8IZ/nAFGThRGKx4y13saKS/GBrfqY
	QsJoDqz29w9Fpo5k8JOYlBnWr+tL2kdqFsGXAMq7ZizJ1lGASZ8migQ28ini1Xv9yU7Vn0xiYBa
	A/z98G287DL1OAhCplr9Y0FWyYhyn5y6elzPRoh6o/3RuX6t89S7PMJ6fquyfBo6cV07WlutCVy
	W+W62rHrm762s
X-Received: by 2002:a5d:5f54:0:b0:431:2b2:9628 with SMTP id ffacd0b85a97d-4324e506ba3mr13554575f8f.52.1766473712768;
        Mon, 22 Dec 2025 23:08:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2/F9cxhPn5IdB9dXseWhjktn4DNI+GITUDnXyOaDGSylCJE8I4qOMs0JTw7LLNZQx/CkEbQ==
X-Received: by 2002:a5d:5f54:0:b0:431:2b2:9628 with SMTP id ffacd0b85a97d-4324e506ba3mr13554539f8f.52.1766473712281;
        Mon, 22 Dec 2025 23:08:32 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm25879368f8f.0.2025.12.22.23.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 23:08:31 -0800 (PST)
Message-ID: <a9e7c86b-1a08-4ea4-bf41-75d406a13923@redhat.com>
Date: Tue, 23 Dec 2025 08:08:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 00/15] nbl driver for Nebulamatrix NICs
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 4:50 AM, illusion.wang wrote:
> The patch series add the nbl driver, which will support the nebula-matrix 18100 and 18110 series 
> of network cards.
> This submission is the first phase. which includes the PF-based and VF-based Ethernet transmit 
> and receive functionality. Once this is merged. will submit addition patches to implement support
> for other features. such as ethtool support, debugfs support and etc.
> Our Driver architecture  supports Kernel Mode and Coexistence Mode(kernel and dpdk)

Not a real review, but this series has several basic issues:

- each patch should compile and build without warnings on all arches
- don't use inline in c code
- avoid using 'module_params'
- the preferred line width is still 80 chars
- strip changed-id from the commit message
- respect the reverse christmas tree order for variable declaration
- commit messages lines should be wrapped at 72 chars

Note that you can clone the NIPA repository:

https://github.com/linux-netdev/nipa/

and use the ingest_mdir.py script to validate most of the above check
before submission (otherwise you should do that manually).

However...

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


