Return-Path: <netdev+bounces-225506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73760B94D90
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973B318A82F5
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC831197E;
	Tue, 23 Sep 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb+jRBoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B7548EE
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613644; cv=none; b=IdB6fGgtlDRY/+LEm5FrilJfqXV/4sCm8axzeN0MNYkA+oTgqZYZ+UzBqNjSsMHb9ugGotQ4/5n2MwdpKVrbIIciykfWpNSCIngM83VGhz0ehrhxv199o3BvGkM02tAUhNAI4G/YAJmpZ8ZgfHKGScLnLkOPc7Un5MMenAzDlzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613644; c=relaxed/simple;
	bh=m6w75x5KmuboRbte2t8Bef+Y5vLZQaZtpC0JTZQjfAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHue9zICSbl/cSW9o3Y0vmRIYGx9W6u3WTEaK6JOJzpMQGmghw3Unt6QHEPzRmM4MVBlujCkQbyd1k4Q3k22la9A9z0bEAIkhz1CJICQR0XcndWx8KutWGyDgtzFw3DZ5xAebduCK3PdyyeJiOJGt4NQMVp9VgqrK8bles3O69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb+jRBoa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57933d3e498so5621109e87.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758613641; x=1759218441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3zTrXIgrjNde7MVV+dQe94AXCJb9BQSJNtQ02xJwZs=;
        b=Hb+jRBoaW25Oj5LVwuGp7pHGOFDrDFFhIeie7Dfkq7+H92LLpf9dwG1qxKUu1KIpXK
         a/+ETLzxr+qq6Vfu9r4bMk8iF4z14DgqEzefgubl9MbHat1K6GPmHCzsRMZQsn5cli/c
         y+37BqQKvT056OX1pmV4nkBy1M0tOrXJHHLYTX5/30rCKPjKYURVGchkSCOFrYlF4kYg
         K9GkjJZS9AVEAOPnwxvU+Ng0lgrJH6AQ0sDuinpD6dC9iZvf9aOw6mklkaMgK1VN7H+v
         dySneeWOdEqBp330cNJV29C5OkWDgrMoYCVCQzyX13KEXMEYYJrzzMLTweOkWEVbfzqL
         fAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758613641; x=1759218441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3zTrXIgrjNde7MVV+dQe94AXCJb9BQSJNtQ02xJwZs=;
        b=MpI6I0cUUUKDaY3y+TrBvZ8NWFNWJmFfyojgL1f5ImgW4UaMNPceCs2dc2JwQPYOUo
         YkkDkgqRaPuMldefvKbbsjXV3+2BajapsXDRPlVmvcsI7JH9Cg1AA8cQJTaz6HGhKgvO
         A9+OWcDBFkVGEqq4SlAHI5lMD7h+mq36+4GPjXMcxXepWWFf7EU+UrAjtRqkuhQ0p5Qs
         XFSmNajCrkQCLr8p780Ud7bgfve1tlXgQQg5ZCDl1GyNbnHsxnHNiSQIccU/c11JTV3U
         JuJBNMTA/Y34zVy66V163zNzUrnBUsUk9UAMfdtaMRo8QfLgBIJEgIFvGS8pHhKMz36B
         EyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCGWEA9P18cFb+Yh3XWK5z5VVqUIaVak6B6QqufUte58XLmHd6ZD+CTmTr8xtaZmjeUB+hDow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvkMtjB6FnRe3CGRdJ8U07/a3brAiXHWeAEpoKShVTaC1e8sIV
	Z6ZOWBnk5HNOwN8wbUQKRznl9av3cYdXqnZ5X5mk7UpBskAssuqsgsdu
X-Gm-Gg: ASbGnctfnkdcxsI01+Vv+vVIcw8QYaUwI4t7JjQ7QJRLVio01ftqv4LLCQ1gdlA8eyZ
	wjTBMxMTwfGaIJ/+p0r6jwyJaTimQ80rBRxymv5mvxz+xHaKLhfZfMHZ9vhDEyV042sIhojtIg7
	0EO/DffHcmeH9JPqbfGcHMZt0HpJo08yUTF+h2PhAxpPfH30WTrcdiwmb5DYZJUHeyfzf5i40gf
	HJiWiyvBTh+CfY5Sw+Dy0sn8SoFb8+uHi//N8Wg04E8TXJDM3RcKMBy17ek7pLf6B7n4RRCJJfK
	X3nFT0bsIVjhCGle/LEGiy2FlMpjrSwaD76W8Qr/392rHDJLPUJcCL2zbwAg5D3CxvhS8c3916X
	f3ESLNQx74NL389rUzEbWTl2E+WwSrn3WmpI=
X-Google-Smtp-Source: AGHT+IHdpC5HbX3ix1zT26Flp+EGyUUBeKiByHFSuNEWqr8rJkXfKIJvyKcJk6flJER7ibjGFmTI7Q==
X-Received: by 2002:a05:6512:4207:b0:57e:1e1b:dde5 with SMTP id 2adb3069b0e04-58071403f46mr357677e87.25.1758613640434;
        Tue, 23 Sep 2025 00:47:20 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57fcb89170asm791542e87.63.2025.09.23.00.47.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Sep 2025 00:47:20 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:47:11 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: I Viswanath <viswanathiyyappan@gmail.com>, andrew@lunn.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, david.hunter.linux@gmail.com,
 edumazet@google.com, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com,
 skhan@linuxfoundation.org,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250923094711.200b96f1.michal.pecio@gmail.com>
In-Reply-To: <20250922180742.6ef6e2d5@kernel.org>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
	<20250920181852.18164-1-viswanathiyyappan@gmail.com>
	<20250922180742.6ef6e2d5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 18:07:42 -0700, Jakub Kicinski wrote:
> On Sat, 20 Sep 2025 23:48:52 +0530 I Viswanath wrote:
> > rtl8150_set_multicast is rtl8150's implementation of ndo_set_rx_mode and
> > should not be calling netif_stop_queue and notif_start_queue as these handle 
> > TX queue synchronization.
> > 
> > The net core function dev_set_rx_mode handles the synchronization
> > for rtl8150_set_multicast making it safe to remove these locks.  
> 
> Last time someone tried to add device ID to this driver was 20 years
> ago. Please post a patch to delete this driver completely. If someone
> speaks up we'll revert the removal and ask them to test the fix.

These were quite common, I still have one.

What sort of testing do you need?

