Return-Path: <netdev+bounces-247910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5ED007D0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 01:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21FC73014AF5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 00:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BCE1D514E;
	Thu,  8 Jan 2026 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRPfGZK0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7571A23B6
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 00:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832965; cv=none; b=Xs8iEJvtY2UAHkONY5Rj9FjyO9EgBbq4M9OUD4UPrgdX0rlRmeAxqQSdbxLwuQwVmfuQSwg0U6N8G4abi5PNpwYNPLwbk7o/9chEhOR26mxJirJWG+Jn8UyDA5IB3eZOBs2ZPS+WJ35SCHjmo5XlddYcOE5YSElmzorFkpcVoq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832965; c=relaxed/simple;
	bh=9r88JtSZ6xGnZCA8BUjHISgxh3ySwofk73N/9vkt6PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojMrrVFam54aVEnmYcM9rWedcrlQBVHYUHTQqlncTy23opiDCeixAYB7sDYICUVRsN5dgFxrLb82fvkLWgoBG1d2id7gs4fVtcmfIT+cEoCC63nWaxJI4ec+yakJgea0pRyKeNCv75zervYJkVGJ2+JaJdq3eCL3WrktoSILjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRPfGZK0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso1039509f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 16:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767832961; x=1768437761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/9BEHPko6/406fwIeYINmqT5OrYPin1DACgb6PeivA=;
        b=NRPfGZK0K7QuvYHnmcGT/v1cOr8XWLfMZ8BDcUhIuPWOez5LW9C3727+u3bWKJSuAM
         x0xFEUmLEQHpe9VssMLVNzpDJaIReiZHYBoCCYP0eDsXT3oCedokbXezLK6+A0S1cA0T
         W4pJiCaZXH6P8pHX5SdEd4RGc3lf02f4wXsGPgMEu8lUKP2U8Y1yYwqmmaGx5QJfjl1O
         dG3zY8Z4p01ip2x5qMxxTwSV4DwMlWaQCd9ceg4mYTFPA+gXx9DdXMdNfc+ia1mA6hVk
         eW3UydxdEpRtAFaf+1g0HbqYGQ0gKMDMin8+HZkaBBQAonm51DBPGlN0QkmKn82gwirj
         ncWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767832961; x=1768437761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/9BEHPko6/406fwIeYINmqT5OrYPin1DACgb6PeivA=;
        b=pl76F3En+wA3ie3lS/1pk7HuszgdImnnypzEmhiSH1+p4fYvcj31cckykyf77STDqA
         f6h2w0boI8yvuqYmJUvosrPnUmMr+Retad/9elxulyxaais31wc0vjSc+fid6aq6AT27
         WpGJGH0CYyudrKy6zac2WKKlV6vPSavqlM0Twqmr0gW+9B4DVptF5LXM1UkhJvT4AP7g
         9z+uvxBpD1AlTZfyfbu0B9WpFfSMFGREe/AnpJMJCPMnhIOtueOlqlCw1nK8JkFtbXl/
         ys2QKmMAXAqIE+qWdWDGC/Q+1sG9/C2sCMVsQ37TOiNHdufcLriP0ZeCTvf3bHf6TzwX
         JVkA==
X-Forwarded-Encrypted: i=1; AJvYcCX78yk5s0TwTiBjbH+79MiIeIikQbdjh3YxJVFBzmuRpza1VZH+9JSOAtoK3euzAZlFLW93hnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZNE3f5g295wlVJn/1ksxBZboXQFb0eROs/vTqsaZRjEfuRfA
	KkOFZGRMHf/c1W2W8YWLyvOJXP69JKUWg6TtivZbGa17MFfu0viG7667
X-Gm-Gg: AY/fxX4cFTwUKrifRVm7kEZyFZvzdEVrMRXTw/5NdzzbSGiOJVCFhQAvLivEoDkXgDP
	2+BLC9/AjtIQ1l7bZm9gPefISCljFCGp4Z1GnaAXyoGCFAJhM/MkGeemdmMsxqvZ3ksK74V229g
	Rp4f71K3ldUiuAXNGIpMZlZQGwDfVgK9am+u9GG0QnykGDiZ20fuefmU3aa1IqoAHW1m1ON93p3
	M9yC80o53hnCi5ea0JabCge2jEptxKdfAgY0w9EkBbR8OlrOltPHnmnLqFNJydCbIveCu4OHhdN
	OhgYSx4UOEr0fV/00nJrZLtuHRgjwGpj/qi+ptD0Xi/hjG2C3kvCZs8nQoqj13LYIklg2sMHQkA
	hx7SoYhWl2jFJWRn23Yxxg/Ympb6u7MBmUN7LDNVyEzZLTuJxyqgqPTmxIpnNQNoJG3wgZqn4h3
	KBxsUnzXfeZctJ9w==
X-Google-Smtp-Source: AGHT+IFTfQWgJn/mwY43/DpenxZMUgLIDYN3NOa3kiGMyzLgOoMz9GLFCupyFA0R0Z3yX3Mz7Ira5A==
X-Received: by 2002:a05:6000:1843:b0:432:b951:e9ff with SMTP id ffacd0b85a97d-432c376158amr6238838f8f.53.1767832961411;
        Wed, 07 Jan 2026 16:42:41 -0800 (PST)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5eesm13342959f8f.34.2026.01.07.16.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 16:42:40 -0800 (PST)
Message-ID: <af3aba1d-984b-46e1-824f-8cdbd774f89f@gmail.com>
Date: Thu, 8 Jan 2026 02:42:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v4 2/8] net: wwan: core: split port creation and
 registration
To: Slark Xiao <slark_xiao@163.com>,
 Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "loic.poulain@oss.qualcomm.com" <loic.poulain@oss.qualcomm.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "mani@kernel.org" <mani@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260105102018.62731-1-slark_xiao@163.com>
 <20260105102018.62731-3-slark_xiao@163.com>
 <BYAPR18MB37352E69CB7B685926A574B9A087A@BYAPR18MB3735.namprd18.prod.outlook.com>
 <65a926ef.5e4a.19b97551cdb.Coremail.slark_xiao@163.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <65a926ef.5e4a.19b97551cdb.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/26 09:21, Slark Xiao wrote:
> At 2026-01-07 00:49:50, "Sai Krishna Gajula" <saikrishnag@marvell.com> wrote:
>>> -----Original Message-----
>>> From: Slark Xiao <slark_xiao@163.com>
>>> Sent: Monday, January 5, 2026 3:50 PM
>>> To: loic.poulain@oss.qualcomm.com; ryazanov.s.a@gmail.com;
>>> johannes@sipsolutions.net; andrew+netdev@lunn.ch;
>>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>>> pabeni@redhat.com; mani@kernel.org
>>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Subject: [net-next v4 2/8] net: wwan: core: split port creation and
>>> registration
>>>
>>> From: Sergey Ryazanov <ryazanov. s. a@ gmail. com> Upcoming GNSS (NMEA)
>>> port type support requires exporting it via the GNSS subsystem. On another
>>> hand, we still need to do basic WWAN core work: find or allocate the WWAN
>>> device, make it the
>>> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>>>
>>> Upcoming GNSS (NMEA) port type support requires exporting it via the GNSS
>>> subsystem. On another hand, we still need to do basic WWAN core
>>> work: find or allocate the WWAN device, make it the port parent, etc. To reuse
>>> as much code as possible, split the port creation function into the registration
>>> of a regular WWAN port device, and basic port struct initialization.
>>>
>>> To be able to use put_device() uniformly, break the device_register() call into
>>> device_initialize() and device_add() and call device initialization earlier.

[skipped]

>>> +	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
>>> +	char namefmt[0x20];
>>> +	int minor, err;
>>> +
>>> +	/* A port is exposed as character device, get a minor */
>>> +	minor = ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1,
>>> GFP_KERNEL);
>>> +	if (minor < 0)
>>> +		return minor;
>>> +
>>> +	port->dev.class = &wwan_class;
>>> +	port->dev.devt = MKDEV(wwan_major, minor);
>>> +
>>> +	/* allocate unique name based on wwan device id, port type and
>>> number */
>>> +	snprintf(namefmt, sizeof(namefmt), "wwan%u%s%%d", wwandev-
>>>> id,
>>> +		 wwan_port_types[port->type].devsuf);
>>> +
>>> +	/* Serialize ports registration */
>>> +	mutex_lock(&wwan_register_lock);
>>> +
>>> +	__wwan_port_dev_assign_name(port, namefmt);
>>> +	err = device_add(&port->dev);
>>> +
>>> +	mutex_unlock(&wwan_register_lock);
>>> +
>>> +	if (err)
>>> +		return err;
>> Please check, if freeing with ida_free is required before returning err.
>> if (err) {
>>     ida_free(&minors, minor);
>>     return err;
>> }
> Yes, you are right.
> And patch 7/8 modifies this file as well. We need to align with that changes
> since there are some issues(we still allocates the minor even the cdev is
> false). This would lead to the release function can't release the correct
> devt.

Sai, nice catch! It should free the minor number on error exactly like this.

--
Sergey

