Return-Path: <netdev+bounces-155040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B37A00C14
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFEC1642D0
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A480154C0D;
	Fri,  3 Jan 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="j0o0KkWO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E18BE4F
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921955; cv=none; b=fYHV9yckwaiVlMD6meVAlJsSelHlQBb9y1f0MiqG2YGALcJMYw605EEfaU75KI/ZoBDTMgKmkkoxYTHqf3YJjxrev9ERuMoEB9Hz9JiWYDQMKNQWAosfQ75euEJUa0Tq9YKGwOnA9LrQ+wGW+7+iIAlT0rIu4ziPFqy+/UVTsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921955; c=relaxed/simple;
	bh=YhYnlIWQ+d8dKputLILvnT8wjaUXkoyixNilA45JY/0=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePJ/vOeUrvNkHyBE57t5N9IYrBfLdMLiC0YZuzMntFPu4mSlbmb+SukQpodcRYwd7AITmzYbVKyZuMQ8vBFo7qGEHf/MCZRfNjE+1TGoCj9B5atx7lA/A+R9RCxvCqXRv2h31zhEjOXq+GUMj/AR4TdIeBJ/CbRCOrh0V3ZuuMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=j0o0KkWO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21654fdd5daso162233785ad.1
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1735921953; x=1736526753; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KS2UvGDKhyZb/bZf50JOkJeT1+YqfcQ5yJptp1Xn7nM=;
        b=j0o0KkWOr4/P1wAl8jjNxA74lgsgEs4xGcl/zLYLM/Qe0Aw4oo2xFOL3bVX9gvOxM2
         D/0m8qpDZ/8tXi/HVGMi0knSd7Uk5FYdBNz5Ux8rkpdxLylMXby/j3CzHAtr8+cnURt/
         5zORKoopnN1Wh7NG5rbpe26/7xec0ig2nKljfTKdOH67kBgPTdpt9xInNWW/pIbzN/WO
         ue0b2/1wxdzUSX0BA9EOBvZ25bkgO9ew/TKTGdLPCHRVz5xgPBauvtnLXfza0Yfoc68i
         T4sBzxPSN5224tuSuyqR743aB78HQThOTxwkvBPnzm4ZZvRlh9/9C+bA9LVe70VnZFh6
         wQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735921953; x=1736526753;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KS2UvGDKhyZb/bZf50JOkJeT1+YqfcQ5yJptp1Xn7nM=;
        b=wAHWm3PP4Rt6gVNKaBU1jJdUdFNZfE6bryOaxaYJlal8KoOqYOaHV6JLjGwObfKC1X
         KbFsCPuXLBrkRdMF7Hqzau27V+UxU+oxBSxfnJArjLWRqDshR3WllumL6Bsz/FD1niHz
         tIYLXqimouh3sB8wdpd/fFp3YIMTsXTdbxH6+kPyhjKxBGRcDcA8yoGjkQauK2HK6Wak
         wgrQy3QIsOrxLhs1qQJnbngbrEHtIQoL2VMZXU1rENc7CrlotjG1Ky+VdUSMN3vfO+le
         irGggoieZ+A/S6B2FudU+04aAbW0QDRgVxRRQcIAszgJ13R6xGgXvWqQucY9PyFXCSRF
         2x7g==
X-Gm-Message-State: AOJu0YzFQbEm1O2NpcLELe5Pu/+JoVzGbmnrmH3hPr2BI20DOjRygu9h
	vOegUBwVBabKnNSL/NZ8HYvhbun8mnlJWBgL49tXUvrYi5pzjfdnvX86KhtfTtU=
X-Gm-Gg: ASbGncs9MGsiSD5ML559rlPoG/U4EKXfNrcsqoafJxG4KeXcYvPkTIyRgieMaTDREpC
	aViKZKM1wfyUm2FBL96xNdpu/M6EBgoBALn7rtguULg7FdB+PMFmX9s+TCisMN+eXhQLk1EjQlc
	Z/mODPqp8xLdiontlKxlTNvfIF5JIStirKv+0OxYtjh3P3d5vhhS+zrVVdGqZv3d7NN7mga9uu3
	rWtCiRy8JASRydjBy634XSwFj8dd8a8evdzgAmUyVSiKn2Af7jd+XSbditUhwK7F2tG/A==
X-Google-Smtp-Source: AGHT+IHZf/nyqM2afR1OhAeRJYw+4e1/W6ZosEJBZye1aFq23fiVDN/QxGCfLguHsYpC9p+E8UJDJA==
X-Received: by 2002:a17:902:f64d:b0:215:94e0:17 with SMTP id d9443c01a7336-219e6ebb6admr772395825ad.23.1735921952583;
        Fri, 03 Jan 2025 08:32:32 -0800 (PST)
Received: from muhammads-ThinkPad ([2001:e68:5473:b14:1bbf:e66b:5e1e:6485])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca006fasm246924715ad.227.2025.01.03.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:32:32 -0800 (PST)
Date: Sat, 04 Jan 2025 00:32:23 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: [PATCH] Add NMEA GPS character device for PCIe MHI Quectel Module
 to read NMEA statements.
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: netdev@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn <andrew@lunn.ch>,
	Slark Xiao <slark_xiao@163.com>
Message-Id: <ZXTIPS.5HTA0G5SXE7D3@unrealasia.net>
In-Reply-To: <YT6HPS.1GNVHHJXEVF83@unrealasia.net>
References: <R8AFPS.THYVK2DKSEE83@unrealasia.net>
	<5LHFPS.G3DNPFBCDKCL2@unrealasia.net>
	<aea78599-0d3f-42d9-8f3e-0e90c37a31b8@gmail.com>
	<VK3HPS.SZBNRWNH78611@unrealasia.net> <YT6HPS.1GNVHHJXEVF83@unrealasia.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Sergey,

Apparently after a new recompilation the entire kernel and modules 
fixes the problem with wwan0nmea0 port get attached at bootup. I had 
previously only compiled modules without the kernel during development.

Before that i went to debug several wwan_core.c device wwan_create_port 
and wwan_create_dev functions to see what's going on not being loaded 
at bootup and seemed that a recompile the entire kernel and module 
fixes that. Checked my diffs and saw no changes.

So now, everything works perfectly at bootup and I have to tell 
ModemManager to ignore NMEA port type. So booting up with a fresh new 
kernel and module gets my 5G working automatically at boot.

No need to unload and reload of the kernel modules and configuring with 
AT commands to wwan0at0 with scripts, now everything works seamlessly.

So to ensure ModemManager can work with this setup, i would add a new 
udev rule for ModemManager to not probe wwan0nmea0 port (which i think 
i will submit this to ModemManger project):

# ModemManager ignore NMEA
ATTRS{vendor}=="0x1eac", ATTRS{device}=="0x1007", ATTR{type}=="NMEA", 
ENV{ID_MM_PORT_IGNORE}="1"

I'll submit the "cleaned up" v3 nmea patch later tomorrow, it's a 
pretty small patch. (It's 12AM now here in Malaysia)

- Zaihan

On Fri, Jan 3 2025 at 03:15:34 AM +0800, Muhammad Nuzaihan 
<zaihan@unrealasia.net> wrote:
> Hi Sergey,
> 
> 
> On Fri, Jan 3 2025 at 02:05:19 AM +0800, Muhammad Nuzaihan 
> <zaihan@unrealasia.net> wrote:
>> Hi Sergey,
>> 



