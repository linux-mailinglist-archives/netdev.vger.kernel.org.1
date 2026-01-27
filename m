Return-Path: <netdev+bounces-253771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CTgB3WEeGmqqgEAu9opvQ
	(envelope-from <netdev+bounces-253771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:25:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7561091A87
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4098D300E707
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98792DA742;
	Tue, 27 Jan 2026 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L8oO2AK7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332782D97B5
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769505840; cv=none; b=rUTdtOarGlfPNfQ0fEg47pNeOhr9MDfvv8onpvhS+ZZk5LpZMMu34QmHNQS4Kp2WUzBxjudurnVx76l6Ju5+jRBRDtVxmA2/ZSkk+0+E+1SejyEbZ7RPrG+wYphHUp+9ImQOp1XbK60leWcQQw4i5JK1WSSgLGN6aXnai+jqUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769505840; c=relaxed/simple;
	bh=1/iUH8Y51lHdcNvj4qwjV0K0QoMu7X33Yn+rwXhA858=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3LDQAX4QE72y6jaJOcB5KlsMA/lXhMWZg4DyWSt5Ad7+3BzLCxnnx+MByTPuoOc9Y4P7nGx52V/ZsvJA8y3eI9zNVB8HNgFafbFhMZcIr8mw+05enlOQOE03E0qybsoo+wmbW9zLKQo1s3mOHqBg/2TNoL8hE9Q4YHIsuAlPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L8oO2AK7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso42644255e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 01:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769505837; x=1770110637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rymuFbvBBtXY/nydGoduhBnxQ6RXb+ltZKTsRxuPdI=;
        b=L8oO2AK7oGrkxWF+I/gEO44Rm/U7Zui59Gy9tJTOt21nK8l4XoRvQTmDzLe3K0zkHj
         y7AC6XwBGX9jQP5IFnBoRpaewQY33f/+3y/WIdPwjrnslfeE88Y9b81ABKDNxdG0ZH7K
         vKR97tLK1RzCTZCACIZ9Jz5w7s9ivKFlKyTTSQh3OjJ8MqdfBQ8RNoMoLNq3KfBQHhqf
         2oM6ISSA77XC3j1pwwDVzr6Nz3mDWPYhRdySklgl/zlnGC7fLW6/+ZWCuz0IrMU3eRWC
         7HJg6QhX92fFTGQZb1AV/I70IA6H74EXV0fve584O647drOiF34covmuVRVB6GArWa8n
         E4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769505837; x=1770110637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rymuFbvBBtXY/nydGoduhBnxQ6RXb+ltZKTsRxuPdI=;
        b=GR4rQlVlTcX2WI5kP6MpTb2aVOSQfo55xXKrViumwLAlR8RsulyxzgDjDKMXkL4L8q
         xY0AtRdyNKv6IgIVqb5h/dGgmYz/cYeXYK0unw3G5qgTuodJQs3C2kS3n06Aghhm8t3i
         VseE4wbP/1TaErLkcMIB7QPphjooluY7+TKKpvUHOz47MT2wl/9G3nPK7BOCPdzgAE7K
         xDDtfWuF1p8CgtDo/YejI0cmozGx7TUoXDsoWr5uWGfaHGIXS1pNs5BO3TCgSaoNfkmf
         OEIE15fQVXm/aguMHiIcMhmpk4eycyCjAxvDy1rGcULuOAznh3Q+zU4GIj8nSmIf97qb
         7hCA==
X-Gm-Message-State: AOJu0Yx8HXx6enFEV3FW/ZLd9WI+DgkzTE2uIjJWRFS599bTMhyPCwQt
	A2spp6d0/9ZXkjwanS6OotpY0ars7GeNKqXKefxVIEUfH0+1hf5lRDJZECAryyaKBCI=
X-Gm-Gg: AZuq6aJ6e0r6N1nCb4NluRUCxlTcmaBWCXCh3ARG8sVxRNJTZv9i6DuMrov0sYzG2gu
	MczbKbA6nYr+b+330VkWQ5L+0lFBMGxevyVZEMA92WKZkrQwSCjo22d/H1Wtf9ixzh+f9WNvfCn
	hpOclfNcZidpocA446GZbDnA2G0aLV1eVTOt8NZxU0niqbqGnK2gdJm1U2SmvMi/g9XUxOj2gsJ
	nO1lCvM+IJ58SR1ndeXeWAPAopzsp5mVXVhsVvQOI6eAwpGw4STUoEjwf6TxsttYcC7C6z/0IcO
	N5MT4vKNApodPUZGOFWmdvGuot23xRq58LETpKNQekHzUDko5ObJb+zFruGQXHVhtQ4ZiTU7/nx
	SHZ7pOvSicFskVcX+r99aZn08t9o6qVbhjzDCtyNWjKSLmNuR3oz1DE3IbxGOhC3mzn0kGoQE0I
	6eA+oxd+QlbDepnvhXb5WfulS1/VLmQd1ZmHeJB7IDj/ZuK8hoT7dy+LQ=
X-Received: by 2002:a05:600c:4746:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-48069c5547amr12943825e9.30.1769505837492;
        Tue, 27 Jan 2026 01:23:57 -0800 (PST)
Received: from ?IPV6:2001:a61:1310:7401:36c8:bb62:3315:2c36? ([2001:a61:1310:7401:36c8:bb62:3315:2c36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24bedsm35318025f8f.17.2026.01.27.01.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 01:23:57 -0800 (PST)
Message-ID: <314effcc-5bf2-47c5-9757-aafd5b47fe65@suse.com>
Date: Tue, 27 Jan 2026 10:23:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: usb: kaweth: remove eth_addr_t typedef
 and bcast_addr definition
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260125083501.34513-1-enelsonmoore@gmail.com>
 <20260125083501.34513-4-enelsonmoore@gmail.com>
 <9239ddef-c197-4fbd-8e88-691766bda3e2@suse.com>
 <CADkSEUjgRrC9eAQYOkaErd7wyXKkUs7+dG+Q1jz7VbqF+zxwuw@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CADkSEUjgRrC9eAQYOkaErd7wyXKkUs7+dG+Q1jz7VbqF+zxwuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253771-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7561091A87
X-Rspamd-Action: no action

On 27.01.26 05:38, Ethan Nelson-Moore wrote:

> Hope that helps you get a sense of how much these drivers are being used.

Hi,

yes I am aware of this. Yet there is no point in breaking
existing setups. I would prefer this driver to get only
clear fixes and adaptions to changes in API that are absolutely
necessary.

	Regards
		Oliver


