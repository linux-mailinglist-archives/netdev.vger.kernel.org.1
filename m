Return-Path: <netdev+bounces-154751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B019FFAAC
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E421627A5
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0E1B4128;
	Thu,  2 Jan 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="pjCLrNkS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F01B3724
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830011; cv=none; b=ul3RErg/7rNcqRpB6P1sduKM5GWluFLMesMMc0Fnv9Ppd5CS87p/ByWDvkxK7RNWWFuyYD8sto5AYLSwnnXOJg87gA/u+nrLVcbMQIBEdPJJWYwyjoBz9si234tqmrA3wU8pRxnzPJG6opDfPh5WAsaePUW//BU6z4IoV/D/7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830011; c=relaxed/simple;
	bh=csej4I2UFTqPFljkqdH+u06HIdOpUkuSRuDuYgIjIA0=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7y+Fpc4q0gHFK19XTXRoKP5ZuAhHJFXx+aUBsBfzrLMrvPODBv2pAh96Hztj5JOfc1Rgw7o/ynUS37xLD88j2M3GGY1i06VmptDKIzX15WzAvni9cNY01zeM1aoI5toNYQJ9qlf0CeIcJQsTTK/I3jw8/MP3+lcvzAf+TnQD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=pjCLrNkS; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-21636268e43so68664725ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1735830008; x=1736434808; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVWv1yG28Az/TllwbejOqQ1NzoDY8ivL6MBIugj2JQA=;
        b=pjCLrNkSR0pWXhPZ6v5MEWRw+ILlJHL8rQb0YCP4fQsuYecI/i4fIa0evVE9WT5mlZ
         pYsg757cC94QODJuJBHvi9mldSJPZS9aRJybqBHRgiJbA575r8qIAEgL4JjyxZ2gFdhH
         fGG/OZ8YGsUIzAmgX7lwm4R6hO732CeRJJZYOWLXtRYl1jRHbWOR7qY4JssGnoJ9ev3H
         b3lXNXXgIzWcOkQl0A7XeufzFp2TETybekziql9nwGeUPhWPRNzrphEmg0o2ccufHmhy
         aDVtCUYuL1oLzPM6L9RPEozIDu75OEnkBYRSFw5NnY+DfPb8WyVrIG+l+D/YXklQGPto
         XBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735830008; x=1736434808;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVWv1yG28Az/TllwbejOqQ1NzoDY8ivL6MBIugj2JQA=;
        b=oRTiBcP4PRAs4jLueBPvUKv7i6fatezhXcI2a/XC6yXWi769MN2mIxnGU7EqkADD2q
         diO+qkzH5hbbbRBM+t7bD7ZfFXmRKtnbcUHc0GC6HC9vKE8i+aESdeth9BRnhW3icFPq
         39yEcsYUI0IOIJLqmWdd+dXJmZudCis0QFA2rXQ7M/jnqXhCsnJ6C57Vo/v1yndlGfa0
         mt3T6WOJagzS+RT6gt1XRMxiEzpOzwAeP2ZwYEcFikLyGnyV/HZYq+zaxhoQ2yGI7V31
         ifxVdM+AriSRGquoGFLzCm+PEkfEDSOeHTpS3R48ADwNhoL8v0YcyKmM7Q/5myzW3CQj
         RJhw==
X-Gm-Message-State: AOJu0Yz+wCbsSktQI2uuf5bYqQBhNdj709vj7sr6SbG/46frxjD93prN
	FJjL+sNMzlYwBAmic40/HwNY9Dq93G1RH6FvnZWgR/WXFVnkZkTlPr3Q41xYJiM=
X-Gm-Gg: ASbGncstYxESAgr7arrVjSLRr9PMeVPUYMmu7J9UGN9QH5nbpzN8Zwmuh70hiwFOdgv
	TS/VPXVQECqYXso3xbOQnOFf7YoyAd8HYwmBnwsDOdMzvBgHrRSXORekJpw5lzVTdwvyWFBn1hK
	aFjnaoB6IXT2XrKSFYsTMopiphXTEM1pu9N8lXuiBZNWjl7VlLrN3GQwSf1TsEqAtrbLpwcjtwp
	nycCK/4zVYIrgg9WQHBvzXmLZwiuU8/9eog27s+V9oXsE4VvG7mDq56lsQ3QokGl2DB
X-Google-Smtp-Source: AGHT+IHdfKh9fsUR5Ni2yjx+vcQUvdBgpinqCPRVr5B9m2FPIjuYlnuF2MUvr1NG5+bGBP++X/BngQ==
X-Received: by 2002:a05:6a20:12d2:b0:1e1:3970:d75a with SMTP id adf61e73a8af0-1e5e0458eadmr80010227637.9.1735830007949;
        Thu, 02 Jan 2025 07:00:07 -0800 (PST)
Received: from muhammads-ThinkPad ([2001:e68:5473:b14:5c5:4698:43ff:2f5b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f71sm22551306a12.9.2025.01.02.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 07:00:07 -0800 (PST)
Date: Thu, 02 Jan 2025 22:20:23 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: [PATCH] Add NMEA GPS character device for PCIe MHI Quectel Module
 to read NMEA statements.
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
	<johannes@sipsolutions.net>
Message-Id: <Z5TGPS.PN2YJKFH2CDV@unrealasia.net>
In-Reply-To: <4b576e34-ec43-4789-b18b-86d592f9d031@lunn.ch>
References: <R8AFPS.THYVK2DKSEE83@unrealasia.net>
	<5LHFPS.G3DNPFBCDKCL2@unrealasia.net>
	<4b576e34-ec43-4789-b18b-86d592f9d031@lunn.ch>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Andrew,

I'm actually new to netdev and the main kernel.org documentation on 
submitting patches 
(https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html) 
was not clear on the commit message (or i've missed it).

Thank you for pointing me to the netdev maintainer process page.

Anyway, i will make a new v3 patch tomorrow on a new thread to address 
the issues you mentioned. I'll follow the guidelines as you required.

Sorry for the mess.

Thank you,
Muhammad Nuzaihan

On Thu, Jan 2 2025 at 02:22:15 PM +0100, Andrew Lunn <andrew@lunn.ch> 
wrote:
> On Thu, Jan 02, 2025 at 05:12:41AM +0800, Muhammad Nuzaihan wrote:
>>  Hi netdev,
>> 
>>  I made a mistake in choosing AT mode IPC, which is incorrect. For 
>> NMEA
>>  streams it should use LOOPBACK for IPC. If it uses AT, i noticed 
>> that using
>>  gpsd will cause intermittent IOCTL errors which is caused when gpsd 
>> wants to
>>  write to the device.
>> 
>>  Attached is the patch.
> 
> This is not my area, so i cannot do a full review, but a few things to
> note.
> 
> Please start a new thread for each version of a patch, and wait at
> lest 24 hours between each version.
> 
> The commit message should be formal, since it will be part of the
> kernel history.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
>>  @@ -876,7 +880,8 @@ static long wwan_port_fops_ioctl(struct file 
>> *filp, unsigned int cmd,
>>   	struct wwan_port *port = filp->private_data;
>>   	int res;
>> 
>>  -	if (port->type == WWAN_PORT_AT) {	/* AT port specific IOCTLs */
>>  +	if (port->type == WWAN_PORT_AT ||
>>  +			WWAN_PORT_NMEA) {	/* AT or NMEA port specific IOCTLs */
> 
> This looks wrong. || WWAN_PORT_NMEA will always be true, assuming
> WWAN_PORT_NMEA is not 0.
> 
>     Andrew
> 
> ---
> pw-bot: cr



