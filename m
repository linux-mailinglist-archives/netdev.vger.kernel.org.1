Return-Path: <netdev+bounces-171290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B019A4C5F2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F857A3845
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C91DB148;
	Mon,  3 Mar 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d1G142Qr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431784A3E
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017712; cv=none; b=hawV+NUG08tPZPUedooOq9JRafOuhy4U2xVHNj+OMYYLIAUxu9ARpnouABKG2p97+wc9kJ1e2uaH+jFM4huC5FCeV60ASgsg9w2qI0kJpg8VWwVMWSO7VZ/XJuD7IIChW7/Perxu1T8tkJxXQDjL7Z2LAEEoJavRsbAG7iX0aec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017712; c=relaxed/simple;
	bh=/nquOOHVbaRNBY7sb1R2HBNCjY/dAiq818J3FR+qi4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otfU8/90P1qBzaS6McN0BkC5CXrEa2fOAGb72nQ8bvu9YnYirtasb9x9BMluDrsVY2/a4J8r7Hj0syK0Akz/Bh0Q4VBg2vEYAtI5H9UgMi21TXlj3ki5V0cmht/ctU09hDAPtu98/ABJMYkdxgf1Ob/0zED5GeKLqovRMHjfkjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=d1G142Qr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso49858865e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 08:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741017709; x=1741622509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nquOOHVbaRNBY7sb1R2HBNCjY/dAiq818J3FR+qi4A=;
        b=d1G142Qrbhmo6/AqiIuDvTiRjntmuvKwGuKkAOYQ064Sjbg0pSZc523QaGjUBv7Ja+
         Rv6EzbfIZdF9jzf8HlgM4F+HfZPxwykz2m1wM8TSBIUA1VUUa0S2/OOqf2Sqde0GhIAV
         pg2NvUkk0vMEv+8C8qKpJeAx9uZ9lGB5cFeXPI9A76IHzIvr+R8q7qVX4hi7tlSD4NJq
         QUYZfJfvs3hvRgXI79oXfabRAt9RjmKS0TfPJB2+3M+zGN5Lw/rNL2jqxQrDzW+nKpP/
         MufK+Q9NpC/wV7CdM+yL2eoEvWdLvbAt3JmSGxVxhDwpm7NZfVxfhFa/8JeGjhuqlxne
         eBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017709; x=1741622509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nquOOHVbaRNBY7sb1R2HBNCjY/dAiq818J3FR+qi4A=;
        b=Zg2ADI9ZuaZ/7ZkUg3/wMUq2GVGqGB96XAXPpVSMf9P4qqKwmYZ3GsS2OdM0Viwcwc
         hhN3m/S8eWC0MZMW2mjNoNZXIQqoWsII1YVK7x4gvyalMQFNzX/d9sG0phULPPbNxXSd
         HGYVglWYJXdkCdYVaJXZi4DO+hUgcJOC9B1hVB7O8kUDTpFIVu9vV071l2TBDiQITbNH
         GCttN3WUe0DWVAikqS4Cwq8Bewx7xawLTKhc8TnuWEinrKNJfmshjP8l4E+ApwNwIbAr
         kaYbDwXqsPKUYMqzIU+MVrnnMSkxRylk0+fB5VHjmKkG4e0Xd0JeQ+I/Q2vsdVtbrEat
         P6Rw==
X-Gm-Message-State: AOJu0YzIBoaB+dy5BtdIm333pI3GYBQSjTAtzzXaWiEsupryOngGBTj5
	UKTRAiwsbIY/s4WZGaa0lD24bTxsXX7FjfKF/DmiEaHo6F+ppF0irqV3R6hl67Q=
X-Gm-Gg: ASbGncvoqcr1rVQmNOSJl+c7pTeaJ/YsWe1t0kv6a7fE+NroZi0m3fct3BalqzqpPkk
	S7zqDx+Jaqg8023OIbq7OoNGKqqlWo8w/a8SPa8Mjd2F+1RkZ2Vo8IKbiklZjg053i+3ATKJPPf
	VqxGupaK1rNn0VUmbUPXYu6MkvXGka820V3KpIU6vFHPzfW+mHB1YSU6M4NHBkQCFR3FqVRchoN
	D+7xZ5B73K/E04xPraVMV5LHK0o4LfNcaWUojkDVLEr2Mu+D7fw/mvODSmeB/3PSOC6ibLJIfjf
	7vNK7gKPp94C0GTnJ3aNGve2fpLh+JBtw6U7uCloPNNKLge6pylN/t4uGU8QvolD9umi+7oC
X-Google-Smtp-Source: AGHT+IF7zG1fhLrMiY98tqlb6OjOZhbOMMGGOCnx5alEj3y7iLMnzFDqnL1HoeULrGBy4deeswRUxA==
X-Received: by 2002:a05:600c:4f12:b0:43b:8198:f713 with SMTP id 5b1f17b1804b1-43ba66d9e7emr137744935e9.4.1741017707141;
        Mon, 03 Mar 2025 08:01:47 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbb15841dsm59677905e9.1.2025.03.03.08.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:01:46 -0800 (PST)
Date: Mon, 3 Mar 2025 17:01:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, security@kernel.org, stable@kernel.org, idosch@idosch.org, 
	syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] vlan: enforce underlying device type
Message-ID: <5a37x4qwepq7scmbv3u7tndci22siahtdslg6x23nlcpapfiis@driggpbpidnl>
References: <20250303155619.8918-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303155619.8918-1-oscmaes92@gmail.com>

Mon, Mar 03, 2025 at 04:56:19PM +0100, oscmaes92@gmail.com wrote:
>Currently, VLAN devices can be created on top of non-ethernet devices.
>
>Besides the fact that it doesn't make much sense, this also causes a
>bug which leaks the address of a kernel function to usermode.
>
>When creating a VLAN device, we initialize GARP (garp_init_applicant)
>and MRP (mrp_init_applicant) for the underlying device.
>
>As part of the initialization process, we add the multicast address of
>each applicant to the underlying device, by calling dev_mc_add.
>
>__dev_mc_add uses dev->addr_len to determine the length of the new
>multicast address.
>
>This causes an out-of-bounds read if dev->addr_len is greater than 6,
>since the multicast addresses provided by GARP and MRP are only 6
>bytes long.
>
>This behaviour can be reproduced using the following commands:
>
>ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
>ip l set up dev gretest
>ip link add link gretest name vlantest type vlan id 100
>
>Then, the following command will display the address of garp_pdu_rcv:
>
>ip maddr show | grep 01:80:c2:00:00:21
>
>Fix the bug by enforcing the type of the underlying device during VLAN
>device initialization.
>
>Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
>Reported-by: syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
>Signed-off-by: Oscar Maes <oscmaes92@gmail.com>


Reviewed-by: Jiri Pirko <jiri@nvidia.com>

