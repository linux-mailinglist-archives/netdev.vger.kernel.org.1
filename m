Return-Path: <netdev+bounces-206464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A73B03340
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 00:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EC018984EE
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 22:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0681A256B;
	Sun, 13 Jul 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngjhAg4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25711531C8
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752444104; cv=none; b=CtjrGplegbaec851D3trJRMrM++ewj8pPw9YKNDhb5OY3sR4OFrvnM9wowCD/+eYtNUZEYLlP1zmbnlAX9dwcCvIe2/WLo9eY2PNMCImJLLpZuonNv1Njf6g9cI/ANNCUUNClMTiR8LHpDZ2Frtt2wm4k9T3qPFWHi3F09BwsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752444104; c=relaxed/simple;
	bh=yZvXkx/I7z47vp0Nv0vWrIs/KiyJ32Bq/JRcQCe02sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPMSvZ+XQ4cipz05UShHSlBaLhviJpY5fMWq5GHnfidRIGWOJDHzYsYclj8867oVu2L/5BK2o72muQNG0fxb50yPgiWrA3JRGaVtjkcSTenpsLwzNHR0K8G6pqaG3vdZisY4+6g9OpuWRcoiFa1R57vMsse7CIcV1xvbKzrQ1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngjhAg4J; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-749248d06faso3088037b3a.2
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752444102; x=1753048902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYOO/ULSytE0a0IhOX6z6bTnRyN0gKDUjj3II4GOsiI=;
        b=ngjhAg4JIz0nUwrvT4LQiWDqy/317U6jg/dqTfNnXjIRetMG+FHDSDupCCcbF0tpXI
         l5HYkh56mV0QcsNMNo8M/USvYsjryCXcWx5On5/bpQ1uPqptv+Nd/Lazsk/Q2aZ5N80l
         sVWLzNNA4bzwiHg9KUNZeilbwZblusJmjK8Rgd1O8KidyMXfcJ9Ohr/lxX40+BoPcr6B
         pLqhsFELDHJ66FuyxIx5535fXzneQUTJSEq0xNlmWTIZ6xP7T3wRfkAvWssWCWyXT+8b
         LtppzA+etXjy/GuwNSvBJtcc/L31+3nQcjvrdE+14NbZvQ2GSOt3+KLLffNnLQlLGKyV
         nCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752444102; x=1753048902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYOO/ULSytE0a0IhOX6z6bTnRyN0gKDUjj3II4GOsiI=;
        b=ZwEZzKLmCYcMgeDBPyYGG1+RRZ16gnfsKwhPTdm7nTyoQSFVCVW0yHCfuy4G6zt+wk
         XJ90L/79fKQVdzH7uoVs7k1/BExfJmgj5/Dvhk+LtG3bP70pSVizavE/4VJNmFBtbxOl
         mhuaqjHqIAqObVMqvET/nj8Bz0HHfru0xwjleQ59bLNwg/H1dbirnpc+o71xyim3P8yp
         cCthYMaj81QKOoAUIsrW0d8XWJmQIEt3VITKJamrCaBx4xo72GEQSuOgtcCbpSUzUuuH
         /SMQD07kxPJYDMzbDJiLtYtMv7YLcFYf5i1kFBLlf929xbQ6jnQFilOE5bhjNRkuj1CF
         aVww==
X-Gm-Message-State: AOJu0YzrjOgso9yYKwadNDbXdoOZdU9zKP4VmM/Pwgw0tU2Mw5b6RvuD
	xCnq77Jk3klMT8poqYPWHZJN5T6ww6evZ+atiZkjPGSjUDEYdoVFwQXBFEtMdg==
X-Gm-Gg: ASbGncs39cj/ppydyJZCi8crtTHexwjIDaATNwOeXEHlkkJOv1Qbyl36fKRPoZ9P3fg
	MDbs5gps9AZzZtuPeavzcJWVK6KBoXnTsq6L5y5Sv3Y5USVMIeKpRPi3lEnKFskFPIkcHeZzmuC
	3lvv2vwg+mnCZqdmlJ6+wjoDxn0DF4pRmQY4h2NhqsJumTVzcW4Hod4v6/9dvpADNsBbEZ+nW0B
	A7WhZFjIkP0q8N1J1F/pGDNmGreKRjO5uqgkj6Jjr9rPVZ8EEKhZbkAtn1cZc8MtpbrRPou4l6E
	nSWGYQsmNv+t6TH9Hal12jF/QSUsyeH+TdNWnSYDSZwhB85+ygyVYRHdDnF8NSYnFdykKQntqAr
	jL72VOFOq9k1tYdY4BwvPlYdUx0gb
X-Google-Smtp-Source: AGHT+IGaFSZIx0RJ99WPGpWR8keI+NyDiaPiT87rzO45euyY8dcXTJ+/Lm/YC4iekmFcBgBcESCC9Q==
X-Received: by 2002:a05:6a00:2e08:b0:748:e772:f952 with SMTP id d2e1a72fcca58-74ee304e78amr11492867b3a.17.1752444101587;
        Sun, 13 Jul 2025 15:01:41 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:b9d2:1ae4:8a66:82b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06883sm9652884b3a.63.2025.07.13.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 15:01:41 -0700 (PDT)
Date: Sun, 13 Jul 2025 15:01:40 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, will@willsroot.io, stephen@networkplumber.org,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v3 net 1/4] net_sched: Implement the right netem
 duplication behavior
Message-ID: <aHQsxMkvvyvJvHrh@pop-os.localdomain>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
 <20250713214748.1377876-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713214748.1377876-2-xiyou.wangcong@gmail.com>

On Sun, Jul 13, 2025 at 02:47:45PM -0700, Cong Wang wrote:
> I tested netem packet duplication in two configurations:
> 1. Nest netem-to-netem hierarchy using parent/child attachment
> 2. Single netem using prio qdisc with netem leaf
> 

Below is the complete tcpdump output I had for each of the above setup,
just provide more evidence here since a lot of people don't trust me.

(Don't get me wrong, it is obviously my fault of not being able to gain
trust).


[root@localhost ~]# tcpdump -i lo -nn -c 20 icmp
[  589.079074] lo: entered promiscuous mode
dropped privs to tcpdump
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on lo, link-type EN10MB (Ethernet), snapshot length 262144 bytes
12:59:23.485638 IP 127.0.0.1 > 127.0.0.1: ICMP echo request, id 5, seq 1, length 64
12:59:23.485844 IP 127.0.0.1 > 127.0.0.1: ICMP echo request, id 5, seq 1, length 64
12:59:23.486714 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 5, seq 1, length 64
12:59:23.486996 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 5, seq 1, length 64
12:59:23.487867 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 5, seq 1, length 64
12:59:23.488163 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 5, seq 1, length 64


[root@localhost ~]# tcpdump -i lo -nn -c 20 icmp
[  361.831773] lo: entered promiscuous mode
dropped privs to tcpdump
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on lo, link-type EN10MB (Ethernet), snapshot length 262144 bytes
12:55:37.074400 IP 127.0.0.1 > 127.0.0.1: ICMP echo request, id 3, seq 1, length 64
12:55:37.074606 IP 127.0.0.1 > 127.0.0.1: ICMP echo request, id 3, seq 1, length 64
12:55:37.074806 IP 127.0.0.1 > 127.0.0.1: ICMP echo request, id 3, seq 1, length 64
12:55:37.075012 IP 127.0.0.1 > 127.0.0.1: ICMP echo request, id 3, seq 1, length 64
12:55:37.076508 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.076789 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.077069 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.077404 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.078825 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.079109 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.079404 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.079927 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.081125 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.081477 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.081763 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.082044 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.083253 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.083534 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.083816 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
12:55:37.084101 IP 127.0.0.1 > 127.0.0.1: ICMP echo reply, id 3, seq 1, length 64
20 packets captured
40 packets received by filter


I didn't include them because the patch description is already very
long. I am happy to add them to the patch description on request.

Please let me know if I miss anything here. I am very very open to
continue iterating this patch.

Thanks!

